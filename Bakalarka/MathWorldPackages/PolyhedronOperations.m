(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.37 *)

(*:Name: MathWorld`PolyhedronOperations` *)

(*:Author:

Eric W. Weisstein (eww@wolfram.com)

*)

(*:Summary:

Adds functionality to construct and perform operations on polyhedra.

*)

(*:URL:
	Current version available from
	
	http://mathworld.wolfram.com/packages/PolyhedronOperations.m
*)


(*:History:
  v1.00 (2000-11-13): Broke off from Polyhedra.m and added partition
  v1.01 (2000-11-30): Documentation cleaned up
  v1.02 (2001-02-21): ConsphericQ.
  v1.03 (2002-01-25): Moved Bevel here from SolidGeometry.m.
                      Fixed up date
  v1.04 (2002-07-17): SphericalPolyhedron
  v1.05 (2002-08-01): PolyhedronInequalities
  v1.06 (2002-08-08): Wrapped And around PolyhedronInequalities.
                      SplitPolyhedron.  Fixed and improved VertexLabels.
  v1.07 (2002-10-03): Removed duplications with PolyhedronOperations`
  v1.08 (2002-10-15): Circumradius, Inradius, Midradius
  v1.09 (2002-10-26): VertexFigures now returns polygons, added Convexify.
                      Convexify now takes tolerance, fixed projection plane
                      determination.  VertexFigures now more efficient and takes
                      Convex->True option
  v1.10 (2002-11-07): PolyhedronFaces, Polyhedron, PolyhedronVertices
  v1.11 (2002-11-09): Net, NetFaces, NetVertices, PolyhedronDual, PolyhedronName.
                      Moved Net here from JohnsonSolids.m and combined Net and
                      ColoredNet.
  v1.12 (2002-11-20): ToExact rewritten for speed.  Polygon2D now returns a
                      normalized polygon, with first vertex {0,0} and last on the
                      x-axis
  v1.13 (2002-12-11): ToExact moved to Simplify.m
  v1.14 (2002-12-27): Fixed roty, fixed Polygon2D
  v1.15 (2002-12-31): Modified PolyhedronRotationCompound; added PolyhedronPolyhedra.
                      Polyhedron now evaluates only if PolyhedronFaces and PolyhedronVertices
                      are defined, and returns a list of lists if PolyhedronPolyhedra is
                      defined.  Moved RotationMatrixX/Y/Z here.  Colorize.
  v1.16 (2003-01-11): NetPieces.  Remove NonConvexHull in favor of Polyhedron[poly,Split->True].
                      NetDiagram, NetEdgeLengths, NetEdges.
  v1.17 (2003-01-25): Fixed RotationMatrixY.
  v1.18 (2003-02-20): Fixed up Orientation stuff and added OrientedQ
                      Fixed Convexify.  Added HalfIcosahedralGroup and IcosahedralGroup
                      courtesy of Ed Pegg, Jr.  Junked obsolete routines.
  v1.19 (2003-02-21): Moved Wireframe here and moved IcosahedralGroup routines
                      to Groups.m
  v1.20 (2003-04-04): SphericalPolyhedron now accepts a symbolic polyhedron (without
                      Polyhedron[] wrapped around it)
  v1.21 (2003-07-28): Added BoxRatios->{1,1,1} and option passing to HiddenWireframe
  v1.22 (2003-08-24): Centroid[Polygon[]]
  v1.23 (2003-09-14): NetPrintout.  Fixed Net.
  v1.24 (2003-09-17): NetPrintout now properly inhibits character substitution
  v1.25 (2003-10-05): Fixed Centroid
  v1.26 (2003-10-19): updated contexts
  v1.27 (2003-11-09): Cumulate now accepts any input containing Polygons at any level
                      Added PDFDirectory for NetPrintout
  v1.28 (2003-11-15): FaceIntersections, NetSurfaceArea
  v1.29 (2003-12-07): Replaced PolyhedronFaceLists with PolyhedronFaces[list]
  v1.30 (2003-12-08): Added Diameters
  v1.31 (2003-12-09): NonparallelVectors
  v1.32 (2003-12-20): Expansion, Snubify, SymbolicUnion, TruncateByPlanes.
                      Added OrientPolygon message for degenerate points.  Removed EdgeLengths.
  v1.33 (2004-09-14): Defined NetFaces[list]
  v1.34 (2004-11-10): Fixed Inradius, moved PointPlaneDistance to SolidGeometry`Distanced3D
  v1.35 (2006-06-21): Changed the sign of RotationMatrix
  v1.36 (2006-07-06): Remove incorrect BoxRatios from HiddenWireframe options
  v1.37 (2007-04-01): Volume Centroid, MomentOfInertia based on IntegrateOverPolygon

  (c) 2000-2007 Eric W. Weisstein
  
  Volume Centroid, MomentOfInertia and IntegrateOverPolygon by
  Sasha Pavlyk
  March 2007
*)

(*:Keywords:
*)

(*:Requirements:
*)

(*:Discussion:

*)

(*:References: *)

(*:Limitations:
	
	This package is still under construction and is not intended to
	be a finished product.
	
	Documentation not complete.
	
	SphericalPolyhedron requires a future version of
	Mathematica to render the concave polygons properly
*)

BeginPackage["MathWorld`PolyhedronOperations`",
	{
	"Combinatorica`",
	"MathWorld`Graphs`",
	"Utilities`FilterOptions`",
	"MathWorld`ConvexHull`",
	"MathWorld`SolidGeometry`",
	"MathWorld`VertexEnum`"
	}
]

AdjacentFaceIndices::usage =
"AdjacentFaceIndices[poly] gives a list of the index pair of the faces of poly \
that are adjacent."

Bevel::usage =
"Bevel[poly-list,w,<h>] takes a list of Polygons and returns a list of \
polygonal 'frames' on the same vertices of width w.  If h>0 is specified, \
then the edges of the frame are extended inwards with sides taken along \
radii towards (0,0,0).  Note that these inward-pointing planes are \
currently not internally capped and so are left open."

BeveledPolygon::usage =
"BeveledPolygon[{v1,...,vn},w,<h>] returns a \
polygonal 'frame' on the same vertices of width w.  If h>0 is specified, \
then the edges of the frame are extended inwards with sides taken along \
radii towards (0,0,0)."

Centroid::usage =
"Centroid[{v1,...,vn}] or Centroid[Polygon[{v1,...,vn}]] gives the centroid \
of the specified polygon.  Centroid[graphicscomplex] computes the centroid \
of the polynomial specified by the given GraphicsComple.  Centroid[name] computes \
the centroid of the specified PolyhedronData object."

Circumradius::usage =
"Circumradius[polyhedron] gives the distance from the origin (assumed \
to be the polyhedron's center) to the first vertex of its first face."

ClosedLine::usage =
"ClosedLine[l] gives a line that adds an edge between the first and last \
vertices."

Colored::usage =
"Colored->(True|False) is an option for Net."

Colorize::usage =
"Colorize[polyhedron-compound,colors] colors a Polyhedron object.  If specified, \
Colors->{color1,...} is a list of colors to use cyclically.  If not specified, \
Automatic is used which chooses Hue[i/n] for polyhedron number i=1, 2, ..., n \
in the compound.  A complete sample syntax is \
Show[Graphics3D[Colorize[Polyhedron[Cube3Compound],Colors->{Red,Yellow,Blue}]]."

Colors::usage =
"Colors->{3->color1, 4->color2,...} is an option to Net that \
specifies the colors to paint faces with specified number of vertices.  \
Colors->{color1,color2,...} is an option for Colorize[polyhedron-compound] \
that allows specification of a list of colors that will be used cyclically."

Convex::usage =
"Convex->(True|False) is an option to VertexFigures that fills in the polygonal \
holes centered on the original face centroids."

Convexify::usage =
"Convexify[polygon] uses Mathematica's 2-D ConvexHull routine \
to return a 3-dimensional polygon with the same vertices as the original, \
but specified in convex order.  Convexify[polygon,tol] uses tolerance tol \
for zero determination when finding an appropriate projection plane."

Cumulate::usage =
"Cumulate[polyhedron,h] replaces faces of a polyhedron with pyramids \
of height h on the same vertices. h may be negative, zero, or \
positive.  If h is a list of the form {{n1,h1},...{nk,hk}}, then \
ni-gonal faces are cumulated with height hi, and any faces not in the \
list are not cumulated."

CumulateFace::usage =
"CumulateFace[poly,h] gives a pyramid of height h with base on the \
vertices of the specified polygon."

CumulateWireframe::usage =
"CumulateWireframe[polyhedron,scale] replaces faces of a polyhedron with  \
pyramids of height scale on the same vertices, drawing the pyramid edges \
as lines on top of the original polyhedron."

Diameters::usage =
"Diameters[named-polyhedron] gives the longest vertex-vertex distances of \
Polyhedron[named-polyhedron]."

DihedralAngles::usage =
"DihedralAngles[poly] gives a list of dihedral angle rules."

DualModel::usage =
"DualModel."

Expansion::usage =
"Expansion[poly,r] moves the specified polygona outward by a distance r \
and fills the gaps with new faces.  Expansion[poly,r,fn] uses the \
specified function for simplification before passing on to ConvexHull3D."

