(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`CurvilinearCoordinates` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/CurvilinearCorodinates.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2005-10-18): Written
  v1.01 (2005-10-19): ChristoffelSymbols
  v1.02 (2005-10-21): ChristoffelSymbols2
  
  (c) 2005-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`CurvilinearCoordinates`"]

ChristoffelSymbols::usage =
"ChristoffelSymbols[coords,vars] gives the three matrices of \
Christoffel symbols (Misner form) of the specified coordinates \
with respect to the specified variables."

ChristoffelSymbols2::usage =
"ChristoffelSymbols2[coords,vars] gives the three matrices of \
Christoffel symbols (Arfken form) of the specified coordinates \
with respect to the specified variables."

Grad::usage=
"Grad[coords,vars] gives the gradient."

Gradients::usage =
"Gradients[coords,vars] gives the gradients of the specified coordinates \
with respect to the specified variables."

JacobianDet::usage=
"JacobianDet[coords,vars] gives the Jacobian of the specified coordinates \
with respect to the specified variables."

Laplacian::usage=
"Laplacian[coords,vars] gives the Laplacian of the \
specified coordinates with respect to the specified variables."

ScaleFactors::usage=
"ScaleFactors[coords,vars] gives the scale factors h_i of the \
specified coordinates with respect to the specified variables."

UnitVectors::usage=
"UnitVectors[coords,vars] the unit vectors factors uhat_i of the \
specified coordinates with respect to the specified variables."


Begin["`Private`"]

ChristoffelSymbols[coords_,vars_]:=Module[
	{
		u=UnitVectors[coords,vars],
		h=ScaleFactors[coords,vars],
		i,j,k
	},
	Table[u[[i]].(D[u[[j]],vars[[k]]])/h[[k]],{i,3},{j,3},{k,3}]
]

eps[coords_,vars_,i_]:=D[coords,vars[[i]]]

ChristoffelSymbols2[coords_,vars_]:=
  Module[{h=ScaleFactors[coords,vars],i,j,m},
    Table[1/h[[m]]^2 eps[coords,vars,m].D[eps[coords,vars,i],vars[[j]]],{m,3},{i,3},{j,3}]]

Grad[coords_,vars_][f_]:=Module[
	{
		u=UnitVectors[coords,vars],
		h=ScaleFactors[coords,vars]
	},
	Plus@@((u[[#]]/h[[#]] D[f,vars[[#]]])&/@Range[3])
]

Gradients[coords_,vars_]:=Module[
	{
		u=UnitVectors[coords,vars],
		h=ScaleFactors[coords,vars],
		j,k
	},
	Table[(D[u[[j]],vars[[k]]])/h[[k]],{j,3},{k,3}]
]

JacobianMatrix[f_List?VectorQ, x_List] := 
  Outer[D, f, x] /; Equal@@(Dimensions/@{f,x})
JacobianDet[f_List?VectorQ, x_List] := 
  Abs[Det[JacobianMatrix[f, x]]] /;Equal @@ (Dimensions /@ {f, x})

Laplacian[coords_,vars_][f_]:=Module[{h=ScaleFactors[coords,vars]},
	(D[h[[2]]h[[3]]/h[[1]] D[f,vars[[1]]], vars[[1]]]+
	D[h[[3]]h[[1]]/h[[2]] D[f,vars[[2]]], vars[[2]]]+
	D[h[[1]]h[[2]]/h[[3]] D[f,vars[[3]]], vars[[3]]])/Times@@h
]

norm[x_]:=Sqrt[x.x]

ScaleFactors[coords_,vars_]:=Outer[norm[D[##]]&,{coords},vars,1][[1]]

UnitVectors[coords_,vars_]:=
  Outer[D[##]/norm[D[##]]&,{coords},vars,1][[1]]

End[]

EndPackage[]

(* Protect[  ] *)