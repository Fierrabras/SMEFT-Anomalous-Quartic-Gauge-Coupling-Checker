"""Named unitarity limits and positivity sectors from the canonical registry.

These names reference the bounds used by the checker.
Unitarity entries store C_i in abs(f_i) <= C_i*(Lambda/Ecm)**4.
Positivity entries map condition identifiers to residuals required >= 0.
"""
from .bounds import get_bounds as _get_bounds

_bounds = _get_bounds()

# NaiveSingle
unitarityNaiveSingleFS0 = _bounds.unitarity['NaiveSingle']['FS0']
unitarityNaiveSingleFS1 = _bounds.unitarity['NaiveSingle']['FS1']
unitarityNaiveSingleFS2 = _bounds.unitarity['NaiveSingle']['FS2']
unitarityNaiveSingleFM0 = _bounds.unitarity['NaiveSingle']['FM0']
unitarityNaiveSingleFM1 = _bounds.unitarity['NaiveSingle']['FM1']
unitarityNaiveSingleFM2 = _bounds.unitarity['NaiveSingle']['FM2']
unitarityNaiveSingleFM3 = _bounds.unitarity['NaiveSingle']['FM3']
unitarityNaiveSingleFM4 = _bounds.unitarity['NaiveSingle']['FM4']
unitarityNaiveSingleFM5 = _bounds.unitarity['NaiveSingle']['FM5']
unitarityNaiveSingleFM7 = _bounds.unitarity['NaiveSingle']['FM7']
unitarityNaiveSingleFM8 = _bounds.unitarity['NaiveSingle']['FM8']
unitarityNaiveSingleFM9 = _bounds.unitarity['NaiveSingle']['FM9']
unitarityNaiveSingleFT0 = _bounds.unitarity['NaiveSingle']['FT0']
unitarityNaiveSingleFT1 = _bounds.unitarity['NaiveSingle']['FT1']
unitarityNaiveSingleFT2 = _bounds.unitarity['NaiveSingle']['FT2']
unitarityNaiveSingleFT3 = _bounds.unitarity['NaiveSingle']['FT3']
unitarityNaiveSingleFT4 = _bounds.unitarity['NaiveSingle']['FT4']
unitarityNaiveSingleFT5 = _bounds.unitarity['NaiveSingle']['FT5']
unitarityNaiveSingleFT6 = _bounds.unitarity['NaiveSingle']['FT6']
unitarityNaiveSingleFT7 = _bounds.unitarity['NaiveSingle']['FT7']
unitarityNaiveSingleFT8 = _bounds.unitarity['NaiveSingle']['FT8']
unitarityNaiveSingleFT9 = _bounds.unitarity['NaiveSingle']['FT9']
unitarityNaiveSingleFM1odd = _bounds.unitarity['NaiveSingle']['FM1odd']
unitarityNaiveSingleFM2odd = _bounds.unitarity['NaiveSingle']['FM2odd']
unitarityNaiveSingleFM3odd = _bounds.unitarity['NaiveSingle']['FM3odd']
unitarityNaiveSingleFM4odd = _bounds.unitarity['NaiveSingle']['FM4odd']
unitarityNaiveSingleFM5odd = _bounds.unitarity['NaiveSingle']['FM5odd']
unitarityNaiveSingleFM6odd = _bounds.unitarity['NaiveSingle']['FM6odd']
unitarityNaiveSingleFT1odd = _bounds.unitarity['NaiveSingle']['FT1odd']
unitarityNaiveSingleFT2odd = _bounds.unitarity['NaiveSingle']['FT2odd']
unitarityNaiveSingleFT3odd = _bounds.unitarity['NaiveSingle']['FT3odd']
unitarityNaiveSingleFT4odd = _bounds.unitarity['NaiveSingle']['FT4odd']
unitarityNaiveSingleFT5odd = _bounds.unitarity['NaiveSingle']['FT5odd']
unitarityNaiveSingleFT6odd = _bounds.unitarity['NaiveSingle']['FT6odd']

