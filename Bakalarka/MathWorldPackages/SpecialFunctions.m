(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.50 *)

(*:Name: MathWorld`SpecialFunctions` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/SpecialFunctions.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-12-18): Written by Eric W. Weisstein
  v1.01 (2004-01-06): DirichletBeta, DirichletEta
  v1.02 (2004-01-14): HankelH moved here, ClausenCl
  v1.03 (2004-01-17): LegendreChi
  v1.04 (2004-01-20): Moved elliptic and Q-stuff here
  v1.05 (2004-01-29): EllipticExpand
  v1.06 (2004-02-04): JFunction
  v1.07 (2004-04-20): LucasL
  v1.08 (2004-05-19): SphericalBesselI, J, K, Y, SphericalHankelH
  v1.10 (2004-05-20): AiryGi, AiryHi, BarnesG, Bei, Ber,
                      DawsonD, DirichletLambda, GFunction, 
                      Gudermannian, Jinc, Kei, Ker, KFunction,
                      InverseTangentIntegralT, ParabolicCylinderD,
                      PrimeZeta, Sinc, Sinhc, Tanc, XiFunction
  v1.11 (2004-06-01): Bei, Ber, Kei, Ker extended to nonzero parameter
  v1.12 (2004-07-28): added rule for EllipticE to EllipticSimplify
  v1.20 (2004-09-09): Remove ?NumericQ pattern and replace TraditionalForm
                      formatting rules with MyTraditionalForm
  v1.21 (2004-09-27): FallingFactorial, RisingFactorial
  v1.22 (2005-01-12): LSeries
  v1.23 (2005-02-03): RampFunction
  v1.24 (2005-02-24): CentralBinomial, CentralTrinomial, Trinomial,
                      Fixed ClausenCl
  v1.25 (2005-03-04): Extended QSeries notation
  v1.26 (2005-04-22): Tanhc
  v1.27 (2005-09-13): Coversine, etc.
  v1.28 (2005-09-15): InverseGudermannian
  v1.29 (2005-10-13): SphericalHankel[n,x] -> SphericalHankel1[x],
                      SphericalBesselN -> SphericalBesselY
  v1.30 (2005-10-19): Flipped even/odd cases of ClausenCl
  v1.31 (2005-11-07): Primorial
  v1.32 (2006-01-04): GramPoint
  v1.33 (2006-01-25): renamed HankelH1, HankelH2, Kelvin*
  v1.34 (2006-02-04): Fast LucasL
  v1.35 (2006-03-16): Cis
  v1.36 (2005-03-30): Restricted DirichletL
  v1.37 (2005-04-20): Fixed sign and multiplier for DirichletL
  v1.38 (2006-05-05): LucasL has moved
  v1.39 (2006-06-01): Attach typeset rules to symbols using TagSetDelayed /: instead of to
                      MakeBoxes
  v1.40 (2006-06-20): Check version number for new fuctions
  v1.50 (2007-09-22): Updated for V6.1
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: 

Need to add EllipticE singular values to EllipticExpand

*)

BeginPackage["MathWorld`SpecialFunctions`"]

AiryGi::usage =
"AiryGi[z] gives the Airy Gi-function."

AiryHi::usage =
"AiryHi[z] gives the Airy Hi-function."

BranchCuts::usage =
"BranchCuts[f] gives a list of Mathematica's branch cuts for the \
function f."

CentralBinomial::usage =
"CentralBinomial[n] gives the nth central binomial coefficient."

CentralTrinomial::usage =
"CentralTrinomial[n] gives the nth central trinomial coefficient."

Cis::usage =
"Cis[z] gives Exp[I z]."

ClausenCl::usage =
"ClausenCl[n,x] gives the Clausen function of order n."

Coversine::usage =
"Coversine[x] gives the coversine function."

DawsonD::usage =
"DawsonD[k,z] gives Dawson's integral for k=-/+1."

DirichletBeta::usage =
"DirichletBeta[x] gives the Dirichlet beta function."

DirichletEta::usage =
"DirichletEta[x] gives the Dirichlet eta function."

DirichletLambda::usage =
"DirichletLambda[x] gives the Dirichlet lambda function."

EllipticAlpha::usage =
"EllipticAlpha[n] gives the elliptic alpha function for the nth singular value.  \
This relates E(k_n) and E'(k_n) to K(k_n)."

EllipticDelta::usage =
"EllipticDelta[n] gives the elliptic delta function, which is related to the \
EllipticAlpha function by alpha[n]=1/2(Sqrt[n]-EllipticDelta[n])."

EllipticExpand::usage =
"EllipticExpand[expr] replaces any occurrences of EllipticK[m_k] in which m_k is a \
singular value with exact analytic expressions in terms of algebraic numbers, Pi, and \
Gamma functions."

EllipticLambda::usage =
"EllipticLambda[n] gives the nth singular value of the parameter k.  This is the value \
such that EllipticK[1-k^2]/EllipticK[k] = Sqrt[n]."

EllipticSimplify::usage =
"EllipticSimplify[expr] transforms EllipticF to EllipticK where possible using a particular \
transformation rule."

Exsecant::usage =
"Exsecant[x] gives the exsecant function."

FallingFactorial::usage =
"FallingFactorial[x,n] gives the nth falling factorial on n."

GFunction::usage =
"GFunction[z] gives the G-function of Erdelyi."

GramPoint::usage =
"GramPoint[n] gives the nth Gram point.  Options may be specified using any valid \
FindRoot options."

Gudermannian::usage =
"Gudermannian[z] gives the Gudermannian of z."

HalfClosedInterval::usage =
"HalfClosedInterval[{a,b}] represents the half-open interval [a,b)."

HalfOpenInterval::usage =
"HalfOpenInterval[{a,b}] represents the half-open interval (a,b]."

HankelH1::usage = 
"HankelH1[n,z] gives the Hankel function of the 1st kind of nth \
order with argument z."

HankelH2::usage = 
"HankelH2[n,z] gives the Hankel function of the 2nd kind of nth \
order with argument z."

Haversine::usage =
"Haversine[x] gives the haversine function."

InverseGudermannian::usage =
"InverseGudermannian[z] gives the inverse Gudermannian of z."

InverseTangentIntegralT::usage =
"InverseTangentIntegralT[z] gives the inverse tangent integral T_2(z)."

JFunction::usage =
"JFunction[tau] gives a normalized form of KleinInvariantJ[tau].  To express \
tau in terms of q, use q=Exp[I Pi tau], i.e., tau = -I Log[q]/Pi."

Jinc::usage =
"Jinc[z] gives the jinc function BesselJ[1,z]/z."

KelvinBei::usage =
"KelvinBei[nu,z] gives the Kelvin function bei of order nu evaluated at z."

KelvinBer::usage =
"KelvinBer[nu,z] gives the Kelvin function ber of order nu evaluated at z."

KelvinKei::usage =
"KelvinKei[nu,z] gives the Kelvin function kei of order nu evaluated at z."

KelvinKer::usage =
"KelvinKer[nu,z] gives the Kelvin function ker of order nu evaluated at z."

KFunction::usage =
"KFunction[z] gives the K-function."

