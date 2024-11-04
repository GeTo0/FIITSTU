(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.04 *)

(*:Name: MathWorld`Matrices` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Matrices.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-07-12): Written
  v1.01 (2003-07-14): AntihermitianQ, AntisymmetricQ
  v1.02 (2003-10-19): context updated
  v1.03 (2004-01-09): DiagonalizationQ, NormalMatrixQ
  v1.04 (2004-01-15): DiagonalizableQ[m,Field->Reals]
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Matrices`",
	{
	"Utilities`FilterOptions`"
	}
]

AntihermitianQ::usage =
"AntihermitianQ[m] returns True if m is antihermitian."

AntisymmetricQ::usage =
"AntisymmetricQ[m] returns True if m is antisymmetric."

DiagonalizableQ::usage =
"DiagonalizableQ[m] returns True if m is diagonalizable."

Field::usage =
"Field->(Reals|Complexes) specifies what field the elements of the \
diagonalizing matrices of eigenvectors should be taken from."

HermitianQ::usage =
"HermitianQ[m] returns True if m is a Hermitian matrix."

Matrices::usage =
"Matrices[n,{e1,...,em}] gives a list of nxn matrices made out of \
the elements e1, ..., em."

Matrix::usage =
"Matrix[n,k,{e1,...,em}] gives the kth nxn matrices made out of \
the elements e1, ..., em."

Matrix01::usage =
"Matrix01[n,k] gives the kth nxn (0,1)-matrix for 0<=k<=2^(n^2)-1."

Matrix101::usage =
"Matrix101[n,k] gives the kth nxn (-1,0,1)-matrix for 0<=k<=3^(n^2)-1."

NormalMatrixQ::usage =
"NormalMatrixQ[m] returns True if m is a normal matrix."

PositiveDefiniteQ::usage =
"PositiveDefiniteQ[m] returns True if m is positive definite."

PositiveEigenvaluedQ::usage =
"PositiveEigenvaluedQ[m] returns True if m has all positive eigenvalues."

RealDiagonalizableQ::usage =
"RealDiagonalizableQ[m] returns True if m has linearly independent \
real eigenvectors."

SymmetricMatrixQ::usage =
"SymmetricMatrixQ[m] returns True if m is a symmetric matrix."


Options[DiagonalizableQ]={
	Field->Complexes,
	ZeroTest->(RootReduce[#]===0&)
};

Options[NormalMatrixQ]={
	ZeroTest->(#===0&)
};

(* 
For DiagonalizableQ, RootReduce is much faster than the default ZeroTest
for integer matrices.

For NormalMatrixQ, ===0 is much faster than RootReduce for integer matrices.
*)


Begin["`Private`"]

AntihermitianQ[m_List?MatrixQ] := (m === -Conjugate@Transpose@m)

AntisymmetricQ[m_List?MatrixQ] := (m === -Transpose[m])

DiagonalizableQ[m_List?MatrixQ,opts___] :=Module[
	{
	field=Field/.{opts}/.Options[DiagonalizableQ],
	eigenopts=FilterOptions[Eigenvectors,opts]
	},
	Switch[field,
		Complexes,ComplexDiagonalizableQ[m,eigenopts],
		Reals,RealDiagonalizableQ[m,eigenopts]
	]
]

ComplexDiagonalizableQ[m_List?MatrixQ,opts___] :=
	FreeQ[Chop[Eigenvectors[m,opts]],Table[0,{Length[m]}]]

RealDiagonalizableQ[m_List?MatrixQ,opts___]:=Module[
	{
	e=Chop[Eigenvectors[m,opts]],
	zerotest=ZeroTest/.{opts}/.Options[DiagonalizableQ]
	},
	(*
	using RootReduce here is slow, but probably necessary to
	deal properly with Im[root-objects] 
	*)
    ((zerotest/@And@@Flatten[Im[e]])&&FreeQ[e,Table[0,{Length[m]}]])||
      Dimensions[m]==={1,1}
]

HermitianQ[m_List?MatrixQ] := (m === Conjugate@Transpose@m)

Matrices[n_,l_List:{0,1}]:=
  Partition[#,n]&/@Flatten[Outer[List,Sequence@@Table[l,{n^2}]],n^2-1]

Matrix[n_,k_,l_List:{0,1}]:=
  Partition[IntegerDigits[k,Length[l],n^2],n]/.Thread[
      Range[Length[l]]-1->l]

Matrix01[n_,k_]:=Partition[IntegerDigits[k,2,n^2],n]

Matrix101[n_,k_]:=
  Partition[IntegerDigits[k,3,n^2],n]/.Thread[{0,1,2}->{-1,0,1}]

NormalMatrixQ[a_List?MatrixQ,opts___]:=Module[
	{
	b=Conjugate@Transpose@a,
	zerotest=ZeroTest/.{opts}/.Options[NormalMatrixQ]
	},
	(zerotest/@And@@Flatten[a.b-b.a])||Dimensions[a]=={1,1}
]

PositiveDefiniteQ[m_]:=PositiveEigenvaluedQ[m+Transpose[m]]

PositiveEigenvaluedQ[m_]:=Positive/@And@@Eigenvalues[m]

SymmetricMatrixQ[m_List?MatrixQ] := (m === Transpose[m])

End[]

EndPackage[]

(* Protect[  ] *)