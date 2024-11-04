(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.82 *)

(*:Name: MathWorld`Curves` *)

(*:Author: Eric W. Weisstein *)

(*:Summary:

  http://mathworld.wolfram.com/packages/Curves.m
  
*)

(*:History:
  1.00             : Written by Eric Weisstein, 1995-1996
  1.50 (1997-10-26): Plotting added to Info and Info0, Changed syntax {f,g,t} 
                     to {f,g},t
                     ImplicitCurvature, NormalPlot, NormalVector,
                     NormalTangentPlot, OsculatingCircle, OsculatingCirclePlot,
                     OsculatingCirclePoints,
                     PolarCurvature, PolarArcLength, TangentPlot, Tangent Vector,
                     ThreePointCircle, ThreePointCircleShow 
  1.51 (1998-03-27): Fixed syntax error in TangentVector
  1.52 (1998-11-07): Epicycloid, EpicycloidFrames, Epitrochoid, 
                     Hypocycloid, HypocycloidFrames, Hypotrochoid,
                     Trochoid, TrochoidFrames, TrochoidMovie
  1.53 (1998-11-12): Minor interface changes; many optional arguments added
  1.54 (1999-02-07): LogarithmicSpiral
  1.55 (1999-06-07): Wrapped Graphics[] around EpiHypotrochoid[{a,b},h,s,{t,t}]
  1.56 (1999-10-28): InvoluteMovie
  1.57 (2000-01-01): URL updated
  1.58 (2001-02-15): Added option passing to Hypocycloid
  1.59 (2001-01-11): Updated date and URL
  1.60 (2002-07-10): Added AlgebraicDegree, removed simplification from 
                     TangentialAngle
  1.61 (2002-07-28): Changed dashed styles to Red
  1.62 (2003-01-09): Catacaustic, CatacausticPlot, Reflections
  1.63 (2003-02-07): ParallelCurve, cleaned up documentent, PedalCurvePlot
                     animation
  1.64 (2003-02-10): NegativePedalCurve
  1.65 (2003-03-11): EvolutePLot extended
  1.66 (2003-04-10): PolarCurvature syntax now agrees with documentation
  1.67 (2003-09-02): Spirograph
  1.68 (2003-10-18): Updated context
  1.69 (2003-10-24): Documented EvoluteFrames
  1.70 (2003-10-30): Made syntax of PolarArcLength agree with documentation
  1.71 (2003-12-01): ArcLength and TangentialAngle now take options (to pass
                     along to Integrate)
  1.72 (2003-12-31): Epitroichoid now takes options
  1.73 (2004-02-09): Curvature and Torsion added for space curves
  1.74 (2004-04-13): Combined Polar with non-polar ArcLength and Curvature.  Implemented
                     ArcLength[{x,y},{t,t0,t1}], ArcLength[r,{th,th0,th1}], 
                     TangentialAngle[r,t], Slope
  1.75 (2004-04-16): Fixed coloring of RadialCurvePlot
  1.76 (2004-04-25): Area.  Removed TrochoidMovie.
  1.77 (2004-04-30): Fixed coloring of PedalCurvePlot
  1.78 (2004-05-02): Cycloid
  1.79 (2004-05-25): Changed *cycloid center point to be Blue
  1.80 (2004-12-12): Removed OsculatingCirclePoints and OsculatingCirclePlot
  1.81 (2005-11-02): ArcLength now works for SpaceCurves
  1.82 (2007-09-29): Removed Graphics`Colors`
  
  (c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:
  arc length, conchoid, plane curves, etc.
*)

(*:Requirements: None. *)

(*:Discussion:
  See http://mathworld.wolfram.com/PlaneCurve.html
*)

BeginPackage["MathWorld`Curves`",{"Utilities`FilterOptions`"}]

AlgebraicDegree::usage =
"AlgebraicDegree[eqn,vars] gives the algebraic degree of the specified equation eqn \
in the variables var.  eqn may be specified as a polynomial or a polynomial equality."

ArcLength::usage =
"ArcLength[{f,g},t] gives the arc length of the parametric curve {f,g} from t = 0 to t.  \
ArcLength[{f,g},{t,t0,t1}] gives the arc length from t = t0 to t1.  Assumptions can be given.  \
ArcLength[r,theta] gives the arc length from theta = 0 to theta of r[theta].  \
ArcLength[r,{theta,theta0,theta1}] gives the length from theta0 to theta1.  \
Assumptions can also be given."

Area::usage =
"Area[{f,g},{t,t0,t1}] gives the area of the curve {f,g} represented \
paramterically, assumed to be non-selfintersecting.  Area[r,{t,t0,t1}] \
gives the area of the curve represented in polar coordinates."

Catacaustic::usage =
"Catacaustic[{f,g},{x,y},t] gives an equation for the catacaustic \
of a curve {f,g} specified parametrically in terms of the variable \
t with respect to a point {x,y}."

CatacausticPlot::usage =
"CatacausticPlot[{f,g},{x,y},{t,t0,t1,dt}] plots the curve {f,g} specified parametrically \
in terms of the variable t, its catacaustic with respect to the point {x,y}, and a \
series of rays for parameter t varying from t0 to t1 in steps of dt."

CesaroEquation::usage =
"CesaroEquation[{f,g},t,{kappa,s}] gives f(kappa,s)=0."

Conchoid::usage =
"Conchoid[{f,g},{x0,y0},k,t] computes the conchoid for the curve {f,g]} \
relative to the point {x0,y0} and with distance k."

ConchoidPlot::usage =
"ConchoidPlot[{f,g},{x0,y0},k,{t,a,b},<options>] plots the conchoid for \
the curve {f,g} relative to the point {x0,y0} and with distance k."

Curvature::usage =
"Curvature[{f,g},t] gives the curvature of the specified plane curve.  \
Curvature[{x,y,z},t] gives the curvature of the specified space curve.  \
Curvature[r,th] gives the curvature of r[th]."

Cycloid::usage =
"Cycloid[{a,b},t] gives the parametric equations of a curtate (b<a), \
prolate (b>a), or normal (b=a) cycloid as a function of parameter t.  \
Cycloid[a,t] is equivalent to Cycloid[{a,a},t]."

Epicycloid::usage =
"Epicycloid[{a,b},t] gives the coordinates of the epicycloid for \
parameter t.  Epicycloid[{a,b},{t1,t2}] plots the segment of the \
epicycloid between t1 and t2.  Epicycloid[{a,b},{t1,t2,dt}] plots \
a movie of the epicycloid (showing circles) for t=t1 to t2 by steps dt."

EpicycloidFrames::usage =
"EpicycloidFrames[{a,b},{t1,...,tn}] plots the epicycloid together with the \
snapshots of the rolling circle at steps ti." 

EpiHypotrochoid::usage =
"EpiHypotrochoid[{a,b},h,s,t] gives the coordinates of the hypotrochoid (s=-1) \
or epitrochoid (s=1) for parameter t.  EpiHypotrochoid[{a,b},h,s,{t1,t2}] \
plots the segment of the hypo- or epitrochoid between t1 and t2.  \
EpiHypotrochoid[{a,b},h,s,{t1,t2,dt}] plots a movie of the epi- or hypotrochoid \
(showing circles) for t=t1 to t2 by steps dt."

Epitrochoid::usage =
"Epitrochoid[{a,b},h,t] gives the coordinates of the epitrochoid for \
parameter t.  Epitrochoid[{a,b},h,{t1,t2}] plots the segment of the \
epitrochoid between t1 and t2.  Epitrochoid[{a,b},h,{t1,t2,dt}] plots \
a movie of the epitrochoid (showing circles) for t=t1 to t2 by steps dt."

Evolute::usage =
"Evolute[{f,g}, t] returns a parametric representation of the evolute of \
the curve specified parametrically as a function of t."

EvoluteFrames::usage =
"EvoluteFrames[{f,g},{t,a,b,dt},<opts>] plots frames of the evolute of \
{f,g} from a to be in steps of dt."

EvolutePlot::usage =
"EvolutePlot[{f,g},{t,a,b},<options>] plots the parametrically represented \
function and its evolute.  The function is plotted as a dashed line and \
the evolute as a solid line.  The parameter t varies from a to b."

Hypocycloid::usage =
"Hypocycloid[{a,b},t] gives the coordinates of the hypocycloid for \
parameter t.  Hypocycloid[{a,b},{t1,t2}] plots the segment of the \
hypocycloid between t1 and t2.  Hypocycloid[{a,b},{t1,t2,dt}] plots \
a movie of the hypocycloid (showing circles) for t=t1 to t2 by steps dt."

HypocycloidFrames::usage =
"HypocycloidFrames[{a,b},{t1,...,tn}] plots the hypocycloid together with the \
snapshots of the rolling circle at steps ti."

Hypotrochoid::usage =
"Hypotrochoid[{a,b},h,t] gives the coordinates of the hypotrochoid for \
parameter t.  Hypotrochoid[{a,b},h,{t1,t2}] plots the segment of the \
epitrochoid between t1 and t2.  Hypotrochoid[{a,b},h,{t1,t2,dt}] plots \
a movie of the hypotrochoid (showing circles) for t=t1 to t2 by steps dt."

ImplicitCurvature::usage =
"ImplicitCurvature[g,{x,y}] gives the curvature for the function g[x,y]=0."

InverseCurve::usage =
"InverseCurve[{f,g},{x0,y0,R},t] gives the inverse curve with respect to \
the point {x0, y0} and radius R for the parametric curve {f,g}."

InverseCurvePlot::usage =
"InverseCurve[{f,g},{x0,y0,R},{t,a,b},<options>] plots the inverse curve \
with respect to the point {x0, y0} and radius R for the parametric curve \
{f,g}."

Involute::usage =
"Involute[{f,g}, t] returns a parametric representation of the involute of \
the curve specified parametrically as a function of t."

InvolutePlot::usage =
"InvolutePlot[{f,g},{t,a,b},<options>]
plots a Plot of the parametrically represented function and its involute.  \
The function is plotted as a dashed line and the involute as a solid line.  \
The parameter t varies from a to b.  \
InvolutePlot[{f,g},{t,t1,t2,dt},{a,b}] makes a sequence of frames \
showing the involute at step t1 to t2 by increment dt.  The base curve \
is shown, plotted as t goes from a to b."

LineLength::usage =
"LineLength."

NaturalEquations::usage =
"NaturalEquations[{f,g},t] gives the natural equations which express {f,g} \
in terms of ArcLength for the parametric curve {f,g}."

NegativePedalCurve::usage =
"NegativePedalCurve[{f,g},{x0,y0},t] gives the negative pedal curve with respect to the \
point {x0, y0} for the parametric curve {f,g}."

NormalPlot::usage =
"NormalPlot[{f,g},{t,a,b,step},len,opts] plot the curve {f,g} and \
a sequence of its normal vectors of lenth len."

NormalVector::usage =
"NormalVector[{f,g},t] gives the normal vector for the curve {f,g}."

Orthotomic::usage = 
"Orthotomic[{f,g},{x0,y0},t}] gives the orthotomic curve with respect \
to the point {x0, y0} for the parametric curve {f,g}."

OrthotomicPlot::usage =
"OrthotomicPlot[{f,g},{x0,y0},{t,a,b},<options>] plots the orthotomic \
curve with respect  to the point {x0, y0} for the parametric curve \
{f,g}."

OsculatingCircle::usage =
"OsculatingCircle[{f,g},t] gives the osculating circle to the curve \
{f,g}."

ParallelCurve::usage =
"ParallelCurve[{f,g},t,d] gives the parallel curve for the curve {f,g} \
parametrized by variable g for a distance d."

ParallelCurvesPlot::usage=
"ParallelCurvesPlot[{f,g},{k1,k2,kstep},{t,a,b},<options>] plots the \
parametrically reprresented function {f,g} curve, together with the \
parallel curves a distance k away, as t varies from a to b."

PedalCurve::usage=
"PedalCurve[{f,g},{x0,y0},t] gives the pedal curve with respect to the \
point {x0, y0} for the parametric curve {f,g}."

PedalCurvePlot::usage=
"PedalCurvePlot[{f,g},{x0,y0},{t,a,b},<opts>] plots the pedal curve \
with respect to the  point {x0, y0} for the parametric curve {f,g} \
for t running from a to b.  \
PedalCurvePlot[{f,g},{x0,y0},{t,a,b,dt},{u0,v0},<opts>] makes an animation."

RadialCurve::usage=
"RadialCurve[{f,g},{x0,y0},t] gives the radial curve with respect to the \
point {x0, y0} for the parametric curve {f,g}."

RadialCurvePlot::usage=
"RadialCurvePlot[{f,g},{x0,y0},{t,a,b}, <options>] plots the radial curve \
with respect to the point {x0, y0} for the parametric curve {f,g} for t \
running from a to b."

Reflections::usage =
"Reflections[{f,g},{x,y},{t,t0,t1,dt}] returns a list of Lines corresponding \
to rays from the radiant point {x,y} reflected off the curve {f,g} parametrized \
as a function of t as t varies from t0 to t1 in steps of dt."

Slope::usage =
"Slope[r,th] gives the slope of the radial curve r[th] at the point th."

Spirograph::usage =
"Spirograph[{p, q}, a, rot:0] displays the spirograph pattern formed by \
an outer wheel of unit radius and an inner wheel of radius p/q produced by a pen \
placed a units from the center and starting at rot radians above the x-axis."
  
TangentialAngle::usage=
"TangentialAngle[{f,g},t] returns the tangential angle for the paramteric \
curve {f,g}.  TangentialAngle[r,th] gives the the tangential angle for a polar curve."

TangentPlot::usage =
"TangentPlot[{f,g},{t,a,b,step},len,opts] plot the curve {f,g} and a sequence of \
its tangent vectors of lenth len."

TangentVector::usage =
"TangentVector[{f,g},t] gives the tangent vector for the curve {f,g}."

ThreePointCircle::usage =
"ThreePointCircle[{x1,y1},{x2,y2},{x3,y3}] gives the circle passing through \
the three points."

ThreePointCircleShow::usage =
"ThreePointCircleShow[{x1,y1},{x2,y2},{x3,y3}] plots the three points \
and the circle containing them."

Torsion::usage =
"Torsion[{x,y,z},t] gives the torsion of the specified space curve."

Trochoid::usage =
"Trochoid[{a,b},t] gives the point on the trochoid for parameter t.  \
Trochoid[{a,b},{t1,t2}] plots the trochoid for parameter from t1 to t2.  \
Trochoid[{a,b},{t1,t2,dt}] plots a movie of the rolling circle from \
t1 to t2 by step dt."

TrochoidFrames::usage =
"TrochoidFrames[{a,b},{t1,...,tn}] plots a trochoid from t=0 to 4Pi \
together with the circles for parameters t1, ... tn."


Begin["`Private`"]

Options[EvolutePlot]={
	LineLength->1
};

AlgebraicDegree[eqn_,vars_List]:=Max[Plus@@@First/@
	If[$VersionNumber<6,Internal`DistributedTermsList,GroebnerBasis`DistributedTermsList]
		[eqn/.Equal:>Subtract,vars][[1]]]

ArcLength[x_List,{t_,t0_,t1_},opts___?OptionQ]:=Integrate[Sqrt[Total[D[#,t]^2&/@x]],{t,t0,t1},opts]

ArcLength[x_List,t_,opts___?OptionQ]:=ArcLength[x,{t,0,t},opts]

ArcLength[r_,{th_,th0_,th1_},assum___?OptionQ]:=Integrate[Sqrt[D[r,th]^2+r^2],{th,th0,th1},assum]
   
ArcLength[r_,th_,assum___?OptionQ]:=ArcLength[r,{th,0,th},assum]

Area[{f_,g_},{t_,t0_,t1_},assum___?OptionQ]:=
	Integrate[f D[g,t]-g D[f,t],{t,t0,t1},assum]/2

Area[r_,{t_,t0_,t1_},assum___?OptionQ]:=Integrate[r^2,{t,t0,t1},assum]/2

Catacaustic[{f_,g_},{x_,y_},t_]:=Evolute[Orthotomic[{f,g},{x,y},t],t]

CatacausticPlot[{f_,g_},x_,{t_,t0_,t1_,dt_},opts___?OptionQ]:=Show[Graphics[{
	{
		Red,
		Reflections[{f,g},x,{t,t0,t1,dt}]
	},
	ParametricPlot[
		Evaluate[{
			Catacaustic[{f,g},x,t],
			{f,g}
		}],{t,t0,t1},
		PlotStyle->{{Blue,Thickness[.01]},Black},
		DisplayFunction->Identity][[1]],
	{
		AbsolutePointSize[8],
		Point[x]
	}
	}],
	opts,AspectRatio->Automatic
]

CesaroEquation[{f_,g_},t_,{kappa_,s_}]:=
  Eliminate[{s==ArcLength[{f,g},t],kappa==Curvature[{f,g},t]},t]

Conchoid[{f_,g_},{x0_,y0_},k_,t_]:=Module[{df,dg,denom},
  df=D[f,t];
  dg=D[g,t];
  denom=Sqrt[(f-x0)^2+(g-y0)^2];
  {f+k(f-x)/denom,g+k(g-y)/denom}
]

ConchoidPlot[{f_,g_},k_,{t_,a_,b_},opts___?OptionQ]:=Module[{c},
  c=Conchoid[{f,g},{x0,y0},k,t];
  ParametricPlot[{c,{f,g}},
    {t,a,b}, AspectRatio->Automatic,
    Ticks->None,PlotStyle->{Red,{}},
    opts]
]

Curvature[{x_,y_},t_]:=Module[
  {xp=D[x,t],xpp=D[x,{t,2}],yp=D[y,t],ypp=D[y,{t,2}]},
  (xp ypp-yp xpp)/(xp^2+yp^2)^(3/2)
]

norm[x_]:=Sqrt[x.x]

Curvature[r_List?VectorQ,t_]:=Module[{dr=D[r,t]},
      norm[Cross[dr,D[dr,t]]]/norm[dr]^3
] /; Length[r]==3

Curvature[r_,th_]:=(-D[r,{th,2}]r+2D[r,th]^2+r^2)/(D[r,th]^2+r^2)^(3/2)

(* Cycloid *)

Cycloid[{a_,b_},t_]:={a t-b Sin[t],a-b Cos[t]}
Cycloid[a_,t]:=Cycloid[{a,a},t]

(* Epicycloid and Hypocycloid *)

Epicycloid[{a_,b_},t_,opts___?OptionQ]:=Epitrochoid[{a,b},b,t,opts]
Epicycloid[{a_,b_},{t_,t_},opts___?OptionQ]:=Epitrochoid[{a,b},b,{t,t},opts]
Epicycloid[{a_,b_},{t1_,t2_},opts___?OptionQ]:=Epitrochoid[{a,b},b,{t1,t2},opts]
Epicycloid[{a_,b_},{t1_,t2_,dt_},opts___?OptionQ]:=Epitrochoid[{a,b},b,{t1,t2,dt},opts]

EpiHypotrochoid[{a_,b_},h_,s_,{t_,t_},opts___?OptionQ]:=
	Graphics[Point[Evaluate[EpiHypotrochoid[{a,b},h,s,t]]]]

EpiHypotrochoid[{a_,b_},h_,s_,{t1_,t2_,dt_},opts___?OptionQ]:=Module[{i,t,
	range,m=Max[a+h-b,a+b s+h]+.1,curv={}
	},
	range={{-m,m},{-m,m}}1.1;
	Table[Graphics[{
		{Red,
			If[t==t1,{},
			AppendTo[curv,
			EpiHypotrochoid[{a,b},h,s,{t-dt,t},DisplayFunction->Identity][[1]]
			]]
		},
		Circle[{0,0},a],
		{
			Blue,
			Circle[(a+s b){Cos[t],Sin[t]},b],
			Line[unit[{(a+s b){Cos[t],Sin[t]},
			EpiHypotrochoid[{a,b},h,s,t]},b]],
			PointSize[.04],
			Point[(a+s b){Cos[t],Sin[t]}]
		},
		{
			Blue,
			Line[{(a+s b){Cos[t],Sin[t]},EpiHypotrochoid[{a,b},h,s,t]}]
		},
		{
			Red,
			PointSize[.04],Point[EpiHypotrochoid[{a,b},h,s,t]]
		}
		},
		opts,AspectRatio->Automatic,PlotRange->range,ImageSize->200],
		{t,t1,t2,dt}
	]
]

EpiHypotrochoid[{a_,b_},h_,s_,{t1_,t2_},opts___?OptionQ]:=
	ParametricPlot[Evaluate[EpiHypotrochoid[{a,b},h,s,t]],{t,t1,t2},
	opts,AspectRatio->Automatic,Ticks->None]

EpiHypotrochoid[{a_,b_},h_,s_,t_]:=
	{(a+s b)Cos[t]-s h Cos[(a+s b)/b t],(a+s b)Sin[t]-h Sin[(a+s b)/b t]}

Epitrochoid[{a_,b_},h_,{t_,t_},opts___?OptionQ]:=EpiHypotrochoid[{a,b},h,1,{t,t},opts]
Epitrochoid[{a_,b_},h_,{t1_,t2_},opts___?OptionQ]:=EpiHypotrochoid[{a,b},h,1,{t1,t2},opts]
Epitrochoid[{a_,b_},h_,{t1_,t2_,dt_},opts___?OptionQ]:=EpiHypotrochoid[{a,b},h,1,{t1,t2,dt},opts]
Epitrochoid[{a_,b_},h_,t_]:=EpiHypotrochoid[{a,b},h,1,t]

EpiHypotrochoidFrames[{a_,b_},h_,s_,t_List,opts___?OptionQ]:=Module[{i,eps=.1,range,m},
	m=Max[a+h-b,a+b s+h]+eps;
	range={{-m,m},{-m,m}};
	Graphics[{
		EpiHypotrochoid[{a,b},h,s,{0,2Pi},DisplayFunction->Identity,PlotStyle->Red][[1]],
		Table[{
			{Circle[{0,0},a]},
			{Blue,Circle[(a+s b){Cos[t[[i]]],Sin[t[[i]]]},b],
			Line[{(a+s b){Cos[t[[i]]],Sin[t[[i]]]},EpiHypotrochoid[{a,b},h,s,t[[i]]]}]
			},
			{Red,PointSize[.03],Point[EpiHypotrochoid[{a,b},h,s,t[[i]]]]}},
		{i,Length[t]}]
	},
	opts,AspectRatio->Automatic,PlotRange->All]
]

EpicycloidFrames[{a_,b_},t_List,opts___?OptionQ]:=EpiHypotrochoidFrames[{a,b},b,1,t,opts]

Hypotrochoid[{a_,b_},h_,{t1_,t2_,dt_},opts___?OptionQ]:=
	EpiHypotrochoid[{a,b},h,-1,{t1,t2,dt},opts]
Hypotrochoid[{a_,b_},h_,{t_,t_}]:=EpiHypotrochoid[{a,b},h,-1,{t,t}]
Hypotrochoid[{a_,b_},h_,{t1_,t2_},opts___?OptionQ]:=
	EpiHypotrochoid[{a,b},h,-1,{t1,t2},opts]
Hypotrochoid[{a_,b_},h_,t_]:=EpiHypotrochoid[{a,b},h,-1,t]

Hypocycloid[{a_,b_},t_]:=Hypotrochoid[{a,b},b,t]
Hypocycloid[{a_,b_},{t_,t_},opts___?OptionQ]:=Hypotrochoid[{a,b},b,{t,t},opts]
Hypocycloid[{a_,b_},{t1_,t2_},opts___?OptionQ]:=Hypotrochoid[{a,b},b,{t1,t2},opts]
Hypocycloid[{a_,b_},{t1_,t2_,dt_},opts___?OptionQ]:=Hypotrochoid[{a,b},b,{t1,t2,dt},opts]

HypocycloidFrames[{a_,b_},t_List,opts___?OptionQ]:=EpiHypotrochoidFrames[{a,b},b,-1,t,opts]

(* Evolute *)

Evolute[{x_,y_},t_]:=Module[{dx,dy,ddx,ddy,dlen,denom},
  dx=D[x,t];
  dy=D[y,t];
  ddx=D[dx,t];
  ddy=D[dy,t];
  dlen={dx,dy}.{dx,dy}; 
  denom=dx ddy - ddx dy;
  {x - dy dlen / denom, y + dx dlen / denom}
]
  
EvolutePlot[{fx_, fy_}, {var_, tmin_, tmax_}, Plotoptions___?OptionQ] :=Module[{f}, 
  f=Evolute[{fx, fy}, var];
  ParametricPlot[{f,{fx,fy}}, {var, tmin, tmax}, AspectRatio->Automatic,
  Ticks->None,
  PlotStyle->{Red,{}},Plotoptions]
]

EvolutePlot[{f_,g_},{t_,a_,b_,step_},opts___?OptionQ]:=Module[
	{
	len=LineLength/.{opts}/.Options[EvolutePlot],
	gopts=FilterOptions[Graphics,opts],
	norm=NormalVector[{f,g},t]
	},
	Show[Graphics[{
          {Blue,
            Table[Line[{{f,g}-len norm,{f,g}+len norm}],{t,a,b,step}]
            },
             ParametricPlot[{f,g},{t,a,b},Ticks->None,
              AspectRatio->Automatic,
              DisplayFunction->Identity][[1]],
          ParametricPlot[Evaluate[Evolute[{f,g},t]],{t,a,b},
              PlotStyle->{Thickness[.02],Red},
              DisplayFunction->Identity][[1]]
          }
        ],Evaluate[gopts],Axes->True,Ticks->None]
]

EvoluteFrames[{f_,g_},{t_,a_,b_,step_},opts___?OptionQ]:=Module[
	{
	len=LineLength/.{opts}/.Options[EvolutePlot],
	gopts=FilterOptions[Graphics,opts],
	t0,norm
	},
	Rest[Reverse@NestList[Drop[#,-1]&,
	Table[Graphics[{
		{
			Blue,
			norm=Function[t,Evaluate[NormalVector[{f,g},t]]][t0];
            Function[t,Line[{{f,g}-len norm,{f,g}+len norm}]][t0]
		},
		ParametricPlot[{f,g},{t,t0,t0+step},Ticks->None,
              AspectRatio->Automatic,
              DisplayFunction->Identity][[1]],
        ParametricPlot[Evaluate[Evolute[{f,g},t]],{t,t0,t0+step},
              PlotStyle->{Thickness[.02],Red},
              DisplayFunction->Identity][[1]]
        },
    Evaluate[gopts],Axes->True,Ticks->None],{t0,a,b,step}],
    1+Floor[(b-a)/step]
    ]]
]

ImplicitCurvature[g_,{x_,y_}]:=Module[{gx=D[g,x],gy=D[g,y]},
	(D[g,{x,2}]gy^2-2D[g,x,y]gx gy+D[g,{y,2}]gx^2)/(gx^2+gy^2)^(3/2)
]

InverseCurve[{fx_,fy_},{x0_,y0_,R_},t_]:=
  {x0+R(fx-x0)/((fx-x0)^2+(fy-y0)^2),y0+R(fy-y0)/((fx-x0)^2+(fy-y0)^2)}

InverseCurvePlot[{fx_,fy_},{x0_,y0_,R_},{t_,a_,b_}, Plotoptions___?OptionQ]:=Module[{f},
  f=InverseCurve[{fx,fy},{x0,y0,R},t];
  Show[
    {ParametricPlot[{f,{fx,fy}},{t,a,b},AspectRatio->Automatic,
      Ticks->None,PlotStyle->{Red,{}},DisplayFunction->Identity],
    Graphics[{Blue,PointSize[.03],Point[{x0,y0}],Circle[{x0,y0},R]}
  ]},DisplayFunction->$DisplayFunction,Plotoptions]
]
 
Involute[{x_,y_},t_]:=Module[{dx=D[x,t],dy=D[y,t],ds,s,tangent},
  ds=Sqrt[dx^2+dy^2];
  s=Integrate[ds,t];
  tangent={dx,dy}/ds;
  {x,y}-s tangent
]

InvolutePlot[{x_,y_},{t_,t0_,t1_,dt_},{c1_,c2_},opts___?OptionQ]:=Module[
	{inv=Evaluate[Involute[{x,y},t]],tt,curv,string={}},
	curv=ParametricPlot[{x,y},{t,c1,c2},AspectRatio->Automatic,
          DisplayFunction->Identity][[1]];
    Table[AppendTo[string,ParametricPlot[inv,{t,tt-dt,tt},
    		AspectRatio->Automatic,
			DisplayFunction->Identity][[1]]];
		Show[Graphics[{
			curv,
			{Red,string},
			{Blue,Line[Function[t,{{x,y},inv}][tt]]},
			{PointSize[.02],Red,Point[Function[t,inv][tt]]}
		}],
		opts,
		AspectRatio->Automatic],
	{tt,t0+dt,t1,dt}
	]
]

InvolutePlot[{fx_, fy_}, {var_, tmin_, tmax_}, opts___?OptionQ] :=Module[{f}, 
  f=Involute[{fx, fy}, var]; 
  ParametricPlot[{f,{fx,fy}}, {var, tmin, tmax}, AspectRatio->Automatic,
    Ticks->None,PlotStyle->{Red,{}},opts]
]
			
NaturalEquations[{x_,y_},t_]:=Module[
  {arc=ArcLength[{x,y},t],tanang=TangentialAngle[{x,y},t]},
  {Integrate[Cos[tanang]D[arc,t],t],Integrate[Sin[tanang]D[arc,t],t]}
]

NegativePedalCurve[{f_,g_},{x0_,y0_},t_]:=Module[{df=D[f,t],dg=D[g,t]},
  {-((x0-2f)(y0-g)df+((x0-f)f+(y0-g)^2)dg),((x0-f)^2+y0 g-g^2)df+(x0-f)(y0-2g)dg}/
    ((y0-g)df+(-x0+f)dg)
]

NormalVector[{f_,g_},t_]:=Module[{tan=TangentVector[{f,g},t]},
  {-tan[[2]],tan[[1]]}
]

NormalPlot[{f_,g_},{t_,a_,b_,step_},len_:1,opts___?OptionQ]:=Module[{norm=NormalVector[{f,g},t]},
  Show[{
    ParametricPlot[{f,g},{t,a,b},Ticks->None,AspectRatio->Automatic,
      DisplayFunction->Identity],
    Graphics[Table[Line[{{f,g},{f,g}+len norm}],{t,a,b,step}]]
    },opts,DisplayFunction->$DisplayFunction
  ]
]

Orthotomic[{f_,g_},{x_,y_},t_]:=Module[{df=D[f,t],dg=D[g,t],sq},
  sq=(df(g-y)-dg(f-x))/(df^2+dg^2);
  {-2 dg sq+x,2 df sq+y}
]

OrthotomicPlot[{f_,g_},{x_,y_},{t_,a_,b_},Plotoptions___?OptionQ]:=Module[{df=D[f,t],dg=D[g,t],sq},
  sq=(df(g-y)-dg(f-x))/(df^2+dg^2);
  ParametricPlot[{{-2 dg sq+x,2 df sq+y},{f,g}}, {t, a, b}, AspectRatio->Automatic,
    Ticks->None,PlotStyle->{Red,{}},Plotoptions]
]

OsculatingCircle[{f_,g_},t_]:=Circle[Evolute[{f,g},t],1/Abs[Curvature[{f,g},t]]]

ParallelCurve[{f_,g_},t_,k_]:=Module[{df=D[f,t],dg=D[g,t],ds},
	ds=Sqrt[df^2+dg^2];
	{f+k dg/ds,g-k df/ds}
]

ParallelCurvesPlot[{f_,g_},{k1_,k2_,kstep_},{t_,a_,b_},opts___?OptionQ]:=Module[{df,dg,ds},
  df=D[f,t];
  dg=D[g,t];
  ds=Sqrt[df^2+dg^2];
  Show[{
  ParametricPlot[Evaluate[Table[{f+k dg/ds,g-k df/ds},{k,k1,k2,kstep}]],
    {t,a,b},AspectRatio->Automatic,Ticks->None,DisplayFunction->Identity],
  ParametricPlot[{f,g},
    {t,a,b},AspectRatio->Automatic,Ticks->None,DisplayFunction->Identity,
    PlotStyle->{Thickness[.01],Red}]},
  opts,DisplayFunction->$DisplayFunction]
]

PedalCurve[{f_,g_},{x0_,y0_},t_]:=Module[{df=D[f,t],dg=D[g,t]},
  {x0 df^2+f dg^2+(y0-g)df dg,g df^2+y0 dg^2+(x0-f)df dg}/(df^2+dg^2)
]

PedalCurvePlot[{x_,y_},{x0_,y0_},{t_,a_,b_},{r0_,r1_,dr_},opts___?OptionQ]:=
  Module[{f=PedalCurve[{x,y},{x0,y0},t],tt},
  	Show[Graphics[{
  	{Blue,Table[Line[{{x0,y0},f,{x,y}}/.t:>tt],{tt,r0,r1,dr}]},
    ParametricPlot[Evaluate[{f,{x,y}}],{t,a,b},
      DisplayFunction->Identity,
      PlotStyle->{Red,{}}][[1]],
    {PointSize[.05],Point[{x0,y0}]}
	},opts,AspectRatio->Automatic,Axes->True,Ticks->None]]
]

PedalCurvePlot[{x_,y_},{x0_,y0_},{t_,a_,b_}, opts___?OptionQ]:=Module[
  {f=PedalCurve[{x,y},{x0,y0},t]},
  ParametricPlot[Evaluate[{f,{x,y}}], {t,a,b}, AspectRatio->Automatic,
  Ticks->None,PlotStyle->{Red,{}},opts]
]

PedalCurvePlot[{f_,g_},{x_,y_},{t_,t0_,t1_,dt_},{c1_,c2_},opts___?OptionQ]:=Module[
	{
	pedal=Function[t,Evaluate[PedalCurve[{f,g},{x,y},t]]],
	tt,
	u,
	u1,
	u2,
	curv,
	string={}
	},
    curv=ParametricPlot[Evaluate[{f,g}],{t,c1,c2},AspectRatio->Automatic,
          DisplayFunction->Identity][[1]];
    Table[
      AppendTo[string,
        ParametricPlot[pedal[u],{u,tt-dt,tt},AspectRatio->Automatic,
            DisplayFunction->Identity][[1]]];
      Show[Graphics[{
            curv,
            {Red,string},
            PointSize[.02],
            {Blue,
              Line[{{x,y},pedal[tt],Function[t,{f,g}][tt]}],
              Point[{x,y}],
              Line[{
                  pedal[tt]+.05(u1=unit[{x,y},pedal[tt]]),
                  pedal[tt]+.05(u1+(u2=unit[Function[t,{f,g}][tt],pedal[tt]])),
                  pedal[tt]+.05u2
              }]
            },
            {
              Point[Function[t,{f,g}][tt]]
            },
            {
              Red,
              Point[pedal[tt]]
            },
            Text[#1,#2+.06,
            	Background->White,
            	TextStyle->{FontColor->#3,FontFamily->"Times",FontSlant->"Italic"}]&@@@{
			{"O",{x,y},Blue},
			{"C",Function[t,{f,g}][tt],Black},
			{"P",pedal[tt],Red}
			}
          }
          ],opts,AspectRatio->Automatic],{tt,t0+dt,t1,dt}]
]

RadialCurve[{x_,y_},{x0_,y0_},t_]:=Module[{dx,dy,ddx,ddy,dlen,denom},
  dx=D[x,t];
  dy=D[y,t];
  ddx=D[dx,t];
  ddy=D[dy,t];
  dlen={dx,dy}.{dx,dy};
  denom=dx ddy - ddx dy;
  {x0 - dy dlen / denom, y0 + dx dlen / denom}
]

RadialCurvePlot[{fx_,fy_},{x0_,y0_},{t_,a_,b_}, Plotoptions___?OptionQ]:=Module[
  {f=RadialCurve[{fx,fy},{x0,y0},t]},
  ParametricPlot[{f,{fx,fy}}, {t, a, b}, AspectRatio->Automatic,
  Ticks->None,PlotStyle->{Red,{}},Plotoptions,Epilog->{{Red,PointSize[.03],Point[{x0,y0}]}}]
]

Reflections[{f_,g_},x_,{t_,t0_,t1_,dt_}]:=Module[
	{fn=Function[t,{f,g}],i,v,tt,n,df},
	df=Derivative[1][fn];
	Table[
		Line[{
          x,
          v=Function[t,{f,g}][tt=t0+dt i],
          v+(v-x)-2(v-x).(n=#/Sqrt[#.#]&[{{0,-1},{1,0}}.df[tt]])n
		}],
	{i,0,(t1-t0)/dt}
	]
]

Slope[r_,th_]:=(r+Tan[th]D[r,th])/(-r Tan[th]+D[r,th])

Spirograph[{p_Integer,q_Integer},a_,off_:{0,0},start_:0,opts___Rule]:=Module[
	{m=(q-p)/q,n=(q-p)/p,x=Cos[start],y=Sin[start]},
	ParametricPlot[off+{x(m Cos[t]+a Cos[n t])-y(m Sin[t]-a Sin[n t]),
          y(m Cos[t]+a Cos[n t])+x(m Sin[t]-a Sin[n t])},{t,0,2 p Pi},
    opts,DisplayFunction->Identity,AspectRatio->Automatic,PlotPoints->24,Axes->None][[1,1,1]]
]

TangentialAngle[{x_,y_},t_,opts___?OptionQ]:=
	Integrate[Curvature[{x,y},t] D[ArcLength[{x,y},t,opts],t],{t,0,t},opts]

TangentialAngle[r_,th_]:=ArcTan[r/D[r,th]]

TangentPlot[{f_,g_},{t_,a_,b_,step_},len_:1,opts___]:=Module[{tan=TangentVector[{f,g},t]},
  Show[{
    ParametricPlot[{f,g},{t,a,b},Ticks->None,AspectRatio->Automatic,
      DisplayFunction->Identity],
    Graphics[Table[Line[{{f,g},{f,g}+len tan}],{t,a,b,step}]]
    },opts,DisplayFunction->$DisplayFunction
  ]
]

TangentVector[{f_,g_},t_]:=Module[{df=D[f,t],dg=D[g,t]},
  {df,dg}/Sqrt[df^2+dg^2]
]

ThreePointCircle[{x1_,y1_},{x2_,y2_},{x3_,y3_}]:=Module[
  {
    a=Det[{{x1,y1,1},{x2,y2,1},{x3,y3,1}}],
    d=-Det[{{x1^2+y1^2,y1,1},{x2^2+y2^2,y2,1},{x3^2+y3^2,y3,1}}],
    e= Det[{{x1^2+y1^2,x1,1},{x2^2+y2^2,x2,1},{x3^2+y3^2,x3,1}}],
    f=-Det[{{x1^2+y1^2,x1,y1},{x2^2+y2^2,x2,y2},{x3^2+y3^2,x3,y3}}]
  },
  Circle[-{d,e}/(2a),Sqrt[(e^2+d^2)/(4a^2)-f/a]]
]

ThreePointCircleShow[{x1_,y1_},{x2_,y2_},{x3_,y3_},opts___?OptionQ]:=
  Show[Graphics[{PointSize[.04],Point[{x1,y1}],Point[{x2,y2}],Point[{x3,y3}],
    ThreePointCircle[{x1,y1},{x2,y2},{x3,y3}]}],opts,AspectRatio->Automatic]

Torsion[r_List?VectorQ,t_]:=Module[{dr=D[r,t],d2r},
	dr.Cross[d2r=D[dr,t],D[d2r,t]]/norm[Cross[dr,d2r]]^2
] /; Length[r]==3

(* Trochoid *)

Trochoid[{a_,b_},{t_,t_},opts___?OptionQ]:=Point[Trochoid[{a,b},t]]

Trochoid[{a_,b_},{t1_,t2_},opts___?OptionQ]:=Module[{t},
	ParametricPlot[Evaluate[Trochoid[{a,b},t]],{t,t1,t2},
	DisplayFunction->Identity,
		opts,AspectRatio->Automatic,Ticks->None][[1]]
]

Trochoid[{a_,b_},{t1_,t2_,dt_},opts___?OptionQ]:=Module[{i,t,eps=.2,range},
	range={{-a-eps,t2+a+eps},{-Max[0,b-a]-eps,Max[2a,a+b]+eps}};
	curve={};
	Table[
		Show[Graphics[{
			{Red,AppendTo[curve,Trochoid[{a,b},{If[#<0,0,#]&[t-dt],t},
				DisplayFunction->Identity]]},
			{Blue,Circle[{t,a},a]},
			Line[{{t1-a,0},{t2+a,0}}],
			{Blue,Line[{{t,a},Trochoid[{a,b},t]}]},
			{PointSize[.02],Point[{a t,a}]},
			{PointSize[.02],Red,Point[Trochoid[{a,b},t]]}
		}],
		opts,AspectRatio->Automatic,PlotRange->range,AxesOrigin->{0,0}],
	{t,t1,t2,dt}
	]
]

Trochoid[{a_,b_},t_]:={a t-b Sin[t],a-b Cos[t]}

TrochoidFrames[{a_,b_},t_List]:=Module[{i,eps=.2,range},
	range={{-a-eps,4Pi+a+eps},{-Max[0,b-a]-eps,Max[2a,a+b]+eps}};
	Show[Graphics[{
		{Red,Trochoid[{a,b},{0,4Pi},DisplayFunction->Identity]},
		Table[{
			{Blue,Circle[{t[[i]],a},a]},
			Line[{{Min[t]-a,0},{Max[t]+a,0}}],
			{Blue,Line[{{t[[i]],a},Trochoid[{a,b},t[[i]]]}]},
			{PointSize[.02],Point[{a t[[i]],a}]},
			{Red,PointSize[.02],Point[Trochoid[{a,b},t[[i]]]]}
			},
		{i,Length[t]}]
	}],AspectRatio->Automatic,PlotRange->range]
]

cycloid[t_,a_] :=Trochoid[{1,a},t]

unit[v_]:=v/Sqrt[v.v]
unit[x_?VectorQ,y_?VectorQ]:=If[x==y,{0,0},unit[x-y]]
unit[{v1_,v2_},r_]:=Module[{u=#/Sqrt[#.#]&[v2-v1],f=.8},
	{v1+f u r,v1+u r}
]

End[]

Protect[ (* ArcLength, Conchoid, ConchoidPlot, Curvature,
  Evolute, EvolutePlot, Info0, Info, InverseCurve, InverseCurvePlot, Involute, InvolutePlot,
  Orthotomic, OrthotomicPlot,
  ParallelCurvesPlot, PedalCurve, PedalCurvePlot, RadialCurve, RadialCurvePlot, TangentAngle
  *) ]

EndPackage[]