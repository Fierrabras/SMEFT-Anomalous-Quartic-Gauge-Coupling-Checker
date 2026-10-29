"""Evaluate the published coefficient limits and positivity residuals."""
from __future__ import annotations

from collections.abc import Mapping, Sequence

import sympy as sp

from .bounds import Bounds, MODES, UNITARITY_MODES, get_bounds
from .expressions import real_number

STATUSES = ('Pass', 'Fail', 'Boundary', 'Indeterminate')


def complete_coefficients(coefficients: Mapping, *, bounds: Bounds | None = None) -> dict:
    """Fill unspecified coefficients with zero; validate names and real values."""
    b = bounds or get_bounds()
    if not isinstance(coefficients, Mapping):
        raise ValueError('Coefficients must be a mapping, e.g. {"FM1": 0.5}.')
    unknown = [key for key in coefficients if key not in b.symbols]
    if unknown:
        raise ValueError(f'Unknown coefficient names: {unknown!r}. Names are case-sensitive strings.')
    return {name: real_number(coefficients.get(name, 0), name) for name in b.coefficients}


def _modes(modes) -> list[str]:
    if isinstance(modes, str):
        requested = list(MODES) if modes == 'All' else [modes]
    elif isinstance(modes, Sequence):
        requested = list(modes)
    else:
        raise ValueError(f'Modes must be a mode name, a nonempty list, or "All": {MODES}.')
    if not requested or any(not isinstance(m, str) or m not in MODES for m in requested):
        raise ValueError(f'Unknown or empty mode selection. Allowed: {MODES}, or "All".')
    return list(dict.fromkeys(requested))


def aggregate_status(statuses) -> str:
    statuses = list(statuses)
    if not statuses:
        return 'Indeterminate'
    if 'Fail' in statuses:
        return 'Fail'
    if any(s not in STATUSES for s in statuses) or 'Indeterminate' in statuses:
        return 'Indeterminate'
    if 'Boundary' in statuses:
        return 'Boundary'
    return 'Pass'


def _summary(records) -> dict:
    records = list(records)
    statuses = [record['status'] for record in records]
    return {'status': aggregate_status(statuses), 'total': len(records),
            'counts': {s: statuses.count(s) for s in STATUSES},
            'complete': 'Indeterminate' not in statuses}


def _evaluate(residual, scale, *, digits: int, atol, rtol) -> dict:
    """Use precision-aware arithmetic; the near-boundary band is not a pass.

    Exact equality satisfies a non-strict inequality. Nonzero residuals within
    the requested tolerance are explicitly marked Boundary. A zero absolute
    tolerance preserves homogeneous rescaling of positivity conditions.
    """
    try:
        if residual.free_symbols or scale.free_symbols:
            raise ValueError('Unresolved symbolic expression.')
        r, s = sp.N(residual, digits), sp.N(scale, digits)
        if (r.is_real is not True or r.is_finite is not True
                or s.is_real is not True or s.is_finite is not True or bool(s < 0)):
            raise ValueError('Residual or scale is not a finite real number.')
        tolerance = sp.N(atol + rtol * s, digits)
        exact_zero = residual == 0 or residual.is_zero is True
        if exact_zero:
            status = 'Pass'
        elif bool(sp.Abs(r) <= tolerance):
            status = 'Boundary'
        elif bool(r > 0):
            status = 'Pass'
        elif bool(r < 0):
            status = 'Fail'
        else:
            status = 'Indeterminate'
        return {'residual': r, 'status': status, 'tolerance': tolerance,
                'at_exact_boundary': bool(exact_zero)}
    except (ValueError, TypeError, ArithmeticError) as exc:
        return {'residual': None, 'status': 'Indeterminate', 'reason': str(exc)}


def _unitarity(values, b, mode, factor, settings) -> dict:
    result = {}
    for name in b.coefficients:
        value = values[name]
        constant = b.unitarity[mode].get(name)
        if constant is None:
            result[name] = {'value': value, 'limit': None, 'ratio': None,
                            'residual': None, 'status': 'Indeterminate',
                            'available': False, 'reason': 'No published bound supplied for this mode.'}
            continue
        limit = constant * factor
        record = _evaluate(limit - sp.Abs(value), limit + sp.Abs(value), **settings)
        result[name] = {'value': value, 'constant': sp.N(constant, settings['digits']),
                        'limit': sp.N(limit, settings['digits']),
                        'ratio': sp.N(sp.Abs(value) / limit, settings['digits']),
                        'available': True, **record}
    return result


def _positivity(values, b, settings) -> dict:
    replacements = {b.symbols[n]: v for n, v in values.items()}
    result = {}
    for sector, expressions in b.positivity.items():
        result[sector] = {}
        for key, expression in expressions.items():
            residual = expression.xreplace(replacements)
            # The sum of absolute top-level terms is homogeneous, unlike max(1,...).
            scale = sum((sp.Abs(term.xreplace(replacements))
                         for term in sp.Add.make_args(expression)), sp.S.Zero)
            result[sector][key] = _evaluate(residual, scale, **settings)
    return result


