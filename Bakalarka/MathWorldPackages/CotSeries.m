(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.02 *)

(*:Name: MathWorld`CotSeries` *)

(*:Author: Eric W. Weisstein *)

(*:Summary:

  http://mathworld.wolfram.com/packages/CotSeries.m
  
*)

(*:History:
  1.00 (1996      ): First version
  1.01 (2000-01-01): URL updated
  1.02 (2003-10-18): context updated
  
  (c) 1996-2007 Eric W. Weisstein
*)

(* Limitations:
*)

(*:Keywords:
*)

(*:Requirements: None. *)

(*:Discussion:
  See http:/mathworld.wolfram.com/Cotangent.html.
*)

BeginPackage["MathWorld`CotSeries`"]

CotSeries::usage=
"CotSeries[x] gives the Cot series for the rational number x."

ArcCotSeries::usage=
"ArcCotSeries[x] gives the ArcCot series for the rational number x."


Begin["`Private`"]

CotSeries[x_]:=Module[{a0=Numerator[x],a1,b0=Denominator[x],n,sgn=1,s=0,t},
  While[b0>0,
    n=Floor[a0/b0];
    s+=sgn ArcCot[n];
    sgn*=-1;
    a1=a0 n+b0;
    b0=a0-n b0;
    a0=a1;
  ];
  s
]

ArcCotSeriesConvert[x_]:=Module[{sum=0,fsum=0,b,f,n=0,i,f0=0},
  Do[
    b=x[[i]];
    If[b[[0]]==Times,
      If[IntegerQ[b/(Pi/4)],
        f0=b/(Pi/4);
        f=0,
      (* Else *)
        f=b[[1]];
        n=b[[2,1]]
      ],Null,
    (* Else *)
      f=1;
      n=b[[1]]
    ];
    sum+= f ArcCot[n];
    fsum+=f;
    (* Print[i," ",b," ",f," ",n," ",fsum," ",f0] *),
    {i,1,Length[x]}
  ];
  sum+=(2-f0-2 fsum)ArcCot[1]
]

End[]

(*
Protect[ ]
*)

EndPackage[]