(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.02 *)

(*:Name: MathWorld`PeriodicContinuedFractions` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/PeriodicContinuedFractions.m
*)

(*:Summary:
This package provides a function for giving the exact expression involving
square roots for periodic continued fraction.  It also includes the extension
of ContinuedFraction to rational numbers a la Wagon, p. 267.
*)

(*:History:
	v1.00 (1995-03-07): Written
	v1.01 (2000-01-01): URL added
	v1.02 (2003-10-19): context updated
	
	(c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:
	number theory, continued fractions
*)

(*:Requirements: None. *)

(*:References:
 Wagon, S.  _Programming in Mathematica_.  p. 267.
*)

(*:Discussion:
*)

BeginPackage["MathWorld`PeriodicContinuedFractions`",
	{
	"NumberTheory`ContinuedFractions`"
	}
]

ContinuedFraction::usage = 
"ContinuedFraction[x,n] generates the continued fraction 
representation for the real number x to order n.  Note that the
order returned may be less than n if the continued fraction
terminates before n steps.  ContinuedFraction[x] generates the
terminating continued fraction for rational x."

FormattedCF::usage =
"FormattedCF[x] prints a formatted version of the continued fraction of
x where x is rational.  FormattedCF[x,n] prints a formatted version of the 
continued fraction for the first n terms of x where x is real."

PeriodicCF::usage =
"PeriodicCF[{n0,n1,...},{p1,p2,...}] gives the analytic expression
for the continued fraction with initial portion {n0,n1,...} and
periodic portion {p1,p2,...}.  If only one array is entered, the
CF is assumed to be purely periodic and CFPurePeriodic is called."

PurePeriodicCF::usage =
"PurePeriodicCF[{a0,a1,...}] gives the analytic expression
corresponding to the pure continued fraction obtaining by
iterating {a0,a1,...}."

QuadConjugate::usage =
"QuadConjugate[d(a+b Sqrt[c])] gives the quadratic conjugate."

SqrtRationalize::usage = 
"SqrtRationalize[x] multiplies the numerator and denominator
of an expression x by the quadratic conjugate QuadConjugate[x]
in order to rationalize it."

Begin["`Private`"]

Unprotect[ContinuedFraction]

quotients[a_,b_]:=(AppendTo[qlist,Floor[a/b]]; quotients[b,Mod[a,b]])

quotients[a_,0]:=0

ContinuedFraction[r_Rational]:=(qlist={};
  quotients[Numerator[r],Denominator[r]];
  ContinuedFractionForm[qlist])
  
FormattedCF[r_Rational] :=
  Block[{qlist=ContinuedFraction[r][[1]]},
    Normal@ContinuedFractionForm[
      Rest[Append[qlist,ToString[Last[qlist]]]]]]
      
FormattedCF[x_Real,n_Integer?Positive]:=
  Block[{qlist=ContinuedFraction[x,n][[1]]},
    Normal[ContinuedFractionForm[
      Rest[Append[qlist, ToString[Last[qlist]]]]]]]

QuadConjugate[a_Integer]:=1

QuadConjugate[d_ * Sqrt[c_Integer]] := Sqrt[c]

QuadConjugate[a_+Sqrt[c_Integer]] := a-Sqrt[c]

QuadConjugate[a_ + b_ * Sqrt[c_Integer]] := a - b Sqrt[c]

QuadConjugate[d_ * (a_+ Sqrt[c_Integer])] := a- Sqrt[c]

QuadConjugate[d_ * (a_+b_ * Sqrt[c_Integer])] := a-b Sqrt[c]

SqrtRationalize[x_]:=Module[{d=Denominator[x]},
  conj=QuadConjugate[d];
  Simplify[Expand[Numerator[x] conj]/Expand[d conj]]
]

PurePeriodicCF[a_List]:= Module[{an,am,pn,pm,qn,qm},
  If[Length[a]>1,
    an=Normal[ContinuedFractionForm[a]];
    pn=Numerator[an];
    qn=Denominator[an];
    am=Normal[ContinuedFractionForm[Drop[a,-1]]];
    pm=Numerator[am];
    qm=Denominator[am];
    Simplify[(-(qm-pn)+Sqrt[(qm-pn)^2+4 qn pm])/(2 qn)],
  (* Else *)
    an=a[[1]];
    Simplify[(an+Sqrt[an^2+4])/2]
  ]
]
  
PeriodicCF[np_List,p_List:{}]:=Module[{pp,an,pn,pm,qn,qm},
  If[p=={},CFPurePeriodic[np],
  pp=PurePeriodicCF[p];
  an=Normal[ContinuedFractionForm[np]];
  pn=Numerator[an];
  qn=Denominator[an];
  If[Length[np]>1,
    am=Normal[ContinuedFractionForm[Drop[np,-1]]];
    pm=Numerator[am];
    qm=Denominator[am];
    SqrtRationalize[Together[Simplify[(pp pn+pm)/(pp qn+qm)]]],
  (* Else *)
    SqrtRationalize[Together[Simplify[np[[1]]+1/pp]]]
  ]]
]

End[]

Protect[ PeriodicCF, PurePeriodicCF, FormattedCF, QuadConjugate, \
\
SqrtRationalize ]

EndPackage[]

(*:Limitations: None known. *)

