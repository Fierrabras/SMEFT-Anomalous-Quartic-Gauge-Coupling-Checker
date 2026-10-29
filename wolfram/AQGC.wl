(* ::Package:: *)
(* Plain-text implementation. No function definitions are stored in notebook boxes. *)
BeginPackage["AQGC`"];

CheckAQGC::usage = "CheckAQGC[association, modes, options] checks the implemented published bounds. Keys can be coefficient names as strings or unassigned symbols. Unspecified coefficients are zero. Modes: NaiveSingle, NaiveCombined, FinalCombined, Positivity, or All. FinalCombined includes explicit positivity.";
ShowAQGCReport::usage = "ShowAQGCReport[result] displays summaries, nonzero coefficients and every non-passing condition. Option ShowAll -> True shows all results.";
AuditBounds::usage = "AuditBounds[] reports the available bounds, sector coverage, and consistency checks.";
CoefficientNames::usage = "CoefficientNames[] returns the 34 case-sensitive coefficient name strings.";
AvailableModes::usage = "AvailableModes[] returns the supported check names.";
GetBoundsData::usage = "GetBoundsData[] returns the loaded formula registry, with locally scoped coefficient symbols.";

(* Named formulas use the explicit unitarity/positivity prefixes. *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "NamedBounds.wl"}]];

CheckAQGC::input = "`1`";
CheckAQGC::load = "Could not load a valid BoundsData.wl from `1`.";
Options[CheckAQGC] = {"LambdaTeV" -> Automatic, "EcmTeV" -> Automatic,
  "WorkingPrecision" -> 50, "AbsoluteTolerance" -> 0, "RelativeTolerance" -> 10^-12};
Options[ShowAQGCReport] = {"ShowAll" -> False};

Begin["`Private`"];

$packageDirectory = DirectoryName[$InputFileName];
(* Read the data file without suppressing diagnostic messages. A benign message
   must not turn a successfully parsed Association into $Failed. *)
