(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.11 *)

(*:Name: MathWorld`ConvexHull` *)

(*:Authors:
	Wouter L. J. Meeussen <w.meeussen.vdmcc@vandemoortele.be>
	Eric W. Weisstein     <eww@wolfram.com>
*)

(*:URL:
  http://mathworld.wolfram.com/packages/ConvexHull.m
*)

(*:History:
  v1.00 (1999-08-01): Put in a package by Eric Weisstein
  v1.01 (1999-09-12): Changed Polygon to ConvexifiedPolygon
  v1.02 (1999-10-31): Span
  v1.03 (2000-01-01): Updated URL
  v1.04 (2002-10-26): Updated Convexify
  v1.05 (2003-10-18): updated context
  v1.06 (2003-11-09): updated context in BeginPackage
  v1.10 (2003-12-20): Rewrote vunion.  Added numerical preprocessing of 
                      input vertices in order to reliably and efficiently
                      identify and remove duplicates, which otherwise 
                      cause ConvexHull3D to fail.  Cleaned up dead code.
  v1.11 (2006-02-24): renamed Span

  (c) 1999-2007 Wouter Meeussen and Eric W. Weisstein

*)

(* Limitations:
*)

(*:Keywords:
*)

(*:Requirements: None. *)

(*:Discussion:

This notebook contains a function, ConvexHull3D, to construct the convex hull
of a list of at least four {x,y,z} points in 3-space.

Possibly obsoleted by the undocumented future function

ComputationalGeometry`Methods`ConvexHull3D[vectors] 
*)

BeginPackage["MathWorld`ConvexHull`",{"ComputationalGeometry`"}]

ConvexHull3D::usage =
"ConvexHull3D[points] constructs the convex hull of a list of at least four \
noncoplanar {x,y,z} points in 3-space.  The option WorkingPrecision can be \
specified."

LineSpan::usage =
"LineSpan[l] gives the indices of the points giving the longest line segment
connecting two points of l."


Options[ConvexHull3D]={
	WorkingPrecision->50
};

Begin["`Private`"]

(*
this provides the angle between (v2-v1) and (v3-v2), useful only in the case
of 4 or more coplanar points:
*)

ang[{v1_List,v2_List},v2_|v1_]:=1.
ang[{v1_List,v2_List},v3_List]:=(v2-v1).(v3-v2)/norm[v2-v1]/norm[v3-v2]

ang2[{v1_List,v2_List},v2_]:=1.
ang2[{v1_List,v2_List},v1_]:=-1.
ang2[{v1_List,v2_List},v3_List]:=(v2-v1).(v3-v2)/norm[v2-v1]/norm[v3-v2]

bary[pts_]:=1/Length[pts] Plus@@pts

