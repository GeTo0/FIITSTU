(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`Calculus` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Calculus.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2005-01-28): Written
  v1.01 (2005-02-05): Exported IntegrateWithAssumptions2
  
  (c) 2005-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Calculus`"]


IntegrateWithAssumptions::usage =
"IntegrateWithAssumptions[int, {x, x0, x1}, ..., <opts>] performs \
a multiple integration by propagating assumptions.  The additional \
option Simplification->f can be given to simplify at each step."

IntegrateWithAssumptions2::usage =
"IntegrateWithAssumptions[int, {x, x0, x1}, ..., <opts>] performs \
a multiple integration by propagating assumptions.  The last integral \
is done as in indefinite integral and limits plugged in."

Simplification::usage =
"Simplification->f is an option to IntegrateWithAssumptions."


Options[IntegrateWithAssumptions]=
	{
    Simplification->Simplify,
    Assumptions->True
	};

Begin["`Private`"]


IntegrateWithAssumptions[integrand_,dx__,opts___?OptionQ]:=Module[
    {
      ineqs=#2<#1<#3&@@@{dx},
      conds,
      simp=Simplification/.{opts}/.Options[IntegrateWithAssumptions],
      assum=Assumptions/.{opts}/.Options[IntegrateWithAssumptions]
      },
    conds=And@@@NestList[Most,Most[ineqs],Length[ineqs]-1];
    Fold[
      simp[Integrate[#1,#2[[1]],Assumptions->assum&&#2[[2]]],
          assum&&#2[[2]]]&,
      integrand,Transpose[{Reverse[{dx}],conds}]]
    ]

IntegrateWithAssumptions2[integrand_,dx__,opts___?OptionQ]:=Module[
    {allbutlast,
      int,
      x,x0,x1
      },
    {x,x0,x1}=First[{dx}];
    allbutlast=
      IntegrateWithAssumptions[integrand,Sequence@@Rest[{dx}],opts,
        Assumptions->x0<x<x1];
    int=Integrate[allbutlast,{dx}[[1,1]]];
    Simplify[
      Limit[int,x->x1,Direction->1]-
        Limit[int,x->x0,Direction->-1]]
]

End[]

EndPackage[]

(* Protect[  ] *)