# NaiveCombined
unitarityNaiveCombinedFS0 = _bounds.unitarity['NaiveCombined']['FS0']
unitarityNaiveCombinedFS1 = _bounds.unitarity['NaiveCombined']['FS1']
unitarityNaiveCombinedFS2 = _bounds.unitarity['NaiveCombined']['FS2']
unitarityNaiveCombinedFM0 = _bounds.unitarity['NaiveCombined']['FM0']
unitarityNaiveCombinedFM1 = _bounds.unitarity['NaiveCombined']['FM1']
unitarityNaiveCombinedFM2 = _bounds.unitarity['NaiveCombined']['FM2']
unitarityNaiveCombinedFM3 = _bounds.unitarity['NaiveCombined']['FM3']
unitarityNaiveCombinedFM4 = _bounds.unitarity['NaiveCombined']['FM4']
unitarityNaiveCombinedFM5 = _bounds.unitarity['NaiveCombined']['FM5']
unitarityNaiveCombinedFM7 = _bounds.unitarity['NaiveCombined']['FM7']
unitarityNaiveCombinedFM8 = _bounds.unitarity['NaiveCombined']['FM8']
unitarityNaiveCombinedFM9 = _bounds.unitarity['NaiveCombined']['FM9']
unitarityNaiveCombinedFT0 = _bounds.unitarity['NaiveCombined']['FT0']
unitarityNaiveCombinedFT1 = _bounds.unitarity['NaiveCombined']['FT1']
unitarityNaiveCombinedFT2 = _bounds.unitarity['NaiveCombined']['FT2']
unitarityNaiveCombinedFT3 = _bounds.unitarity['NaiveCombined']['FT3']
unitarityNaiveCombinedFT4 = _bounds.unitarity['NaiveCombined']['FT4']
unitarityNaiveCombinedFT5 = _bounds.unitarity['NaiveCombined']['FT5']
unitarityNaiveCombinedFT6 = _bounds.unitarity['NaiveCombined']['FT6']
unitarityNaiveCombinedFT7 = _bounds.unitarity['NaiveCombined']['FT7']
unitarityNaiveCombinedFT8 = _bounds.unitarity['NaiveCombined']['FT8']
unitarityNaiveCombinedFT9 = _bounds.unitarity['NaiveCombined']['FT9']
unitarityNaiveCombinedFM1odd = _bounds.unitarity['NaiveCombined']['FM1odd']
unitarityNaiveCombinedFM2odd = _bounds.unitarity['NaiveCombined']['FM2odd']
unitarityNaiveCombinedFM3odd = _bounds.unitarity['NaiveCombined']['FM3odd']
unitarityNaiveCombinedFM4odd = _bounds.unitarity['NaiveCombined']['FM4odd']
unitarityNaiveCombinedFM5odd = _bounds.unitarity['NaiveCombined']['FM5odd']
unitarityNaiveCombinedFM6odd = _bounds.unitarity['NaiveCombined']['FM6odd']
unitarityNaiveCombinedFT1odd = _bounds.unitarity['NaiveCombined']['FT1odd']
unitarityNaiveCombinedFT2odd = _bounds.unitarity['NaiveCombined']['FT2odd']
unitarityNaiveCombinedFT3odd = _bounds.unitarity['NaiveCombined']['FT3odd']
unitarityNaiveCombinedFT4odd = _bounds.unitarity['NaiveCombined']['FT4odd']
unitarityNaiveCombinedFT5odd = _bounds.unitarity['NaiveCombined']['FT5odd']
unitarityNaiveCombinedFT6odd = _bounds.unitarity['NaiveCombined']['FT6odd']

