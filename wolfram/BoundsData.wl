(* Mathematical registry equivalent to aqgc/data/bounds.json. *)
(* Decimal constants are fixed exact rationals. *)
Module[{FS0, FS1, FS2, FM0, FM1, FM2, FM3, FM4, FM5, FM7, FM8, FM9, FT0, FT1, FT2, FT3, FT4, FT5, FT6, FT7, FT8, FT9, FM1odd, FM2odd, FM3odd, FM4odd, FM5odd, FM6odd, FT1odd, FT2odd, FT3odd, FT4odd, FT5odd, FT6odd, beta24, alpha4, alpha5, alpha6, alpha23tilde, alpha4tilde, A5, A6, A7, b3Expr, b4Expr, unitarityNaiveSingleFS0, unitarityNaiveSingleFS1, unitarityNaiveSingleFS2, unitarityNaiveSingleFM0, unitarityNaiveSingleFM1, unitarityNaiveSingleFM2, unitarityNaiveSingleFM3, unitarityNaiveSingleFM4, unitarityNaiveSingleFM5, unitarityNaiveSingleFM7, unitarityNaiveSingleFM8, unitarityNaiveSingleFM9, unitarityNaiveSingleFT0, unitarityNaiveSingleFT1, unitarityNaiveSingleFT2, unitarityNaiveSingleFT3, unitarityNaiveSingleFT4, unitarityNaiveSingleFT5, unitarityNaiveSingleFT6, unitarityNaiveSingleFT7, unitarityNaiveSingleFT8, unitarityNaiveSingleFT9, unitarityNaiveSingleFM1odd, unitarityNaiveSingleFM2odd, unitarityNaiveSingleFM3odd, unitarityNaiveSingleFM4odd, unitarityNaiveSingleFM5odd, unitarityNaiveSingleFM6odd, unitarityNaiveSingleFT1odd, unitarityNaiveSingleFT2odd, unitarityNaiveSingleFT3odd, unitarityNaiveSingleFT4odd, unitarityNaiveSingleFT5odd, unitarityNaiveSingleFT6odd, unitarityNaiveCombinedFS0, unitarityNaiveCombinedFS1, unitarityNaiveCombinedFS2, unitarityNaiveCombinedFM0, unitarityNaiveCombinedFM1, unitarityNaiveCombinedFM2, unitarityNaiveCombinedFM3, unitarityNaiveCombinedFM4, unitarityNaiveCombinedFM5, unitarityNaiveCombinedFM7, unitarityNaiveCombinedFM8, unitarityNaiveCombinedFM9, unitarityNaiveCombinedFT0, unitarityNaiveCombinedFT1, unitarityNaiveCombinedFT2, unitarityNaiveCombinedFT3, unitarityNaiveCombinedFT4, unitarityNaiveCombinedFT5, unitarityNaiveCombinedFT6, unitarityNaiveCombinedFT7, unitarityNaiveCombinedFT8, unitarityNaiveCombinedFT9, unitarityNaiveCombinedFM1odd, unitarityNaiveCombinedFM2odd, unitarityNaiveCombinedFM3odd, unitarityNaiveCombinedFM4odd, unitarityNaiveCombinedFM5odd, unitarityNaiveCombinedFM6odd, unitarityNaiveCombinedFT1odd, unitarityNaiveCombinedFT2odd, unitarityNaiveCombinedFT3odd, unitarityNaiveCombinedFT4odd, unitarityNaiveCombinedFT5odd, unitarityNaiveCombinedFT6odd, unitarityFinalCombinedFS0, unitarityFinalCombinedFS1, unitarityFinalCombinedFS2, unitarityFinalCombinedFM0, unitarityFinalCombinedFM1, unitarityFinalCombinedFM2, unitarityFinalCombinedFM3, unitarityFinalCombinedFM4, unitarityFinalCombinedFM5, unitarityFinalCombinedFM7, unitarityFinalCombinedFM8, unitarityFinalCombinedFM9, unitarityFinalCombinedFT0, unitarityFinalCombinedFT1, unitarityFinalCombinedFT2, unitarityFinalCombinedFT3, unitarityFinalCombinedFT4, unitarityFinalCombinedFT5, unitarityFinalCombinedFT6, unitarityFinalCombinedFT7, unitarityFinalCombinedFT8, unitarityFinalCombinedFT9, unitarityFinalCombinedFM1odd, unitarityFinalCombinedFM2odd, unitarityFinalCombinedFM3odd, unitarityFinalCombinedFM4odd, unitarityFinalCombinedFM5odd, unitarityFinalCombinedFM6odd, unitarityFinalCombinedFT1odd, unitarityFinalCombinedFT2odd, unitarityFinalCombinedFT3odd, unitarityFinalCombinedFT4odd, unitarityFinalCombinedFT5odd, unitarityFinalCombinedFT6odd, positivityB4, positivityW4, positivityB2W2, positivityPhi2B2, positivityPhi2W2, positivityPhi2BW, positivityPhi4},
  beta24 = (66793/1000); (* 66.793 *)
  alpha4 = (25433/1000); (* 25.433 *)
  alpha5 = (121837/1000); (* 121.837 *)
  alpha6 = (13937/1000); (* 13.937 *)
  alpha23tilde = (3179/1000); (* 3.179 *)
  alpha4tilde = (1963873/1000); (* 1963.873 *)
  A5 = ((((((((2*FT0)+FT1)+FT2)+FT3)-(2*((4*FT8)+(3*FT9))))^2)+((((4*FT5)+(2*FT6))+FT7)^2))+(16*(((2*(FT2odd+FT3odd))+FT4odd)^2)));
  A6 = ((((((4*(FT0+FT1))+(3*(FT2+FT3)))-(4*((4*FT8)+(3*FT9))))^2)+(4*((((FT4+(2*FT6))+FT7)+Abs[((FT4+(4*FT5))+FT7)])^2)))+(256*((FT2odd-FT3odd)^2)));
  A7 = (((((((4*(FT0+(2*FT1)))+(5*(FT2+FT3)))+(2*((FT4+(2*FT6))+FT7)))-(4*((4*FT8)+(3*FT9))))^2)+((((FT4+(2*FT6))+FT7)+(2*Abs[((FT4+(4*FT5))+FT7)]))^2))+(((Sqrt[3]*((FT4+(2*FT6))+FT7))+(16*Abs[(FT2odd-FT3odd)]))^2));
  b3Expr = (((FM9^2)+((9/2)*(((FM4odd^2)+(FM5^2))+Abs[((FM4odd^2)-(FM5^2))])))+((Sqrt[6]*Abs[FM9])*Sqrt[(((FM4odd^2)+(FM5^2))+Abs[((FM4odd^2)-(FM5^2))])]));
  b4Expr = (((18*((FM4odd^2)+(FM5^2)))+((31-(4*Sqrt[3]))*(FM9^2)))+((2*(3+(2*Sqrt[3])))*Sqrt[(((2*(FM9^2))*((FM5^2)+(FM4odd^2)))+Abs[(((FM9^2)*((FM5^2)-(FM4odd^2)))-((((2*Sqrt[3])*FM5)*(FM9*Abs[FM9]))*FM4odd))])]));
  unitarityNaiveSingleFS0 = (32*Pi);
  unitarityNaiveSingleFS1 = ((96/7)*Pi);
  unitarityNaiveSingleFS2 = ((96/5)*Pi);
  unitarityNaiveSingleFM0 = ((Pi*32)/Sqrt[6]);
  unitarityNaiveSingleFM1 = ((Pi*128)/Sqrt[6]);
  unitarityNaiveSingleFM2 = ((Pi*16)/Sqrt[2]);
  unitarityNaiveSingleFM3 = ((Pi*64)/Sqrt[2]);
  unitarityNaiveSingleFM4 = (Pi*32);
  unitarityNaiveSingleFM5 = (Pi*64);
  unitarityNaiveSingleFM7 = ((Pi*256)/Sqrt[6]);
  unitarityNaiveSingleFM8 = (((Pi*512)*Sqrt[3])/5);
  unitarityNaiveSingleFM9 = (Pi*48);
  unitarityNaiveSingleFT0 = ((Pi*12)/5);
  unitarityNaiveSingleFT1 = ((Pi*24)/5);
  unitarityNaiveSingleFT2 = ((Pi*96)/13);
  unitarityNaiveSingleFT3 = ((Pi*32)/3);
  unitarityNaiveSingleFT4 = (Pi*16);
  unitarityNaiveSingleFT5 = ((Pi*8)/Sqrt[3]);
  unitarityNaiveSingleFT6 = ((Pi*48)/7);
  unitarityNaiveSingleFT7 = ((Pi*32)/Sqrt[3]);
  unitarityNaiveSingleFT8 = ((Pi*3)/2);
  unitarityNaiveSingleFT9 = ((Pi*24)/7);
  unitarityNaiveSingleFM1odd = ((Pi*8)*Sqrt[2]);
  unitarityNaiveSingleFM2odd = (Pi*32);
  unitarityNaiveSingleFM3odd = (((Pi*512)*Sqrt[3])/5);
  unitarityNaiveSingleFM4odd = (Pi*64);
  unitarityNaiveSingleFM5odd = (((Pi*8)*Sqrt[6])/3);
  unitarityNaiveSingleFM6odd = ((Pi*384)/5);
  unitarityNaiveSingleFT1odd = ((Pi*12)/5);
  unitarityNaiveSingleFT2odd = (((Pi*4)*Sqrt[3])/3);
  unitarityNaiveSingleFT3odd = (((Pi*4)*Sqrt[3])/3);
  unitarityNaiveSingleFT4odd = (Pi*6);
  unitarityNaiveSingleFT5odd = ((Pi*12)/11);
  unitarityNaiveSingleFT6odd = ((Pi*12)/7);
  unitarityNaiveCombinedFS0 = ((224/5)*Pi);
  unitarityNaiveCombinedFS1 = ((288/5)*Pi);
  unitarityNaiveCombinedFS2 = ((288/5)*Pi);
  unitarityNaiveCombinedFM0 = ((Pi*(2/3))*(72+(5*Sqrt[6])));
  unitarityNaiveCombinedFM1 = ((Pi*8)*(24+(Sqrt[6]/5)));
  unitarityNaiveCombinedFM2 = (Pi*(24+(5*Sqrt[2])));
  unitarityNaiveCombinedFM3 = (Pi*96);
  unitarityNaiveCombinedFM4 = ((Pi*4)*(5+(8*Sqrt[3])));
  unitarityNaiveCombinedFM5 = ((Pi*64)*Sqrt[3]);
  unitarityNaiveCombinedFM7 = ((Pi*(64/5))*(24+Sqrt[6]));
  unitarityNaiveCombinedFM8 = (((Pi*512)*Sqrt[3])/5);
  unitarityNaiveCombinedFM9 = (Pi*48);
  unitarityNaiveCombinedFT0 = ((Pi*40)/3);
  unitarityNaiveCombinedFT1 = ((Pi*176)/15);
  unitarityNaiveCombinedFT2 = ((Pi*208)/5);
  unitarityNaiveCombinedFT3 = ((Pi*176)/5);
  unitarityNaiveCombinedFT4 = (((Pi*8)*(6+(8*Sqrt[3])))/5);
  unitarityNaiveCombinedFT5 = (((Pi*8)*(3+Sqrt[3]))/3);
  unitarityNaiveCombinedFT6 = (((Pi*16)*(9+(5*Sqrt[3])))/15);
  unitarityNaiveCombinedFT7 = (((Pi*32)*(5+Sqrt[3]))/5);
  unitarityNaiveCombinedFT8 = ((Pi*18)/5);
  unitarityNaiveCombinedFT9 = (Pi*8);
  unitarityNaiveCombinedFM1odd = ((Pi*8)*Sqrt[2]);
  unitarityNaiveCombinedFM2odd = ((Pi*4)*(5+(8*Sqrt[3])));
  unitarityNaiveCombinedFM3odd = (((Pi*512)*Sqrt[3])/5);
  unitarityNaiveCombinedFM4odd = ((Pi*64)*Sqrt[3]);
  unitarityNaiveCombinedFM5odd = (((Pi*8)*Sqrt[6])/3);
  unitarityNaiveCombinedFM6odd = (((Pi*16)*(24+Sqrt[6]))/5);
  unitarityNaiveCombinedFT1odd = ((Pi*12)/5);
  unitarityNaiveCombinedFT2odd = (((Pi*2)*(3+(4*Sqrt[3])))/5);
  unitarityNaiveCombinedFT3odd = (((Pi*2)*(3+(4*Sqrt[3])))/5);
  unitarityNaiveCombinedFT4odd = (((Pi*4)*(9+(2*Sqrt[3])))/5);
  unitarityNaiveCombinedFT5odd = ((Pi*22)/5);
  unitarityNaiveCombinedFT6odd = ((Pi*26)/5);
  unitarityFinalCombinedFS0 = ((224/5)*Pi);
  unitarityFinalCombinedFS1 = ((288/5)*Pi);
  unitarityFinalCombinedFS2 = (48*Pi);
  unitarityFinalCombinedFM0 = ((Pi*(2/3))*(72+(5*Sqrt[6])));
  unitarityFinalCombinedFM1 = ((Pi*(8/5))*(120+Sqrt[6]));
  unitarityFinalCombinedFM2 = (Pi*(24+(5*Sqrt[2])));
  unitarityFinalCombinedFM3 = (Pi*96);
  unitarityFinalCombinedFM4 = (Pi*beta24);
  unitarityFinalCombinedFM5 = ((Pi*96)*(Sqrt[3]-1));
  unitarityFinalCombinedFM7 = ((Pi*(64/9))*(24+Sqrt[6]));
  unitarityFinalCombinedFM8 = ((Pi*(1536/11))*((5*Sqrt[3])-8));
  unitarityFinalCombinedFM9 = ((Pi*576)/((14+Sqrt[3])+Sqrt[(31-(4*Sqrt[3]))]));
  unitarityFinalCombinedFT0 = (Pi*12);
  unitarityFinalCombinedFT1 = (Pi*8);
  unitarityFinalCombinedFT2 = (Pi*(704/19));
  unitarityFinalCombinedFT3 = (Pi*(352/19));
  unitarityFinalCombinedFT4 = (Pi*alpha4);
  unitarityFinalCombinedFT5 = ((Pi*(4/15))*(27+Sqrt[(3*alpha5)]));
  unitarityFinalCombinedFT6 = (Pi*alpha6);
  unitarityFinalCombinedFT7 = ((Pi*(32/5))*(5+Sqrt[3]));
  unitarityFinalCombinedFT8 = (Pi*3);
  unitarityFinalCombinedFT9 = (Pi*8);
  unitarityFinalCombinedFM1odd = ((Pi*8)*Sqrt[2]);
  unitarityFinalCombinedFM2odd = (Pi*beta24);
  unitarityFinalCombinedFM3odd = (((Pi*1536)*((5*Sqrt[3])-8))/11);
  unitarityFinalCombinedFM4odd = ((Pi*96)*(Sqrt[3]-1));
  unitarityFinalCombinedFM5odd = (((Pi*8)*Sqrt[6])/3);
  unitarityFinalCombinedFM6odd = (((Pi*16)*(24+Sqrt[6]))/9);
  unitarityFinalCombinedFT1odd = ((Pi*3)/2);
  unitarityFinalCombinedFT2odd = (Pi*alpha23tilde);
  unitarityFinalCombinedFT3odd = (Pi*alpha23tilde);
  unitarityFinalCombinedFT4odd = ((Pi*(144+alpha4tilde))/403);
  unitarityFinalCombinedFT5odd = ((Pi*40)/19);
  unitarityFinalCombinedFT6odd = ((Pi*44)/19);
  positivityB4 = <|
    "P1" -> (((4*FT8)+(3*FT9))-Sqrt[((((4*FT8)+FT9)^2)+((4*FT1odd)^2))])
  |>;
  positivityW4 = <|
    "P1" -> ((((2*FT1)+FT2)+FT3)-Sqrt[((((2*FT1)+FT3)^2)+((8*FT6odd)^2))]),
    "P2" -> (((((2*FT0)+FT1)+FT2)+FT3)-Sqrt[(((((2*FT0)+FT1)+(FT2/2))^2)+(((8*FT5odd)+(4*FT6odd))^2))])
  |>;
  positivityB2W2 = <|
    "P38" -> (((FT4+(2*FT6))+FT7)-Sqrt[(((FT4+(2*FT6))^2)+((4*FT4odd)^2))]),
    "P39" -> (((((((((2*FT0)+FT1)+FT2)+FT3)+FT4)+(2*FT6))+FT7)+(2*((4*FT8)+(3*FT9))))-Sqrt[A5]),
    "P40" -> (((((4*(FT0+FT1))+(3*(FT2+FT3)))+(2*((FT4+(2*FT6))+FT7)))+(4*((4*FT8)+(3*FT9))))-Sqrt[A6]),
    "P41" -> (((((4*(FT0+(2*FT1)))+(5*(FT2+FT3)))+(4*((FT4+(2*FT6))+FT7)))+(4*((4*FT8)+(3*FT9))))-Sqrt[A7])
  |>;
  positivityPhi2B2 = <|
    "P1" -> (FM3-Sqrt[((((4*FM2)-FM3)^2)+((4*FM1odd)^2))])
  |>;
  positivityPhi2W2 = <|
    "P53" -> (((2*FM1)-FM7)-(((2/3)*((2+Sqrt[3])+Sqrt[(31-(4*Sqrt[3]))]))*Abs[FM9])),
    "P54" -> (((2*FM1)-FM7)-Sqrt[(((FM7^2)+((4*FM9)^2))+((4*FM6odd)^2))]),
    "P55" -> (((2*FM1)-FM7)-Sqrt[((((((8*FM0)-(2*FM1))+FM7)^2)+((4*FM9)^2))+((16*FM5odd)^2))]),
    "P56" -> ((((2*FM1)-FM7)-(4*Abs[FM9]))-Sqrt[((((4*FM0)-FM1)^2)+(4*(((4*FM5odd)+FM6odd)^2)))])
  |>;
  positivityPhi2BW = <|
    "P62" -> (((2*FM3)*((2*FM1)-FM7))-(((((((2*(FM8^2))+(2*(FM3odd^2)))+(((2*FM4)+FM5)^2))+(FM5^2))+(((2*FM2odd)+FM4odd)^2))+(FM4odd^2))+Abs[((((((2*FM4)+FM5)^2)-(FM5^2))+(((2*FM2odd)+FM4odd)^2))-(FM4odd^2))])),
    "P63" -> (((2*FM3)*(((2*FM1)-FM7)-(4*Abs[FM9])))-(((((((2*FM4)+FM5)^2)+(FM8^2))+(((2*FM2odd)+FM4odd)^2))+(FM3odd^2))+(2*Abs[((FM8*((2*FM4)+FM5))-(FM3odd*((2*FM2odd)+FM4odd)))]))),
    "P64" -> ((((1/2)*(((2*FM1)+(4*FM3))-FM7))-Abs[FM9])-Sqrt[((FM9^2)+(2*(((FM5^2)+(FM4odd^2))+Abs[((FM5^2)-(FM4odd^2))])))]),
    "P65" -> ((((3/4)*(((2*FM1)+(4*FM3))-FM7))-Abs[FM9])-Sqrt[b3Expr]),
    "P66" -> ((((3/2)*(((2*FM1)+(4*FM3))-FM7))-((2+Sqrt[3])*Abs[FM9]))-Sqrt[b4Expr]),
    "P67" -> (((FM3*(((2*FM1)-FM7)-Abs[FM9]))-(FM5^2))-(FM4odd^2))
  |>;
  positivityPhi4 = <|
    "P1" -> FS0,
    "P2" -> (FS0+FS2),
    "P3" -> ((FS0+FS1)+FS2)
  |>;
  <|
  "DataVersion" -> "1.0.0",
  "DataSHA256" -> "9a302aa57990f4a982439a02b516a94fb28316d2072923734891912bba4c36fa",
  "Coefficients" -> {"FS0", "FS1", "FS2", "FM0", "FM1", "FM2", "FM3", "FM4", "FM5", "FM7", "FM8", "FM9", "FT0", "FT1", "FT2", "FT3", "FT4", "FT5", "FT6", "FT7", "FT8", "FT9", "FM1odd", "FM2odd", "FM3odd", "FM4odd", "FM5odd", "FM6odd", "FT1odd", "FT2odd", "FT3odd", "FT4odd", "FT5odd", "FT6odd"},
  "Symbols" -> {FS0, FS1, FS2, FM0, FM1, FM2, FM3, FM4, FM5, FM7, FM8, FM9, FT0, FT1, FT2, FT3, FT4, FT5, FT6, FT7, FT8, FT9, FM1odd, FM2odd, FM3odd, FM4odd, FM5odd, FM6odd, FT1odd, FT2odd, FT3odd, FT4odd, FT5odd, FT6odd},
  "Constants" -> <|"beta24" -> beta24, "alpha4" -> alpha4, "alpha5" -> alpha5, "alpha6" -> alpha6, "alpha23tilde" -> alpha23tilde, "alpha4tilde" -> alpha4tilde|>,
  "ModeLabels" -> <|"NaiveSingle" -> "Single-operator unitarity", "NaiveCombined" -> "Combined-operator unitarity", "FinalCombined" -> "Positivity-constrained unitarity", "Positivity" -> "Positivity"|>,
  "Unitarity" -> <|"NaiveSingle" -> <|"FS0" -> unitarityNaiveSingleFS0, "FS1" -> unitarityNaiveSingleFS1, "FS2" -> unitarityNaiveSingleFS2, "FM0" -> unitarityNaiveSingleFM0, "FM1" -> unitarityNaiveSingleFM1, "FM2" -> unitarityNaiveSingleFM2, "FM3" -> unitarityNaiveSingleFM3, "FM4" -> unitarityNaiveSingleFM4, "FM5" -> unitarityNaiveSingleFM5, "FM7" -> unitarityNaiveSingleFM7, "FM8" -> unitarityNaiveSingleFM8, "FM9" -> unitarityNaiveSingleFM9, "FT0" -> unitarityNaiveSingleFT0, "FT1" -> unitarityNaiveSingleFT1, "FT2" -> unitarityNaiveSingleFT2, "FT3" -> unitarityNaiveSingleFT3, "FT4" -> unitarityNaiveSingleFT4, "FT5" -> unitarityNaiveSingleFT5, "FT6" -> unitarityNaiveSingleFT6, "FT7" -> unitarityNaiveSingleFT7, "FT8" -> unitarityNaiveSingleFT8, "FT9" -> unitarityNaiveSingleFT9, "FM1odd" -> unitarityNaiveSingleFM1odd, "FM2odd" -> unitarityNaiveSingleFM2odd, "FM3odd" -> unitarityNaiveSingleFM3odd, "FM4odd" -> unitarityNaiveSingleFM4odd, "FM5odd" -> unitarityNaiveSingleFM5odd, "FM6odd" -> unitarityNaiveSingleFM6odd, "FT1odd" -> unitarityNaiveSingleFT1odd, "FT2odd" -> unitarityNaiveSingleFT2odd, "FT3odd" -> unitarityNaiveSingleFT3odd, "FT4odd" -> unitarityNaiveSingleFT4odd, "FT5odd" -> unitarityNaiveSingleFT5odd, "FT6odd" -> unitarityNaiveSingleFT6odd|>,
"NaiveCombined" -> <|"FS0" -> unitarityNaiveCombinedFS0, "FS1" -> unitarityNaiveCombinedFS1, "FS2" -> unitarityNaiveCombinedFS2, "FM0" -> unitarityNaiveCombinedFM0, "FM1" -> unitarityNaiveCombinedFM1, "FM2" -> unitarityNaiveCombinedFM2, "FM3" -> unitarityNaiveCombinedFM3, "FM4" -> unitarityNaiveCombinedFM4, "FM5" -> unitarityNaiveCombinedFM5, "FM7" -> unitarityNaiveCombinedFM7, "FM8" -> unitarityNaiveCombinedFM8, "FM9" -> unitarityNaiveCombinedFM9, "FT0" -> unitarityNaiveCombinedFT0, "FT1" -> unitarityNaiveCombinedFT1, "FT2" -> unitarityNaiveCombinedFT2, "FT3" -> unitarityNaiveCombinedFT3, "FT4" -> unitarityNaiveCombinedFT4, "FT5" -> unitarityNaiveCombinedFT5, "FT6" -> unitarityNaiveCombinedFT6, "FT7" -> unitarityNaiveCombinedFT7, "FT8" -> unitarityNaiveCombinedFT8, "FT9" -> unitarityNaiveCombinedFT9, "FM1odd" -> unitarityNaiveCombinedFM1odd, "FM2odd" -> unitarityNaiveCombinedFM2odd, "FM3odd" -> unitarityNaiveCombinedFM3odd, "FM4odd" -> unitarityNaiveCombinedFM4odd, "FM5odd" -> unitarityNaiveCombinedFM5odd, "FM6odd" -> unitarityNaiveCombinedFM6odd, "FT1odd" -> unitarityNaiveCombinedFT1odd, "FT2odd" -> unitarityNaiveCombinedFT2odd, "FT3odd" -> unitarityNaiveCombinedFT3odd, "FT4odd" -> unitarityNaiveCombinedFT4odd, "FT5odd" -> unitarityNaiveCombinedFT5odd, "FT6odd" -> unitarityNaiveCombinedFT6odd|>,
"FinalCombined" -> <|"FS0" -> unitarityFinalCombinedFS0, "FS1" -> unitarityFinalCombinedFS1, "FS2" -> unitarityFinalCombinedFS2, "FM0" -> unitarityFinalCombinedFM0, "FM1" -> unitarityFinalCombinedFM1, "FM2" -> unitarityFinalCombinedFM2, "FM3" -> unitarityFinalCombinedFM3, "FM4" -> unitarityFinalCombinedFM4, "FM5" -> unitarityFinalCombinedFM5, "FM7" -> unitarityFinalCombinedFM7, "FM8" -> unitarityFinalCombinedFM8, "FM9" -> unitarityFinalCombinedFM9, "FT0" -> unitarityFinalCombinedFT0, "FT1" -> unitarityFinalCombinedFT1, "FT2" -> unitarityFinalCombinedFT2, "FT3" -> unitarityFinalCombinedFT3, "FT4" -> unitarityFinalCombinedFT4, "FT5" -> unitarityFinalCombinedFT5, "FT6" -> unitarityFinalCombinedFT6, "FT7" -> unitarityFinalCombinedFT7, "FT8" -> unitarityFinalCombinedFT8, "FT9" -> unitarityFinalCombinedFT9, "FM1odd" -> unitarityFinalCombinedFM1odd, "FM2odd" -> unitarityFinalCombinedFM2odd, "FM3odd" -> unitarityFinalCombinedFM3odd, "FM4odd" -> unitarityFinalCombinedFM4odd, "FM5odd" -> unitarityFinalCombinedFM5odd, "FM6odd" -> unitarityFinalCombinedFM6odd, "FT1odd" -> unitarityFinalCombinedFT1odd, "FT2odd" -> unitarityFinalCombinedFT2odd, "FT3odd" -> unitarityFinalCombinedFT3odd, "FT4odd" -> unitarityFinalCombinedFT4odd, "FT5odd" -> unitarityFinalCombinedFT5odd, "FT6odd" -> unitarityFinalCombinedFT6odd|>|>,
  "Positivity" -> <|"B4" -> positivityB4,
"W4" -> positivityW4,
"B2W2" -> positivityB2W2,
"Phi2B2" -> positivityPhi2B2,
"Phi2W2" -> positivityPhi2W2,
"Phi2BW" -> positivityPhi2BW,
"Phi4" -> positivityPhi4|>,
  "CoverageNotes" -> {}
  |>
]
