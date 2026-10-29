# aQGC coefficient-bound checker - 1.0.0

Evaluate the supplied unitarity and positivity bounds for 34 dimensionless Wilson coefficients, using Python or Mathematica. Each interface runs independently.

After replacing package files, restart the Python or Mathematica kernel before running the checks.

## Python

Requires Python 3.10 or later. In a terminal, change to the extracted `aQGC_package_v1.0.0` directory and run:

```bash
python -m pip install ".[notebook]"
python -m jupyterlab Use_aQGC.ipynb
```

Run the notebook from the top, editing the coefficients and energies in the input cell. For Python without Jupyter, install with `python -m pip install .` and use:

```python
from aqgc import check, print_report

coefficients = {
    "FS0": 0.5,
    "FM1": 1.0,
    "FT9": 0.5,
    "FT1odd": 0.1,
}

result = check(
    coefficients,
    modes=["NaiveSingle", "NaiveCombined", "Positivity"],
    lambda_tev=2.5,
    ecm_tev=2.0,
)
print_report(result)
```

## Mathematica

Open `Use_aQGC.nb` and evaluate from the top in a fresh kernel. Keep the `wolfram` directory beside the notebook. No Python installation is required.

The package can also be loaded directly from a saved notebook in this directory:

```mathematica
Get[FileNameJoin[{NotebookDirectory[], "wolfram", "AQGC.wl"}]];
coefficients = <|
    "FS0" -> 1/2,
    "FM1" -> 1,
    "FT9" -> 1/2,
    "FT1odd" -> 1/10
|>;

result = AQGC`CheckAQGC[
    coefficients,
    {"NaiveSingle", "NaiveCombined", "Positivity"},
    "LambdaTeV" -> 5/2, "EcmTeV" -> 2
];
AQGC`ShowAQGCReport[result]
```

## Inputs and modes

Enter dimensionless Wilson coefficients with case-sensitive string keys. Both Lambda and Ecm are in TeV. The exact accepted names are:

| Sector | Accepted names |
|---|---|
| S | `FS0`, `FS1`, `FS2` |
| CP-even M | `FM0`, `FM1`, `FM2`, `FM3`, `FM4`, `FM5`, `FM7`, `FM8`, `FM9` |
| CP-even T | `FT0`, `FT1`, `FT2`, `FT3`, `FT4`, `FT5`, `FT6`, `FT7`, `FT8`, `FT9` |
| CP-odd M | `FM1odd`, `FM2odd`, `FM3odd`, `FM4odd`, `FM5odd`, `FM6odd` |
| CP-odd T | `FT1odd`, `FT2odd`, `FT3odd`, `FT4odd`, `FT5odd`, `FT6odd` |

**You do not need to enter all 34 coefficients. Every coefficient you omit is set to zero.** The examples above set FS0, FM1, FT9, and FT1odd; the remaining 30 coefficients are zero. Separate entries with commas, using `"name": value` inside `{...}` in Python or `"name" -> value` inside `<|...|>` in Mathematica. There is no `FM6`; unknown names are rejected.

| Mode | Meaning | Available limits |
|---|---|---|
| `NaiveSingle` | Single-operator unitarity | 34 coefficients |
| `NaiveCombined` | Combined-operator unitarity | 34 coefficients |
| `FinalCombined` | Positivity-constrained unitarity, including explicit positivity | 34 coefficients |
| `Positivity` | Positivity only | 21 inequalities in seven sectors |

Select a mode string, a list of modes, or `"All"` (Mathematica also accepts `All`). For unitarity, supply positive cutoff and centre-of-mass energies in **TeV**. Limits are evaluated as:

```text
abs(f_i) <= C_i * (Lambda / Ecm)^4
```

Positivity residuals must be nonnegative and need no energy inputs. For example, `check({"FS0": 0.5, "FS1": -0.25}, "Positivity")` in Python or ``AQGC`CheckAQGC[<|"FS0" -> 1/2, "FS1" -> -1/4|>, "Positivity"]`` in Mathematica.

The S-operator constraints are included in the `Phi4` sector:

| Condition | Required inequality |
|---|---|
| `Phi4/P1` | `FS0 >= 0` |
| `Phi4/P2` | `FS0 + FS2 >= 0` |
| `Phi4/P3` | `FS0 + FS1 + FS2 >= 0` |

These are checked whenever positivity is evaluated, including `FinalCombined` and `All`. Inspect their results with `result["positivity"]["Phi4"]` in Python or `result["Positivity"]["Phi4"]` in Mathematica. Exact equality passes, with the same numerical-tolerance rules as the other sectors.

## Reading the results

- **Pass:** the condition is satisfied, including exact equality.
- **Fail:** the condition is violated outside the tolerance band.
- **Boundary:** a nonzero residual is within numerical tolerance.
- **Indeterminate:** a bound is missing or the condition cannot be evaluated.

The report shows nonzero inputs and non-passing conditions. All records remain in the returned dictionary or Association. Show every record with `print_report(result, show_all=True)` or ``AQGC`ShowAQGCReport[result, "ShowAll" -> True]``. Python can export all records with `from aqgc import export_json; export_json(result, "results.json")`.

