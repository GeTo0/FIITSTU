(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.32 *)

(*:Name: MathWorld`Groups` *)

(*:Author: Eric W. Weisstein (eww@wolfram.com)

Contributions by

(2003-03-20) Ed Pegg Jr.  PointGroup["I"], PointGroup["O"], PointGroup["T"]

*)

(*:URL:
  http://mathworld.wolfram.com/packages/Groups.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1998-05-26): Written.
  v1.01 (2000-01-01): URL updated.
  v1.02 (2000-01-15): Explicitly calculate FiniteGroups for special cases,
                      otherwise look it up.
  v1.03 (2000-03-18): Added reference.
  v1.04 (2000-04-14): g(512) added.
  v1.05 (2000-06-20): g(768) added.  References updated.
  v1.06 (2000-06-21): Added all groups from 1-2000, returned by GAP.
  v1.07 (2000-07-01): Typo fixes.
  v1.08 (2002-06-14): ConjugacyClasses
  v1.09 (2003-02-21): Moved IcosahedralGroup here
  v1.10 (2003-03-13): Rewrote CharacteisticFactors and ModuloMultiplicationPhi
  v1.11 (2003-06-10): Renamed AbelianGroups
  v1.20 (2003-08-31): CycleGraph, CyclicGroupMatrices, DihedralGroupMatrices,
                      GroupQ, SubgroupQ, Subgroups, AbelianGroupQ, MatrixGroupQ.
                      Rewrote and renamed GraphCycles
                      (to avoid a conflict with Combinatorica).  Rewrote 
                      ResidueClasses
  v1.25 (2003-09-02): Extended all commands to work with permutation groups,
                      matrix groups, and modulo multiplication groups by 
                      defining GroupTimes, GroupIdentity, and GroupInverse.
  v1.26 (2003-09-06): CycleDiagram, changed simplification syntax.
                      Renamed IcosahedralGroup and added other PointGroups
  v1.27 (2003-09-08): TransitiveGraphQ moved here
  v1.28 (2003-09-13): Renamed MaximalGraphCycle to MaximalGroupCycle
  v1.29 (2003-10-18): Updated context
  v1.30 (2004-10-05): Fixed MaximalGroupCycles
  v1.31 (2006-06-21): Changed the sign of RotationMatrix
  v1.32 (2006-12-05): GroupDataString, NormalSubgroups, SimpleGroupQ
  
  (c) 1998-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None *)

(*:Discussion:
*)

(*:References:
  Besche, H.-U. and Eick, B.  "The Groups of Order at Most 1000 Except 512 and 768."
    J. Symb. Comput. _27_, 405--413, 1999.
  g(512) from Eick, B. and O'Brien, E.A.  "The Groups of Order 512."  In
    _Algorithmic Algebra and Number Theory_.  New York: Springer-Verlag, pp. 379-380.
  A list of the orders of the finite groups up to order 1000 can be found at
    http://www.cs.uwa.edu.au/~gordon/remote/group1000.html
  The GAP program contains a database of the number of group for orders up to 2000 
    (excluding 1024).  GAP is available from http://www-history.mcs.st-and.ac.uk/~gap/.
*)

(*:Limitations: 
  Lookup table extends only to 2000
*)

BeginPackage["MathWorld`Groups`",
	{
	If[$VersionNumber<6,"NumberTheory`NumberTheoryFunctions`",Sequence@@{}],
	If[$VersionNumber<6,"DiscreteMath`Combinatorica`","Combinatorica`"]
	}
]

AbelianGroupQ::usage =
"AbelianGroupQ[g] returns True if g is Abelian."

CharacteristicFactors::usage =
"CharacteristicFactors[{f1,f2,...}] gives the list of characteristic factors \
given a direct product representation of a group."

ConjugacyClasses::usage =
"ConjugacyClasses[g] gives a list of lists of elements in each conjugacy \
class of the given group."

ConjugacyClassTable::usage =
"ConjugacyClassTable[g] gives a table of X^-1YX for all pairs of elements."

CycleDiagram::usage =
"CycleDiagram[CyclicGroup[n]] makes a nice diagram representing the cycle graph \
of the spcified group."

CycleGraph::usage =
"CycleGraph[g] gives a graph representing the nontrivial cycles of the \
specified group."

CyclicGroupMatrices::usage =
"CyclicGroupMatrices[n] gives a list of n 2-dimensional matrices representing \
the cyclic group Z_n."

DihedralGroupMatrices::usage =
"DihedralGroupMatrices[n] gives a list of 2n 2-dimensional matrices representing \
the dihedral group D_n.  These are given in the order {S^0 R^0, S^0 R^1, ..., \
S^0 R^(n-1), S^1 R^0, S^1, R^1, ..., S^1, R^(n-1)}."

GroupCycles::usage =
"GroupCycles[g] gives a list of cycles for the specified group where g is \
a modulo multiplication group, a permutation group, or a matrix group."

GroupDataString::usage =
"GroupDataString[group, {standardName, namestring}, classes, timeout] gives output \
for a given group with given StandardName, Name (as a string), explicit classes, and timeout."

GroupIdentity::usage =
"GroupIdentity[g1] gives the identity element of a group having g1 as an element."

GroupInverse::usage =
"GroupInverse[g1] gives the inverse element of g1."

GroupMultiplicationTable::usage =
"GroupMultiplicationTable[g,(rules)] gives a group multiplication table."