# FinalCombined
unitarityFinalCombinedFS0 = _bounds.unitarity['FinalCombined']['FS0']
unitarityFinalCombinedFS1 = _bounds.unitarity['FinalCombined']['FS1']
unitarityFinalCombinedFS2 = _bounds.unitarity['FinalCombined']['FS2']
unitarityFinalCombinedFM0 = _bounds.unitarity['FinalCombined']['FM0']
unitarityFinalCombinedFM1 = _bounds.unitarity['FinalCombined']['FM1']
unitarityFinalCombinedFM2 = _bounds.unitarity['FinalCombined']['FM2']
unitarityFinalCombinedFM3 = _bounds.unitarity['FinalCombined']['FM3']
unitarityFinalCombinedFM4 = _bounds.unitarity['FinalCombined']['FM4']
unitarityFinalCombinedFM5 = _bounds.unitarity['FinalCombined']['FM5']
unitarityFinalCombinedFM7 = _bounds.unitarity['FinalCombined']['FM7']
unitarityFinalCombinedFM8 = _bounds.unitarity['FinalCombined']['FM8']
unitarityFinalCombinedFM9 = _bounds.unitarity['FinalCombined']['FM9']
unitarityFinalCombinedFT0 = _bounds.unitarity['FinalCombined']['FT0']
unitarityFinalCombinedFT1 = _bounds.unitarity['FinalCombined']['FT1']
unitarityFinalCombinedFT2 = _bounds.unitarity['FinalCombined']['FT2']
unitarityFinalCombinedFT3 = _bounds.unitarity['FinalCombined']['FT3']
unitarityFinalCombinedFT4 = _bounds.unitarity['FinalCombined']['FT4']
unitarityFinalCombinedFT5 = _bounds.unitarity['FinalCombined']['FT5']
unitarityFinalCombinedFT6 = _bounds.unitarity['FinalCombined']['FT6']
unitarityFinalCombinedFT7 = _bounds.unitarity['FinalCombined']['FT7']
unitarityFinalCombinedFT8 = _bounds.unitarity['FinalCombined']['FT8']
unitarityFinalCombinedFT9 = _bounds.unitarity['FinalCombined']['FT9']
unitarityFinalCombinedFM1odd = _bounds.unitarity['FinalCombined']['FM1odd']
unitarityFinalCombinedFM2odd = _bounds.unitarity['FinalCombined']['FM2odd']
unitarityFinalCombinedFM3odd = _bounds.unitarity['FinalCombined']['FM3odd']
unitarityFinalCombinedFM4odd = _bounds.unitarity['FinalCombined']['FM4odd']
unitarityFinalCombinedFM5odd = _bounds.unitarity['FinalCombined']['FM5odd']
unitarityFinalCombinedFM6odd = _bounds.unitarity['FinalCombined']['FM6odd']
unitarityFinalCombinedFT1odd = _bounds.unitarity['FinalCombined']['FT1odd']
unitarityFinalCombinedFT2odd = _bounds.unitarity['FinalCombined']['FT2odd']
unitarityFinalCombinedFT3odd = _bounds.unitarity['FinalCombined']['FT3odd']
unitarityFinalCombinedFT4odd = _bounds.unitarity['FinalCombined']['FT4odd']
unitarityFinalCombinedFT5odd = _bounds.unitarity['FinalCombined']['FT5odd']
unitarityFinalCombinedFT6odd = _bounds.unitarity['FinalCombined']['FT6odd']

# Positivity sectors
positivityB4 = _bounds.positivity['B4']
positivityW4 = _bounds.positivity['W4']
positivityB2W2 = _bounds.positivity['B2W2']
positivityPhi2B2 = _bounds.positivity['Phi2B2']
positivityPhi2W2 = _bounds.positivity['Phi2W2']
positivityPhi2BW = _bounds.positivity['Phi2BW']
positivityPhi4 = _bounds.positivity['Phi4']

