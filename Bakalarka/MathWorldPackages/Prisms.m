(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.09 *)

(*:Name: MathWorld`Prisms` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Prisms.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-01-12): Broken off from MiscPolyhedra.m.
                      PentagonalPrism6Compound
  v1.01 (2003-08-17): Rhombohedron
  v1.02 (2003-10-05): Renamed Wedge to SolidWegde
  v1.03 (2003-10-19): updated contexts
  v1.04 (2003-11-21): Fixed Antiprism
  v1.05 (2003-12-25): Converted contructors to use PolyhedronFaces[]
                      and PolyehdronVertices[].  Moved Prism-type solids
                      here.
  v1.06 (2004-02-10): Fixed Frustum
  v1.07 (2004-09-14): Fixed Net[Antiprism[]], added names for antiprisms
  v1.08 (2005-02-15): PolyhedronName for solids with polygonal bases
  v1.09 (2006-05-10): Fixed Net[Prism[]]
  v1.10 (2006-05-15): Pyramid now supports a bade radius
  
  (c) 2002-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements:

  Requires
  
    http://mathworld.wolfram.com/packages/Polygons.m
    http://mathworld.wolfram.com/packages/PolyhedronOperations.m

*)

(*:Discussion:
*)

(*:References: *)

(*:Limitations:

Should rewrite constructors to generate faces and vertices directly instead of
generating solids and then extracting the face and vertex information.

Ditto for nets.
*)

BeginPackage["MathWorld`Prisms`",
	{
	"MathWorld`PolyhedronOperations`",
	"MathWorld`Platonic`", (* AugmentedDodecahedron *)
	"MathWorld`Polygons`"
	}
]


Antiprism::usage =
"Polyhedron[Antiprism[n]] generates an n-sided regular antiprism of side and \
lateral edge length 1.  Polyhedron[Antiprism[n,h]] generates an n-sided regular \
antiprism of side length 1 and height h.  Polyhedron[Antiprism[n,h,s]] generates \
an n-sided regular antiprism of side length s and height h.  \
Net[Antiprism[n]] gives the net of the n-gonal antiprism of height 1.  \
Net[Antiprism[n,h]] gives the net of the n-gonal antiprism of height h."

AugmentedDodecahedron::usage =
"Polyhedron[AugmentedDodecahedron] gives an augemented dodecahedron.  \
Polyhedron[AugmentedDodecahedron[l]] gives a dodecehedron with faces \
augmented."

AugmentedPrism::usage =
"Polyhedron[AugmentedPrism[n]] gives an n-gonal prism with square pyramid \
attached to one lateral face."

Cupola::usage =
"Polyhedron[Cupola[n]] gives the n-gonal cupola of unit edge lengths (which only \
exists for n=3, 4, 5.  Polyhedron[Cupola[n,h]] gives the n-gonal cupola of height h."

Dipyramid::usage =
"Polyhedron[Dipyramid[{v1,...,vn},{x,y,h}]] gives the dipyramid with base v and vertex \
{x,y,n}.  Polyhedron[Dipyramid[{v1,...,vn},h]] gives the dipyramid with base v and \
vertex {0,0,h}."

ElongatedCupola::usage =
"Polyhedron[ElongatedCupola[n]] gives a list of polygons representing the n-gonal \
elongated cupola."

ElongatedDipyramid::usage =
"Polyhedron[ElongatedDipyramid[n]] gives a list of polygons representing the n-gonal \
elongated dipyramid."

ElongatedGyrobicupola::usage =
"Polyhedron[ElongatedGyrobicupola[n]] gives an elongated gyrobicupola."

ElongatedGyrobirotunda::usage =
"Polyhedron[ElongatedGyrobirotunda[n]] gives an elongated gyrobirotunda \
for values of n sufficiently close to 5."

ElongatedGyrocupolarotunda::usage =
"Polyhedron[ElongatedGyrocupolarotunda[n]] gives the elongated orthocupolarotunda \
for values of n sufficiently close to 5."

ElongatedOrthobicupola::usage =
"Polyhedron[ElongatedOrthobicupola[n]] gives the elongated orthobicupola."

ElongatedOrthobirotunda::usage =
"Polyhedron[ElongatedOrthobirotunda[n]] gives the elongated orthobirotunda \
for values of n sufficiently close to 5."

ElongatedOrthocupolarotunda::usage =
"Polyhedron[ElongatedOrthocupolarotunda[n]] gives the elongated orthocupolarotunda \
for values of n sufficiently close to 5."

ElongatedPyramid::usage =
"Polyhedron[ElongatedPyramid[n]] gives a list of polygons representing the n-gonal \
elongated pyramid."

ElongatedRotunda::usage =
"Polyhedron[ElongatedRotunda[5]] gives a list of polygons representing the 5-gonal \
elongated rotunda."

Frustum::usage =
"Polyhedron[Frustum[{v1,...,vn},{x,y,h},s]] gives the frustun with base v, top center \
{x,y,h}, and top scaled by a factor s.  Polyhedron[Frustum[{v1,...,vn},h,s]] gives the \
frustum with base v, top centered at {0,0,h}, and top scaled by a factor s."

GoldenRhombohedron::usage =
"GoldenRhombohedron gives a golden rhombohedron."

Gyrobicupola::usage =
"Polyhedron[Gyrobicupola[n]] gives the n-gonal gyrobicupola."

Gyrobifastigium::usage =
"Polyhedron[Gyrobifastigium] gives the gyrobifastigium."

Gyrocupolarotunda::usage =
"Polyhedron[Gyrocupolarotunda[n]] gives the n-gonal gyrocupolarotunda \
for values of n sufficiently close to 5."

GyroelongatedBicupola::usage =
"Polyhedron[GyroelongatedBicupola[n]] gives the gyroelongated bicupola \
of n sides."

GyroelongatedBirotunda::usage =
"Polyhedron[GyroelongatedBirotunda[n]] gives the gyroelongated birotunda \
of n sides for values of n sufficiently close to 5."

GyroelongatedCupola::usage =
"Polyhedron[GyroelongatedCupola[n]] gives the gyroelongated cupola on \
a 2n-gonal base."

GyroelongatedCupolarotunda::usage =
"Polyhedron[GyroelongatedCupolarotunda[n]] gives the n-gonal \
gyroelongatedcupolarotunda for values of n sufficiently close to 5."

GyroelongatedPyramid::usage =
"Polyhedron[GyroelongatedPyramid[n]] gives the gyroelongated pyramid on \
an n-gonal base."

GyroelongatedRotunda::usage =
"Polyhedron[GyroelongatedRotunda[n]] gives the gyroelongated pentagonal rotunda \
for values of n sufficiently close to 5."

Orthobicupola::usage =
"Polyhedron[Orthobicupola[n]] gives the orthobicupola on n vertices."

Orthobirotunda::usage =
"Polyhedron[Orthobirotunda[n]] gives the pentagonal orthobirotunda for values of \
n sufficiently close to 5."

Orthocupolarotunda::usage =
"Polyhedron[Orthocupolarotunda[n]] gives the orthocupolarotunda for values of n \
sufficiently close to 5."