def check(coefficients: Mapping, modes='All', *, lambda_tev=None, ecm_tev=None,
          digits: int = 50, absolute_tolerance=0, relative_tolerance='1e-12',
          bounds: Bounds | None = None) -> dict:
    """Check any selection of published bounds; unspecified f_i are zero.

    Parameters
    ----------
    coefficients : mapping[str, real scalar]
        Dimensionless Wilson coefficients, e.g. {"FM1": 0.5, "FT6odd": -0.2}.
    modes : str or sequence[str]
        NaiveSingle, NaiveCombined, Positivity, FinalCombined, or "All".
        FinalCombined automatically includes explicit Positivity.
    lambda_tev, ecm_tev : positive real scalars
        Required only if a unitarity mode is requested; both are in TeV.
    digits : int
        Numerical working precision (default 50 decimal digits).
    absolute_tolerance, relative_tolerance : nonnegative scalars
        Nonzero residuals in the tolerance band get Boundary, not Pass.
        Exact zero passes the non-strict inequalities. Default atol=0 avoids
        a spurious dependence of positivity on the overall coefficient scale.
    bounds : Bounds, optional
        Alternative registry, e.g. Bounds("my_bounds.json").

    Returns every internal check, even for zero coefficients. The presentation
    function hides uninteresting passing zeros, not data errors. The results
    test the implemented conditions; marginalized upper limits are not a
    complete set of coupled-channel eigenvalue constraints.
    """
    b = bounds or get_bounds()
    values = complete_coefficients(coefficients, bounds=b)
    requested = _modes(modes)
    evaluated = requested.copy()
    if 'FinalCombined' in evaluated and 'Positivity' not in evaluated:
        evaluated.append('Positivity')
    if isinstance(digits, bool) or not isinstance(digits, int) or not 20 <= digits <= 1000:
        raise ValueError('digits must be an integer between 20 and 1000.')
    atol = real_number(absolute_tolerance, 'absolute_tolerance')
    rtol = real_number(relative_tolerance, 'relative_tolerance')
    if bool(atol < 0) or bool(rtol < 0):
        raise ValueError('Numerical tolerances must be nonnegative.')
    settings = {'digits': digits, 'atol': atol, 'rtol': rtol}
    need_energy = any(m in UNITARITY_MODES for m in evaluated)
    lam = energy = None
    if need_energy:
        lam = real_number(lambda_tev, 'lambda_tev')
        energy = real_number(ecm_tev, 'ecm_tev')
        if not bool(lam > 0) or not bool(energy > 0):
            raise ValueError('lambda_tev and ecm_tev must both be positive.')
    unitarity, summary, warnings = {}, {}, []
    for mode in evaluated:
        if mode in UNITARITY_MODES:
            unitarity[mode] = _unitarity(values, b, mode, (lam / energy)**4, settings)
            summary[mode] = _summary(unitarity[mode].values())
    positivity = _positivity(values, b, settings) if 'Positivity' in evaluated else None
    if positivity is not None:
        summary['Positivity'] = _summary(r for sector in positivity.values() for r in sector.values())
    if 'FinalCombined' in evaluated:
        row = summary['FinalCombined']
        row['coefficient_bounds_status'] = row['status']
        row['positivity_status'] = summary['Positivity']['status']
        row['status'] = aggregate_status([row['coefficient_bounds_status'], row['positivity_status']])
        row['complete'] = row['complete'] and summary['Positivity']['complete']
        row['includes_positivity'] = True
    active = [n for n, v in values.items() if v != 0]
    if 'NaiveSingle' in evaluated and len(active) > 1:
        warnings.append('Single-operator unitarity is an isolated-coefficient reference comparison for this multi-coefficient input.')
    if any(m in evaluated for m in ('NaiveCombined', 'FinalCombined')):
        warnings.append('Combined limits are marginalized coefficient bounds, not a complete joint eigenvalue test.')
    if need_energy and bool(energy > lam):
        warnings.append('Ecm exceeds the supplied cutoff Lambda; passing these inequalities does not establish EFT validity.')
    for item in b.coverage_notes:
        if any(m in evaluated for m in item['modes']):
            warnings.append(item['message'])
    return {'coefficient_values': values, 'requested_modes': requested,
            'evaluated_modes': evaluated, 'lambda_tev': lam, 'ecm_tev': energy,
            'precision_digits': digits, 'absolute_tolerance': atol, 'relative_tolerance': rtol,
            'unitarity': unitarity, 'positivity': positivity, 'summary': summary,
            'overall_status': aggregate_status(s['status'] for s in summary.values()),
            'warnings': warnings, 'dataset_version': b.raw['dataset_version'],
            'dataset_sha256': b.sha256}
