(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.36 *)

(*:Name: MathWorld`Digits` *)

(*:Author: Eric Weisstein *)

(*:Summary:

  http://mathworld.wolfram.com/packages/Digits.m

*)

(*:History:
  1.0  (1996)	    eww: written
  1.1  (2001-11-29) eww: eliminated duplicated build-in functionality and
						 updated URL.  Changed names to <base>Form[x]
  1.2  (2002-04-23) eww: added NaryPlot
  1.3  (2003-07-07) eww: CyclicNumberQ, CyclicPart, DecimalExpansion,
						 PrimesWithDecimalPeriod, PrimitiveRoots,
						 PrimitiveRootQ
  1.31 (2003-08-29) eww: DigitCycleLength, sped up CyclicNumberQ substantially using
						 the code of DigitCycleLength
  1.32 (2003-10-18) eww: updated context
  1.33 (2005-10-02) eww: moved Digits here
  1.34 (2006-02-21) eww: Removed NaryPlot (which lives in Utilities`Plot);
						 added NegativeIntegerDigits (from Paul Abbott)
  1.35 (2006-03-01) eww: bug fix for DecimalExpansion
  1.36 (2006-05-01) eww: Moved CorrectDigits 
  1.37 (2006-05-18) eww: Renamed Digits to IntegerLength
  
  (c) 1996-2007 Eric W. Weisstein
*)

(* Limitations:
  None known.
*)

(*:Keywords:
  bases, base conversion, number systems
*)

(*:Requirements: None. *)

(*:Discussion:

  Defines commands to display numbers in common bases.
  
*)

BeginPackage["MathWorld`Digits`"]

BinaryForm::usage=
"BinaryForm[x] gives the base-2 representation of the number x."

CorrectDigits::usage =
"CorrectDigits[c1,c2] gives the number of digits to the left of the decimal point that \
are the same between c1 and c2."

CyclicNumberQ::usage =
"CyclicNumberQ[n] returns True if n is cyclic."

CyclicPart::usage =
"CyclicPart[r] gives a list of digits corresponding to the repeating \
part of the decimal expansion of r."

DecimalExpansion::usage =
"When formatted in TraditionalForm, DecimalExpansion[r] gives a typeset \
version of the decimal expansion of r that indicates the perioidic part \
with a vinculum."

DecimalForm::usage=
"DecimalForm[x] gives the base-10 representation of the number x."

DecimalPeriod::usage=
"DecimalPeriod[r] gives the period of the repeating part of the number r.  \
If r is regular (terminating), then DecimalPeriod[r] returns 0."

DigitCycleLength::usage =
"DigitCycleLength[r,b] gives the length of the repeating portion of the \
decimal expansion of the rational number r in base b."

HexadecimalForm::usage=
"HexadecimalForm[x] gives the base-16 representation of the number x."

If[$VersionNumber<6,
IntegerLength::usage =
"IntegerLength[n] gives the number of decimal digits in n"
];

ModuloOrder::usage =
"ModuloOrder[x,m] gives the modulo order of x mod m."

NegativeIntegerDigits::usage =
"NegativeIntegerDigits[n, b] gives the integer digits of n in base-b for b<0."

OctalForm::usage=
"OctalForm[x] gives the base-8 representation of the number x."

PrimesWithDecimalPeriod::usage=
"PrimesWithDecimalPeriod[n] gives a list of prime numbers whose inverses \
have period n."

PrimesWithDecimalPeriods::usage=
"PrimesWithDecimalPeriods[n] gives a list of prime numbers whose inverses \
have period n."

PrimitiveRootQ::usage =
"PrimitiveRootQ[n,m] returns True if n is a primitive root modulo m."

PrimitiveRoots::usage =
"PrimitiveRoots[n] gives a list of the primitive roots of n."

QuaternaryForm::usage=
"QuaternaryForm[x] gives the base-4 representation of the number x."

TernaryFormForm::usage=
"TernaryForm[x] gives the base-3 representation of the number x."

VigesimalFormForm::usage=
"VigesimalForm[x] gives the base-20 representation of the number x."


Begin["`Private`"]


BinaryForm[x_]:=BaseForm[x,2]

(* CorrectDigits *)

CorrectDigits[r1_,r2_,padding_:2]:=Module[
	{d=(RealDigits[#,10,Ceiling[-Log[10,Abs[r1-r2]]]+Ceiling[Log[10,Abs[r1]]]+padding]&/@{r1,r2})},
    Position[SameQ@@@Transpose[First/@d],False,1,1][[1,1]]-d[[1,2]]-1
]

(* very very slow *)
(*
CyclicNumberQ[n_]:=Length[RealDigits[1/7][[1,-1]]]==n-1
*)

(* very slow *)
(*
CyclicNumberQ[n_Integer?Positive]:=PrimitiveRootQ[10,n]
*)

CyclicNumberQ[2]:=False
CyclicNumberQ[n_]:=
	MultiplicativeOrder[10,FixedPoint[Quotient[#,GCD[#,10]]&,n]]==n-1

CyclicPart[r_Rational]:=RealDigits[r][[1,-1]]

(* Decimal Expansion *)

parts[{{non___Integer,rep_List},offset_}]:={{non},rep,offset}
parts[{{non___Integer},offset_}]:={{non},{},offset}

MakeBoxes[DecimalExpansion[x_],TraditionalForm]:=Module[{non,rep,off},
	{non,rep,off}=parts[RealDigits[x]];
	leading=Which[
		off<=0,
			"0."<>StringJoin@@Table["0",{Abs[off]}]<>StringJoin@@(ToString/@non),
		off<=Length[non],
			StringInsert[StringJoin[ToString/@non],".",off+1],
		True, (* e.g., 32+1/3+1/81 *)
			StringJoin@@(ToString/@non) 
	];
	repeating=Which[
		rep=={},
			"",
		off<=Length[non],
			OverscriptBox[StringJoin@@(ToString/@rep),"_"],
		True, (* e.g., 32+1/3+1/81 *)
			OverscriptBox[
		  	StringInsert[StringJoin[ToString/@rep],".",off-Length[non]+1], "_"]
	];
	RowBox[{leading,(*"\[NegativeVeryThinSpace]",*)repeating}]
]

DecimalForm[x_]:=BaseForm[x,10]

DecimalPeriod[r_Rational]:=Length[CyclicPart[r]]
DecimalPeriod[n_Integer]:=0

DigitCycleLength[r_Rational,b_Integer?Positive]:=
	MultiplicativeOrder[b,FixedPoint[Quotient[#,GCD[#,b]]&,Denominator[r]]]

(* IntegerLength *)

If[$VersionNumber<6,
IntegerLength[n_]:=Floor[Log[10,n]]+1
];

HexadecimalForm[x_]:=BaseForm[x,16]

ModuloOrder[a_,m_]:=Module[{k=1},
	  While[PowerMod[a,k,m]!=1,k++];
	  k
] /; GCD[a,m]==1

NegativeIntegerDigits[0, n_Integer?Negative] := {0}											   

NegativeIntegerDigits[i_, n_Integer?Negative] := Rest @ Reverse @								 
	 Mod[NestWhileList[(# - Mod[#, -n])/n & , i, # != 0 & ], -n]

OctalForm[x_]:=BaseForm[x,8]

(* Primes with Decimal Period *)

fac[n_]:=Select[
	Transpose[FactorInteger[10^n-1]][[1]],#\[NotEqual]2\[NotEqual]5&]

PrimesWithDecimalPeriods[k_]:=Table[fac[i],{i,k}]
PrimesWithDecimalPeriod[n_Integer]:=
  PrimesWithDecimalPeriod[n,PrimesWithDecimalPeriods[n]]
PrimesWithDecimalPeriod[n_Integer,l_List]:=
  Module[{u=Union[Flatten[Take[l,n-1]]]},Complement[l[[n]],u]]

PrimitiveRoots[p_]:=Select[Range[p-1],PrimitiveRootQ[#,p]&]
PrimitiveRootQ[g_,p_]:=ModuloOrder[g,p]==EulerPhi[p]

QuaternaryForm[x_]:=BaseForm[x,4]

TernaryForm[x_]:=BaseForm[x,3]

VigesimalForm[x_]:=BaseForm[x,20]

End[]

(*
Protect[ ]
*)

EndPackage[]