$boundsFile = FileNameJoin[{$packageDirectory, "BoundsData.wl"}];
$data = If[FileExistsQ[$boundsFile], Get[$boundsFile], $Failed];
If[!AssociationQ[$data] ||
   !AllTrue[{"Coefficients", "Symbols", "Unitarity", "Positivity", "Constants"},
     AssociationQ[$data] && KeyExistsQ[$data, #] &],
   $data = $Failed;
   Message[CheckAQGC::load, $boundsFile]
];
$unitarityModes = {"NaiveSingle", "NaiveCombined", "FinalCombined"};
$allModes = Join[$unitarityModes, {"Positivity"}];
$statusNames = {"Pass", "Fail", "Boundary", "Indeterminate"};
$modeLabels = $data["ModeLabels"];

CoefficientNames[] := $data["Coefficients"];
AvailableModes[] := $allModes;
GetBoundsData[] := $data;

failure[text_String] := (Message[CheckAQGC::input, text]; Failure["InvalidInput", <|"Message" -> text|>]);
finiteRealQ[x_] := Quiet[With[{n = N[x, 50]}, TrueQ[NumericQ[x] && NumberQ[n] && Im[n] == 0 &&
    FreeQ[x, Indeterminate | _DirectedInfinity]]]];
(* Preserve the actual value of machine-real inputs; exact rationals are recommended near a boundary. *)
exactify[x_] := x /. y_Real :> Rationalize[y, 0];

completeCoefficients[input_Association] := Module[{names, unknown, provided, vals},
  names = Map[Function[key, Which[StringQ[key], key, Head[key] === Symbol,
        SymbolName[key], True, $Failed]], Keys[input]];
  If[MemberQ[names, $Failed], Return[failure["Coefficient keys must be names as strings or unassigned symbols. Prefer string keys."]]];
  If[Length[DeleteDuplicates[names]] != Length[names], Return[failure["Duplicate coefficient names after key normalization."]]];
  unknown = Complement[names, CoefficientNames[]];
  If[unknown =!= {}, Return[failure["Unknown coefficient names: " <> ToString[unknown, InputForm]]]];
  vals = Values[input];
  If[!AllTrue[vals, finiteRealQ], Return[failure["Every coefficient value must be a finite real scalar."]]];
  provided = AssociationThread[names, exactify /@ vals];
  AssociationThread[CoefficientNames[], Lookup[provided, CoefficientNames[], 0]]
];

aggregateStatus[statuses_List] := Which[
  statuses === {}, "Indeterminate",
  MemberQ[statuses, "Fail"], "Fail",
  MemberQ[statuses, "Indeterminate"] || !AllTrue[statuses, MemberQ[$statusNames, #] &], "Indeterminate",
  MemberQ[statuses, "Boundary"], "Boundary",
  True, "Pass"
];
summarize[records_List] := Module[{statuses = Lookup[records, "Status"]},
  <|"Status" -> aggregateStatus[statuses], "Total" -> Length[records],
    "Counts" -> AssociationThread[$statusNames, (Count[statuses, #] & /@ $statusNames)],
    "Complete" -> !MemberQ[statuses, "Indeterminate"]|>
];

evaluateResidual[residual_, scale_, wp_, atol_, rtol_] := Module[{r, s, tolerance, status, exactZero},
  r = Quiet[Check[N[residual, wp], $Failed]];
  s = Quiet[Check[N[scale, wp], $Failed]];
  If[!finiteRealQ[r] || !finiteRealQ[s] || !TrueQ[s >= 0],
    Return[<|"Residual" -> Missing["NotRealNumeric"], "Status" -> "Indeterminate",
      "Reason" -> "Residual or numerical scale is not a finite real number."|>]];
  tolerance = N[atol + rtol*s, wp];
  exactZero = TrueQ[residual == 0];
  status = Which[exactZero, "Pass", TrueQ[Abs[r] <= tolerance], "Boundary",
    TrueQ[r > 0], "Pass", TrueQ[r < 0], "Fail", True, "Indeterminate"];
  <|"Residual" -> r, "Status" -> status, "Tolerance" -> tolerance, "AtExactBoundary" -> exactZero|>
];

unitarityCheck[values_Association, mode_String, factor_, wp_, atol_, rtol_] :=
 AssociationMap[Function[name, Module[{value, constant, limit, record},
   value = values[name];
   constant = Lookup[$data["Unitarity"][mode], name, Missing["Unavailable"]];
   If[MissingQ[constant],
     <|"Value" -> value, "Limit" -> Missing["Unavailable"], "Ratio" -> Missing["Unavailable"],
       "Residual" -> Missing["Unavailable"], "Status" -> "Indeterminate", "Available" -> False,
       "Reason" -> "No published bound supplied for this mode."|>,
     limit = constant*factor;
     record = evaluateResidual[limit - Abs[value], limit + Abs[value], wp, atol, rtol];
     Join[<|"Value" -> value, "Constant" -> N[constant, wp], "Limit" -> N[limit, wp],
       "Ratio" -> N[Abs[value]/limit, wp], "Available" -> True|>, record]
   ]]], CoefficientNames[]];

positivityCheck[values_Association, wp_, atol_, rtol_] := Module[{rules},
  rules = Thread[$data["Symbols"] -> Lookup[values, CoefficientNames[]]];
  Association@KeyValueMap[Function[{sector, expressions}, sector ->
    Association@KeyValueMap[Function[{id, expression}, id -> Module[{residual, terms, scale},
      residual = expression /. rules;
      terms = If[Head[expression] === Plus, List @@ expression, {expression}];
      scale = Total[Abs /@ (terms /. rules)];
      evaluateResidual[residual, scale, wp, atol, rtol]
    ]], expressions]], $data["Positivity"]]
];

CheckAQGC[input_Association, modes_: All, OptionsPattern[]] := Module[
  {requested, evaluated, values, needEnergy, lambda, energy, wp, atol, rtol,
   unitarity = <||>, positivity = Missing["NotRequested"], summary = <||>, warnings = {}, row},
  If[!AssociationQ[$data], Return[failure["The bounds data did not load."]]];
  requested = Which[modes === All || modes === "All", $allModes, StringQ[modes], {modes},
    ListQ[modes], modes, True, {}];
  If[requested === {} || !AllTrue[requested, MemberQ[$allModes, #] &],
    Return[failure["Choose a supported mode, a nonempty list of modes, or All."]]];
  requested = DeleteDuplicates[requested];
  evaluated = requested;
  If[MemberQ[evaluated, "FinalCombined"] && !MemberQ[evaluated, "Positivity"], AppendTo[evaluated, "Positivity"]];
  values = completeCoefficients[input];
  If[FailureQ[values], Return[values]];
  wp = OptionValue["WorkingPrecision"];
  atol = OptionValue["AbsoluteTolerance"]; rtol = OptionValue["RelativeTolerance"];
  If[!IntegerQ[wp] || !TrueQ[20 <= wp <= 1000], Return[failure["WorkingPrecision must be an integer from 20 to 1000."]]];
  If[!finiteRealQ[atol] || !finiteRealQ[rtol] || !TrueQ[atol >= 0 && rtol >= 0],
    Return[failure["Tolerances must be finite, real and nonnegative."]]];
  atol = exactify[atol]; rtol = exactify[rtol];
  needEnergy = AnyTrue[evaluated, MemberQ[$unitarityModes, #] &];
  lambda = OptionValue["LambdaTeV"]; energy = OptionValue["EcmTeV"];
  If[needEnergy,
    If[!finiteRealQ[lambda] || !finiteRealQ[energy] || !TrueQ[lambda > 0 && energy > 0],
      Return[failure["Unitarity requires positive LambdaTeV and EcmTeV."]]];
    lambda = exactify[lambda]; energy = exactify[energy]
  ];
  Do[If[MemberQ[evaluated, mode],
    AssociateTo[unitarity, mode -> unitarityCheck[values, mode, (lambda/energy)^4, wp, atol, rtol]];
    AssociateTo[summary, mode -> summarize[Values[unitarity[mode]]]]], {mode, $unitarityModes}];
  If[MemberQ[evaluated, "Positivity"],
    positivity = positivityCheck[values, wp, atol, rtol];
    AssociateTo[summary, "Positivity" -> summarize[Flatten[Values /@ Values[positivity], 1]]]
  ];
  If[MemberQ[evaluated, "FinalCombined"],
    row = summary["FinalCombined"];
    AssociateTo[summary, "FinalCombined" -> Join[row, <|
      "CoefficientBoundsStatus" -> row["Status"], "PositivityStatus" -> summary["Positivity"]["Status"],
      "Status" -> aggregateStatus[{row["Status"], summary["Positivity"]["Status"]}],
      "Complete" -> TrueQ[row["Complete"] && summary["Positivity"]["Complete"]],
      "IncludesPositivity" -> True|>]]
  ];
  If[MemberQ[evaluated, "NaiveSingle"] && Count[Values[values], Except[0]] > 1,
    AppendTo[warnings, "Single-operator unitarity is an isolated-coefficient reference comparison for this multi-coefficient input."]];
  If[Intersection[evaluated, {"NaiveCombined", "FinalCombined"}] =!= {},
    AppendTo[warnings, "Combined limits are marginalized coefficient bounds, not a complete joint eigenvalue test."]];
  If[needEnergy && TrueQ[energy > lambda],
    AppendTo[warnings, "Ecm exceeds Lambda; passing these conditions does not establish EFT validity."]];
  Do[If[Intersection[item["Modes"], evaluated] =!= {}, AppendTo[warnings, item["Message"]]],
    {item, $data["CoverageNotes"]}];
  <|"CoefficientValues" -> values, "RequestedModes" -> requested, "EvaluatedModes" -> evaluated,
    "LambdaTeV" -> If[needEnergy, lambda, Missing["NotNeeded"]],
    "EcmTeV" -> If[needEnergy, energy, Missing["NotNeeded"]], "PrecisionDigits" -> wp,
    "AbsoluteTolerance" -> atol, "RelativeTolerance" -> rtol,
    "Unitarity" -> unitarity, "Positivity" -> positivity, "Summary" -> summary,
    "OverallStatus" -> aggregateStatus[Lookup[Values[summary], "Status"]], "Warnings" -> warnings,
    "DataVersion" -> $data["DataVersion"], "DataSHA256" -> $data["DataSHA256"]|>
];
CheckAQGC[___] := failure["Use CheckAQGC[association, modes, options]. Prefer coefficient names as string keys."];

AuditBounds[] := Module[{names = CoefficientNames[], missing, unused, hierarchy, final, naive},
  missing = AssociationMap[Complement[names, Keys[$data["Unitarity"][#]]] &, $unitarityModes];
  unused = Pick[names, (FreeQ[Values[$data["Positivity"]], #] & /@ $data["Symbols"])];
  final = $data["Unitarity"]["FinalCombined"]; naive = $data["Unitarity"]["NaiveCombined"];
  hierarchy = Select[Intersection[Keys[final], Keys[naive]], TrueQ[N[FullSimplify[final[#] - naive[#]], 50] > 0] &];
  <|"DataVersion" -> $data["DataVersion"], "DataSHA256" -> $data["DataSHA256"],
    "CoefficientCount" -> Length[names], "UnitarityCounts" -> Map[Length, $data["Unitarity"]],
    "MissingUnitarity" -> missing, "PositivityCounts" -> Map[Length, $data["Positivity"]],
    "PositivityUnreferenced" -> unused, "FinalExceedsNaiveCombined" -> hierarchy|>
];

formatNumber[x_] := If[MissingQ[x], "--", If[NumericQ[x], NumberForm[N[x, 10], 7], x]];
ShowAQGCReport[result_Association, OptionsPattern[]] := Module[
  {items, showAll = TrueQ[OptionValue["ShowAll"]], rows, selected},
  items = {Style["aQGC: " <> result["OverallStatus"] <> " for the selected implemented checks", Bold],
    "Dimensionless f_i; unspecified coefficients are zero."};
  If[!MissingQ[result["LambdaTeV"]], AppendTo[items,
    Row[{"Lambda = ", formatNumber[result["LambdaTeV"]], " TeV; Ecm = ", formatNumber[result["EcmTeV"]], " TeV"}]]];
  KeyValueMap[Function[{mode, summary},
    AppendTo[items, Style[Lookup[$modeLabels, mode, mode] <> ": " <> summary["Status"], Bold]];
    AppendTo[items, Row[{"Counts: ", summary["Counts"]}]];
    If[TrueQ[Lookup[summary, "IncludesPositivity", False]], AppendTo[items,
      "Counts refer to coefficient bounds. Mode status also includes explicit positivity (" <>
      summary["PositivityStatus"] <> ")."]];
    If[KeyExistsQ[result["Unitarity"], mode],
      selected = Select[result["Unitarity"][mode],
        showAll || !TrueQ[#["Value"] == 0] || #["Status"] =!= "Pass" &];
      rows = KeyValueMap[Function[{name, r}, {name, formatNumber[r["Value"]],
        formatNumber[r["Limit"]], r["Status"], Lookup[r, "Reason", ""]}], selected];
      If[rows =!= {}, AppendTo[items, Grid[Prepend[rows, {"Coefficient", "Chosen value", "Limit on |f|", "Status", "Reason"}],
        Frame -> All, Alignment -> Left]]],
      If[mode === "Positivity",
        rows = Flatten[KeyValueMap[Function[{sector, records},
          KeyValueMap[Function[{id, r}, {sector, id, formatNumber[r["Residual"]], r["Status"], Lookup[r, "Reason", ""]}],
            Select[records, showAll || #["Status"] =!= "Pass" &]]], result["Positivity"]], 1];
        If[rows =!= {}, AppendTo[items, Grid[Prepend[rows, {"Sector", "Condition", "Residual", "Status", "Reason"}],
          Frame -> All, Alignment -> Left]]]
    ]]], result["Summary"]];
  If[result["Warnings"] =!= {}, AppendTo[items, Style["Notes", Bold]];
    items = Join[items, (StringReplace[#, Normal[$modeLabels]] & /@ result["Warnings"])]];
  Column[items, Spacings -> 1]
];
ShowAQGCReport[f_Failure, OptionsPattern[]] := f;

End[];
EndPackage[];
