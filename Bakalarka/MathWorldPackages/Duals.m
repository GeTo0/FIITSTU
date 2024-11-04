(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.36 *)

(*:Name: MathWorld`Duals` *)

(*:Authors: Eric W. Weisstein
Portions by:
	Peter Messer
	Roman E. Maeder
	Vladidimir Bulatov
 *)

(*:URL:
	  http://mathworld.wolfram.com/packages/Duals.m
*)

(*:Summary:
  The package computes and plots the duals of Platonic, Archimedean,
  and uniform polyhedra. The inputs are either lists of Polygons 
  or a UniformPolyhedron[n].  
*)

(*:History:
  v1.00 (1995-07-07): orignal version by EWW
        (1997-05-19): documented
  v1.01 (1998-04-01): syntax slightly cleaned up
  v1.02 (1998-10-30): Updated to include PlaneGeometry package
  v1.03 (1999-06-19): Updated documentation
  v1.10 (1999-07-15): VertexFigures
  v1.11 (1999-07-23): Bulatov and Messer dual code added.  Added Method to Dual.
  v1.12 (1999-07-27): Added Peter Messer's code as Method->Hemi             
  v1.20 (1999-07-27): Added UniformDuals` code here.  Moved ConvexPolygon
                      to Convexify`EricsConvexifiedPolygon.
  v1.21 (1999-07-28): DualSpheresPlot
  v1.22 (1999-07-29): Modified Dual catchall.  Changed WireFrame to 
                      Wireframe.  Added DualEmbeddedPlot.
  v1.23 (1999-08-11): Fixed up documentation and calls to renamed method Semiregular
  v1.30 (1999-08-28): Moved VertexFigures to Polyhedra.  Completely rewrote
                      DualSemiregulars from scratch.  It should much run faster now.
  v1.31 (2000-01-01): URL updated
  v1.32 (2000-02-24): Added message for when DualSemiregular fails
  v1.33 (2000-09-30): Started updating usage now that NumberedPolyhedron is no 
                      longer defined. Added continuation characters.
                      UniformDual.
  v1.34 (2000-11-13): PolyhedronOperations now added to BeginPackage
  v1.35 (2002-11-06): Convexify correctly referenced in new location
  v1.36 (2003-10-18): updated context

  (c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:
	polyhedron, dual, Archimedean solid, Platonic solids
*)

(*:Requirements:
  The packages needs several additional packages, available from
	http://mathworld.wolfram.com/math/packages/
*)

(*:Discussion:
  See http://mathworld.wolfram.com/DualPolyhedron.html for information
  about duals.
*)

(*:Limitations:

  Method->Semiregular can fail under some circumstances involving 
  intermediate computations with analytic vertices which are apparently 
  not recognized as being equal.
  
  PolygonsAtVertex should be rewritten for speed and robustness.
    
  Documentation needs to be completed.
*)


BeginPackage["MathWorld`Duals`",
	{
	"Graphics`Shapes`",
	"MathWorld`JohnsonSolids`",
	"MathWorld`MiscPolyhedra`",
	"MathWorld`UniformPolyhedra`",
	"MathWorld`PolyhedronOperations`"
	}
]


Bulatov::usage =
"Bulatov is a Method for Dual."
	
PolygonsAtEdge::usage =
"PolygonsAtEdge[poly] does something."

PolygonsAtVertex::usage =
"PolygonsAtVertex[poly][[i]] is a list of edges sharing vertex i, \
so PolygonsAtVertex[poly] is a list of all such lists.  Note that \
analytic points are essentially compared with SameQ, so it must \
be ensure that all equivalent expressions are simplified to be \
identical in poly."

Dual::usage =
"Dual[poly] gives the dual of the specified polyhedron.  \
For methods other than Semiregular, poly must be of the form \
MakeUniform[WythoffSymbol[n]].  UniformDual[n,Method->meth] is \
equivalent to Dual[MakeUniform[WythoffSymbol[n]],Method->meth].  \
For Method->Semiregular, poly must be a list of Polygons.  \
Method->Bulatov uses Vladimir Bulatov's method.  \
Method->Hemi (Height->h) uses Peter Messer's algorithm for hemipolyhedra.  \
Method->Messer0 uses Peter Messer's orginal dual algorithm. \
Method->MesserX uses Peter Messer's dualX algorithm.  \
Method->Semiregular uses efficient code for Platonic and Archimedean solids \
which relies on the fact that the vertices of the dual are on extensions \
of the line from the origin through the centroids d of faces, with length \
given by d rho^2/|d|^2.  \
Method->Triangulated uses Peter Messer's dualTriangulated method."

DualEmbeddedPlot::usage =
"DualEmbeddedPlot[poly,{r,rho,R}] returns a superposed plot a la \
Wenninger."

DualLineDrawing::usage =
"DualLineDrawing."

DualPentagrams::usage =
"DualPentagrams[] converts pentagrams in polyhedra numbers 35 and 53.  \
Code by Peter Messer."

DualSpheresPlot::usage =
"DualSpheresPlot[poly,{r,rho,R}] returns a Graphics3D object of \
the original polyhedra, both it and its dual, and its dual together \
with the circumsphere, midsphere, and circumsphere of the dual."

DualVertex::usage =
"For regular and semirgular solids, the vertices of the dual \
lie on extensions of the the lines from the origin through the centroid \
of each face.  DualVertex returns these points."

Hemi::usage =
"Hemi is a Method for Dual."
	
Messer0::usage =
"Messer0 is a Method for Dual."

MesserX::usage =
"MesserX is a Method for Dual."

PolygonsAtEdge::usage =
"PolygonsAtEdge"

PolygonsAtVertex::usage =
"PolygonsAtVertex"

PrismHeight::usage =
"PrismHeight is an option for Dual[Method->Hemi]."

Semiregular::usage =
"Semiregular is a Method for Dual."

Triangulated::usage =
"Triangulated is a Method for Dual."

UniformDual::usage =
"UniformDual[n,Method->meth] gives the dual of the nth uniform polyhedron.  \
It is equavialent to Dual[MakeUniform[WythoffSymbol[n]]]."


(* Options *)

Options[Dual]={Method->Semiregular,PrismHeight->5}



Begin["`Private`"]


(* Catch-all *)

Dual::UnknownMethod="Unknown method `1` given to Dual."

Dual::UniformMethod="Method `1` is applicable to only uniform polyhedra \
specified in the form MakeUniform[WythoffSymbol[n]].  Try using \
UniformDual[] instead."

Dual::SemiregularMethod="Method `1` is applicable to only Archimedean \
and Platonic solids."


Dual[poly_?PolyhedronQ,opts___]:=Module[{meth=Method/.{opts}/.Options[Dual]},
	Switch[meth,
		Bulatov,     DualBulatov[poly,opts],
		Messer0,     DualMesser0[poly,opts],
		MesserX,     DualMesserX[poly,opts],
		Triangulated,DualTriangulated[poly,opts],
		Hemi,        DualHemi[poly,opts],
		Semiregular, Message[Dual::SemiregularMethod,meth],
		_,Message[Dual::UnknownMethod,meth]
	]
]

Dual[poly_,opts___]:=Module[{meth=Method/.{opts}/.Options[Dual]},
	Switch[meth,
		Bulatov,     Message[Dual::UniformMethod,meth],
		Messer0,     Message[Dual::UniformMethod,meth],
		MesserX,     Message[Dual::UniformMethod,meth],
		Triangulated,Message[Dual::UniformMethod,meth],
		Hemi,        Message[Dual::UniformMethod,meth],
		Semiregular, DualSemiregulars[poly,opts],
		_,Message[Dual::UnknownMethod,meth]
	]
]

UniformDual[n_,opts___]:=Dual[MakeUniform[WythoffSymbol[n]],opts]

(************************** BEGIN MESSER *************************)

centroid[vlist_]:=Plus @@ vlist/Length[vlist]; (*centroid of vertex list*)

rad[coord_List]:=Sqrt[Plus@@(coord^2)];(*distance of point from origin*)

correct[coord_List]:=1/rad[coord]^2 coord;(*sliding correction for point*)

DualMesser0[poly_?PolyhedronQ,opts___]:=(madeUniform=poly;
vertexlist=VertexList[madeUniform]; (*faces around each reference vertex*)
facelist= FaceList[madeUniform];  (*vertices of each reference face*)
vertcoord=VertexCoordinates[madeUniform]//Chop; (*coordinates of all \
vertices*)
vfv=Part[facelist,#]& /@ vertexlist;(*vertices of faces about reference \
vertices*) 
coordfv=Map[Part[vertcoord,#]&, vfv,{2}]; (*coordinates of vfv*)
facecenters=Map[centroid,coordfv,{2}]; (*coordinates of face centers*)
dualizedCoord=Map[correct,facecenters,{2}]//Chop;(*sliding correction \
factors*)
dualPoly=Map[Polygon,dualizedCoord,-3]; (*insert Polygon*)
dualPoly
)

(*Maeder's Convexify function, modified here by PW Messer, accepts 
 any 3D convex or non-convex regular p-gon (or complement p'-gon) 
 encountered in the 75 uniform polyhedra;  Actually, Convexify[]
 accepts any regular p-gon where Denominator[p]= 2 or 3. 
 vlist is the cyclic ordered vertices {{x1,y1,z1},{x2,y2,z2},...} 
 of a p-gon. Non-convex regular p-gons are known as 'regular stars' 
 or simply 'stars'*)

(*edges={}*)

ConvexifyM[vlist_List,p_]:= Convexify[Reverse[vlist],compl[p]]/;
     Denominator[compl[p]]<Denominator[p];

ConvexifyM[vlist_List,p_]:=Module[
	{m=Numerator[p],n=Denominator[p],k,v2list,tria,cent}, 
	k=1+Mod[n Ceiling[p],m] Floor[p];
	v2list={vlist,RotateLeft[vlist,1],RotateLeft[vlist,-k],RotateLeft[vlist,k]};
	v2list=Apply[interM,Transpose[v2list],{1}];
	tria=Transpose[{vlist,v2list,RotateLeft[v2list,-k]}];
	cent={v2list[[Mod[k Range[0,m-1],m]+1]]};
	(*Join[edges,*)Polygon/@Join[tria,cent] (*]*)
]/;Denominator[p]==2;

ConvexifyM[vlist_List,p_]:= Module[
	{m=Numerator[p],n=Denominator[p],k,quadra,v2list,tria,v3list,cent},
	k=1+Mod[n Ceiling[p],m] Floor[p];
	v2list={vlist,RotateLeft[vlist,1],RotateLeft[vlist,-2k],
            RotateLeft[vlist,k]};
	v2list=Apply[interM,Transpose[v2list],{1}];
	v3list={RotateLeft[vlist,-2k],RotateLeft[vlist,k],RotateLeft[vlist,-k], 
                       RotateLeft[vlist,2k]};
	v3list=Apply[interM,Transpose[v3list],{1}];
	quadra=Transpose[{vlist,v2list,v3list,RotateLeft[v2list,-k]}];
	tria=Transpose[{v2list,RotateLeft[v3list,k],v3list}];
	cent={v3list[[Mod[k Range[0,m-1],m]+1]]};
	(*Join[edges,*)Polygon/@Join[quadra,tria,cent] (*]*)
]/; Denominator[p]==3;

ConvexifyM[vlist_List,p_]:=Polygon[vlist] ;(*integer p and catchall*)

(*intersection of two lines (defined by points a,b,c,d) in 3D,
  after Andrew S.Glassner (Ed.),Graphics Gems*)

interM[a_,b_,c_,d_]:=(*REVISE*)
    With[{p1=a,v1=unit[b-a],p2=c,v2=unit[c-d]},
                      Module[{v1v2,n2v1v2,s1,s2},
                      v1v2=cross[v1,v2];
                      n2v1v2=norm2[v1v2];
                      s1=Det[{p2-p1,v2,v1v2}]/n2v1v2;
                      s2=Det[{p2-p1,v1,v1v2}]/n2v1v2;
                      (p1+v1 s1+p2+v2 s2)/2
 ]];


(*rotate vector {a,b,c} about radius axis {c,d,e} where clockwise direction=
    positive radians.*)

rotateM[vector_,axis_,rotang_]:= Module[{p,q,uax},uax=unit[axis];
                                p=uax(uax.vector);q=cross[uax,vector];
                                p+Cos[rotang](vector-p)+Sin[-rotang] q]

(*rotation axis must be unit vector! I changed to clockwise=positive*)

(*rotate[v_,axis_,a_]:=
    With[{p=axis(axis.v),q=cross[axis,v]},p+Cos[a] (v-p)+Sin[-a] q]*)


(*

Below is promising new code that should render most nonconvex dual faces.
However,hemipolyhedra still remain elusive.Right after successfully 
rendering dualX[w2[3/2,4,4]] and dualX[w2[5/3,5,3]] I sent you this 
message out of sheer excitement!  I'm using the name "dualX" only 
temporarily so that I can compare with daul[.Thank you Russell for 
sending me Maxim Rytin's code for split3d[].That's a quantum leap in 
3D rendering and just what I needed.  However, one shortcoming with 
Rytin's code is that I don't think it handles self-intersecting polygons,
i.e.,stars like pentagrams.I couldn't get anywhere with dualX[w1[5/2,2,5]].
We still need Maeder's convexify to render the pentagrams.
    More later.
    Peter Messer
*)

DualMesserX[poly_?PolyhedronQ,opts___]:=(madeUniform=poly;
	vertexlist=VertexList[madeUniform]; (*faces around each reference vertex*)
	facelist=FaceList[madeUniform];  (*vertices of each reference face*) 
	vertcoord=VertexCoordinates[madeUniform]//Chop; (*coordinates of all \
vertices*)
	vfv=Part[facelist,#]&/@vertexlist;(*vertices of faces about reference \
vertices*)
	coordfv=Map[Part[vertcoord,#]&,vfv,{2}]; (*coordinates of vfv*)
	facecenters=Map[centroid,coordfv,{2}]; (*coordinates of face centers*)
	dualizedCoord=Map[correct,facecenters,{2}]//Chop;(*sliding correction \
factors*)
    triangulated=split3d/@dualizedCoord;
	dualPoly=Map[Polygon,triangulated,{-3}]; (*insert Polygon*)
    dualPoly
 )

(*dualTriangulate[Wythoff symbol] dissects dual faces into triangles 
such that each triangle includes the centroid and one side of the face. 
Therefore rendering is correct only if the centroid lies on the 
'inside'of each side.  Such is the case for polygon classes I, II, III.
(See "Progress on Duals").
  
Beyond these three classes, there are several individual case that 
qualify. Three of the more interesting are : 
#64(recall that Rytin's code failed here!) 
#72 (nonregular pentagram)
#74 (the centroid is suspected to lie entirely inside this nonregular 
'hexagram' face, not 'pentgram' as was mistakenly listed before)

Conjecture : dualTriangulate[] renders faster than dualX[]
due to the more symmetrical triangulation in the former?

toTriangles[] is additional new code from Roman Maeder's POVray.m

--- Peter W. Messer, version 7 - 23 - 99 
*)

DualTriangulated[poly_?PolyhedronQ,opts___]:=dualTriangulated[poly]

toTriangles[vlist_List] /; Length[vlist] == 3 := {vlist};

toTriangles[vlist_List] /; Length[vlist] == 4 := 
                            {vlist[[{1, 2, 3}]], vlist[[{3, 4, 1}]]};

toTriangles[vlist_List] :=
     Module[{bary = (Plus @@ vlist)/Length[vlist], circ},
     circ = Partition[ Append[vlist, First[vlist]], 2, 1];
     Apply[ {#1, #2, bary} &, circ, {1} ] ];

dualTriangulated[poly_?PolyhedronQ] := (madeUniform = poly;
   vertexlist = VertexList[madeUniform]; (*faces around each reference \
vertex*)
   facelist = FaceList[madeUniform];  (*vertices of each reference face*)
   vertcoord = 
      VertexCoordinates[madeUniform] // Chop; (*coordinates of all vertices*)
   vfv = Part[facelist, #] & /@ 
        vertexlist;(*vertices of faces about reference vertices*) 
   coordfv = Map[Part[vertcoord, #] &, vfv, {2}]; (*coordinates of vfv*)
   facecenters = Map[centroid, coordfv, {2}]; (*coordinates of face centers*)
   dualizedCoord = 
      Map[correct, facecenters, {2}] // Chop;(*sliding correction factors*)
   triangles = Map[toTriangles, dualizedCoord, {-3}]; (*triangulation*)
   dualPoly = Map[Polygon, triangles, {-3}]; (*insert Polygon*)
   dualPoly
)


(*****
dualHemi[] renders the dual of a hemipolyhedron, a kind of uniform 
polyhedron which has certain faces through the origin.  dualHemi[] 
only accepts Wythoff symbol w2[p, q, r] where 1/p + 1/q = 1 which is 
the necessary condition for a hemipolyhedron.  These duals have 
infinitely long regular prisms through the origin but they are 
truncated in the rendering.
*****)

(*perpendicular direction to plane determined by points v1, v2, v3*)
ortho[{v1_, v2_, v3_}] := Cross[v1 - v2, v2 - v3];

(*feq compares machine numbers; from Maxim Rytin*)
feq[x_, y_, eps_:10^-10] := Plus @@ Abs[x - y] < eps;

(* Only if a parent face contains the origin, then erect a regular 
   prism through the polygon that is dual to that parent face.
   Length of prism's rectangle sides = 10.*)
   
erectPrism[faceVertices_List,h_:5] := If[feq[rad[centroid[faceVertices]], 0],           
	directed = ortho[Take[faceVertices, 3]];(*direction of parent face*)
	farPoint = h/rad[directed] directed; (*farPoint lies 5 from origin*)
	parentBase = Partition[Append[faceVertices, faceVertices[[1]]], 2, 1];
	midPoints = Map[Apply[Plus, #] &, parentBase]/2;
	dualBase = Partition[Append[midPoints, midPoints[[1]]], 2, 1];
	quads = (Map[{farPoint + #, # - farPoint} &,
         dualBase, {-2}]) /. {{w_, x_}, {y_, z_}} -> Polygon[{w, x, z, y}], {}]

(* should define only for   1/p + 1/q == 1; *)

DualHemi[poly_?PolyhedronQ,opts___] := Module[
	{h=PrismHeight/.{opts}/.Options[Dual]},
	(
	madeUniform = poly;
	vertexlist = VertexList[madeUniform]; (*faces around each reference vertex*)
	facelist = FaceList[madeUniform];  (*vertices of each reference face*)
	vertcoord = VertexCoordinates[madeUniform] // Chop; (*coordinates of all \
vertices*)
	vfv = Part[facelist, #] & /@ vertexlist;(*vertices of faces about reference \
vertices*) 
	coordfv = Map[Part[vertcoord, #] &, vfv, {2}]; (*coordinates of vfv*)
	dualPoly = Union[Flatten[Map[erectPrism[#,h]&, coordfv,{2}]]] // Chop; (*all \
prisms*)
	dualPoly
	)
]
	
(***************************** END MESSER ***************************)


(*************************** BEGIN BULATOV ***************************)

pole::Error="Error in pole"

pole[r_, a_, b_, c_] := Module [{p = Cross [b-a, c-a],k},
	k = Dot [p, a];
	If[Abs [k] < 0.000001, 
		Return [p / Sqrt [Dot [p, p]]],
		 Return [p *(r/k)],		
		Message[pole::Error]	
	];
	r
]

DualBulatov[poly_?PolyhedronQ]:=Module[{
	vc = VertexCoordinates[poly],
	fl = FaceList[poly],
	vl = VertexList[poly],
	dvc},
	dvc=Table[pole[1.,vc[[fl[[i,1]]]],vc[[fl[[i,2]]]],vc[[fl[[i,3]]]]],
		{i,Length[fl]}];
    Table[Polygon[Table[ dvc[[vl[[j,i]] ]],{i,Length[vl[[j]]]} ]],
    	{j, Length[vl]}]
]

(************************** END BULATOV *************************)


(************************** BEGIN WEISSTEIN *************************)

centroid[vert_List]:=Plus@@vert/Length[vert]

(* List of indices of polygons sharing an edge *)

DualEmbeddedPlot[poly_,l_List,s_]:=Module[{cum,dual},
	cum=Cumulate[poly,l];
	dual=Dual[Polygon[#[[1]]s]&/@poly,Method->Semiregular];
	Graphics3D[{
		(* Remove duplicated adjacent faces *)
		Polygon/@Union[Sort/@(Flatten[cum] /. Polygon:>Identity)],
		dual
        },Boxed->False]
]

DualEmbeddedPlot[poly_,r_,s_]:=Module[{cum,dual},
	cum=Cumulate[poly,-r];
	dual=Dual[Polygon[#[[1]]s]&/@poly,Method->Semiregular];
	Graphics3D[{
		(* Remove duplicated adjacent faces *)
		Polygon/@Union[Sort/@(Flatten[cum] /. Polygon:>Identity)],
		dual
        },Boxed->False
	]
]

DualLineDrawing[poly_List]:=Module[
	{vertex=DualVertex[poly],edges=PolygonsAtEdge[poly]},
	Line/@(vertex[[#]]&/@edges)
]

(* Assume the Midradius passed through the midpoint of EVERY edge.  This is
in general only true for Platonic and Archimidean solids *)

DualSemiregulars[poly_?PolyhedronQ]:=DualSemiregulars[Graphics3D[poly][[1]]]

(*
DualSemiregulars[poly_,opts___]:=Module[
	{i,j,
	vertex=DualVertex[Chop[poly]],
	cv=PolygonsAtVertex[Chop[poly]]
	},
	Table[Convexify[Polygon[
			FullSimplify[Table[vertex[[cv[[i,j]]]],{j,Length[cv[[i]]]}]]]
		],
	{i,Length[cv]}
	]
]
*)

Dual::badpolygon="PolygonsAtVertex returned polygon(s) with <3 vertices within \
DualSemiregular.  This is impossible.  Suspect simplification failed to collapse \
expressions which are actually identical, or else insufficient numerical precision \
was used."

DualSemiregulars[poly_,opts___]:=Module[
	{
		vertex=DualVertex[poly],
		vertices=PolygonsAtVertex[poly]
	},
	If[Min[Length/@vertices]<3,
		Message[Dual::badpolygon];
		Return[$Failed]
	];
	Convexify/@Polygon/@(vertex[[#]]&/@vertices)
]

DualSpheresPlot[poly_,l_List,opts___]:=Module[{r,rho,R},
	{r,rho,R}=l;
    {
    Graphics3D[{Wireframe[poly],Sphere[r,15,20]},
		opts,Boxed->False],
	Graphics3D[{poly,Wireframe[Sphere[R]]},
		opts,Boxed->False],
    Graphics3D[{poly,Dual[poly,Method->Semiregular],
		Wireframe[Sphere[rho,40,30]]},
		opts,Boxed->False],
	Graphics3D[{Wireframe[Dual[poly,Method->Semiregular]],
		Sphere[r,15,20]},
		opts,Boxed->False]
	}
]

DualSpheresPlot[poly_,name_,opts___]:=DualSpheresPlot[poly,
	{InsphereRadius[name],MidsphereRadius[name],CircumsphereRadius[name]}]

(*
DualVertex[poly_]:=Module[{i,j},
	Table[Sum[poly[[i,1,j]],{j,Length[poly[[i,1]]]}],{i,Length[poly]}]
]

DualVertex[poly_]:=Apply[Plus,Flatten[poly]/.Polygon:>Identity,1]
*)

(* For regular and semiregular solids, the vertices of the dual
lie on extensions of the the lines from the origin through the centroid 
of each face *)

(*DualVertex[poly_List]:=centroid/@(poly/.Polygon:>Identity)*)

DualVertex[poly_List]:=Module[
	{
		rho=Midradius[poly],
		p=Flatten[poly]/.Polygon:>Identity
	},
	#rho^2/normsq[#]&/@(centroid/@p)
]

(*
DualVertexNormalized2[poly_]:=Module[
	{p=poly/.Polygon:>Identity,
	v=DualVertex[poly],
	comedgelist=PolygonsAtEdge[poly],
	r=Midradius[poly],
	rvec={},vvec={},v2={},comface={},theedge={},
	i
	},

	Do[
		(* find the faces sharing edge i *)
		comface=Select[comedgelist,MemberQ[#,i]&,1][[1]];
		Print["comface:",comface];
 		theedge=Intersection[poly[[comface[[1]]]][[1]],poly[[comface[[2]]]][[1]]];
		rvec=(theedge[[1]]+theedge[[2]])/2;
		rvec/=norm[rvec];
		vvec=unit[v[[i]]];
		AppendTo[v2,r/(rvec.vvec) vvec],
		{i,Length[p]}
	];
	v2
]
*)

(* return True if e is an edge of l *)

EdgeQ[l_List,e_List]:=And@@(MemberQ[l,#]&/@e)

(* For a regular or semiregular solid _only_, the midsphere passes 
through the midpoint of each edge, so take the first edge of the first
polygon and find the distance to its midpoint *)

Midradius[poly_]:=norm[(poly[[1,1,1]]+poly[[1,1,2]])/2]

(* Norm of a vector *)

normsq[v_List]:=v.v

norm[v_List]:=Sqrt[normsq[v]]

PolygonsAtEdge[poly_]:=Module[
	{e=PolyhedronEdges[poly],p=Flatten[poly]/.Polygon:>Identity,i},
	Table[Position[p,#,1][[1,1]]&/@Select[p,EdgeQ[#,e[[i]]]&,2],{i,Length[e]}]
]

(* Give a list of lists of polygons sharing each vertex, e.g.
{{1,2,3},{3,4,5},...}
Make sure values of poly are identical for corresponding vertices.
E.g., N[Antiprism[8]] produces 0.5000000000000002`, 0.5000000000000003`, etc.
So you probably need to call N[Antiprism[8],17] to use bignums
*)

(* This is inefficient and could be improved, but is fairly quick calculation in any case *)

PolygonsAtVertex[poly_]:=Module[
	{
		p=Flatten[poly]/.Polygon:>Identity,
		i
	},
	v=Union[Flatten[p,1]];
	Table[Position[p,#][[1,1]]&/@Select[p,MemberQ[#,v[[i]]]&],{i,Length[v]}]
]

UniformDual[36]:=UnifyPolygons[
  DropInnerPolygons[
    NonIntersectingPolygons[
      Graphics3D[
         Dual[UniformPolyhedron[36]]
      ]
    ]
  ]
]

unit[v_List]:=v/norm[v]

xrot[t_]:={{1,0,0},{0,Cos[t],Sin[t]},{0,-Sin[t],Cos[t]}};

yrot[t_]:={{Cos[t],0,Sin[t]},{0,1,0},{-Sin[t],0,Cos[t]}};

zrot[t_]:={{Cos[t],Sin[t],0},{-Sin[t],Cos[t],0},{0,0,1}};


End[]

(* Protect[ ] *)

EndPackage[]