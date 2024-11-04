(*:Mathematica Version: 6.0 *)

(*:Package Version: 0.26 *)

(*:Name: MathWorld`IntegerSequences` *)

(*:Author: Eric Weisstein 

RomanNumeralForm by
Robby Villegas
"Antique Notations"
http://library.wolfram.com/infocenter/Demos/4952

*)

(*:URL:
  http://mathworld.wolfram.com/packages/IntegerSequences.m
*)

(*:Summary:
  
  Utility functions for integer sequences
  
*)

(*:Requirements:

PartitionsJ requires Mathematica v5.0 or above

*)

(*:Limitations:
*)

(*:History:
	v0.01: (Oct  5, 2003) written by Eric W. Weisstein
    v0.02: (Oct 18, 2003) updated context.  Moved PartitionsJ here
    v0.03: (Nov  8, 2003) added NumberName
    v0.04: (Dec 16, 2003) added RomanNumeral
    v0.05: (Dec 30, 2003) added Period
    v0.07: (Jan 21, 2004) DistinctPrimeFactors
    v0.08: (Jan 24, 2004) ProvablePrimeQ
    v0.09: (Jan 26, 2004) MoebiusTransform
    v0.10: (Feb 26, 2004) CumulativeCount, CumulativeSum
    v0.11: (Mar  9, 2004) Digits, InverseStirlingTransform, StirlingTransform
    v0.12: (Apr 29, 2004) RunningMinima, LowWaterMarks
    v0.13: (Jul  5, 2004) Greedy* routines
    v0.14: (Aug 24, 2004) Removed silly ProvablePrimeQ
    v0.15: (Sep  9, 2004) Trinomial
    v0.16: (Sep 14, 2004) CorrectDigits, FromRealDigits
    v0.17: (Nov 22, 2004) PalindromicQ
    v0.18: (Dec 28, 2004) Sumset, SumFreeSetQ
    v0.19: (Feb 18, 2005) Closed form for Trinomial
    v0.20: (Feb 24, 2005) Moved Trinomial to SpecialFunctions
    v0.21: (Oct  2, 2005) Digits moved to Digits`
    v0.22: (Jan 16, 2006) FirstOccurrences
    v0.23: (Mar 14, 2006) Fixed CorrectDigits
    v0.24: (Mar 16, 2006) PerfectPowerQ
    v0.23: (Mar 14, 2006) Corrected CorrectDigits (again)
    v0.24: (Apr 14, 2006) Extended PalindromicQ to base b
    v0.25: (May  1, 2006) Moved CorrectDigits to Digits.m
    
    (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
*)

(*:Limitations:
*)


BeginPackage["MathWorld`IntegerSequences`"]

\[HorizontalLine]::usage =
"\[HorizontalLine] is defined here as a hack since it typesets as a single \
pixel wide if input as a string instead of a symbol."

CumulativeCount::usage =
"CumulativeCount[list] gives a list of cumulative counts of the elements in list \
that are <= 1, 2, ..., Max[list]."

CumulativeSum::usage =
"CumulativeSum[list] gives a list {a1, a1+a2, a1+a2+a3, ...} of the cumulative sums of a \
list={a1,a2,...}."

DistinctPrimeFactors::usage =
"DistinctPrimeFactors[n] gives a list of the distinct prime factors of n."

DistinctPrimeFactorsOmega::usage =
"DistinctPrimeFactorsOmega[n] gives the number of the distinct prime \
factors of n."

FirstOccurrences::usage =
"FirstOccurrences[list,incr] gives a list of the first occurrences of \
list[[1]], list[[1]]+incr, list[[1]]+2incr, ... together with their \
positions.  Only elemets up to the first gap (or first difference less \
than incr) are included."

FromRealDigits::usage =
"FromRealDigits[{d1,d2,...}] or FromRealDigits[{{d1,d2,...},off}] gives \
the real number represented by the given string of digits."

GreatestPrimeFactor::usage =
"GreatestPrimeFactor[n] gives the greatest prime factor of th integer n."

GreedyDecomposition::usage =
"GreeydDecomposition[<list>,n] returns a list <coefs> which gives the \
lexographically smallest decomposition of \
n in terms of the integers in <list> so that <list>.<coefs>=n if it exsists, \
using a greedy algorithm.  If no such decomposition exists, {} is returned."

GreedyAll::usage =
"GreedyAll[<list>,n] returns a list of all solutions satisfying \
<list>.<coefs>=n by iteratively applying Greedy and GreedyReduce. \
N.B.: <list> is ASSUMED to consist of distinct positive integers \
in increasing order."

GreedyReduce::usage =
"GreedyReduce[<list>,<soln>,n] reduces the soln vector to the lexographically \
next smallest solution.  N.B.: <list> is ASSUMED to consist of distinct \
positive integers in increasing order.  If no smaller solution exists, <soln> \
is returned."

GreedySequence::usage =
"GreedySequence[<list>,n] gives the sequence of high water marks \
in application of the greedy algorithm at which the number of largest \
terms rolls over."

GreedyQ::usage =
"GreedyQ[<list>,n] returns True if there is a decomposition of n using \
the members of <list>."

HighWaterMarks::usage =
"HighWaterMarks[list] gives {hwm,pos}, where hwm is a list of high-water \
marks and pos is a list of the positions in list at which they increase.  \
The first element of hwm is always First[list] and the first element of \
pos is always 1."

InverseMoebiusTransform::usage =
"InverseMoebiusTransform[{b1,b2,...}] gives the inverse Moebius transform \
{a1,a2,...} of the given sequence."

InverseStirlingTransform::usage =
"InverseStirlingTransform[{a1,a2,...}] gives the inverse Stirling transform {b1,b2,...} \
of the given sequence."

LowWaterMarks::usage =
"LowWaterMarks[list] gives {lwm,pos}, where lwm is a list of low-water \
marks and pos is a list of the positions in list at which they decrease.  \
The first element of lwm is always First[list] and the first element of \
pos is always 1."

MoebiusTransform::usage =
"MoebiusTransform[{a1,a2,...}] gives the Moebius transform {b1,b2,...} \
of the given sequence."

NumberName::usage =
"NumberName[n] gives a string representing the full name of the specified \
integer using the American powers of 10 convention."

PalindromicQ::usage =
"PalindromicQ[n] returns True if n is a base-10 palindromic number.  \
PalindromicQ[n,b] returns True if n is a base-b palindromic number."

PartitionsJ::usage =
"PartitionsJ[n] gives the vector j such that j.Range[n]==n."

PerfectPowerQ::usage =
"PerfectPowerQ[n] returns True if n is a perfect power (>1)."

Period::usage =
"Period[list] gives the period of the given list."

RomanNumeral::usage = 
"RomanNumeral[n] gives a string representing the Roman numeral of n.  Vincula \
are not used."

RomanNumeralForm::usage =
"RomanNumeralForm[n] formats an integer n as a Roman numeral using vincula."

RunningMaxima::usage =
"RunningMaxima[list] gives the running maxima of the given list."

RunningMinima::usage =
"RunningMinima[list] gives the running minima of the given list."

StirlingTransform::usage =
"StirlingTransform[{a1,a2,...}] gives the Stirling transform {b1,b2,...} \
of the given sequence."

SumFreeQ::usage =
"SumFreeQ[list] gives True if the given list is sumfree."

Sumset::usage =
"Sumset[l1,l2,...] gives the sumset of the given sequence of sets."

(* Options *)


Begin["`Private`"]

(* Cumulative Count and Sum *)

CumulativeSum[l_List]:=Rest[FoldList[Plus,0,l]]

CumulativeCount[l_List]:=CumulativeSum[
	Flatten[Prepend[Table[0,{#-1}],1]&/@(-Subtract@@@Partition[l,2,1])]
]

(* DistinctPrimeFactors *)

DistinctPrimeFactors[1]:={}
DistinctPrimeFactors[n_Integer?Positive]:=
	Union[Transpose[FactorInteger[n]][[1]]]

DistinctPrimeFactorsOmega[n_Integer?NonNegative]:=
	Length[DistinctPrimeFactors[n]]

(* FirstOccurrences *)

FirstOccurrences[l_List,off_:1]:=Module[
	{
	split=First/@Split[Sort[MapIndexed[{#1,#2[[1]]}&,l]],First[#1]==First[#2]&],
	i=1
	},
    While[
		i<Length[split]&&split[[i+1,1]]-split[[i,1]]-off==0,
		i++
	];
	Take[split,i]
]

(* FromRealDigits *)

FromRealDigits[l_List]:=N[FromDigits[l],Length[First[l]]]

(* Greatest Prime Factor *)

GreatestPrimeFactor[n_Integer?NonNegative]:=FactorInteger[n][[-1,1]]

(* Greedy Algorithm *)

(* Note: GreedyReduce results in an infinite loop if the list contains
 +/- a number *)

diff[l_List,a_List,n_Integer]:=n-l.a

GreedyAll[l_List,n_]:=Module[{g,g0=GreedyDecomposition[l,n],v},
	v={g0};
	While[(g=GreedyReduce[l,g0,n])!=g0,
		AppendTo[v,g];
		g0=g;
	];
	v
]

GreedyReduce[l_List, a0_List, n_Integer, debug_:False] := 
	Module[{j, a = a0, p, pos = {}}, 
	While[a==a0||a.l != n, 
		pos = Flatten[Position[a, _?Positive]]; 
        If[pos == {}, Return[a0], p = pos[[1]]]; 
    	a[[p]]--;
        If[debug, Print[p]];
		df=n-l[[p]] a[[p]];
		Do[
			a[[j]] = Floor[df/l[[j]]];
			df-=l[[j]]a[[j]],
			{j, p - 1, 1, -1}
		];
		If[debug, Print[a]];
	];
	a
]

(*
GreedyReduce[l_List,a0_List,n_Integer,debug_:False]:=Module[
	{i=Length[l],j,a=a0,p,pos={}},
	p=Flatten[Position[a,_?Positive]][[-1]];
	If[debug,Print[p]];
	pos=Flatten[Position[a,_?Positive]];
	If[pos=={},
		a0,
	(* Else *)
		p0=pos[[-1]];
		If[debug,Print[p0]];
		a[[p0]]--;
		If[debug,Print[a]];
		While[a.l!=n,
			pos=Flatten[Position[a,_?Positive]];
			If[pos=={},p=0,p=pos[[-1]]];
			If[debug,Print[p]];
			Do[a[[j]]=Floor[diff[l,a,n]/l[[j]]],{j,p0-1,1,-1}];
			If[debug,Print[a]];
			p0=p;
		];
		a
	]
]
*)

GreedyDecomposition[l_List,n_Integer]:=Module[{a={},aold={},len=Length[l],j},
  a=Table[0,{len}];
  Do[a[[j]]=Floor[diff[l,a,n]/l[[j]]],{j,len,1,-1}];
  While[a!={} && diff[l,a,n]>0 && a!=aold,
    aold=a;
    a=GreedyReduce[l,a,n];
  ];
  If[a==aold,{},a,{}]
]

GreedySequence[l_List,n_Integer]:=Module[{a={},aold={},s={},len=Length[l],j},
  a=Table[0,{len}];
  Do[a[[j]]=Floor[diff[l,a,n]/l[[j]]],{j,len,1,-1}];
  s={a};
  While[diff[l,a,n]>0 && a!=aold,
    aold=a;
    a=GreedyReduce[l,a,n];
    s=Append[s,a];
  ];
  If[a==aold,s[[-1]]={}];
  s
]

GreedyQ[l_List,n_Integer]:=GreedyDecomposition[l,n]!={}


(* High Water Marks *)

HighWaterMarks[l_]:=Module[{s=Split[RunningMaxima[l]]},
    {First/@s,Most[FoldList[Plus,1,Length/@s]]}
]

LowWaterMarks[l_]:=Module[{s=Split[RunningMinima[l]]},
    {First/@s,Most[FoldList[Plus,1,Length/@s]]}
]

(* Moebius Transform *)

MoebiusTransform[a_List]:=
  Module[{n},Table[Tr[MoebiusMu[n/#]a[[#]]&/@Divisors[n]],{n,Length[a]}]]

InverseMoebiusTransform[b_List]:=
  Module[{n},Table[Tr[b[[#]]&/@Divisors[n]],{n,Length[b]}]]

(* Number Name *)

Ones[n_,pad_:0]:=If[Mod[pad,10]>0,"-",""]<>
	{"","one","two","three","four","five","six","seven","eight","nine",
        "ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen",
        "seventeen","eighteen","nineteen"
    }[[n+1]]

Tens[n_]:={"","twenty","thirty","forty","fifty","sixty","seventy","eighty",
      "ninety"}[[n]]

LastThree[n_]:=LastThree[n]=Module[{h=Quotient[n,100],m=Mod[n,100]},
	If[n>99,Ones[h,0]<>" hundred ",""]<>
		If[m<20,Ones[m],Tens[Quotient[m,10]]<>Ones[Mod[m,10],m]]
]

Powers[n_]:=Powers[n]=
	{"",
	" thousand"," million"," billion"," trillion",
	" quadrillion"," quintillion"," sextillion"," septillion"," octillion",
	" nonillion"," decillion"," undecillion"," duodecillion"," tredecillion",
	" quattuordecillion"," quindecillion"," sexdecillion"," septendecillion",
	" octodecillion"," novemdecillion", " vigintillion"
	}[[n]]

(*
NumberName[0]:="zero"
*)

(* handling zero and negative numbers slows code down *)

NumberName[0]="zero"

NumberName[n_Integer]:=Module[
	{db=Reverse[MapIndexed[If[#1==0,"",LastThree[#1]<>Powers[#2[[1]]]<>" "]&,
            FromDigits[#,10]&/@
              Reverse/@Partition[Reverse[IntegerDigits[n,10]],3,3,{1,1},{}]]
          ]},
    StringDrop[StringJoin@@db,-1]
]

(* Partitions *)

PartitionsJ[p_] := Reduce`NaturalLinearSolve[{Range[p]}, {p}, True][[1]]

(* PalindromicQ *)

PalindromicQ[n_,b_:10]:=Module[{l=IntegerDigits[n,b]},
	l===Reverse[l]
]

(* PerfectPowerQ *)

PerfectPowerQ[1]:=True
PerfectPowerQ[n_Integer]:=GCD@@Last/@FactorInteger[n]>1

(* Period *)

Period[l_List]:=Module[
    {
      p=NestWhileList[Rest,Rest[l],#!=Take[l,Length[#]]&,1]
      },
    If[Last[p]=={}||Length[p]==Length[l]-1,0,Length[p]]
    ]

(* Roman Numeral *)

(* Eric's Code *)

RomanNumeral[n_Integer?Positive]:=
  Module[{d=Join[{0,0,0},IntegerDigits[n]],t=Floor[n/1000]},
    StringInsert["","M",Table[1,{t}]]<>
      Switch[d[[-3]],9,"CM",8,"DCCC",7,"DCC",6,"DC",5,"D",4,"CD",3,"CCC",2,
        "CC",1,"C",0,""]<>
      Switch[d[[-2]],9,"XC",8,"LXXX",7,"LXX",6,"LX",5,"L",4,"XL",3,"XXX",2,
        "XX",1,"X",0,""]<>
      Switch[d[[-1]],9,"IX",8,"VIII",7,"VII",6,"VI",5,"V",4,"IV",3,"III",2,
        "II",1,"I",0,""]]

(* Robby's code *)

$RomanDigitValues = {1, 5, 10, 50, 100, 500, 1000};
$RomanDigitSymbols = {"I", "V", "X", "L", "C", "D", "M"};

$RomanDigitDecompRules = Append[
    {4 -> {1, 5}, 9 -> {1,10}}, 
    digit_ :> Table[5, {Quotient[digit, 5]}] ~Join~ Table[1, {Mod[digit, 5]}]
    ];

romanDigitDecomp[n_Integer /; 0 <= n <= 9] := 
  Replace[n, $RomanDigitDecompRules]

toRoman[n_Integer /; 0 <= n <= 999] :=
  Module[{digits, romanValueLists, romanDigitLists},
    digits = IntegerDigits[n, 10, 3];
    romanValueLists = romanDigitDecomp /@ digits;
    romanDigitLists = 
      MapThread[Replace[#1, Thread[{1, 5, 10} -> #2], {1}]&,
        {
          romanValueLists,
          Reverse @ Partition[$RomanDigitSymbols, 3, 2]
          }
        ];
    StringJoin[romanDigitLists]
    ]

ThousandFold[expr] := 
  Grid[{{expr}}, RowSpacings->0, RowMinHeight->0.25]
ThousandFold[expr_, 0] := 
  Grid[{{expr}}, RowSpacings->0, RowMinHeight->0.25]
ThousandFold[expr_, n_Integer] :=
  Grid[Append[Table[{\[HorizontalLine]}, {n}], {expr}], RowSpacings->0, 
    RowMinHeight->0.25]

Unprotect[$BoxForms];
AppendTo[$BoxForms, RomanNumeralForm];
Protect[$BoxForms];

RomanNumeralForm /: ParentForm[RomanNumeralForm] = StandardForm;

RomanNumeralForm /: 
  MakeBoxes[n_Integer /; NumberQ @ Unevaluated[n] && Positive[n], 
    RomanNumeralForm] := 
  FormBox[InterpretationBox[#, n, Editable->False], StandardForm]& @
    GridBox[
      {Reverse @ 
          MapIndexed[ToBoxes @ ThousandFold[toRoman[#1], First[#2] - 1]&, 
            Reverse @ IntegerDigits[n, 10^3]]},
      RowAlignments->Bottom, ColumnSpacings->0.1
      ]

RomanNumeralForm /: MakeBoxes[RomanNumeralForm[expr_], fmt_] :=
  MakeBoxes[expr, RomanNumeralForm]

(* Running Maxima *)

RunningMinima[l_]:=Rest[FoldList[Min,Infinity,l]]

RunningMaxima[l_]:=Rest[FoldList[Max,-Infinity,l]]

(* Stirling Transform *)

StirlingTransform[a_List]:=
  Module[{n},Table[Plus@@MapIndexed[StirlingS2[n-1,#2[[1]]-1]#1&,a],{n,Length[a]}]]

InverseStirlingTransform[b_List]:=
  Module[{n},Table[Plus@@MapIndexed[StirlingS1[n-1,#2[[1]]-1]#1&,b],{n,Length[b]}]]

Sumset[l__List]:=Union[Flatten[Outer[Plus,l]]]

SumFreeQ[l_List]:=Intersection[l,Sumset[l,l]]=={}

End[]

(* Protect[ ] *)

EndPackage[]