__all__ = [
    'unitarityNaiveSingleFS0',
    'unitarityNaiveSingleFS1',
    'unitarityNaiveSingleFS2',
    'unitarityNaiveSingleFM0',
    'unitarityNaiveSingleFM1',
    'unitarityNaiveSingleFM2',
    'unitarityNaiveSingleFM3',
    'unitarityNaiveSingleFM4',
    'unitarityNaiveSingleFM5',
    'unitarityNaiveSingleFM7',
    'unitarityNaiveSingleFM8',
    'unitarityNaiveSingleFM9',
    'unitarityNaiveSingleFT0',
    'unitarityNaiveSingleFT1',
    'unitarityNaiveSingleFT2',
    'unitarityNaiveSingleFT3',
    'unitarityNaiveSingleFT4',
    'unitarityNaiveSingleFT5',
    'unitarityNaiveSingleFT6',
    'unitarityNaiveSingleFT7',
    'unitarityNaiveSingleFT8',
    'unitarityNaiveSingleFT9',
    'unitarityNaiveSingleFM1odd',
    'unitarityNaiveSingleFM2odd',
    'unitarityNaiveSingleFM3odd',
    'unitarityNaiveSingleFM4odd',
    'unitarityNaiveSingleFM5odd',
    'unitarityNaiveSingleFM6odd',
    'unitarityNaiveSingleFT1odd',
    'unitarityNaiveSingleFT2odd',
    'unitarityNaiveSingleFT3odd',
    'unitarityNaiveSingleFT4odd',
    'unitarityNaiveSingleFT5odd',
    'unitarityNaiveSingleFT6odd',
    'unitarityNaiveCombinedFS0',
    'unitarityNaiveCombinedFS1',
    'unitarityNaiveCombinedFS2',
    'unitarityNaiveCombinedFM0',
    'unitarityNaiveCombinedFM1',
    'unitarityNaiveCombinedFM2',
    'unitarityNaiveCombinedFM3',
    'unitarityNaiveCombinedFM4',
    'unitarityNaiveCombinedFM5',
    'unitarityNaiveCombinedFM7',
    'unitarityNaiveCombinedFM8',
    'unitarityNaiveCombinedFM9',
    'unitarityNaiveCombinedFT0',
    'unitarityNaiveCombinedFT1',
    'unitarityNaiveCombinedFT2',
    'unitarityNaiveCombinedFT3',
    'unitarityNaiveCombinedFT4',
    'unitarityNaiveCombinedFT5',
    'unitarityNaiveCombinedFT6',
    'unitarityNaiveCombinedFT7',
    'unitarityNaiveCombinedFT8',
    'unitarityNaiveCombinedFT9',
    'unitarityNaiveCombinedFM1odd',
    'unitarityNaiveCombinedFM2odd',
    'unitarityNaiveCombinedFM3odd',
    'unitarityNaiveCombinedFM4odd',
    'unitarityNaiveCombinedFM5odd',
    'unitarityNaiveCombinedFM6odd',
    'unitarityNaiveCombinedFT1odd',
    'unitarityNaiveCombinedFT2odd',
    'unitarityNaiveCombinedFT3odd',
    'unitarityNaiveCombinedFT4odd',
    'unitarityNaiveCombinedFT5odd',
    'unitarityNaiveCombinedFT6odd',
    'unitarityFinalCombinedFS0',
    'unitarityFinalCombinedFS1',
    'unitarityFinalCombinedFS2',
    'unitarityFinalCombinedFM0',
    'unitarityFinalCombinedFM1',
    'unitarityFinalCombinedFM2',
    'unitarityFinalCombinedFM3',
    'unitarityFinalCombinedFM4',
    'unitarityFinalCombinedFM5',
    'unitarityFinalCombinedFM7',
    'unitarityFinalCombinedFM8',
    'unitarityFinalCombinedFM9',
    'unitarityFinalCombinedFT0',
    'unitarityFinalCombinedFT1',
    'unitarityFinalCombinedFT2',
    'unitarityFinalCombinedFT3',
    'unitarityFinalCombinedFT4',
    'unitarityFinalCombinedFT5',
    'unitarityFinalCombinedFT6',
    'unitarityFinalCombinedFT7',
    'unitarityFinalCombinedFT8',
    'unitarityFinalCombinedFT9',
    'unitarityFinalCombinedFM1odd',
    'unitarityFinalCombinedFM2odd',
    'unitarityFinalCombinedFM3odd',
    'unitarityFinalCombinedFM4odd',
    'unitarityFinalCombinedFM5odd',
    'unitarityFinalCombinedFM6odd',
    'unitarityFinalCombinedFT1odd',
    'unitarityFinalCombinedFT2odd',
    'unitarityFinalCombinedFT3odd',
    'unitarityFinalCombinedFT4odd',
    'unitarityFinalCombinedFT5odd',
    'unitarityFinalCombinedFT6odd',
    'positivityB4',
    'positivityW4',
    'positivityB2W2',
    'positivityPhi2B2',
    'positivityPhi2W2',
    'positivityPhi2BW',
    'positivityPhi4',
]