GroupQ::usage =
"GroupQ[g] returns True if g is a permutation group, matrix group, or a \
modulo multiplication group.  For matrix groups with nontrivial elements, \
it may be necessary to provide additional simplification to establish \
equality of the products of elements.  This is specified via Simplification->f, \
where f is a pure function."

GroupTimes::usage =
"GroupTimes[g1,g2,...] gives the product of the given elements using \
the appropriate group multiplication operation."

MaximalGroupCycles::usage =
"MaximalGroupCycles[g] gives a list of maximal group cycles for the specified group."

ModuloMultiplicationGroup::usage =
"ModuloMultiplicationGroup[m] represents the modulo multiplication M_m as \
the list of its residues {{r1,{m}},{r2,{m}},...}."

ModuloMultiplicationPhi::usage =
"ModuloMultiplicationPhi[n] gives the factorization of EulerPhi[n] \
as phi[n].  Apply CharacteristicFactors to it to get the standard form."

NormalSubgroupQ::usage =
"NormalSubgroupQ[h,g] returns true if h is a normal subgroup of g."

NormalSubgroups::usage =
"NormalSubgroups[g] gives a list of the normal subgroups of g."

NumberOfAbelianGroups::usage =
"NumberOfAbelianGroups[n] gives the number of Abelian groups of order n."

NumberOfFiniteGroups::usage =
"NumberOfFiniteGroups[n] gives the total number of non-isomorphic finite groups \
of order n.  For special forms of n, the number is calculated, otherwise \
it is looked up."

PointGroup::usage =
"PointGroup[ptg] gives a set of matrices for the specified point group, given as \
a string.  Recognized groups can be found by issuing PointGroups."

PointGroups::usage =
"PointGroups gives a listing of defined point groups available using PointGroup[\"pg\"]."

QuadraticResidues::usage =
"QuadraticResidues[n] gives the number of quadratic residues of \
the group M_n."

SimpleGroupQ::usage =
"SimpleGroupQ[g] returns True if g is a simple group."

Simplification::usage =
"Simplification is an option for GroupQ."

SubgroupQ::usage =
"SubgroupQ[h,g] returns True if g is a subgroup of the group g."

Subgroups::usage =
"Subgroups[g] gives the subgroups of the given group.  The group may be specified as \
either a list of matrices or a list of permuations."

TransitiveGroupQ::usage =
"TransitiveGroupQ[pg] returns True if the permutation group pg is \
transitive."


SetAttributes[CycleDiagram,HoldFirst]

Begin["`Private`"]

(* AbelianGroupQ *)

