(* :Title: Stellated Icosahedra *)

(* :Author: Roman E. Maeder *)

(* :Summary: Code for rendering all 59 stellated icosahedra in various ways. *)

(* :Context: Icosahedra` *)

(* :Package Version: 1.12 *)

(* :Copyright: Copyright 1993, Roman E. Maeder.

   Permission is granted to distribute this file for any purpose
   except for inclusion in commercial software or program collections.
   This copyright notice must remain intact.
  
   The use of this code for the preparation of graphics images for publication
   or commercial purposes requires prior written permission by the author.
   
   The newest release of this file is available through MathSource.
*)

(* :History:
   Version 1.00 for The Mathematica Programmer (AP Professional, 1994),
               August 1993.
   Version 1.10 for Mathematica in Education, October 1993.
   Version 1.11 fixed for Mathematica 3.0-4.0 by Eric W. Weisstein, November 1998
   Version 1.12 using MathWorld context, October 18, 2003
*)

(* :Keywords: 
  Stellated Icosahedra, Stellation, Polyhedra 
*)

(* :Source: 
    Maeder, Roman E. 1993. The Stellated Icosahedra.
        Mathematica in Education, 3(1).
*)

(* :Source: 
    H. S. M. Coxeter, Patrick du Val, H. T. Flather, and J. F. Petrie. 1982
        The Fifty-Nine Icosahedra. Springer-Verlag.
        Originally published by Univ. of Toronto Press, 1938.
*)

(* :Mathematica Version: 5.0 *)

(* :Requirement: Graphics`Polyhedra` *)
(* :Requirement: Graphics`Legend` *)
(* :Requirement: Utilities`FilterOptions` *)
(* :Requirement: Geometry`Rotations` *)
(* :Requirement: Geometry`Polytopes` *)  (* EWW *)

(*
BeginPackage["Icosahedra`",
	{
	"Graphics`Polyhedra`",
	"Utilities`FilterOptions`",
	"Geometry`Rotations`",
	"Graphics`Legend`"
	}
]
*)

(* Must get Icosahedron from "Geometry`Polytopes`" in versions 3.0 and 4.x
   - EWW
*)

BeginPackage["MathWorld`Icosahedra`",
	{
	"Graphics`Polyhedra`",
	"Utilities`FilterOptions`",
	"Geometry`Rotations`",
	"Graphics`Legend`",
	"Geometry`Polytopes`"
	}
]


Icosahedra::usage = "Icosahedra[n, opts...] is a 3D graphics object
	representing stellation no. n of the icosahedron."

EdgeForm::usage = EdgeForm::usage <>
	"EdgeForm -> {primitives} is an
	option of Icosahedra that gives the rendering of edges."
PlaneColoring::usage = "PlaneColoring->colorfunction is an option of
	Icosahedra that gives the color function of each planar face.
	Argument is a number from 1 to 20."

lineGraphics::usage = "lineGraphics is a graphics object showing
	the intersection of one facial plane with all others."
lineGraphicsInner::usage = "lineGraphicsInner leaves out the outermost
	points of lineGraphics."
faceGraphics::usage = "faceGraphics is a graphics of color coded facets."
faceGraphicsInner::usage = "faceGraphicsInner leaves out the outermost
	facets of faceGraphics."

facet::usage = "face[n] or face[n, r|l] is a symbolic representation
	of one facet. N[facet[...]] gives the vertex coordinates."

icosahedra::usage = "icosahedra is the list of all
	stellated icosahedra in symbolic form."

FaceGraphics::usage = "FaceGraphics[n, (True|False)] is
	one planar face of stellation no. n."
faces::usage = "faces[n, (True|False)] is a numerical representation
	of one planar face of stellation no. n."

r::usage = "r designates the dextro form of a chiral object."
l::usage = "l designates the laevo form of a chiral object."

(* points *)
{a, bl, br, c, dl, dr, el, er, f, gl, gr, h, i, j, kl, kr}

Begin["`Private`"]

(* points in one plane *)

prec = 30;
n[a_] := N[a, prec] (* higher precision for intermediate computations *)

