"""The bounds registry: the Python equivalent of the original definitions .wl.

The readable authoritative formulas are in data/bounds.json. They are parsed
once, independently of the checker and the user notebooks.
"""
from __future__ import annotations

import hashlib
import json
from functools import lru_cache
from importlib.resources import files
from pathlib import Path
from types import MappingProxyType

import sympy as sp

from .expressions import FormulaError, parse_formula

UNITARITY_MODES = ('NaiveSingle', 'NaiveCombined', 'FinalCombined')
MODES = (*UNITARITY_MODES, 'Positivity')

# Display labels are separate from the stable identifiers used in API calls.
MODE_LABELS = MappingProxyType({
    'NaiveSingle': 'Single-operator unitarity',
    'NaiveCombined': 'Combined-operator unitarity',
    'FinalCombined': 'Positivity-constrained unitarity',
    'Positivity': 'Positivity',
})


class Bounds:
    def __init__(self, path: str | Path | None = None):
        payload = (Path(path).read_bytes() if path is not None
                   else files('aqgc').joinpath('data/bounds.json').read_bytes())
        self.sha256 = hashlib.sha256(payload).hexdigest()
        self.raw = json.loads(payload)
        if self.raw.get('schema_version') != 1:
            raise ValueError('Unsupported bounds data schema.')
        self.coefficients = tuple(self.raw['coefficients'])
        if len(set(self.coefficients)) != len(self.coefficients):
            raise ValueError('Duplicate coefficient in basis.')
        self.symbols = MappingProxyType({n: sp.Symbol(n, real=True) for n in self.coefficients})
        names = {'pi': sp.pi, **self.symbols}
        constants = {}
        for key, value in self.raw['constants'].items():
            constants[key] = parse_formula(value, names)
            if (constants[key].free_symbols or constants[key].is_finite is not True
                    or constants[key].is_real is not True):
                raise FormulaError(f'Invalid constant: {key}')
            names[key] = constants[key]
        self.constants = MappingProxyType(constants)
        auxiliary = {}
        for key, text in self.raw['auxiliary'].items():
            auxiliary[key] = parse_formula(text, names)
            names[key] = auxiliary[key]
        self.auxiliary = MappingProxyType(auxiliary)
        unitarity = {}
        for mode in UNITARITY_MODES:
            entries = self.raw['unitarity'].get(mode, {})
            if set(entries) - set(self.coefficients):
                raise FormulaError(f'Unknown unitarity coefficient in {mode}.')
            compiled = {n: parse_formula(text, names) for n, text in entries.items()}
            for n, expr in compiled.items():
                if (expr.free_symbols or expr.is_real is not True
                        or expr.is_finite is not True or not bool(expr > 0)):
                    raise FormulaError(f'{mode}/{n}: bound must be a positive real constant.')
            unitarity[mode] = MappingProxyType(compiled)
        self.unitarity = MappingProxyType(unitarity)
        positivity = {}
        for sector, entries in self.raw['positivity'].items():
            positivity[sector] = MappingProxyType({
                key: parse_formula(text, names) for key, text in entries.items()
            })
        self.positivity = MappingProxyType(positivity)
        self.coverage_notes = tuple(self.raw.get('coverage_notes', ()))

    def audit(self) -> dict:
        """Data completeness and automatic hierarchy checks, not a physics proof."""
        final, naive = self.unitarity['FinalCombined'], self.unitarity['NaiveCombined']
        hierarchy = []
        for n in self.coefficients:
            if n in final and n in naive and bool(sp.N(sp.simplify(final[n] - naive[n]), 50) > 0):
                hierarchy.append({'coefficient': n,
                                  'final_constant': sp.N(final[n], 16),
                                  'naive_combined_constant': sp.N(naive[n], 16)})
        used = set().union(*(e.free_symbols for b in self.positivity.values() for e in b.values()))
        return {
            'dataset_version': self.raw['dataset_version'],
            'sha256': self.sha256,
            'coefficient_count': len(self.coefficients),
            'unitarity_counts': {m: len(b) for m, b in self.unitarity.items()},
            'missing_unitarity': {m: [n for n in self.coefficients if n not in b]
                                 for m, b in self.unitarity.items()},
            'positivity_counts': {s: len(b) for s, b in self.positivity.items()},
            'positivity_unreferenced': [n for n, x in self.symbols.items() if x not in used],
            'final_exceeds_naive_combined': hierarchy
        }


@lru_cache(maxsize=1)
def get_bounds() -> Bounds:
    return Bounds()
