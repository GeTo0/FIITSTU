(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: Hanoi` *)

(*:Author: David G. Poole
   ``The Towers and Triangles of Professor Claus (or, Pascal Knows Hanoi).''
   Math. Mag. _67_, 323-344, 1994. *)

(*:URL:
  http://mathworld.wolfram.com/packages/Hanoi.m
*)

(*:Summary:
This package computes moves for the Tower of Hanoi.
*)

(*:History:

 v1.00             : Written by David G. Poole
 v1.01 (2003-10-18): added MathWorld context

*)

(*:Keywords:
	
*)

(*:Requirements: None. *)

(*:Discussion:
*)

BeginPackage["MathWorld`Hanoi`"]


LucasMap::usage =
"LucasMap[a] performs a Lucas correspondence between the Hanoi graph H[n] and
the isomorphic graph of binomial coefficients with adjancency determined by
adjacency in Pascal's triangle."

HanoiMoveSequence::usage =
"HanoiMoveSequence[{a1,...,an},p] gives the minimal sequence of moves required
to move the disks 1,...,n to post p (for a 3-post tower with posts
numbered 0 to 2).  ai gives the post on which disk i starts."

HanoiPath::usage =
"HanoiPath[a1,a2] gives the minimal sequence of moves between positions given
by the lists a1 and a2."

Begin["`Private`"]
   
binstrings[n_]:=Flatten[Apply[Outer,Prepend[Table[{0,1},{n}],List]],n-1]

basismat[n_]:=Module[{M},
  M=Table[0,{n},{n}];
  Do[M[[j,j]]=PowerMod[2,j,3];
    M[[i,j]]=PowerMod[2,j-1,3],{j,1,n-1},{i,j+1,n}
  ];
  M[[n,n]]=PowerMod[2,n,3];
  M
]

ternrep[a_]:=Module[{n,M},
  n=Dimensions[a][[1]];
  M=basismat[n];
  Mod[M.a,3]
]

LucasMap[a_List]:=Module[{n,t,r,k},
  n=Dimensions[a][[1]];
  t=ternrep[a];
  r=Sum[PowerMod[t[[n-i]],2,3] 2^i,{i,0,n-1}];
  k=Sum[t[[n-i]] 2^i,{i,0,n-1}]-r;
  {r,k}
]

movetower[a_]:=Module[{n,top,m,t,b,moveseq},
  n=Dimensions[a][[1]];
  top=Table[0,{n}];
  moveseq={top};
  M=basismat[n];
  b=binstrings[n];
  t=ternrep[a];
  Do[If[t[[i]]!=0,
    (Do[AppendTo[moveseq,Mod[top+t[[i]] M.b[[j+1]],3]],{j,1,2^(n-i)}];
    top=Last[moveseq])],{i,n}
  ];
  Reverse[moveseq]
]

HanoiMoveSequence[a_List,p_Integer] :=Mod[movetower[Mod[a-p,3]]+p,3]

HanoiMoveSequence[a_Integer,p_Integer] :=HanoiMoveSequence[{a},p]

prepend[l_,i_]:=Map[Prepend[#,i]&,l]

HanoiPath01[a1_List,a2_List]:=Module[
  {n,r1,r2,k1,k2,d1,d2,one,path},
  n=Dimensions[a1][[1]];
  r1=LucasMap[a1][[1]];
  k1=LucasMap[a1][[2]];
  r2=LucasMap[a2][[1]];
  k2=LucasMap[a2][[2]];
  one=Table[1,{n-1}];
  d1=r2-k1;
  d2=3 2^(n-1)-1-r1-r2+k1+k2;
  path=If[d1<=d2,
    Join[prepend[HanoiMoveSequence[Rest[a1],2],0],
      Reverse[prepend[HanoiMoveSequence[Rest[a2],2],1]] ],
    Join[prepend[HanoiMoveSequence[Rest[a1],1],0],
      prepend[HanoiMoveSequence[one,0],2],
      Reverse[prepend[HanoiMoveSequence[Rest[a2],0],1]]]
  ];
  path
] (* /; Length[a1]==Length[a2] *)

HanoiPath[a1_List,a2_List]:=Module[
  {u1,u2,v1,v2,rotate,flip,path},
  u=a1;
  v=a2;
  If[u[[1]]==v[[1]],
    path=prepend[HanoiPath[Rest[u],Rest[v]],a1[[1]]],
    (
      rotate=a1[[1]];
      u1=Mod[a1-rotate,3];
      u2=Mod[a2-rotate,3];
      flip=u2[[1]];
      v1=flip u1;
      v2=flip u2;
      path=Mod[flip HanoiPath01[v1,v2]+rotate,3];
    )
  ];
  path
] (* /; Length[a1]==Length[a2] *)

End[]

Protect[ HanoiPath, HanoiMoveSequence, LucasMap ] 

EndPackage[]

(*:Limitations: Range checking not done. *)