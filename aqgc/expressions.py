"""Restricted arithmetic parsing with exact numbers; never evaluates Python code."""
from __future__ import annotations

import ast
from collections.abc import Mapping
from decimal import Decimal
from fractions import Fraction
from numbers import Integral, Real

import sympy as sp


class FormulaError(ValueError):
    """An expression uses an unknown name or unsupported syntax."""


def parse_formula(text: str, names: Mapping[str, sp.Expr]) -> sp.Expr:
    """Accept numbers, known names, + - * / **, sqrt(x), abs(x), and parentheses.

    Numeric tokens, including finite decimal literals, become exact rationals.
    There is no eval, attribute access, arbitrary call, or implicit new symbol.
    """
    if not isinstance(text, str) or len(text) > 30000:
        raise FormulaError('A formula must be a short arithmetic string.')
    try:
        tree = ast.parse(text.strip(), mode='eval')
    except SyntaxError as exc:
        raise FormulaError(f'Invalid formula: {text!r}') from exc

    def visit(node):
        if isinstance(node, ast.Expression):
            return visit(node.body)
        if isinstance(node, ast.Constant) and type(node.value) in (int, float):
            token = ast.get_source_segment(text.strip(), node)
            try:
                return sp.Rational(token)
            except (ValueError, TypeError) as exc:
                raise FormulaError(f'Invalid numeric literal: {token}') from exc
        if isinstance(node, ast.Name):
            if node.id not in names:
                raise FormulaError(f'Unknown name in formula: {node.id}')
            return names[node.id]
        if isinstance(node, ast.UnaryOp):
            x = visit(node.operand)
            if isinstance(node.op, ast.USub):
                return -x
            if isinstance(node.op, ast.UAdd):
                return x
        if isinstance(node, ast.BinOp):
            x, y = visit(node.left), visit(node.right)
            if isinstance(node.op, ast.Add):
                return x + y
            if isinstance(node.op, ast.Sub):
                return x - y
            if isinstance(node.op, ast.Mult):
                return x * y
            if isinstance(node.op, ast.Div):
                if y == 0:
                    raise FormulaError('Division by zero in formula.')
                return x / y
            if isinstance(node.op, ast.Pow):
                if y.is_Rational is not True or abs(y) > 100:
                    raise FormulaError('Only small fixed rational powers are supported.')
                return x**y
        if (isinstance(node, ast.Call) and isinstance(node.func, ast.Name)
                and len(node.args) == 1 and not node.keywords):
            x = visit(node.args[0])
            if node.func.id == 'sqrt':
                return sp.sqrt(x)
            if node.func.id == 'abs':
                return sp.Abs(x)
        raise FormulaError(f'Unsupported formula syntax: {ast.dump(node)}')

    value = visit(tree)
    if not isinstance(value, sp.Expr):
        raise FormulaError('Formula did not produce a scalar expression.')
    return value


def real_number(value, label: str = 'value') -> sp.Expr:
    """Normalize a finite real scalar, rejecting booleans and symbolic inputs.

    Strings may be decimal/rational arithmetic such as '0.1', '1/3', or 'pi'.
    Python floats are interpreted via their displayed decimal representation.
    SymPy Float values retain their actual stored value through Rational(value).
    """
    if isinstance(value, bool):
        raise ValueError(f'{label} must be a finite real number, not a boolean.')
    if isinstance(value, str):
        x = parse_formula(value, {'pi': sp.pi})
    elif isinstance(value, sp.Float):
        x = sp.Rational(value)
    elif isinstance(value, sp.Expr):
        x = value
    elif isinstance(value, Integral):
        x = sp.Integer(int(value))
    elif isinstance(value, Fraction):
        x = sp.Rational(value.numerator, value.denominator)
    elif isinstance(value, (Real, Decimal)):
        try:
            x = sp.Rational(str(value))
        except (ValueError, TypeError) as exc:
            raise ValueError(f'{label} must be finite and real.') from exc
    else:
        raise ValueError(f'{label} must be a finite real scalar; received {value!r}.')
    if x.free_symbols or x.is_real is not True or x.is_finite is not True:
        raise ValueError(f'{label} must be finite, real and fully numerical; received {value!r}.')
    return x