LegendreChi::usage =
"LegendreChi[n,z] gives the Legendre chi function of order n."

LSeries::usage =
"LSeries[d,s] gives the Dirichlet L-series L_d[s]."

MyTraditionalForm::usage =
"MyTraditionalForm formats a non-builtin special function without evaluating it.  \
If no MakeBoxes rule is explicitly defined for a given expression, MyTraditionalForm \
reverts to TraditionalForm."

OpenInterval::usage =
"OpenInterval[{a,b}] represents the open interval (a,b)."

PrimeZeta::usage =
"PrimeZeta[n] gives the nth prime zeta function."

PrimitiveQ::usage =
"PrimitiveQ[d] returns True if LSeries[d,n] is a primitive L-series."

Primorial::usage =
"Primorial[n] gives the primorial function."

RampFunction::usage =
"RampFunction[x] gives the ramp function."

RisingFactorial::usage =
"RisingFactorial[x,n] gives the nth rising factorial on n, \
a.k.a., Pochammer."

Sinhc::usage =
"Sinhc[z] gives the function Sinh[z]/z."

SingularValue::usage =
"EllipticK[SingularValue[n]] gives EllipticK[EllipticLambda[n]^2]."

SphericalBesselI::usage =
"SphericalBesselI[n,z] gives the modified spherical Bessel function of \
the first kind i_n(z)."

SphericalBesselK::usage =
"SphericalBesselK[n,z] gives the modified spherical Bessel function of \
the second kind k_n(z)."

Tanc::usage =
"Tanc[z] gives the function Tan[z]/z."

Tanhc::usage =
"Tanhc[z] gives the function Tanh[z]/z."

ToFallingFactorial::usage =
"ToFallingFactorial[expr] gives expr with Pochhammers expressed in terms of corresponding \
falling factorials."

Trinomial::usage =
"Trinomial[n,k] gives the trinomial coefficient."

Versine::usage =
"Versine[x] gives the versine function."

XiFunction::usage =
"XiFunction[z] gives the xi-function."


(*SetAttributes[MyTraditionalForm,HoldAll];*)
SetAttributes[{CentralBinomial,CentralTrinomial,DirichletBeta},Listable];

Options[GramPoint]:={
};

Begin["`Private`"]

(*** Typeset Rules ***)

(*
MyTraditionalForm[x_]:=ToBoxes[x,TraditionalForm]//DisplayForm
*)

(* Intervals *)

OpenInterval /; MakeBoxes[OpenInterval[{a_,b_}],TraditionalForm]:=
  RowBox[{"(",MakeBoxes[a,TraditionalForm],",",MakeBoxes[b,TraditionalForm],")"}]
OpenInterval /; MakeBoxes[Interval[{a_,b_}],TraditionalForm]:=
  RowBox[{"[",MakeBoxes[a,TraditionalForm],",",MakeBoxes[b,TraditionalForm],"]"}]
OpenInterval /; MakeBoxes[HalfOpenInterval[{a_,b_}],TraditionalForm]:=
  RowBox[{"(",MakeBoxes[a,TraditionalForm],",",MakeBoxes[b,TraditionalForm],"]"}]
OpenInterval /; MakeBoxes[HalfClosedInterval[{a_,b_}],TraditionalForm]:=
  RowBox[{"[",MakeBoxes[a,TraditionalForm],",",MakeBoxes[b,TraditionalForm],")"}]

(* Functions *)

AiryGi /: MakeBoxes[AiryGi[z_],TraditionalForm]:=
  RowBox[{"Gi","(",MakeBoxes[z,TraditionalForm],")"}]
  
AiryHi /: MakeBoxes[AiryHi[z_],TraditionalForm]:=
  RowBox[{"Hi","(",MakeBoxes[z,TraditionalForm],")"}]

Cis /: MakeBoxes[Cis[z_],TraditionalForm]:=
  RowBox[{"Cis","(",MakeBoxes[z,TraditionalForm],")"}]

