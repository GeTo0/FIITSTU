(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.02 *)

(*:Name: MathWorld`Hauy` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Hauy.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1998-09-12): Written
  v1.01 (2000-01-01): URL updated
  v1.02 (2003-10-18): updated context
  
  (c) 1998-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)


BeginPackage["MathWorld`Hauy`"]

HauyOctahedralNumber::usage =
"HauyOctahedralNumber[n] gives the nth Hauy octahedral number."

HauyOctahedron::usage =
"HauyOctahedron[n] gives an octahedron of height n (n odd) created by
assembling identical cubic blocks."

HauyRhombicDodecahedralNumber::usage =
"HauyRhombicDodecahedralNumber[n] gives the nth Hauy rhombic
dodecahedral number."

HauyRhombicDodecahedron::usage =
"HauyRhombicDodecahedron[n] gives a rhombic dodecahedron of height n
(n odd) created by assembling identical cubic blocks."

HauySquarePyramid::usage =
"HauySquarePyramid[n] gives a square pyramid of height n created by
assembling identical cubic blocks."


Begin["`Private`"]


HauyOctahedralNumber[n_Integer?Positive]:=(2n-1)(2n^2-2n+3)/3

HauyOctahedron[k_Integer?OddQ]:=Module[{x,y,z,n=(k-1)/2},
	Graphics3D[Flatten[
	Table[
		Table[
			Table[
				Cuboid[{x,y,z}],
			{y,-(n-Abs[z]-Abs[x]),n-Abs[z]-Abs[x]}],
		{x,-(n-Abs[z]),n-Abs[z]}],			
	{z,-n,n}]]
	]
]

HauyRhombicDodecahedralNumber[n_Integer?Positive]:=(2n-1)(8n^2-14n+7)

HauyRhombicDodecahedron[k_Integer?OddQ]:=Module[{x,y,z,n=(k-1)/4},
	Graphics3D[Union[Flatten[{
		Table[
			Table[
				Cuboid[{x,y,(-1)^i z}],
			{y,-(2n-Abs[z]),(2n-Abs[z])},{x,-(2n-Abs[z]),(2n-Abs[z])}],
		{z,n,2n},{i,2}],
		Table[
			Table[
				Cuboid[{x,(-1)^i z,y}],
			{y,-(2n-Abs[z]),(2n-Abs[z])},{x,-(2n-Abs[z]),(2n-Abs[z])}],
		{z,n,2n},{i,2}],
		Table[
			Table[
				Cuboid[{(-1)^i z,x,y}],
			{y,-(2n-Abs[z]),(2n-Abs[z])},{x,-(2n-Abs[z]),(2n-Abs[z])}],
		{z,n,2n},{i,2}]
	}]]]
]

HauySquarePyramid[k_Integer]:=Module[{x,y,z,n=k-1},
	Graphics3D[Flatten[
	Table[
		Table[
			Table[
				Cuboid[{x,y,z}],
			{y,-(n-Abs[z]),n-Abs[z]}],
		{x,-(n-Abs[z]),n-Abs[z]}],			
	{z,0,n}]]
	]
]

End[]

(* Protect[  ] *)

EndPackage[]