three = n[RotationMatrix2D[2Pi/3]]; (* a rotation by 120 degrees *)

(* intersection of lines ab and cd in two dimensions *)

inter[a_, b_, c_, d_] :=
    With[{p1 = a, v1 = unit[b-a], p2 = c, v2 = unit[c-d]},
     Module[{v1v2, s1, s2},
	v1v2 = v1[[1]] v2[[2]] - v1[[2]] v2[[1]];
	s1 = Det[{p2-p1, v2}]/v1v2;
	s2 = Det[{p2-p1, v1}]/v1v2;
	(p1 + v1 s1 + p2 + v2 s2)/2
     ]
    ]

norm[v_] := Sqrt[Plus@@(v^2)]
unit[v_] := v/norm[v]

(* make three definitions *)

define[s_Symbol, val1_] := (
	s[1] = n[val1];
	s[2] = three.s[1];
	s[3] = three.s[2];
)

(* points *)

define[c, {0, 1}]

define[ dl, c[1] + (1 - 1/GoldenRatio)(c[2] - c[1]) ]
define[ dr, c[1] + (1 - 1/GoldenRatio)(c[3] - c[1]) ]

define[  a, inter[dl[3], dl[1], dr[3], dr[2]] ]

define[ bl, inter[c[3], c[1], dl[2], dl[1]] ]
define[ br, inter[c[2], c[1], dr[3], dr[1]] ]

define[ el, inter[c[1], dl[2], c[3], dl[1]] ]
define[ er, inter[c[1], dr[3], c[2], dr[1]] ]

define[  f, inter[c[2], dr[1], c[3], dl[1]] ]

define[ gl, inter[c[1], dl[2], dl[1], dl[3]] ]
define[ gr, inter[c[1], dr[3], dr[1], dr[2]] ]

define[  h, inter[dr[1], dr[2], dl[1], dl[3]] ]

define[  i, inter[dl[1], dl[2], dr[1], dr[2]] ]

define[  j, inter[c[1], dl[2], c[2], dr[1]] ]

define[ kl, inter[dl[3], dr[2], dl[1], dl[2]] ]
define[ kr, inter[dl[3], dr[2], dr[1], dr[3]] ]

(* line drawings *)

mod[n_] := Mod[n-1, 3] + 1

