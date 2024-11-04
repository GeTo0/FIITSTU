(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`Apodization` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Apodization.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2004-10-07): Put in package format
  v1.01 (2007-05-05): Updated for V6
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion: *)

(*:References: *)

(*:Limitations: 
Usage messages haven't been written yet
*)

BeginPackage["MathWorld`Apodization`",{"Utilities`Typesetting`"}]


Bartlett::usage =
"."
Blackman::usage =
"."
Connes::usage =
"."
Cosine::usage =
"."
Gaussian::usage =
"."
Hamming::usage =
"."
Hanning::usage =
"."
Lorentzian::usage =
"."
Uniform::usage =
"."
Welch::usage =
"."

InstrumentFunction::usage =
"."

ApodizationPlot::usage =
"."

(* Typesetting *)

MakeBoxes[aa[z_],TraditionalForm] := RowBox[{"A","(",MakeBoxes[z,TraditionalForm],")"}]
MakeBoxes[ii[z_],TraditionalForm] := RowBox[{"I","(",MakeBoxes[z,TraditionalForm],")"}]

Begin["`Private`"]


(* Apodization Functions *)

Bartlett[x_, a_] := 1 - Abs[x]/a
Blackman[x_, a_] := (.42 + .5 Cos[Pi x/a] + .08 Cos[2 Pi x/a])
Connes[x_, a_] := (1 - x^2/a^2)^2
Cosine[x_, a_] := Cos[Pi x/2/a]
Gaussian[x_, s_] := Exp[-x^2/2/s^2]
Hamming[x_, a_] := (.54 + .46 Cos[Pi x/a])
Hanning[x_, a_] := Cos[Pi x/2/a]^2
Lorentzian[x_,a_]:=1/(x^2/a^2+1)
Uniform[x_] := 1
Welch[x_, a_] := 1 - x^2/a^2

(* ApodizationPlot *)

ApodizationPlot[{f_, i_}, {x_, k_}, a_, myopts___] := 
 With[{opts = Sequence[PlotStyle -> Red, DisplayFunction -> Identity]}, 
  Show[GraphicsArray[{Plot[f /. a -> 1, {x, -1, 1}, myopts, opts, PlotRange -> {{-1, 1}, {0, 1}}, AxesLabel -> {InlineFraction[x, a], aa[InlineFraction[x, a]]}], 
     Plot[i /. a -> 1, {k, -Pi, Pi}, myopts, opts, PlotRange -> All, AxesLabel -> {k a, InlineFraction[ii[k a], a]}], 
     Plot[i /. a -> 1, {k, -5, 5}, myopts, opts, AxesLabel ->  {k a, InlineFraction[ii[k a], a]}]}], 
   ImageSize -> 400]
   ]


(* FWHM *)

FWHM[f_, x_] := Module[{soln = Solve[f == Limit[f, x -> 0]/2, x]},
      -Subtract @@ Select[x /. soln,Abs[#]<1&]
]

NFWHM[f_, x_] := 2x /. FindRoot[Evaluate[f == Limit[f, x -> 0]/2], {x, .01, .99}]

(* Instrument Function *)

InstrumentFunction[f_, {x_, a_}, k_, opts___] := 
  Integrate[2f Cos[2Pi k x], {x, 0, a}, opts]

End[]

(* Protect[  ] *)

EndPackage[]