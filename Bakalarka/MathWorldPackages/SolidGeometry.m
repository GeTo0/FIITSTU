(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.55 *)

(*:Name: MathWorld`SolidGeometry` *)

(*:Author: Eric W. Weisstein 

original Cylinder by Flavio Smirne

*)

(*:URL:
  http://mathworld.wolfram.com/packages/SolidGeometry.m
*)

(*:Summary:
  This package implements functionality in solid geometry.
*)

(*:History:
  v1.00                 Written 1996 by Eric W. Weisstein
                        Documented May 19, 1997
  v1.01                 AntiPrism renamed and flatten added
  v1.10 (Oct 14, 1998): Package renamed from Prism to SolidGeometry,
                        AntiPrism renamed to Antiprism,
                        cuboid, Obelisk, Pyramid, PyramidalFrustum,
                        Trapezohedron, Wedge, Wireframe
  v1.20 (Nov  1, 1998): Apple, BohemianDome, ConicalFrustum, CrossCap,
                        Cyclide, cylinder, Deltahedron, EllipticCone, 
                        EllipticCylinder, HalfTorus, Lemon, 
                        PyramidalFrustum, Spheroid,
                        Toroid, torus, TorusCrossSection, TorusPlot
  v1.21 (Nov 11, 1998): EllipticCone no longer uses ParametricPlot3D
  v1.22 (Nov 19, 1998): Barrel
  v1.23 (Dec 13, 1998): Antiprism and Prism modified, cone, ConeGrid,
                        ConeNet, ConeNetFilled, SkewQuadrilateral,
                        TetrahedronCube, ThreadedTetrahedron
  v1.24 (Mar 20, 1999): ConeSphereIntersection
  v1.25 (Mar 26, 1999): EightSurface
  v1.26 (Aug  3, 1999): Polyhedra moved to Polyhedra`
  v1.27 (Aug 15, 1999): Ellipsoid, missing Spheroid added.
  v1.28 (Aug 18, 1999): Hexlet, TangentSphere
  v1.29 (Aug 20, 1999): LinePlaneIntersection
  v1.30 (Sep  9, 1999): ThreadedTetrahedron moved away
  v1.31 (Sep 17, 1999): cuboid moved to Polyhedra`
  v1.32 (Sep 28, 1999): Bimedians, LineLineIntersection3D, Medians3D,
                        TetrahedronEdges, TetrahedronMidpoints
  v1.33 (Oct  1, 1999): TrihedralAngle, TrirectangularTetrahedron
  v1.34 (Oct 30, 1999): Sheaf
  v1.35 (Nov 22, 1999): Inradius3D, TetrahedronVolume, TriangleArea
  v1.36 (Jan  1, 2000): Updated URL
  v1.37 (Feb  6, 2000): Wireframe not includes each line segment only 
                        once
  v1.38 (Apr 16, 2000): Added missing 1/3! to TetrahedronVolume
  v1.39 (Apr 17, 2000): Tetrahedron.
  v1.40 (Jun  2, 2000): Bevel, BeveledPolygon, PointLineDistance.
  v1.41 (Feb 21, 2001): ConsphericQ
  v1.42 (Jan 25, 2002): Bevel moved to PolyhedronOperations.m.
                        Circumsphere added.
  v1.43 (2002-10-03): Removed duplications with PolyhedronOperations`
  v1.44 (2002-10-27): CoplanarQ
  v1.45 (2002-11-17): HessianNormalForm, Intersection3D
  v1.46 (2003-07-07): DihedralAngle
  v1.47 (2003-10-19): added context
  v1.48 (2003-11-02): added local copy of Centroid
  v1.49 (2004-02-10): Removed Apple, Barrel, etc.
  v1.50 (2004-04-08): Removed CrossCap
  v1.51 (2004-11-10): Added Distance3D
  v1.52 (2005-02-06): Sped up TriangleArea3D
  v1.53 (2005-07-13): Cylinder
  v1.54 (2006-03-29): removed cylinder
  v1.55 (2006-07-06): added CuboidPolygons (replaced cuboid wch was removed as some point)

  (c) 1997-2007 Eric W. Weisstein
*)

(*:Keywords:
  antiprism, prism, solid geometry, etc.
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: 

 add CylindricalSegment
 Hexlet is broken and needs to be fixed
 
*)

BeginPackage["MathWorld`SolidGeometry`","Combinatorica`"]

Bimedians3D::usage =
"Bimedians3D[{v1,...,v4}] gives the bimedeans of the specified tetrahedron."

Caps::usage =
"Caps->True|False is an option for cone, and cylinder."

Circumsphere::usage =
"Circumsphere[tetrahedron] gives the analytic circumsphere of a given \
set of four points."

cone::usage =
"cone[n,r,h,z,flip] gives an n-sided cone of radius r, height h, base at \
height z, and flip +/-1.  The option Caps->True can be given."

ConeSphereIntersection::usage =
"ConeSphereIntersection[c,r,{x0,y0,z0}] gives the curve of the intersection \
of a cone (x^2+y^2)/c^2=z^2 with a sphere (x-x0)^2+(y-y0)^2+(z-z0)^2=r^2."

ConicalFrustum::usage =
"ConicalFrustum[n,{x,y,h},s] gives the frustun with base an n-gon, top center 
{x,y,h}, and top scaled by a factor s.  ConicalFrustum[n,h,s] gives the \
frustum with base an n-gon, top centered at {0,0,h}, and top scaled by a factor s."

ConsphericQ::usage =
"ConsphericQ[{v1,...,vn}] returns True if the specified points all lie on a \
common sphere."

CoplanarQ::usage =
"CoplanarQ[{v1,v2,...}] returns True if the set of 3-dimensional points lie \
in a common plane.  The computation is done by ensuring that the distances \
of each point from the plane determined by the first three points is 0."

CuboidPolygons::usage =
"CuboidPolygons[cuboid] gives the polygons corresponding to a Cuboid object."

Cyclide::usage =
"Cyclide[a,c,x0,z0] gives the cyclide generated from the torus with outer \
and inner radii of a and c, repsectively, inverted about the point (x0,z0)."

Cylinder::usage =
"Cylinder[{x1,y1,z1},{x2,y2,z2},r] gives a cylinder."

DihedralAngle::usage =
"DihedralAngle[polygon1,polygon2] gives the dihedral angle between the specified \
polygons, where each polygon has an explicit Head Polygon and must have \
three or more vertices."

Distance3D::usage =
"Distance3D[point,line] or Distance3D[point,polygon] gives the distance \
from the specified point to the specified line or plane.  If point is \
omitted, distance to the origin is assumed."

EightSurface::usage =
"EightSurface[u,v] gives the parametric form of the eight surface."

Ellipsoid::usage =
"Ellipsoid[a,b,c] gives an ellipsoid with semi-major axes a, b, and c."

EllipticCone::usage =
"EllipticCone[h,a] gives the elliptic cone of height h and semimajor axis a."

EllipticCylinder::usage =
"EllipticCylinder[a,h,n] gives the elliptic cylinder of semimajor axis, \
height h, and n side around the circumference."

HalfTorus::usage =
"HalfTorus[a,c] gives half a torus."

HessianNormalForm::usage =
"HessianNormalForm[plane] returns {nx,ny,nz,p} where {nx,ny,nz} is the \
unit normal vector and p is the distance from the plane to the origin."

Hexlet::usage =
"Hexlet[Sphere[xa,ra],xb,{yc,rc},r1] gives Soddy's hexlet for a given \
sphere A Sphere[xa,ra], a sphere B with center xb, a circumsphere C \
of radius rc and center with y-coordinate yc, and first hexlet sphere \
of radius r1."

Inradius3D::usage =
"Inradius3D[tetrahedron] gives the inradius of the tetrahedron \
with specified vertices."

Intersection3D::usage =
"Intersection3D[line1,line2] returns the Point that is the intersection of \
the two specified lines, or {} if they are skew.  Intersection3D[line,plane] \
returns the Point that is the intersection of the specified line and plane, \
or {} if they are coplanar or parallel.  Intersections3D[plane1,plane2] \
returns a Line of intersection for the two specified planes, or {} if \
the planes are parallel.  Intersection3D[plane1,plane2,plane3] returns the \
point of intersection of the specified three planes."

Lemon::usage =
"Lemon[R,r] gives an lemon of revolution of radii R and r."

Medians3D::usage =
"Medians3D[{v1,v2,v3,v4}] gives the medians of the tetrahedron determined \
by the specified vertices."

Obelisk::usage =
"Obelisk[{a,b},{a',b'},h] gives an obelisk of height h and bases a x b and \
a' x b'."

Plane::usage =
"Plane[{x1,x2,x3}] represents a plane using three-point form."

PointLineDistance::usage =
"PointLineDistance[{x1,x2},x0] gives the distance between the line along
{x1,x2} and the point x0, for points in 3-space."

polygon::usage =
"polygon[{v1,...,vn}] returns a closed line."

Sheaf::usage =
"Sheaf[n] gives a 3-D sheaf with n planes."

SkewQuadrilateral::usage =
"SkewQuadrilateral[v,n] gives a skew quadrilateral with vertices v \
illustrated using n lines connecting opposite sides."

Spheroid::usage =
"Spheroid[a,c] gives a spheroid with equatorial radius a and polar radius c."

TangentSphere::usage =
"TangentSphere[Sphere[x1,r1],x2] gives the sphere centered at x2 tangent \
to the specified sphere.  Other syntaxes are \
TangentSphere[Sphere[x1,r1],Sphere[x2,r2],{y,z},r,{1,1}],
TangentSphere[Sphere[x1,r1],Sphere[x2,r2],Sphere[x3,r3],Sphere[x4,r4_],{1,1,1,1}], \
TangentSphere[Sphere[x1,r1],Sphere[x2,r2],{y},r,{1,1}], \
TangentSphere[Sphere[x1,r1],Sphere[x2,r2],Sphere[x3,r3],r,{1,1,1}], \
where +1 indicates external tangency and -1 indicates internal tangency. \
Note that these may return two tangent spheres satisfying the given parameters."

Tetrahedron3D::usage =
"Tetrahedron3D[{v1,v2,v3,v4}] gives the tetrahedron with vertices at the \
four specified points."

TetrahedronCube::usage =
"TetrahedronCube gives a tetrahedron in a cubic frame."

TetrahedronEdges::usage =
"TetrahedronEdges[{v1,...,v4}] gives the edges of the \
tetrahedron with specified vertices."

TetrahedronMidpoints::usage =
"TetrahedronMidpoints[{v1,...,v4}] gives the midpoints \
of the specified tetrahedron."

TetrahedronVolume::usage =
"TetrahedronVolume[tetrahedron] gives the volume of the specified tetrahedron."

Toroid::usage =
"Toroid[d,{r,n},segs] gives a toroid of radius d, n-gon cross-section of r, \
and segs segments around the circumference."

torus::usage =
"torus[a,c] gives a torus."

TorusCrossSection::usage =
"TorusCrossSection[a,c] gives a plot of the cross section of a torus."

TorusPlot::usage =
"TorusPlot[a,c] plots a torus, its bottom half, and its cross-section."

TriangleArea3D::usage =
"TriangleArea3D[{v1,v2,v3}] gives the area of the triangle with 3-D vertices vi."

TrihedralAngle::usage =
"TrihedralAngle[a,b,c] gives the trihedral angle with specified edges."

TrirectangularTetrahedron::usage =
"TrirectangularTetrahedron[a,b,c] gives a trirectangular tetrahedron \
with the specified edge lengths."


(***********************************)
(* Set your favorite defaults here *)
(***********************************)

Options[Solids]={
  Caps->True
};

Intersection3D::parplanes:="Specified planes do not intersect";
Intersection3D::parlines="Specified lines are parallel and have no intersection.";
Intersection3D::skewlines="Specified lines are skew and have no intersection.";

Begin["`Private`"]

Unprotect[Graphics3D]

Graphics3D[expr_?(MemberQ[#,Sphere[_List,__],{0,Infinity}]&),opts___]:=
  Graphics3D[expr /. {
   	Sphere[x_List,r_,n_,m_]:>TranslateShape[Sphere[r,Ceiling[n],Ceiling[m]],x],
  	Sphere[x_List,r_,n_]:>TranslateShape[Sphere[r,Ceiling[n],Ceiling[15r]],x],
  	Sphere[x_List,r_]:>TranslateShape[Sphere[r,Ceiling[20r],Ceiling[15r]],x]
  },opts]

Protect[Graphics3D]

(*
Graphics3D[expr_?(MemberQ[#,_Sphere,{0,Infinity}]&),opts___]:=
  Graphics3D[expr /. Sphere[x_,r_]:>Sphere[r,{20,10}],opts]

Unprotect[Sphere];
Sphere[x_List,r_]:=Sphere[x,r,{20,10}]
Sphere[x_List,r_,pts_List]:=TranslateShape[Sphere[r,pts[[1]],pts[[2]]],x]
Protect[Sphere];
*)


(* *)

addn[n_,k_,m_]:=Mod[n+k-1,m]+1

unit[v_]:=#/Sqrt[#.#]&[v]

Bimedians3D[p_List] := (Line[TetrahedronMidpoints[p][[#1]]]&) /@ {{1,6},{2,5},{3,4}}

Centroid[v_List?MatrixQ]:=Plus@@v/Length[v]

Centroid[Polygon[p_List?MatrixQ]]:=Centroid[p]

Circumsphere[l_List]:=Module[{m,i,a,b,c},
    m=Transpose[
          Table[{x[i]^2+y[i]^2+z[i]^2,x[i],y[i],z[i],1},{i,4}]]/.Flatten[
          Table[Thread[{x[i],y[i],z[i]}->l[[i]]],{i,4}]];
    {a,b,c}=
      {
        Det[Rest[m]],
        Table[(-1)^(i+1) Det[Drop[m,{i+1}]],{i,3}],
        Det[Drop[m,-1]]
        };
    Sphere[b/(2a),Sqrt[b.b-4 a c]/(2Abs[a])]
] /; Length[l]==4


ConcyclicQ[v_List?MatrixQ,eps_:10^-6]:=True /; Length[v]==3

ConcyclicQ[v_List?MatrixQ,eps_:10^-6]:=
  CoplanarQ[v,eps]&&
    UnsameQ[False,
      Reduce[And@@(Function[#.#][#-{x,y,z}]==r^2&/@
      		(v/.n_Real:>Rationalize[n,eps]))&&
      	Element[Alternatives[x,y,z,r],Reals],{x,y,z,r}
      ]
] /; Length[v]>3

cone[n_Integer /; n>=3,r_:1,h_:1,z_:0,flip_:1,opts___]:=Module[
	{caps=Caps/.{opts}/.Options[Solids],i,p,bot},
	bot=Table[r{Cos[2Pi i/n],Sin[2Pi i/n],z},{i,n}];
	p=Table[Polygon[{bot[[i]],bot[[addn[i,1,n]]],{0,0,z+flip h}}],{i,n}];
	If[caps,AppendTo[p,{Polygon[bot]}]];
	Graphics3D[p]
]

ConeSphereCurve[c_,r_,{x0_,y0_,z0_},z_]:=Module[{x,y},
	{x,y,z}/.NSolve[{
	(x^2+y^2)/c^2==z^2,
	(x-x0)^2+(y-y0)^2+(z-z0)^2==r^2},{x,y}]
]

ConeSphereLimits[c_,r_,{x0_,y0_,z0_}]:=Module[{z},
	z/.Solve[ConeSphereCurve[c,r,{x0,y0,z0},z][[1,2,2,4]]==0,z]
]

ConeSphereIntersection[c_,r_,{x0_,y0_,z0_}]:=Module[
	{z,cs,lim=ConeSphereLimits[c,r,{x0,y0,z0}],eps=.00001},
	cs=ConeSphereCurve[c,r,{x0,y0,z0},z];
	Off[ParametricPlot3D::ppcom];
	Show[{
		ParametricPlot3D[cs[[1]],{z,lim[[1]]+eps,lim[[2]]-eps},
          DisplayFunction->Identity],
		ParametricPlot3D[cs[[2]],{z,lim[[1]]+eps,lim[[2]]-eps},
          DisplayFunction->Identity],
		ParametricPlot3D[cs[[1]],{z,lim[[3]]+eps,lim[[4]]-eps},
          DisplayFunction->Identity],
		ParametricPlot3D[cs[[2]],{z,lim[[3]]+eps,lim[[4]]-eps},
          DisplayFunction->Identity]
		},
		Boxed->False,Axes->None
	]
]

ConicalFrustum[n_Integer /; n>=3,{x_,y_,h_},s_]:=Module[{v,i},
	v=Table[{Cos[2Pi i/n],Sin[2Pi i/n]},{i,n}];
	frustum[v,{x,y,h},s]
]

ConicalFrustum[n_Integer /; n>=3,h_,s_]:=ConicalFrustum[n,{0,0,h},s]

ConsphericQ[v_List]:=Module[{x,y,z,r2},
    Solve[(#-{x,y,z}).(#-{x,y,z})==r2&/@v,{x,y,z,r2}]=!={}
]

CoplanarQ[v_List?MatrixQ,eps_:10^-6]:=True /;Length[v]==3

CoplanarQ[v_List?MatrixQ,eps_:10^-6]:=
  Module[{n=Cross[v[[2]]-v[[1]],v[[3]]-v[[1]]]},
      And@@(Abs[n.(v[[1]]-#)]<eps&/@Drop[v,3])
] /; Length[v]>3

CuboidPolygons[{x1_, y1_, z1_}, {x2_, y2_, z2_}] := Polygon /@ {
      {{x1, y1, z1}, {x2, y1, z1}, {x2, y2, z1}, {x1, y2, z1}},
      {{x1, y1, z2}, {x2, y1, z2}, {x2, y2, z2}, {x1, y2, z2}},
      {{x1, y1, z1}, {x2, y1, z1}, {x2, y1, z2}, {x1, y1, z2}},
      {{x2, y1, z1}, {x2, y2, z1}, {x2, y2, z2}, {x2, y1, z2}},
      {{x1, y2, z1}, {x1, y2, z2}, {x2, y2, z2}, {x2, y2, z1}},
      {{x1, y1, z1}, {x1, y1, z2}, {x1, y2, z2}, {x1, y2, z1}}
}

CuboidPolygons[{x_, y_, z_}] := CuboidPolygons[{x, y, z}, {x, y, z} + 1]

Cyclide[a_,c_,r_,x0_,z0_,opts___]:=Module[{u,v,p},
	Off[Power::infy,Infinity::indet,ParametricPlot3D::pplr];
	p=ParametricPlot3D[
		Evaluate[Inv[r,{x0,0,z0},torusfn[{a,c},{u,v}]]],
		{u,0,2Pi},{v,0,2Pi},
		Boxed->False,Axes->False,opts,PlotPoints->{40,15},DisplayFunction->Identity
	][[1]];
	Graphics3D[
	Select[p,(Plus@@(# /. Polygon->Identity)).(Plus@@(# /. Polygon->Identity))<=10^6&]
	]
]

If[$VersionNumber<6.0,
Unprotect[Cylinder];
Cylinder[p1_List,p2_List,r_,opts___?OptionQ]:=
  Module[{len,v,n1,n2,n1y,n1z,n2x,n2y,n2z},    
    (* Calculate Normals *)
    len=Norm[p2-p1];
    v=(p2-p1)/len;
    If[Rest[v].Rest[v]==0,
      {n1,n2}={{0,1,0},{0,0,1}};,
    (* Else *)
      {n1,n2}={{0,n1y,n1z},{n2x,n2y,n2z}};
      n1=n1/.First[Solve[{n1.v==0,n1.n1==v.v},{n1y,n1z}]];
      n2=n2/.First[Solve[{n2.v==0,n2.n1==0,n2.n2==v.v},n2]];
    ];
    (* Create Cylinder *)
    ParametricPlot3D[(h v+r Sin[t]n1+r Cos[t]n2)+(p1+(p2-p1)/2),
    	{h,-len/2,len/2},{t,0,2Pi},opts,PlotPoints->20,DisplayFunction->Identity][[1]]
];
Protect[Cylinder];
]

(*
cylinder[r_:1,h_:2,n_:20,opts___]:=Module[{i,top,bot,p},
	caps=Caps/.{opts}/.Options[Solids];
	bot=Table[{Cos[2Pi i/n],Sin[2Pi i/n],0},{i,n}];
	top=Table[{Cos[2Pi i/n],Sin[2Pi i/n],h},{i,n}];
	p=Table[Polygon[{bot[[i]],bot[[addn[i,1,n]]],top[[addn[i,1,n]]],top[[i]]}],
		{i,n}];
	If[caps,AppendTo[p,{Polygon[top],Polygon[bot]}]];
	Graphics3D[p]
]
*)

DihedralAngle[p__Polygon]:=
  (ArcCos[Dot@@Unit/@(Cross[#[[2]]-#[[1]],#[[-1]]-#[[2]]]&/@First/@{p})] /.
  	{ArcSec[x_]:>Pi-ArcSec[-x], ArcCos[x_]:>Pi-ArcCos[-x]}) /;
  	Dimensions[{p}]=={2}&&Last/@Dimensions/@Last/@{p}=={3,3}&&Min[First/@Dimensions/@Last/@{p}]>=3

(* Distance3D *)

Distance3D[Line[{x1_,x2_}],Point[x0_]]:=Module[
	{t=-(x0-x1).#/#.#&[x1-x2]},
    Sqrt[#.#&[x1-x0+t(x2-x1)]]
]
Distance3D[p_Point,l_Line]:=Distance3D[l,p]
Distance3D[l_Line]:=Distance3D[Point[{0,0,0}],l]

Distance3D[Point[x0_List],Polygon[v_List]]:=Module[
	{n=Unit[Cross[v[[2]]-v[[1]],v[[-1]]-v[[1]]]]},
	Abs[n.(v[[1]]-x0)]
]
Distance3D[p_Polygon,v_Point]:=Distance3D[v,p]
Distance3D[v_Polygon]:=Distance3D[Point[{0,0,0}],v]

EightSurface[u_,v_]:={Cos[u]Sin[2v],Sin[u]Sin[2v],Sin[v]}

Ellipsoid[a_,b_,c_]:=
  ParametricPlot3D[{a Cos[t]Sin[p],b Sin[t]Sin[p],c Cos[p]},{t,0,2Pi},{p,0,Pi},
  	DisplayFunction->Identity
  ][[1]]

EllipticCone[h_,a_]:=Module[{i,n=20,bot},
	bot=Table[{a Cos[2Pi i/n],Sin[2Pi i/n],0},{i,n}];
	Graphics3D[
	Join[{Polygon[bot]},
		Polygon/@Table[{bot[[i]],bot[[addn[i,1,n]]],{0,0,h}},{i,n}]]
	]
]

EllipticCylinder[a_,h_,n_:20,opts___]:=Module[{i,top,bot,p},
	caps=Caps/.{opts}/.Options[Solids];
	bot=Table[{a Cos[2Pi i/n],Sin[2Pi i/n],0},{i,n}];
	top=Table[{a Cos[2Pi i/n],Sin[2Pi i/n],h},{i,n}];
	p=Table[Polygon[{bot[[i]],bot[[addn[i,1,n]]],top[[addn[i,1,n]]],
		top[[i]]}],{i,n}];
	If[caps,AppendTo[p,{Polygon[bot],Polygon[top]}]];
	Graphics3D[{p}]
]

frame[p_]:=Switch[p,
	_Cuboid,Union[(p/.Cuboid->CuboidPolygons)/.Polygon->line],
	_List,Union[(p/.Cuboid->CuboidPolygons)/.Polygon->line],
	_Graphics3D,Union[(p[[1]]/.Cuboid->CuboidPolygons)/.Polygon->line]
]

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

HalfTorus[a_,c_]:=Module[{u,v},
	Graphics3D[
	ParametricPlot3D[torusfn[{a,c},{u,v}],
	{u,0,2Pi},{v,Pi,2Pi},Boxed->False,Axes->False,DisplayFunction->Identity][[1]]
	]
]

HessianNormalForm[Plane[v_List?MatrixQ]]:=Module[{coefs,eqn,x,y,z},
    eqn=Det[Append[#,1]&/@Prepend[v,{x,y,z}]];
    coefs=Append[Coefficient[eqn,{x,y,z}],eqn/.{x->0,y->0,z->0}];
    coefs/Sqrt[#.#]&[Take[coefs,3]]
]

Hexlet[ra_,rb_,rc_,r1_]:=Hexlet[Sphere[{0,0,-ra},ra],{0,0,rb},{0,rc},r1]

Hexlet[Sphere[xa_List,ra_],xb_List,{yc_,rc_},r1_]:=
  Module[{a,b,c,s1,s2,s3,s4,s5,s6},
    a=Sphere[xa,ra];
    b=TangentSphere[a,xb];
    c=TangentSphere[a,b,{yc},rc,{-1,-1}][[1]];
    s1=TangentSphere[a,b,c,r1,{1,1,-1}][[1]];
    s2=TangentSphere[a,b,c,s1,{1,1,-1,1}][[1]];
    s3=Select[TangentSphere[a,b,c,s2,{1,1,-1,1}],!SphereMemberQ[{s1},#]&][[
        1]];
    s4=Select[
          TangentSphere[a,b,c,s3,{1,1,-1,1}],!SphereMemberQ[{a,b,c,s2},#]&][[
        1]];
    s5=Select[
          TangentSphere[a,b,c,s4,{1,1,-1,1}],!SphereMemberQ[{a,b,c,s3},#]&][[
        1]];
    s6=Select[
          TangentSphere[a,b,c,s5,{1,1,-1,1}],!SphereMemberQ[{a,b,c,s4},#]&][[
        1]];
	{
      {a,b,s1,s2,s3,s4,s5,s6} /. Sphere:>sphere,
      c /. Sphere:>sphere /. Polygon[x_]:>Line[Append[x,x[[1]]]]
	} 
]

Inv[r_,x0_List,x_List]:=x0+r^2(x-x0)/(x-x0).(x-x0)

Inradius3D[t_Tetrahedron3D]:=3TetrahedronVolume[t]/
	(TriangleArea3D/@t[[1,#]]&/@{{1,2,3},{1,2,4},{1,3,4},{2,3,4}})

(* Intersection *)

Intersection3D[Line[l1_List?MatrixQ],Line[l2_List?MatrixQ]]:=Module[
	{a=-Subtract@@l1,b=-Subtract@@l2,c,axb,axb2},
	If[Abs[N[axb2=#.#&[axb=Cross[a,b]],200]]==0,
		Message[Intersection3D::parlines];{},
		If[Abs[N[Dot[c=Subtract@@(First/@{l2,l1}),axb],200]]>0,
			Message[Intersection3D::skewlines];{},
			Point[l1[[1]]+a Dot[Cross[c,b],axb]/axb2]
		]
	]
] /; Dimensions[l1]==Dimensions[l2]=={2,3}

(*
Intersection3D[Line[l1_List?MatrixQ],Line[l2_List?MatrixQ]]:=Module[{s,diff},
	If[N[#.#&[Cross@@(diff=Subtract@@@{-l1,l2})],200]==0,
		Message[Intersection3D::parlines];
		{},
	(* Else *)
		Off[LinearSolve::nosol];
		s=LinearSolve[Transpose[diff],Subtract@@First/@{l2,l1},ZeroTest->(N[#,200]==0&)];
		On[LinearSolve::nosol];
		If[Head[s]===LinearSolve,
			Message[Intersection3D::skewlines];
			{},
		(* Else *)
			Point[l1[[1]]+s[[1]](l1[[2]]-l1[[1]])]
		]
	]
] /; Dimensions[l1]==Dimensions[l2]=={2,3}
*)

(*intersection of two lines in 3D,after Andrew S.Glassner (Ed.),
  Graphics Gems.Modified by EWW to return {} if there is no intersection*)

(*
norm2[v_List]:=v.v
norm[v_List]:=Sqrt[norm2[v]]
unit[v_List]:=v/norm[v]

Intersection3D[Line[{a_,b_}],Line[{c_,d_}]]:=
  With[{p1=a,v1=unit[b-a],p2=c,v2=unit[c-d],eps=.0001},
    Module[{v1v2,n2v1v2,s1,s2},v1v2=Cross[v1,v2];
      n2v1v2=norm2[v1v2];
      If[Abs[n2v1v2]<eps,{},s1=Det[{p2-p1,v2,v1v2}]/n2v1v2;
        s2=Det[{p2-p1,v1,v1v2}]/n2v1v2;
        (p1+v1 s1+p2+v2 s2)/2]]
] /; Dimensions[a]==Dimensions[b]==Dimensions[c]==Dimensions[d]=={3}
*)

Intersection3D[Plane[{{x1_,y1_,z1_},{x2_,y2_,z2_},{x3_,y3_,z3_}}],
	Line[{{x4_,y4_,z4_},{x5_,y5_,z5_}}]]:=Module[
	{t=-Det[{{1,1,1,1},{x1,x2,x3,x4},{y1,y2,y3,y4},{z1,z2,z3,z4}}]/
          Det[{{1,1,1,0},{x1,x2,x3,x5-x4},{y1,y2,y3,y5-y4},{z1,z2,z3,z5-z4}}]},
    Point[{x4+t(x5-x4),y4+t(y5-y4),z4+t(z5-z4)}]
]

Intersection3D[p_Plane,l_Line]:=Intersection[l,p]

Intersection3D[Plane[x1_List?MatrixQ],Plane[x2_List?MatrixQ]]:= 
  Module[{
        h=HessianNormalForm[Plane[#]]&/@{x1,x2},
        m,nullsp
        },
      m=Take[#,3]&/@h;
      If[Length[nullsp=NullSpace[m]]!=1,
        Message[Intersection3D::parplanes];{},
        Line[LinearSolve[m,-Last/@h,ZeroTest->(N[#,200]==0&)]+# nullsp[[1]]&/@{-1,1}]
        ]
] /; Dimensions[x1]==Dimensions[x2]=={3,3}

Intersection3D[Plane[x1_List?MatrixQ],Plane[x2_List?MatrixQ],Plane[x3_List?MatrixQ]]:=
    Module[
    {
        u=Drop[HessianNormalForm[Plane[#]],-1]&/@{x1,x2,x3},
        p=First/@{x1,x2,x3}
    },
    Point[
    	Plus@@(Dot[p[[#1]],u[[#1]]]Cross[u[[#2]],u[[#3]]]&@@@
              NestList[RotateLeft,Range[3],2])/Det[u]
    ]
] /; Dimensions[x1]==Dimensions[x2]==Dimensions[x2]=={3,3}

Lemon[R_,r_]:=Module[{x},
	Graphics3D[{
	SurfaceOfRevolution[{x,Sqrt[R^2-(x+r)^2]},{x,0,R-r},
		Boxed->False,Axes->False,DisplayFunction->Identity][[1]],
	SurfaceOfRevolution[{x,-Sqrt[R^2-(x+r)^2]},{x,0,R-r},
		Boxed->False,Axes->False,DisplayFunction->Identity][[1]]
	}]
]

line[l_List]:=Line[Join[l,{l[[1]]}]]

lines[v_List]:=Line/@Sort/@Partition[v,2,1,1]

Medians3D[v_List]:=
  Line[{v[[Complement[Range[4],#][[1]]]],Centroid[v[[#]]][[1]]}]&/@
    KSubsets[Range[4],3]

Obelisk[v1_List,v2_List,h_:1,opts___]:=Module[{i,bot,top,a={v1,v2},c,p},
	{bot,top}=Table[{
		{-a[[i,1]],-a[[i,2]],(i-1)h},{a[[i,1]],-a[[i,2]],(i-1)h},
		{a[[i,1]],a[[i,2]],(i-1)h},{-a[[i,1]],a[[i,2]],(i-1)h}},
	{i,2}];
	c=Plus@@bot/4;
	p=Polygon[bot];
	{
	Polygon[top],p,
	Table[Polygon[{bot[[i]],bot[[addn[i,1,4]]],top[[addn[i,1,4]]],top[[i]]}],{i,4}]
	}
]

ObeliskBroken[v1_List,v2_List,h_]:=Module[{i,bot,top,a={v1,v2},c},
	{bot,top}=Table[{
		{-a[[i,1]],-a[[i,2]],(i-1)h},{a[[i,1]],-a[[i,2]],(i-1)h},
		{a[[i,1]],a[[i,2]],(i-1)h},{-a[[i,1]],a[[i,2]],(i-1)h}},
	{i,2}];
	c=Plus@@bot/4;
	{
	Polygon[top],
	Polygon/@Table[{bot[[i]],bot[[addn[i,1,4]]],c},{i,4}],
	Table[Polygon[{bot[[i]],bot[[addn[i,1,4]]],top[[addn[i,1,4]]],top[[i]]}],{i,4}]
	}
]

polygon[v_List]:=Line[Append[v,v[[1]]]]

twopi=N[2Pi];

Segment[d_,{R_,n_},{t_,dt_}]:=Module[{i},
Table[Polygon[{
  {(d+R Cos[twopi(i-.5)/n])Cos[t],   (d+R Cos[twopi(i-.5)/n])Sin[t],   Sin[twopi(i-.5)/n]},
  {(d+R Cos[twopi(i+.5)/n])Cos[t],   (d+R Cos[twopi(i+.5)/n])Sin[t],   Sin[twopi(i+.5)/n]},
  {(d+R Cos[twopi(i+.5)/n])Cos[t+dt],(d+R Cos[twopi(i+.5)/n])Sin[t+dt],Sin[twopi(i+.5)/n]},
  {(d+R Cos[twopi(i-.5)/n])Cos[t+dt],(d+R Cos[twopi(i-.5)/n])Sin[t+dt],Sin[twopi(i-.5)/n]}}],  
  {i,0,n}]
]

Sheaf[n_Integer?Positive,l_Integer:1]:=Module[{i},
	{
	{Thickness[.015],Line[{{-1,0,0},{l+1,0,0}}]},
	Table[
        Polygon[{{0,Cos[2Pi i/n],Sin[2Pi i/n]},
            {l,Cos[2Pi i/n],Sin[2Pi i/n]},
            {l,0,0},
            {0,0,0}
		}],
	{i,n}]
	}
]

SkewQuadrilateral[v_List /; Length[v]==4,n_:10]:=Module[{i},
	{
	Line[Join[v,{v[[1]]}]],
	Line/@Table[{v[[1]]+i/n(v[[2]]-v[[1]]),v[[4]]+i/n(v[[3]]-v[[4]])},{i,n-1}],
	Line/@Table[{v[[1]]+i/n(v[[4]]-v[[1]]),v[[2]]+i/n(v[[3]]-v[[2]])},{i,n-1}]
	}
]


(*
Returns True if s=Sphere[{x,y,z},r] is approximately equal in
center and radius to one of those in the list
l={Sphere[{xi,yi,zi},ri],...}
*)

SphereMemberQ[l_List,s_]:=Module[{eps=.01},
    Or@@((Norm[s[[1]]-#[[1]]]<eps&&Abs[s[[2]]-#[[2]]]<eps)&/@l)
]

Spheroid[a_,c_]:=Ellipsoid[a,a,c]

TangentSphere::NoTangent = 
    "There is no tangent sphere satisfying the given properties.";

TangentSphere[Sphere[x1_List,r1_],x2_List]:=Sphere[x2,Norm[x2-x1]-r1]

TangentSphere[Sphere[x1_List,r1_],Sphere[x2_List,r2_],{y_,z_},r_,
    sign_List:{1,1}]:=Module[{x,soln},
    soln=Solve[Normsq[x1-{x,y,z}]==(r1+sign[[1]]r)^2,x];
    If[soln=={},Message[TangentSphere::NoTangent];Return[]];
    Sphere[Join[{#},{y,z}],r]&/@(x/.soln)
]

TangentSphere[Sphere[x1_List,r1_],Sphere[x2_List,r2_],Sphere[x3_List,r3_],
    Sphere[x4_List,r4_],sign_List:{1,1,1,1}]:=Module[{x,y,z,r,soln},
    soln=Solve[{
          Normsq[x1-{x,y,z}]==(r1+sign[[1]]r)^2,
          Normsq[x2-{x,y,z}]==(r2+sign[[2]]r)^2,
          Normsq[x3-{x,y,z}]==(r3+sign[[3]]r)^2,
          Normsq[x4-{x,y,z}]==(r4+sign[[4]]r)^2
          },{x,y,z,r}];
    If[soln=={},Message[TangentSphere::NoTangent];Return[]];
    Sphere[Take[#,3],#[[-1]]]&/@({x,y,z,r}/.soln)
]

TangentSphere[Sphere[x1_List,r1_],Sphere[x2_List,r2_],{y_},r_,
    sign_List:{1,1}]:=Module[{x,z,soln},
    soln=Solve[{Normsq[x1-{x,y,z}]==(r1+sign[[1]]r)^2,
          Normsq[x2-{x,y,z}]==(r2+sign[[2]]r)^2},{x,z}];
    If[soln=={},Message[TangentSphere::NoTangent];Return[]];
    Sphere[Insert[#,y,2],r]&/@({x,z}/.soln)
]

TangentSphere[Sphere[x1_List,r1_],Sphere[x2_List,r2_],Sphere[x3_List,r3_],r_,
    sign_List:{1,1,1}]:=Module[{x,y,z,soln},
    soln=Solve[{
          Normsq[x1-{x,y,z}]==(r1+sign[[1]]r)^2,
          Normsq[x2-{x,y,z}]==(r2+sign[[2]]r)^2,
          Normsq[x3-{x,y,z}]==(r3+sign[[3]]r)^2
          },{x,y,z}];
    If[soln=={},Message[TangentSphere::NoTangent];Return[]];
    Sphere[#,r]&/@({x,y,z}/.soln)
]

Tetrahedron3D[v_List?MatrixQ]:=Polygon/@KSubsets[v,3]

TetrahedronCube:=Module[
	{t={{0,0,0},{0,1,1},{1,0,1},{1,1,0}},
	k={{1,2,3},{1,2,4},{1,3,4},{2,3,4}},
	i},
	{
		Polygon/@Table[t[[k[[i]]]],{i,Length[k]}],
		frame[Cuboid[{1,1,1}]][[1]]
	}
]

TetrahedronEdges[p_List] := (Line[p[[#1]]]&) /@ KSubsets[Range[4], 2]

TetrahedronMidpoints[p_List] := (Plus @@ p[[#1]]/2&) /@ KSubsets[Range[4], 2]

TetrahedronVolume[{x1_,x2_,x3_,x4_}]:=Module[{i={1,1,1,1}},
    Det[Join[Transpose[{x1,x2,x3,x4}],{i}]]/3!
]
    
Toroid[d_,{R_,n_},segs_]:=Module[{t},
	Table[Segment[d,{R,n},{t,twopi/segs}],{t,0,twopi,twopi/segs}]
]

torusfn[{a_,c_},{u_,v_}]:={(c+a Cos[v])Cos[u],(c+a Cos[v])Sin[u],a Sin[v]}

torus[a_,c_]:=Module[{u,v},
	Graphics3D[
	ParametricPlot3D[torusfn[{a,c},{u,v}],
	{u,0,2Pi},{v,0,2Pi},Boxed->False,Axes->False,DisplayFunction->Identity][[1]]
	]
]

TorusCrossSection[a_,c_,opts___]:=Module[{t},
	ParametricPlot[{{-c+a Cos[t],a Sin[t]},{c+a Cos[t],a Sin[t]}},
	{t,0,2Pi},opts,AspectRatio->Automatic]
]

TorusPlot[a_,c_]:=Show[GraphicsArray[{
	Show[torus[a,c],Boxed->False,DisplayFunction->Identity],
	Show[HalfTorus[a,c],Boxed->False,DisplayFunction->Identity],
	Show[TorusCrossSection[a,c],Ticks->None,DisplayFunction->Identity]
}]]

TrihedralAngle[a_List,b_List,c_List]:=Module[{O={0,0,0}},
    Polygon/@{{O,a,a+b,b},{O,a,a+c,c},{O,b,b+c,c}}
]

TriangleArea3D[{{x1_,y1_,z1_},{x2_,y2_,z2_},{x3_,y3_,z3_}}]:=
	Sqrt[(-x2*y1+x3*y1+x1*y2-x3*y2-x1*y3+x2*y3)^2+
	(x2*z1-x3*z1-x1*z2+x3*z2+x1*z3-x2*z3)^2+
	(-y2*z1+y3*z1+y1*z2-y3*z2-y1*z3+y2*z3)^2]/2

TrirectangularTetrahedron[a_,b_,c_]:=
  Module[{v={{0,0,0},{a,0,0},{0,b,0},{0,0,c}}},
    Polygon[v[[#]]]&/@KSubsets[Range[4],3]
]

Unit[v_]:=v/Norm[v]

Wireframe[l_List]:=Union[frame[l]]

End[]

(* Protect[  ] *)

EndPackage[]