FaceIntersections::usage =
"FaceInterscetions[poly] gives the set of all lines of intersections \
of the faces in the specified polyhedron."

FromFaces::usage =
"FromFaces[l] gives the graph corresponding to the connectivtity \
table represented by the list of face indices."

GeneralizedDiameter::usage =
"GeneralizedDiameter[poly] gives the generalized diameter of the specified polyhedron."

GeometricCentroid::usage =
"GeometricCentroid[] gives the geometric centroid of the specified polyhedron."

HiddenWireframe::usage =
"HiddenWireframe[poly,<opts>] returns a Graphics object representing the list of \
Polygons poly such that hidden lines are distinguished from visible lines.  Options \
ViewPoint->{x,y,z} and PlotStyles->{frontstyle,backstyle} can be specified."

HullSpiderWeb::usage =
"HullSpiderWeb[poly,hull] generates a list of two Graphics3D objects, the first is a
spiderweb overlaid on poly and the second is the convex hull itself.  If name is Self,
then the solid itself is used as the convex hull."

InertiaTensor::usage =
"InertiaTensor[nam, simp1, simp2] computes the moment of inertia tensor
of the specified PolyhedronData object using the given simplification functions."

InertiaTriangle::usage =
"InertiaTriangle[nam, simp1, simp2] computes the moment of inertia triangle
of the specified PolyhedronData object using the given simplification functions."

Inradius::usage =
"Inradius[polyhedron] gives the distance from the origin (assumed \
to be the polyhedron's center) to the centroid of its first face."

Labeled::usage =
"Labeled->(True|False) is an option for Net."

Lines::usage =
"Lines->(True|False) is an option for Net."

ListEdges::usage =
"ListEdges."

Midpoint::usage =
"Midpoint[{v1,v2}] gives the midpoint of the given line segment."

MidpointCumulate::usage =
"MidpointCumulate[poly,scale] replaces the list of polygons with \
flat triangular pyramids on the face and a pyramid of height h with \
vertices on the edge midpoints.  scale may be negative, zero, or \
positive.  If scale is a list of the form {{n1,s1},...{nk,sk}}, then \
ni-gonal faces are cumulated with height si, and any faces not in the \
list are not cumulated."

Midradius::usage =
"Midradius[polyhedron] gives the distance from the origin (assumed \
to be the polyhedron's center) to the midpoint of the first edge of its \
first face)."

Net::usage =
"Net[polyhedron] give a list of 2-D Polygons representing the net of the specified \
polyhedron.  For Johnson solids, the vertices of the net are \
specified exactly when known, and the scale is chosen so that all edges \
have length unity.  Options to Net include Colored, Labeled, Lines, and Colors."

NetConnectivity::usage =
"NetConnectivity[net] gives a list of the vertices adjacent to each \
vertex of a net specified as a series of lines."

NetDiagram::usage =
"NetDiagram[polyhedron] plots the net of the polyhedron with edge lengths labeled in \
increasing order."

NetEdgeLengths::usage =
"NetEdgeLengths[polyhedron] gives a list of the length of the edges of the \
specified polyhedron in the ordering of NetEdges[polyhedron]."

NetEdges::usage =
"NetEdges[polyhedron] gives a list of the indices of the edges of the net \
for the specified polyhedron, where the ordering is that of NetVertices[polyhedron].  \
Use in conjunction with Net[polyhedron]."

NetFaces::usage =
"NetFaces[polyhedron] gives a list of the indices of NetVertices[polyhedron] that specify \
the faces of a net.  Use in conjunction with Net[polyhedron]."

NetPieces::usage =
"NetPieces[polyhedron] is a list of the form {{n1,{f11,f12,..}},..} \
that indicates the indices fij of the NetFaces that form separate \
pieces of the net for a concave polyhedron that cannot be constructed from a single \
connected net.  The first element of each list is the count of number of pieces \
of that type needed."

NetPrintout::usage =
"NetPrintout[polyhedron,filename,opts] exports a copy of specified polyhedron to a PDF \
file.  NetPrintout accepts the same options as Net."

NetSurfaceArea::usage =
"NetSurfaceArea[polyhedron] gives the surface area for a polyhedron with a net \
defined."

NetVertices::usage =
"NetVertices[polyhedron] gives a list of vertices of the net of the specified solid.  \
Use in conjunction with Net[polyhedron].  NetVertices[line-list] gives the vertices \
of a net specified as a series of lines."

NonparallelVectors::usage =
"NoneparallelVectors[{v1,v2,...}] gives a subset of the given vectors with any parallel vectors \
removed."

NormalizedNet::usage =
"NormalizedNet[poly] gives a normalized form of the specified net."

Orient::usage =
"Orient[{polygon1,polygon2,...}] orients the faces of polygons with normal pointing outward, \
where outward is assumed to mean in a direction increasing the distance from {0,0,0}.  \
Orient[{polygon1,polygon2,...},{x,y,z}] assumes that {x,y,z} is at the center, so outward \
means the direction increasing the distance from {x,y,z}."

OrientedQ::usage =
"OrientedQ[{polygon1,polygon2,...}] returns a list of Booleans indicating if each polygon \
is positively oriented.  OrientedQ[{polygon1,polygon2,...},{x,y,z}] uses the point {x,y,z} \
as the center."

OrientPolygon::usage =
"OrientPolygon[list] takes a list of vertices and orients then so that the \
first and last edges form an outward-pointing cross product.  It returns a \
Polygon object."

PDFDirectory::usage =
"PDFDirectory is an option for NetPrintout."

PDFName::usage =
"PDFName is an option for NetPrintout."

PlotStyles::usage =
"PlotStyles->{style1,style2} is an option for HiddenWireframe."

Polygon2D::usage =
"Polygon2D[{v1,v2,...}] given a list of 3-D vertices, Polygon2D returns an \
equiavelent Polygon[] object with vertices in the plane that is congruent to the \
original 3-D polygon.  The resulting vertices will contain ArcTans of complicated \
expressions, but can sometimes be converted to algebraic numbers using ToExact.  \
The returned polygon has first vertex at {0,0}."

Polygon3D::usage =
"Polygon3D[Polygon[poly2d],z,vec] takes a 2-D polygon and transforms \
it back into 3-space."

PolygonArea::usage =
"PolygonArea[list] gives the area of an arbitrary convex planar polygon in \
3-D computed by triangulating it."

Polyhedron::usage =
"Polyhedron[polyhedron] gives a list of Polygons with exact vertices \
representing the given polyhedron, assuming that PolyhedronVertices[polyhedron] \
and PolyhedronFaces[polyhedron] are defined.  If PolyhedronPolyhedra[polyhedron] is \
also defined, the expression returned is a list of lists of Polygons, with each \
sublist representing a single polyhedron in a compound."

PolyhedronCompoundSurfaceArea::usage =
"PolyhedronCompoundSurfaceArea[poly] gives the volume of a compound \
of a polyhedron and its dual, making the assumption that poly \
is in the form {{rim1,pyr1},{rim2,pyr2}...}."

PolyhedronCompoundVolume::usage =
"PolyhedronCompoundVolume[poly] gives the volume of a compound \
of a polyhedron and its dual, making the assumption that poly \
is in the form {{rim1,pyr1},{rim2,pyr2}...}."

PolyhedronDataString::usage =
"PolyhedronDataString[{poly, polyname, name, url}, classes, simp] gives a string \
for a specified polyhedron poly with StandardName polyname, Name name, url, \
is a member of the given classes (possibly {}), and the simplification function simp \
is applied."

PolyhedronDual::usage =
"PolyhedronDual[polyhedron] gives the name of the polyhedron that is \
dual to the specified polyhedron."

PolyhedronEdges::usage =
"PolyhedronEdges[poly-list] gives the explicit edges of the given \
polyhedron specified as a list of Polygons.  PolyehdronEdges[polyhedron] \
gives a list of indices of PolyhedronVertices[polyhedron] that are the \
edges."

PolyhedronEdgeLengths::usage =
"PolyhedronEdgeLengths[vertex-list] gives a sorted list of the \
vertex-vertex distances among the specified vertices.  \
PolyhedronEdgeLengths[polyhedron] gives a sorted list of edge lengths \
using the analytic representation of polyhedron."

PolyhedronFaces::usage =
"PolyhedronFaces[polyhedron] is a list of the indices of \
PolyhedronVertices[polyhedron] that specify the faces of the given \
polyhedron.  Use in conjunction with Polyhedron[polyhedron]."

PolyhedronFaceCounts::usage =
"PolyhedronFaceCounts[polyhedron] gives a list {{f1,n1},...} where \
fi is the number of sides of face i and ni is the number of fi-gons \
faces in a given polyhedron."

PolyhedronFaceCenters::usage =
"PolyhedronFaceCenters gives a list of the centers of faces of a \
polyhedron."

PolyhedronFaceGraphics::usage =
"PolyhedronFaceGraphics[poly-list] gives an array of 2-D graphics objects \
corresponding to the faces of poly."

PolyhedronInequalities::usage =
"PolyhedronInequalities[{polygon1, polygon2, ...}, {x,y,z}] returns a list \
of inequalities in variables x, y, and z specifying the given set of \
polygons, assumed to \
bound a polyhedron.  The polygons are assumed to all be oriented \
with face normals pointing away from the polyhedron center."