ClausenCl /: MakeBoxes[ClausenCl[n_,z_],TraditionalForm]:=
	RowBox[{SubscriptBox["Cl", MakeBoxes[n,TraditionalForm]],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

Coversine /: MakeBoxes[Coversine[z_],TraditionalForm]:=
  RowBox[{"covers","(",MakeBoxes[z,TraditionalForm],")"}]

DawsonD /: MakeBoxes[DawsonD[-1,z_],TraditionalForm]:=
	RowBox[{SubscriptBox["D", "-"],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

DawsonD /: MakeBoxes[DawsonD[1,z_],TraditionalForm]:=
	RowBox[{SubscriptBox["D", "+"],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

DirichletBeta /: MakeBoxes[DirichletBeta[z_],TraditionalForm]:=
  RowBox[{"\[Beta]","(",MakeBoxes[z,TraditionalForm],")"}]

DirichletEta /: MakeBoxes[DirichletEta[z_],TraditionalForm]:=
  RowBox[{"\[Eta]","(",MakeBoxes[z,TraditionalForm],")"}]

DirichletLambda /: MakeBoxes[DirichletLambda[z_],TraditionalForm]:=
  RowBox[{"\[Lambda]","(",MakeBoxes[z,TraditionalForm],")"}]

Exsecant /: MakeBoxes[Exsecant[z_],TraditionalForm]:=
  RowBox[{"exsec","(",MakeBoxes[z,TraditionalForm],")"}]

FallingFactorial /: MakeBoxes[FallingFactorial[x_,n_],TraditionalForm]:=
  SubscriptBox[RowBox[{"(",MakeBoxes[x,TraditionalForm],")"}],
    MakeBoxes[n,TraditionalForm]]

Gudermannian /: MakeBoxes[Gudermannian[z_],TraditionalForm]:=
  RowBox[{"gd","(",MakeBoxes[z,TraditionalForm],")"}]

Haversine /: MakeBoxes[Haversine[z_],TraditionalForm]:=
  RowBox[{"hav","(",MakeBoxes[z,TraditionalForm],")"}]

InverseGudermannian /: MakeBoxes[InverseGudermannian[z_],TraditionalForm]:=
  RowBox[{SuperscriptBox["gd", 
          RowBox[{"-", "1"}]],"(",MakeBoxes[z,TraditionalForm],")"}]

InverseTangentIntegralT /: MakeBoxes[InverseTangentIntegralT[z_],TraditionalForm]:=
	RowBox[{SubscriptBox["T", "2"],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

JFunction /: MakeBoxes[JFunction[z_],TraditionalForm]:=
  RowBox[{"j","(",MakeBoxes[z,TraditionalForm],")"}]

Jinc /: MakeBoxes[Jinc[z_],TraditionalForm]:=
  RowBox[{"jinc","(",MakeBoxes[z,TraditionalForm],")"}]

KFunction /: MakeBoxes[KFunction[z_],TraditionalForm]:=
  RowBox[{"K","(",MakeBoxes[z,TraditionalForm],")"}]

PrimeZeta /: MakeBoxes[PrimeZeta[z_],TraditionalForm]:=
  RowBox[{"P","(",MakeBoxes[z,TraditionalForm],")"}]

MakeBoxes[Round[z_],TraditionalForm]:=
  RowBox[{"nint","(",MakeBoxes[z,TraditionalForm],")"}]

Sinhc /: MakeBoxes[Sinhc[z_],TraditionalForm]:=
  RowBox[{"sinhc","(",MakeBoxes[z,TraditionalForm],")"}]

SphericalBesselI /: MakeBoxes[SphericalBesselI[n_,z_],TraditionalForm]:=
	RowBox[{SubscriptBox["i", MakeBoxes[n,TraditionalForm]],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

SphericalBesselK /: MakeBoxes[SphericalBesselK[n_,z_],TraditionalForm]:=
	RowBox[{SubscriptBox["k", MakeBoxes[n,TraditionalForm]],
	 "(", " ", MakeBoxes[z,TraditionalForm], ")"}]

Tanc /: MakeBoxes[Tanc[z_],TraditionalForm]:=
  RowBox[{"tanc","(",MakeBoxes[z,TraditionalForm],")"}]

Tanhc /: MakeBoxes[Tanhc[z_],TraditionalForm]:=
  RowBox[{"tanhc","(",MakeBoxes[z,TraditionalForm],")"}]

Versine /: MakeBoxes[Versine[z_],TraditionalForm]:=
  RowBox[{"vers","(",MakeBoxes[z,TraditionalForm],")"}]

XiFunction /: MakeBoxes[XiFunction[z_],TraditionalForm]:=
  RowBox[{"\[Xi]","(",MakeBoxes[z,TraditionalForm],")"}]


(*** Functions ***)

(* Airy *)

AiryGi[z_]:=AiryBi[z]/3 -
	z^2 HypergeometricPFQ[{1}, {2/3, 5/6, 7/6, 4/3}, z^6/1296]/(2Pi) - 
	z^5 HypergeometricPFQ[{1}, {7/6, 4/3, 5/3, 11/6}, z^6/1296]/(40Pi)

AiryHi[z_,opts___]:=2AiryBi[z]/3 - 
	z^2 HypergeometricPFQ[{1}, {4/3, 5/3}, z^3/9]/(2Pi)

(* Branch Cuts *)

BranchCuts[ArcCos]:={OpenInterval[{-Infinity,-1}],OpenInterval[{1,Infinity}]}
BranchCuts[ArcCosh]:={OpenInterval[{-Infinity,1}]}
BranchCuts[ArcCot]:={OpenInterval[{-I,I}]}
BranchCuts[ArcCoth]:={Interval[{-1,1}]}
BranchCuts[ArcCsc]:={OpenInterval[{-1,1}]}
BranchCuts[ArcCsch]:={OpenInterval[{-I,I}]}
BranchCuts[Log]:={HalfOpenInterval[{-Infinity,0}]}
BranchCuts[ArcSec]:={OpenInterval[{-1,1}]}
BranchCuts[ArcSech]:={HalfOpenInterval[{-Infinity,0}],OpenInterval[{1,Infinity}]}
BranchCuts[ArcSin]:={OpenInterval[{-Infinity,-1}],OpenInterval[{1,Infinity}]}
BranchCuts[ArcSinh]:={OpenInterval[{-I Infinity,-I}],OpenInterval[{I,I Infinity}]}
BranchCuts[Sqrt]:={OpenInterval[{-Infinity,0}]}
BranchCuts[ArcTan]:={HalfOpenInterval[{-I Infinity,-I}],HalfClosedInterval[{I,I Infinity}]}
BranchCuts[ArcTanh]:={HalfOpenInterval[{-Infinity,-1}],HalfClosedInterval[{1,Infinity}]}

(* Central Binomial *)

CentralBinomial[n_]:=Binomial[2n,n]

(* Central Trinomial *)

CentralTrinomial[n_]:=(-1)^n GegenbauerC[n,-n,1/2]

(* Cis *)

Cis[z_]:=Exp[I z]

(* ClausenCl *)

ClausenCl[n_Integer?OddQ,x_]:=(PolyLog[n, E^(-I x)] + PolyLog[n, E^(I x)])/2
ClausenCl[n_Integer?EvenQ,x_] :=(PolyLog[n, E^(-I x)] - PolyLog[n, E^(I x)])I/2

(* Coversine *)

Coversine[x_]:=1-Sin[x]

(* DawsonD *)

DawsonD[ 1, x_] := Sqrt[Pi]Erfi[x]Exp[-x^2]/2
DawsonD[-1, x_] := Sqrt[Pi]Erf[x]Exp[x^2]/2

(* DirichletBeta *)

DirichletBeta[1]:=Pi/4
DirichletBeta[x_]:=(1/4^x)(Zeta[x,1/4]-Zeta[x,3/4])

(* DirichletEta *)

DirichletEta[x_]:=(1-2^(1-x))Zeta[x]

(* DirichletLambda *)

DirichletLambda[x_]:=(1-2^(-x))Zeta[x]

(* Elliptic Alpha *)

EllipticAlpha[1] :=1/Sqrt[2]
EllipticAlpha[2] :=-1+Sqrt[2]
EllipticAlpha[3] :=Root[1-16#1^2+16#1^4&,3]
EllipticAlpha[4] :=3-2Sqrt[2]
EllipticAlpha[5] :=Root[1-72#1^2+88#1^4-32#1^6+16#1^8&,3]
EllipticAlpha[6] :=Root[1-12#1+2#1^2+12#1^3+#1^4&,3]
EllipticAlpha[7] :=Root[1-256#1^2+256#1^4&,3]
EllipticAlpha[8] :=Root[1-20#1-26#1^2-20#1^3+#1^4&,1]
EllipticAlpha[9] :=Root[1-776#1^2+792#1^4-32#1^6+16#1^8&,3]
EllipticAlpha[10]:=Root[1-36#1+2#1^2+36#1^3+#1^4&,3]
EllipticAlpha[11]:=Root[1-2096#1^2+2864#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticAlpha[12]:=Root[1-60#1+134#1^2-60#1^3+#1^4&,1]
EllipticAlpha[13]:=Root[1-5192#1^2+5208#1^4-32#1^6+16#1^8&,3]
EllipticAlpha[14]:=Root[1-88#1-108#1^2-88#1^3+230#1^4+88#1^5-108#1^6+88#1^7+#1^8&,3]
EllipticAlpha[15]:=Root[1-12032#1^2+77568#1^4-131072#1^6+65536#1^8&,5]
EllipticAlpha[16]:=Root[1-132#1-250#1^2-132#1^3+#1^4&,1]
EllipticAlpha[17]:=Root[1-26384#1^2-24720#1^4-319936#1^6+1215584#1^8-1267456#1^10+423680#1^12-1024#1^14+256#1^16&,3]
EllipticAlpha[18]:=Root[1-196#1+2#1^2+196#1^3+#1^4&,3]
EllipticAlpha[19]:=Root[1-55344#1^2+56112#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticAlpha[20]:=Root[1-280#1-292#1^2-680#1^3+2758#1^4-680#1^5-292#1^6-280#1^7+#1^8&,1]
EllipticAlpha[21]:=Root[1-111760#1^2+1337584#1^4-4239808#1^6+6590560#1^8-5365504#1^10+1789696#1^12-1024#1^14+256#1^16&,5]
EllipticAlpha[22]:=Root[1-396#1+2#1^2+396#1^3+#1^4&,3]
EllipticAlpha[23]:=Root[1-218368#1^2-1223424#1^4-13893632#1^6+48889856#1^8-50331648#1^10+16777216#1^12&,3]
EllipticAlpha[24]:=Root[1-552#1+1372#1^2+1512#1^3-570#1^4+1512#1^5+1372#1^6-552#1^7+#1^8&,1]
EllipticAlpha[25]:=Root[1-414728#1^2+414744#1^4-32#1^6+16#1^8&,3]
EllipticAlpha[26]:=Root[1-748#1-3274#1^2-9988#1^3+15#1^4+21736#1^5+6580#1^6-21736#1^7+15#1^8+9988#1^9-3274#1^10+748#1^11+#1^12&,3]
EllipticAlpha[27]:=Root[1-768048#1^2+768816#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticAlpha[28]:=Root[1-1020#1+2054#1^2-1020#1^3+#1^4&,1]

(*
EllipticAlpha[1]:=1/2 
EllipticAlpha[2]:=Sqrt[2]-1
EllipticAlpha[3]:=1/2 (Sqrt[3]-1)
EllipticAlpha[4]:=2(Sqrt[2]-1)^2
EllipticAlpha[5]:=1/2 (Sqrt[5]-Sqrt[2Sqrt[5]-2])
EllipticAlpha[6]:=5Sqrt[6]+6Sqrt[3]-8Sqrt[2]-11
  (* (Sqrt[2]+1)*(3-Sqrt[2])*(Sqrt[3]-Sqrt[2])*(2-Sqrt[3]) *)	(* ega *)
  (* (1+2Sqrt[2])k[6] *)										(* ega *)
EllipticAlpha[7]:=1/2 (Sqrt[7]-2)
EllipticAlpha[8]:=2(10+7Sqrt[2])(1-Sqrt[Sqrt[8]-2])^2
EllipticAlpha[9]:=1/2 (3-3^(3/4)Sqrt[2](Sqrt[3]-1))
EllipticAlpha[10]:=-103+72 Sqrt[2]-46Sqrt[5]+33 Sqrt[10]
  (* (Sqrt[2]-1)^2*(Sqrt[10]-3)*(7+2*Sqrt[5]) *)				(* ega *)
  (* (7+2Sqrt[5])k[10] *)										(* ega *)
(* EllipticAlpha[11]:=1/2(Sqrt[11]-(2x^2-(x-3/2)-Sqrt[11]Sqrt[1-(x-3/2)^2])/3) /. {x-> 2/3 - 2 2^(1/3)/3/(34+6Sqrt[33])^(1/3)+(34+6Sqrt[33])^(1/3)/3/2^(1/3)}
WRONG p. 162 *)
EllipticAlpha[12]:=264+154Sqrt[3]-188Sqrt[2]-108Sqrt[6]
  (* 2*(Sqrt[2]-1)^2*(Sqrt[3]-Sqrt[2])^2*(4+3*Sqrt[3]) *)		(* ega *)
  (* 2(4+3Sqrt[3])k[12] *)										(* ega *)
EllipticAlpha[13]:=1/2(Sqrt[13]-Sqrt[74Sqrt[13]-258])
EllipticAlpha[15]:=1/2(Sqrt[15]-Sqrt[5]-1)
EllipticAlpha[16]:=4((Sqrt[8]-1)/(2^(1/4)+1)^4)
EllipticAlpha[18]:=-3057+2163Sqrt[2]+1764Sqrt[3]-1248Sqrt[6]
  (* 3*(Sqrt[2]-1)^3*(2-Sqrt[3])^2*(2*Sqrt[2]+Sqrt[3])^2 *)		(* ega *)
  (* 3(11+4Sqrt[6])k[18] *)										(* ega *)
EllipticAlpha[22]:=-12479 - 8824Sqrt[2] + 3762Sqrt[11] + 2661Sqrt[22]
  (* (3*Sqrt[11]-7*Sqrt[2])*(10-3*Sqrt[11])*(61+46*Sqrt[2]) *)	(* ega *)
  (* (61+46Sqrt[2])k[22] *)										(* ega *)
EllipticAlpha[25]:=5/2(1-2 5^(1/4)(7-3Sqrt[5]))
EllipticAlpha[27]:=3(1/2 (Sqrt[3]+1)-2^(1/3))
EllipticAlpha[30]:=(30^(1/2) - (2 + 5^(1/2))^2*(3 + 10^(1/2))^2*
     (-6 - 5*2^(1/2) - 3*5^(1/2) - 2*10^(1/2) + 6^(1/2)*(57 + 40*2^(1/2))^(1/2))*
     (56 + 38*2^(1/2) + 30^(1/2)*(2 + 5^(1/2))*(3 + 10^(1/2))))/2
     (* (107+76Sqrt[2]+50Sqrt[5]+34Sqrt[10])k[30] *)			(* ega *)
EllipticAlpha[37]:=1/2 (Sqrt[37]-(171-25Sqrt[37])Sqrt[Sqrt[37]-6])
EllipticAlpha[49]:=7/2 -Sqrt[7(Sqrt[2]7^(3/4)(33011+12477Sqrt[7])-21(9567+3616Sqrt[7]))]
EllipticAlpha[58]:=3 (-40768961 + 28828008Sqrt[2] - 7570606Sqrt[29] + 5353227Sqrt[58])
  (* (Sqrt[2]-1)^6*(4*Sqrt[2]-Sqrt[29])^2
          *(Sqrt[58]-7)*(2081+386*Sqrt[29])/9 *)	(* ega *)
  (* 3(2081+386Sqrt[29])k[58] *)					(* ega *)
EllipticAlpha[64]:=(8(2(Sqrt[8]-1)-(2^(1/4)-1)^4)/(Sqrt[Sqrt[2]+1]+2^(5/8))^4)
EllipticAlpha[81]:=9/2(1-Sqrt[2] 3^(1/4)(Sqrt[3]+1)(3+a)/a) /. a->((2+Sqrt[12])^(1/3)+1)^2
*)

(* EllipticDelta *)

EllipticDelta[r_]:=Sqrt[r]-2EllipticAlpha[r]

(* EllipticExpand *)

EllipticExpand[expr_] := Module[
	{sv = ReleaseHold[First /@ DownValues[EllipticLambda] /. EllipticLambda[n_] :> n]},
    expr /. EllipticK[m_] :> Switch[RootReduce[Sqrt[m]],
          Evaluate[Sequence @@ Flatten[Transpose[{EllipticLambda /@ sv, EllipticK /@ SingularValue /@ sv}]]],
          _, EllipticK[m]]
    ]

(* EllipticK *)

Unprotect[EllipticK];

EllipticK[SingularValue[1]]:=Gamma[1/4]^2/4/Sqrt[Pi]
EllipticK[SingularValue[2]]:=Sqrt[Sqrt[2]+1]Gamma[1/8]Gamma[3/8]/2^(13/4)/Sqrt[Pi]
EllipticK[SingularValue[3]]:=3^(1/4)Gamma[1/3]^3/2^(7/3)/Pi
EllipticK[SingularValue[4]]:=(Sqrt[2]+1)Gamma[1/4]^2/2^(7/2)/Sqrt[Pi]
EllipticK[SingularValue[5]]:=(Sqrt[5]+2)^(1/4) Sqrt[Gamma[1/20]Gamma[3/20]Gamma[7/20]Gamma[9/20]/
  160/Pi]
EllipticK[SingularValue[6]]:=Sqrt[(Sqrt[2]-1)(Sqrt[3]+Sqrt[2])(2+Sqrt[3])Gamma[1/24]Gamma[5/24]*
  Gamma[7/24]Gamma[11/24]/384/Pi]
EllipticK[SingularValue[7]]:=Gamma[1/7]Gamma[2/7]Gamma[4/7]/7^(1/4)/4/Pi
EllipticK[SingularValue[8]]:=Sqrt[(2Sqrt[2]+Sqrt[1+5Sqrt[2]])/4/Sqrt[2]](Sqrt[2]+1)^(1/4) Gamma[1/8]*
  Gamma[3/8]/8/Sqrt[Pi]  
EllipticK[SingularValue[9]]:=3^(1/4)Sqrt[2+Sqrt[3]]/12/Sqrt[Pi]Gamma[1/4]^2
EllipticK[SingularValue[10]]:=Sqrt[(2+3Sqrt[2]+Sqrt[5])Gamma[1/40]Gamma[7/40]Gamma[9/40]Gamma[11/40]*
  Gamma[13/40]Gamma[19/40]Gamma[23/40]Gamma[37/40]/2560/Pi^3]
EllipticK[SingularValue[11]]:=(2+(17+3Sqrt[33])^(1/3)-(3Sqrt[33]-17)^(1/3))^2 Gamma[1/11]Gamma[3/11]*
  Gamma[4/11]Gamma[5/11]Gamma[9/11]/11^(1/4)/144/Pi^2
EllipticK[SingularValue[12]]:=(Sqrt[2]+1)(Sqrt[3]+Sqrt[2])Sqrt[2-Sqrt[3]]3^(1/4)Gamma[1/3]^3/2^(13/3)/Pi
EllipticK[SingularValue[13]]:=(18+5Sqrt[13])^(1/4) Sqrt[Gamma[1/52]Gamma[7/52]Gamma[9/52]Gamma[11/52]*
  Gamma[15/52]Gamma[17/52]Gamma[19/52]Gamma[25/52]Gamma[29/52]Gamma[31/52]Gamma[47/52]*
  Gamma[49/52]/6656/Pi^5] 
EllipticK[SingularValue[14]]:=Sqrt[Sqrt[4Sqrt[2]+2]+Sqrt[2]+Sqrt[2Sqrt[2]-1]]2^(-13/4)7^(-3/8)*
  (Tan[5Pi/56]Tan[13Pi/56]/Tan[11Pi/56])^(1/4)*
  Sqrt[Beta[5/56,5/56]Beta[13/56,13/56]Beta[1/8,1/8]/Beta[11/56,11/56]]
(* This version from Borwein^2 p. 298 is ***WRONG***
 EllipticK[SingularValue[14]]:=Sqrt[Sqrt[10+6Sqrt[2]]+Sqrt[2+2Sqrt[2]]+Sqrt[3+Sqrt[2]]]*
  Sqrt[Gamma[1/56]Gamma[3/56]Gamma[9/56]Gamma[13/56]Gamma[15/56]Gamma[19/56]Gamma[23/56]*
  Gamma[25/56]Gamma[27/56]Gamma[39/56]Gamma[45/56]]/16/Pi/Sqrt[7]
*)
EllipticK[SingularValue[15]]:=Sqrt[(Sqrt[5]+1)Gamma[1/15]Gamma[2/15]Gamma[4/15]Gamma[8/15]/240/Pi]
EllipticK[SingularValue[16]]:=(2^(1/4)+1)^2Gamma[1/4]^2/2^(9/2)/Sqrt[Pi]
(*EllipticK[SingularValue[17]]:=*)
EllipticK[SingularValue[25]]:=(Sqrt[5]+2)/20 Gamma[1/4]^2/Sqrt[Pi]

Protect[EllipticK];

(* Elliptic Lambda *)

EllipticLambda[1]:=1/Sqrt[2]
EllipticLambda[2]:=-1+Sqrt[2]
EllipticLambda[3]:=Root[1-16#1^2+16#1^4&,3]
EllipticLambda[4]:=3-2Sqrt[2]
EllipticLambda[5]:=Root[1-72#1^2+88#1^4-32#1^6+16#1^8&,3]
EllipticLambda[6]:=Root[1-12#1+2#1^2+12#1^3+#1^4&,3]
EllipticLambda[7]:=Root[1-256#1^2+256#1^4&,3]
EllipticLambda[8]:=Root[1-20#1-26#1^2-20#1^3+#1^4&,1]
EllipticLambda[9]:=Root[1-776#1^2+792#1^4-32#1^6+16#1^8&,3]
EllipticLambda[10]:=Root[1-36#1+2#1^2+36#1^3+#1^4&,3]
EllipticLambda[11]:=Root[1-2096#1^2+2864#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticLambda[12]:=Root[1-60#1+134#1^2-60#1^3+#1^4&,1]
EllipticLambda[13]:=Root[1-5192#1^2+5208#1^4-32#1^6+16#1^8&,3]
EllipticLambda[14]:=Root[1-88#1-108#1^2-88#1^3+230#1^4+88#1^5-108#1^6+88#1^7+#1^8&,3]
EllipticLambda[15]:=Root[1-12032#1^2+77568#1^4-131072#1^6+65536#1^8&,5]
EllipticLambda[16]:=Root[1-132#1-250#1^2-132#1^3+#1^4&,1]
EllipticLambda[17]:=Root[1-26384#1^2-24720#1^4-319936#1^6+1215584#1^8-1267456#1^10+423680#1^12-1024#1^14+256#1^16&,3]
EllipticLambda[18]:=Root[1-196#1+2#1^2+196#1^3+#1^4&,3]
EllipticLambda[19]:=Root[1-55344#1^2+56112#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticLambda[20]:=Root[1-280#1-292#1^2-680#1^3+2758#1^4-680#1^5-292#1^6-280#1^7+#1^8&,1]
EllipticLambda[21]:=Root[1-111760#1^2+1337584#1^4-4239808#1^6+6590560#1^8-5365504#1^10+1789696#1^12-1024#1^14+256#1^16&,5]
EllipticLambda[22]:=Root[1-396#1+2#1^2+396#1^3+#1^4&,3]
EllipticLambda[23]:=Root[1-218368#1^2-1223424#1^4-13893632#1^6+48889856#1^8-50331648#1^10+16777216#1^12&,3]
EllipticLambda[24]:=Root[1-552#1+1372#1^2+1512#1^3-570#1^4+1512#1^5+1372#1^6-552#1^7+#1^8&,1]
EllipticLambda[25]:=Root[1-414728#1^2+414744#1^4-32#1^6+16#1^8&,3]
EllipticLambda[26]:=Root[1-748#1-3274#1^2-9988#1^3+15#1^4+21736#1^5+6580#1^6-21736#1^7+15#1^8+9988#1^9-3274#1^10+748#1^11+#1^12&,3]
EllipticLambda[27]:=Root[1-768048#1^2+768816#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticLambda[28]:=Root[1-1020#1+2054#1^2-1020#1^3+#1^4&,1]
(*EllipticLambda[29]:=*)
EllipticLambda[30]:=Root[1-1368#1+7060#1^2-1368#1^3-14106#1^4+1368#1^5+7060#1^6+1368#1^7+#1^8&,5]
EllipticLambda[31]:=Root[1-2468352#1^2+13281792#1^4-38404096#1^6+61145088#1^8-50331648#1^10+16777216#1^12&,3]
EllipticLambda[32]:=Root[1-1800#1-12772#1^2-63800#1^3-105402#1^4-63800#1^5-12772#1^6-1800#1^7+#1^8&,1]
(*EllipticLambda[33]:=*)
EllipticLambda[34]:=Root[1-2376#1+1300#1^2-2376#1^3-2586#1^4+2376#1^5+1300#1^6+2376#1^7+#1^8&,3]
(*EllipticLambda[35]:=*)
EllipticLambda[36]:=Root[1-3096#1-5924#1^2+2136#1^3+14022#1^4+2136#1^5-5924#1^6-3096#1^7+#1^8&,1]
EllipticLambda[37]:=Root[1-12446792#1^2+12446808#1^4-32#1^6+16#1^8&,3]
EllipticLambda[38]:=Root[1-4004#1-27210#1^2-159148#1^3+15#1^4+433400#1^5+54452#1^6-433400#1^7+15#1^8+159148#1^9-27210#1^10+4004#1^11+#1^12&,3]
(*EllipticLambda[39]:=*)
EllipticLambda[40]:=Root[1-5160#1+10588#1^2+6120#1^3-19002#1^4+6120#1^5+10588#1^6-5160#1^7+#1^8&,1]
(*EllipticLambda[41]:=*)
EllipticLambda[42]:=Root[1-6600#1+51988#1^2-6600#1^3-103962#1^4+6600#1^5+51988#1^6+6600#1^7+#1^8&,5]
EllipticLambda[43]:=Root[1-55296048#1^2+55296816#1^4-5632#1^6+13056#1^8-12288#1^10+4096#1^12&,3]
EllipticLambda[44]:=Root[1-8372#1-37950#1^2-370916#1^3+1457135#1^4-3813992#1^5+5552284#1^6-3813992#1^7+1457135#1^8-370916#1^9-37950#1^10-8372#1^11+#1^12&,1]
(*EllipticLambda[45]:=*)
EllipticLambda[46]:=Root[1-10584#1-29804#1^2-10584#1^3+59622#1^4+10584#1^5-29804#1^6+10584#1^7+#1^8&,3]
(*EllipticLambda[47]:=*)
EllipticLambda[48]:=Root[1-13320#1+92188#1^2+275400#1^3+340038#1^4+275400#1^5+92188#1^6-13320#1^7+#1^8&,1]
(*EllipticLambda[49]:=*)
EllipticLambda[50]:=Root[1-16652#1-174026#1^2-1708900#1^3+15#1^4+4943528#1^5+348084#1^6-4943528#1^7+15#1^8+1708900#1^9-174026#1^10+16652#1^11+#1^12&,3]
(*EllipticLambda[51]:=*)
EllipticLambda[52]:=Root[1-20760#1-41252#1^2+19800#1^3+84678#1^4+19800#1^5-41252#1^6-20760#1^7+#1^8&,1]
(*EllipticLambda[53]:=*)
EllipticLambda[54]:=Root[1-25764#1+52662#1^2-146604#1^3+15#1^4+156408#1^5-105292#1^6-156408#1^7+15#1^8+146604#1^9+52662#1^10+25764#1^11+#1^12&,3]
(*EllipticLambda[55]:=*)
EllipticLambda[56]:=Root[1-31824#1-499464#1^2-6240496#1^3-14672868#1^4+11287728#1^5+81585864#1^6-837488#1^7-124405690#1^8-837488#1^9+81585864#1^10+11287728#1^11-14672868#1^12-6240496#1^13-499464#1^14-31824#1^15+#1^16&,1]
(*EllipticLambda[57]:=*)
EllipticLambda[58]:=Root[1-39204#1+2#1^2+39204#1^3+#1^4&,3]
(*EllipticLambda[59]:=*)
EllipticLambda[60]:=Root[1-48120#1+952348#1^2-4146120#1^3+6484038#1^4-4146120#1^5+952348#1^6-48120#1^7+#1^8&,1]
(*EllipticLambda[61]:=*)
(*EllipticLambda[62]:=*)
(*EllipticLambda[63]:=*)
EllipticLambda[64]:=Root[1-71688#1+12316#1^2-452664#1^3-1073082#1^4-452664#1^5+12316#1^6-71688#1^7+#1^8&,1]
(*EllipticLambda[65]:=*)
(*EllipticLambda[66]:=*)
(*EllipticLambda[67]:=*)
(*EllipticLambda[68]:=*)
(*EllipticLambda[69]:=*)
EllipticLambda[70]:=Root[1-127512#1+571540#1^2-127512#1^3-1143066#1^4+127512#1^5+571540#1^6+127512#1^7+#1^8&,5]
(*EllipticLambda[71]:=*)
EllipticLambda[72]:=Root[1-153640#1+307548#1^2+154600#1^3-612922#1^4+154600#1^5+307548#1^6-153640#1^7+#1^8&,1]
(*EllipticLambda[73]:=*)
(*EllipticLambda[74]:=*)
(*EllipticLambda[75]:=*)
EllipticLambda[76]:=Root[1-221364#1-1315902#1^2-3139812#1^3-246801#1^4-832104#1^5+11516060#1^6-832104#1^7-246801#1^8-3139812#1^9-1315902#1^10-221364#1^11+#1^12&,1]
(*EllipticLambda[77]:=*)
EllipticLambda[78]:=Root[1-264792#1+6780820#1^2-264792#1^3-13561626#1^4+264792#1^5+6780820#1^6+264792#1^7+#1^8&,5]
(*EllipticLambda[79]:=*)
(*EllipticLambda[80]:=*)
(*EllipticLambda[81]:=*)
EllipticLambda[82]:=Root[1-376200#1+685588#1^2-376200#1^3-1371162#1^4+376200#1^5+685588#1^6+376200#1^7+#1^8&,3]
(*EllipticLambda[83]:=*)
(*EllipticLambda[84]:=*)
(*EllipticLambda[85]:=*)
(*EllipticLambda[86]:=*)
(*EllipticLambda[87]:=*)
EllipticLambda[88]:=Root[1-627240#1+1254748#1^2+628200#1^3-2507322#1^4+628200#1^5+1254748#1^6-627240#1^7+#1^8&,1]
(*EllipticLambda[89]:=*)
(*EllipticLambda[90]:=*)
(*EllipticLambda[91]:=*)
EllipticLambda[92]:=Root[1-873460#1-28309438#1^2-1085096740#1^3+6527738351#1^4-16093897960#1^5+21360882588#1^6-16093897960#1^7+6527738351#1^8-1085096740#1^9-28309438#1^10-873460#1^11+#1^12&,1]
(*EllipticLambda[93]:=*)
(*EllipticLambda[94]:=*)
(*EllipticLambda[95]:=*)
(*EllipticLambda[96]:=*)
(*EllipticLambda[97]:=*)
(*EllipticLambda[98]:=*)
(*EllipticLambda[99]:=*)
EllipticLambda[100]:=Root[1-1658904#1-3317540#1^2+1657944#1^3+6637254#1^4+1657944#1^5-3317540#1^6-1658904#1^7+#1^8&,1]

(*
EllipticLambda[r_]:=Divide@@(EllipticTheta[#,0,Exp[-Pi Sqrt[r]]]^2&/@{2,3})

EllipticLambda[2/29]:=(13Sqrt[58]-99)(Sqrt[2]+1)^6
EllipticLambda[2/5]:=(Sqrt[10]-3)(Sqrt[2]+1)^2
EllipticLambda[2/3]:=(2-Sqrt[3])(Sqrt[2]+Sqrt[3])
EllipticLambda[3/4]:=(Sqrt[3]-Sqrt[2])^2(Sqrt[2]+1)^2
EllipticLambda[1]:=1/Sqrt[2]
EllipticLambda[2]:=Sqrt[2]-1
EllipticLambda[3]:=1/4 Sqrt[2](Sqrt[3]-1)
EllipticLambda[4]:=3-2Sqrt[2]
EllipticLambda[5]:=1/2 (Sqrt[Sqrt[5]-1]-Sqrt[3-Sqrt[5]])
EllipticLambda[6]:=(2-Sqrt[3])(Sqrt[3]-Sqrt[2])
EllipticLambda[7]:=1/8 Sqrt[2](3-Sqrt[7])
EllipticLambda[8]:=(Sqrt[2]+1-Sqrt[2Sqrt[2]+2])^2
EllipticLambda[9]:=1/2 (Sqrt[2]-3^(1/4))(Sqrt[3]-1)
EllipticLambda[10]:=(Sqrt[10]-3)(Sqrt[2]-1)^2
EllipticLambda[11]:=(-(11/6+2/(3(17+3Sqrt[33])^(1/3))-(17+3Sqrt[33])^(1/3)/3)^(1/2) + 
    (1/6-2/(3(17+3Sqrt[33])^(1/3))+(17+3Sqrt[33])^(1/3)/3)^(1/2))/2
EllipticLambda[12]:=(Sqrt[3]-Sqrt[2])^2(Sqrt[2]-1)^2
EllipticLambda[13]:=(Sqrt[5Sqrt[13]-17]-Sqrt[19-5Sqrt[13]])/2 (* from G13 *)
EllipticLambda[14]:=-11-8Sqrt[2]-4Sqrt[5+4Sqrt[2]]-2Sqrt[2]Sqrt[5+4Sqrt[2]] + 
	2Sqrt[11+8Sqrt[2]]+2Sqrt[2]Sqrt[11+8Sqrt[2]] + 
	Sqrt[2]Sqrt[5+4Sqrt[2]]Sqrt[11+8Sqrt[2]]
EllipticLambda[15]:=(3-Sqrt[5])(Sqrt[5]-Sqrt[3])(2-Sqrt[3])/8/Sqrt[2] (* p 162 *)
EllipticLambda[16]:=(2^(1/4)-1)^2/(2^(1/4)+1)^2
EllipticLambda[17]:=(Sqrt[42 + 10 Sqrt[17] - 13 Sqrt[-3 + Sqrt[17]] Sqrt[5 + Sqrt[17]] - 
    3 Sqrt[17] Sqrt[-3 + Sqrt[17]] Sqrt[5 + Sqrt[17]]] - 
    Sqrt[-38 - 10 Sqrt[17] + 13 Sqrt[-3 + Sqrt[17]] Sqrt[5 + Sqrt[17]] + 
    3 Sqrt[17] Sqrt[-3 + Sqrt[17]] Sqrt[5 + Sqrt[17]]]) / (2 Sqrt[2])
EllipticLambda[18]:=(Sqrt[2]-1)^3(2-Sqrt[3])^2				(* ega *)
	(* (5+2Sqrt[6])(7Sqrt[2]-5-2Sqrt[6]) *)		(* Borwein^2, p. 162 *)
EllipticLambda[21]:=(Sqrt[1+(3-Sqrt[7])^2(Sqrt[7]-Sqrt[3])^3/16]-Sqrt[1-(3-Sqrt[7])^2(Sqrt[7]-Sqrt[3])^3/16])/2
EllipticLambda[22]:=(3Sqrt[11]-7Sqrt[2])(10-3Sqrt[11])		(* ega *)
EllipticLambda[25]:=(Sqrt[5]-2)(3-2 5^(1/4))/Sqrt[2]			(* Borwein^2, p. 162 *)
EllipticLambda[27]:=(-(9/2 + 2^(1/3) - 3*2^(2/3))^(1/2) + (-5/2 - 2^(1/3) + 3*2^(2/3))^(1/2))/2
EllipticLambda[30]:=(Sqrt[3]-Sqrt[2])^2(2-Sqrt[3])(Sqrt[6]-Sqrt[5])(4-Sqrt[15])
												(* ega *)
EllipticLambda[33]:=(-(-259 + 150*3^(1/2) + 78*11^(1/2) - 45*33^(1/2))^(1/2) + 
    (261 - 150*3^(1/2) - 78*11^(1/2) + 45*33^(1/2))^(1/2))/2
EllipticLambda[34]:=(Sqrt[2]-1)^2(3Sqrt[2]-Sqrt[17])*
      (Sqrt[297+72Sqrt[17]]-Sqrt[296+72Sqrt[17]])
      											(* ega *)
EllipticLambda[37]:=(-(883 - 145*37^(1/2))^(1/2) + (-881 + 145*37^(1/2))^(1/2))/2
EllipticLambda[42]:=(Sqrt[2]-1)^2(2-Sqrt[3])^2(Sqrt[7]-Sqrt[6])(8-3Sqrt[7])
												(* ega *)
EllipticLambda[45]:=(-(1179 + 680*3^(1/2) - 527*5^(1/2) - 304*15^(1/2))^(1/2) + 
    (-1177 - 680*3^(1/2) + 527*5^(1/2) + 304*15^(1/2))^(1/2))/2
EllipticLambda[46]:=(-18 - 13*2^(1/2) + 3*2^(1/2)*(147 + 104*2^(1/2))^(1/2) - (661 + 468*2^(1/2))^(1/2))*
     (18 + 13*2^(1/2) + (661 + 468*2^(1/2))^(1/2))
EllipticLambda[49]:=(-(1 - 4096/(7^(1/4) + (4 + 7^(1/2))^(1/2))^12)^(1/2) + 
    (1 + 4096/(7^(1/4) + (4 + 7^(1/2))^(1/2))^12)^(1/2))/2
EllipticLambda[58]:=(13Sqrt[58]-99)(Sqrt[2]-1)^6				(* Borwein^2, p. 299 *)
EllipticLambda[64]:= ((Sqrt[Sqrt[2]+1]-2^(5/8))/(Sqrt[Sqrt[2]+1]+2^(5/8)))^2
												(* Borwein^2, p. 161 *)
EllipticLambda[210]:=(Sqrt[2]-1)^2(2-Sqrt[3])(Sqrt[7]-Sqrt[6])^2(8-3Sqrt[7])*
   (Sqrt[10]-3)^2(4-Sqrt[15])^2(Sqrt[15]-Sqrt[14])(6-Sqrt[35])
   												(* Borwein^2, p. 141 *)
EllipticLambda[330]:=(2-Sqrt[3])^3(Sqrt[2]-1)^2(Sqrt[33]-4Sqrt[2])^2(Sqrt[10]-3)^2(3Sqrt[5]-2Sqrt[11])^2*
  (4-Sqrt[15])(Sqrt[55]-3Sqrt[6])(10-3Sqrt[11])
  												(* Borwein^2, p. 296 *)
EllipticLambda[462]:=(Sqrt[3]-Sqrt[2])^4(2-Sqrt[3])^2(2Sqrt[2]-Sqrt[7])^2(8-3Sqrt[7])^2*
  (3Sqrt[11]-7Sqrt[2])^2(Sqrt[22]-Sqrt[21])(10-3Sqrt[11])(76-5Sqrt[231])
  												(* Borwein^2, p. 296 *)
*)

(* EllipticSimplify *)

EllipticSimplify[expr_]:= Module[{},
	expr /. {
	EllipticF[x_,y_]:>If[-Pi/2<Re[x]<Pi/2&&Csc[x]^2==y,EllipticK[Sin[x]^2]Sin[x],EllipticF[x,y]],
	EllipticE[x_,y_]:>If[-Pi/2<Re[x]<Pi/2&&Csc[x]^2==y,Csc[x]EllipticE[Sin[x]^2]-Cos[x]Cot[x]EllipticK[Sin[x]^2],EllipticE[x,y]]
	}
]

(* Exsecant *)

Exsecant[x_]:=Sec[x]-1

(* Falling Factorial *)

FallingFactorial[x_,n_]:=(-1)^n Pochhammer[-x,n]
ToFallingFactorial[expr_]:=expr /. Pochhammer[x_,n_] :> (-1)^n HoldForm[FallingFactorial][-x,n]

(* GFunction *)

GFunction[z_]:=2Hypergeometric2F1[1,z,1+z,-1]/z

(* GramPoint *)

GramPoint[n_, opts___?OptionQ] := Module[{t},
	FindRoot[RiemannSiegelTheta[t] - n*Pi, {t, 2E^(1 + ProductLog[(1 + 8n)/(8E)])Pi}, opts, Evaluate[Sequence@@Options[GramPoint]]][[1,-1]]
]

(* Gudermannian *)

Gudermannian[z_]:=2ArcTan[Tanh[z/2]]

(* Haversine *)

Haversine[x_]:=(1-Cos[x])/2

(* Inverse Gudermannian *)

InverseGudermannian[x_]:=-Log[Cos[x/2] - Sin[x/2]] + Log[Cos[x/2] + Sin[x/2]]

(* InverseTangentIntegralT *)

InverseTangentIntegralT[x_]:=(PolyLog[2,I x]-PolyLog[2,-I x])/(2I)

(* JFunction *)

JFunction[tau_]:=1728KleinInvariantJ[tau]

(* Jinc *)

Jinc[0]:=1/2
Jinc[x_]:=BesselJ[1,x]/x

(* LSeries *)

LSeries[d_Integer?PrimitiveQ,s_]:=
	Total[KroneckerSymbol[d,#]PolyGamma[s-1,#/Abs[d]]&/@Range[Abs[d]-1]]/((-Abs[d])^s (s-1)!)

(*
	(-1)^s/(Abs[d]^s (s-1)!) Total[KroneckerSymbol[d,#]PolyGamma[s-1,#/Abs[d]]&/@Range[Abs[d]-1]]
*)
(* LegendreChi *)

LegendreChi[n_, z_] := z LerchPhi[z^2, n, 1/2]/2^n

(* PrimeZeta *)

primes=Prime[Range[10^4]];

PrimeZeta[z_]:=Plus@@(N[1,20]/primes^z)

(* PrimitiveQ *)

PrimitiveQ[n_]:=Module[{f=FactorInteger[n]},
    Max[Last/@DeleteCases[f,{2,_}]]<2&&
      Switch[First[If[#\[Equal]{},{0},#]]&@Cases[f,{2,p_}\[Rule]p],
        3,True,
        2,Mod[n/4,4]\[Equal]3,
        0,Mod[n,4]\[Equal]1,
        _,False
        ]
    ]

(* Primorial *)

Primorial[p_]:=Times@@Prime[Range[PrimePi[p]]]

(* QFactorial *)
(*
QFactorial[1,q_]:= 1
QFactorial[a_,q_]:= QFactorial[a,q]=Module[{k},
	Plus@@Table[q^k,{k,0,a-1}]QFactorial[a-1,q]
]
*)

(* QSeries *)
(* superceded in V6.1 by QPochhammer *)

QSeries[{a:Except[_List],q_},n:(_Integer|_Symbol)] := Times@@((1-a q^#)&/@Range[0,n-1])
QSeries[{q:Except[_List]},n:(_Integer|_Symbol)] := Times@@((1-q^#)&/@Range[n-1])

QSeries[{a:Except[_List],q_}] := QSeries[{a,q},100]
QSeries[{q_}] := QSeries[{q},100] /; Abs[q]<1
QSeries[{q_}] := 0 /; Abs[q]>=1

(*
QSeries[q_List,n:(_Integer|_Symbol)]:= Times@@Flatten[Outer[1-#1^#2&,{q},Range[n-1]]]
*)
QSeries[q_List]:=QSeries[q,100]
QSeries[{a_List,q_},n_]:=Times@@(QSeries[{#,q},n]&/@a)
QSeries[{a_List,q_}]:=QSeries[{a,q},100]

(* Ramp Function *)

RampFunction[x_]:=x UnitStep[x]

(* Rising Factorial *)

RisingFactorial[x_,n_]:=Pochhammer[x,n]

(* Sinc *)

If[$VersionNumber<6,
Sinc[0]:=1;
Sinc[x_]:=Sin[x]/x
]

(* Sinhc *)

Sinhc[x_]:=Sinh[x]/x

(* Spherical Bessel *)

SphericalBesselI[n_,z_]:=Sqrt[Pi/(2z)]BesselI[n+1/2,z]

SphericalBesselK[n_,z_]:=Sqrt[2/(Pi z)]BesselK[n+1/2,z]

(* Tanc *)

Tanc[x_]:=Tan[x]/x

(* Tanhc *)

Tanhc[x_]:=Tanh[x]/x

(* Trinomial *)

Trinomial[n_,k_]:=n!Hypergeometric2F1Regularized[(k-n)/2, (1 + k - n)/2, 1 + k, 4]/(n-k)!

(* Versine *)

Versine[x_]:=1-Cos[x]

(* XiFunction *)

XiFunction[z_]:=1/2 z(z-1)Gamma[z/2]/Pi^(z/2) Zeta[z]

End[]

EndPackage[]

(* Protect[  ] *)