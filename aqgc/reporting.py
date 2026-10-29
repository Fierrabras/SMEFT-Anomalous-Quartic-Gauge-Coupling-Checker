"""Display and export, separate from all evaluations."""
from __future__ import annotations
import json
from pathlib import Path
import sympy as sp

from .bounds import MODE_LABELS


def _fmt(value):
    if value is None:
        return '--'
    if isinstance(value, sp.Expr):
        return str(sp.N(value, 7))
    return str(value)


def format_report(result: dict, *, show_all: bool = False) -> str:
    lines = [f"aQGC: {result['overall_status']} for the selected implemented checks",
             'Dimensionless f_i; unspecified coefficients = 0.']
    if result['lambda_tev'] is not None:
        lines.append(f"Lambda = {_fmt(result['lambda_tev'])} TeV; Ecm = {_fmt(result['ecm_tev'])} TeV")
    for mode, summary in result['summary'].items():
        counts = ', '.join(f'{s}: {n}' for s, n in summary['counts'].items() if n)
        lines.append(f'\n{MODE_LABELS.get(mode, mode)}: {summary["status"]} ({counts})')
        if summary.get('includes_positivity'):
            lines.append('  Counts refer to coefficient bounds; overall mode status also includes explicit positivity.')
            lines.append(f"  Coefficient bounds: {summary['coefficient_bounds_status']}; positivity: {summary['positivity_status']}")
        if mode in result['unitarity']:
            visible = {n: r for n, r in result['unitarity'][mode].items()
                       if show_all or r['value'] != 0 or r['status'] != 'Pass'}
            for name, r in visible.items():
                lines.append(f"  {name:8s} f={_fmt(r['value']):>12s}  max|f|={_fmt(r['limit']):>12s}  {r['status']}")
                if 'reason' in r:
                    lines.append('    ' + r['reason'])
        elif mode == 'Positivity':
            for sector, records in result['positivity'].items():
                for key, r in records.items():
                    if show_all or r['status'] != 'Pass':
                        lines.append(f"  {sector}/{key}: {r['status']}; residual={_fmt(r['residual'])}")
                        if 'reason' in r:
                            lines.append('    ' + r['reason'])
    if result['warnings']:
        lines.append('\nNotes:')
        for warning in result['warnings']:
            for identifier, label in MODE_LABELS.items():
                warning = warning.replace(identifier, label)
            lines.append('  ' + warning)
    return '\n'.join(lines)


def print_report(result: dict, *, show_all: bool = False) -> None:
    print(format_report(result, show_all=show_all))


def export_json(result: dict, path: str | Path) -> None:
    """Write all records; symbolic/high-precision numbers are lossless strings."""
    def convert(x):
        if isinstance(x, sp.Expr):
            return str(x)
        raise TypeError(f'Unsupported JSON value: {type(x).__name__}')
    Path(path).write_text(json.dumps(result, default=convert, indent=2) + '\n', encoding='utf-8')