PolyhedronName::usage =
"PolyhedronName[polyhedron] gives a string that is the name of the specified \
polyhedron."

PolyhedronPolyhedra::usage =
"PolyhedronPolyhedra[polyhedron] gives a list of lists of faces comprising \
the individual solids in a polyhedron compound."

PolyhedronRotationCompound::usage =
"PolyhedronRotationCompound[polyhedron,n] for a polyhedron of k faces \
(specifed as a list of k polygons) gives the compound of k polyhedra obtained \
by rotating one copy of the polyhedron by an angle Pi/n about each axes \
determined by the origin-face centroid line.  Note that depending on symmetry, \
some of the polyhedra in the compound may be conincident.  The specified \
polyhedron is _assumed_ to have centroid {0,0,0}."

PolyhedronSurfaceArea::usage =
"PolyhedronSurfaceArea[poly] gives the surface area of the polyhedron \
specified by a list of Polygons.  PolyhedronSurfaceArea[poly,{n1,n2,...}] \
gives the surface area of the polyhedron assuming that all n1-gons, \
n2-gons, etc. contribute equally.  If each polygon of a given number \
of sides contributes the same as all others having the same number of \
sides, then use PolyhedronSymmetricSurfaceArea."

PolyhedronSymmetricSurfaceArea::usage =
"PolyhedronSymmetricSurfaceArea[poly] gives the surface area of the \
polyhedron specified by a list of Polygons assuming that each polygon \
of a given number of sides contributes the same as all others having \
the same number of sides.  If this is not the case, use 
PolyhedronSurfaceArea."

PolyhedronSymmetricVolume::usage =
"PolyhedronSymmetricVolume[poly] gives the volume of the polyhedron \
specified by a list of Polygons assuming that each polygon of a given \
number of sides contributes the same as all others having the same \
number of sides.  If this is not the case, use PolyhedronVolume."

PolyhedronVertexDistances::usage =
"PolyhedronVertexDistances"

PolyhedronVertices::usage =
"PolyhedronVertices[polyhedron] is a list of the exact vertices of \
the specified polyhedron.  Use in conjunction with Faces[poly] and \
Polyhedron[poly].  \
PolyhedronVertices[polygon-list] extracts the vertices from the \
specified list of polygons.  Vertices can be equivalent but not obviously \
identical, in which case the user is responsible for simplifiying \
them and taking their union."

PolyhedronVolume::usage =
"PolyhedronVolume[poly] gives the volume of the polyhedron specified by \
a list of Polygons.  PolyhedronVolume[poly,{n1,n2,...}] gives the volume \
of the polyhedron assuming that all n1-gons, n2-gons, etc. contribute \
equally to the volume.  If each polygon of a given number of sides \
contributes the same as all others having the same number of sides, then \
use PolyhedronSymmetricVolume."

PyramidVolume::usage =
"PyramidVolume[{v1,...,vn}] gives the volume of the pyramid with apex at (0,0,0) \
and specified base."

RectifiedPair::usage =
"RectifiedPair[poly] gives poly and a rectified version of it."

Rectify::usage =
"Rectify[poly] gives the rectified polyhedron."

RotateAboutAxis::usage =
"RotateAboutAxis[v,n,ang] rotates a vector about the normal n by angle ang.  \
RotateAboutAxis[polygon,n,ang] rotates the polygon."

RotationFormula::usage =
"RotationFormula[r,n,angle] rotates a vector r about the unit \
vector n by angle."

If[$VersionNumber<6,
RotationMatrix::usage =
"RotationMatrix[angle] gives the 2-D rotation matrix for an angle \
ang in the plane."
]

RotationMatrixX::usage =
"RotationMatrixX[angle] gives the 3-D rotation matrix for an angle \
ang about the x-axis."

RotationMatrixY::usage =
"RotationMatrixY[angle] gives the 3-D rotation matrix for an angle \
ang about the y-axis."

RotationMatrixZ::usage =
"RotationMatrixZ[angle] gives the 3-D rotation matrix for an angle \
ang about the z-axis."

Snubify::usage =
"Snubify[poly,d,t] constructs the snubification of the given polyhedron \
with radial displacement d and with twist angle t."

SolidCentroid::usage =
"SolidCentroid[poly-list] returns the centroid of the list of polygons."

SphericalPolyhedron::usage =
"SphericalPolyhedron[poly,n] gives the spherical polyhedron formed by projecting \
the edges of the specified list of 3-dimensional polygons onto a unit sphere \
with n equally spaced steps along each arc.  SphericalPolyhedron[poly,n,r] \
displays the arcs as radial \"walls\" extending from a radius r to radius 1."

SpiderWeb::usage =
"SpiderWeb[Polygon[...]] gives a web of lines around the rim
of the polygon and from the centroid to vertices and edge
midpoints."

SymbolicUnion::usage =
"SymbolicUnion[l] takes a list of analytic objects and unions them \
by treating objects that are numerically equal as symbolically equal \
and discarding the duplicated.  WorkingPrecision can be specified."

TruncateByPlanes::usage =
"TruncateByPlanes[poly,r] truncates the given polyhedron by converting \
its faces to inequalities, adding the inequalities obtained by adding \
cutting planes at distances r from the center along the vertices, \
and computing the new vertices."

VertexDistances::usage =
"VertexDistances"

VertexFigures::usage =
"VertexFigures[poly] gives the vertex figures of the specified polyhedron. \
VertexFigures[poly,Convex->True] fills in the polygonal holes centered on \
the original face centroids."

VertexLabels::usage =
"VertexLabels[poly] gives numbers at the vertices of the polygon."

Volume::usage =
"Volume[graphicscomplex] computes the volume of the polynomial specified \
by the given GraphicsComple.  Volume[volume] computes the centroid of the \
specified PolyhedronData object."

WenningerModel::usage =
"WenningerModel."

Wireframe::usage =
"Wireframe[{polygon1,...}] gives a wireframe of the input.  Unlike \
Graphics`Shapes`WireFrame, the input does not already have to be a \
Graphics3D object."


(***********************************)
(* Set your favorite defaults here *)
(***********************************)

Options[HiddenWireframe]={
	ViewPoint->{1.3,-2.4,2.},
	PlotStyles->{Automatic,{GrayLevel[.5],Dashing[{.02}]}}
}

Options[Net]:={
	Lines->True,
	Colored->False,
	Colors->{3->Red,4->Yellow,5->Blue,6->Green,8->Violet,10->Orange},
	Labeled->False
};

Options[NetPrintout]:={
	PDFDirectory->"/troves/MathOzTeX/pdf/",
	PDFName->""
};

Options[VertexFigures]={
	Convex->False
};

Options[Colorize]={
	Colors->Automatic,
	Lighting->False
};

Options[SymbolicUnion]={
	WorkingPrecision->100
};


Begin["`Private`"]

