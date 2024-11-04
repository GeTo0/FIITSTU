(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.03 *)

(*:Name: MathWorld`Polynomial` *)

(*:Author: Eric Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Polynomial.m
*)

(*:Summary:
  This package .
*)

(*:History:
  v1.00 (2005-10-27): Written by Eric W. Weisstein
  v1.01 (2005-10-28): Added AlgebraicDegree for Sin and Cos
  v1.02 (2006-01-05): PolynomialOrder
  v1.03 (2006-05-01): Make Polynomial "safe for slots"
  
  (c) 2005-2007 Eric W. Weisstein
*)

(*:Keywords:
	polynomials
*)

(*:Requirements: None. *)

(*:Limitations:
    PolynomialOrder uses a dumb brute-force method
*)

(*:References:
*)


BeginPackage["MathWorld`Polynomial`",
	{
	"NumberTheory`AlgebraicNumberFields`",	(* AlgebraicDegree *)
	"Algebra`PolynomialPowerMod`"			(* PolynomialOrder *)
	}
]

AlgebraicDegree::usage =
"AlgebraicDegree[c] returns the algebraic degree of an explicit algebraic \
number.  To convert to an algebraic number, it might be necessary to first \
apply FunctionExpand, etc."

IrreducibleQ::usage =
"IrreducibleQ[poly, Modulus->m] returns True if poly is irreducible."

Polynomial::usage =
"Polynomial[coefs, x] returns a polynomial of degree n=(Length[coefs]-1) in x \
with coefficients coefs, read from x^n to x^0."

PolynomialOrder::usage =
"PolynomialOrder[poly, x, Modulus->m] gives the order of the specified polynomial."


(* Typesetting *)

  
Begin["`Private`"]

MakeBoxes[Root[poly_,n_,___],TraditionalForm]:=DeleteCases[
	SubscriptBox[RowBox[{"(",MakeBoxes[poly,TraditionalForm],")"}],n]/.{"#1"->"x"},"&",{1,Infinity}]

AlgebraicDegree[Sin[Rational[1,n_Integer?Positive]Pi]]:=If[n==2,1,EulerPhi[n]/{1,1,2,1}[[Mod[n,4]+1]]]
AlgebraicDegree[Sin[Rational[2,n_Integer?Positive]Pi]]:=
	If[n==4,
		1,
	(* Else *)
		EulerPhi[n]/Switch[IntegerExponent[n,2],
		0|1,1,
		2,4,
		_?(#>2&),2,
		_,Indeterminate
		]
	]
AlgebraicDegree[Cos[Rational[1,n_Integer?Positive]Pi]]:=If[n==1,1,EulerPhi[n]/(Mod[n,2]+1)]
AlgebraicDegree[Cos[Rational[2,n_Integer?Positive]Pi]]:=If[n==1||n==2,1,EulerPhi[n]/2]

AlgebraicDegree[c_]:=Module[{x},Exponent[MinimalPolynomial[c,x],x]]

IrreducibleQ[p_?PolynomialQ,Modulus->m_]:=Module[{f=FactorList[p,Modulus->m]},
	Total[Last/@DeleteCases[f,{_Integer,_Integer}]]==1
]

Polynomial[l_List, x_] := Fold[Function[{a,b}, x a + b], 0, l]

PolynomialOrder[p_?PolynomialQ,x_]:=Exponent[p,x]
PolynomialOrder[x_,x_,Modulus->m_]:=1
PolynomialOrder[p_?PolynomialQ,x_,Modulus->m_]:=Module[{n=1},
    While[
      PolynomialRemainder[x^n+1,p,x,Modulus->m]=!=0,n++];
    n
]

End[]

Protect[(* *)]

EndPackage[]