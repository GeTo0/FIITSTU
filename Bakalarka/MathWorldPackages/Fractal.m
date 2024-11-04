(*:Mathematica Version: 6.0 *)

(*:Package Version: 2.34 *)

(*:Name: MathWorld`Fractal` *)

(*:Author: Eric W. Weisstein

  Some routines written by or based on other authors:
  
  Cook, Mathew.
    KochFrillFlake from math-fun posting Oct 14, 1997.
    Tetrix by e-mail at some point in 1996-7.
  Haggerty, Patrick.  In "Fractals and Chaos" by Richard Crownover.
    SierpinskiGasket
  Kraus, Martin
    Mirroring of MengerFacade to produce MengerSponge
  Lauwerier, H.  Fractals: Endlessly Repeated Geometric Figures.
    Princeton, NJ: Princeton University Press, 1991.
    (c) 1991 Princeton University Press
    Many L-system routines are quick-and-ugly conversions of
    the BASIC routines in this book.
  Maeder, Roman.  The Mathematica Programmer.  New York: Academic Press, 1993.
    (c) 1993 Academic Press
    MengerFacade is Meader's Sierpinski.  Note that this routine only
    generates a facade of the sponge; the back is missing!
	Owners of a copy of the book may use this software and make any necessary copies on hard
	disk as well as archival copies.  Distribution to others is not 
	allowed.  Inclusion in program collections requires prior written
	permission by the copyright holder.
  Wagon, Stan.  "Mathematica in Action."  Reading, MA: Addison-Wesley, 1992.
    (c) 1992 Addison-Wesley
    Barnsley fern, filled Julia set.  
    LSystem routines strongly based on Wagon's routine.
*)

(*:URL:
  http://mathworld.wolfram.com/packages/Fractal.m
*)

(*:Summary:
*)

