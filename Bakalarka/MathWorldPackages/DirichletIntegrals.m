(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`DirichletIntegrals` *)

(*:Author: Eric Weisstein *)

(*:Summary:

  http://www.astro.virginia.edu/~eww6n/math/packages/DirichletIntegrals.m

  This package computes Dirichlet integrals.
*)

(*:History:
  v1.00 (1995-03-11): Written
  v1.01 (2003-10-18): context updated
  
  (c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:
	integrals
*)

(*:Requirements: None. *)

(*:Discussion:
  See http://mathworld.wolfram.com/DirichletIntegeral.html.
*)

BeginPackage["MathWorld`DirichletIntegrals`"]

DirichletC::usage =
"DirichletC[{a1,...,an},{r1,...,rn},m] gives the Dirichlet C integral.
DirichletC[a,{r1,...,rn},m] gives the Dirichlet C integral
DirichletC[{a,...,a},{r1,...,rn},m].  DirichletC[a,r,m] gives the
Dirichlet C integral DirichletC[{a},{r},m]."

DirichletCD::usage =
"DirichletCD[c,{a1,...,an},{r1,...,rn},m] gives the Dirichlet CD integral.
DirichletCD[c,a,{r1,...,rn},m] gives the Dirichlet CD integral
DirichletCD[c,{a,...,a},{r1,...,rn},m].  DirichletCD[c,a,r,m] gives the
Dirichlet CD integral DirichletCD[c,{a},{r},m]."

DirichletD::usage =
"DirichletD[{a1,...,an},{r1,...,rn},m] gives the Dirichlet D integral.
DirichletD[a,{r1,...,rn},m] gives the Dirichlet D integral
DirichletD[{a,...,a},{r1,...,rn},m].  DirichletD[a,r,m] gives the
Dirichlet D integral DirichletD[{a},{r},m]."


Begin["`Private`"]
   
DirichletC[a_List,r_List,m_]:=Module[{
  R=Apply[Plus,r],
  integrand,i},
  integrand=Product[x[i]^(r[[i]]-1),{i,1,Length[r]}]/
    (1+Sum[x[i],{i,1,Length[r]}])^(m+R);
  Do[
    integrand=Integrate[integrand,{x[i],0,a[[i]]}],
    {i,1,Length[r]}
  ];
  Simplify[integrand*
    Gamma[m+R]/Gamma[m]/Product[Gamma[r[[i]]],{i,1,Length[r]}]]
]

DirichletC[a_Integer,r_List,m_]:=
  DirichletC[Table[a,{Length[r]}],r,m]

DirichletC[a_Integer,r_Integer,m_]:=DirichletC[{a},{r},m]


DirichletD[a_List,r_List,m_]:=Module[{
  R=Apply[Plus,r],
  integrand,i},
  integrand=Product[x[i]^(r[[i]]-1),{i,1,Length[r]}]/
    (1+Sum[x[i],{i,1,Length[r]}])^(m+R);
  Do[
    integrand=Integrate[integrand,{x[i],a[[i]],Infinity}],
    {i,1,Length[r]}
  ];
  Simplify[integrand*
    Gamma[m+R]/Gamma[m]/Product[Gamma[r[[i]]],{i,1,Length[r]}]]
]

DirichletD[a_Integer,r_List,m_]:=
  DirichletD[Table[a,{Length[r]}],r,m]

DirichletD[a_Integer,r_Integer,m_]:=DirichletD[{a},{r},m]


DirichletCD[c_Integer,a_List,r_List,m_]:=Module[{
  R=Apply[Plus,r],
  integrand,i},
  integrand=Product[x[i]^(r[[i]]-1),{i,1,Length[r]}]/
    (1+Sum[x[i],{i,1,Length[r]}])^(m+R);
  Do[
    integrand=Integrate[integrand,{x[i],a[[i]],Infinity}],
    {i,c+1,Length[r]}
  ];
  Do[
    integrand=Integrate[integrand,{x[i],0,a[[i]]}],
    {i,1,c}
  ];
  Simplify[integrand*
    Gamma[m+R]/Gamma[m]/Product[Gamma[r[[i]]],{i,1,Length[r]}]]
]

DirichletCD[c_Integer,a_Integer,r_List,m_]:=
  DirichletCD[c,Table[a,{Length[r]}],r,m]

DirichletCD[c_Integer,a_Integer,r_Integer,m_]:=DirichletCD[c,{a},{r},m]


End[]

Protect[ DirichletC, DirichletCD, DirichletD ]

EndPackage[]

(*:Limitations: None known. *)