line[a_, b_] := Line[{a[#], b[#]}]& /@ {1, 2, 3}
line[a_, b_, d_] := Line[{a[#], b[mod[#+d]]}]& /@ {1, 2, 3}

point[s_Symbol] :=
    Text[HoldForm[Subscripted[s[#]]], s[#], -1.1 unit[s[#]]]& /@ {1, 2, 3}

lineGraphics := lineGraphics =
Graphics[ {
	Thickness[0],
	point[c],
	point[dl], point[dr],
	line[c, dl, 1],
	line[c, dr, 2],
	point[el], point[er],
	point[f],
	point[gl], point[gr],
	point[h],
	point[i],
	point[j],
	point[kl], point[kr],
	line[dr, dl, 1],
	point[a],
	point[bl], point[br],
	line[bl, a, 1], line[br, a, 1],
	line[bl, br, 2]
    }, {
	AspectRatio->Automatic, PlotRange->All,
	DefaultFont -> {"Times-Roman", 6.0}
    } ]

lineGraphicsInner := lineGraphicsInner =
Graphics[ {
	Thickness[0],
	point[c],
	point[dl], point[dr],
	line[c, dl, 1],
	line[c, dr, 2],
	point[el], point[er],
	point[f],
	point[gl], point[gr],
	point[h],
	point[i],
	point[j],
	point[kl], point[kr],
	line[dr, dl, 1],
	line[dl, dl, 1], line[dr, dr, 2],
	line[c, c, 2]
    }, {
	AspectRatio->Automatic, PlotRange->All,
	DefaultFont -> {"Times-Roman", 8.0}
    } ]

(* Coxeter faces *)

(* generate three polygons out of one by rotation *)
rot[points__] := NestList[(three.#& /@ #)&, {points}, 2]

(* combine the left and right facets *)
merge[n_] := Join[ N[facet[n,r]], N[facet[n,l]] ]

N[facet[0]] = {{j[1], j[2], j[3]}}; (* this one has only one piece *)

N[facet[1]] = rot[j[1], j[3], f[1]]

N[facet[2, r]] = rot[el[1], j[1], f[1]]
N[facet[2, l]] = rot[er[1], f[1], j[3]]
N[facet[2]] = merge[2]

N[facet[3]] = rot[h[1], el[1], f[1], er[1]]

N[facet[4, r]] = rot[el[1], kr[2], j[1]]
N[facet[4, l]] = rot[er[1], j[3], kl[3]]
N[facet[4]] = merge[4]

N[facet[5, r]] = rot[dl[1], kr[2], el[1]]
N[facet[5, l]] = rot[dr[1], er[1], kl[3]]
N[facet[5]] = merge[5]

N[facet[6, r]] = rot[gl[1], el[1], h[1]]
N[facet[6, l]] = rot[gr[1], h[1], er[1]]
N[facet[6]] = merge[6]

N[facet[7]] = rot[i[1], kl[1], j[1], kr[2]]

N[facet[8]] = rot[c[1], gl[1], h[1], gr[1]]

N[facet[9, r]] = rot[dl[1], i[1], kr[2]]
N[facet[9, l]] = rot[dr[1], kl[3], i[3]]
N[facet[9]] = merge[9]

N[facet[10, r]] = rot[dl[1], el[1], gl[1]]
N[facet[10, l]] = rot[dr[1], gr[1], er[1]]
N[facet[10]] = merge[10]

N[facet[11, r]] = rot[c[1], dl[1], gl[1]]
N[facet[11, l]] = rot[c[1], gr[1], dr[1]]
N[facet[11]] = merge[11]

N[facet[12]] = rot[dl[1], dr[2], i[1]]

N[facet[13, r]] = rot[bl[1], dl[1], c[1]]
N[facet[13, l]] = rot[br[1], c[1], dr[1]]
N[facet[14]] = rot[a[1], dr[2], dl[1]]
N[facet[13]] = Join[ merge[13], N[facet[14]] ] (* ! 14 is always with 13 *)

(* facet color, n=0,..,max *)

facetColor[n_, max_] := Hue[n/(max+1),1,1]

(* color coded map *)

colorMap[max_] := Graphics[
    {facetColor[#, max], Polygon /@ N[facet[#]]}& /@ Range[0, max],
    {AspectRatio->Automatic, PlotRange->All}
]
legend[max_] := {
    {facetColor[#, max],
     ToString[NumberForm[#, 2, NumberPadding->" "]]}& /@ Range[0, max],
    LegendPosition->{-1, 0}
}

faceGraphics := faceGraphics =
    Block[{$DisplayFunction=Identity},
        ShowLegend[ colorMap[13], legend[13] ]
    ]
faceGraphicsInner := faceGraphicsInner =
    Block[{$DisplayFunction=Identity},
        ShowLegend[ colorMap[12], legend[12] ]
    ]

(* sets of facets *)

lambda = {facet[3], facet[4]}
lambdaref = {facet[3], facet[4], facet[5]}
mu = {facet[7], facet[8]}
nu = {facet[11], facet[12]}
nuref = {facet[10], facet[11], facet[12]}

setOf[comps___] := Sequence @@ Distribute[ {comps}, List ]

icosahedra = {

  (* reflexible *)
    {facet[ 0]},
    {facet[ 1]},
    {facet[ 2]},
    {facet[13]},
    {facet[ 3], facet[ 4]},
    {facet[ 3], facet[ 5]},
    {facet[ 4], facet[ 5]},
    {facet[ 7], facet[ 8]},
    {facet[10], facet[11]},
    {facet[10], facet[12]},
    {facet[11], facet[12]},
    setOf[lambdaref, facet[6], mu],
    setOf[mu, facet[9], nuref],
    setOf[lambdaref, facet[6], facet[9], nuref],
    
  (* chiral *)
    {facet[ 5,l], facet[ 6,l], facet[ 9,r], facet[ 10,r]},
    setOf[lambda, facet[5,r], facet[6,l], facet[9,r], facet[10,r]],
    setOf[facet[5,r], facet[6,r], mu, facet[9,r], facet[10,r]],
    setOf[facet[5,r], facet[6,r], facet[9,l], facet[10,r], nu],
    setOf[lambda, facet[5,l], facet[6,r], mu, facet[9,r], facet[10,r]],
    setOf[lambda, facet[5,l], facet[6,r], facet[9,l], facet[10,r], nu],
    setOf[facet[5,l], facet[6,l], mu, facet[9,l], facet[10,r], nu],
    setOf[lambda, facet[5,r], facet[6,l], mu, facet[9,l], facet[10,r], nu]
};

(* lists of faces. A face is a list of vertices.
   A vertex is a list of 2 numbers *)

faces[n_, rev_:False] := Join @@ N[icosahedra[[n]]]
faces[n_, True] :=
    Join @@ N[ icosahedra[[n]] /.
               {facet[i_, r] :> facet[i, l], facet[i_, l] :> facet[i, r]} ]

faces3D[n_, rev_:False] :=
    Apply[ {#1, #2, 1}&, faces[n, rev], {2} ] (* z coordinate is 1 *)

FaceGraphics[n_Integer, rev:(True|False):False, opts___] :=
    Graphics[ Polygon /@ faces[n, rev], {opts, AspectRatio->Automatic} ]

(* compute plane transforms *)

(* we take an ordinary icosahedron as template *)

targetfaces = Polyhedron[Icosahedron][[1]] /. Polygon[f_]:>f

(* compute normal vectors *)

cross[ {ax_, ay_, az_}, {bx_, by_, bz_} ] :=
	{ay bz - az by, az bx - ax bz, ax by - ay bx}

normal[f_List] := unit[cross[ f[[2]] - f[[1]], f[[3]] - f[[2]] ]]

normals = normal /@ targetfaces;

(* find opposite pairs *)
perm = Flatten[ Position[ normals, #, {1} ]& /@ -normals ]
pairs = Transpose[{Range[Length[perm]], perm}]
pairs = Flatten[ Union[Sort /@ pairs] ]

(*
If[ Union[pairs] === Range[Length[targetfaces]], (* sanity check *)
    targetfaces = targetfaces[[Flatten[pairs]]]
]
*)


(* find the matrix that transforms the three points in template
   into the three points in goal *)

trans[template_, goal_] :=
    Module[{mat = Array[m, {3, 3}]},
        eqs = mat . Transpose[template] == Transpose[goal];
        eqs = Thread[ Flatten /@ eqs ];
        sol = Solve[ eqs, Flatten[mat] ];
        mat /. sol[[1]]
    ]

(* facet[0] should map into the icosahedron faces *)
proto = faces3D[1][[1]];

(* a list of 20 transformation matrices *)

transforms = trans[proto, #]& /@ targetfaces;

(* graphics *)

Options[Icosahedra] = {
(*	EdgeForm -> {}, *)
	Boxed -> False,
	PlaneColoring -> (Hue[Floor[(#-1)/2]/10]&)
}

defaults = {PlotRange->All}; (* changes to standard options *)

Icosahedra[n_, rev:(True|False):False, opts___] :=
    With[{plane = faces3D[n, rev]},
    Module[{planes, edges, colorfunction},
        planes = Function[trans, Map[trans . #&, plane, {2}]] /@ transforms;
        planes = Map[Polygon, planes, {2}];
(*        edges = EdgeForm /. {opts} /. Options[Icosahedra];
        colorfunction = PlaneColoring /. {opts} /. Options[Icosahedra];
        planes = MapIndexed[ Prepend[#1, colorfunction[#2[[1]]]]&, planes ];
*)
        planes
    ]] /; 1 <= n <= Length[icosahedra]


End[]

Share[]
Protect[ Icosahedra, facet, icosahedra, FaceGraphics, faces, r, l ]

EndPackage[]