Default precision is 50 digits, with absolute tolerance 0 and relative tolerance `10^-12`. These are adjustable through `digits`, `absolute_tolerance`, and `relative_tolerance` in Python, or `"WorkingPrecision"`, `"AbsoluteTolerance"`, and `"RelativeTolerance"` in Mathematica. Higher working precision does not increase the physical precision of the supplied constants.

Named formulas are available through `aqgc.definitions` and the Mathematica ``AQGC` `` context: for example, `unitarityNaiveSingleFM1`, `unitarityFinalCombinedFT4odd`, `positivityB4`, and `positivityPhi4`. Unitarity names return `C_i` before the energy factor; positivity names contain symbolic residuals indexed by condition ID.

## S-sector unitarity and references

The authors independently calculated the unitarity bounds. For the S sector, the J=0 expressions and limits reproduce Eq. (19) and Table 1 of E. da Silva Almeida, O. J. P. Eboli, and M. C. Gonzalez-Garcia, *Unitarity Constraints on Anomalous Quartic Couplings*, **Physical Review D 101**, 113003 (2020), [arXiv:2004.05174](https://arxiv.org/abs/2004.05174), [doi:10.1103/PhysRevD.101.113003](https://doi.org/10.1103/PhysRevD.101.113003).

This release uses the authors' stronger combined S-sector bounds obtained by imposing **both J=0 and J=1**. `FinalCombined` also imposes the three S-sector positivity inequalities. With `x_i = FS_i / [pi * (Lambda / Ecm)^4]`, the unitarity inequalities used to obtain these marginal limits are:

```text
J=0:
abs(3*x0 + x1 + x2) <= 96
abs(x0 + x1 + 3*x2) <= 96
abs(3*x0 + 7*x1 + 5*x2) <= 96

J=1:
abs(x0 - x1) <= 192
abs(3*x0 - x1 - 2*x2) <= 192
abs(-x1 + x2) <= 192
```

The stored constants in `abs(FS_i) <= C_i * (Lambda / Ecm)^4` are:

| Mode | FS0: C_i | FS1: C_i | FS2: C_i |
|---|---|---|---|
| `NaiveSingle` | `32*pi` | `(96/7)*pi` | `(96/5)*pi` |
| `NaiveCombined` | `(224/5)*pi` | `(288/5)*pi` | `(288/5)*pi` |
| `FinalCombined` | `(224/5)*pi` | `(288/5)*pi` | `48*pi` |

These are maxima of absolute values. Adding J=1 tightens the combined FS0 constant from `48*pi` to `(224/5)*pi`; the single-operator limits remain unchanged.

The authors also independently calculated the three S-sector positivity constraints, agreeing with the combinations in Eq. (86) of G. N. Remmen and N. L. Rodd, *Consistency of the Standard Model Effective Field Theory*, **JHEP 12** (2019) 032, [arXiv:1908.09845](https://arxiv.org/abs/1908.09845), [doi:10.1007/JHEP12(2019)032](https://doi.org/10.1007/JHEP12%282019%29032). That reference writes strict positivity; this package includes the boundary using the requested non-strict `>= 0` convention.

## Scope

All three unitarity modes contain limits for all 34 coefficients. Positivity contains 21 inequalities across B4, W4, B2W2, Phi2B2, Phi2W2, Phi2BW, and Phi4.

Combined unitarity limits are marginalized individual-coefficient maxima. Passing every individual limit does not establish satisfaction of the complete joint partial-wave eigenvalue constraints. The checker tests the supplied conditions, not full UV consistency or EFT validity.

The required Python code and data are in `aqgc/`; the required Mathematica code and data are in `wolfram/`. Keep these directories intact.

## AI disclosure

ChatGPT (OpenAI), through a GPT-6-based Codex assistant, was used to assist with the construction, organization, and syntax of this code.

## Referencing this work

Please reference this repository and the preprints/published articles listed below if you use this code:

@misc{aQGCchecker,
  author = "{\'E}boli, Oscar J. P. and Lozano-Onrubia, {\'A}. and Rosende Herrero, S.",
  title        = {{SMEFT Anomalous Quartic Gauge Coupling Checker}},
  howpublished = {\url{https://github.com/Fierrabras/SMEFT-Anomalous-Quartic-Gauge-Coupling-Checker}},
  year         = {2026},
  note         = {Version 1.0.0}
}

@article{...}

@article{Almeida:2020ylr,
    author = "Almeida, Eduardo da Silva and {\'E}boli, O. J. P. and Gonzalez{\textendash}Garcia, M. C.",
    title = "{Unitarity constraints on anomalous quartic couplings}",
    eprint = "2004.05174",
    archivePrefix = "arXiv",
    primaryClass = "hep-ph",
    reportNumber = "YITP-SB-2020-8",
    doi = "10.1103/PhysRevD.101.113003",
    journal = "Phys. Rev. D",
    volume = "101",
    number = "11",
    pages = "113003",
    year = "2020"
}
