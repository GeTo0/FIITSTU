(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.04 *)

(*:Name: MathWorld`Fourier` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/LucasPolynomialSequence.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-09-27): Written
  v1.01 (2003-10-18): updated context
  v1.02 (2004-01-04): Usage messages made consistent with implementation
  v1.03 (2004-05-20): FourierPartialSums
  v1.04 (2004-07-17): Add L>0 assumptions to FourierA and FourierB
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Fourier`",
	{
	"Utilities`FilterOptions`",
	"Graphics`Colors`"
	}
]


FourierA::usage =
"FourierA[n,f,{x,x1,x2}] gives the a_n coefficient of the Fourier series of x \
for n an integer >=0, where f is assumed be be defined over [x1,x2]."

FourierB::usage =
"FourierB[n,f,{x,x1,x2}] gives the b_n coefficient of the Fourier series of x \
for n an integer >0, where f is assumed be be defined over [x1,x2]."

FourierPartialSums::usage =
"FourierPartialSums[f,{x,x0,x1},nmax] gives a list of the first nmax partial sums of \
the Fourier series of f in variable x."

FourierPlot::usage =
"FourierPlot[f,{x,x0,x1},nmax] plots the function and the first nmax partial sums of the \
Fourier series of f in variable x."

Begin["`Private`"]

FourierA[0,f_,{x_,x0_,x1_},opts___]:=Module[{L=(x1-x0)/2},
	Integrate[f,{x,x0,x1},Assumptions->L>0&&opts]/L
]

FourierA[n_,f_,{x_,x0_,x1_},opts___]:=Module[{L=(x1-x0)/2},
	Integrate[f Cos[n Pi x/L],{x,x0,x1},opts,
		Assumptions->Element[n,Integers]&&n>0&&L>0]/L
]

FourierB[n_,f_,{x_,x0_,x1_},opts___]:=Module[{L=(x1-x0)/2},
	Integrate[f Sin[n Pi x/L],{x,x0,x1},opts,
		Assumptions->Element[n,Integers]&&n>0&&L>0]/L
]

FourierPartialSums[f_,{x_,x0_,x1_},nmax_:10,opts___]:=Module[{a0,an,bn,n},
    a0=FourierA[0,f,{x,x0,x1},opts];
    an=FourierA[n,f,{x,x0,x1},opts];
    bn=FourierB[n,f,{x,x0,x1},opts];
    FoldList[Plus,a0/2,Table[an Cos[n Pi x]+bn Sin[n Pi x],{n,nmax}]]
]

FourierPlot[f_,{x_,x0_,x1_},nmax_:10,opts___]:=Module[
	{
		popts=FilterOptions[Plot,opts],
		eps=.05
	},
	Plot[Evaluate[Prepend[FourierPartialSums[f,{x,x0,x1},nmax],f]],{x,x0-eps,x1+eps},
		Evaluate[popts],
		PlotStyle->{Thickness[.01],Red,Orange,Yellow,Green,Blue,Violet}
	]
]

End[]

EndPackage[]

(* Protect[  ] *)