AbelianGroupQ[g_,opts___]:=Module[
	{
		f=Simplification/.{opts}/.{Simplification->Identity}
	},
	And@@(Equal@@f/@{GroupTimes@@#,GroupTimes@@Reverse[#]}&/@Subsets[g,{2}])
]

(* Characteristic Factors *)

CharacteristicFactors[{}]:={}

CharacteristicFactors[l_List]:=
  Module[{ll=Split[Sort[Flatten[FactorInteger/@l,1]],Equal@@First/@{##}&]},
    Reverse[
      Times@@@Apply[Power,
          Map[Last,
            NestList[DeleteCases[Map[Drop[#,-1]&,#,{1}],{}]&,ll,
              Max[Length/@ll]-1],{2}],{2}]]
    ]

(* Conjugacy Classes *)

ConjugacyClassTable[g_,opts___]:=Module[
	{
		f=Simplification/.{opts}/.{Simplification->Identity}
	},
	Outer[f[GroupTimes[GroupInverse[#2],#1,#2]]&,g,g,1]
]	

ConjugacyClasses[g_,opts___]:=Union[Union/@ConjugacyClassTable[g,opts]]

(* CycleGraph *)

(*
GroupGraphRaw[m_Integer,opts___]:=
  FromOrderedPairs[Flatten[Partition[#,2,1,1]&/@GroupCycles[m],1],
    opts,Type->Undirected]

GroupGraph[m_Integer?PrimeQ,opts___]:=
  Module[{n=m-1,k},
    ChangeVertices[GroupGraphRaw[m,opts],
      Table[{Cos[-2Pi k/n+Pi/2.],Sin[-2Pi k/n+Pi/2.]},{k,0,
            n}][[InversePermutation[
            First[Sort[GroupCycles[m],Length[#1]>=Length[#2]&]]]]]]
]

GroupGraph[m_Integer]:=GroupGraphRaw[m]

GroupGraph[l_List?MatrixQ,opts___]:=
	FromOrderedPairs[Flatten[Partition[#,2,1,1]&/@
		(GroupCycles[l]/.Thread[l->Range[Length[l]]]),1],
    opts,Type->Undirected]
*)

CycleDiagram[CyclicGroup[n_],r_:.3]:=Module[{c,t=3},
	{
		Circle[{0,0},1],
		{
			{GrayLevel[1],Disk[c=Through[{Sin,Cos}[2Pi(#-1)/n]],r]},
			{If[#==1,AbsoluteThickness[t],Sequence@@{}],Circle[c,r]},
			Text[#,c,{0,0}]
		}&/@Range[n]
	}
]

(*
CycleGraph[g_List]:=CycleGraphFromCycles[GroupCycles[g]/.Thread[g->Range[Length[g]]]]
*)

CycleGraph[g_List]:=FromUnorderedPairs[Flatten[Partition[#,2,1,1]&/@MaximalGroupCycles[g],1]]

(*
CycleGraphFromCycles[c_List]:=Module[
	{
		c2=Union[c,SameTest->(Sort[#1]==Sort[#2]&)],
		n
	},
	FromUnorderedPairs[Flatten[Partition[#,2,1,1]&/@c2[[Flatten[
              Position[
                Or@@@Table[
                    c2[[n]]==Intersection[c2[[n]],#]&/@Drop[c2,{n}],{n,
                      Length[c2]}],False]]]],1]
	]
]
*)



(* CyclicGroupMatrix *)

CyclicGroupMatrices[n_]:=RotationMatrix[-2Pi#/n]&/@Range[0,n-1]

(* Dihedral Matrices *)

DihedralGroupMatrices[n_]:=
  Flatten[Outer[Dot,MatrixPower[{{-1,0},{0,1}},#]&/@{0,1},
      RotationMatrix[2Pi#/n]&/@Range[0,n-1],
      1
],1]

FiniteGroupsList:={
1, 1, 1, 2, 1, 2, 1, 5, 2, 2, 1, 5, 1, 2, 1, 14, 1, 5, 1, 5, 2, 2, 1, 15, 2, 
2, 5, 4, 1, 4, 1, 51, 1, 2, 1, 14, 1, 2, 2, 14, 1, 6, 1, 4, 2, 2, 1, 52, 2, 
5, 1, 5, 1, 15, 2, 13, 2, 2, 1, 13, 1, 2, 4, 267, 1, 4, 1, 5, 1, 4, 1, 50, 1, 
2, 3, 4, 1, 6, 1, 52, 15, 2, 1, 15, 1, 2, 1, 12, 1, 10, 1, 4, 2, 2, 1, 231, 
1, 5, 2, 16, 1, 4, 1, 14, 2, 2, 1, 45, 1, 6, 2, 43, 1, 6, 1, 5, 4, 2, 1, 47, 
2, 2, 1, 4, 5, 16, 1, 2328, 2, 4, 1, 10, 1, 2, 5, 15, 1, 4, 1, 11, 1, 2, 1, 
197, 1, 2, 6, 5, 1, 13, 1, 12, 2, 4, 2, 18, 1, 2, 1, 238, 1, 55, 1, 5, 2, 2, 
1, 57, 2, 4, 5, 4, 1, 4, 2, 42, 1, 2, 1, 37, 1, 4, 2, 12, 1, 6, 1, 4, 13, 4, 
1, 1543, 1, 2, 2, 12, 1, 10, 1, 52, 2, 2, 2, 12, 2, 2, 2, 51, 1, 12, 1, 5, 1, 
2, 1, 177, 1, 2, 2, 15, 1, 6, 1, 197, 6, 2, 1, 15, 1, 4, 2, 14, 1, 16, 1, 4, 
2, 4, 1, 208, 1, 5, 67, 5, 2, 4, 1, 12, 1, 15, 1, 46, 2, 2, 1, 56092, 1, 6, 
1, 15, 2, 2, 1, 39, 1, 4, 1, 4, 1, 30, 1, 54, 5, 2, 4, 10, 1, 2, 4, 40, 1, 4, 
1, 4, 2, 4, 1, 1045, 2, 4, 2, 5, 1, 23, 1, 14, 5, 2, 1, 49, 2, 2, 1, 42, 2, 
10, 1, 9, 2, 6, 1, 61, 1, 2, 4, 4, 1, 4, 1, 1640, 1, 4, 1, 176, 2, 2, 2, 15, 
1, 12, 1, 4, 5, 2, 1, 228, 1, 5, 1, 15, 1, 18, 5, 12, 1, 2, 1, 12, 1, 10, 14, 
195, 1, 4, 2, 5, 2, 2, 1, 162, 2, 2, 3, 11, 1, 6, 1, 42, 2, 4, 1, 15, 1, 4, 
7, 12, 1, 60, 1, 11, 2, 2, 1, 20169, 2, 2, 4, 5, 1, 12, 1, 44, 1, 2, 1, 30, 
1, 2, 5, 221, 1, 6, 1, 5, 16, 6, 1, 46, 1, 6, 1, 4, 1, 10, 1, 235, 2, 4, 1, 
41, 1, 2, 2, 14, 2, 4, 1, 4, 2, 4, 1, 775, 1, 4, 1, 5, 1, 6, 1, 51, 13, 4, 1, 
18, 1, 2, 1, 1396, 1, 34, 1, 5, 2, 2, 1, 54, 1, 2, 5, 11, 1, 12, 1, 51, 4, 2, 
1, 55, 1, 4, 2, 12, 1, 6, 2, 11, 2, 2, 1, 1213, 1, 2, 2, 12, 1, 261, 1, 14, 
2, 10, 1, 12, 1, 4, 4, 42, 2, 4, 1, 56, 1, 2, 1, 202, 2, 6, 6, 4, 1, 8, 1, 
10494213, 15, 2, 1, 15, 1, 4, 1, 49, 1, 10, 1, 4, 6, 2, 1, 170, 2, 4, 2, 9, 
1, 4, 1, 12, 1, 2, 2, 119, 1, 2, 2, 246, 1, 24, 1, 5, 4, 16, 1, 39, 1, 2, 2, 
4, 1, 16, 1, 180, 1, 2, 1, 10, 1, 2, 49, 12, 1, 12, 1, 11, 1, 4, 2, 8681, 1, 
5, 2, 15, 1, 6, 1, 15, 4, 2, 1, 66, 1, 4, 1, 51, 1, 30, 1, 5, 2, 4, 1, 205, 
1, 6, 4, 4, 7, 4, 1, 195, 3, 6, 1, 36, 1, 2, 2, 35, 1, 6, 1, 15, 5, 2, 1, 
260, 15, 2, 2, 5, 1, 32, 1, 12, 2, 2, 1, 12, 2, 4, 2, 21541, 1, 4, 1, 9, 2, 
4, 1, 757, 1, 10, 5, 4, 1, 6, 2, 53, 5, 4, 1, 40, 1, 2, 2, 12, 1, 18, 1, 4, 
2, 4, 1, 1280, 1, 2, 17, 16, 1, 4, 1, 53, 1, 4, 1, 51, 1, 15, 2, 42, 2, 8, 1, 
5, 4, 2, 1, 44, 1, 2, 1, 36, 1, 62, 1, 1387, 1, 2, 1, 10, 1, 6, 4, 15, 1, 12, 
2, 4, 1, 2, 1, 840, 1, 5, 2, 5, 2, 13, 1, 40, 504, 4, 1, 18, 1, 2, 6, 195, 2, 
10, 1, 15, 5, 4, 1, 54, 1, 2, 2, 11, 1, 39, 1, 42, 1, 4, 2, 189, 1, 2, 2, 39, 
1, 6, 1, 4, 2, 2, 1, 1090235, 1, 12, 1, 5, 1, 16, 4, 15, 5, 2, 1, 53, 1, 4, 
5, 172, 1, 4, 1, 5, 1, 4, 2, 137, 1, 2, 1, 4, 1, 24, 1, 1211, 2, 2, 1, 15, 1, 
4, 1, 14, 1, 113, 1, 16, 2, 4, 1, 205, 1, 2, 11, 20, 1, 4, 1, 12, 5, 4, 1, 
30, 1, 4, 2, 1630, 2, 6, 1, 9, 13, 2, 1, 186, 2, 2, 1, 4, 2, 10, 2, 51, 2, 
10, 1, 10, 1, 4, 5, 12, 1, 12, 1, 11, 2, 2, 1, 4725, 1, 2, 3, 9, 1, 8, 1, 14, 
4, 4, 5, 18, 1, 2, 1, 221, 1, 68, 1, 15, 1, 2, 1, 61, 2, 4, 15, 4, 1, 4, 1, 
19349, 2, 2, 1, 150, 1, 4, 7, 15, 2, 6, 1, 4, 2, 8, 1, 222, 1, 2, 4, 5, 1, 
30, 1, 39, 2, 2, 1, 34, 2, 2, 4, 235, 1, 18, 2, 5, 1, 2, 2, 222, 1, 4, 2, 11, 
1, 6, 1, 42, 13, 4, 1, 15, 1, 10, 1, 42, 1, 10, 2, 4, 1, 2, 1, 11394, 2, 4, 
2, 5, 1, 12, 1, 42, 2, 4, 1, 900, 1, 2, 6, 51, 1, 6, 2, 34, 5, 2, 1, 46, 1, 
4, 2, 11, 1, 30, 1, 196, 2, 6, 1, 10, 1, 2, 15, 199, 1, 4, 1, 4, 2, 2, 1, 
954, 1, 6, 2, 13, 1, 23, 2, 12, 2, 2, 1, 37, 1, 4, 2, 49487365422, 4, 66, 2, 
5, 19, 4, 1, 54, 1, 4, 2, 11, 1, 4, 1, 231, 1, 2, 1, 36, 2, 2, 2, 12, 1, 40, 
1, 4, 51, 4, 2, 1028, 1, 5, 1, 15, 1, 10, 1, 35, 2, 4, 1, 12, 1, 4, 4, 42, 1, 
4, 2, 5, 1, 10, 1, 583, 2, 2, 6, 4, 2, 6, 1, 1681, 6, 4, 1, 77, 1, 2, 2, 15, 
1, 16, 1, 51, 2, 4, 1, 170, 1, 4, 5, 5, 1, 12, 1, 12, 2, 2, 1, 46, 1, 4, 2, 
1092, 1, 8, 1, 5, 14, 2, 2, 39, 1, 4, 2, 4, 1, 254, 1, 42, 2, 2, 1, 41, 1, 2, 
5, 39, 1, 4, 1, 11, 1, 10, 1, 157877, 1, 2, 4, 16, 1, 6, 1, 49, 13, 4, 1, 18, 
1, 4, 1, 53, 1, 32, 1, 5, 1, 2, 2, 279, 1, 4, 2, 11, 1, 4, 3, 235, 2, 2, 1, 
99, 1, 8, 2, 14, 1, 6, 1, 11, 14, 2, 1, 1040, 1, 2, 1, 13, 2, 16, 1, 12, 5, 
27, 1, 12, 1, 2, 69, 1387, 1, 16, 1, 20, 2, 4, 1, 164, 4, 2, 2, 4, 1, 12, 1, 
153, 2, 2, 1, 15, 1, 2, 2, 51, 1, 30, 1, 4, 1, 4, 1, 1460, 1, 55, 4, 5, 1, 
12, 2, 14, 1, 4, 1, 131, 1, 2, 2, 42, 3, 6, 1, 5, 5, 4, 1, 44, 1, 10, 3, 11, 
1, 10, 1, 1116461, 5, 2, 1, 10, 1, 2, 4, 35, 1, 12, 1, 11, 1, 2, 1, 3609, 1, 
4, 2, 50, 1, 24, 1, 12, 2, 2, 1, 18, 1, 6, 2, 244, 1, 18, 1, 9, 2, 2, 1, 181, 
1, 2, 51, 4, 2, 12, 1, 42, 1, 8, 5, 61, 1, 4, 1, 12, 1, 6, 1, 11, 2, 4, 1, 
11720, 1, 2, 1, 5, 1, 112, 1, 52, 1, 2, 2, 12, 1, 4, 4, 245, 1, 4, 1, 9, 5, 
2, 1, 211, 2, 4, 2, 38, 1, 6, 15, 195, 15, 6, 2, 29, 1, 2, 1, 14, 1, 32, 1, 
4, 2, 4, 1, 198, 1, 4, 8, 5, 1, 4, 1, 153, 1, 2, 1, 227, 2, 4, 5, 19324, 1, 
8, 1, 5, 4, 4, 1, 39, 1, 2, 2, 15, 4, 16, 1, 53, 6, 4, 1, 40, 1, 12, 5, 12, 
1, 4, 2, 4, 1, 2, 1, 5958, 1, 4, 5, 12, 2, 6, 1, 14, 4, 10, 1, 40, 1, 2, 2, 
179, 1, 1798, 1, 15, 2, 4, 1, 61, 1, 2, 5, 4, 1, 46, 1, 1387, 1, 6, 2, 36, 2, 
2, 1, 49, 1, 24, 1, 11, 10, 2, 1, 222, 1, 4, 3, 5, 1, 10, 1, 41, 2, 4, 1, 
174, 1, 2, 2, 195, 2, 4, 1, 15, 1, 6, 1, 889, 1, 2, 2, 4, 1, 12, 2, 178, 13, 
2, 1, 15, 4, 4, 1, 12, 1, 20, 1, 4, 5, 4, 1, 408641062, 1, 2, 60, 36, 1, 4, 
1, 15, 2, 2, 1, 46, 1, 16, 1, 54, 1, 24, 2, 5, 2, 4, 1, 221, 1, 4, 1, 11, 1, 
30, 1, 928, 2, 4, 1, 10, 2, 2, 13, 14, 1, 4, 1, 11, 2, 6, 1, 697, 1, 4, 3, 5, 
1, 8, 1, 12, 5, 2, 2, 64, 1, 4, 2, 10281, 1, 10, 1, 5, 1, 4, 1, 54, 1, 8, 2, 
11, 1, 4, 1, 51, 6, 2, 1, 477, 1, 2, 2, 56, 5, 6, 1, 11, 5, 4, 1, 1213, 1, 4, 
2, 5, 1, 72, 1, 68, 2, 2, 1, 12, 1, 2, 13, 42, 1, 38, 1, 9, 2, 2, 2, 137, 1, 
2, 5, 11, 1, 6, 1, 21507, 5, 10, 1, 15, 1, 4, 1, 34, 2, 60, 2, 4, 5, 2, 1, 
1005, 2, 5, 2, 5, 1, 4, 1, 12, 1, 10, 1, 30, 1, 10, 1, 235, 1, 6, 1, 50, 309, 
4, 2, 39, 7, 2, 1, 11, 1, 36, 2, 42, 2, 2, 5, 40, 1, 2, 2, 39, 1, 12, 1, 4, 
3, 2, 1, 47937, 1, 4, 2, 5, 1, 13, 1, 35, 4, 4, 1, 37, 1, 4, 2, 51, 1, 16, 1, 
9, 1, 30, 2, 64, 1, 2, 14, 4, 1, 4, 1, 1285, 1, 2, 1, 228, 1, 2, 5, 53, 1, 8, 
2, 4, 2, 2, 4, 260, 1, 6, 1, 15, 1, 110, 1, 12, 2, 4, 1, 12, 1, 4, 5, 
1083553, 1, 12, 1, 5, 1, 4, 1, 749, 1, 4, 2, 11, 3, 30, 1, 54, 13, 6, 1, 15, 
2, 2, 9, 12, 1, 10, 1, 35, 2, 2, 1, 1264, 2, 4, 6, 5, 1, 18, 1, 14, 2, 4, 1, 
117, 1, 2, 2, 178, 1, 6, 1, 5, 4, 4, 1, 162, 2, 10, 1, 4, 1, 16, 1, 1630, 2, 
2, 2, 56, 1, 10, 15, 15, 1, 4, 1, 4, 2, 12, 1, 1096, 1, 2, 21, 9, 1, 6, 1, 
39, 5, 2, 1, 18, 1, 4, 2, 195, 1, 120, 1, 9, 2, 2, 1, 54, 1, 4, 4, 36, 1, 4, 
1, 186, 2, 2, 1, 36, 1, 6, 15, 12, 1, 8, 1, 4, 5, 4, 1, 241004, 1, 5, 1, 15, 
4, 10, 1, 15, 2, 4, 1, 34, 1, 2, 4, 167, 1, 12, 1, 15, 1, 2, 1, 3973, 1, 4, 
1, 4, 1, 40, 1, 235, 11, 2, 1, 15, 1, 6, 1, 144, 1, 18, 1, 4, 2, 2, 2, 203, 
1, 4, 15, 15, 1, 12, 2, 39, 1, 4, 1, 120, 1, 2, 2, 1388, 1, 6, 1, 13, 4, 4, 
1, 39, 1, 2, 5, 4, 1, 66, 1, 963, 1}

(* GroupCycles *)

GroupCycles[g_]:=Function[r,
	NestWhileList[GroupTimes[#,r]&,GroupIdentity[g[[1]]],UnsameQ,All,Infinity,-1]
]/@g

(* GroupDataString *)

GroupDataString[g_, {s_, name_String}, classes_List: {}, t_: 60] := 
 Module[
  {
   cycles,
   missing = {},
   rules = Thread[g -> Range[Length[g]]],
   subgroups,
   MissingString=Missing["NotAvailable"]
   },
  cycles = TimeConstrained[GroupCycles[g] /. rules, t];
  subgroups = TimeConstrained[Subgroups[g], t];
  "RawFiniteGroupData[" <> ToString[s, InputForm] <> ",\"Name\"]:=\"" <> 
   name <> "\"\r" <>
   StringJoin @@ ("RawFiniteGroupData[" <> ToString[s, InputForm] <> 
        ",\"" <> #[[1]] <> "\"]:=" <> 
        StringReplace[ToString[#[[2]], InputForm], {" " -> "", "MathWorld`Groups`Private`"->""}] <> 
        "\n" & /@
      {
       {"Classes", Union[DeleteCases[Flatten[{classes,
            If[AbelianGroupQ[g], "Abelian"],
            If[ListQ[subgroups] && Length[subgroups] == 2, "Simple", AppendTo[missing, "Simple"];],
            If[TransitiveGroupQ[g], "Transitive"]
            }], Null]]
        },
       {"ConjugacyClasses", ConjugacyClasses[g] /. rules},
       {"Cycles", If[ListQ[cycles], cycles, MissingString]},
       {"CycleIndex", MissingString},
       {"NormalSubgroups", If[ListQ[subgroups], Select[subgroups, NormalSubgroupQ[#, g] &] /. rules, MissingString]},
       {"Order", Length[g]},
       {"Permutations", g},
       {"Subgroups", If[ListQ[subgroups], subgroups /. rules, MissingString]},
       If[missing == {}, 
        Sequence @@ {}, {Alternatives @@ missing /.  Alternatives :> Identity, MissingString}]
       })
  ]

(* Group operations *)

GroupIdentity[m_List?MatrixQ]:=IdentityMatrix[Length[m]]
GroupIdentity[p_List?PermutationQ]:=Range[Length[p]]
GroupIdentity[{r_Integer?Positive,{m_Integer?Positive}}]:={1,{m}}

GroupInverse[m_List?MatrixQ]:=Inverse[m]
GroupInverse[p_List?PermutationQ]:=InversePermutation[p]
GroupInverse[{r_Integer?Positive,{m_Integer?Positive}}]:={PowerMod[r,-1,m],{m}}

GroupMultiplicationTable[g_,rules_:{},opts___]:=Module[
	{
		f=Simplification/.{opts}/.{Simplification->Identity}
	},
	TableForm[(f/@Outer[GroupTimes,g,g,1])/.rules,TableHeadings->{g,g}/.rules]
]

GroupTimes[m__List?MatrixQ]:=Dot[m]
GroupTimes[m__List?PermutationQ]:=Fold[Permute,First[{m}],Rest[{m}]]
GroupTimes[x__List?ModuloQ]:=Module[{m={x}[[1,-1,1]]},
	{Mod[Times@@First/@{x},m],{m}}
]

(* need to be careful; 
Complement[{E^2-2E+1-(E-1)^2},{0},SameTest->Equal] does not return {}
*)

GroupQ[g_,opts___]:=Module[
	{
		f=Simplification/.{opts}/.{Simplification->Identity},
		test
	},
	test=(Equal@@f[{##}]&);
	And@@{
		Complement[Union[Flatten[Outer[GroupTimes,g,g,1],1]],g,SameTest->test]=={},
		And@@Flatten[Outer[Equal@@f/@{
			GroupTimes[GroupTimes[#1,#2],#3],GroupTimes[#1,GroupTimes[#2,#3]]}&,g,g,g,1]],
		Intersection[{GroupIdentity[g[[1]]]},g,SameTest->test]!={},
		Complement[GroupInverse/@g,g,SameTest->test]=={}
	}
]

(* MaximalGroupCycles *)

MaximalGroupCycles[g_]:=Module[
	{
		c=Union[GroupCycles[g]/.Thread[g->Range[Length[g]]],
			SameTest->(Sort[#1]==Sort[#2]&)],
		n
	},
	c[[Position[
		Table[Or@@(SubsetQ[c[[n]],#]&/@Drop[c,{n}]),{n,Length[c]}],
        False]//Flatten
	]]
]

(* Modulo Multiplication Groups *)

ModuloQ[m_]:=Dimensions/@m=={{},{1}}&&IntegerQ[m[[1]]]&&IntegerQ[m[[2,1]]]

ModuloMultiplicationGroup[m_]:={#,{m}}&/@Select[Range[m-1],GCD[#,m]==1&]

ModuloMultiplicationPhi[1]:={}
ModuloMultiplicationPhi[n_]:=Module[
	{
	f=FactorInteger[n],twos,terms
	},
    {twos,terms}=If[f[[1,1]]==2,{f[[1,2]],Rest[f]},{0,f}];
    DeleteCases[Sort[
		Flatten[{
			Switch[twos,
				_?(#<2&),{},
				2,{2},
				_?(#>2&),{2,2^(twos-2)}],
			{Power@@@FactorInteger[#[[1]]-1],#[[1]]^(#[[-1]]-1)}&/@terms
		}]],
	1]
]

(* Normal Subgroup *)

NormalSubgroupQ[h_,g_]:= Equal@@Sort/@Join[Outer[GroupTimes[#1,#2,GroupInverse[#1]]&,g,h,1],{h}]

NormalSubgroups[g_]:=Select[Subgroups[g],NormalSubgroupQ[#,g]&]

(* Number of Abelian Groups *)

NumberOfAbelianGroups[1]:=1
NumberOfAbelianGroups[n_Integer?Positive]:=Module[
	{alpha=Transpose[FactorInteger[n]][[2]]},
	Times@@PartitionsP[alpha]
]

(* Number of Finite Groups *)

(* tabulation *)

NumberOfFiniteGroups[n_Integer?Positive /; n<=Length[FiniteGroupsList]]:=
	FiniteGroupsList[[n]]

(* special case *)

NumberOfFiniteGroups[1]:=1

(* p *)

NumberOfFiniteGroups[p_Integer?PrimeQ]:=1

(* p^2 *)

NumberOfFiniteGroups[p2_Integer]:=2 /; Transpose[FactorInteger[p2]][[2]]==={2}

(* p^3 *)

NumberOfFiniteGroups[p3_Integer]:=5 /; Transpose[FactorInteger[p3]][[2]]==={3}

(* p*q *)

NumberOfFiniteGroups[pq_Integer]:=Module[{p,q},
      {p,q}=Transpose[FactorInteger[pq]][[1]];
      If[Mod[q-1,p]==0,2,1]
] /; Transpose[FactorInteger[pq]][[2]]==={1,1}

(* Squarefree *)

NumberOfFiniteGroups[n_Integer?SquareFreeQ]:=
  Module[{d},
    Plus@@(Function[d,
            Times@@(Function[p,(p^o[p,n/d]-1)/(p-1)]/@Rest[Divisors[d]])]/@
          Divisors[n])
]

o[p_,m_]:=Count[Prime/@Range[PrimePi[m]],_?(Mod[m,#]==0&&Mod[#-1,p]==0&)]  

(* Point Groups *)

PointGroup["I"]:=With[{a=(1+Sqrt[5])/4,b=(-1+Sqrt[5])/4},
{{{-1,0,0},{0,-1,0},{0,0,1}},{{-1,0,0},{0,1,0},{0,0,-1}},
{{-1/2,-a,-b},{-a,b,1/2},{-b,1/2,-a}},{{-1/2,-a,-b},{a,-b,-1/2},{b,-1/2,a}},
{{-1/2,-a,b},{-a,b,-1/2},{b,-1/2,-a}},{{-1/2,-a,b},{a,-b,1/2},{-b,1/2,a}},
{{-1/2,a,-b},{-a,-b,1/2},{b,1/2,a}},{{-1/2,a,-b},{a,b,-1/2},{-b,-1/2,-a}},
{{-1/2,a,b},{-a,-b,-1/2},{-b,-1/2,a}},{{-1/2,a,b},{a,b,1/2},{b,1/2,-a}},
{{0,-1,0},{0,0,-1},{1,0,0}},{{0,-1,0},{0,0,1},{-1,0,0}},{{0,0,-1},{-1,0,0},{0,1,0}},
{{0,0,-1},{1,0,0},{0,-1,0}},{{0,0,1},{-1,0,0},{0,-1,0}},{{0,0,1},{1,0,0},{0,1,0}},
{{0,1,0},{0,0,-1},{-1,0,0}},{{0,1,0},{0,0,1},{1,0,0}},
{{1/2,-a,-b},{-a,-b,-1/2},{b,1/2,-a}},{{1/2,-a,-b},{a,b,1/2},{-b,-1/2,a}},
{{1/2,-a,b},{-a,-b,1/2},{-b,-1/2,-a}},{{1/2,-a,b},{a,b,-1/2},{b,1/2,a}},
{{1/2,a,-b},{-a,b,-1/2},{-b,1/2,a}},{{1/2,a,-b},{a,-b,1/2},{b,-1/2,-a}},
{{1/2,a,b},{-a,b,1/2},{b,-1/2,a}},{{1/2,a,b},{a,-b,-1/2},{-b,1/2,-a}},
{{1,0,0},{0,-1,0},{0,0,-1}},{{1,0,0},{0,1,0},{0,0,1}},
{{-a,-b,-1/2},{-b,-1/2,a},{-1/2,a,b}},{{-a,-b,-1/2},{b,1/2,-a},{1/2,-a,-b}},
{{-a,-b,1/2},{-b,-1/2,-a},{1/2,-a,b}},{{-a,-b,1/2},{b,1/2,a},{-1/2,a,-b}},
{{-a,b,-1/2},{-b,1/2,a},{1/2,a,-b}},{{-a,b,-1/2},{b,-1/2,-a},{-1/2,-a,b}},
{{-a,b,1/2},{-b,1/2,-a},{-1/2,-a,-b}},{{-a,b,1/2},{b,-1/2,a},{1/2,a,b}},
{{-b,-1/2,-a},{-1/2,a,-b},{a,b,-1/2}},{{-b,-1/2,-a},{1/2,-a,b},{-a,-b,1/2}},
{{-b,-1/2,a},{-1/2,a,b},{-a,-b,-1/2}},{{-b,-1/2,a},{1/2,-a,-b},{a,b,1/2}},
{{-b,1/2,-a},{-1/2,-a,-b},{-a,b,1/2}},{{-b,1/2,-a},{1/2,a,b},{a,-b,-1/2}},
{{-b,1/2,a},{-1/2,-a,b},{a,-b,1/2}},{{-b,1/2,a},{1/2,a,-b},{-a,b,-1/2}},
{{b,-1/2,-a},{-1/2,-a,b},{-a,b,-1/2}},{{b,-1/2,-a},{1/2,a,-b},{a,-b,1/2}},
{{b,-1/2,a},{-1/2,-a,-b},{a,-b,-1/2}},{{b,-1/2,a},{1/2,a,b},{-a,b,1/2}},
{{b,1/2,-a},{-1/2,a,b},{a,b,1/2}},{{b,1/2,-a},{1/2,-a,-b},{-a,-b,-1/2}},
{{b,1/2,a},{-1/2,a,-b},{-a,-b,1/2}},{{b,1/2,a},{1/2,-a,b},{a,b,-1/2}},
{{a,-b,-1/2},{-b,1/2,-a},{1/2,a,b}},{{a,-b,-1/2},{b,-1/2,a},{-1/2,-a,-b}},
{{a,-b,1/2},{-b,1/2,a},{-1/2,-a,b}},{{a,-b,1/2},{b,-1/2,-a},{1/2,a,-b}},
{{a,b,-1/2},{-b,-1/2,-a},{-1/2,a,-b}},{{a,b,-1/2},{b,1/2,a},{1/2,-a,b}},
{{a,b,1/2},{-b,-1/2,a},{1/2,-a,-b}},{{a,b,1/2},{b,1/2,-a},{-1/2,a,b}}}
]

PointGroup["Ih"]:=Join[-#,#]&[PointGroup["I"]]

PointGroup["O"]:={{{-1,0,0},{0,-1,0},{0,0,1}},{{-1,0,0},{0,0,-1},{0,-1,0}},{{-1,0,0},{0,0,
      1},{0,1,0}},{{-1,0,0},{0,1,0},{0,0,-1}},{{0,-1,0},{-1,0,0},{0,
      0,-1}},{{0,-1,0},{0,0,-1},{1,0,0}},{{0,-1,0},{0,0,1},{-1,0,0}},{{0,-1,
      0},{1,0,0},{0,0,1}},{{0,0,-1},{-1,0,0},{0,1,0}},{{0,0,-1},{0,-1,0},{-1,
      0,0}},{{0,0,-1},{0,1,0},{1,0,0}},{{0,0,-1},{1,0,0},{0,-1,0}},{{0,0,
      1},{-1,0,0},{0,-1,0}},{{0,0,1},{0,-1,0},{1,0,0}},{{0,0,1},{0,1,0},{-1,0,
      0}},{{0,0,1},{1,0,0},{0,1,0}},{{0,1,0},{-1,0,0},{0,0,1}},{{0,1,0},{0,
      0,-1},{-1,0,0}},{{0,1,0},{0,0,1},{1,0,0}},{{0,1,0},{1,0,0},{0,
      0,-1}},{{1,0,0},{0,-1,0},{0,0,-1}},{{1,0,0},{0,0,-1},{0,1,0}},{{1,0,
      0},{0,0,1},{0,-1,0}},{{1,0,0},{0,1,0},{0,0,1}}}

PointGroup["Oh"]:=Join[-#,#]&[PointGroup["O"]]

PointGroup["T"]:={{{1,0,0},{0,1,0},{0,0,1}},{{-1,0,0},{0,-1,0},{0,0,1}},{{-1,0,0},{0,1,0},{0,0,-1}},{{0,-1,0},{0,
      0,-1},{1,0,0}},{{0,-1,0},{0,0,1},{-1,0,0}},{{0,0,-1},{-1,0,0},{0,1,
      0}},{{0,0,-1},{1,0,0},{0,-1,0}},{{0,0,1},{-1,0,0},{0,-1,0}},{{0,0,1},{1,
      0,0},{0,1,0}},{{0,1,0},{0,0,-1},{-1,0,0}},{{0,1,0},{0,0,1},{1,0,0}},{{1,
      0,0},{0,-1,0},{0,0,-1}}}

PointGroup["Th"]:=Join[-#,#]&[PointGroup["T"]]

PointGroups:=#[[1,1,1]]&/@DownValues[PointGroup]

(* Quadratic Residues *)

QuadraticResidues[1]:=0
QuadraticResidues[2]:=1
QuadraticResidues[m_]:=EulerPhi[m]/2^Length[CharacteristicFactors[m]]

(* RotationMatrix *)

If[$VersionNumber<6,
RotationMatrix[t_]:={{Cos[t],-Sin[t]},{Sin[t],Cos[t]}}
]

(* SimpleGroupQ *)

SimpleGroupQ[g_] := Length[Subgroups[g]]==2

(* Subgroups *)

SubgroupQ[h_,g_,opts___]:=GroupQ[h,opts]&&Complement[h,g]=={}

Subgroups[g_,opts___]:=Flatten[Select[Subsets[g,{#}],GroupQ[#,opts]&]&/@Divisors[Length[g]],1]

SubsetQ[r_,s_]:=Module[{rs=Sort[r]},
	Intersection[rs,s]==rs
]

(** TransitiveGroupQ **)

TransitiveGroupQ[{{1}}]:=True

TransitiveGroupQ[pg_List]:=Module[
	{all=Range[Length[pg[[1]]]]},
    Function[a,Union[Flatten[Position[#,a,{1}]&/@pg]]==all]/@Or@@all
]

End[]

(* Protect[  ] *)

EndPackage[]