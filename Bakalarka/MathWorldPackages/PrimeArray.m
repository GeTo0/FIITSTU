(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.15 *)

(*:Name: MathWorld`PrimeArray` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/PrimeArray.html
*)

(*:Summary:
*)

(*:History:
  v1.00 (Sep 31, 1997): Written
  v1.10 (Mar 16, 1998): Modified to give arrays equal to best found so far
  v1.11 (Aug 17, 1998): Added date reporting
  v1.12 (May  8, 1999): FlippedArrays, MinimalArray
  v1.13 (Jan  1, 2000): URL updated
  v1.14 (Oct 19, 2003): context updated
  v1.15 (Sep 20, 2005): ripped out old inefficient code; PrimeArray renamed
                        ArrayPrimes
  
  (c) 1997-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
Needs to be rewritten in efficient functional style
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`PrimeArray`",{"MathWorld`MagicSquares`"}]


BestPrimeArray::usage =
"BestPrimeArray[m,n,{min,max}] exhaustively searches for the prime array of shape m x n
with the maximum number of primes.  If min and max are not specified, all numbers
will be searched."

ArrayPrimes::usage =
"ArrayPrimes[array] gives a sorted list of primes contained in the rectangular
array."


Begin["`Private`"]

date:=Module[{d=Date[],e},
	e[n_]:=If[d[[n]]<10,"0"<>ToString[d[[n]]],d[[n]]];
	SequenceForm[d[[1]],"-",e[2],"-",e[3]," ",e[4],":",e[5],":",e[6]]
]

ArrayPrimes[a_List]:=Module[
  {
    p={},i,j,n,str="",
    rows=Length[a],
    cols=Length[a[[1]]]
  },
  Do[
    If[Length[a[[i]]]!=cols,
      Print["Array is not rectangular"];
      Exit[];
    ],
    {i,rows}
  ];
  Do[
     str="";
     i0=i; j0=j;
     While[i0>=1 && j0>=1 && 
          i0<=cols && j0<=rows  && !(dx==dy==0),
         str=str<>ToString[a[[j0,i0]]];
         i0+=dy; j0+=dx;
       ];
(*       Print["(",i,",",j,"), (",dx,",",dy,") ",str]; *)
       While[str!="",
          n=ToExpression[str];
          If[PrimeQ[n] && !MemberQ[p,n],p=Append[p,n]];
(*          Print["'",str,"' ",n," ",p]; *)
          str=StringDrop[str,-1];
       ],
       {i,cols},
       {j,rows},
       {dy,-1,1},
       {dx,-1,1}
    ];
    Sort[p]
]

BestPrimeArray[n_]:=BestPrimeArray[n,n,{1,10^(n n)-1}]
BestPrimeArray[n_,{minn_}]:=BestPrimeArray[n,n,{minn,10^(n n)-1}]
BestPrimeArray[n_,{minn_,maxn_}]:=BestPrimeArray[n,n,{minn,maxn}]
BestPrimeArray[m_,n_]:=BestPrimeArray[m,n,{1,10^(m n)-1}]
BestPrimeArray[m_,n_,{minn_}]:=BestPrimeArray[m,n,{minn,10^(m n)-1}]

BestPrimeArray[m_,n_,{minn_,maxn_}]:=Module[
  {i,d={},d0={},dlist={},maxl=0,maxar={},ar={},stepn=Sign[maxn-minn]},
  Do[
     d=IntegerDigits[i];
     d0=Join[Table[0,{m n-Length[d]}],d];
     ar=PrimeArray[Partition[d0,m]];
     If[Length[ar]>maxl,
        maxl=Length[ar];
        maxar={ar};
        dlist={i};
        Print["(",date,") Better: ",maxl," [1 total] (",i,") ",maxar],
        If[Length[ar]==maxl,
          If[Intersection[{ar},maxar]=={},
            maxar=Append[maxar,ar];
            dlist=Append[dlist,i];
            Print["(",date,") Another ",maxl," [",Length[dlist],
              " total] (",dlist,") ",maxar]
 (* Else *)
 (*     Print["Permutation: ",maxl, " (",i,") ",maxar] *)
          ];
        ];
      ];
      If[Mod[i,20000]==0,Print["(",date,") ",i,"..."]],
    {i,minn,maxn,stepn}
  ];
  dlist
]

End[]

(* Protect[  ] *)

EndPackage[]