(*
AdjacentFaceIndices[faceindices_List]:= Sort[Map[First /@ # &, Select[Subsets[MapIndexed[{#2[[1]], #1} &, faceindices], {2}], Length[Intersection @@ Last /@ #] == 2 &], {1}]]
*)
(* these are listed in the same order as PolyhedronEdges *)
AdjacentFaceIndices[{faceindices:__List}]:= Last /@ Sort[Select[{Intersection @@ (Last /@ #), First /@ #} & /@ Subsets[MapIndexed[{#2[[1]], #1} &, {faceindices}], {2}], Length[First[#]]>1&]]
      
AdjacentFaceIndices[poly_]:= AdjacentFaceIndices[PolyhedronData[poly, "FaceIndices"]] /; Quiet[Head[PolyhedronData[poly,"Name"]]=!=PolyhedronData]
AdjacentFaceIndices[{poly:__Polygon}]:= AdjacentFaceIndices[PolyhedronFaces[{poly}]]

Area[Polygon[l_List?MatrixQ]]:=
  Plus@@(Det/@Partition[l,2,1,1])/2/;Dimensions[l][[2]]==2

BeveledPolygon[l_List,w_,h_:0]:=Module[
	{pts,bev,bis,i,n=Length[l],edge=Partition[l,3,1,1]},
    pts=#2-(bis=Unit[Unit[#2-#1]+Unit[#2-#3]])w/Sqrt[1-(bis.Unit[#2-#1])^2]&@@@
		edge;
    bev=Table[{edge[[i,1]],edge[[i,2]],pts[[i]],pts[[Mod[i-2,n]+1]]},{i,n}];
    Polygon/@Join[bev,
		If[h<=0,{},{#3,#4,#4-h Unit[#4],#3-h Unit[#3]}&@@@bev]
	]
]

Bevel[l_List,w_,h_:0]:=l/.Polygon[x_]:>BeveledPolygon[x,w,h]

Centroid[v_List?MatrixQ]:=Total[v/Length[v]]

Centroid[Polygon[p_List?MatrixQ]]:=Centroid[p]

Centroid[g_GraphicsComplex]:=Module[{n=Normal[g]},Centroid[n, PolyhedronVolume[n]]]

Centroid[name_ /; Head[PolyhedronData[name]] =!= PolyhedronData] := Centroid[PolyhedronData[name, "Faces"], PolyhedronData[name, "Volume"]]

Centroid[faces_, vol_, simp1___:RootReduce, simp2__: Function[f, FullSimplify[ToRadicals[f]]]] :=  Module[{a, b, c, x, y, res, t}, 
  t = First[Timing[res = Together[Total[IntegrateOverPolygon[Function[{x, y, z}, {a x^2/2 + b x y + c x z, 0, 0}], #] & /@ Flatten[Normal[faces]]]]]];
  res = Collect[res/vol, {a, b, c},  simp1];
  res = D[res, #] & /@ {a, b, c};
  simp2[res]
]

Circumradius[poly_List]:=norm[poly[[1,1,1]]]

CircumsphereRadius[poly_]:=Sqrt[Max[#.#&/@PolyhedronVertices[poly]]]

ClosedLine[l_List]:=Line[Append[l,First[l]]]

(* Colorize *)

Colorize[p_List,opts___]:=Module[
	{
	color=Colors/.{opts}/.Options[Colorize],
	n=Length[p],
	gopts=FilterOptions[Graphics3D,opts,Options[Colorize]]
	},
	Sequence@@{
	If[color===Automatic,
		MapIndexed[{FaceForm[Sequence@@Table[Hue[#2[[1]]/n],{2}]],#1}&,p],
		MapIndexed[{FaceForm[Sequence@@Table[color[[Mod[#2[[1]]-1,Length[color]]+1]],{2}]],#1}&,p]
	],gopts
	}
]

(* Convexify *)

(* the triangle is always convex *)

Convexify[poly_Polygon]:=poly /; Length[poly[[1]]]==3

(* but higher n-gons are unfortunately not *)

Convexify::singular = "Normal vector is singular for vector `1`";
Convexify::fatal = "Fatal error while finding projection plain.";

Convexify[poly_Polygon,eps_:10^-6]:=Module[
	{v=poly[[1]],normal,indx,p,nv},
	nv=N[v,100];
	normal=Cross@@(#-nv[[1]]&/@{nv[[2]],nv[[-1]]});
	(* pick a nonsingular projection plane *)
	p=Flatten[Position[normal,_?(Abs[#]<eps&),{1},Heads->False]];
	If[Length[p]==3,
	  Message[Convexify::singular,normal];
	  $Failed,
	(* Else *)
		indx=Switch[Length[p],
		3,Message[Convexify::fatal],
		2,Complement[Range[3],p],
		1,{Complement[Range[3],p][[1]]},
		_,{3}];
		Polygon[v[[ConvexHull[Drop[#,indx]&/@nv]]]]
	]
]

(* CoplanarQ---from SolidGeometry.m *)

CoplanarQ[v_List?MatrixQ,eps_:10^-6]:=True /;Length[v]==3

CoplanarQ[v_List?MatrixQ,eps_:10^-6]:=
  Module[{n=Cross[v[[2]]-v[[1]],v[[3]]-v[[1]]]},
      And@@(Abs[n.(v[[1]]-#)]<eps&/@Drop[v,3])
] /; Length[v]>3
  
(* Cumulate *)

CumulateFace[Polygon[face_List],s_]:=Module[{ctr=Plus@@face/Length[face],tip},
      tip = ctr-Unit[Cross[face[[1]]-ctr,face[[-1]]-ctr]]s;
      Polygon[{tip,First[#],Last[#]}]&/@Partition[face,2,1,{1,1}]
]

CumulateFace[face_,s_]:=Module[{ctr=Plus@@face/Length[face],tip},
      tip = ctr-Unit[Cross[face[[1]]-ctr,face[[-1]]-ctr]]s;
      Polygon[{tip,First[#],Last[#]}]&/@Partition[face,2,1,{1,1}]
]

Cumulate[poly_List,scales_List]:=Module[
	{inpoly=poly/.Polygon:>Identity,n,s,i},
	{n,s}=Transpose[scales];
	Table[
		Map[CumulateFace[#,s[[i]]]&,Select[inpoly,Length[#]==n[[i]]&]],
		{i,Length[n]}
	]
]

(*
Cumulate[poly_List,scale_] :=Module[{inpoly=poly /. Polygon:>Identity},
	CumulateFace[#,scale]&/@inpoly
]
*)

Cumulate[g_,scale_]:=g/.Polygon[v_]:>CumulateFace[v,scale]

CumulateWireframe[poly_,s_]:=Module[{inpoly = Map[#[[1]]&,poly]},
	{
	Thickness[.015],Map[CumulateWires[#,s]&,inpoly],
	poly
	}
]

CumulateWires[face_,s_] :=Module[{ctr=Plus@@face/Length[face],tip},
      tip = ctr-Unit[Cross[face[[1]]-ctr,face[[-1]]-ctr]]s;
      Map[Line[{tip,#}]&,face]
]

Diameters[poly_,eps_:10^-10]:=Module[{e=KSubsets[PolyhedronVertices[poly],2],m},
	m=Max[Norm/@e];
	Select[e,(Abs[Norm[#]-m]<eps&)]
]

DihedralAngles[poly_]:=Module[
	{
		adj = AdjacentFaceIndices[Flatten[poly]],
		v = PolyhedronData[poly, "VertexCoordinates"],
		rules
	},
	rules = Thread[Range[Length[v]] -> v];
	(Pi - DihedralAngle @@ (Polygon /@ PolyhedronData[poly, "FaceIndices"][[#]] /. rules)) & /@ adj
] /; Quiet[Head[PolyhedronData[poly,"Name"]]=!=PolyhedronData]

DihedralAngles[poly_]:=Module[
	{
		adj = AdjacentFaceIndices[Flatten[poly]],
		v = PolyhedronVertices[poly],
		rules
	},
	rules = Thread[Range[Length[v]] -> v];
	(Pi - DihedralAngle @@ (Polygon /@ PolyhedronFaces[poly][[#]] /. rules)) & /@ adj
]

DualModel[n_]:=Module[{l=Select[WenningerDuals,#[[3]]==n&]},
	{#[[4]],"p. "<>ToString[#[[5]]],
		"Dual of "<>#[[2]]<>
		" ("<>udualstring[#[[2]]]<>", W"<>ToString[#[[1]]]<>")"}&/@l
]

Expansion[poly_,r_]:=
  ConvexHull3D[
    PolyhedronVertices[
      poly/.Polygon[l_]:>Polygon[#+r Unit[Centroid[Polygon[l]]]&/@l]
    ]
]

FaceIntersections[poly_]:=Module[{pairs=KSubsets[Take[#,3]&/@First/@poly,2]},
    DeleteCases[Intersection3D@@@Map[Plane,pairs,{2}],{}]
]

FromFaces[l_List]:=
	FromUnorderedPairs[Union[Flatten[Sort/@Partition[#,2,1,1]&/@l,1]]]

GeneralizedDiameter[v_List?MatrixQ] := FullSimplify[Max[Norm /@ (Subtract @@@ Subsets[v, {2}])]]
GeneralizedDiameter[p_] := GeneralizedDiameter[PolyhedronData[p, "VertexCoordinates"]] /;Quiet[ Head[PolyhedronData[p, "Name"]] =!= PolyhedronData]
GeneralizedDiameter[p_List] := GeneralizedDiameter[PolyhedronVertices[p]]

GeometricCentroid[p_ , r_: Infinity, vars_: {1, 2, 3}] := Module[{x},
	If[Head[PolyhedronData[p, "RegionFunction"]] === Missing, Return[$Failed]];
	Integrate[Array[x, 3] Evaluate[Boole[PolyhedronData[p, "RegionFunction"][Sequence @@ Array[x, 3]]]], {x[vars[[1]]], -r, r}, {x[vars[[2]]], -r,  r}, {x[vars[[3]]], -r, r}]/
		PolyhedronData[p, "Volume"]
] /; Quiet[Head[PolyhedronData[p, "Name"]] =!= PolyhedronData]

GeometricCentroid[p_, v_, r_: Infinity] := Module[{x, y, z},
  Integrate[{x, y, z} Boole[And @@ PolyhedronInequalities[p, {x, y, z}]], {x, -r,  r}, {y, -r,  r}, {z, -r, r}]/v
]

GeometricCentroid[p_] := GeometricCentroid[p, PolyhedronVolume[p]]

HiddenWireframe[poly_,opts___]:=Module[
	{front,all,back,frontstyle,backstyle,view,gopts},
	view=ViewPoint/.{opts}/.Options[HiddenWireframe];
	{frontstyle,backstyle}=PlotStyles/.{opts}/.Options[HiddenWireframe]
		/.Automatic->{};
	gopts=FilterOptions[Graphics3D,opts,Options[HiddenWireframe]];
	front=Select[
		Flatten[Show[Graphics[
		Graphics3D[{Wireframe[poly],EdgeForm[],poly},
		gopts,RenderAll->False,ViewPoint->view]],AspectRatio->Automatic,
		DisplayFunction->Identity][[1]]],
		Head[#]===Line&];
	all=Select[Flatten[Show[Graphics[
		Graphics3D[Wireframe[poly],gopts,ViewPoint->view,AspectRatio->Automatic]],
		DisplayFunction->Identity][[1]]],
		Head[#]===Line&];
	(* back lines are subset of all which are _not_ in front.
	   Sort to make sure order of vertices is the same during the
	   comparison
	*)
	back=Complement[Map[Sort,all,2],Map[Sort,front,2]];
	Graphics[{{Sequence@@frontstyle,front},{Sequence@@backstyle,back}},
		AspectRatio->Automatic][[1]]
]

HullSpiderWeb[poly_,Self]:=HullSpiderweb[poly,poly]

HullSpiderWeb[poly_,hullname_String]:=Module[
	{
		hull=ConvexHull3D[Union[Flatten[Map[#[[1]]&,poly],1]]]
	},
	{
		Graphics3D[{poly,Thickness[.01],SpiderWeb/@hull},Boxed->False],
		Graphics3D[hull,Boxed->False]
	}
]

HullSpiderWeb[poly_]:=HullSpiderweb[poly,poly]

HullSpiderWeb[poly_,hull_]:=Module[{},
	{
	Graphics3D[{#,Thickness[.01],SpiderWeb/@#}&@poly,Boxed->False],
	Graphics3D[hull,Boxed->False]
	}
]

IntegrateOverPolygon[f_Function, HoldPattern[Polygon][{b_, a_, c_}], simpFunction_: Together] := Module[
  {v1 = c - b, v2 = a - b, s, t, integrand},
  integrand = (f @@ (b + v1 t + v2 s)).Cross[v2, v1];
  If[PolynomialQ[integrand, {s, t}],
   (* integrate over s first *)
   integrand = Collect[integrand*s, s] /. {s^n_. :> 1/n (1 - t)^n};
   (* integrate over t *)
   integrand = Collect[integrand*t, t] /. {t^n_. :> 1/n};
   simpFunction[integrand],
   simpFunction[Integrate[integrand, {t, 0, 1}, {s, 0, 1 - t}]]
   ]
]

IntegrateOverPolygon[f_Function, HoldPattern[Polygon][{b_, a_, c__}], simpFunction_: Together] := Module[{v1, v2, s, t}, 
	simpFunction[Total[IntegrateOverPolygon[f, Polygon[Join[{b}, #]], simpFunction] & /@ Partition[{a, c}, 2, 1]]]
]

Inradius[poly_List]:=Distance3D[Flatten[poly][[1]]]

LineLineIntersection[{l1_,l2_},{l3_,l4_}]:=Module[{a,b},
	l1+(l2-l1)a /. Solve[l1+(l2-l1)a==l3+(l4-l3)b,{a,b}][[1]]
]

(* must sort to make sure smallest vertex of pair is first *)

ListEdges[l_List]:=Sort/@(l[[#]]&/@Partition[Range[Length[l]],2,1,1])

lline[l_List]:=Module[{i,j},
	Table[ClosedLine[Table[RotationMatrixZ[j Pi/2].l[[i]],{i,Length[l]}]],{j,0,3}]
]

Midpoint[Line[l_List?MatrixQ]]:=Point[Midpoint[l]] /; Dimensions[l][[1]]==2

Midpoint[l_List /; Length[l]==2]:=Plus@@l/2

addn[n_,k_,m_]:=Mod[n+k-1,m]+1
MidpointCumulateFace[Polygon[poly_List],h_]:=Module[
	{mid,n,v},
	n=Length[poly];
	v=Centroid[poly];
	mid=Plus@@#/2&/@Partition[poly,2,1,1];
	{
	Polygon/@Table[{poly[[i]],mid[[i]],mid[[addn[i,-1,n]]]},{i,n}],
	Polygon/@Table[{mid[[i]],mid[[addn[i,1,n]]],v+h Unit[v]},{i,n}]
	}
]

MidpointCumulate[poly_List,scales_List]:=Module[
	{n,s,i,inpoly=poly/.Polygon:>Identity},
	{n,s}=Transpose[scales];
	Table[
		Map[MidpointCumulateFace[Polygon[#],s[[i]]]&,
			Select[inpoly,Length[#]==n[[i]]&]],
		{i,Length[n]}
	]
]

MidpointCumulate[poly_List,h_]:=MidpointCumulateFace[#,h]&/@poly

Midradius[poly_List]:=Distance3D[Line[Take[Flatten[poly][[1,1]],2]]]

InertiaTensor[g_GraphicsComplex]:=Module[{n=Normal[g]},InertiaTensor[n, Volume[n]]]

InertiaTensor[name_ /; Quiet@Head[PolyhedronData[name]] =!= PolyhedronData] := InertiaTensor[PolyhedronData[name, "Faces"], PolyhedronData[name, "Volume"]]

InertiaTensor[faces_, vol_, simp1_: RootReduce, simp2_: Function[f, FullSimplify[ToRadicals[f]]]] := Module[{a, b, c, res}, 
	res = Together[Total[IntegrateOverPolygon[Function[{x, y, z}, {(a^2 x^3)/3 + a b x^2 y + b^2 x y^2 + a c x^2 z + 2 b c x y z + c^2 x z^2, 0, 0}], #] & /@
		Flatten[Normal[faces]]]];
	res = Collect[res/vol, {a, b, c}, simp1];
	res = Outer[D[res/2, #1, #2] &, {a, b, c}, {a, b, c}];
	simp2[IdentityMatrix[3] Tr[res] - res]
]

InertiaTriangle[name_, simp___]:=Module[{m=InertiaTensor[name,simp]},
	{m[[1]],Drop[m[[2]],1],Drop[m[[3]],2]}
]

(* Net *)

Net::counts="To create the solid, the following numbers of pieces of each type are \
needed: `1`.";

Net[poly__,opts___?OptionQ]:=Module[
	{
		colored=Colored/.{opts}/.Options[Net],
		lines=Lines/.{opts}/.Options[Net],
		colors=Colors/.{opts}/.Options[Net],
		labeled=Labeled/.{opts}/.Options[Net],
		v=NetVertices[poly],
		net,
		c,piece
	},
	(*
	If[Cases[DownValues[NetPieces],Verbatim[HoldPattern[NetPieces[poly]]],Infinity]!={},
		Message[Net::counts,First/@NetPieces[poly]];
		c=Last/@NetPieces[poly],
		(* Else *)
		c=Range[Length[NetFaces[poly]]]
	];
	*)
	net=Polygon[v[[#]]]&/@NetFaces[poly];
	{	
		If[colored,Transpose[{Length@@@net/.colors,net}],Sequence@@{}],
		If[lines,ClosedLine@@@net,Sequence@@{}],
		If[labeled,
			MapIndexed[Text[#2[[1]],#1,Background->White]&,v],
			Sequence@@{}
		]
	}
] 

NetConnectivity[polynet_List]:=
  Module[{NetVert = NetVertices[Flatten[polynet]]},
    Flatten[polynet] /. Line[x_List] :> Drop[x, -1] /. 
      Thread[NetVert -> Range[Length[NetVert]]]
]

NetDiagram[poly__,opts___?OptionQ]:=Module[
    {
      s=RootReduce/@NetEdgeLengths[poly],
      sides,
      lengths
      },
    sides=Sort[Union[s],Less];
    lengths=
      Sort[Transpose[{s/.Thread[sides->Range[Length[sides]]],
            NetEdges[poly]}]];
    {
      Net[poly,opts],
      Text[
            Subscript[
              StyleForm["s",FontSize->12,FontFamily->"Times",
                FontSlant->"Italic"],#1],Plus@@NetVertices[poly][[#2]]/2,
            Background->White]&@@@lengths
      }
    ]

NetEdgeLengths[poly__]:=
	SymbolicUnion[
	Sqrt[#.#]&/@Map[Subtract@@#&,NetVertices[poly][[#]]&/@NetEdges[poly],{1}]
	]

NetEdges[poly__]:=Union[Sort/@Flatten[Partition[#,2,1,1]&/@NetFaces[poly],1]]

size[poly_]:=Module[{v=Transpose[NetVertices[poly]]//N},
    Subtract@@{Max/@v,Min/@v}
]

NetFaces[l_List]:=Module[{v=NetVertices[l]},
    l/.{Line[x_List]:>Drop[x,-1], Polygon[x_List]:>x}/.Thread[v->Range[Length[v]]]
]

NetPrintout[poly_,file_,opts___]:=Module[{sz=size[poly],
	dir=PDFDirectory/.{opts}/.Options[NetPrintout],
	html=PDFName/.{opts}/.Options[NetPrintout]
	},
	If[html=="",html=StringDrop[file,-4]];
    Export[dir<>file,Graphics[
	{
		NormalizedNet[poly,opts],
		Text[StyleForm["Net for the "<>PolyhedronName[poly],
			PrivateFontOptions->{"OperatorSubstitution"->False}],
			{.15Min[sz],0},{0,1},{0,-1},
			TextStyle->{FontFamily->"Times",FontSlant->"Italic",FontSize->18}],
		Text[StyleForm["Downloaded from http://mathworld.wolfram.com/pdf/"<>html<>".pdf",
			PrivateFontOptions->{"OperatorSubstitution"->False}],
            {.1Min[sz],0},{0,1},{0,-1},
			TextStyle->{FontFamily->"Times",FontSlant->"Italic",FontSize->12}],
		Text[StyleForm["For more information, see the MathWorld entry http://mathworld.wolfram.com/"<>html<>".html",
			PrivateFontOptions->{"OperatorSubstitution"->False}],
            {.07Min[sz],0},{0,1},{0,-1},
			TextStyle->{FontFamily->"Times",FontSlant->"Italic",FontSize->12}]
	},
	AspectRatio->Automatic,
	PlotRange->All]
	]
]

NetSurfaceArea[poly__]:=Module[{v=NetVertices[poly],f=NetFaces[poly]},
	Plus@@@Abs/@Map[
		Area[Polygon[#]]&,
		Last/@NetPieces[poly]/.Thread[Range[Length[f]]->f]/.Thread[Range[Length[v]]->v],
		{2}
	].First/@NetPieces[poly]
]

NetVertices[l_List]:=
	Union[Flatten[(Flatten[l]) /. {Line[x_List]:>Drop[x,-1], Polygon[x_List]:>x},1],
	SameTest->(Abs[(#1-#2).(#1-#2)]<10^-6&)]

NonparallelVectors[v_List?MatrixQ,eps_:10^-10]:=Union[v,SameTest->(Norm[Cross[#1,#2]]<eps&)]

(* Norm *)

norm[a_List,b_List]:=norm[a-b]

norm[a_List]:=Sqrt[normsq[a]]

normsq[a_List,b_List]:=normsq[a-b]

normsq[a_List]:=a.a

NormalizedNet[poly_,opts___]:=Module[
	{
		v=Transpose[NetVertices[poly]]//N,
		dx,size,net
	},
    size=Subtract@@{Max/@v,Min/@v};
    net=If[Subtract@@size>0,
        dx={Max[v[[2]]],Min[v[[1]]]}; Net[poly,opts]/.{Line[x_]:>Line[Reverse/@x],
        	Polygon[x_]:>Polygon[Reverse/@x]},
        dx={Max[v[[1]]],Min[v[[2]]]}; Net[poly,opts]];
    net/.{Line[x_]:>Line[{#[[1]],-#[[2]]}&/@(#-dx&/@x)],
	    Polygon[x_]:>Polygon[{#[[1]],-#[[2]]}&/@(#-dx&/@x)]}
]

(* Orient *)

(* Returns a polyhedron recentered at a given internal point and all faces
pointing outward.  If the internal point is not specified, the centroid
is used.
*)

Orient[poly_,ctr_:{0,0,0}]:=poly/.Polygon[v_List]:>OrientPolygon[v,ctr]

OrientedQ[poly_,ctr_:{0,0,0}]:=poly/.Polygon[v_List]:>(Polygon[v]===OrientPolygon[v,ctr])

(* Check to see a point on the polygon offset by a small right-hand normal 
is closer or farther away to the origin.  The centroid of the polygon
can be used instead of face[[1]], but I'm not sure it really matters.
*)

OrientPolygon[face_List?MatrixQ]:=OrientPolygon[face,{0,0,0}]

OrientPolygon::degen = 
"Coincident vertices encountering in vertex list `1`."

OrientPolygon[face_List?MatrixQ,origin_List?VectorQ,eps_:0.001]:=Module[
	{
		c=Centroid[face],
		tip=Cross@@N[{face[[2]]-face[[1]],face[[-1]]-face[[1]]},100]
	},
	If[Norm[tip]==0.,
		Message[OrientPolygon::degen,face];
		face,
	(* Else *)
		tip=eps Unit[tip];

		(* Chop[N[#]] needed here to avoid approx real + exact real = 
		approx real + exact imaginary result possible in v4.2; see bug 42124
		*)
	
		Polygon[
			If[Chop[N[normsq[c+tip,origin]]] < Chop[N[normsq[c-tip,origin]]],
				Reverse[face],
			(* Else *)
				face
			]
		]
	]
]

rotmm::Singular="Singular value ArcTan[0,0] encounted: (`1`,`2`,`3`)"

rotmm[{x_, y_, z_}] := Module[{a, b,eps=.001},
	If[Sqrt[N[y^2+z^2]]<eps && Abs[N[x]]<eps,
		Message[rotmm::Singular,x,y,z],
		{a, b} = {If[Abs[N[y]]<eps && Abs[N[z]]<eps,0,ArcTan[z, y]], \
ArcTan[Sqrt[y^2 + z^2], x]};
		    {{Cos[b],0,-Sin[b]},{0,1,0},{Sin[b],0,Cos[b]}}.
    		{{1,0,0},{0,Cos[a],-Sin[a]},{0,Sin[a],Cos[a]}}
	]
]

Polygon2D::nonz="z-coordinates are not zero but should be: `1`";
Polygon2D::nonplanar="Polygon is not planar."
Polygon2D::dimension="Polygon vertices must be of the form {x,y,z}."

Polygon2D[p_List?MatrixQ,eps_:10^-16]:=Module[{v=#-p[[1]]&/@p,l},
	(* rotate last point above x-axis so y[n-1]=0 *)
	If[(l=Drop[v[[-1]],{3}])!={0,0},
		v=RotationMatrixZ[ArcTan@@l].#&/@v
	];
	
	(* rotate last point onto x-axis so y[n-1]=0, z[n-1]=0 *)
	If[(l=Drop[v[[-1]],{2}])!={0,0},
		v=RotationMatrixY[-ArcTan@@l].#&/@v
	];
	
	(* rotate 2nd point into xy-plane so z[2]=0 *)
	If[(l=Drop[v[[2]],{1}])!={0,0},
		v=RotationMatrixX[ArcTan@@l].#&/@v
	];

	(* check that all z-coordinates are actually 0 *)
	If[#.#&[Last/@v]>eps,
		Message[Polygon2D::nonz,Last/@v],
		Polygon[Drop[#,-1]&/@v]
	]
]/;Last[Dimensions[p]]==3&&CoplanarQ[p]

Polygon2D[Polygon[p_List?MatrixQ],eps_:10^-16]:=
  Message[Polygon2D::dimension]/;Last[Dimensions[p]]!=3

Polygon2D[Polygon[p_List?MatrixQ],eps_:10^-16]:=
  Message[Polygon2D::nonplanar]/;Not[CoplanarQ[p]]
  
Polygon3D[Polygon[poly2d_],z_,vec_]:=Module[
	{
	poly3d=Map[Append[#,z]&,poly2d,{2}]
	},
	Map[Transpose[rotmm[vec]].#&,poly3d,{2}]
]

PolygonArea[l_List]:=Module[
	{triangulate=Join[{1},#]&/@Partition[Range[2,Length[l]],2,1]},
    Plus@@(TriangleArea3D[l[[#]]]&/@triangulate)
]

(*

To convert an existing polyhedron, use

poly=Flatten[TriakisIcosahedronExact];
FullSimplify[v=PolyhedronVertices[poly]]//InputForm
First/@poly/.Thread[v->Range[Length[v]]]

*)

Polyhedron[p__]:=Module[{poly=VerticesToSolid[PolyhedronVertices[p],PolyhedronFaces[p]]},
	If[Cases[
			DownValues[PolyhedronPolyhedra],Verbatim[HoldPattern[PolyhedronPolyhedra[p]]],
			Infinity
		]=={},
		poly,
		poly[[#]]&/@PolyhedronPolyhedra[p]
	]
] 
(* otherwise, Prism[n] doesn't work *)
(*/;
Cases[DownValues[PolyhedronVertices],Verbatim[HoldPattern[PolyhedronVertices[p]]],Infinity]!={}&&
Cases[DownValues[PolyhedronFaces],Verbatim[HoldPattern[PolyhedronFaces[p]]],Infinity]!={}
*)

PolyhedronCompoundVolume[poly_]:=Module[
    {l=Length/@poly,l2,i,n=Length[poly]},
    l2=Length/@Table[poly[[i,1,1]],{i,n}];
    Plus@@Table[
        l[[i]]l2[[i]](PolyhedronVolume[{poly[[i,1,1,1]]}]+
              PolyhedronVolume[{poly[[i,1,2,1]]}]),{i,n}]
]

PolyhedronCompoundSurfaceArea[poly_]:=Module[
    {l=Length/@poly,l2=Length/@{poly[[1,1,1]],poly[[2,1,1]],i}},
    Plus@@Table[
        l[[i]]l2[[i]](PolyhedronSurfaceArea[{poly[[i,1,1,1]]}]+
              PolyhedronSurfaceArea[{poly[[i,1,2,1]]}]),{i,2}]
]

Options[PolyhedronDataString]={
	"AlternateNames"->{},
	"AlternateStandardNames"->{},
	"Classes"->{},
	"Information"->None,
	"Name"->"<<default>>",
	"Simplification"->(FullSimplify[RootReduce[Developer`TrigToRadicals[#]], TimeConstraint -> 60] &),
	"Skip"->{},
	"StandardName"->"DefaultName",
	TimeConstraint->3600,
	MemoryConstraint->500*^6,
	Debug->False
}

DebugPrint[x_]:=Module[{t=AbsoluteTime[]},
	Print[x,StringJoin@@Table[" ",{Max[30-StringLength[x],0]}]<>" (AbsoluteTime: ",t-t0,", Time: ",t-t1,", MaxMemoryUsed: ",MaxMemoryUsed[]/10^6.,", MemoryInUse: ",MemoryInUse[]/10^6.,")"];
	t1=t;
]

PolyhedronDataString[p0_, opts___?OptionQ]:=
	Module[
	{
		v, vol, p,
		e0, e,
		g = SkeletonGraph[p0, Pi/2],
		str, r, x, fi, f, rf, graphdata, t, mem, debug, url, simp, classes
	},
	{polyname,name,url,classes,simp,t,mem,debug}={"StandardName","Name","Information","Classes","Simplification",TimeConstraint,MemoryConstraint,Debug}/.{opts}/.Options[PolyhedronDataString];
	t0=AbsoluteTime[];
	t1=t0;
	e0 = Union[simp[PolyhedronEdgeLengths[p0]]];
	str = "RawPolyhedronData[" <> StringReplace[ToString[polyname, InputForm], " " -> ""];
	If[debug,DebugPrint["Starting main routine..."]];
	If[debug,DebugPrint["Recognizing skeleton graph..."]];
	graphdata=RecognizeGraph[g];
	e = e0/e0[[1]];
	p = p0 /. Polygon[x_]:>Polygon[x/e[[1]]];
	v = Union[Flatten[First /@ Flatten[p], 1]];
	If[debug,DebugPrint["Volume..."]];
	vol = simp[Volume[p]];
	If[debug,DebugPrint["Centroid..."]];	
	x = If[MemberQ[classes,"Concave"],$Failed,simp[TimeConstrained[Centroid[p, vol], t]]];
	If[debug,DebugPrint["Inequalities..."]];	
	rf=If[MemberQ[classes,"Concave"],$Failed,And @@ FullSimplify[PolyhedronInequalities[p, {#1, #2, #3}], TimeConstraint -> t]];
	If[debug,DebugPrint["Radii..."]];	
	r = simp[Union[Norm /@ v]];
	fi = First /@ Flatten[p] /. Thread[v -> Range[Length[v]]];
	str <> ",\"Name\"]:=" <> ToString[name, InputForm] <> "\r" <> StringReplace[
	str <> ",\"AlternateStandardNames\"]:={}\r" <>
	str <> ",\"Information\"]:=" <> If[url===None, "Missing[\"NotAvailable\"]", "Hyperlink[\"http://mathworld.wolfram.com/" <> url <> ".html\"]"]<>"\r" <>
	str <> ",\"AlternateNames\"]:={}\r" <>
	str <> ",\"PrivateNames\"]:={}\r" <>
	str <> ",\"Dual\"]:=Missing[\"NotAvailable\"]\r" <>
	str <> ",\"Compound\"]:=Missing[\"NotApplicable\"]\r" <>
	str <>  ",\"Classes\"]:=" <> 
	ToString[
      DeleteCases[
       Union[Flatten[{If[Length[e] == 1, "Equilateral"], classes}]], 
       Null], InputForm] <> "\r" <>
	str <> ",\"NetFaceIndices\"]:=Missing[\"NotAvailable\"]\r" <>
	str <> ",\"NetVertices\"]:=Missing[\"NotAvailable\"]\r" <>
	str <> ",\"NetCount\"]:=Missing[\"NotAvailable\"]\r" <>
	str <> ",\"FaceIndices\"]:=" <> ToString[fi, InputForm] <> "\r" <>
	str <> ",\"AdjacentFaceIndices\"]:=" <> ToString[AdjacentFaceIndices[p],InputForm] <> "\r" <>
	str <> ",\"EdgeLengths\"]:=" <> ToString[e, InputForm] <> "\r" <>
	str <> ",\"FaceCountRules\"]:=" <> ToString[(First[#] -> Length[#]) & /@ Split[Sort[Length /@ fi]], InputForm] <> "\r" <>
	str <> ",\"VertexCoordinates\"]:=" <>  ToString[FullSimplify[v, TimeConstraint -> 60], InputForm] <> "\r" <>
	str <> ",\"RegionFunction\"]:="<>If[rf===$Failed,"Missing[\"NotAvailable\"]","(" <> ToString[And@@rf, InputForm] <> "&)"] <> "\r" <>
	str <> ",\"Inradius\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"Incenter\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"Midradius\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"Midcenter\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
    If[Length[r] == 1, str <> ",\"Circumradius\"]:=" <> ToString[r[[1]], InputForm] <> "\r", "Missing[\"NotApplicable\"]"] <>
	str <> ",\"Circumcenter\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"Circumcenter\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"GeneralizedDiameter\"]:=" <> ToString[simp[GeneralizedDiameter[v]], InputForm] <> "\r" <>
	str <> ",\"Centroid\"]:=" <> If[rf=!=$Failed && ListQ[x], ToString[x, InputForm], "Missing[\"NotAvailable\"]"] <> "\r" <>
	str <> ",\"InertiaTensor\"]:=" <> ToString[InertiaTensor[p, vol],InputForm] <> "\r" <>
	str <> ",\"SymmetryGroupString\"]:=" <> "Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"Volume\"]:=" <> ToString[vol, InputForm] <> "\r" <>
	str <> ",\"Orientations\"]:=Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"DefaultOrientation\"]:=Missing[\"NotAvailable\"]" <> "\r" <>
	str <> ",\"SkeletonCoordinates\"]:=" <> ToString[If[graphdata==={},
		PadVertices[Vertices[g]],
		PadVertices[ToCommonEdges[CombinatoricaGraph[graphdata],g]]]] <> "\r" <> 
	str <> ",\"SkeletonGraph\"]:=" <> If[graphdata==={},"Missing[\"NotAvailable\"]",ToString[graphdata, InputForm]] <> "\r",
		{" "->"","*"->""}]
]

PolyhedronEdges[poly_List]:=
	SymbolicUnion[Flatten[Flatten[poly] /. Polygon:>ListEdges,1]]

PolyhedronEdges[poly_]:=Union[
	Sort/@Flatten[Partition[#,2,1,1]&/@PolyhedronFaces[poly],1]
]

PolyhedronEdgeLengths[poly_List]:=
	SymbolicUnion[norm@@@(PolyhedronEdges[Flatten[poly]])]

PolyhedronEdgeLengths[poly_]:=Module[{v=PolyhedronVertices[poly]},
	SymbolicUnion[Sqrt[#.#&/@Subtract@@@(v[[#]]&/@PolyhedronEdges[poly])]]
]

PolyhedronFaceCounts[poly_]:={Length[#],#[[1]]}&/@
    Split[Sort[(Flatten[poly]) /. Polygon:>Length]]

PolyhedronFaceCenters[poly_]:=
	Centroid/@(Flatten[poly]/.Polygon:>Identity)

PolyhedronFaceCenters[poly_,n_]:=
	Centroid/@(Select[Flatten[poly]/.Polygon:>Identity,Length[#]==n&])

PolyhedronFaceGraphics[poly_List]:=Module[{i,p=Flatten[poly]},
	Table[
		Graphics[p[[i]] /.Polygon:>Polygon2D,AspectRatio->Automatic],
		{i,Length[p]}
	]
]

PolyhedronFaces[l_List]:=Module[{v=PolyhedronVertices[l]},
    First/@Flatten[l]/.Thread[v->Range[Length[v]]]
]

FaceDet[Polygon[f_],x_List]:=Det[Append[#,1]&/@Prepend[Take[f,3],x]]<=0

PolyhedronInequalities[poly_List,x_List]:=poly/.p_Polygon:>FaceDet[p,x]

PolyhedronRotationCompound[poly_,n_]:=Module[
	{
	j,
	dirs=PolyhedronFaceCenters[poly]
	},
	Table[RotateAboutAxis[#,dirs[[j]],Pi/n]&/@poly,{j,Length[dirs]}]
]

PolyhedronSurfaceArea::Faces="Using {facetypes,facecounts} = `1`"

PolyhedronSurfaceArea[poly_,f_List]:=Module[
	{faces,i},
	faces=Table[Select[poly,Length[#[[1]]]==f[[i]]&]//Flatten,{i,Length[f]}] /.
		Polygon:>Identity;
	Message[PolyhedronSurfaceArea::Faces,{Length[#[[1]]],Length[#]}&/@faces];
	Plus@@(PolygonArea[#[[1]]]Length[#]&/@faces)
]

PolyhedronSurfaceArea[poly_]:=
	Plus@@(PolygonArea[# /. Polygon:>Identity]&/@(Flatten[poly]))

PolyhedronSymmetricSurfaceArea[poly0_List]:=Module[
	{poly=Flatten[poly0]},
	PolyhedronSurfaceArea[poly,Union[Length/@(poly /. Polygon:>Identity)]]
]

PolyhedronSymmetricSurfaceArea[poly_]:=
	PolyhedronSymmetricSurfaceArea[Polyhedron[poly]]

PolyhedronSymmetricVolume[poly0_List]:=Module[
	{poly=Flatten[poly0]},
	PolyhedronVolume[Flatten[poly],Union[Length/@(poly /. Polygon:>Identity)]]
]

PolyhedronSymmetricVolume[poly_]:=
	PolyhedronSymmetricVolume[Polyhedron[poly]]

PolyhedronVertexDistances[poly_]:=
	VertexDistances[PolyhedronVertices[Flatten[poly]]]

(* Make have to simplify and re-union *)

PolyhedronVertices[poly_List]:=
	Union[Flatten[(Flatten[poly]) /. Polygon:>Identity,1],SameTest->SameQ]

PolyhedronVolume[poly_List]:=
	Plus@@(PyramidVolume[#/.Polygon:>Identity]&/@Flatten[poly])

PolyhedronVolume::Faces="Using {facetypes,facecounts} = `1`"

PolyhedronVolume[poly_List,f_List]:=Module[
	{faces,i},
	faces=Table[Select[Flatten[poly],Length[#[[1]]]==f[[i]]&]//Flatten,{i,Length[f]}] /. Polygon:>Identity;
	Message[PolyhedronVolume::Faces,{Length[#[[1]]],Length[#]}&/@faces];
	Plus@@(PyramidVolume[#[[1]]]Length[#]&/@faces)
]

PyramidVolume[v_List]:=Module[{n=Unit[Cross[v[[2]]-v[[1]],v[[-1]]-v[[1]]]]},
    1/3 PolygonArea[v] Abs[v[[1]].n]
]

RectifiedPair[poly_] := 
  Module[{v = Transpose[PolyhedronVertices[poly]], m, eps = .01},
    m = {Min[#] - eps, Max[#] + eps} & /@ v;
    {Graphics3D[{poly, VertexFigures[poly]}, Boxed -> False, PlotRange -> m],
      Graphics3D[Rectify[poly], Boxed -> False, PlotRange -> m]}
]

Rectify[poly_List]:=Module[
	{
      vf = VertexFigures[poly],
      v = PolyhedronVertices[poly],
      cent = Centroid /@ (poly /. Polygon :> Identity),
      mid = Midpoint /@ PolyhedronEdges[poly],
      dist2, i, eps = .01
	},
    dist2 = normsq[Midpoint[Take[poly[[1]] /. Polygon :> Identity, 2]], 
        Centroid[poly[[1]] /. Polygon :> Identity]];
    {
	vf /. Line[l_List] :> Polygon[Drop[l, -1]],
	Convexify/@Polygon /@ 
		Table[Select[mid, N[Abs[normsq[cent[[i]], #] - dist2]] < eps &],
		{i,Length[cent]}]
	}
]

(* Rotation Stuff *)

RotationMatrixX[x_]:={{1,0,0},{0,Cos[x],Sin[x]},{0,-Sin[x],Cos[x]}}
RotationMatrixY[x_]:={{Cos[x],0,-Sin[x]},{0,1,0},{Sin[x],0,Cos[x]}}
RotationMatrixZ[x_]:={{Cos[x],Sin[x],0},{-Sin[x],Cos[x],0},{0,0,1}}

If[$VersionNumber<6,
RotationMatrix[x_]:={{Cos[x],-Sin[x]},{Sin[x],Cos[x]}}
]

RotationFormula[r_List?VectorQ,n0_List?VectorQ,ang_]:=Module[
	{n=Unit[n0]},
	r Cos[ang]+n(n.r)(1-Cos[ang])+Cross[r,n]Sin[ang]
]

RotateAboutAxis[Polygon[l_List],n_List,ang_]:=
	Polygon[RotationFormula[#,n,ang]&/@l]

RotateAboutAxis[l_List,n_List,ang_]:=l/.Polygon[x_]:>RotateAboutAxis[Polygon[x],n,ang]

RotateE[g_,n_,ang_]:=Module[{i},
	Polygon/@Table[RotateAboutAxis[g[[i]],n,ang],{i,Length[g]}]
]

Snubify[poly_,d_,rot_]:=
  ConvexHull3D[
    PolyhedronVertices[poly/.Polygon[v_]:>RotateAboutAxis[
            Polygon[d Unit[c=Centroid[v]]+#&/@v],c,rot]]]
    
SolidCentroid[poly_]:=Module[{facectrs=poly /. Polygon:>Centroid},
	Chop[Plus@@facectrs/Length[facectrs]]
]

SphericalPolyhedronArcs[p_,n_]:=Module[{i},
    Table[Unit[#[[1]]+(#[[2]]-#[[1]])i/n],{i,0,n}]&/@PolyhedronEdges[p]
]

SphericalPolyhedron[p_List,n_:10]:=Line/@SphericalPolyhedronArcs[p,n]

SphericalPolyhedron[p_List,n_,r_]:=
    Polygon[Join[#,r Reverse[#]]]&/@SphericalPolyhedronArcs[p,n]

SphericalPolyhedron[p_,n_:10]:=SphericalPolyhedron[Polyhedron[p],n]
SphericalPolyhedron[p_,n_,r_]:=SphericalPolyhedron[Polyhedron[p],n,r]

SpiderWeb[Polygon[l_List]]:=Module[{c=Centroid[l]},
	{
		ClosedLine[l],
		Line[{#,c}]&/@l,
		Line[{c,Plus@@l[[#]]/2}]&/@Partition[Range[Length[l]],2,1,1]
	}
]

SymbolicUnion[v_,opts___]:=Module[
	{
	nv,
	prec=WorkingPrecision/.{opts}/.Options[SymbolicUnion]
	},
	nv=Chop[N[v,prec]];
	First/@Split[Sort[nv]]/.Thread[nv->v]
]

(* defined in SolidGeometry.m *)
TriangleArea3D[{x1_,x2_,x3_}]:=Module[{i={1,1,1},x,y,z},
      {x,y,z}=Transpose[{x1,x2,x3}];
      Sqrt[Det[{y,z,i}]^2+Det[{z,x,i}]^2+Det[{x,y,i}]^2]/2
]

TruncateByPlanes[poly_,r_]:=
  Module[{i=PolyhedronInequalities[Polyhedron[poly],{x,y,z}],i2},
    i2=Numerator[Simplify[#.({x,y,z}-r Unit[#])]]<0&/@
        PolyhedronVertices[poly];
    PolyhedronFromInequalities[Join[i,i2],{x,y,z}]
]

Unit[v_List]:=v/Sqrt[v.v]

VertexDistances[v_]:=Module[{i,j},
	Sort[Union[
		FullSimplify[Together//@
			Flatten[
				Table[Sqrt[(v[[i]]-v[[j]]).(v[[i]]-v[[j]])],
					{i,Length[v]},{j,i+1,Length[v]}
				]
			]
		],SameTest->SameQ
	],Less]
]

VertexFigures[poly_List,opts___]:=Module[
	{
		v=PolyhedronVertices[poly],
		e=PolyhedronEdges[poly],
		i,n,l,m,
		figures,holes,
		convex=Convex/.{opts}/.Options[VertexFigures]
	},
	n=Length[v];
	l=e/.Thread[v->Range[n]];
	m=Midpoint/@e;
	figures=Table[First/@Position[l,i],{i,n}];
	Flatten[Function[f,Convexify/@Polygon/@Map[m[[#]]&,f,{2}]]/@
		If[convex,
			{figures,holes=Map[Sort,
    			Partition[#,2,1,1]&/@First/@poly/.Thread[v->Range[n]],
    			{2}]/.Thread[l->Range[Length[l]]]},
			{figures}
		]
	]
]

VertexLabels[Polygon[l_List]]:=
  MapIndexed[Text[ToString[Sequence@@#2],1.05#1]&,l]

VerticesToSolid[v_List?MatrixQ,f_List]:=Polygon[v[[#]]]&/@f

Volume[g_GraphicsComplex]:=Volume[Normal[g]]
Volume[name_ /; Quiet@Head[PolyhedronData[name]] =!= PolyhedronData] := PolyhedronData[name, "Volume"]
Volume[faces_, simp_: Function[f, FullSimplify[ToRadicals[RootReduce[f]]]]] := Module[{res}, 
	res = Together[Total[IntegrateOverPolygon[Function[{x, y, z}, {x, 0, 0}], #] & /@ Flatten[Normal[faces]]]];
	simp[res]
]

(*
Volume[name_, simp_: Function[f, FullSimplify[ToRadicals[RootReduce[f]]]]] /; Head[PolyhedronData[name]] =!= PolyhedronData := Module[{res}, 
  res = Together[
    Total[IntegrateOverPolygon[Function[{x, y, z}, {x, 0, 0}], #] & /@
       Flatten[PolyhedronData[name, "Faces"] // Normal]]];
  simp[res]]
*)

WenningerModel[n_]:=Module[{l=Select[WenningerDuals,#[[1]]==n&]},
	{#[[2]]<>" ("<>ustring[#[[2]]]<>")",
		"Wenninger dual "<>ToString[#[[3]]]<>" ("<>#[[4]]<>")"}&/@l
]

Wireframe[l_List]:=Union[frame[l]]
frame[p_]:=Switch[p,
	_Cuboid,Union[(p/.Cuboid->CuboidPolygons)/.Polygon->ClosedLine],
	_List,Union[(p/.Cuboid->CuboidPolygons)/.Polygon->ClosedLine],
	_Graphics3D,Union[(p[[1]]/.Cuboid->CuboidPolygons)/.Polygon->ClosedLine]
]

End[]

(* Protect[  ] *)

EndPackage[]