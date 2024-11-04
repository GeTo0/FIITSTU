(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.13 *)

(*:Name: MathWorld`EllipticSingular` *)

(*:Author: Eric Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/EllipticSingular.m
*)

(*:Summary:

This package provides exact expressions for singular values of the 
elliptic integral modulus k_n, the associatied complete elliptic 
functions K[k_n] and E[k_n], as well as various subsidiary functions 
including the Ramanujan g and G functions, alpha[n], delta[n], etc.
*)

(*:History:

  v1.00 (1995-06-10): Written
  v1.10 (1998-05-24): Simplified analytic forms for some k, alpha, g, and G
                      thanks to E. Abramochkin (ega@fian.samara.ru)
  v1.11 (1998-05-25): Corrected syntax for alpha[37], removed erroneous alpha[46]
  v1.12 (2000-01-01): Updated URL
  v1.13 (2003-10-18): updated context
  
  (c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:

  number theory, Ramanujan functions, elliptic integrals, singular values

*)

(*:Requirements: None. *)

(*:Discussion:

Singular values of K from Borwein and Borwein (p. 298).  Values of k and 
alpha from throughout Borwein and Borwein.  The majority of G and g 
functions are from Ramanujan (1912-1913), but some are from Borwein and 
Borwein.

See http://mathworld.wolfram.com/math/EllipticFunction.html et seq.

*)

(*:Limitations:

Need to simplify and fill in missing values.

Need to decide just what constitutes the "simplest" form for expressions:
products of terms containing square roots or expanded form containing only
terms which are a product of an integer and a square root.  Sigh, what to do...

*)


BeginPackage["MathWorld`EllipticSingular`"]


EllipticKSingular::usage =
"EllipticKSingular[n] gives the nth singular value of K."

EllipticKSingularPrime::usage =
"EllipticKSingularPrime[n] gives the nth singular value of K'."

EllipticESingular::usage =
"EllipticESingular[n] gives the nth singular value of E."

EllipticESingularPrime::usage =
"EllipticESingularPrime[n] gives the nth singular value of E'."

g::usage =
"g[n] (n even) gives the analytical value of the Ramanugan g function."

g4::usage =
"g4[n] (where n is a multiple of 4) calculates g[n] from g[n/4]."

go::usage =
"go[n] gives the g function for odd n."

gTok::usage =
"gTok[n] (n even) gives k[n] for g[n] known."

GTok::usage =
"GTok[n] (n odd) gives k[n] for G[n] known."

G::usage =
"G[n] (n odd) gives the analytical value of the Ramanugan G function."

Ge::usage =
"Ge[n] gives the G function for even n."

m::usage =
"m[n] gives the nth singular modulus (=k[n]^2)"

NG::usage =
"NG[n] gives the numerical value of the Ramanujan G function computed 
directly from the infinite product."

Ng::usage =
"Ng[n] gives the numerical value of the Ramanujan g function computed 
directly from the infinite product."


Begin["`Private`"]

(* Ramanujan g and G Functions *)
   
NG[n_]:=N[Product[1+Exp[-Pi (2k-1) Sqrt[n]],
  {k,1,Infinity}]/(2^(1/4) Exp[-Pi Sqrt[n]/24])]
  
Ng[n_]:=N[Product[1-Exp[-Pi (2k-1) Sqrt[n]],
  {k,1,Infinity}]/(2^(1/4) Exp[-Pi Sqrt[n]/24])]
  
Ge[n_]:=2^(-1/8) (g[n]^8+Sqrt[g[n]^(16)+g[n]^(-8)])^(1/8)

go[n_]:=2^(-1/8) (G[n]^8+Sqrt[G[n]^16-G[n]^(-8)])^(1/8)

g4[n_]:=Module[{k=n/4},
  If[EvenQ[k],2^(1/4)g[k]Ge[k],2^(1/4)go[k]G[k]]
]

G[3]:=2^(1/12)
G[5]:=((1+Sqrt[5])/2)^(1/4)
G[7]:=8^(1/12)
G[9]:=((1+Sqrt[3])/Sqrt[2])^(1/3)
G[11]:=(-5/6-2/3/(17+3Sqrt[33])^(1/3)+(17+3Sqrt[33])^(1/3)/3)^(-1/12)
G[13]:=((3+Sqrt[13])/2)^(1/4)
(*G[15]*)
G[17]:=Sqrt[(5+Sqrt[17])/8]+Sqrt[(Sqrt[17]-3)/8]
(*G[19]*)
G[21]:=2^(-1/3)(Sqrt[3]+Sqrt[7])^(1/4)(3+Sqrt[7])^(1/6)
(*G[23]*)
G[25]:=(1+Sqrt[5])/2
G[27]:=2^(1/12)(2^(1/3)-1)^(-1/3)
(*G[29]*)
(*G[31]*)
G[33]:=2^(-1/3)(1+Sqrt[3])^(1/2)(3+Sqrt[11])^(1/6)
(*G[35]*)
G[37]:=(6+Sqrt[37])^(1/4)
(*G[39]*)
(*G[41]*)
(*G[43]*)
G[45]:=(1/4 (Sqrt[5]+2)^3(Sqrt[5]+Sqrt[3])^4)^(1/12)
(*G[47]*)
G[49]:=1/2 (7^(1/4)+Sqrt[4+Sqrt[7]])

g[2]:=1
g[4]:=2^(1/8)
g[6]:=(Sqrt[2]+1)^(1/6)
g[8]:=2^(1/8)(1 + Sqrt[2])^(1/8)
g[10]:=Sqrt[1/2(Sqrt[5]+1)]
g[12]:=2^(1/6)(2+Sqrt[3])^(1/8)
g[14]:=(2+Sqrt[2]+Sqrt[5+4Sqrt[2]])^(1/6)
g[16]:=2^(1/4)*(2 + 3/2^(1/2))^(1/8)
g[18]:=(Sqrt[2]+Sqrt[3])^(1/3)
g[20]:=((1 + 5^(1/2))^(1/4)*(3 + 5^(1/2) + 2*2^(1/2)*(1 + 5^(1/2))^(1/2))^(1/8))/2^(1/4)
g[22]:=Sqrt[1+Sqrt[2]]
g[24]:=2^(1/8)*(1 + 2^(1/2))^(1/6)*((1 + 2^(1/2))^(1/3)*(1 + 2^(1/2) + 6^(1/2)))^(1/8)
(*g[26]*)
g[28]:=2^(1/4)*(8 + 3*7^(1/2))^(1/8)
g[30]:=((2+Sqrt[5])(3+Sqrt[10]))^(1/6)
g[32]:=2^(3/16)*(1+Sqrt[2])^(1/2)*(1+2*Sqrt[2])^(1/8)
g[34]:=Sqrt[(7+Sqrt[17])/8]+Sqrt[(Sqrt[17]-1)/8]
g[36]:=2^(-1/12)*(1+Sqrt[3])^(5/12)*(Sqrt[2]+3^(1/4))^(1/4)
(*g[38]*)
g[40]:=2^(1/8)*(1+Sqrt[2])^(1/4)*(2+Sqrt[5])^(1/12)*(3+Sqrt[10])^(1/8)
g[42]:=(2Sqrt[2]+Sqrt[7])^(1/6)Sqrt[(Sqrt[7]+Sqrt[3])/2]
g[44]:=(2^(1/8)*((-5/6 - 2/(3*(17 + 3*33^(1/2))^(1/3)) + (17 + 3*33^(1/2))^(1/3)/3)^(-2/3) + 
       ((-5/6 - 2/(3*(17 + 3*33^(1/2))^(1/3)) + (17 + 3*33^(1/2))^(1/3)/3)^(-4/3) - 
          (-5/6 - 2/(3*(17 + 3*33^(1/2))^(1/3)) + (17 + 3*33^(1/2))^(1/3)/3)^(2/3))^(1/2))^(1/8))/
          (-5/6 - 2/(3*(17 + 3*33^(1/2))^(1/3)) + (17 + 3*33^(1/2))^(1/3)/3)^(1/12)
g[46]:=(18 + 13*2^(1/2) + (661 + 468*2^(1/2))^(1/2))^(1/6)
g[48]:=2^(5/24)*(1+Sqrt[2])^(1/4)*(Sqrt[2]+Sqrt[3])^(1/4)*(2+Sqrt[3])^(1/16)
(*g[50]*)
g[52]:=2^(-1/4) (3+Sqrt[13])^(1/4)(11+3Sqrt[13]+6Sqrt[2]Sqrt[3+Sqrt[13]])^(1/8)
(*g[54]*)
g[56]:=2^(1/8)*(2 + 2^(1/2) + (5 + 4*2^(1/2))^(1/2))^(1/6)*
   ((2 + 2^(1/2) + (5 + 4*2^(1/2))^(1/2))^(4/3) + 
     (1 + (2 + 2^(1/2) + (5 + 4*2^(1/2))^(1/2))^4)^(1/2)/ 
      (2 + 2^(1/2) + (5 + 4*2^(1/2))^(1/2))^(2/3))^(1/8)
g[58]:=Sqrt[1/2(Sqrt[29]+5)]


(* Singular values of K *)


(* Compute K', E, and E' for singular K(k_n) *)

EllipticKSingularPrime[n_]:=Sqrt[n]EllipticKSingular[n]
EllipticESingular[n_]:=Module[{K=EllipticKSingular[n]},
  Simplify[Pi/4/Sqrt[n]/K+K(1-alpha[n]/Sqrt[n])]
]
EllipticESingularPrime[n_]:=Module[{K=EllipticKSingular[n]},
  Simplify[Pi/4/K+alpha[n]K]
]


(* Compute k given the corresponding value of g or G *)

GTok[n_]:=1/2(Sqrt[1+G[n]^(-12)]-Sqrt[1-G[n]^(-12)])
gTok[n_]:=g[n]^6(Sqrt[g[n]^12+g[n]^(-12)]-g[n]^6)


End[]

(*
Protect[ alpha, delta, EllipticKSingular, EllipticKSingularPrime, EllipticKSingularPrime,
  EllipticESingular, EllipticESingularPrime, EllipticESingularPrime, g, g4, go,
  gTok, G, Ge, GTok, k, m, NG, Ng ]
*)

EndPackage[]