PentagonalPrism6Compound::usage =
"Polyhedron[PentagonalPrism6Compound] gives the analytic vertices of \
a compound of six pentagonal pyramids."

Prism::usage =
"Polyhedron[Prism[n]] generates an n-sided regualar prism.  Prism[{v1,...,vn},h,{x,y}] \
generates a prism having top and bottom of shape v, height h, and top-bottom offset of \
{x,y}.  Net[Prism[n]] gives the net of the n-gonal prism of height 1.  Net[Prism[n,h]] \
gives the net of the n-gonal prism of height h."

Pyramid::usage =
"Polyhedron[Pyramid[n,h]] gives a right regular n-sided pyramid of height h and base edge length 1.  \
Polyhedron[Pyramid[n,h,a]] gives a right regular n-sided pyramid of height h and base edge length a.  \
Polyhedron[Pyramid[{v1,...,vn},h]] gives the pyramid with base v and vertex {0,0,h}.  \
Polyhedron[Pyramid[{v1,...,vn},{x,y,h}]] gives the pyramid with base v and vertex \
{x,y,n}."

PyramidalFrustum::usage =
"Polyhedron[PyramidalFrustum[n,h,s]] gives a pyramidal frustum of n sides, \
height h, and top scaled by s."

Rhombohedron::usage =
"Polyhedron[Rhombohedron[{vx,vy}]] gives a rhombohedron using {1,0,0} and \
{vx,vy,0} as basis vectors in the plane."

Rotunda::usage =
"Polyhedron[Rotunda[n]] gives the n-rotunda, with the only true member corresponding \
to n=5."

SolidWedge::usage =
"Polyhedron[SolidWedge[{a,b},h,x]] gives a wedge with base rectangle a x b, height h, \
and indents x on the top.  Polyhedron[SolidWedge[{a,b},h]] gives \
Polyhedron[SolidWedge[{a,b},h,0]]."



Begin["`Private`"]

addn[n_,k_,m_]:=Mod[n+k-1,m]+1

(* Antiprism *)