ch2D[indices_List]:=Module[
	{pts,cen,dis,idx,xfar,far,xsec,hull},
	pts=points[[indices]];
	cen=bary[pts];
	dis=norm[#-cen]& /@ pts;
	idx=myOrdering[dis];
	xfar=Last[idx];far=pts[[xfar]];
	xsec=Sort[{10+  ang2[{cen,far},pts[[#]] ]-10.,
		norm[(far-pts[[#]])] ,#} &/@idx][[-2,-1]];
	hull={xfar,xsec};
		FixedPoint[Last[AppendTo[hull, 
	Sort[ {10+ang[  pts[[Take[hull,-2] ]],
	pts[[#]] ]-10.,
	norm[(pts[[ Last[hull] ]] -pts[[#]])] ,#} &/@idx] [[-3,-1]] ] ]&,0,
		SameTest->(First[hull]==#2 &)];
	indices[[Drop[hull,-1]]]
]

(*
The plane has a sign, which we will need.
All distances from points v on the same side
of the plane {v1,v2,v3} have the same sign.
It can be "+" or "-", dependent on the
right or left circulation of the set {v1,v2,v3}
as seen from the origin.
*)

ConvexHull3D[v_,opts___]:=Module[
	{
	distx,far,crosx,nix,it,faces,legs,cen,
	testable,badones,disordered,circulation,testing,
	prec,
	nv,inputpoints
	(* "n" and "points" are global variables; bad *)
	},
	prec=WorkingPrecision/.{opts}/.Options[ConvexHull3D];
	(* remove duplicates *)
	nv=Chop[N[v,prec]];
	points=First/@Split[Sort[nv]];
	(* reinsert exact values for remaining distinct points *)
	inputpoints=points/.Thread[nv->v];
	n=Length[points];
	cen=Plus@@points/n;
	cenpoints=(#-cen)&/@points;
	distx=Reverse[myOrdering[(#.#)&/@cenpoints]];
	far=distx[[1]];
	crosx= Reverse[myOrdering[1/(1+2 norm/@((points[[far]]-#)& /@ points))* 						\
	(norm[#-cen]&/@points +
		norm/@(Cross[(points[[far]]-cen),(#-cen)]&/@points))]];

	nix=True;i=1;badones={};
	While[nix&&i<=n-1,j=1;
	While[j<=n-1 && (nix=Not[test[it={far,crosx[[i]],crosx[[j]]}]]),j++];
	i++];

	If[Count[res,0,-1]>3,
		it=ch2D[disordered=Flatten[Position[Flatten[res],0]] ]; 
		badones=Complement[disordered,it]
	];

	faces={it};
	oldlegs=legs={};
	faces=Union@Flatten[{faces,{it}},1];
	legs=Split[Sort[Sort/@Flatten[Partition[#~Append~First[#],2,1]&/@faces,1]]];
	legs=Flatten[DeleteCases[legs,{_List,_List}],1];

	While[legs=!={}&&legs=!=oldlegs,
		oldlegs=legs;
		faces=Union[Flatten[{faces,{it}},1]];
		legs=Split[Sort[Sort/@Flatten[Partition[#~Append~First[#],2,1]&/@faces,1]]];
		legs=Flatten[DeleteCases[legs,{q_List,q_List..}],1];
		testing=First@Select[faces, (!FreeQ[#, legs[[1,1]] ]&& !FreeQ[#,legs[[1,2]] \
	])&];

	nix=True;
	j=1; testable=DeleteCases[distx,Alternatives@@Join[testing,badones]];
	While[j<=Length[testable] &&
	(nix=Not[test[it=Flatten[{legs[[1]],testable[[j]]}] ] ]),j++];
	disordered={};
	If[Count[res,0,-1]>3,
		it=ch2D[disordered=Flatten[Position[Flatten[res],0] ] ]; 
		badones=Union[Flatten[{badones,Complement[disordered,it]}] ]
	];
	faces=Union@Flatten[{faces,{it}},1];
	legs=Split[
		Sort[
			Sort /@ Flatten[ Partition[#~Append~First[#],2,1]& /@ faces,1]
			]
		];
	legs=Flatten[DeleteCases[legs,{q_List,q_List..}],1]
	];(*endwhile*)

	circulation=Sign[Chop[plane[Take[#,3]/.k_Integer:>points[[k]],cen]]]&/@faces;
	faces=MapThread[List,{faces,circulation}]/.{poly_List,1}:>Reverse[poly]/.{poly_List,-1}:>poly;
	(Convexify/@Polygon /@ (inputpoints[[#]]& /@ Sort[FixedPoint[RotateLeft,#,SameTest->(First[#2]==Min[#2]&)]&/@faces]))
]

(* Convexify (from PolyhedronOperations.m) *)

(* the triangle is always convex *)

Convexify[poly_Polygon]:=poly /; Length[poly[[1]]]==3

(* but higher n-gons are unfortunately not *)

Convexify::singular = "Normal vector is singular for vector `1`";
Convexify::fatal = "Fatal error while finding projection plain.";

Convexify[poly_Polygon,eps_:10^-6]:=Module[
	{v=poly[[1]],normal,indx,p,nv},
	nv=N[v,100];
	normal=Cross@@(#-nv[[1]]&/@{nv[[2]],nv[[-1]]});
	(* pick a nonsingular projection plane *)
	p=Flatten[Position[normal,_?(Abs[#]<eps&),{1},Heads->False]];
	If[Length[p]==3,
	  Message[Convexify::singular,normal];
	  $Failed,
	(* Else *)
		indx=Switch[Length[p],
		3,Message[Convexify::fatal],
		2,Complement[Range[3],p],
		1,{Complement[Range[3],p][[1]]},
		_,{3}];
		Polygon[v[[ConvexHull[Drop[#,indx]&/@nv]]]]
	]
]

myOrdering[z_List]:=(Sort[Transpose[{z,Range[Length[z]]}]]//Transpose) [[2]]

norm[vec_List]:=Sqrt[vec.vec]

(*
For points "vi" in 3D space, given as vi : {Real_,Real_,Real_},
the following function defines a plane :
*)

plane[{v1_,v2_,v3_},v_]:=Det[{(v-v1),(v1-v2), (v2-v3)}]

same[v1_,v2_]:= Chop[v1-v2]=={0,0,0}

(* Span *)

LineSpan[l_List]:=With[{n=Length[l]},
	Module[
      {p=Subsets[Range[n],2],{d}},
      d=#.#&/@(l[[#[[1]]]]-l[[#[[2]]]]&/@p);
      p[[Flatten[Position[d,Max@@d]][[1]]]]
	]
]

test[tria:{_Integer,_Integer,_Integer}]:=
	If[Unequal@@tria &&Chop[norm[
	Cross[points[[tria[[1]] ]]-points[[tria[[2]] ]], 
	points[[tria[[1]] ]] -points[[tria[[3]] ]]]]]=!=0,
	Block[{i=1,oneside=True},res={};
		While[(oneside = Or[FreeQ[res,-1],FreeQ[res,1]])&&i<=n,
			res={res,
			If[FreeQ[tria,i], Sign@Chop@plane[points[[tria]],points[[i]] ],0] 						\
	};i++];
		oneside],
	False]

End[]

(*
Protect[ ]
*)

EndPackage[]