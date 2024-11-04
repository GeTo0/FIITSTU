(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.10 *)

(*:Name: MathWorld`Surfaces` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Surfaces.m
*)

(*:Summary:
This package provides a function for giving the exact expression involving
square roots for periodic continued fraction.
*)

(*:History:
	1.00 (1997-11-01): written by Eric W. Weisstein
	1.01 (1999-10-30): cleaned up.  Corrected G in BothFundamentalForms.
	                   Moved Surfaces` here.
	1.02 (1999-11-06): Fixed dA in Curvatures, cleaned up documentation
	1.03 (2000-01-01): Updated URL.
	1.04 (2000-06-28): Corrected swapped printout of 1st and 2nd forms in 
	                   Curvatures.
	1.05 (2000-09-09): PrincipalCurvatures, added contiuation characters to
	                   usage messages
	1.06 (2001-12-06): updated URL
	1.07 (2003-10-19): updated context
	1.08 (2004-06-06): Corrected PrincipalCurvatures by reversing arguments
	1.09 (2005-09-08): Removed Incorrect FullSimplify[PowerExpand[...]] from Curvatures.
	                   Added AreaElement
	1.10 (2007-09-28): Removed package no longer needed in V6.0
	
	(c) 1997-2007 Eric W. Weisstein
*)

(*:Keywords:
	curvature
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:Limitations: 
  Normal curvature and shape operator not yet defined 
*)


BeginPackage["MathWorld`Surfaces`"]


AreaElement::usage =
"AreaElement[{x,y,z},{u,v}] gives the area element of the specifed surface."

Curvatures::usage =
"Curvatures[{x,y,z},{u,v}] prints the 1st and 2nd fundamental forms and the \
Gaussian and mean curvatures.  Curvatures[{x,y,z},{u,v},simp] uses the given \
simplification function."

E1::usage =
"E1[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the first fundamental coefficient E, \
i.e. E in ds^2=E du^2+2F du dv+G dv^2."

E2::usage =
"e2[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the second fundamental coefficient \
e."

EnneperWeierstrass::usage =
"EnneperWeierstrass[f,g,z,{r1,r2},{phi1,phi2},opts] plots a surface \
using the Enneper-Weierstrass parameterization."

F1::usage =
"F1[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the first fundamental coefficient F, \
i.e. F in ds^2=E du^2+2F du dv+G dv^2."

F2::usage =
"F2[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the second fundamental coefficient \
f."

FirstFundamentalForm::usage =
"FirstFundamentalForm[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the coefficients E, \
F, G."

G1::usage =
"G1[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the first fundamental coefficient G, \
i.e. G in ds^2=E du^2+2F du dv+G dv^2."

G2::usage =
"G2[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the second fundamental coefficient \
g."

GaussianCurvature::usage =
"GaussianCurvature[{x,y,z},{u,v}] gives the Gaussian curvature of the \
surface."

MeanCurvature::usage =
"MeanCurvature[{x,y,z},{u,v}] gives the mean curvature of the surface."

NormalCurvature::usage =
"NormalCurvature[{x,y,z},{u,v},{u0,v0}] gives the normal curvature."

PrincipalCurvatures::usage =
"PrincipalCurvatures[K,H] give the principal curvatures for a given \
Gaussian curvature K and mean curvature H.  \
PrincipalCurvatures{x(u,v),y(u,v),z(u,v)},{u,v}] computes the \
principal curvatures from the parametric equations."

SecondFundamentalForm::usage =
"SecondFundamentalForm[{x(u,v),y(u,v),z(u,v)},{u,v}] gives the coefficients \
e, f, g."

ShapeOperator::usage =
"ShapeOperator is not yet implemented..."


Begin["`Private`"]

(* E1=E, F1=F, G1=G *)
(* E2=e, F2=f, G2=g *)


(* Area Element *)

AreaElement[x_List,{u_,v_}]:=Module[{E1,F1,G1},
	{E1,F1,G1}=FirstFundamentalForm[x,{u,v}];
	Sqrt[E1 G1-F1^2]
]

(* Both Fundamental Forms *)

BothFundamentalForms[x_List,{u_,v_}]:=Module[  
  {
    du=D[x,u],
    dv=D[x,v],
    dudu,
    dudv,
    dvdv
  },
  dudu=D[du,u];
  dudv=D[du,v];
  dvdv=D[dv,v];
  {
    {du.du,du.dv,dv.dv},
    {Det[{dudu,du,dv}],Det[{dudv,du,dv}],Det[{dvdv,du,dv}]}/
    	Sqrt[du.du dv.dv-(du.dv)^2]
  }
]

(* Summary of curvatures *)

Curvatures[x_List,{u_,v_},simp_:Indentity]:=Module[{E1,F1,G1,E2,F2,G2},
  {{E1,F1,G1},{E2,F2,G2}}=simp[BothFundamentalForms[x,{u,v}]];
  Print["{E,F,G} = ",{E1,F1,G1}];
  Print["{e,f,g} = ",{E2,F2,G2}];
  Print["dA = ",simp[Sqrt[E1 G1-F1^2]]];
  Print["Gaussian K = ",simp[(E2 G2-F2^2)/(E1 G1-F1^2)]];
  Print["Mean H     = ",simp[(E2 G1-2F2 F1+G2 E1)/2/(E1 G1-F1^2)]];
]

E1[x_List,{u_,v_}]:=Module[{du=D[x,u]},du.du]

E2[x_List,{u_,v_}]:=Module[{du=D[x,u],dv=D[x,v],dudu},
  dudu=D[du,u];
  Det[{dudu,du,dv}]/Sqrt[du.du dv.dv-(du.dv)^2]
]

EnneperWeierstrass[f_,g_,{z_,r_,phi_}]:=Module[{},
	FullSimplify[PowerExpand[ComplexExpand[FullSimplify[Re[Expand[
		Integrate[{f(1-g^2),I f(1+g^2),2f g},z] /. z->r Exp[I phi]]]]]] /. 
    Arg[Exp[I phi] r]->phi]
]

EnneperWeierstrass[f_,g_,z_,r0_List,phi0_List,opts___]:=Module[{r,phi},
	ParametricPlot3D[Evaluate[EnneperWeierstrass[f,g,{z,r,phi}]],
		{r,r0[[1]],r0[[2]]},{phi,phi0[[1]],phi0[[2]]},opts]
]

F1[x_List,{u_,v_}]:=D[x,u].D[x,v]

F2[x_List,{u_,v_}]:=Module[{du=D[x,u],dv=D[x,v],dudv},
  dudv=D[du,v];
  Det[{dudv,du,dv}]/Sqrt[Simplify[du.du dv.dv-(du.dv)^2]]
]

(* First Fundumental Form *)

FirstFundamentalForm[x_,{u_,v_}]:=Module[{du=D[x,u],dv=D[x,v]},
  {du.du,du.dv,dv.dv}
]

G1[x_List,{u_,v_}]:=Module[{dv=D[x,v]},dv.dv]

G2[x_List,{u_,v_}]:=Module[{du=D[x,u],dv=D[x,v],dvdv},
  dvdv=D[dv,v];
  Det[{dvdv,du,dv}]/Sqrt[Simplify[du.du dv.dv-(du.dv)^2]]
]

GaussianCurvature[x_List,{u_,v_}]:=Module[{E1,F1,G1,E2,F2,G2},
  {{E1,F1,G1},{E2,F2,G2}}=BothFundamentalForms[x,{u,v}];
  (E2 G2-F2^2)/(E1 G1-F1^2)
]

GaussianCurvatureg[{g11_,g12_,g22_},{u_,v_}]:= Module[{},
  Simplify[
  (Det[{{g11,g12,D[g12,v]-1/2 D[g22,u]},
    {g12,g22,1/2 D[g22,v]},
    {1/2 D[g11,u],D[g12,u]-1/2 D[g11,v],
    	-1/2 D[g11,{v,2}]+D[g12,u,v]-1/2 D[g22,{u,2}]}}]
   -Det[{{g11,g12,1/2 D[g11,v]},{g12,g22,1/2 D[g22,u]},
    {1/2 D[g11,v],1/2 D[g22,u],0}}])/Det[{{g11,g12},{g12,g22}}]^2]
]

MeanCurvature[x_List,{u_,v_}]:=Module[{E1,F1,G1,E2,F2,G2},
  {{E1,F1,G1},{E2,F2,G2}}=BothFundamentalForms[x,{u,v}];
  (E2 G1-2F2 F1+G2 E1)/2/(E1 G1-F1^2)
]

NormalCurvature[x_List,{u0_,v0_}]:=NormalCurvature[x,{u,v},{u0,v0}]

NormalCurvature[x_List,{u_,v_},{u0_,v0_}]:=Module[{},
  Print["under construction"];
]

PrincipalCurvatures[x_List,{u_,v_}]:=
	PrincipalCurvatures[GaussianCurvature[x,{u,v}],MeanCurvature[x,{u,v}]]

PrincipalCurvatures[k_,h_]:=Module[{s=Sqrt[h^2-k]},
  {h+s,h-s}
]

(* Second Fundamental Form *)

SecondFundamentalForm[x_List,{u_,v_}]:=Module[
  {du=D[x,u],dv=D[x,v],dudu,dudv,dvdv},
  dudu=D[du,u];
  dudv=D[du,v];
  dvdv=D[dv,v];
  {Det[{dudu,du,dv}],Det[{dudv,du,dv}],Det[{dvdv,du,dv}]}/
    Sqrt[du.du dv.dv-(du.dv)^2]
]

(* Shape Operator using Weingarten Equations *)

ShapeOperator:=Module[{},
  Print["under construction"];
]


End[]

Protect[ (*  *) ]

EndPackage[]


