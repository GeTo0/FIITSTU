(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`Packing` *)

(*:Author: Raw code by Erich Friedman
           Put into package form by Eric W. Weisstein 
*)

(*:URL:
  http://mathworld.wolfram.com/packages/Packing.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2000-01-27): Erich's code modularized and placed in this package
  v1.01 (2003-10-19): updated context
  
  (c) 2000-2007 Erich Friedman and Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Packing`"]

Circle::usage =
"A type of shape for use in Packing."

Packing::usage =
"Packing[{n,shape1},shape2] gives Graphics primitives giving the
best-known packing of n copies of shape1 inside shape2.  Valid shapes
are Circle, Square, and Triangle."

Square::usage =
"A type of shape for use in Packing."

Triangle::usage =
"A type of shape for use in Packing."


Begin["`Private`"]


(* box *)

b[n_]:=Line[{{0,0},{0,n},{n,n},{n,0},{0,0}}];

(* circle *)

c[i_,j_]:={GrayLevel[.7],Disk[{i,j},1],GrayLevel[0],Circle[{i,j},1]}

c[n_]:=Circle[{0,0},n]

(* square *)

s[i_,j_]:={GrayLevel[.7],Rectangle[{i,j},{i+1,j+1}],
 GrayLevel[0],Line[{{i,j},{i,j+1},{i+1,j+1},{i+1,j},{i,j}}]}

s[i_,j_,n_]:=Module[{k},
{GrayLevel[.7],Rectangle[{i,j},{i+n,j+1}],
GrayLevel[0],Line[{{i,j},{i,j+1},{i+n,j+1},{i+n,j},{i,j}}],
Table[Line[{{i+k,j},{i+k,j+1}}],{k,1,n-1}]}
]

ss[i_,j_]:=With[{a=2/Sqrt[3]},
{GrayLevel[.7],Polygon[{{i,j},{i+1/2,j+1/a},
 {i+1/2+1/a,j+1/a-1/2},{i+1/a,j-1/2}}],
 GrayLevel[0],Line[{{i,j},{i+1/2,j+1/a},
 {i+1/2+1/a,j+1/a-1/2},{i+1/a,j-1/2},{i,j}}]}
]

sss[i_,j_]:=With[{a=2/Sqrt[3]},
{GrayLevel[.7],Polygon[{{i,j},{i-1/2,j+1/a},
 {i-1/2+1/a,j+1/a+1/2},{i+1/a,j+1/2}}],
 GrayLevel[0],Line[{{i,j},{i-1/2,j+1/a},
 {i-1/2+1/a,j+1/a+1/2},{i+1/a,j+1/2},{i,j}}]}
]

tt[i_,j_]:=With[{aa=1/Sqrt[8]},
{GrayLevel[.7],Polygon[{{i-aa,j+aa},{i+aa,j-aa},{i+3aa,j+aa},
{i+aa,j+3aa},{i-aa,j+aa}}], GrayLevel[0],
Line[{{i-aa,j+aa},{i+aa,j-aa},{i+3aa,j+aa},{i+aa,j+3aa},{i-aa,j+aa}}]}
]

(* triangle *)

t[n_]:={GrayLevel[0],Line[{{0,0},{n,0},{n/2,n Sqrt[3]/2},{0,0}}]}

t[n_,x_]:={GrayLevel[0],Line[{{x,0},{n+x,0},{n/2+x,n Sqrt[3]/2},{x,0}}]}

t[i_,j_,th_]:={GrayLevel[.7],
  Polygon[{{i,j},{i+Cos[th],j+Sin[th]},
  {i+Cos[th]+Cos[th+2Pi/3],j+Sin[th]+Sin[th+2Pi/3]}}],
  GrayLevel[0],
  Line[{{i,j},{i+Cos[th],j+Sin[th]},
  {i+Cos[th]+Cos[th+2Pi/3],j+Sin[th]+Sin[th+2Pi/3]},{i,j}}]}


(* Circles in Circles *)

Packing[{1,Circle},Circle]:={c[0,0]}
Packing[{2,Circle},Circle]:={c[-1,0],c[1,0],c[2]}
Packing[{3,Circle},Circle]:=With[{s=Sin[Pi/12],d=Cos[Pi/12]},
    {c[2/Sqrt[3],0],c[-Sqrt[1/3],1],c[-Sqrt[1/3],-1],c[1+2/Sqrt[3]]}]
Packing[{4,Circle},Circle]:={c[-1,-1],c[-1,1],c[1,-1],c[1,1],c[1+Sqrt[2]]}
Packing[{5,Circle},Circle]:=With[{a=2Pi/5,b=1.705},
    {c[b,0],c[b Cos[a],b Sin[a]],c[b Cos[2a],b Sin[2a]],
      c[b Cos[3a],b Sin[3a]],c[b Cos[4a],b Sin[4a]],c[1+b]}]
Packing[{6,Circle},Circle]:=With[{a=Pi/3,b=2},
    {c[b,0],c[b Cos[a],b Sin[a]],c[b Cos[2a],b Sin[2a]],
      c[b Cos[3a],b Sin[3a]],c[b Cos[4a],b Sin[4a]],c[b Cos[5a],b Sin[5a]],
      c[1+b]}]
Packing[{7,Circle},Circle]:=With[{a=2Pi/5,b=2},
    {c[b Cos[5a],b Sin[5a]],c[b Cos[a],b Sin[a]],c[b Cos[2a],b Sin[2a]],
      c[b Cos[3a],b Sin[3a]],c[b Cos[4a],b Sin[4a]],c[0,0],c[1+b]}
]


(* Circles in Squares *)

Packing[{1,Circle},Square]:={c[1,1],b[2]}

Packing[{2,Circle},Square]:={c[1,1],c[1+Sqrt[2],1+Sqrt[2]],b[2+Sqrt[2]]}

Packing[{3,Circle},Square]:=With[{s=Sin[Pi/12],d=Cos[Pi/12]},
{c[1,1],c[1+2d,1+2s],c[1+2s,1+2d],b[2+2d]}
]

Packing[{4,Circle},Square]:={c[1,1],c[1,3],c[3,1],c[3,3],b[4]}

Packing[{5,Circle},Square]:=With[{s=Sin[Pi/4]},
{c[1,1],c[1,1+4s],c[1+4s,1],c[1+4s,1+4s],c[1+2s,1+2s],b[2+4s]}
]

Packing[{6,Circle},Square]:=Module[{t=ArcTan[2/3],a,aa},
a=Sin[t];
aa=Cos[t];
{c[1,1],c[1+4aa,1],c[1+2aa,1+2a],
c[1,1+4a],c[1+4aa,1+4a],c[1+2aa,1+6a],b[2+4aa]}
]


(* Circles in Triangle *)

Packing[{1,Circle},Triangle]:={c[Sqrt[3],1],t[2Sqrt[3]]}

Packing[{2,Circle},Triangle]:={c[Sqrt[3],1],c[Sqrt[3]+2,1],t[2+2Sqrt[3]]}

Packing[{3,Circle},Triangle]:={c[Sqrt[3],1],c[Sqrt[3]+2,1],c[Sqrt[3]+1,1+Sqrt[3]],
t[2+2Sqrt[3]]}

Packing[{4,Circle},Triangle]:={c[Sqrt[3],1],c[3Sqrt[3],1],c[2Sqrt[3],4],c[2Sqrt[3],2],
t[4Sqrt[3]]}

Packing[{5,Circle},Triangle]:={c[Sqrt[3],1],c[Sqrt[3]+2,1],c[Sqrt[3]+1,1+Sqrt[3]],
c[Sqrt[3]+3,1+Sqrt[3]],c[Sqrt[3]+4,1],t[4+2Sqrt[3]]}

Packing[{6,Circle},Triangle]:={c[Sqrt[3],1],c[Sqrt[3]+2,1],c[Sqrt[3]+1,1+Sqrt[3]],
c[Sqrt[3]+3,1+Sqrt[3]],c[Sqrt[3]+4,1],c[Sqrt[3]+2,1+2Sqrt[3]],t[4+2Sqrt[3]]}


(* Squares in Circle *)

stack[l__]:=Module[{a,n,b,c,d,e,f,sol,g,x,r,i},
  a={l};
  n=Length[a];
  b=Table[s[ -a[[i]]/2,-i,a[[i]] ],{i,n}];
  c=Table[a[[i]]^2+4(i-1-n/2)^2,{i,Floor[(n+1)/2]}];
  d=Last[Last[Position[c,Max[c]]]];
  e=Table[a[[j]]^2+4(j-n/2)^2,{j,Ceiling[(n+1)/2],n}];
  f=Position[e,Max[e]][[1,1]]+Ceiling[(n+1)/2]-1;
  sol=First[Solve[{ a[[d]]^2/4+(1-d-x)^2==a[[f]]^2/4+(f+x)^2 },x]];
  g=x/.sol;
  r=Sqrt[a[[f]]^2/4+(f+x)^2] /. sol;
  {Circle[{0,g},r],b}
]

Packing[{1,Square},Circle]:=stack[1]

Packing[{2,Square},Circle]:=stack[2]

Packing[{3,Square},Circle]:=stack[1,2]

Packing[{4,Square},Circle]:=stack[2,2]

Packing[{5,Square},Circle]:=stack[1,3,1]

Packing[{6,Square},Circle]:=With[{aa=1/Sqrt[8]},
{Circle[{.4157,.4157},1.69],s[0,0],s[0,1],s[1,0],
s[.336,-1],s[-1,.336],tt[-2aa-.02,-2aa-.02]}
]


(* Squares in Square *)

sp[m_]:=Module[{n=Ceiling[N[Sqrt[m]]]-1,i,j},
  Flatten[{
    Table[s[i,j],{i,0,n},{j,0,n-1}],
    Table[s[i,n],{i,0,m-n^2-n-1}],b[n+1]
  }]
]

d[n_]:=Module[{x,l,i},
	x=n+1+Sqrt[1/2];
	l=Floor[N[Sqrt[2](x-2)]];
	Flatten[{s[0,0],b[x],s[x-1,x-1],
    	Table[s[x-1-i,j],{i,0,n-1},{j,0,n-1-i}],
    	Table[s[i,x-1-j],{i,0,n-1},{j,0,n-1-i}],
    	Table[tt[1+2a i, 1+2a i],{i,0,l-1}]
	}]
]

Packing[{1,Square},Square]:=sp[1]

Packing[{2,Square},Square]:=sp[2]

Packing[{3,Square},Square]:=sp[3]

Packing[{4,Square},Square]:=sp[4]

Packing[{5,Square},Square]:=d[1]

Packing[{6,Square},Square]:=sp[6]


(* Squares in Triangles *)

Packing[{1,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],t[1+a,-1/Sqrt[3]]}
]

Packing[{2,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],s[1,0],t[2+a,-1/Sqrt[3]]}
]

Packing[{3,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],ss[1/4,1+Sqrt[3]/4],sss[3/2+Sqrt[3]-3a/2,0],
t[3/2+Sqrt[3],-1/Sqrt[3]]}
]

Packing[{4,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],s[1,0],s[2,0],s[1,1],t[3+a,-1/Sqrt[3]]
}]

Packing[{5,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],s[1,0],s[2,0],s[.5,1],s[1.5,1],t[2+2a,.5-a]}
]

Packing[{6,Square},Triangle]:=With[{a=2/Sqrt[3]},
{s[0,0],s[1,0],ss[a/4,3/2],ss[a/4+1/2,3/2+Sqrt[3]/2],
sss[2+1/Sqrt[3],0],sss[1.5+1/Sqrt[3],Sqrt[3]/2],t[2+2a,-1/Sqrt[3]]}
]


(* Triangles in Circles *)

Packing[{1,Triangle},Circle]:=With[{a=1/2/Sqrt[3]},
{t[-1/2,-a,0],c[2a]}
]

Packing[{2,Triangle},Circle]:={t[-1/2,0,0],t[1/2,0,Pi],c[Sqrt[3]/2]}


Packing[{3,Triangle},Circle]:=With[{x=.9535},
{t[-.899,0,0],t[-.899,0,5Pi/3],t[-.18,-.5505 Sqrt[3]/2,0],c[x]}
]

Packing[{4,Triangle},Circle]:={t[-.5,.11,0],t[.03,.11,Pi],t[-.02,.03,4Pi/3],
t[-.02,.03,5Pi/3],c[.9806]}

Packing[{5,Triangle},Circle]:={t[0,0,0],t[0,0,5Pi/3],t[0,0,2Pi/3],t[0,0,Pi],t[0,0,4Pi/3],
c[1]}

Packing[{6,Triangle},Circle]:={t[0,0,0],t[0,0,5Pi/3],t[0,0,2Pi/3],t[0,0,Pi],t[0,0,4Pi/3],
t[0,0,Pi/3],c[1]}


(* Triangles in Square *)

Packing[{1,Triangle},Square]:=With[{x=Cos[Pi/12]},
{t[0,0,Pi/12],b[x]}
]

Packing[{2,Triangle},Square]:=With[{x=Cos[Pi/12]+Sin[Pi/12]},
{t[0,0,Pi/12],t[x,x,13Pi/12],b[x]}
]

Packing[{3,Triangle},Square]:=With[{x=Sqrt[3]/2(1+Sqrt[1/2])},
{t[0,0,Pi/12],t[x-Sqrt[3/4]+1/2,x,Pi],
t[x,x-Sqrt[3/4]-1/2,Pi/2], b[x]}
]

Packing[{4,Triangle},Square]:=With[{x=1+1/Sqrt[3]},
{t[0,0,0],t[x,x,Pi],t[0,x,3Pi/2],t[x,0,Pi/2],b[x]}
]

Packing[{5,Triangle},Square]:=Module[{x,y},
x=y/.Simplify[Rest[Solve[(y-Sqrt[3])^2+((2+Sqrt[3])y-(4+Sqrt[3]))^2==1,y]][[1]]];
{t[x-Sqrt[3/4],.905,11Pi/6],t[.995,x-Sqrt[3/4],Pi/3],
t[1,Sqrt[3/4],Pi],t[0,Sqrt[3/4],.075],t[1,Sqrt[3/4],4Pi/3],b[x]}
]

Packing[{6,Triangle},Square]:=With[{x=(9-3Sqrt[3])/2},
{t[x-1,x-Sqrt[3/4],Pi/3],t[x-1,x-Sqrt[3/4],0],
t[x-1,x-Sqrt[3/4],5Pi/3],t[1,Sqrt[3/4],2Pi/3],t[1,Sqrt[3/4],Pi],
t[1,Sqrt[3/4],4Pi/3],b[x]}
]


(* Triangles in Triangle *)

Packing[{1,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=1},
{t[0,0,0],t[x]}
]

Packing[{2,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=2},
{t[0,0,0],t[1,0,0],t[x]}
]

Packing[{3,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=2},
{t[0,0,0],t[1,0,0],t[1.5,a,Pi],t[x]}
]

Packing[{4,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=2},
{t[0,0,0],t[1,0,0],t[1.5,a,Pi],t[.5,a,0],t[x]}
]

Packing[{5,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=1+Sqrt[3]},
{t[0,0,0],t[x-1,0,0],t[x/2,a x,4Pi/3],
t[1/2,a,-Pi/6],t[x-1/2,a,5Pi/6],t[x]}
]

Packing[{6,Triangle},Triangle]:=With[{a=Sqrt[3]/2,x=2.98},
{t[0,0,0],t[x-1,0,0],t[x/2,a x,4Pi/3],t[1-.13,.26a,3-Pi],
t[x-1/2,a,3],t[x/2-1/2,x a-a,4.85],t[x]}
]


End[]

(* Protect[  ] *)

EndPackage[]