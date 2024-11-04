(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.06 *)

(*:Name: MathWorld`Stats` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Stats.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2002-01-17): Written
  v1.01 (2002-02-15): StatsForm
  v1.02 (2003-04-02): Added typesetting rules for PDF and CDF
  v1.03 (2003-09-03): Added RawMoment, CentralMoment
  v1.04 (2003-10-19): updated context
  v1.05 (2006-06-23): handle contexts for PDF and CDF
  v1.06 (2007-05-07): updated to V6
  
  (c) 2002-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: 
*)

BeginPackage["MathWorld`Stats`"]

RawMoment::usage =
"RawMoment[dist,r] gives the rth raw moment of the specified distribution."

Stats::usage =
"Stats[dist,var] gives a list of the domain, PDF, CDF, \
mean, variance, skewness, and kurtosis of the specified distribution."

StatsForm::usage =
"StatsForm[stats] is a wrapper for Stats that provides nicely formatted \
output in a table using TraditionalForm."

SetOptions[#,FourierParameters->{1,1}]& /@ 
	{FourierTransform, InverseFourierTransform}; 


Unprotect[CentralMoment]

Begin["`Private`"]

CentralMoment[dist_,r_,opts___]:=Module[{x},
    Integrate[Statistics`Common`DistributionsCommon`PDF[dist,x](x-Mean[dist])^r,
    	Evaluate[{x,Sequence@@First[Statistics`Common`DistributionsCommon`Domain[dist]]}],
      opts,GenerateConditions->False]
]

RawMoment[dist_,r_,opts___]:=Module[{x},
    Integrate[Statistics`Common`DistributionsCommon`PDF[dist,x]x^r,
    	Evaluate[{x,Sequence@@First[Statistics`Common`DistributionsCommon`Domain[dist]]}],
      opts,GenerateConditions->False]
]

Stats[dist_,x_]:=
    Table[{
    {"Domain",Statistics`Common`DistributionsCommon`Domain[dist]},
    {"PDF"[x],Statistics`Common`DistributionsCommon`PDF[dist,x]},
    {"CDF"[x],Statistics`Common`DistributionsCommon`CDF[dist,x]},
    {"\[Mu]",Factor[Mean[dist]]},
    {"\!\(\[Sigma]\^2\)",Variance[dist]},
    {"\!\(\[Gamma]\_1\)",Skewness[dist]},
    {"\!\(\[Gamma]\_2\)",Kurtosis[dist]-3}}]

StatsForm[x_]:=Module[{s=MapAt[HoldForm,x,{1,2}]},
	Map[TraditionalForm,TableForm[s],{0}]/.
		z_?StringQ:>ToExpression[z]
]

m[n_] := Sum[Binomial[n, j]*(-1)^(n-j)*\[Mu][j]*\[Mu][1]^(n-j), {j,0,n}]

End[]

Protect[CentralMoment]

EndPackage[]