(*:History:
  v1.00: Written by Eric Weisstein Jun 2 and Dec 6, 1996
  v1.01: (Jun 21, 1997) Typos in KarotidKundalini fixed
  v1.02: (Jun 22, 1997) ExteriorSnowflake, KochSnowflake
  v1.50: (Oct 12, 1997) routines included
  v1.55: (Oct 18, 1997) KochFrillFlake (by Mathew Cook)
  v1.56: (Nov 28, 1997) Pentaflake added
  v1.60: (Dec  1, 1997) Peano curve corrected, syntax modified
  v1.61: (Apr 20, 1998) usage added form JuliaSetReal
  v2.00: (Apr 21, 1998) fractals from Lauwerier converted from QuickBasic
                        and added
  v2.01: (Apr 22, 1998) PythagorasTree added
  v2.02: (Jul 20, 1998) SoerpinskiArrowhead fixed
  v2.03: (Aug  9, 1998) FractalDrawArray now allows a range and 
                        FracalDraw now takes argument 0.
                        Renamed KochAntiSnowflake to KochAntisnowflake
  v2.04: (Oct  5, 1998) Whirl moved to MouseProblem`
  v2.05: (Nov  1, 1998) MengerFacade, Tetrix
  v2.06: (Nov 11, 1998) MenngerSponge
  v2.07: (Dec  6, 1998) SierpinskiCross
  v2.08: (Jul  8, 1999) Updated package documentation
  v2.09: (Jul 10, 1999) Rewrote ChaosGame, added m argument
  v2.10: (Jan  1, 1999) Updated URL
  v2.11: (Jan  4, 2002) Fixed BarnsleyFern, updated date and URL
  v2.21: (May  6, 2002) JuliaSet
  v2.22: (May 11, 2002) SierpinskiCarpet caching fixed, MandelbrotSet added
  v2.25: (Apr 18, 2003) Slightly cleaned up syntax
  v2.26: (Jun  4, 2003) Modified MengerSponge
  v2.27: (Jul 16, 2003) Pentaflake now returns a single Graphics object
  v2.28: (Oct 18, 2003) updated context
  v2.29: (Dec 25, 2004) corrected renaming of Gasket to SierpinskiGasket
  v2.30: (Jan 21, 2005) improved some formatting
  v2.31: (Mar 28, 2005) PythagorasTree now does not return a raw Graphic
  v2.32: (Nov  9, 2005) Made scalings exact.  Renamed FlowsnakeFractal as
                        GosperIsland
  v2.33: (Nov 28, 2005) Allow options to MandelbrotSet
  v2.35: (Apr  9, 2006) Exported TurtlePlot, HafermanCarpet.  Ripped out string-
                        based replacements in favor of NestList and returning
                        results suitable for ArrayPlot

  (c) 1996-2007 Eric W. Weisstein (except as noted above)
*)

(*:Keywords:
	 Fractals
*)

(*:Requirements: None. *)

(*:Discussion:
  See http://mathworld.wolfram.com/Fractal.html.

  Some fractals in this package need the Recursive routine from Wagon (1992).
  FilledJuliaSetReal from Wagon (1992).
*)

(*:References:
  Lauwerier, H.  Fractals: Endlessly Repeated Geometric Figures.
    Princeton, NJ: Princeton University Press, 1991.
  Pickover, C.A.  Keys to Infinity.  New York: W.H. Freeman, 1995.
*)

(*:Limitations:

  Speed up default case of MandelbrotSet by compiling (with option-passing,
  it is really slow right now)

  SierpinskiCross not yet generalized above n=3
  
  FilledJuliaSetReal (or perhaps OrbitCheckReal) is not working properly
    
  Many of these routines could be implemented much more cleanly and uniformly.
  This package is currently a mishmash from before Eric knew as much about Mathematica
  as he knows now.  He should really get around to cleaning up the code in this package
  at some point...  The *Motifs should be combined using DownValues.
  
*)

BeginPackage["MathWorld`Fractal`",
	{
	"Graphics`Arrow`",
	"LinearAlgebra`MatrixManipulation`", (* BlockMatrix *)
	"Utilities`FilterOptions`"
	}
]


BarnsleyFern::usage =
"BarnsleyFern[n] gives attractor of the fern equations by taking n \
interations."

BoxFractal::usage =
"BoxFractal[n] gives a graphic of the nth iteration of the box fractal."

CantorDust::usage =
"CantorDust[n] plots the iterations 1..n of Cantor dust."

CantorSquareFractal::usage =
"CantorSquareFractal[n] gives a graphic of the nth iteration of the Cantor square fractal."

Cesaro::usage =
"Cesaro[n] gives the nth iteration of the Cesaro fractal."

CesaroMotif::usage =
"CesaroMotif gives the motif for the Cesaro fractal."

ChaosGame::usage =
"ChaosGame[n,its,drop] gives its iterations of the chaos game \
on an n-gon with its points using a ratio of 1/2, dropping the 
first drop points.  ChaosGame[{n.r},its,drop] uses a ratio r."

CurveArray::usage =
"CurveArray[fractal,{i1,in}] plots a graphics array of a fractal curve."

DragonCurve::usage =
"DragonCurve[n] gives the nth dragon curve."

ExteriorSnowflake::usage =
"ExteriorSnowflake[n] gives the nth exterior snowflake."

FilledJuliaSet::usage =
"FilledJuliaSet[c, meshx, meshy, x1, x2, y1, y2, iters] shows the \
filled-in Julia set for c*z*(1-z) using the Escape Time \
algorithm on a meshx by meshy grid over the rectangle where \
x varies from x1 to x2 and y from y1 to y2.  \
The number of iterations is given by iters."

FilledJuliaSetReal::usage =
"FilledJuliaSetReal[r, meshx, meshy, x, y, iters] shows the \
filled-in Julia set for r*z*(1-z) using the Escape Time \
algorithm on a meshx by meshy grid over the rectangle where \
x varies from 0 to x and y from 0 to y.  Fourfold symmetry is \
then used to generate an image for x ranging from 0 to 1 and y \
from -y to y.  x and y should therefore be set to 0.5 to get the \
entire set.  The number of iterations is given by iters."

GosperIsland::usage =
"GosperIsland[n] generates a plot of the nth iteration of the Gosper island \
(flowsnake) fractal."

FractalDraw::usage =
"FractalDraw[n,{a,b},{l,f}] gives the nth iteration of a fractal as \
parameterized in Lauwerier."

FractalDrawArray::usage =
"FractalDrawArray[fractal,n] gives a graphics array of the first n \
iterations of the fractal.  FractalDrawArray[fractal,{n1,n2}] plots \
orders n1 to n2."

FractalMotif::usage =
"FractalMotif[motif] plots the base curve and motif for a given list."

Fractals::usage =
"Fractals gives a list of 2-D fractals defined by replacement rules."

HafermanCarpet::usage =
"HafermanCarpet[n] gives a graphic of the nth iteration of the Haferman carpet."

HFractal::usage =
"HFractal[n] gives the nth iteration of the H-fractal."

Hilbert::usage =
"Hilbert[n] generates a plot of the nth iteration of the Hilbert \
space-filling curve."

HilbertII::usage =
"HilbertII[n] generates a plot of the nth iteration of the Hilbert \
space-filling curve."

IceAntiSquare::usage =
"IceAntiSquare[n] gives the nth iteration of the IceAntiSquare fractal."

IceAntiSquareMotif::usage =
"IceAntiSquareMotif gives the motif for the IceAntiSquare fractal."

IceAntiTriangle::usage =
"IceAntiTriangle[n] gives the nth iteration of the IceAntiTriangle fractal."

IceAntiTriangleMotif::usage =
"IceAntiTriangleMotif gives the motif for the IceAntiTriangle fractal."

IceSquare::usage =
"IceSquare[n] gives the nth iteration of the IceSquare fractal."

IceSquareMotif::usage =
"IceSquareMotif gives the motif for the IceSquare fractal."

IceTriangle::usage =
"IceTriangle[n] gives the nth iteration of the IceTriangle fractal."

IceTriangleMotif::usage =
"IceTriangleMotif gives the motif for the IceTriangle fractal."

JuliaSet::usage =
"JuliaSet[its,z0,rmax,{{xmin,xmax},{ymin,ymax}},<opts>] produces \
a contour plot corresponding to the Julia set."

KochAntisnowflake::usage =
"KochAntisnowflake[n] gives the nth iteration of the Koch antisnowflake \
fractal."

KochAntisnowflakeMotif::usage =
"KochAntisnowflakeMotif gives the motif for the Koch antisnowflake fractal."

KochFrillFlake::usage =
"KochFrillFlake[it,frac] plots a pretty picture obtained by replacing the \
triangles of the Koch snowflake with rotated triangles rotated by frac of \
a complete rotation.  it determines how deep the nesting is."

KochSnowflake::usage =
"KochSnowflake[n] plots nth iteration.  \
Snowflake[n] plots nth iteration using algorithm of Notices Amer. Math. Soc. \
39, 709, 1992."

KochSnowflakeL::usage =
"KochSnowflakeL[n] gives the nth iteration of the Koch snowflake fractal."

KochSnowflakeLMotif::usage =
"KochSnowflakeLMotif gives the motif for the Koch snowflake fractal."

LevyFractal::usage =
"LevyFractal[n] gives the nth iteration of the Levy fractal."

LevyFractalMotif::usage =
"LevyFractalMotif gives the motif for the Levy fractal."

LevyTapestry::usage =
"LevyTapestry[n] gives the nth iteration of the Levy tapestry."

LevyTapestryMotif::usage =
"LevyTapestryMotif gives the motif for the Levy tapestry."

LSystemPlot::usage =
"LSystemPlot[recursion, axiom, depth, angle, steplength, \
startposn:{0.,0.}, startdir:{1.,0.}, \
dim:1000] returns the image obtained from the specified Lindenmayer system."

LSystemPath::usage =
"LSystemPath[recursion, axiom, depth, angle, steplength, \
startposn:{0.,0.},startdir:{1.,0.}, \
dim:1000] returns the path obtained by applying a Lindenmayer system to the \
sequence of movements generated by <depth> rewritings of the \
axiom.  Possible string characters are F, B, -, +."

MandelbrotSet::usage =
"MandelbrotSet[{zmin,zmax},<opts>] gives a DensityPlot of the \
Mandelbrot set in the given region.  \
MandelbrotSet[power,{zmin,zmax},<opts>] gives a DensityPlot of the \
the generalized Mandelbrot set using the specified power."

MandelbrotTree::usage =
"MandelbrotTree[n] gives the nth Mandelbrot tree for n even."

MengerFacade::usage =
"MengerFacade[n] gives that portion of the nth iteration of Menger's sponge \
which is visible from the default ViewPoint (appropriate for hardcopy)."

MengerSponge::usage =
"MengerSponge[n] gives the nth iteration of Menger's sponge."

Minkowski::usage =
"Minkowski[n] gives the nth iteration of the Minkowski fractal."

MinkowskiMotif::usage =
"MinkowskiMotif gives the motif for the Minkowski fractal."

PascalGasket::usage =
"PascalGasket[n,f] returns a graphics object giving the nth Sierpinski \
gasket with triangles labelled with the function f[#1,#2] of \
Pascal's triangle.  If not specified, f is taken to be Binomial."

PascalTriangle::usage =
"PascalTriangle[n,f] returns a graphics object giving the first n rows of \
Pascal's triangle with the function f[#1,#2]. If not specified, f is taken to be \\
Binomial."

Peano::usage =
"Peano[n] generates a plot of the nth iteration of the Peano space-filling \
curve."

PeanoGosper::usage =
"PeanoGosper[n] returns a graphics object giving the nth iteration of the \
Peano-Gosper curve."

Pentaflake::usage =
"Pentaflake[n] returns a graphics object giving the nth iteration of the \
pentaflake."

PythagorasTree::usage =
"PythagorasTree[n,bent] gives the nth iteration of the Pythagoras tree \
fractal.  bent=4 is a straight tree, bent=3 is bent."

SierpinskiGasket::usage =
"SierpinskiGasket[n] returns a graphics object which is the nth iteration \
of the outline of the Sierpinski gasket."

SierpinskiMotif::usage =
"SierpinskiMotif returns the motif for the outline of the Sierpinski gasket."

SierpinskiArrowhead::usage =
"SierpinskiArrowhead[n] returns a graphics object which is the nth iteration \
of the Sierpinski Arrowhead curve."

SierpinskiCarpet::usage=
"SierpinskiCarpet[n] gives a graphic of the nth \
iteration of the Sierpinski Carpet Fractal."

SierpinskiCross::usage =
"SierpinskiCross[n] generates a plot of the nth iteration of the Sierpinski \
curve from Cundy and Rollet and Steinhaus (1983, p. 103)."

SierpinskiCurve::usage =
"Sierpinski[n] generates a plot of the nth iteration of the Sierpinski \
fractal."

SierpinskiGasket::usage =
"SierpinskiGasket[n] generates a graphics object for the nth iteration using \
algorithm of Cronover."

Square::usage =
""

StarFractal::usage =
"StarFractal[n,v,r] gives the nth iteration of the star fractal with \
central offset v (e.g., 4, 6, 7, 8) for an angular displacement of 2Pi/r."

Tetrix::usage =
"Tetrix[n] gives the nth iteration of the tetrix."

TornSquare::usage =
"TornSquare[n] gives the nth iteration of the TornSquare fractal."

TornSquareMotif::usage =
"TornSquareMotif gives the motif for the TornSquare fractal."

TurtlePlot::usage =
"TurtlePlot[string,dang] gives a plot of the path traced by a turtle with possible rules F, B, +, - and angle dang."

(* Options *)

Options[MandelbrotSet]={
	PlotPoints->100,
	MaxIterations->500,
	Mesh->False,
	Frame->False,
	AspectRatio->Automatic,
	ColorFunction->(GrayLevel[#]&),
	MaxRadius->2.
};


Begin["`Private`"]


(* Barnsley Fern - by Stan Wagon *)

BarnsleyFern[n_]:=Module[{A1,A2,A3,A4},
  {A1,A2,A3,A4}={
    {{.85,.04},{-.04,.85}},
   	{{-.15,.28},{.26,.24}},
   	{{0.2,-.26},{.23,.22}},
   	{{0,0},{0,.16}}};
   	Graphics[
  {PointSize[.0005],Map[Point,NestList[
 	Which[
	   (r=Random[Integer,{1,100}]) <=85, A1.#+{0,1.6},
	 							r<=92, A2.#+{0,.44},
	 							r<=99, A3.#+{0,1.6},
	 							r==100,A4.# ] &,
	 {0,0},n]]}
	 ]
]

(* Box Fractal *)

FractalRules[BoxFractal] =  {1, {0 -> ZeroMatrix[3], 1 -> {{1, 0, 1}, {0, 1, 0}, {1, 0, 1}}}};

(* Cantor Dust *)

FractalRules[CantorDust] =  {1, {0 -> ZeroMatrix[3], 1 -> {{1, 0, 1}, {0, 0, 0}, {1, 0, 1}}}};

(* Cantor Square Fractal *)

FractalRules[CantorSquareFractal] =  {0, {0 -> {{0,1,0},{1,1,1},{0,1,0}}, 1 -> UnitMatrix[3]}};

(* Chaos Game *)

ChaosGame[{n_Integer?Positive,r_},pts_:1000,drop_:10]:=Module[
	{v,x0=0.,y0=0.,sc=1.,p,i,p0},
	p0=2Random[Integer,{1,n}]{x0,y0};
	v=Table[{x0,y0}+sc{Cos[Pi/2+2 Pi i/n],Sin[Pi/2+2 Pi i/n]},{i,0,n-1}];
    p=NestList[r Plus[#, v[[Random[Integer,{1,n}] ]] ]&,p0,pts];
    Drop[p,drop]
]

ChaosGame[n_Integer?Positive,pts_:1000,drop_:10]:=
	ChaosGame[{n,.5},pts,drop]

(* Curve Arrays *)

CurveArray[Fractal_,start_Integer,dim_:1000]:=CurveArray[Fractal,{start,start}]

CurveArray[Fractal_,{start_,stop_},dim_:1000,opts___?OptionQ]:=Module[{i},
  Show[GraphicsArray[Table[Fractal[i,{0,0},dim],{i,start,stop}]],opts]
]

CurveArray[Fractal_,stop_Integer,dim_:1000,opts___?OptionQ]:=CurveArray[Fractal,{1,stop},opts]

(* Dragon Curve *)

DragonCurve[p_Integer?Positive]:=Module[
		{  h1=2^(-p/2),s=0, scale=1,  xx=200,yy=200,
		x1,y1,x2,y2,path,m,n,xz,ya,xb,yb},
		x1=h1 Cos[p Pi/4.];
		y1=-h1 Sin[p Pi/4.];
		path={{xx+0,yy+0},{xx+scale*.75*x1,yy+.75*y1*scale}};
		Do[ 
			m=n;
			While[Mod[m, 2]==0, m=m/2];
			d1=If[Mod[m,4]==1,1,-1];
			s=Mod[(s+d1), 4];
			x2=x1+h1*Cos[(s-p/2)*Pi/2.];
			 y2=y1+h1*Sin[(s-p/2)*Pi/2.];
			xa=(3*x1+x2)/4;
			ya=(3*y1+y2)/4;
			xb=(x1+3*x2)/4;
			yb=(y1+3*y2)/4;
			path=Join[path,{{xx+xa*scale,yy+ya*scale},{xx+xb*scale,yy+yb*scale}}];
			x1=x2;
			y1=y2,
			{n,2^p-1}
	];
  Graphics[Line[Append[path,{xx+1*scale,0+yy}]]]
]


(* Exterior Snowflake *)

ExteriorSnowflake[n_,pos_List:{0,0},dim_:1000]:= 
  LSystemPlot[{"F"->"F-F++F-F"},"F-F-F-F-F-F",n,60,4^-n,{pos[[1]],pos[[2]]},
  {1,0},dim]

(* Fractal2D *)

Fractal2D[{n0_Integer,n1_Integer},state_,rules_]:=Drop[
  NestList[BlockMatrix[# /. rules] &, {{state}}, n1],
  n0] /; 0<=n0<=n1
Fractal2D[n_Integer?NonNegative,state_,rules_]:=Nest[BlockMatrix[# /. rules] &, {{state}}, n]

(* Fractal Drawing of Lauwerier's Fractals *)

FractalDraw[0,{bs_List,ba_List,ms_List,ma_List}]:=Module[
	{base={{0,0}},i},
	Do[
		AppendTo[base,
		base[[-1]]+bs[[i]]{Cos[ba[[i]] Degree],Sin[ba[[i]] Degree]}],
		{i,Length[ba]}
	];
	Graphics[Line[base],AspectRatio->Automatic]
]


FractalDraw[p_,{a_List,b_List,l1_List,f_List}]:=Module[
	{
		x0=-1,y0=-1,xm,ym,s=0,x,y,a1,b1,i,j,m,n,
		u=Length[a],v=Length[l1],l=l1,c={},d={},line,scale=1.,xx=0.,yy=0.
	},
	xm=x0;
	ym=y0;
	Do[ s+=l[[i]]*Cos[f[[i]] Degree],{i,v}];
	l/=s;
	c=Table[l[[i]]*Cos[f[[i]] Degree],{i,v}];
	d=Table[l[[i]]*Sin[f[[i]] Degree],{i,v}];
	line={{ xx+x0*scale,yy+y0*scale}};
	Do[
		x[1,0]=1;
		y[1,0]=0;
		s=1;
		a1=a[[q]]*Cos[b[[q]] Degree];
		b1=a[[q]]*Sin[b[[q]] Degree];
		Do[
			Do[
				x[k,j]=c[[k]]*x[1,j-1]-d[[k]]*y[1,j-1];
				y[k,j]=d[[k]]*x[1,j-1]+c[[k]]*y[1,j-1],
				{k,v}
			],
			{j,s,p}
		];
		Do[
			xs=a1*x[t,p]-b1*y[t,p];
			ys=b1*x[t,p]+a1*y[t,p];
			xm+=xs;
			ym+=ys;
			line=Append[line,{xx+scale*xm,yy+scale*ym}],
			{t,v}
		];
 		Do[
			n=m;
    		s=p;
    		While[Mod[n,v]==0,
      			n=Floor[n/v];
      			s--;
    		];
			Do[
				x[i,s-1]=x[i+1,s-1];
				y[i,s-1]=y[i+1,s-1],
				{i,v-1}
			];
			Do[
				Do[
					x[k,j]=c[[k]]*x[1,j-1]-d[[k]]*y[1,j-1];
					y[k,j]=d[[k]]*x[1,j-1]+c[[k]]*y[1,j-1],
					{k,v}
				],
				{j,s,p}
			];
			Do[
				xs=a1*x[t,p]-b1*y[t,p];
				ys=b1*x[t,p]+a1*y[t,p];
				xm=xm+xs;
				ym=ym+ys;
				line=Append[line,{xx+scale*xm,yy+scale*ym}],
				{t,v}
			],
	  		{m,v^(p-1)-1}
		],
		{q,u}
	];
	Graphics[Line[line],AspectRatio->Automatic]
]


FractalDrawArray[f_,n_:4]:=FractalDrawArray[f,{0,n}]

FractalDrawArray[f_,{min_,max_}]:=Show[GraphicsArray[
	Table[
		Show[f[i],AspectRatio->Automatic,DisplayFunction->Identity],
		{i,min,max}]],
	DisplayFunction->$DisplayFunction]

arrow[v_List]:=Table[Arrow[v[[i]],v[[i+1]]],{i,Length[v]-1}]

FractalMotif[{bs_List,ba_List,ms_List,ma_List}]:=Module[
	{base={{0,0}},motif={{0,0}},i},
	Do[
		AppendTo[base,
		base[[-1]]+bs[[i]]{Cos[ba[[i]] Degree],Sin[ba[[i]] Degree]}],
		{i,Length[ba]}
	];
	Do[
		AppendTo[motif,
		motif[[-1]]+ms[[i]]{Cos[ma[[i]] Degree],Sin[ma[[i]] Degree]}],
		{i,Length[ma]}
	];
	Show[GraphicsArray[{
		Show[Graphics[{{PointSize[.05],Point[base[[1]]]},arrow[base]}],
			DisplayFunction->Identity,AspectRatio->Automatic],
		Show[Graphics[arrow[motif]],DisplayFunction->Identity,
			AspectRatio->Automatic]
	}]]
]

(* GosperIsland *)

GosperIsland[n_Integer?NonNegative,pos_List:{0,0},dim_:1000]:=
	 LSystemPlot[{"F"->"F+F-F"},"-F+F+F+F+F+F",n,60,3^-n,
	 {pos[[1]],pos[[2]]},{1,0},dim]

(* H-Fractal *)

HFractal[p_Integer?Positive]:=Module[
		{a1=.5,b1,c1, x=0, y=0, scale=1,j,m,n,s,xx,yy,path={}},
	xx[1,0]=0;
	yy[1,0]=0;
	s=1;
	Do[
    x1=xx[1,j-1];
    y1=yy[1,j-1];
    b1=a1^j;
    c1=a1*b1*1.5;
    xx[1,j]=x1+b1; yy[1,j]=y1+c1;
    xx[2,j]=x1+b1; yy[2,j]=y1-c1;
    xx[3,j]=x1-b1; yy[3,j]=y1+c1;
    xx[4,j]=x1-b1; yy[4,j]=y1-c1;
		path=Join[path,
			{{{x+scale*(x1-b1),y+scale*y1},{x+scale*(x1+b1),y+scale*y1}},
			{{x+scale*xx[1,j],y+scale*yy[1,j]},{x+scale*xx[2,j],y+scale*yy[2,j]}},
			{{x+scale*xx[3,j],y+scale*yy[3,j]},{x+scale*xx[4,j],y+scale*yy[4,j]}}}],
			{j,s,p}
	];
		
	Do[
    n=m;
    s=p;
    While[Mod[n,4]==0,
      n=Floor[n/4];
      s--;
    ];
					
		xx[1,s-1]=xx[2,s-1];
		xx[2,s-1]=xx[3,s-1];
		xx[3,s-1]=xx[4,s-1];
		yy[1,s-1]=yy[2,s-1];
		yy[2,s-1]=yy[3,s-1];
	  yy[3,s-1]=yy[4,s-1];
			
	Do[
    x1=xx[1,j-1];
    y1=yy[1,j-1];
    b1=a1^j;
    c1=a1*b1*1.5;
    xx[1,j]=x1+b1; yy[1,j]=y1+c1;
    xx[2,j]=x1+b1; yy[2,j]=y1-c1;
    xx[3,j]=x1-b1; yy[3,j]=y1+c1;
    xx[4,j]=x1-b1; yy[4,j]=y1-c1;
		path=Join[path,
			{{{x+scale*(x1-b1),y+scale*y1},{x+scale*(x1+b1),y+scale*y1}},
			{{x+scale*xx[1,j],y+scale*yy[1,j]},{x+scale*xx[2,j],y+scale*yy[2,j]}},
		 {{x+scale*xx[3,j],y+scale*yy[3,j]},{x+scale*xx[4,j],y+scale*yy[4,j]}}}],
			{j,s,p}
	],
		{m,4^(p-1)-1}
	];
	Graphics[Line/@path]
]

(* Haferman Carpet *)

FractalRules[HafermanCarpet] =  {1, {0 -> UnitMatrix[3], 1 -> {{0, 1, 0}, {1, 0, 1}, {0, 1, 0}}}};

(* Hilbert Curve *)

Hilbert[n_,pos_List:{0,0},dim_:1000]:=
 	LSystemPlot[{"X"->"-YF+XFX+FY-","Y"->"+XF-YFY-FX+"},"Y",n,90,2^-n,
 	{pos[[1]],pos[[2]]},{1,0},dim]

(* Hilbert II Curve *)
  
HilbertII[n_,pos_List:{0,0},dim_:1000]:=
 	LSystemPlot[{"X"->"XFYFX+F+YFXFY-F-XFYFX","Y"->"YFXFY-F-XFYFX+F+YFXFY"},"X",n,90,
 	3^-n,{pos[[1]],pos[[2]]},{1,0},dim]

(* Julia Set *)

JuliaSet[n_:50,c_,rmax_:3.,{{x1_,x2_},{y1_,y2_}},opts___]:=
  DensityPlot[-Length[
        FixedPointList[#^2+c&,x+I y,n,SameTest->(Abs[#2]>rmax&)]],{x,x1,
      x2},{y,y1,y2},opts,PlotPoints->200,Mesh->False,
    Frame->False,AspectRatio->Automatic]

orbitcheck[z_,c_,iters_]:=(s=z;i=0;
		While[++i<=iters && Abs[s=s^2+c]<2];
		If[i==iters+1,{Re[z],Im[z]}*#& /@ {1,-1},{}]);
		
FilledJuliaSet[c_,meshx_Integer,meshy_Integer,
 x0_,x1_,y0_,y1_,iters_:20]:=
	Show[Graphics[{PointSize[.002], Point /@ Flatten[
 Outer[orbitcheck[#1+I #2,N[c],iters]&,
	Range[x0,x1,(x1-x0)/meshx],Range[y0,y1,(y1-y0)/meshy]],2]}],
 AspectRatio->(ymax=Max[Abs[{y0,y1}]])/(xmax=Max[Abs[{x0,x1}]]),
 PlotRange->{{-xmax,xmax},{-ymax,ymax}}];

orbitcheckreal[z_,r_,iters_]:=(s=z; i=0;
  If[Re[z] !=xold,xold=Re[z]; (*Print[xold]*)];
  While[++i<=iters && Abs[s=s^2+r]<r0];
  If[i != iters+1, {}, a=Re[z]; b=Im[z];
  Flatten[Outer[List,{a,1-a},{b,-b}],1]]);
  
FilledJuliaSetReal[r_, meshx_Integer, meshy_Integer, x_, y_, iters_]:=
  (r0=1+1/Abs[r]; xold=0;
  Show[Graphics[{PointSize[.002],
  Point /@ Flatten[
    Outer[orbitcheckreal[#1+I #2,N[r],iters]&,
      Range[0, x, x/meshx],
      Range[0, y, y/meshy]], 2]}],
  PlotRange->All, AspectRatio->y/x])
  
(* Koch Snowflake *)

KochSnowflake[n_Integer?NonNegative,opts___]:=
  Graphics[
    Nest[ (#1/.Line[{start_,finish_}] :>doline[start, finish]) &,
          {Line[{{0,0},{1/2,Sqrt[3]/2}}],
           Line[{{1/2,Sqrt[3]/2},{1,0}}],
           Line[{{1,0},{0,0}}]},
          n
    ],AspectRatio->Automatic
  ]

doline[start_,finish_]:=Module[
  {vec=finish-start,normal},
  normal=Reverse[vec] {-1,1} Sqrt[3]/6;
  {Line[{start,start + vec/3}],
    Line[{start + vec/3,start + vec/2 + normal}],
    Line[{start + vec/2 + normal, start + 2 vec/3}],
    Line[{start + 2 vec/3, finish}]
  }
]

KochSnowflake[n_,pos_List:{0,0},dim_:1000]:= 
  LSystemPlot[{"F"->"F+F--F+F"},"+F--F--F",n,60,4^-n,{pos[[1]],pos[[2]]},\
{1,0},dim]
  
(* Koch FrillFlake *)

  an=(-1)^(1/3);

  wiggle = flake[p_,d_] -> {flake[p,d/3], flake[p+2d/3,-d/3],
             flake[p+an*d/3,d/Sqrt[3an]], flake[p+an*d/3,an*d/3],
             flake[p+2an*d/3,d/3], flake[p+d/3+2an*d/3,d/an/3],
             flake[p+d,an^2d/3]};

  tri[a_] := flake[p_,d_] :> Polygon[{Re[#],Im[#]}& /@
           (p+d/Sqrt[3/an]+(-1)^(a/6)#/Sqrt[3]&) /@ {d,an^2d,an^4d}];

  KochFrillFlake[n_,a_:3,opts___]:= \
Show[Graphics[Nest[#/.wiggle&,flake[0.,1.],n]/.tri[a],
           AspectRatio->Automatic,PlotRange->{{-.03,1.03},{-.3,.88}},opts]]
  
(* L-System *)

LSystemPlot[opts___] := 
	Graphics[Line[LSystemPath[opts]],AspectRatio->Automatic,Axes->None,
	  PlotRange->All]

LSystemPath[recursion_List,axiom_String,depth_Integer,
	angle_,steplength_, startposn_List:{0,0},
	startdir_List:{1,0},dim_:1000] := Module[{},
	
	symboltable={"F"->forward, "B"->back, "-"->right,"+"->left};
	X=startposn; 
	U=startdir;
	count=1;
	c=Cos[angle Degree]; 
	s=Sin[angle Degree];
	
	Attributes[turtle]=Listable;
	  turtle[forward]:=path[[++count]]=(X+=steplength U);
	  turtle [back]  :=path[[++count]]=(X-=steplength U);
	  turtle[left]   := U=rotateleft . U;
	  turtle[right]  := U=rotateright . U;
	  
	replacerules = 
	  Map[First[Chracters[#[[1]]]] -> Characters[#[[2]]] &, recursion] /.symboltable;
	    
	path=Table[Null,{dim}]; path[[1]]=X;
	rotateleft={{c,-s},{s,c}};
	rotateright=Transpose[rotateleft];
	turtle[Nest[# /. replacerules &, Characters[axiom]/.symboltable,depth]];
	path=Take[path, count]
]



CesaroMotif:={{2,2,2,2},{0,90,-180,-90},{1,1,1,1},{0,60,-60,0}}
Cesaro[n_]:=FractalDraw[n,CesaroMotif]

IceAntiSquareMotif:={{2,2,2,2},{0,90,180,-90},{1,.7,.7,1},{0,90,-90,0}}
IceAntiSquare[n_]:=FractalDraw[n,IceAntiSquareMotif]

IceAntiTriangleMotif:={{2,2,2},{0,120,-120},{1,.4,.4,.4,.4,1},{0,120,-60,60,-120,0}}
IceAntiTriangle[n_]:=FractalDraw[n,IceAntiTriangleMotif]

IceSquareMotif:={{2,2,2,2},{0,90,180,-90},{1,.7,.7,1},{0,-90,90,0}}
IceSquare[n_]:=FractalDraw[n,IceSquareMotif]

IceTriangleMotif:={{2,2,2},{0,120,-120},{1,.4,.4,.4,.4,1},{0,-120,60,-60,120,0}}
IceTriangle[n_]:=FractalDraw[n,IceTriangleMotif]

KochSnowflakeLMotif:={{2,2,2},{0,120,-120},{1,1,1,1},{0,-60,60,0}}
KochSnowflakeL[n_]:=FractalDraw[n,KochSnowflakeLMotif]

KochAntisnowflakeMotif:={{2,2,2},{0,120,-120},{1,1,1,1},{0,60,-60,0}}
KochAntisnowflake[n_]:=FractalDraw[n,KochAntiSnowflakeMotif]

LevyFractalMotif:={{.5,.5,.5},{-90,0,90},{.353,.353},{-45,45}}
LevyFractal[n_]:=FractalDraw[n,LevyFractalMotif]

LevyTapestryMotif:={{.5,.5,.5,.5},{0,90,180,-90},{.353,.353},{-45,45}}
LevyTapestry[n_]:=FractalDraw[n,LevyTapestryMotif]

MinkowskiMotif:={{2,2,2,2},{0,90,180,-90},{Sqrt[2],Sqrt[2],Sqrt[2]},{-30,60,-30}}
Minkowski[n_]:=FractalDraw[n,MinkowskiMotif]

TornSquareMotif:={{2,2,2,2},{0,90,180,-90},{.95,.95,.95,.95},{0,86.983,-86.983,0}}
TornSquare[n_]:=FractalDraw[n,TornSquareMotif]

(* Mandelbrot Set *)

Mandelbrot=Compile[{{c,_Complex}},
      Length[FixedPointList[#^2+c&,c,500,SameTest->(Abs[#2]>2.0&)]]];

(*
MandelbrotSet[{zmin_,zmax_},opts___]:=Module[{x,y},
	DensityPlot[
		Mandelbrot[x+I y],
			Evaluate[{x,Re[zmin],Re[zmax]}],
			Evaluate[{y,Im[zmin],Im[zmax]}],
		opts,
		Mesh->False,AspectRatio->Automatic,Frame->False,
		ColorFunction->(GrayLevel[1-Chop[#/501.]]&),PlotPoints->250
	]
] /; Im[zmin]!=0||Im[zmax]!=0
*)

MandelbrotSet[{zmin_,zmax_},opts___?OptionQ]:=MandelbrotSet[#^2+c&,{c,zmin,zmax},opts]

MandelbrotSet[f_,{c_,zmin_,zmax_},opts___?OptionQ]:=Module[
	{
		dopts=FilterOptions[DensityPlot,opts,Options[MandelbrotSet]],
		its=MaxIterations/.{opts}/.Options[MandelbrotSet],
		r=MaxRadius/.{opts}/.Options[MandelbrotSet],
		x,y
	},
	DensityPlot[
		2-Length[FixedPointList[Function[c,f][x+I y],x+I y,its,SameTest->(Abs[#2]>r&)]],
		{x,Re[zmin],Re[zmax]},
		{y,Im[zmin],Im[zmax]},
		Evaluate[dopts]
	]
]/;Im[zmin]!=0||Im[zmax]!=0

MandelbrotSet[{zmin_,zmax_},opts___]:=
	MandelbrotSet[{zmin(I+1),zmax(I+1)},opts] /; Im[zmin]==Im[zmax]==0

MandelbrotSet[pow_Integer?Negative,{zmin_,zmax_},opts___]:=Module[{x,y},
  DensityPlot[-Length[
        FixedPointList[Conjugate[#]^(-pow)+(x+I y)&,x+I y,500,
          SameTest->(Abs[#2]>2.0&)]],{x,Re[zmin],Re[zmax]},{y,Im[zmin],Im[zmax]},
    opts,
    PlotPoints->200,Mesh->False,Frame->False,
    AspectRatio->Automatic,ColorFunction->Hue]
] /; Im[zmin]!=0||Im[zmax]!=0

MandelbrotSet[pow_Integer?Positive,{zmin_,zmax_},opts___]:=Module[{x,y},
  DensityPlot[-Length[
        FixedPointList[#^pow+(x+I y)&,x+I y,500,
          SameTest->(Abs[#2]>2.0&)]],{x,Re[zmin],Re[zmax]},{y,Im[zmin],Im[zmax]},
    opts,
    PlotPoints->200,Mesh->False,Frame->False,
    AspectRatio->Automatic,ColorFunction->(GrayLevel[1-Chop[#/501.]]&)]
] /; Im[zmin]!=0||Im[zmax]!=0

MandelbrotSet[n_Integer,{zmin_,zmax_},opts___]:=
	MandelbrotSet[n,{zmin(I+1),zmax(I+1)},opts] /; Im[zmin]==Im[zmax]==0&&n!=0

(* Mandelbrot Tree *)

MandelbrotTree[p_Integer?Positive]:=Module[
{ xx=200, yy=200, scale=1,
  r1=.72, r2=.67, a=3.98, b=4.38,a1=0,a2,b1=0,b2,e1=1,e2,
			f1=1,f2,c1=.5,c2,d1=.5,d2,
			u,v,x,y,u1,u2,u3,u4,v1,v2,v3,v4,x1,x2,x3,y1,y2,y3,path={}},
  a2=a;
  b2=a+r1;
  e2=b+r2;
  f2=b;
  c2=b2;  d2=e2;
  x1[0]=0; y1[0]=0; u1[0]=1; v1[0]=0;
  path={{{xx,yy},{xx+scale,yy}}};
  s=1;
	 Do[
    x=x1[j-1]; y=y1[j-1]; u=u1[j-1]; v=v1[j-1];
    x3=u-x; y3=v-y;
    x1[j]=x+a1*x3-a2*y3; y1[j]=y+a2*x3-a1*y3;
    u1[j]=x+b1*x3-b2*y3; v1[j]=y+b2*x3+b1*y3;
    x2[j]=x+e1*x3-e2*y3; y2[j]=y+e2*x3+e1*y3;
    u2[j]=x+f1*x3-f2*y3; v2[j]=y+f2*x3+f1*y3;
    u3=x+c1*x3-c2*y3; v3=y+c2*x3+c1*y3;
    u4=x+d1*x3-d2*y3; v4=y+d2*x3+d1*y3;
    If[j==p,
      u1[j]=x1[j];
      u3=u1[j];
      u4=u2[j];
      x2[j]=u2[j];
    ];
    If[j==s,h=a2; a2=f2; f2=h; h=b2; b2=e2; e2=h; h=c2; c2=d2; d2=h];
		path=Join[path,
   {{{xx+scale*x,yy+scale*y},{xx+scale*x1[j],yy+scale*y1[j]}},
    {{xx+scale*u1[j],yy+scale*v1[j]},{xx+scale*u3,yy+scale*v3},
    {xx+scale*u4,yy+scale*v4},{xx+scale*x2[j],yy+scale*y2[j]}},
    {{xx+scale*u2[j],yy+scale*v2[j]},{xx+scale*u,yy+scale*v}}}],
{j,s,p}
];

Do[
   s=p;
    n=m;
    While[Mod[n,2]==0,
      n=Floor[n/2];
      s--;
    ];
    h=a2; a2=f2; f2=h; h=b2; b2=e2; e2=h; h=c2; c2=d2; d2=h;
		x1[s-1]=x2[s-1]; y1[s-1]=y2[s-1];
		u1[s-1]=u2[s-1]; v1[s-1]=v2[s-1];
	 Do[
    x=x1[j-1]; y=y1[j-1]; u=u1[j-1]; v=v1[j-1];
    x3=u-x; y3=v-y;
    x1[j]=x+a1*x3-a2*y3; y1[j]=y+a2*x3-a1*y3;
    u1[j]=x+b1*x3-b2*y3; v1[j]=y+b2*x3+b1*y3;
    x2[j]=x+e1*x3-e2*y3; y2[j]=y+e2*x3+e1*y3;
    u2[j]=x+f1*x3-f2*y3; v2[j]=y+f2*x3+f1*y3;
    u3=x+c1*x3-c2*y3; v3=y+c2*x3+c1*y3;
    u4=x+d1*x3-d2*y3; v4=y+d2*x3+d1*y3;
    If[j==p,
      u1[j]=x1[j];
      u3=u1[j];
      u4=u2[j];
      x2[j]=u2[j];
    ];
    If[j==s,h=a2; a2=f2; f2=h; h=b2; b2=e2; e2=h; h=c2; c2=d2; d2=h];
		path=Join[path,
   {{{xx+scale*x,yy+scale*y},{xx+scale*x1[j],yy+scale*y1[j]}},
    {{xx+scale*u1[j],yy+scale*v1[j]},{xx+scale*u3,yy+scale*v3},
    {xx+scale*u4,yy+scale*v4},{xx+scale*x2[j],yy+scale*y2[j]}},
    {{xx+scale*u2[j],yy+scale*v2[j]},{xx+scale*u,yy+scale*v}}}],
{j,s,p}
],
 {m, 2^(p-1)-1}
];
Graphics[Line/@path]
]

(* Menger Sponge *)

cheese[0, False, False, False, __ ] := {} (* small optimization *)

cheese[0, right_, front_, top_, x0_, y0_, z0_] :=
  With[{xs = x0+1, ys = y0+1, zs = z0+1},
    { If[right,
         Polygon[{{xs, y0, z0}, {xs, ys, z0}, {xs, ys, zs}, {xs, y0, zs}}],
         {} ],
      If[front,
         Polygon[{{x0, y0, z0}, {xs, y0, z0}, {xs, y0, zs}, {x0, y0, zs}}],
         {} ],
      If[top,
         Polygon[{{x0, y0, zs}, {xs, y0, zs}, {xs, ys, zs}, {x0, ys, zs}}],
         {} ]
    }
  ]

cheese[n_, right_, front_, top_, x0_, y0_, z0_] :=
  With[{ xs = x0 + 3^(n-1), xt = x0 + 2 3^(n-1),
         ys = y0 + 3^(n-1), yt = y0 + 2 3^(n-1),
         zs = z0 + 3^(n-1), zt = z0 + 2 3^(n-1),
         n1 = n - 1},
   {
    (* bottom layer *)
    cheese[n1, False, front, False, x0, y0, z0],
    cheese[n1, False, front, True , xs, y0, z0],
    cheese[n1, right, front, False, xt, y0, z0],
    cheese[n1, True , False, True , x0, ys, z0],
    cheese[n1, right, False, True , xt, ys, z0],
    cheese[n1, False, False, False, x0, yt, z0],
    cheese[n1, False, True , True , xs, yt, z0],
    cheese[n1, right, False, False, xt, yt, z0],
    (* middle layer *)
    cheese[n1, True , front, False, x0, y0, zs],
    cheese[n1, right, front, False, xt, y0, zs],
    cheese[n1, True , True , False, x0, yt, zs],
    cheese[n1, right, True , False, xt, yt, zs],
    (* top layer *)
    cheese[n1, False, front, top  , x0, y0, zt],
    cheese[n1, False, front, top  , xs, y0, zt],
    cheese[n1, right, front, top  , xt, y0, zt],
    cheese[n1, True , False, top  , x0, ys, zt],
    cheese[n1, right, False, top  , xt, ys, zt],
    cheese[n1, False, False, top  , x0, yt, zt],
    cheese[n1, False, True , top  , xs, yt, zt],
    cheese[n1, right, False, top  , xt, yt, zt]
   }
]

MengerFacade[ n_Integer?NonNegative ] :=Module[{polylist},
        polylist = {EdgeForm[], cheese[n, True, True, True, 0, 0, 0]};
        polylist = Flatten[ polylist ];
        polylist
]

MirroredPoint[center_,vec_]:=center+center-vec;

MirroredPointList[center_,points_]:=Module[{i},
		Table[MirroredPoint[center,points[[i]]],{i,Length[points]}]];

Mirrored[center_,expr_]:=Module[{mPolygon,mPoint,mLine,result=expr},
		result = result //. {
          Polygon[list_]:>{mPolygon[list],
              mPolygon[MirroredPointList[center,list]]},
          Line[list_]:>{mLine[list],mLine[MirroredPointList[center,list]]},
          Point[list_]:>{mPoint[list],
              mPoint[MirroredPointList[center,{list}][[1]]]}};
		result=result//.{mPolygon:>Polygon,mLine:>Line,mPoint:>Point};
		result];

MengerSponge[n_Integer?NonNegative]:=Module[
	{sc=3^n/2.,m=MengerFacade[n]},
	Mirrored[{sc,sc,sc},m]
]

(* Pascal's Triangle *)

BW[n_Integer]:=Which[OddQ[n],1.,EvenQ[n],0.,True,.5]

PascalTriangle[n_Integer?Positive,f_:Binomial]:=
	Module[{i,j,out={},c=0.433013,scale=1/2^(Log[2,n+1])},
  Do[
    out=Append[out,Table[
      {GrayLevel[BW[Binomial[i,j]]],
      Text[f[i,j],{1/2+(j-i/2)scale,2. (n-i+.4) c scale}]},
      {j,0,i}]],
    {i,0,n}
  ];
  out
]

PascalGasket[n_,f_:Binomial]:={SierpinskiGasket[n],PascalTriangle[2^n-1,f]}

(* Peano Curve *)

Peano[n_,pos_List:{0,0},dim_:1000]:= 
  LSystemPlot[{"F"->"F+F-F-F-F+F+F+F-F"},"F",n,
  90,4^-n,{pos[[1]],pos[[2]]},{1,0},dim]

(* Peano-Gosper Curve *)

PeanoGosper[n_,pos_List:{0,0},dim_:1000]:= 
  LSystemPlot[{"X"->"X+YF++YF-FX--FXFX-YF+","Y"->"-FX+YFYF++YF+FX--FX-Y"},"FX",n,
  60,4^-n,{pos[[1]],pos[[2]]},{1,0},dim]
  
(* Pentaflake *)

Pentaflake[n_]:=Graphics[Pentaflake[n,{0,0},0],AspectRatio->Automatic]
Pentaflake[0,{x_,y_},rot_]:=
  Polygon[Table[{x,y}+{Cos[2Pi/5 i+rot],Sin[2Pi/5 i+rot]},{i,5}]]
Pentaflake[n_,{x_,y_},rot_]:=Join[
	Table[Pentaflake[n-1,{x,y}+GoldenRatio^(2n-1){Cos[2Pi/5 i+rot],Sin[2Pi/5 i+rot]},rot],{i,5}],
	{Pentaflake[n-1,{x,y},rot+Pi/5]}
]

(* Pythagoras Tree *)

PythagorasTree[p1_,bent_:4]:=Module[ (* Bent=3 *)
	{ 
		p=2^p1,xx=0,yy=0,scale=-1,f=Pi/bent//N,
		c,cc,ss,sxy,eps=.005,a1,a2,b1,b2,c1,c2,d1,d2,x1=0,
		y1=0,u1=1,v1=0,q=0,j=1,
   		k,m,xa,xb,ya,yb,done=False,tree={}
    },
	cc=Cos[f];
	ss=Sin[f];
	a1=-cc*ss;
	a2=cc^2;
	b1=a1+a2;
	b2=-a1+a2;
	c1=b2;
	c2=1-b1;
	d1=1-a1;
	d2=1-a2;
	s[0]=1;
	tree={{{xx,yy},{xx+scale,yy},{xx+scale,yy+scale},{xx,yy+scale},{xx,yy}}};
	While[!done,
		m=q+j;
		x=u1-x1;
		y=v1-y1;
		xa=x1+a1*x-a2*y; ya=y1+a2*x+a1*y;
		xb=x1+b1*x-b2*y; yb=y1+b2*x+b1*y;
		x2[m]=x1+c1*x-c2*y; y2[m]=y1+c2*x+c1*y;
		u2[m]=x1+d1*x-d2*y; v2[m]=y1+d2*x+d1*y;
		sxy=x*x+y*y; s[m]=1;
		tree=Append[tree,
			{{xx+scale*x1,yy-scale*y1},{xx+scale*xa,yy-scale*ya},
			{xx+scale*xb,yy-scale*yb},{xx+scale*u1,yy-scale*v1},
			{xx+scale*u2[m],yy-scale*v2[m]},{xx+scale*x2[m],yy-scale*y2[m]},
			{xx+scale*x1,yy-scale*y1}}];
		x1=xa; y1=ya; u1=xb; v1=yb;
		If[m==p || sxy<eps,
			k=1;
			While[s[m-k]==0,k++];
 			If[m==k,done=True,
				q=m-k;
				x1=x2[q];
				y1=y2[q];
				u1=u2[q];
				v1=v2[q];
				s[q]--;j=0;
			];		
		];
 		j++;
	];
	Line/@tree
]

(* Sierpinski Arrowhead *)

SierpinskiArrowhead[n_,pos_List:{0,0},dim_:1000]:= 
  LSystemPlot[{"X"->"YF+XF+Y","Y"->"XF-YF-X"},"YF",n,60,7^-n,{pos[[1]],pos[[\
2]]},{1,0},dim]
  
(* Sierpinski Carpet *)

FractalRules[SierpinskiCarpet] =  {1, {0 -> ZeroMatrix[3], 1 -> {{1, 1, 1}, {1, 0, 1}, {1, 1, 1}}}};

(* Sierpinski Curve *)

SierpinskiCurve[n_,pos_List:{0,0},dim_:1000]:=
 	LSystemPlot[{"X"->"XF-F+F-XF+F+XF-F+F-X"},"F+XF+F+XF",n,90,4^-n,{pos[[1]],
pos[[2]]},{1,0},dim]

(* Sierpinski Sieve

   Code adapted from Patrick Haggerty to produce the graphics for the 
   Sierpinski gasket in Richard Crownover's book Fractals and Chaos.
*)

SierpinskiGasket[0]:=Graphics[Polygon[{{0,0},{1./2.,Sqrt[3.]/2.},{1,0}}],
AspectRatio->Automatic]

SierpinskiGasket[level_Integer?NonNegative]:=Module[
	{newF,G,F,sierp,i,j,k,trans,group1,group2},
	(* trans={{a1,b1,c1,d1,e1,f1},
	   		   {a2,b2,c2,d2,e2,f2},
	   		   {a3,b3,c3,d3,e3,f3}} represents the
	   coefficients of the affine transformations of
	   the iterated function system given by
	   Ti(x)=|ai bi|x + |ei|   i=1,2,3 
 	        |ci di|    |fi|
 	   which produces the Sierpinski Gasket          *) 
	trans={{1/2,0,0,1/2,0,0},{1/2,0,0,1/2,1/2,0},{1/2,0,0,1/2,1/4,Sqrt[3]/4}};
  	group1[list_]:={{list[[1]],list[[2]]},{list[[3]],list[[4]]}};
  	group2[list_]:={{list[[5]]},{list[[6]]}};
  	F={{0,0},{1/2,Sqrt[3]/2},{1,0},{0,0}};
  	G=F;
 	For[k=1,k<level+1,k++,
	  	F=Partition[Flatten[G],2];
	  	G={};
	  	For[i=1,i<(Length[trans]+1),i++,
	   		newF=F;
	   		For[j=1,j<(Length[F]+1),j++,
			     newF=ReplacePart[newF,group1[trans[[i]]].F[[j]]+group2[trans[[i]]],j];
	    	];
	  	 	G=Append[G,newF];
	  	];
  	 G=Partition[Partition[Flatten[G],2],4];
	];
 	Polygon/@G
]

SierpinskiGasket[p_]:=Module[
		{xx=0,yy=0,scale=1,a=Sqrt[3.],m,n,t,u1,u2,v1,v2,n1,line},
   line={{{xx-a*scale,yy+scale},{xx,yy-2*scale},
		{xx+a*scale,yy+scale},{xx-a*scale,yy+scale}}};
  Do[
    Do[
      n1=n;
      Do[
        t[l]=Mod[n1, 3];
        n1=Floor[n1/3],
      {l,0,m-1}
					];
      x=0;y=0;
      Do[
        x+=Cos[(4*t[k]+1)*Pi/6.]/2^k;
        y+=Sin[(4*t[k]+1)*Pi/6.]/2^k,
		{k,0,m-1}
				];
      u1=x+a/2^(m+1);
      u2=x-a/2^(m+1);
      v1=y-1/2^(m+1);
      v2=y+1/2^m;
      line=Append[line,
						{{xx+scale*u1,yy+scale*v1},{xx+scale*x,yy+scale*v2},
    {xx+scale*u2,yy+scale*v1},{xx+scale*u1,yy+scale*v1}}],
   {n,0,3^m-1}
							],
		{m,0,p}
				];
		Graphics[Line/@line]
]

(* Sierpinski Cross *)

sc[1]:="F-F++F++F-FF-F++F++F-FF-F++F++F-FF-F++F++F-F";
sc[2]:=StringReplace[sc[1],
    "F-F++F++F-F"->"F-F-FF-F++F++F-FF-F++F++F-FF-F++F++F-FF-F-F"];
sc[3]:=StringReplace[sc[2],
    "F-F-FF-F++F++F-FF-F++F++F-FF-F++F++F-FF-F-F"->
      "F-F-FF-F++F++F-FF-F-FF-F-FF-F++F++F-FF-F++F++F-FF-F++F++F-FF-F-FF-F-FF-\
F++F++F-FF-F++F++F-FF-F++F++F-FF-F-FF-F-FF-F++F++F-FF-F++F++F-FF-F++F++F-FF-F-\
FF-F-FF-F++F++F-FF-F-F"];

SierpinskiCross[n_Integer?Positive /; n<=3,opts___]:=
	Show[TurtlePlot[sc[n],45Degree],opts,AspectRatio->Automatic]

(* Star Fractal *)

StarFractal[p_Integer?Positive,v_Integer:4,s_:5/2 ]:=Module[
	{a1=2.Pi/s, r=.35,xx=0.,yy=0.,scale=1.,x1=0,y1=0,f,m,n,b1,star},
	star={{xx,yy}};
	Do[
		m=n;
		b1=n*a1;
		f=0;
		While[!(Mod[m,v]!=0 || f>=p-1),
			f++;
			m=Floor[m/v];
   		 ];
		x1+=r^(p-f-1)*Cos[b1];
		y1+=r^(p-f-1)*Sin[b1];
		star=Append[star,{xx+scale*x1,yy+scale*y1}],
	{n,0,(v+1)*v^(p-1)-1}];
	Graphics[Line[star]]
]

(* Tetrix *)

TetraVec[i_]:= 2 IntegerDigits[3i-2,2,3] - 1
tetrix[-1, p_:{0,0,0}]:=Polygon /@ Array[TetraVec[#]+
	p & /@ Delete[Range[4], #]&, 4]
tetrix[n_, p_:{0,0,0}]:=Array[tetrix[n-1, p + TetraVec[#] 2^n]&, 4]
Tetrix[n_,p_:{0,0,0}]:=Graphics3D[tetrix[n-1,p]]

(* Turtle Plot *)

rot[a_]:={{Cos[a],Sin[a]},{-Sin[a],Cos[a]}}

TurtlePlot[s_String,r_]:=Module[{p={{0,0}},i,ang=0},
	Do[
		Switch[StringTake[s,{i}],
			"F",AppendTo[p,p[[-1]]+rot[ang].{1,0}],
			"B",AppendTo[p,p[[-1]]-rot[ang].{1,0}],
			"+",ang+=r,
			"-",ang-=r
		],
		{i,StringLength[s]}];
	Graphics[Line[p]]
]

(* Unit Matrix *)

UnitMatrix[n_]:=Table[1,{n},{n}]

(*****)
(* Define classes of fractals based on DownValues *)

Fractals:=#[[1,1,1]]&/@DownValues[FractalRules];

(#[{n0_Integer,n1_Integer}]:=Fractal2D[{n0,n1},Sequence@@FractalRules[#]] /; 0<=n0<=n1)&/@Fractals;
(#[n_Integer?NonNegative]:=Fractal2D[n,Sequence@@FractalRules[#]])&/@Fractals;

End[]

Protect[ (* *) ]

EndPackage[]