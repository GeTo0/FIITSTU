(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.02 *)

(*:Name: MathWorld`Lucas` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Lucas.m
*)

(*:Summary:
*)

(*:History:
  
  v1.00 (2002-11-24): Written
  v1.01 (2003-10-18): updated context
  v1.02 (2005-03-02): PellP[n], PellQ[n]
  
  (c) 2002-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Lucas`"]

ChebyshevT2::usage =
"ChebyshevT2[n,x] gives the nth Chebyshev polynomial of the first kind."

ChebyshevU2::usage =
"ChebyshevU2[n,x] gives the nth Chebyshev polynomial of the second kind."

FermatF::usage =
"FermatF[n,x] gives the nth Fermat polynomial."

Fermatf::usage =
"Fermatf[n,x] gives the nth Fermat-Lucas polynomial."

FibonacciF::usage =
"FibonacciF[n,x] gives the nth Fibonacci polynomial."

JacobsthalJ::usage =
"JacobsthalJ[n,x] gives the nth Jacobsthal polynomial."

Jacobsthalj::usage =
"Jacobsthalj[n,x] gives the nth Jacobsthal-Lucas polynomial."

LucasL::usage =
"LucasL[n,x] gives the nth Lucas polynomial."

LucasW::usage =
"LucasW[{p,q},n,x] gives the nth Lucas W-polynomial."

Lucasw::usage =
"Lucasw[{p,q},n,x] gives the nth Lucas w-polynomial."

PellP::usage =
"PellP[n,x] gives the nth Pell polynomial."

PellQ::usage =
"PellQ[n,x] gives the nth Pell-Lucas polynomial."


Begin["`Private`"]

ChebyshevT2[n_,x_]:=Lucasw[{2x,-1},n,x]

ChebyshevU2[n_,x_]:=LucasW[{2x,-1},n,x]

FermatF[n_,x_]:=LucasW[{3x,-2},n,x]

Fermatf[n_,x_]:=Lucasw[{3x,-2},n,x]

FibonacciF[n_,x_]:=LucasW[{x,1},n,x]

JacobsthalJ[n_,x_]:=LucasW[{1,2x},n,x]

Jacobsthalj[n_,x_]:=Lucasw[{1,2x},n,x]

LucasL[n_,x_]:=Lucasw[{x,1},n,x]

LucasW[{p_,q_},n_,x_]:=Module[
    {
      a=(p+Sqrt[p^2+4q])/2,
      b=(p-Sqrt[p^2+4q])/2
      },
    (a^n-b^n)/(a-b)
]

Lucasw[{p_,q_},n_,x_]:=Module[
    {
      a=(p+Sqrt[p^2+4q])/2,
      b=(p-Sqrt[p^2+4q])/2
      },
    a^n+b^n
]

PellP[n_,x_]:=LucasW[{2x,1},n,x]
(* PellP[n_]:=PellP[n,1] *)
PellP[0]=0;
PellP[1]=1;
PellP[n_] := Module[{a0 = 0, a1 = 1, temp},
	Do[temp = 2a1 + a0; a0 = a1; a1 = temp, {n - 1}];
	temp
]

PellQ[n_,x_]:=Lucasw[{2x,1},n,x]
(* PellQ[n_]:=PellQ[n,1] *)
PellQ[0]=PellQ[1]=2;
PellQ[n_] := Module[{a0 = 2, a1 = 2, temp},
	Do[temp = 2a1 + a0; a0 = a1; a1 = temp, {n - 1}];
	temp
]

End[]

EndPackage[]

(* Protect[  ] *)
