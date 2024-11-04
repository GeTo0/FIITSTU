(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`Norm` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Norm.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-02-20): Written
  v1.01 (2003-10-18): Modified now that Norm is built in to
                      v5.  Updated context.
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Norm`"]

(*
Norm::usage=
"Norm[v] gives the norm Sqrt[v.v] of the specified n-vector.  \
Norm[v1,v2] gives the norm of the vector difference."
*)

Norm2::usage=
"Norm2[v] gives the squared norm v.v of the specified n-vector.  \
Norm2[v1,v2] gives the squared norm of the vector difference."

Unit::usage=
"Unit[v] gives the unit vector v/|v|.  \
Unit[v1,v2] gives the unit vector (v2-v1)/|(v2-v1)|."


Begin["`Private`"]

Norm2[v_List?VectorQ]:=v.v
Norm2[v1_List?VectorQ,v2_List?VectorQ]:=Norm2[v1-v2] /;
	Length[v1]==Length[v2]

Unprotect[Norm];
Norm[v1_List?VectorQ,v2_List?VectorQ]:=Norm[v1-v2] /;
	Length[v1]==Length[v2]
Protect[Norm];

Unit[v_List?VectorQ]:=v/Sqrt[v.v]
Unit[v1_List?VectorQ,v2_List?VectorQ]:=Unit[v2-v1] /;
	Length[v1]==Length[v2]

End[]

EndPackage[]

(* Protect[  ] *)