antiprism[n_Integer?(#>2&)]:=antiprism[n,Sqrt[1-Sec[Pi/2/n]^2/4]]

antiprism[n_Integer?(#>2&),h_]:=antiprism[n,h,1]

antiprism[n_Integer?(#>2&),h_,s_]:=Module[
  {i,R=s Csc[Pi/n]/2,z=h/2},
  Orient[Flatten[{
    Polygon[Table[rim2[-z,R,n][[i]],{i,n}]],
    Polygon[Table[rim1[z,R,n][[i]],{i,n}]],
    Table[Polygon[{rim1[z,R,n][[i]],rim1[z,R,n][[i+1]],
    	rim2[-z,R,n][[i]]}],{i,n}],
    Table[Polygon[{rim2[-z,R,n][[i]],rim2[-z,R,n][[i+1]],
    	rim1[z,R,n][[i+1]]}],{i,n}]
   }]]
]

PolyhedronName[Antiprism[n_Integer,args___]]:=PolygonalName[n]<>" antiprism" /;
	n>2 && Head[PolygonalName[n]]=!=PolygonalName
PolyhedronName[Antiprism[args__]]:="antiprism"
PolyhedronFaces[Antiprism[args__]]:=PolyhedronFaces[antiprism[args]]
PolyhedronVertices[Antiprism[args__]]:=PolyhedronVertices[antiprism[args]]

antiprismNet[n_,h_:1]:=antiprismNet[n,h,1]

antiprismNet[n_,h_,s_]:=Module[
	{half=Floor[n/2],r=s Cot[Pi/n]/2,R=s Csc[Pi/n]/2,
	bot,top,ribbon1,ribbon2,
	i,x,dx,ddx,dy},
    dy=If[OddQ[n],R,r];
    dx=If[OddQ[n],1/2,0];
    ddx=If[OddQ[n],0,1];
    bot=Table[{s(dx+half+1/2)+R Sin[2Pi(i-3/2)/n],dy+R Cos[2Pi(i-3/2)/n]},
    	{i,0,n}];
    top=Table[{s(dx+half)+R Sin[2Pi (i-3/2)/n],dy+h-R Cos[2Pi(i-3/2)/n]+2r},
    	{i,0,n}];
    ribbon1=Table[{{s x,r+dy},{s(x+1/2),r+h+dy},{s(x+1),r+dy},{s x,r+dy}},
    	{x,dx,dx+n-1}];
    ribbon2=Table[{{s(x-1/2),r+h+dy},{s x,r+dy},{s(x+1/2),r+h+dy},{s(x-1/2),r+h+dy}},
    	{x,ddx+dx,ddx+dx+n-1}];
    Flatten[{Line/@{bot,top},Line/@ribbon1,Line/@ribbon2}]
]

NetFaces[Antiprism[args__]]:=NetFaces[antiprismNet[args]//RootReduce]
NetVertices[Antiprism[args__]]:=NetVertices[antiprismNet[args]//RootReduce]

(* Augmented Dodecahedron *)

augmentedDodecahedron[l_List:{1}]:=Module[
	{d=Flatten[Polyhedron[Dodecahedron]],h=Sqrt[1-Csc[Pi/5]^2/4]},
    {drop[d,l],CumulateFace[d[[#]],h]&/@l}
]

PolyhedronName[AugmentedDodecahedron[args___]]:="augmented dodecahedron"
PolyhedronFaces[AugmentedDodecahedron[args___]]:=
	PolyhedronFaces[augmentedDodecahedron[args]]
PolyhedronVertices[AugmentedDodecahedron[args___]]:=
	PolyhedronVertices[augmentedDodecahedron[args]]

(* Augmented Prism *)

augmentedPrism[n_Integer?(3<=#<=6&),l0_List:{1}]:=Module[
	{p=Polyhedron[Prism[n]],h=Sqrt[1-Csc[Pi/4]^2/4],l=l0+2},
    {drop[p,l],CumulateFace[p[[#]],h]&/@l}
]

PolyhedronName[AugmentedPrism[args__]]:="augmented prism"
PolyhedronFaces[AugmentedPrism[args__]]:=PolyhedronFaces[augmentedPrism[args]]
PolyhedronVertices[AugmentedPrism[args__]]:=PolyhedronVertices[augmentedPrism[args]]

(* Cupola *)

cupola[n_,h_:0]:=Module[{
      i,top,bot,
      r=Csc[Pi/n]/2,
      R=Csc[Pi/2/n]/2
	},
    z=If[h==0,Sqrt[1-Csc[Pi/n]^2/4],h];
    bot=Table[{R Cos[#],R Sin[#],0}&[Pi(2i+1)/2/n],{i,2n}];
    top=Table[{r Cos[#],r Sin[#],z}&[2Pi i/n],{i,n}];
	{
      Polygon/@{top,Reverse[bot]},
      Polygon/@Table[{top[[addn[i,1,n]]],top[[i]],bot[[2i]],bot[[addn[2i,1,2n]]]},
        {i,n}],
      Polygon/@Table[Reverse[{top[[i]],bot[[2i]],bot[[addn[2i,-1,2n]]]}],{i,n}]
	}
]

PolyhedronName[Cupola[args__]]:="cupola"
PolyhedronFaces[Cupola[args__]]:=PolyhedronFaces[cupola[args]]
PolyhedronVertices[Cupola[args__]]:=PolyhedronVertices[cupola[args]]

(* Dipyramid *)

dipyramid[v_List,{x_,y_,h_},opts___]:=Module[
	{base=Map[Append[#,0]&,Partition[v,2,1,1],{2}]},
	Map[Polygon,{Append[#,{x,y,h}]&/@base,Reverse/@(Append[#,{x,y,-h}]&/@base)},{2}]
]

dipyramid[v_List,h_:1,opts___]:=dipyramid[v,{0,0,h},opts]

dipyramid[n_Integer /; n>=3,{x_,y_,h_},opts___]:=Module[{i,v,R=Csc[Pi/n]/2},
	v=Table[R{Cos[2Pi i/n],Sin[2Pi i/n]},{i,n}];
	dipyramid[v,{x,y,h},opts]
]

dipyramid[n_Integer /; n>=3,h_,opts___]:=dipyramid[n,{0,0,h},opts]

dipyramid[n_Integer /; n>=3,opts___]:=Module[{R=Csc[Pi/n]/2},
	dipyramid[n,{0,0,Sqrt[1-R^2]},opts]
]

PolyhedronName[Dipyramid[n_Integer,args___]]:=PolygonalName[n]<>" dipyramid" /;
	n>2 && Head[PolygonalName[n]]=!=PolygonalName
PolyhedronName[Dipyramid[args__]]:="dipyramid"
PolyhedronFaces[Dipyramid[args__]]:=PolyhedronFaces[dipyramid[args]]
PolyhedronVertices[Dipyramid[args__]]:=PolyhedronVertices[dipyramid[args]]


drop[l_List,items_List]:=Part[l,Complement[Range[Length[l]],items]]


(* Elongated Cupola *)

elongatedCupola[n_Integer?(3<=#<=5&)]:=Module[{c=cupola[n],bot,botbot},
    bot=c[[1,2]]/.Polygon:>Identity;
    botbot={0,0,-1}+#&/@bot;
    {Rest[c],c[[1,1]],Polygon[botbot],ribbon[2n,1,-1/2]}
]

PolyhedronName[ElongatedCupola[args_]]:="elongated cupola"
PolyhedronFaces[ElongatedCupola[args_]]:=PolyhedronFaces[elongatedCupola[args]]
PolyhedronVertices[ElongatedCupola[args_]]:=PolyhedronVertices[elongatedCupola[args]]

(* Elongated Dipyramid *)

elongatedDipyramid[v_List,{x_,y_,h_},opts___]:=Module[
	{p=Partition[v,2,1,1],base1,base2},
	base1=Map[Append[#,1/2]&,p,{2}];
	base2=Map[Append[#,-1/2]&,p,{2}];
	{Map[Polygon,{
		Append[#,{x,y,h+1/2}]&/@base1,
		Reverse/@(Append[#,{x,y,-(h+1/2)}]&/@base2)},
	{2}],
	Polygon/@Reverse/@(Join[#[[1]],Reverse[#[[2]]]]&/@Transpose[{base1,base2}])
	}
]

elongatedDipyramid[v_List,h_:1,opts___]:=elongatedDipyramid[v,{0,0,h},opts]

elongatedDipyramid[n_Integer /; n>=3,{x_,y_,h_},opts___]:=Module[{i,v,R=Csc[Pi/n]/2},
	v=Table[R{Cos[2Pi i/n],Sin[2Pi i/n]},{i,n}];
	elongatedDipyramid[v,{x,y,h},opts]
]

elongatedDipyramid[n_Integer /; n>=3,h_,opts___]:=dipyramid[n,{0,0,h},opts]

elongatedDipyramid[n_Integer /; n>=3,opts___]:=Module[{R=Csc[Pi/n]/2},
	elongatedDipyramid[n,{0,0,Sqrt[1-R^2]},opts]
]

PolyhedronName[ElongatedDipyramid[args_]]:="elongated dipyramid"
PolyhedronFaces[ElongatedDipyramid[args_]]:=PolyhedronFaces[elongatedDipyramid[args]]
PolyhedronVertices[ElongatedDipyramid[args_]]:=PolyhedronVertices[elongatedDipyramid[args]]

(* Elongated Gyrobicupola*)

elongatedGyrobicupola[n_Integer?(3<=#<=5&)]:=Module[
	{
		cup={#[[1,1]],Rest[#]}&@cupola[n],top,bot,l,
		c=Cos[2Pi/2/n],s=Sin[2Pi/2/n]
	},
    top=cup/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l];
    bot=cup/.Polygon[l_List]:>Polygon[{0,0,-1/2}+{1,1,-1}#&/@l];
    {
    	top,
    	bot/.Polygon[l_List]:>Polygon[Reverse[{{c,s,0},{-s,c,0},{0,0,1}}.#&/@l]],
		ribbon[2n,1]
    }
]

PolyhedronName[ElongatedGyrobicupola[args_]]:="elongated gyrobicupola"
PolyhedronFaces[ElongatedGyrobicupola[args_]]:=PolyhedronFaces[elongatedGyrobicupola[args]]
PolyhedronVertices[ElongatedGyrobicupola[args_]]:=PolyhedronVertices[elongatedGyrobicupola[args]]

(* Elongated Gyrobirotunda *)

elongatedGyrobirotunda[n_Integer?(#==5&)]:=Module[
	{
		rot=First[rotunda[n]],l,
		c=Cos[2Pi/2/n],s=Sin[2Pi/2/n]
	},
	{
    	rot/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l],
    	rot/.Polygon[l_List]:>
    		Polygon[Reverse[{0,0,-1/2}+{{c,s,0},{-s,c,0},{0,0,-1}}.#&/@l]],
    	ribbon[10,1]
    }
]

PolyhedronName[ElongatedGyrobirotunda[args_]]:="elongated gyrobirotunda"
PolyhedronFaces[ElongatedGyrobirotunda[args_]]:=PolyhedronFaces[elongatedGyrobirotunda[args]]
PolyhedronVertices[ElongatedGyrobirotunda[args_]]:=PolyhedronVertices[elongatedGyrobirotunda[args]]

(* Elongated Gyrocupolarotunda *)

elongatedGyrocupolarotunda[n_Integer?(#==5&)]:=Module[
	{
		cup={#[[1,1]],Rest[#]}&@cupola[n],
		rot=First[rotunda[n]],
		l
	},
	{
		rot/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l],
		cup/.Polygon[l_List]:>Polygon[Reverse[({0,0,-1/2}+{1,1,-1}#)&/@l]],
    	ribbon[2n,1]
	}
]

PolyhedronName[ElongatedGyrocupolarotunda[args_]]:="elongated gyrocupolarotunda"
PolyhedronFaces[ElongatedGyrocupolarotunda[args_]]:=PolyhedronFaces[elongatedGyrocupolarotunda[args]]
PolyhedronVertices[ElongatedGyrocupolarotunda[args_]]:=PolyhedronVertices[elongatedGyrocupolarotunda[args]]

(* Elongated Orthobicupola *)

elongatedOrthobicupola[n_Integer?(3<=#<=5&)]:=Module[{c=cupola[n],top,bot},
    top=c/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l];
    bot=c/.Polygon[l_List]:>Polygon[Reverse[{0,0,-1/2}+{1,1,-1}#&/@l]];
    {Rest[top],top[[1,1]],Rest[bot],bot[[1,1]],ribbon[2n,1]}
]

PolyhedronName[ElongatedOrthobicupola[args_]]:="elongated orthobicupola"
PolyhedronFaces[ElongatedOrthobicupola[args_]]:=
	PolyhedronFaces[elongatedOrthobicupola[args]]
PolyhedronVertices[ElongatedOrthobicupola[args_]]:=
	PolyhedronVertices[elongatedOrthobicupola[args]]

(* Elongated Orthobirotunda *)

elongatedOrthobirotunda[n_Integer?(#==5&)]:=Module[{c=First[rotunda[n]],l},
    {
    	c/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l],
    	c/.Polygon[l_List]:>Polygon[Reverse[{0,0,-1/2}+{1,1,-1}#&/@l]],
    	ribbon[10,1]
    }
]

PolyhedronName[ElongatedOrthobirotunda[args_]]:="elongated orthobitotunda"
PolyhedronFaces[ElongatedOrthobirotunda[args_]]:=PolyhedronFaces[elongatedOrthobirotunda[args]]
PolyhedronVertices[ElongatedOrthobirotunda[args_]]:=PolyhedronVertices[elongatedOrthobirotunda[args]]

(* Elongated Orthocupolarotunda *)

elongatedOrthocupolarotunda[n_Integer?(#==5&)]:=Module[
	{
		cup={#[[1,1]],Rest[#]}&@cupola[n],
		rot=First[rotunda[n]],
		s=Sin[2Pi/2/n],c=Cos[2Pi/2/n]
	},
	{
		rot/.Polygon[l_List]:>Polygon[{0,0,1/2}+#&/@l],
		cup/.Polygon[l_List]:>
			Polygon[Reverse[{0,0,-1/2}+{{c,s,0},{-s,c,0},{0,0,-1}}.#&/@l]],
		ribbon[2n,1]
	}
]

PolyhedronName[ElongatedOrthocupolarotunda[args_]]:="elongated orthocupolarotunda"
PolyhedronFaces[ElongatedOrthocupolarotunda[args_]]:=PolyhedronFaces[elongatedOrthocupolarotunda[args]]
PolyhedronVertices[ElongatedOrthocupolarotunda[args_]]:=PolyhedronVertices[elongatedOrthocupolarotunda[args]]

(* Elongated Pyramid *)

elongatedPyramid[v_List,{x_,y_,h_},opts___]:=Module[
	{p=Partition[v,2,1,1],base1,base2},
	base1=Map[Append[#,1]&,p,{2}];
	base2=Map[Append[#,0]&,p,{2}];
	{Polygon/@(Append[#,{x,y,h+1}]&/@base1),
	Polygon/@Reverse/@(Join[#[[1]],Reverse[#[[2]]]]&/@Transpose[{base1,base2}]),
	Polygon[Append[#,0]&/@Reverse[v]]}
]

elongatedPyramid[v_List,h_:1,opts___]:=elongatedPyramid[v,{0,0,h},opts]

elongatedPyramid[n_Integer /; n>=3,{x_,y_,h_},opts___]:=Module[{i,v,R=Csc[Pi/n]/2},
	v=Table[R{Cos[2Pi i/n],Sin[2Pi i/n]},{i,n}];
	elongatedPyramid[v,{x,y,h},opts]
]

elongatedPyramid[n_Integer /; n>=3,h_,opts___]:=pyramid[n,{0,0,h},opts]

elongatedPyramid[n_Integer /; n>=3,opts___]:=Module[{R=Csc[Pi/n]/2},
	elongatedPyramid[n,{0,0,Sqrt[1-R^2]},opts]
]

PolyhedronName[ElongatedPyramid[args__]]:="elongated pyramid"
PolyhedronFaces[ElongatedPyramid[args__]]:=PolyhedronFaces[elongatedPyramid[args]]
PolyhedronVertices[ElongatedPyramid[args__]]:=PolyhedronVertices[elongatedPyramid[args]]

(* Elongated Rotunda *)

elongatedRotunda[n_Integer?(#==5&)]:=Module[{r=rotunda[n],bot,botbot},
	bot=Last[r]/.Polygon:>Identity;
    botbot={0,0,-1}+#&/@bot;
    {Drop[r,-1],Polygon[botbot],ribbon[2n,1,-1/2]}
]

PolyhedronName[ElongatedRotunda[args_]]:="elongated rotunda"
PolyhedronFaces[ElongatedRotunda[args_]]:=PolyhedronFaces[elongatedRotunda[args]]
PolyhedronVertices[ElongatedRotunda[args_]]:=PolyhedronVertices[elongatedRotunda[args]]

(* Frustum *)

frustum[v_List,{x_,y_,h_},s_]:=Module[{i,n=Length[v],g,bot,top},
	g=Append[Plus@@v/n,0];
	bot=Table[{v[[i,1]],v[[i,2]],0}-g,{i,n}];
	top=Table[g+s bot[[i]]+{x,y,h},{i,n}];
	{
	Polygon/@{top,bot},
	Polygon/@Table[{bot[[i]],bot[[addn[i,1,n]]],top[[addn[i,1,n]]],top[[i]]},{i,n}]
	}
]

frustum[v_List,h_,s_]:=frustum[v,{0,0,h},s]

PolyhedronName[Frustum[args__]]:="frustum"
PolyhedronFaces[Frustum[args__]]:=PolyhedronFaces[frustum[args]]
PolyhedronVertices[Frustum[args__]]:=PolyhedronVertices[frustum[args]]

(* Golden Rhombohedron *)

PolyhedronName[GoldenRhombohedron]:="golden rhombohedron"
GoldenRhombohedron:=Rhombohedron[{1,2}/Sqrt[5]]

(* Gyrobicupola *)

gyrobicupola[n_Integer?(3<=#<=5&)]:=Module[{cup={#[[1,1]],Rest[#]}&@cupola[n],
	c=Cos[2Pi/n/2],s=Sin[2Pi/n/2]},
    {cup,cup/.Polygon[l_List]:>Polygon[Reverse[{{c,s,0},{-s,c,0},{0,0,-1}}.#&/@l]]}
]

PolyhedronName[Gyrobicupola[args_]]:="gyrobicupola"
PolyhedronFaces[Gyrobicupola[args_]]:=
	PolyhedronFaces[gyrobicupola[args]]
PolyhedronVertices[Gyrobicupola[args_]]:=
	PolyhedronVertices[gyrobicupola[args]]

(* Gyrobifastigium *)

gyrobifastigium:=Module[{i,h=Sqrt[3],
      v1={1,-1,0},v2={1,1,0},v3={-1,-1,0},
      v4={-1,1,0},v5,v6,
      c=Cos[2Pi/4],s=Sin[2Pi/4],
      l},
    v5={1,0,h};
    v6={-1,0,h};
    l={{v1,v2,v5},{v6,v4,v3},Reverse[{v1,v3,v6,v5}],Reverse[{v4,v2,v5,v6}]}/2;
    {Polygon/@l,
    Polygon/@Reverse/@Map[{{c,s,0},{-s,c,0},{0,0,-1}}.#&,l,{2}]}
]

PolyhedronName[Gyrobifastigium]:="gyrobifastigium"
PolyhedronFaces[Gyrobifastigium]:=PolyhedronFaces[gyrobifastigium]
PolyhedronVertices[Gyrobifastigium]:=PolyhedronVertices[gyrobifastigium]

(* Gyrocupolarotunda *)

gyrocupolarotunda[n_Integer?(#==5&)]:=
  Module[{cup={#[[1,1]],Rest[#]}&@cupola[n],rot=First[rotunda[n]],
      s=Sin[2Pi/2/n],c=Cos[2Pi/2/n]},
    {rot,cup/.Polygon[l_List]:>Polygon[Reverse[{1,1,-1}#&/@l]]}
]

PolyhedronName[Gyrocupolarotunda[args_]]:="gyrocupolarotunda"
PolyhedronFaces[Gyrocupolarotunda[args_]]:=
	PolyhedronFaces[gyrocupolarotunda[args]]
PolyhedronVertices[Gyrocupolarotunda[args_]]:=
	PolyhedronVertices[gyrocupolarotunda[args]]

(* Gyroelongated Bicupola *)

gyroelongatedBicupola[n_Integer?(3<=#<=5&)]:=Module[
	{
		a=Drop[Polyhedron[Antiprism[2n]],{1,2}],
		cup={#[[1,1]],Rest[#]}&@cupola[n],
		h=Sqrt[1-Sec[Pi/2/n]^2/4],
		s=Sin[2Pi/4/n],
		c=Cos[2Pi/4/n]
    },
    {a,
    cup/.Polygon[l_List]:>
    	Polygon[{0,0,h/2}+{{c,s,0},{-s,c,0},{0,0,1}}.#&/@l],
	cup/.Polygon[l_List]:>Polygon[Reverse[{0,0,-h/2}-#&/@l]]
	}
]

PolyhedronName[GyroelongatedBicupola[args_]]:="gyroelongated bicupola"
PolyhedronFaces[GyroelongatedBicupola[args_]]:=
	PolyhedronFaces[gyroelongatedBicupola[args]]
PolyhedronVertices[GyroelongatedBicupola[args_]]:=
	PolyhedronVertices[gyroelongatedBicupola[args]]

(* Gyroelongated Birotunda *)

gyroelongatedBirotunda[n_Integer?(#==5&)]:=
  Module[{a=Drop[Polyhedron[Antiprism[2n]],{1,2}],
      rot=First[rotunda[n]],
      h=Sqrt[1-Sec[Pi/2/n]^2/4],s=Sin[2Pi/4/n],c=Cos[2Pi/4/n]},
      {a,
      rot/.Polygon[l_List]:>
          Polygon[{0,0,h/2}+{{c,s,0},{-s,c,0},{0,0,1}}.#&/@l],
      rot/.Polygon[l_List]:>Polygon[Reverse[{0,0,-h/2}+{1,1,-1}#&/@l]]}
]

PolyhedronName[GyroelongatedBirotunda[args_]]:="gyroelongated birotunda"
PolyhedronFaces[GyroelongatedBirotunda[args_]]:=
	PolyhedronFaces[gyroelongatedBirotunda[args]]
PolyhedronVertices[GyroelongatedBirotunda[args_]]:=
	PolyhedronVertices[gyroelongatedBirotunda[args]]

(* Gyroelongated Cupola *)

gyroelongatedCupola[n_Integer?(3<=#<=5&)]:=Module[
	{a=Polyhedron[Antiprism[2n]],c=cupola[n],l},
      {Rest[a] /. Polygon[l_]:>Polygon[Reverse[{0,0,a[[1,1,1,-1]]}-#&/@l]],
      c[[1,1]],Rest[c]}
]

PolyhedronName[GyroelongatedCupola[args_]]:="gyroelongated cupola"
PolyhedronFaces[GyroelongatedCupola[args_]]:=
	PolyhedronFaces[gyroelongatedCupola[args]]
PolyhedronVertices[GyroelongatedCupola[args_]]:=
	PolyhedronVertices[gyroelongatedCupola[args]]

(* Gyroelongated Cupolarotunda *)

gyroelongatedCupolarotunda[n_Integer?(#==5&)]:=
  Module[{a=Drop[Polyhedron[Antiprism[2n]],{1,2}],cup={#[[1,1]],Rest[#]}&@cupola[n],
      rot=First[rotunda[n]],
      h=Sqrt[1-Sec[Pi/2/n]^2/4],s=Sin[2Pi/4/n],c=Cos[2Pi/4/n]},
      {a,
      cup/.Polygon[l_List]:>Polygon[Reverse[{0,0,-h/2}+{1,1,-1}#&/@l]],
      rot/.Polygon[l_List]:>
          Polygon[{0,0,h/2}+{{c,s,0},{-s,c,0},{0,0,1}}.#&/@l]
      }
]

PolyhedronName[GyroelongatedCupolarotunda[args_]]:="gyroelongated cupolarotunda"
PolyhedronFaces[GyroelongatedCupolarotunda[args_]]:=
	PolyhedronFaces[gyroelongatedCupolarotunda[args]]
PolyhedronVertices[GyroelongatedCupolarotunda[args_]]:=
	PolyhedronVertices[gyroelongatedCupolarotunda[args]]

(* Gyroelongated Pyramid *)

gyroelongatedPyramid[n_Integer?(3<=#<=5&)]:=
	Module[{a=Polyhedron[Antiprism[n]],p=Polyhedron[Pyramid[n]],l},
	{Drop[a,{2}],
      Most[p]/.Polygon[l_List]:>Polygon[{0,0,a[[2,1,1,-1]]}+#&/@l]
	}
]

PolyhedronName[GyroelongatedPyramid[args_]]:="gyroelongated pyramid"
PolyhedronFaces[GyroelongatedPyramid[args_]]:=
	PolyhedronFaces[gyroelongatedPyramid[args]]
PolyhedronVertices[GyroelongatedPyramid[args_]]:=
	PolyhedronVertices[gyroelongatedPyramid[args]]

(* Gyroelongated Rotunda *)

gyroelongatedRotunda[n_Integer?(#==5&)]:=
  Module[{a=Polyhedron[Antiprism[2n]],r=rotunda[n],l},
      {Drop[a,{1}] /. Polygon[l_]:>Polygon[Reverse[{0,0,a[[1,1,1,-1]]}-#&/@l]],
      First[r]}
]

PolyhedronName[GyroelongatedRotunda[args_]]:="gyroelongated rotunda"
PolyhedronFaces[GyroelongatedRotunda[args_]]:=
	PolyhedronFaces[gyroelongatedRotunda[args]]
PolyhedronVertices[GyroelongatedRotunda[args_]]:=
	PolyhedronVertices[gyroelongatedRotunda[args]]

(* Orthobicupola *)

orthobicupola[n_Integer?(3<=#<=5&)]:=Module[
	{cup={#[[1,1]],Rest[#]}&@cupola[n],l},
    {cup,cup/.Polygon[l_List]:>Polygon[Reverse[{1,1,-1}#&/@l]]}
]

PolyhedronName[Orthobicupola[args_]]:="orthobicupola"
PolyhedronFaces[Orthobicupola[args_]]:=
	PolyhedronFaces[orthobicupola[args]]
PolyhedronVertices[Orthobicupola[args_]]:=
	PolyhedronVertices[orthobicupola[args]]

(* Orthobirotunda *)

orthobirotunda[n_Integer?(#==5&)]:=Module[{r=First[rotunda[n]]},
    {r,r/.Polygon[l_List]:>Polygon[Reverse[{1,1,-1}#&/@l]]}
]

PolyhedronName[Orthobirotunda[args_]]:="orthobirotunda"
PolyhedronFaces[Orthobirotunda[args_]]:=
	PolyhedronFaces[orthobirotunda[args]]
PolyhedronVertices[Orthobirotunda[args_]]:=
	PolyhedronVertices[orthobirotunda[args]]

(* Orthocupolarotunda *)
		
orthocupolarotunda[n_]:=
  Module[{cup={#[[1,1]],Rest[#]}&@cupola[n],rot=First[rotunda[n]],
      s=Sin[2Pi/2/n],c=Cos[2Pi/2/n]},
    {rot,
    	cup/.Polygon[l_List]:>Polygon[Reverse[{{c,s,0},{-s,c,0},{0,0,-1}}.#&/@l]]}
]

PolyhedronName[Orthocupolarotunda[args_]]:="orthocupolarotunda"
PolyhedronFaces[Orthocupolarotunda[args_]]:=
	PolyhedronFaces[orthocupolarotunda[args]]
PolyhedronVertices[Orthocupolarotunda[args_]]:=
	PolyhedronVertices[orthocupolarotunda[args]]

(* Pentagonal Prism 6-compound *)

PolyhedronName[PentagonalPrism6Compound]:="pentagonal prism 6-compound"
NetPieces[PentagonalPrism6Compound]:={{60,{1,2,3}}}
NetFaces[PentagonalPrism6Compound]:={{11,3,9,8,12,2,1},{1,13,10,4,11},{2,5,7,6,1}}
NetVertices[PentagonalPrism6Compound]:=
{{0, 0}, {0, (3 - Sqrt[5])/2}, {(5 - 3*Sqrt[5])/10, (5 - 2*Sqrt[5])/5}, 
 {(1 - Sqrt[5])/4, -Sqrt[5/8 - 11/(8*Sqrt[5])]}, 
 {(3 - Sqrt[5])/5, (3 - Sqrt[5])/10}, {(5 - Sqrt[5])/10, 0}, 
 {(5 - Sqrt[5])/10, (5 - Sqrt[5])/20}, {(-5 + Sqrt[5])/10, (5 + Sqrt[5])/20}, 
 {(-5 + Sqrt[5])/10, (-5 + 3*Sqrt[5])/10}, 
 {(-3 + Sqrt[5])/4, -(1/Sqrt[2*(65 + 29*Sqrt[5])])}, {(-3 + Sqrt[5])/2, 0}, 
 {(-5 + 2*Sqrt[5])/5, 1/Sqrt[5]}, {(-5 + 3*Sqrt[5])/20, 
  -Sqrt[1/8 - 1/(8*Sqrt[5])]}}

PolyhedronPolyhedra[PentagonalPrism6Compound]:=Partition[Range[42],7]
PolyhedronFaces[PentagonalPrism6Compound]:=
{{50,7,40,1,9},{10,2,41,8,51},{50,7,8,51},{7,40,41,8},{40,1,2,41},{1,9,10,
    2},{9,50,51,10},{49,54,22,19,42},{29,33,3,43,58},{49,54,43,58},{54,22,3,
    43},{22,19,33,3},{19,42,29,33},{42,49,58,29},{27,21,37,35,6},{44,30,16,11,
    56},{27,21,11,56},{21,37,16,11},{37,35,30,16},{35,6,44,30},{6,27,56,
    44},{31,20,14,39,15},{25,57,24,28,48},{31,20,28,48},{20,14,24,28},{14,39,
    57,24},{39,15,25,57},{15,31,48,25},{60,26,4,34,47},{5,13,17,52,53},{60,26,
    52,53},{26,4,17,52},{4,34,13,17},{34,47,5,13},{47,60,53,5},{55,12,46,32,
    59},{45,38,36,18,23},{55,12,18,23},{12,46,36,18},{46,32,38,36},{32,59,45,
    38},{59,55,23,45}}
PolyhedronVertices[PentagonalPrism6Compound]:=
{{-1/2, -Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2}, {-1/2, -Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2}, {-1/2, Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2}, 
 {-1/2, Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2}, {0, -Sqrt[1/2 + 1/(2*Sqrt[5])], -1/2}, {0, -Sqrt[1/2 + 1/(2*Sqrt[5])], 1/2}, 
 {0, Sqrt[1/2 + 1/(2*Sqrt[5])], -1/2}, {0, Sqrt[1/2 + 1/(2*Sqrt[5])], 1/2}, {1/2, -Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2}, 
 {1/2, -Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2}, {1/2, Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2}, {1/2, Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2}, 
 {-3/(2*Sqrt[5]), -Sqrt[1/4 + 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, {-3/(2*Sqrt[5]), Sqrt[1/4 + 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, 
 {-(1/Sqrt[5]), -Sqrt[1/2 + 1/(2*Sqrt[5])], -1/(2*Sqrt[5])}, {-(1/Sqrt[5]), Sqrt[1/2 + 1/(2*Sqrt[5])], -1/(2*Sqrt[5])}, 
 {-1/(2*Sqrt[5]), -Sqrt[1/4 - 1/(2*Sqrt[5])], (5 + 2*Sqrt[5])/10}, {-1/(2*Sqrt[5]), Sqrt[1/4 - 1/(2*Sqrt[5])], 
  (5 + 2*Sqrt[5])/10}, {-1/(2*Sqrt[5]), -Sqrt[1/4 + 1/(2*Sqrt[5])], -3/(2*Sqrt[5])}, 
 {-1/(2*Sqrt[5]), Sqrt[1/4 + 1/(2*Sqrt[5])], -3/(2*Sqrt[5])}, {1/(2*Sqrt[5]), -Sqrt[1/4 - 1/(2*Sqrt[5])], (-5 - 2*Sqrt[5])/10}, 
 {1/(2*Sqrt[5]), Sqrt[1/4 - 1/(2*Sqrt[5])], (-5 - 2*Sqrt[5])/10}, {1/(2*Sqrt[5]), -Sqrt[1/4 + 1/(2*Sqrt[5])], 3/(2*Sqrt[5])}, 
 {1/(2*Sqrt[5]), Sqrt[1/4 + 1/(2*Sqrt[5])], 3/(2*Sqrt[5])}, {1/Sqrt[5], -Sqrt[1/2 + 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, 
 {1/Sqrt[5], Sqrt[1/2 + 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, {3/(2*Sqrt[5]), -Sqrt[1/4 + 1/(2*Sqrt[5])], -1/(2*Sqrt[5])}, 
 {3/(2*Sqrt[5]), Sqrt[1/4 + 1/(2*Sqrt[5])], -1/(2*Sqrt[5])}, {(-5 - 3*Sqrt[5])/20, -Sqrt[1/8 + 1/(8*Sqrt[5])], 3/(2*Sqrt[5])}, 
 {(-5 - 3*Sqrt[5])/20, Sqrt[1/8 + 1/(8*Sqrt[5])], 3/(2*Sqrt[5])}, {(5 - 3*Sqrt[5])/20, -Sqrt[1/8 - 1/(8*Sqrt[5])], 
  (-5 - 2*Sqrt[5])/10}, {(5 - 3*Sqrt[5])/20, Sqrt[1/8 - 1/(8*Sqrt[5])], (-5 - 2*Sqrt[5])/10}, 
 {(-5 - 2*Sqrt[5])/10, -Sqrt[1/4 - 1/(2*Sqrt[5])], -1/(2*Sqrt[5])}, {(-5 - 2*Sqrt[5])/10, Sqrt[1/4 - 1/(2*Sqrt[5])], 
  -1/(2*Sqrt[5])}, {(-15 - Sqrt[5])/20, -Sqrt[1/8 + 1/(8*Sqrt[5])], 1/(2*Sqrt[5])}, 
 {(-15 - Sqrt[5])/20, Sqrt[1/8 + 1/(8*Sqrt[5])], 1/(2*Sqrt[5])}, {(-5 - Sqrt[5])/10, 0, -3/(2*Sqrt[5])}, 
 {(-1 - Sqrt[5])/4, -Sqrt[1/8 - 1/(8*Sqrt[5])], -1/2}, {(-1 - Sqrt[5])/4, -Sqrt[1/8 - 1/(8*Sqrt[5])], 1/2}, 
 {(-1 - Sqrt[5])/4, Sqrt[1/8 - 1/(8*Sqrt[5])], -1/2}, {(-1 - Sqrt[5])/4, Sqrt[1/8 - 1/(8*Sqrt[5])], 1/2}, 
 {(5 - Sqrt[5])/20, -Sqrt[5/8 + Sqrt[5]/8], 1/(2*Sqrt[5])}, {(5 - Sqrt[5])/20, Sqrt[5/8 + Sqrt[5]/8], 1/(2*Sqrt[5])}, 
 {(5 - Sqrt[5])/10, 0, (5 + 2*Sqrt[5])/10}, {(-5 + Sqrt[5])/20, -Sqrt[5/8 + Sqrt[5]/8], -1/(2*Sqrt[5])}, 
 {(-5 + Sqrt[5])/20, Sqrt[5/8 + Sqrt[5]/8], -1/(2*Sqrt[5])}, {(-5 + Sqrt[5])/10, 0, (-5 - 2*Sqrt[5])/10}, 
 {(1 + Sqrt[5])/4, -Sqrt[1/8 - 1/(8*Sqrt[5])], -1/2}, {(1 + Sqrt[5])/4, -Sqrt[1/8 - 1/(8*Sqrt[5])], 1/2}, 
 {(1 + Sqrt[5])/4, Sqrt[1/8 - 1/(8*Sqrt[5])], -1/2}, {(1 + Sqrt[5])/4, Sqrt[1/8 - 1/(8*Sqrt[5])], 1/2}, 
 {(5 + Sqrt[5])/10, 0, 3/(2*Sqrt[5])}, {(15 + Sqrt[5])/20, -Sqrt[1/8 + 1/(8*Sqrt[5])], -1/(2*Sqrt[5])}, 
 {(15 + Sqrt[5])/20, Sqrt[1/8 + 1/(8*Sqrt[5])], -1/(2*Sqrt[5])}, {(5 + 2*Sqrt[5])/10, -Sqrt[1/4 - 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, 
 {(5 + 2*Sqrt[5])/10, Sqrt[1/4 - 1/(2*Sqrt[5])], 1/(2*Sqrt[5])}, {(-5 + 3*Sqrt[5])/20, -Sqrt[1/8 - 1/(8*Sqrt[5])], 
  (5 + 2*Sqrt[5])/10}, {(-5 + 3*Sqrt[5])/20, Sqrt[1/8 - 1/(8*Sqrt[5])], (5 + 2*Sqrt[5])/10}, 
 {(5 + 3*Sqrt[5])/20, -Sqrt[1/8 + 1/(8*Sqrt[5])], -3/(2*Sqrt[5])}, {(5 + 3*Sqrt[5])/20, Sqrt[1/8 + 1/(8*Sqrt[5])], 
  -3/(2*Sqrt[5])}}

(* Prism *)

PolyhedronName[Prism[n_Integer,args___]]:=PolygonalName[n]<>" prism" /;
	n>2 && Head[PolygonalName[n]]=!=PolygonalName
PolyhedronName[Prism[args__]]:="prism"

PolyhedronVertices[Prism[n_Integer?Positive,h_?Positive,s_?Positive]]:=Module[
	{i,z,R=s Csc[Pi/n]/2},
	Flatten[
		Table[{R Cos[2Pi i/n],R Sin[2Pi i/n],z h/2},{z,-1,1,2},{i,0,n-1}],
	1]
] /; n>2

PolyhedronVertices[Prism[n_Integer?Positive]]:=
	PolyhedronVertices[Prism[n,1,1]] /; n>2
PolyhedronVertices[Prism[n_Integer?Positive,h_:1]]:=
	PolyhedronVertices[Prism[n,h,1]] /; n>2

PolyhedronFaces[Prism[n_Integer?Positive,h_?Positive,s_?Positive]]:=Module[
    {r1=Range[n],r2=Range[n+1,2n]},
    Join[{Reverse[r1],r2},
      Flatten[{#1,Reverse[#2]}]&@@@Transpose[Partition[#,2,1,1]&/@{r1,r2}]
      ]
    ]
    
PolyhedronFaces[Prism[n_Integer?Positive]]:=
	PolyhedronFaces[Prism[n,1,1]] /; n>2
PolyhedronFaces[Prism[n_Integer?Positive,h_:1]]:=
	PolyhedronFaces[Prism[n,h,1]] /; n>2


Prism[v_List,h_:1]:=Prism[v,h,{0,0}]

Prism[v_List,h_,off_List]:=Module[{i,n=Length[v],bot,top,sides},
	bot=Table[Append[v[[i]],0],{i,n}];
	top=Table[Append[v[[i]]+off,h],{i,n}];
	sides=Table[{bot[[i]],bot[[addn[i,1,n]]],top[[addn[i,1,n]]],top[[i]]},{i,n}];
	Flatten[{Polygon[bot],Polygon[top],Polygon/@sides}]
]

prismNet[n_,h_:1]:=prismNet[n,h,1]

prismNet[n_,h_,s_]:=
  Module[{half=Floor[n/2],r=s Cot[Pi/n]/2,R=s Csc[Pi/n]/2,bot,top,ribbon,dy,i},
    dy=If[OddQ[n],R,r];
    bot=Table[{half s+s/2+R Sin[2Pi(i-3/2)/n],dy+R Cos[2Pi(i-3/2)/n]},{i,0,n}];
    top=Table[{half s+s/2+R Sin[2Pi(i-3/2)/n],dy+h-R Cos[2Pi(i-3/2)/n]+2r},{i,0,n}];
    ribbon=
      Table[{{s i,r+dy},{s(i+1),r+dy},{s(i+1),r+h+dy},{s i,r+h+dy},{s i,r+dy}},
      {i,0,n-1}];
    Join[Line/@{bot,top},Line/@ribbon]
]

NetFaces[Prism[args__]]:=NetFaces[prismNet[args]//RootReduce]
NetVertices[Prism[args__]]:=NetVertices[prismNet[args]//RootReduce]

(* Pyramid *)

pyramid[v_List,{x_,y_,h_}]:=Module[
	{base=Map[Append[#,0]&,Partition[v,2,1,1],{2}]},
	{Polygon/@(Append[#,{x,y,h}]&/@base),Polygon[Append[#,0]&/@Reverse[v]]}
]

pyramid[v_List,h_:1]:=pyramid[v,{0,0,h}]

pyramid[n_Integer /; n>=3,{x_,y_,h_}]:=
	pyramid[Csc[Pi/n]/2 Through[{Cos, Sin}[2Pi #/n]] & /@ Range[n],{x,y,h}]

pyramid[n_Integer /; n>=3,h_]:=pyramid[n,{0,0,h}]

pyramid[n_/; n>=3,h_,a_]:=pyramid[a Csc[Pi/n]/2 Through[{Cos, Sin}[2Pi #/n]] & /@ Range[n], h]

pyramid[n_Integer /; 3<=n<=5]:=Module[{R=Csc[Pi/n]/2},
	pyramid[n,{0,0,Sqrt[1-R^2]}]
]

pyramid[n_Integer /; n>=6]:=pyramid[n,1]

PolyhedronName[Pyramid[n_Integer,args___]]:=PolygonalName[n]<>" pyramid" /;
	n>2 && Head[PolygonalName[n]]=!=PolygonalName
PolyhedronName[Pyramid[args__]]:="pyramid"
PolyhedronFaces[Pyramid[args__]]:=PolyhedronFaces[pyramid[args]]
PolyhedronVertices[Pyramid[args__]]:=PolyhedronVertices[pyramid[args]]

(* Pyramidal Frsutum *)

pyramidalFrustum[n_Integer /; n>=3,h_:1,s_]:=Module[{i,v},
	v=Table[{Cos[2Pi i/n],Sin[2Pi i/n]},{i,n}];
	Frustum[v,h,s]
]

PolyhedronName[PyramidalFrustrum[args__]]:="pyramidal frustrum"
PolyhedronFaces[PyramidalFrustrum[args__]]:=PolyhedronFaces[pyramidalFrustrum[args]]
PolyhedronVertices[PyramidalFrustrum[args__]]:=PolyhedronVertices[pyramidalFrustrum[args]]

(* Rhombohedron *)

rhombohedron[v_]:=Module[
	{
		o={0,0,0},
		v0=Norm[v]{1,0,0},
		v1=Append[v,0],
		v2,
		theta=ArcTan@@v
	},
    v2={Cos[theta/2]Cos[theta],Sin[theta/2]Cos[theta],Sin[theta]}Norm[v];
	Polygon/@{
		{o,v1,v0+v1,v0},{o,v0,v0+v2,v2},{o,v2,v2+v1,v1},
		{v2,v0+v2,v0+v1+v2,v1+v2},{v1,v1+v2,v0+v1+v2,v0+v1},{v0,v0+v1,v0+v1+v2,v0+v2}
	}
]

PolyhedronName[Rhombohedron[args_]]:="rhombohedron"
PolyhedronFaces[Rhombohedron[args_]]:=PolyhedronFaces[rhombohedron[args]]
PolyhedronVertices[Rhombohedron[args_]]:=PolyhedronVertices[rhombohedron[args]]

(* ribbon *)

ribbon[n_,rot_:0,z_:0]:=Module[{c,i,top,bot,R=Csc[Pi/n]/2},
    c=Table[R{Cos[#],Sin[#]}&[2Pi(i+rot/2)/n],{i,n}];
    top=Append[#,z+1/2]&/@c;
    bot=Append[#,z-1/2]&/@c;
    Polygon/@Reverse/@
      Join@@@Transpose[{Partition[top,2,1,1],Reverse/@Partition[bot,2,1,1]}]
]

(* Rim stuff---rewrite *)

rim1[z_,R_,n_]:=Module[{i},
	Table[{R Cos[2 i Pi/n],R Sin[2 i Pi/n],z},{i,0,n}]
]

rim2[z_,R_,n_]:=Module[{i},
	Table[{R Cos[(2i+1) Pi/n],R Sin[(2i+1) Pi/n],z},{i,0,n}]
]

rim[z_,R_,n_]:=Module[{i},
	Table[{R Cos[2 i Pi/n],R Sin[2 i Pi/n],z},{i,0,n}]
]

(* Rotunda *)

rotunda[5]:=Module[
	{p,rim,ctr,i,h=Sqrt[(5+2Sqrt[5])/5],x2,golden=(Sqrt[5]+1)/2,
      z2=Sqrt[(5+Sqrt[5])/10],R=Sqrt[50+10Sqrt[5]]/10,half},
      x2=h;
    p=Table[{R Cos[2Pi(i+1/2)/5],R Sin[2Pi(i+1/2)/5],h},{i,6}];
    rim=Table[{x2 Cos[2Pi i/5],x2 Sin[2Pi i/5],z2},{i,6}];
    ctr=Table[golden{Cos[2Pi(i+1/2)/10],Sin[2Pi(i+1/2)/10],0},{i,11}];
    half=Flatten[{{Take[p,5]},Table[Reverse[{p[[i]],p[[i+1]],rim[[i+1]]}],{i,5}],
          Table[{ctr[[2i-1]],ctr[[2i]],rim[[i]]},{i,5}],
          Table[{ctr[[2i]],ctr[[2i+1]],rim[[i+1]],p[[i]],rim[[i]]},{i,5}]},
    1]; 
	{Polygon/@half,Polygon[Reverse[Drop[ctr,-1]]]}
]

PolyhedronName[Rotunda[5]]:="rotunda"
PolyhedronFaces[Rotunda[5]]:=PolyhedronFaces[rotunda[5]]
PolyhedronVertices[Rotunda[5]]:=PolyhedronVertices[rotunda[5]]

(* Wedge *)

solidWedge[{a_,b_},h_,x_:0]:=Orient[Polygon/@{
	{{-a,-b,0},{a,-b,0},{a,b,0},{-a,b,0}},
	{{-a,-b,0},{a,-b,0},{a-x,0,h},{-a+x,0,h}},
	{{-a,b,0},{a,b,0},{a-x,0,h},{-a+x,0,h}},
	{{-a,-b,0},{-a+x,0,h},{-a,b,0}},
	{{a,-b,0},{a-x,0,h},{a,b,0}}
}]

PolyhedronName[SolidWedge[args__]]:="wedge"
PolyhedronFaces[SolidWedge[args__]]:=PolyhedronFaces[solidWedge[args]]
PolyhedronVertices[SolidWedge[args__]]:=PolyhedronVertices[solidWedge[args]]

End[]

EndPackage[]

(* Protect[  ] *)
