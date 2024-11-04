(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.45 *)

(*:Name: MathWorld`Platonic` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
	http://mathworld.wolfram.com/packages/Platonic.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1999-08-26): Split off from Polyhedra
  v1.01 (1999-08-27): DodecahedronIcosahedronExact, CubeOctahedronExact,
                      StellaOctangulaExact
  v1.02 (1999-09-02): Moved Cube-n-Compounds here.
                      Cube5CompoundExact, Cube5CompoundDualExact,
                      Octahedron5CompoundExact.
  v1.03 (2000-01-01): URL updated
  v1.04 (2000-02-15): IcosahedronExact2
  v1.05 (2000-02-17): Orientations fixes
  v1.06 (2000-02-23): DodecahedronSTI orientation fixed
  v1.07 (2000-02-27): GreatStellatedDodecahedronExact cumulation sign fixed,
                      GreatIcosahedronExact oriented.
  v1.08 (2000-08-19): Added continuation characters to usage messages.
                      DodecahedronExactZ, Dodecahedron2Compound,
                      Dodecahedron5Compound.
  v1.09 (2000-08-22): Dodecahedron3Compound, DodecahedronTilted
  v1.10 (2000-08-23): Octahedron3Compound
  v1.11 (2000-11-13): PolyhedronOperations` added to BeginPackage
  v1.12 (2000-12-04): Fixed incorrect FiveCubes cached name.  Deleted
                      spurious quadrilaterals from Cube5Compound.
  v1.13 (2002-08-08): StellaOctangula.  Unnumericized and correctly oriented
                      Cube2Compound.
  v1.14 (2002-08-30): Cube5Compound now returns unprocessed version by default.
  v1.15 (2002-09-19): Platonic, PlatonicName
  v1.16 (2002-10-15): OctahedronExactZ, TetrahedronExactZ
  v1.17 (2002-11-06): Convexify fixed to new syntax.
  v1.20 (2002-11-10): Converted to new Polyhedron[] syntax and removed
                      construction code.  Added nets.
  v1.21 (2002-11-22): DodecahedronZ, Dodecahedron5Compound, Octahedron3Compound,
                      Octahedron4Compound
  v1.25 (2003-01-01): Dodecahedron6Compound.  Renamed Dodecahedron5Compound.
                      Added PolyhedronPolyhedra definitions for some compounds.
                      Cube6Compound, Cube7Compound.  Platonic symmetry orientations,
                      Octahedron2Compound, Icosahedron5Compound, Icosahedron6Compound
  v1.26 (2003-01-12): Cube*Compound nets, Dodecahedron6Compound net,
                      Tetrahedron5Compound net
  v1.27 (2003-01-19): Tetrahedron6Compound
  v1.28 (2003-01-20): Cube6Compound C3
  v1.29 (2003-01-27): Cube10Compound, Octahedron10Compound
  v1.30 (2003-02-04): DodecahedronIcosahedronCompound
  v1.31 (2003-02-08): Tetrahedron4Compound
  v1.32 (2003-02-19): Corrected orientations where needed, added radii
  v1.33 (2003-06-03): Platonics
  v1.34 (2003-08-10): Tetrahedron3Compound
  v1.35 (2003-08-17): Dodecahedron C2
  v1.36 (2003-09-04): Polyhedron[Octahehedron,"C4Diamond"],
                      Polyhedron[Octahehedron,"C4Square"]
  v1.37 (2003-10-19): context udpated
  v1.38 (2003-11-09): fixed default Polyhedron[Octahedron]
  v1.39 (2003-11-15): fixed NetFaces[Octahedron3Compound], Net[Octahedron2Compound,"C4"],
                      Net[Dodecahedron2Compound]
  v1.40 (2003-11-17): Added mirror image piece to Net[Tetrahedron4Compound,"C3"]
  v1.41 (2003-12-16): Added self-intersecting versions of the Kepler-Poinsot solids
  v1.42 (2003-12-30): Added Polyhedron[Icosahedron,"C2"]
  v1.43 (2004-09-08): Platonics is now in alphabetical order
  v1.44 (2005-04-08): Typo fixes
  v1.45 (2005-07-13): KeplerPoinsotSolids
  
  (c) 1999-2007 Eric W. Weisstein
*)

(*:Keywords:
*)

(*:Requirements:

  Requires the additional package PolyhedronOperations.m available from

    http://mathworld.wolfram.com/packages/

*)

(*:Discussion:

Contains definitions for contruction of all Platonic and Kepler-Poinsot
solids (and some compounds involving them) with analytic vertices 
and convexified corretly-oriented faces.

Polygons are all oriented so that the right-hand normal points away from the
centroid.

*)

(*:References: *)

(*:Limitations:
*)

BeginPackage["MathWorld`Platonic`",{"MathWorld`PolyhedronOperations`"}]

Cube::usage =
"Polyhedron[Cube,<orientation>] gives a list of Polygons with analytic vertices \
representing a cube with unit side lengths.  The orientation may be specified \
with an optional second argument \"C3\" or \"C4\" (default) that specifies the rotational \
symmetry of the solid around the z-axis."

Cube2Compound::usage =
"Polyhedron[Cube2Compound,orientation] gives a list of Polygons with exact \
vertices representing the compound of 2 cubes, where orientation may be \"C3\" or \"C4\"."

Cube3Compound::usage =
"Polyhedron[Cube3Compound,orientation] gives a list of polygons with exact vertices \
comprising a compound of 3 cubes, where orientation may be \"C3\", \"C4\", or \"2C2\"."

Cube4Compound::usage =
"Polyhedron[Cube4Compound] gives a list of polygons comprising of a compound of \
4 cubes."

Cube5Compound::usage =
"Polyhedron[Cube5Compound] gives a list of polygons comprising a compound of \
5 cubes."

Cube6Compound::usage =
"Polyhedron[Cube6Compound,<orientation>] gives a list of polygons comprising a \
compound of 6 cubes for orientation \"C3\" or \"C4\"."

Cube7Compound::usage =
"Polyhedron[Cube7Compound] gives a list of polygons comprising a compound of \
7 cubes."

Cube10Compound::usage =
"Polyhedron[Cube10Compound] gives a list of polygons comprising a compound of \
10 cubes."

CubeOctahedronCompound::usage =
"Polyhedron[CubeOctahedronCompound] gives the compound of a cube and an octahedron \
by midpoint cumulation."

Dodecahedron::usage =
"Polyhedron[Dodecahedron,<orientation>] gives a list of Polygons with analytic vertices \
representing a dodecahedron with unit side lengths.  The orientation may be specified \
with an optional second argument \"C2\", \"C3\", or \"C5\" (default) that specifies the rotational \
symmetry of the solid around the z-axis."

Dodecahedron2Compound::usage =
"Polyhedron[Dodecahedron2Compound,orientation] gives a 2-dodecahedron compound with \
symmetry specified by orientation \"C2\", \"C3\", or \"C5\"."

Dodecahedron3Compound::usage =
"Polyhedron[Dodecahedron3Compound,n] gives the 3-dodecahedron compound."

Dodecahedron5Compound::usage =
"Polyhedron[Dodecahedron5Compound] gives the 5-dodecahedron compound."

Dodecahedron6Compound::usage =
"Polyhedron[Dodecahedron6Compound] gives the 6-dodecahedron compound."

DodecahedronIcosahedronCompound::usage =
"Polyhedron[DodecahedronIcosahedronCompound] gives a list of Polygons with \
analytic vertices representing a dodecahedron and icosahedron compound."

GreatDodecahedron::usage =
"Polyhedron[GreatDodecahedron] gives a list of mutually intersecting pentagons comprising \
the great dodecahedron.  Polyhedron[GreatDodecahedron,Split->True] gives a list of Polygons \
with analytic vertices representing the nonconvex hull of this Kepler-Poinsot solid."

GreatIcosahedron::usage =
"Polyhedron[GreatIcosahedron] gives a list of Polygons with analytic vertices \
representing this Kepler-Poinsot solid constructed from a unit icosahedron.  \
Polyhedron[GreatIcosahedron,Split->True] gives Polygons that have been split along \
face intersections and with the interior portion removed."

GreatStellatedDodecahedron::usage =
"Polyhedron[GreatStellatedDodecahedron] gives a list of Polygons representing \
this Kepler-Poinsot solid.  Polyhedron[GreatStellatedDodecahedron,Split->True] \
gives a version split at face intersections."

Icosahedron::usage =
"Polyhedron[Icosahedron,<orientation>] gives a list of Polygons with analytic vertices \
representing a icosahedron with unit side lengths.  The orientation may be specified \
with an optional second argument \"C2\", \"C3\", or \"C5\" (default) that specifies the rotational \
symmetry of the solid around the z-axis."

Icosahedron5Compound::usage =
"Polyhedron[Icosahedron5Compound] gives a list of Polygons with exact vertices representing \
a compound of 5 icosahedra."

Icosahedron6Compound::usage =
"Polyhedron[Icosahedron5Compound] gives a list of Polygons with exact vertices representing \
a compound of 6 icosahedra."

KeplerPoinsotSolids::usage =
"Platonics gives a list of the four Kepler-Poinsot solids in alphabetical order."

Octahedron::usage =
"Polyhedron[Octahedron,<orientation>] gives a list of Polygons with analytic vertices \
representing a octahedron with unit side lengths.  The orientation may be specified \
with an optional second argument \"C3\", \"C4Square\", or \"C4Diamond\" that specifies \
the rotational symmetry of the solid around the z-axis."

Octahedron2Compound::usage =
"Polyhedron[Octahedron2Compound,orientation] gives a list of Polygons with exact \
vertices representing the compound of 2 octahedra with orientation \"C3\" or \"C4\"."

Octahedron3Compound::usage =
"Polyhedron[Octahedron3Compound] gives a list of Polygons with exact vertices representing the \
compound of 3 octahedra."

Octahedron4Compound::usage =
"Polyhedron[Octahedron4Compound] gives a list of Polygons exact vertices representing the \
compound of 4 octahedra."

Octahedron5Compound::usage =
"Polyhedron[Octahedron5Compound] gives a list of Polygons with analytic \
vertices representing the compound of 5 octahedra."

Octahedron10Compound::usage =
"Polyhedron[Octahedron10Compound] gives a list of Polygons with analytic \
vertices representing the compound of 10 octahedra."

Platonic::usage =
"Platonic[n] gives an exact representation of the nth Platonic solid."

Platonics::usage =
"Platonics gives a list of the Platonic solids in alphabetical order."

SmallStellatedDodecahedron::usage =
"Polyhedron[SmallStellatedDodecahedron] gives a list of Polygons with \
analytic vertices representing this Kepler-Poinsot solid.  \
Polyhedron[SmallStellatedDodecahedron,Split->True] gives Polygons that have been \
split at face intersections."

StellaOctangula::usage =
"Polyhedron[StellaOctangula] gives a list of Polygons with analytic vertices \
representing a stella octangula constructed from tetrahedra with unit side lengths.  \
Polyhedron[StellaOctangula,Split->True] returns the polyedron split into its \
nonconvex hull."

Tetrahedron::usage =
"Polyhedron[Tetrahedron,<orientation>] gives a list of Polygons with analytic vertices \
representing a tetrahedron with unit side lengths.  The orientation may be specified \
with an optional second argument \"C2\" or \"C3\" (default) that specifies the rotational \
symmetry of the solid around the z-axis."

Tetrahedron2Compound::usage =
"Polyhedron[Tetrahedron2Compound,<chirality>] gives a list of Polygons with analytic \
vertices representing the 2-tetrahedron compound with handedness ±1.  \
If no handedness is specified, +1 (dextro) is assumed."

Tetrahedron3Compound::usage =
"Polyhedron[Tetrahedron3Compound] gives a list of Polygons with analytic \
vertices representing the 3-tetrahedron compound."

Tetrahedron4Compound::usage =
"Polyhedron[Tetrahedron4Compound,<orientation>] gives a list of Polygons with analytic vertices \
representing a compound of 4 tetrahedron with unit side lengths.  The orientation may be specified \
as \"C3\" (default)."

Tetrahedron5Compound::usage =
"Polyhedron[Tetrahedron5Compound,<chirality>] gives a list of Polygons with analytic \
vertices representing the 5-tetrahedron compound with handedness ±1.  \
If no handedness is specified, +1 (dextro) is assumed."

Tetrahedron6Compound::usage =
"Polyhedron[Tetrahedron6Compound] gives a list of Polygons with analytic \
vertices representing the 6-tetrahedron compound."

Tetrahedron10Compound::usage =
"Polyhedron[Tetrahedron10Compound] gives a list of Polygons with analytic \
vertices representing the 10-tetrahedron compound."

Begin["`Private`"]


(* Cube *)

PolyhedronName[Cube]:="cube"
PolyhedronDual[Cube]:=Octahedron
NetFaces[Cube]:={{5,4,8,9},{6,5,9,10},{2,1,4,5},{4,3,7,8},{9,8,11,12},{12,11,13,14}}
NetVertices[Cube]:=
{{-3/2,-1/2},{-3/2,1/2},{-1/2,-3/2},{-1/2,-1/2},{-1/2,1/2},{-1/2,3/2},{1/2,-3/2},{1/2,-1/2},{1/2,1/2},{1/2,3/2},
{3/2,-1/2},{3/2,1/2},{5/2,-1/2},{5/2,1/2}}
PolyhedronPolyhedra[Cube]:={Range[6]}
PolyhedronFaces[Cube]:=PolyhedronFaces[Cube,"C4"]
PolyhedronVertices[Cube]:=PolyhedronVertices[Cube,"C4"]

(* Cube C3 *)

PolyhedronDual[Cube,"C3"]:=Sequence[Octahedron,"C4"]
PolyhedronPolyhedra[Cube,"C3"]:={Range[6]}
PolyhedronFaces[Cube,"C3"]:=
{{1,4,3,5},{6,2,3,4},{7,5,3,2},{6,4,1,8},{1,5,7,8},{7,2,6,8}}
PolyhedronVertices[Cube,"C3"]:=
{{0,0,-Sqrt[3]/2},{0,0,Sqrt[3]/2},{-Sqrt[2/3],0,1/(2Sqrt[3])},
 {-(1/Sqrt[6]),-(1/Sqrt[2]),-1/(2Sqrt[3])},{-(1/Sqrt[6]),1/Sqrt[2],
  -1/(2Sqrt[3])},{1/Sqrt[6],-(1/Sqrt[2]),1/(2Sqrt[3])},
 {1/Sqrt[6],1/Sqrt[2],1/(2Sqrt[3])},{Sqrt[2/3],0,-1/(2Sqrt[3])}}
 
(* Cube C4 *)

PolyhedronDual[Cube,"C4"]:=Sequence[Octahedron,"C3"]
PolyhedronPolyhedra[Cube,"C4"]:={Range[6]}
PolyhedronFaces[Cube,"C4"]:={{8,4,2,6},{8,6,5,7},{8,7,3,4},{4,3,1,2},{1,3,7,5},{2,1,5,6}}
PolyhedronVertices[Cube,"C4"]:={{-1,-1,-1},{-1,-1,1},{-1,1,-1},{-1,1,1},
 {1,-1,-1},{1,-1,1},{1,1,-1},{1,1,1}}/2

(* Cube 2-Compound C3 *)

PolyhedronName[Cube2Compound,"C3"]:="cube 2-compound"
PolyhedronDual[Cube2Compound,"C3"]:=Octahedron2Compound
NetPieces[Cube2Compound,"C3"]:={{12,{1,2,3}}}
NetFaces[Cube2Compound,"C3"]:={{3,4,5},{3,4,1},{3,2,1}}
NetVertices[Cube2Compound,"C3"]:={{-1,0},{0,-1},{0,0},{0,2},{1,0}}/2
PolyhedronPolyhedra[Cube2Compound,"C3"]:={{1,2,3,4,5,6},{7,8,9,10,11,12}}
PolyhedronFaces[Cube2Compound,"C3"]:=
{{2,11,12,4},{8,3,11,2},{4,9,8,2},{3,8,9,1},{1,9,4,12},{1,12,11,3},{2,5,14,
    13},{10,7,5,2},{13,6,10,2},{7,10,6,1},{1,6,13,14},{1,14,5,7}}
PolyhedronVertices[Cube2Compound,"C3"]:=
{{0,0,-Sqrt[3]},{0,0,Sqrt[3]},
 {0,-2Sqrt[2/3],-(1/Sqrt[3])},{0,2Sqrt[2/3],1/Sqrt[3]},{0,-2Sqrt[2/3],1/Sqrt[3]},
 {0,2Sqrt[2/3],-(1/Sqrt[3])},{-Sqrt[2],-Sqrt[2/3],
  -(1/Sqrt[3])},{-Sqrt[2],-Sqrt[2/3],1/Sqrt[3]},
 {-Sqrt[2],Sqrt[2/3],-(1/Sqrt[3])},
 {-Sqrt[2],Sqrt[2/3],1/Sqrt[3]},{Sqrt[2],-Sqrt[2/3],
  1/Sqrt[3]},{Sqrt[2],Sqrt[2/3],-(1/Sqrt[3])},
 {Sqrt[2],Sqrt[2/3],1/Sqrt[3]},{Sqrt[2],-Sqrt[2/3],-(1/Sqrt[3])}}/2

(* Cube 2-Compound C4 *)

PolyhedronDual[Cube2Compound,"C4"]:=Octahedron2Compound
PolyhedronPolyhedra[Cube2Compound,"C4"]:={{1,2,3,4,5,6},{7,8,9,10,11,12}}
PolyhedronFaces[Cube2Compound,"C4"]:=
{{12,4,2,10},{12,10,9,11},{12,11,3,4},{4,3,1,2},{1,3,11,9},{2,1,9,10},{16,8,
    14,6},{16,6,5,15},{16,15,7,8},{8,7,13,14},{13,7,15,5},{14,13,5,6}}
PolyhedronVertices[Cube2Compound,"C4"]:=
{{-1/2,-1/2,-1/2},{-1/2,-1/2,1/2},{-1/2,1/2,-1/2},
 {-1/2,1/2,1/2},{0,-(1/Sqrt[2]),-1/2},
 {0,-(1/Sqrt[2]),1/2},{0,1/Sqrt[2],-1/2},
 {0,1/Sqrt[2],1/2},{1/2,-1/2,-1/2},{1/2,-1/2,1/2},
 {1/2,1/2,-1/2},{1/2,1/2,1/2},
 {-(1/Sqrt[2]),0,-1/2},{-(1/Sqrt[2]),0,1/2},
 {1/Sqrt[2],0,-1/2},{1/Sqrt[2],0,1/2}}

(* Cube 3-Compound 2C2 *)

PolyhedronName[Cube3Compound,"2C2"]:="cube 3-compound"
NetPieces[Cube3Compound,"2C2"]:={{24,{1,2,3}},{24,{4,5}}}
NetFaces[Cube3Compound,"2C2"]:={{6,1,9},{1,5,10,9},{1,4,7,6},{8,3,11},{2,8,11}}
NetVertices[Cube3Compound,"2C2"]:=
{{0,(-1+Sqrt[2])/2},{1,(-1+Sqrt[2])/4},{1,(-1+2Sqrt[2])/4},
 {-1/(2Sqrt[2]),(-2+3Sqrt[2])/4},{1/(2Sqrt[2]),(-2+3Sqrt[2])/4},
 {(1-Sqrt[2])/2,0},{1-Sqrt[2],(-1+Sqrt[2])/2},{(3-Sqrt[2])/2,1/4},
 {(-1+Sqrt[2])/2,0},{-1+Sqrt[2],(-1+Sqrt[2])/2},{(1+Sqrt[2])/2,1/4}}
PolyhedronPolyhedra[Cube3Compound,"2C2"]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18}}
PolyhedronFaces[Cube3Compound,"2C2"]:=
{{16,4,2,14},{16,14,15,13},{16,13,1,4},{4,1,3,2},{3,1,13,15},{2,3,15,14},{8,
    20,17,6},{8,6,21,24},{8,24,7,20},{20,7,5,17},{5,7,24,21},{17,5,21,6},{23,
    12,19,10},{23,10,9,22},{23,22,11,12},{12,11,18,19},{18,11,22,9},{19,18,9,
    10}}
PolyhedronVertices[Cube3Compound,"2C2"]:=
{{-1/2,0,-(1/Sqrt[2])},{-1/2,0,1/Sqrt[2]},{-1/2,-(1/Sqrt[2]),0},
 {-1/2,1/Sqrt[2],0},{0,-1/2,-(1/Sqrt[2])},{0,-1/2,1/Sqrt[2]},
 {0,1/2,-(1/Sqrt[2])},{0,1/2,1/Sqrt[2]},{0,-(1/Sqrt[2]),-1/2},
 {0,-(1/Sqrt[2]),1/2},{0,1/Sqrt[2],-1/2},{0,1/Sqrt[2],1/2},
 {1/2,0,-(1/Sqrt[2])},{1/2,0,1/Sqrt[2]},{1/2,-(1/Sqrt[2]),0},
 {1/2,1/Sqrt[2],0},{-(1/Sqrt[2]),-1/2,0},{-(1/Sqrt[2]),0,-1/2},
 {-(1/Sqrt[2]),0,1/2},{-(1/Sqrt[2]),1/2,0},{1/Sqrt[2],-1/2,0},
 {1/Sqrt[2],0,-1/2},{1/Sqrt[2],0,1/2},{1/Sqrt[2],1/2,0}}

(* Cube 3-Compound C3 *)

PolyhedronName[Cube3Compound,"C3"]:="cube 3-compound"
PolyhedronPolyhedra[Cube3Compound,"C3"]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18}}
PolyhedronFaces[Cube3Compound,"C3"]:=
{{1,5,3,6},{7,2,3,5},{8,6,3,2},{7,5,1,4},{1,6,8,4},{8,2,7,4},{1,9,12,16},{13,
    2,12,9},{20,16,12,2},{13,9,1,17},{1,16,20,17},{20,2,13,17},{1,10,14,
    18},{11,2,14,10},{19,18,14,2},{11,10,1,15},{1,18,19,15},{19,2,11,15}}
PolyhedronVertices[Cube3Compound,"C3"]:=
{{0,0,-Sqrt[3]/2},{0,0,Sqrt[3]/2},{-Sqrt[2/3],0,1/(2Sqrt[3])},
 {Sqrt[2/3],0,-1/(2Sqrt[3])},{-(1/Sqrt[6]),-(1/Sqrt[2]),-1/(2Sqrt[3])},
 {-(1/Sqrt[6]),1/Sqrt[2],-1/(2Sqrt[3])},{1/Sqrt[6],-(1/Sqrt[2]),1/(2Sqrt[3])},
 {1/Sqrt[6],1/Sqrt[2],1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,1,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,3,0],-1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,1,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   4,0],-1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,2,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,2,0],1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,2,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   5,0],1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,3,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,1,0],1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,3,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   6,0],1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,4,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,1,0],-1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,4,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   6,0],-1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,5,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,2,0],-1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,5,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   5,0],-1/(2Sqrt[3])},{Root[-1+54#1^2-216#1^4+216#1^6&,6,0],
  Root[-1+18#1^2-72#1^4+72#1^6&,3,0],1/(2Sqrt[3])},
 {Root[-1+54#1^2-216#1^4+216#1^6&,6,0],Root[-1+18#1^2-72#1^4+72#1^6&,
   4,0],1/(2Sqrt[3])}}

(* Cube 3-Compound C4 *)

PolyhedronName[Cube3Compound,"C4"]:="cube 3-compound"
PolyhedronPolyhedra[Cube3Compound,"C4"]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18}}
PolyhedronFaces[Cube3Compound,"C4"]:=
{{8,4,2,6},{8,6,5,7},{8,7,3,4},{4,3,1,2},{1,3,7,5},{2,1,5,6},{22,20,12,
    14},{22,14,13,21},{22,21,19,20},{20,19,11,12},{11,19,21,13},{12,11,13,
    14},{18,24,16,10},{18,10,9,17},{18,17,23,24},{24,23,15,16},{15,23,17,
    9},{16,15,9,10}}
PolyhedronVertices[Cube3Compound,"C4"]:=
{{-1/2,-1/2,-1/2},{-1/2,-1/2,1/2},{-1/2,1/2,-1/2},{-1/2,1/2,1/2},{1/2,-1/2,-1/2},
 {1/2,-1/2,1/2},{1/2,1/2,-1/2},{1/2,1/2,1/2},{(-1-Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},
 {(-1-Sqrt[3])/4,(1-Sqrt[3])/4,1/2},{(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,-1/2},
 {(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,1/2},{(1-Sqrt[3])/4,(-1-Sqrt[3])/4,-1/2},
 {(1-Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},{(1-Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},
 {(1-Sqrt[3])/4,(1+Sqrt[3])/4,1/2},{(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,-1/2},
 {(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},{(-1+Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},
 {(-1+Sqrt[3])/4,(1+Sqrt[3])/4,1/2},{(1+Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},
 {(1+Sqrt[3])/4,(1-Sqrt[3])/4,1/2},{(1+Sqrt[3])/4,(-1+Sqrt[3])/4,-1/2},
 {(1+Sqrt[3])/4,(-1+Sqrt[3])/4,1/2}}

(* Cube 4-Compound *)

PolyhedronName[Cube4Compound]:="cube 4-compound"
NetPieces[Cube4Compound]:={{8,{1,2,3}},{24,{4,5,6}}}
NetFaces[Cube4Compound]:=
{{1,11,14,10},{16,13,14,12},{15,13,14,11},{4,9,8,6,7,5},{5,2,4},{4,3,9}}
NetVertices[Cube4Compound]:=
{{0,0},{19/20,0},{6/5,-1/4},{6/5,0},{6/5,1/2},{47/35,1/7},
 {76/55,5/11},{91/55,2/11},{17/10,0},{9/(77Sqrt[2]),-3/(7Sqrt[2])},
 {9/(77Sqrt[2]),3/(7Sqrt[2])},{75/(77Sqrt[2]),-3/(7Sqrt[2])},
 {75/(77Sqrt[2]),3/(7Sqrt[2])},{(3Sqrt[2])/11,0},
 {(3Sqrt[2])/11,(3Sqrt[2])/11},{(6Sqrt[2])/11,0}}
PolyhedronPolyhedra[Cube4Compound]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18},{19,20,21,22,23,24}}
PolyhedronFaces[Cube4Compound]:=
{{28,15,4,12},{28,12,18,29},{28,29,21,15},{15,21,5,4},{5,21,29,18},{4,5,18,
    12},{26,31,24,14},{26,14,2,9},{26,9,19,31},{31,19,7,24},{7,19,9,2},{24,7,
    2,14},{8,1,10,20},{8,20,32,23},{8,23,13,1},{1,13,25,10},{25,13,23,32},{10,
    25,32,20},{6,17,30,22},{6,22,16,3},{6,3,11,17},{17,11,27,30},{27,11,3,
    16},{30,27,16,22}}
PolyhedronVertices[Cube4Compound]:=
{{-5,-1,-1},{-5,-1,1},{-5,1,-1},{-5,1,1},{-3,-3,-3},{-3,-3,3},{-3,3,-3},{-3,3,
    3},{-1,-5,-1},{-1,-5,1},{-1,-1,-5},{-1,-1,5},{-1,1,-5},{-1,1,5},{-1,
    5,-1},{-1,5,1},{1,-5,-1},{1,-5,1},{1,-1,-5},{1,-1,5},{1,1,-5},{1,1,5},{1,
    5,-1},{1,5,1},{3,-3,-3},{3,-3,3},{3,3,-3},{3,3,3},{5,-1,-1},{5,-1,1},{5,
    1,-1},{5,1,1}}/6

(* Cube 5-Compound *)

PolyhedronName[Cube5Compound]:="cube 5-compound"
PolyhedronDual[Cube5Compound]:=Octahedron5Compound
NetPieces[Cube5Compound]:={{60,{1,2}},{60,{3,4}},{60,{5,6}}}
NetFaces[Cube5Compound]:={{1,3,12},{1,2,12},{6,5,9},{6,4,9},{7,11,8},{7,10,8}}
NetVertices[Cube5Compound]:=
{{0,0},{(-1+Sqrt[5])/4,(2-Sqrt[5])/2},{(-1+Sqrt[5])/4,(3-Sqrt[5])/4},
 {(-1+Sqrt[5])/2,(2-Sqrt[5])/2},{(-1+Sqrt[5])/2,(3-Sqrt[5])/4},
 {(3(-1+Sqrt[5]))/4,0},{(7(-1+Sqrt[5]))/8,0},{(-23+15Sqrt[5])/8,0},
 {(-9+5Sqrt[5])/4,0},{(-15+11Sqrt[5])/8,(-7+3Sqrt[5])/4},
 {(-15+11Sqrt[5])/8,(3-Sqrt[5])/4},{(3-Sqrt[5])/2,0}}
PolyhedronPolyhedra[Cube5Compound]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18},{19,20,21,22,23,24},{25,
    26,27,28,29,30}}
PolyhedronFaces[Cube5Compound]:=
{{1,9,18,14},{12,2,19,15},{1,15,19,9},{18,2,12,14},{1,14,12,15},{19,2,18,
    9},{13,17,10,1},{16,20,2,11},{10,20,16,1},{13,11,2,17},{16,11,13,1},{10,
    17,2,20},{3,5,10,14},{8,4,19,11},{3,11,19,5},{10,4,8,14},{3,14,8,11},{19,
    4,10,5},{13,9,6,3},{12,20,4,7},{6,20,12,3},{13,7,4,9},{12,7,13,3},{6,9,4,
    20},{5,6,16,15},{7,8,18,17},{5,17,18,6},{16,8,7,15},{5,15,7,17},{18,8,16,
    6}}
PolyhedronVertices[Cube5Compound]:=(*PolyhedronVertices[Dodecahedron,"C5"]*)
{{-Sqrt[1/2+1/(2Sqrt[5])],0,-Sqrt[1/4-1/(2Sqrt[5])]},
 {Sqrt[1/2+1/(2Sqrt[5])],0,Sqrt[1/4-1/(2Sqrt[5])]},
 {-Sqrt[1/2-1/(2Sqrt[5])],0,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/2-1/(2Sqrt[5])],0,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[1/4-1/(2Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[1/4-1/(2Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,-Sqrt[1/4-1/(2Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,-Sqrt[1/4-1/(2Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(1-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(-1+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(1-Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-1+Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[1/4-1/(2Sqrt[5])]},
 {-Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[1/4-1/(2Sqrt[5])]},
 {-Sqrt[1/4-1/(2Sqrt[5])],-1/2,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/4-1/(2Sqrt[5])],1/2,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/4-1/(2Sqrt[5])],-1/2,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/4-1/(2Sqrt[5])],1/2,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/4-1/(2Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/4-1/(2Sqrt[5])]}}

(* Cube 6-Compound C3 *)

PolyhedronName[Cube6Compound,"C3"]:="cube 6-compound"
PolyhedronDual[Cube6Compound,"C3"]:=Octahedron6Compound
NetPieces[Cube6Compound,"C3"]:={{12,{1,2,3,4}},{24,{5,6,7}},{24,{8,9}},{24,{10,11}}}
NetFaces[Cube6Compound,"C3"]:=
{{1,3,20,4,22,6,29,8,32,12,10},{1,2,21,5,23,7,30,9,33,11,10},{26,18,1,3},{25,
    35,10,11},{13,28,34,27},{27,34,38,24},{27,13,31,37},{14,36,40},{14,39,
    40},{15,19,17},{15,16,17}}
NetVertices[Cube6Compound,"C3"]:=
{{0,0},{0,(4-3Sqrt[2])/2},{0,(-4+3Sqrt[2])/2},{1/4,(2-Sqrt[2])/4},{1/4,(-2+Sqrt[2])/4},
 {1/2,(5-3Sqrt[2])/7},{1/2,(-5+3Sqrt[2])/7},{3/4,(2-Sqrt[2])/4},{3/4,(-2+Sqrt[2])/4},{1,0},
 {1,(4-3Sqrt[2])/2},{1,(-4+3Sqrt[2])/2},{3/2,1/8},{9/4,0},{13/4,0},
 {(103-10Sqrt[2])/28,(1-2Sqrt[2])/14},{(3(33-4Sqrt[2]))/28,0},{(4-3Sqrt[2])/2,0},
 {(28-3Sqrt[2])/8,(2-Sqrt[2])/8},{(3-2Sqrt[2])/2,3-2Sqrt[2]},{(3-2Sqrt[2])/2,-3+2Sqrt[2]},
 {(3-Sqrt[2])/7,(8-5Sqrt[2])/14},{(3-Sqrt[2])/7,(-8+5Sqrt[2])/14},
 {(3(4-Sqrt[2]))/4,(-11+6Sqrt[2])/8},{(6-Sqrt[2])/4,(-2+Sqrt[2])/4},{(-2+Sqrt[2])/4,(2-Sqrt[2])/4},
 {(2+Sqrt[2])/2,(5-4Sqrt[2])/8},{(2+Sqrt[2])/2,(5-2Sqrt[2])/8},{(4+Sqrt[2])/7,(8-5Sqrt[2])/14},
 {(4+Sqrt[2])/7,(-8+5Sqrt[2])/14},{(10+Sqrt[2])/8,(3(1-Sqrt[2]))/8},{(-1+2Sqrt[2])/2,3-2Sqrt[2]},
 {(-1+2Sqrt[2])/2,-3+2Sqrt[2]},{(1+2Sqrt[2])/2,1/8},{(-2+3Sqrt[2])/2,0},
 {(16+3Sqrt[2])/8,(2-Sqrt[2])/8},{(-4+7Sqrt[2])/4,(-11+6Sqrt[2])/8},
 {(6+7Sqrt[2])/8,(3(1-Sqrt[2]))/8},{(51+10Sqrt[2])/28,(1-2Sqrt[2])/14},{(55+12Sqrt[2])/28,0}}

(*
NetPieces[Cube6Compound,"C3"]:={{12,{1,2,3,4}},{24,{7,8,9}},{48,{5,6}}}
NetFaces[Cube6Compound,"C3"]:=
{{1,3,16,4,18,6,25,8,28,12,10},{1,2,17,5,19,7,26,9,29,11,10},{22,15,1,3},{21,
    31,10,11},{14,32,36},{14,35,36},{13,24,30,23},{23,30,34,20},{23,13,27,33}}
NetVertices[Cube6Compound,"C3"]:=
{{0,0},{0,(4-3Sqrt[2])/2},{0,(-4+3Sqrt[2])/2},{1/4,(2-Sqrt[2])/4},{1/4,(-2+Sqrt[2])/4},
 {1/2,(5-3Sqrt[2])/7},{1/2,(-5+3Sqrt[2])/7},{3/4,(2-Sqrt[2])/4},{3/4,(-2+Sqrt[2])/4},{1,0},
 {1,(4-3Sqrt[2])/2},{1,(-4+3Sqrt[2])/2},{3/2,1/8},{9/4,0},{(4-3Sqrt[2])/2,0},
 {(3-2Sqrt[2])/2,3-2Sqrt[2]},{(3-2Sqrt[2])/2,-3+2Sqrt[2]},{(3-Sqrt[2])/7,(8-5Sqrt[2])/14},
 {(3-Sqrt[2])/7,(-8+5Sqrt[2])/14},{(3(4-Sqrt[2]))/4,(-11+6Sqrt[2])/8},{(6-Sqrt[2])/4,(-2+Sqrt[2])/4},
 {(-2+Sqrt[2])/4,(2-Sqrt[2])/4},{(2+Sqrt[2])/2,(5-4Sqrt[2])/8},{(2+Sqrt[2])/2,(5-2Sqrt[2])/8},
 {(4+Sqrt[2])/7,(8-5Sqrt[2])/14},{(4+Sqrt[2])/7,(-8+5Sqrt[2])/14},{(10+Sqrt[2])/8,(3(1-Sqrt[2]))/8},
 {(-1+2Sqrt[2])/2,3-2Sqrt[2]},{(-1+2Sqrt[2])/2,-3+2Sqrt[2]},{(1+2Sqrt[2])/2,1/8},
 {(-2+3Sqrt[2])/2,0},{(16+3Sqrt[2])/8,(2-Sqrt[2])/8},{(-4+7Sqrt[2])/4,(-11+6Sqrt[2])/8},
 {(6+7Sqrt[2])/8,(3(1-Sqrt[2]))/8},{(51+10Sqrt[2])/28,(1-2Sqrt[2])/14},{(55+12Sqrt[2])/28,0}}
*)

PolyhedronPolyhedra[Cube6Compound,"C3"]:=Partition[Range[6 6],6]
PolyhedronFaces[Cube6Compound,"C3"]:=
{{40,17,36,18},{40,18,24,47},{40,47,23,17},{17,23,43,36},{43,23,47,24},{36,43,
    24,18},{48,25,44,26},{48,26,16,39},{48,39,15,25},{25,15,35,44},{35,15,39,
    16},{44,35,16,26},{37,13,33,19},{37,19,28,46},{37,46,22,13},{13,22,42,
    33},{42,22,46,28},{33,42,28,19},{45,21,41,27},{45,27,20,38},{45,38,14,
    21},{21,14,34,41},{34,14,38,20},{41,34,20,27},{7,31,5,11},{7,11,10,4},{7,
    4,30,31},{31,30,2,5},{2,30,4,10},{5,2,10,11},{6,32,8,12},{6,12,9,1},{6,1,
    29,32},{32,29,3,8},{3,29,1,9},{8,3,9,12}}
PolyhedronVertices[Cube6Compound,"C3"]:=
{{0,(-2-Sqrt[2])/4,(2-Sqrt[2])/4},{0,(-2-Sqrt[2])/4,(-2+Sqrt[2])/4},
 {0,(2-Sqrt[2])/4,(-2-Sqrt[2])/4},{0,(2-Sqrt[2])/4,(2+Sqrt[2])/4},
 {0,(-2+Sqrt[2])/4,(-2-Sqrt[2])/4},{0,(-2+Sqrt[2])/4,(2+Sqrt[2])/4},
 {0,(2+Sqrt[2])/4,(2-Sqrt[2])/4},{0,(2+Sqrt[2])/4,(-2+Sqrt[2])/4},
 {-(1/Sqrt[2]),-1/(2Sqrt[2]),-1/(2Sqrt[2])},{-(1/Sqrt[2]),-1/(2Sqrt[2]),1/(2Sqrt[2])},
 {-(1/Sqrt[2]),1/(2Sqrt[2]),-1/(2Sqrt[2])},{-(1/Sqrt[2]),1/(2Sqrt[2]),1/(2Sqrt[2])},
 {-1/(2Sqrt[2]),-(1/Sqrt[2]),-1/(2Sqrt[2])},{-1/(2Sqrt[2]),-(1/Sqrt[2]),1/(2Sqrt[2])},
 {-1/(2Sqrt[2]),-1/(2Sqrt[2]),-(1/Sqrt[2])},{-1/(2Sqrt[2]),-1/(2Sqrt[2]),1/Sqrt[2]},
 {-1/(2Sqrt[2]),1/(2Sqrt[2]),-(1/Sqrt[2])},{-1/(2Sqrt[2]),1/(2Sqrt[2]),1/Sqrt[2]},
 {-1/(2Sqrt[2]),1/Sqrt[2],-1/(2Sqrt[2])},{-1/(2Sqrt[2]),1/Sqrt[2],1/(2Sqrt[2])},
 {1/(2Sqrt[2]),-(1/Sqrt[2]),-1/(2Sqrt[2])},{1/(2Sqrt[2]),-(1/Sqrt[2]),1/(2Sqrt[2])},
 {1/(2Sqrt[2]),-1/(2Sqrt[2]),-(1/Sqrt[2])},{1/(2Sqrt[2]),-1/(2Sqrt[2]),1/Sqrt[2]},
 {1/(2Sqrt[2]),1/(2Sqrt[2]),-(1/Sqrt[2])},{1/(2Sqrt[2]),1/(2Sqrt[2]),1/Sqrt[2]},
 {1/(2Sqrt[2]),1/Sqrt[2],-1/(2Sqrt[2])},{1/(2Sqrt[2]),1/Sqrt[2],1/(2Sqrt[2])},
 {1/Sqrt[2],-1/(2Sqrt[2]),-1/(2Sqrt[2])},{1/Sqrt[2],-1/(2Sqrt[2]),1/(2Sqrt[2])},
 {1/Sqrt[2],1/(2Sqrt[2]),-1/(2Sqrt[2])},{1/Sqrt[2],1/(2Sqrt[2]),1/(2Sqrt[2])},
 {(-2-Sqrt[2])/4,0,(2-Sqrt[2])/4},{(-2-Sqrt[2])/4,0,(-2+Sqrt[2])/4},
 {(-2-Sqrt[2])/4,(2-Sqrt[2])/4,0},{(-2-Sqrt[2])/4,(-2+Sqrt[2])/4,0},
 {(2-Sqrt[2])/4,0,(-2-Sqrt[2])/4},{(2-Sqrt[2])/4,0,(2+Sqrt[2])/4},
 {(2-Sqrt[2])/4,(-2-Sqrt[2])/4,0},{(2-Sqrt[2])/4,(2+Sqrt[2])/4,0},
 {(-2+Sqrt[2])/4,0,(-2-Sqrt[2])/4},{(-2+Sqrt[2])/4,0,(2+Sqrt[2])/4},
 {(-2+Sqrt[2])/4,(-2-Sqrt[2])/4,0},{(-2+Sqrt[2])/4,(2+Sqrt[2])/4,0},
 {(2+Sqrt[2])/4,0,(2-Sqrt[2])/4},{(2+Sqrt[2])/4,0,(-2+Sqrt[2])/4},
 {(2+Sqrt[2])/4,(2-Sqrt[2])/4,0},{(2+Sqrt[2])/4,(-2+Sqrt[2])/4,0}}

(* Cube 6-Compound C4 *)

PolyhedronName[Cube6Compound,"C4"]:="cube 6-compound"
PolyhedronDual[Cube6Compound,"C4"]:=Octahedron6Compound
PolyhedronPolyhedra[Cube6Compound,"C4"]:=Partition[Range[6 6],6]
PolyhedronFaces[Cube6Compound,"C4"]:=
{{24,30,46,40},{29,45,46,30},{39,40,46,45},{23,24,40,39},{23,39,45,29},{23,29,
    30,24},{6,14,15,7},{10,11,15,14},{3,7,15,11},{2,6,7,3},{2,3,11,10},{2,10,
    14,6},{17,26,28,19},{26,42,44,28},{19,28,44,35},{17,19,35,33},{33,35,44,
    42},{17,33,42,26},{1,9,12,4},{9,13,16,12},{4,12,16,8},{1,4,8,5},{5,8,16,
    13},{1,5,13,9},{22,38,48,32},{31,32,48,47},{21,22,32,31},{21,37,38,
    22},{21,31,47,37},{37,47,48,38},{34,41,43,36},{25,27,43,41},{20,36,43,
    27},{18,34,36,20},{18,20,27,25},{18,25,41,34}}
PolyhedronVertices[Cube6Compound,"C4"]:=
{{-1/2,(-1-Sqrt[3])/4,(1-Sqrt[3])/4},
 {-1/2,(-1-Sqrt[3])/4,(-1+Sqrt[3])/4},
 {-1/2,(1-Sqrt[3])/4,(-1-Sqrt[3])/4},
 {-1/2,(1-Sqrt[3])/4,(1+Sqrt[3])/4},
 {-1/2,(-1+Sqrt[3])/4,(-1-Sqrt[3])/4},
 {-1/2,(-1+Sqrt[3])/4,(1+Sqrt[3])/4},
 {-1/2,(1+Sqrt[3])/4,(1-Sqrt[3])/4},
 {-1/2,(1+Sqrt[3])/4,(-1+Sqrt[3])/4},
 {1/2,(-1-Sqrt[3])/4,(1-Sqrt[3])/4},
 {1/2,(-1-Sqrt[3])/4,(-1+Sqrt[3])/4},
 {1/2,(1-Sqrt[3])/4,(-1-Sqrt[3])/4},
 {1/2,(1-Sqrt[3])/4,(1+Sqrt[3])/4},
 {1/2,(-1+Sqrt[3])/4,(-1-Sqrt[3])/4},
 {1/2,(-1+Sqrt[3])/4,(1+Sqrt[3])/4},
 {1/2,(1+Sqrt[3])/4,(1-Sqrt[3])/4},
 {1/2,(1+Sqrt[3])/4,(-1+Sqrt[3])/4},
 {(-1-Sqrt[3])/4,-1/2,(1-Sqrt[3])/4},
 {(-1-Sqrt[3])/4,-1/2,(-1+Sqrt[3])/4},
 {(-1-Sqrt[3])/4,1/2,(1-Sqrt[3])/4},
 {(-1-Sqrt[3])/4,1/2,(-1+Sqrt[3])/4},
 {(-1-Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},
 {(-1-Sqrt[3])/4,(1-Sqrt[3])/4,1/2},
 {(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,-1/2},
 {(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,1/2},
 {(1-Sqrt[3])/4,-1/2,(-1-Sqrt[3])/4},
 {(1-Sqrt[3])/4,-1/2,(1+Sqrt[3])/4},
 {(1-Sqrt[3])/4,1/2,(-1-Sqrt[3])/4},
 {(1-Sqrt[3])/4,1/2,(1+Sqrt[3])/4},
 {(1-Sqrt[3])/4,(-1-Sqrt[3])/4,-1/2},
 {(1-Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},
 {(1-Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},
 {(1-Sqrt[3])/4,(1+Sqrt[3])/4,1/2},
 {(-1+Sqrt[3])/4,-1/2,(-1-Sqrt[3])/4},
 {(-1+Sqrt[3])/4,-1/2,(1+Sqrt[3])/4},
 {(-1+Sqrt[3])/4,1/2,(-1-Sqrt[3])/4},
 {(-1+Sqrt[3])/4,1/2,(1+Sqrt[3])/4},
 {(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,-1/2},
 {(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},
 {(-1+Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},
 {(-1+Sqrt[3])/4,(1+Sqrt[3])/4,1/2},
 {(1+Sqrt[3])/4,-1/2,(1-Sqrt[3])/4},
 {(1+Sqrt[3])/4,-1/2,(-1+Sqrt[3])/4},
 {(1+Sqrt[3])/4,1/2,(1-Sqrt[3])/4},
 {(1+Sqrt[3])/4,1/2,(-1+Sqrt[3])/4},
 {(1+Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},
 {(1+Sqrt[3])/4,(1-Sqrt[3])/4,1/2},
 {(1+Sqrt[3])/4,(-1+Sqrt[3])/4,-1/2},
 {(1+Sqrt[3])/4,(-1+Sqrt[3])/4,1/2}}

(* Cube 7-Compound *)

PolyhedronName[Cube7Compound]:="cube 7-compound"
PolyhedronDual[Cube7Compound]:=Octahedron7Compound
PolyhedronPolyhedra[Cube7Compound]:=
{{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18},{19,20,21,22,23,24},{25,
    26,27,28,29,30},{31,32,33,34,35,36},{37,38,39,40,41,42}}
PolyhedronFaces[Cube7Compound]:=
{{32,38,54,48},{37,53,54,38},{47,48,54,53},{31,32,48,47},{31,47,53,37},{31,37,
    38,32},{10,22,23,11},{18,19,23,22},{7,11,23,19},{6,10,11,7},{6,7,19,
    18},{6,18,22,10},{25,34,36,27},{34,50,52,36},{27,36,52,43},{25,27,43,
    41},{41,43,52,50},{25,41,50,34},{5,17,20,8},{17,21,24,20},{8,20,24,12},{5,
    8,12,9},{9,12,24,21},{5,9,21,17},{30,46,56,40},{39,40,56,55},{29,30,40,
    39},{29,45,46,30},{29,39,55,45},{45,55,56,46},{42,49,51,44},{33,35,51,
    49},{28,44,51,35},{26,42,44,28},{26,28,35,33},{26,33,49,42},{16,4,2,
    14},{16,14,13,15},{16,15,3,4},{4,3,1,2},{1,3,15,13},{2,1,13,14}}
PolyhedronVertices[Cube7Compound]:=
{{-1/2,-1/2,-1/2},{-1/2,-1/2,1/2},{-1/2,1/2,-1/2},{-1/2,1/2,1/2},
 {-1/2,(-1-Sqrt[3])/4,(1-Sqrt[3])/4},{-1/2,(-1-Sqrt[3])/4,
  (-1+Sqrt[3])/4},{-1/2,(1-Sqrt[3])/4,(-1-Sqrt[3])/4},
 {-1/2,(1-Sqrt[3])/4,(1+Sqrt[3])/4},{-1/2,(-1+Sqrt[3])/4,
  (-1-Sqrt[3])/4},{-1/2,(-1+Sqrt[3])/4,(1+Sqrt[3])/4},
 {-1/2,(1+Sqrt[3])/4,(1-Sqrt[3])/4},{-1/2,(1+Sqrt[3])/4,
  (-1+Sqrt[3])/4},{1/2,-1/2,-1/2},{1/2,-1/2,1/2},{1/2,1/2,-1/2},
 {1/2,1/2,1/2},{1/2,(-1-Sqrt[3])/4,(1-Sqrt[3])/4},
 {1/2,(-1-Sqrt[3])/4,(-1+Sqrt[3])/4},{1/2,(1-Sqrt[3])/4,
  (-1-Sqrt[3])/4},{1/2,(1-Sqrt[3])/4,(1+Sqrt[3])/4},
 {1/2,(-1+Sqrt[3])/4,(-1-Sqrt[3])/4},{1/2,(-1+Sqrt[3])/4,
  (1+Sqrt[3])/4},{1/2,(1+Sqrt[3])/4,(1-Sqrt[3])/4},
 {1/2,(1+Sqrt[3])/4,(-1+Sqrt[3])/4},{(-1-Sqrt[3])/4,-1/2,
  (1-Sqrt[3])/4},{(-1-Sqrt[3])/4,-1/2,(-1+Sqrt[3])/4},
 {(-1-Sqrt[3])/4,1/2,(1-Sqrt[3])/4},{(-1-Sqrt[3])/4,1/2,
  (-1+Sqrt[3])/4},{(-1-Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},
 {(-1-Sqrt[3])/4,(1-Sqrt[3])/4,1/2},{(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,
  -1/2},{(-1-Sqrt[3])/4,(-1+Sqrt[3])/4,1/2},
 {(1-Sqrt[3])/4,-1/2,(-1-Sqrt[3])/4},{(1-Sqrt[3])/4,-1/2,
  (1+Sqrt[3])/4},{(1-Sqrt[3])/4,1/2,(-1-Sqrt[3])/4},
 {(1-Sqrt[3])/4,1/2,(1+Sqrt[3])/4},{(1-Sqrt[3])/4,(-1-Sqrt[3])/4,
  -1/2},{(1-Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},
 {(1-Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},{(1-Sqrt[3])/4,(1+Sqrt[3])/4,1/2},
 {(-1+Sqrt[3])/4,-1/2,(-1-Sqrt[3])/4},{(-1+Sqrt[3])/4,-1/2,
  (1+Sqrt[3])/4},{(-1+Sqrt[3])/4,1/2,(-1-Sqrt[3])/4},
 {(-1+Sqrt[3])/4,1/2,(1+Sqrt[3])/4},{(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,
  -1/2},{(-1+Sqrt[3])/4,(-1-Sqrt[3])/4,1/2},
 {(-1+Sqrt[3])/4,(1+Sqrt[3])/4,-1/2},{(-1+Sqrt[3])/4,(1+Sqrt[3])/4,
  1/2},{(1+Sqrt[3])/4,-1/2,(1-Sqrt[3])/4},
 {(1+Sqrt[3])/4,-1/2,(-1+Sqrt[3])/4},{(1+Sqrt[3])/4,1/2,
  (1-Sqrt[3])/4},{(1+Sqrt[3])/4,1/2,(-1+Sqrt[3])/4},
 {(1+Sqrt[3])/4,(1-Sqrt[3])/4,-1/2},{(1+Sqrt[3])/4,(1-Sqrt[3])/4,1/2},
 {(1+Sqrt[3])/4,(-1+Sqrt[3])/4,-1/2},{(1+Sqrt[3])/4,(-1+Sqrt[3])/4,
  1/2}}

(* Cube 10-Compound *)

PolyhedronName[Cube10Compound]:="cube 10-compound"
PolyhedronDual[Cube10Compound]:="octahedron 10-compound"
NetPieces[Cube10Compound]:={{20,{1,2,3}},{60,{4,5,6}},{60,{7,8}},{60,{9,10}}}
NetFaces[Cube10Compound]:=
{{1,20,27,32,18,22,19,31,28,3},{1,3,29,36,14,24,16,34,26,21},{
  1,21,25,33,17,23,15,35,30,2},{4,5,43,12,39,48},{4,6,42,11,40,48},{4,13,
    41,5},{7,10,45,47},{47,38,7},{46,37,8},{8,9,44,46}}
NetVertices[Cube10Compound]:=
{{0,0},{0,Root[-9+24#1+32#1^2-64#1^3+16#1^4&,2,0]},
 {0,Root[-9-24#1+32#1^2+64#1^3+16#1^4&,3,0]},{5/8,0},
 {5/8,(1-Sqrt[7-2Sqrt[10]])/2},{5/8,(-1+Sqrt[7-2Sqrt[10]])/2},{5/4,0},{7/4,0},
 {(3(1+Sqrt[2]))/4,Root[-1-16#1+14#1^2+24#1^3+4#1^4&,3,0]},
 {(1+3Sqrt[2])/4,Root[-1+16#1+14#1^2-24#1^3+4#1^4&,2,0]},
 {(5+2Sqrt[7-3Sqrt[5]])/8,Root[1+8#1-40#1^2-64#1^3+64#1^4&,2,0]},
 {(5+2Sqrt[7-3Sqrt[5]])/8,Root[1-8#1-40#1^2+64#1^3+64#1^4&,3,0]},
 {(1+4Sqrt[7-2Sqrt[10]])/8,0},{Root[81+576#1-310#1^2-352#1^3+4#1^4&,2,0],
  Root[9-12#1-218#1^2-152#1^3+4#1^4&,2,0]},
 {Root[81+576#1-310#1^2-352#1^3+4#1^4&,2,0],
  Root[9+12#1-218#1^2+152#1^3+4#1^4&,3,0]},
 {Root[9-12#1-218#1^2-152#1^3+4#1^4&,2,0],
  Root[81+576#1-310#1^2-352#1^3+4#1^4&,2,0]},
 {Root[9-12#1-218#1^2-152#1^3+4#1^4&,2,0],
  Root[81-576#1-310#1^2+352#1^3+4#1^4&,3,0]},
 {Root[9+12#1-218#1^2+152#1^3+4#1^4&,3,0],
  Root[81+576#1-310#1^2-352#1^3+4#1^4&,2,0]},
 {Root[81-576#1-310#1^2+352#1^3+4#1^4&,3,0],
  Root[9-12#1-218#1^2-152#1^3+4#1^4&,2,0]},
 {Root[-9+24#1+32#1^2-64#1^3+16#1^4&,2,0],0},
 {Root[-9-24#1+32#1^2+64#1^3+16#1^4&,3,0],0},
 {Root[-9+84#1-88#1^2-24#1^3+36#1^4&,2,0],
  Root[-9-84#1-88#1^2+24#1^3+36#1^4&,3,0]},
 {Root[-9-84#1-88#1^2+24#1^3+36#1^4&,3,0],
  Root[-9+84#1-88#1^2-24#1^3+36#1^4&,2,0]},
 {Root[-9-84#1-88#1^2+24#1^3+36#1^4&,3,0],
  Root[-9-84#1-88#1^2+24#1^3+36#1^4&,3,0]},
 {Root[-9-60#1-110#1^2+100#1^4&,3,0],Root[9-240#1+530#1^2-400#1^3+100#1^4&,1,
   0]},{Root[-9-60#1-110#1^2+100#1^4&,3,0],
  Root[9+240#1+530#1^2+400#1^3+100#1^4&,4,0]},
 {Root[-9+60#1-110#1^2+100#1^4&,2,0],Root[9+240#1+530#1^2+400#1^3+100#1^4&,4,
   0]},{Root[9-240#1+530#1^2-400#1^3+100#1^4&,1,0],
  Root[-9-60#1-110#1^2+100#1^4&,3,0]},
 {Root[9+240#1+530#1^2+400#1^3+100#1^4&,4,0],Root[-9-60#1-110#1^2+100#1^4&,3,
   0]},{Root[9+240#1+530#1^2+400#1^3+100#1^4&,4,0],
  Root[-9+60#1-110#1^2+100#1^4&,2,0]},
 {Root[1-36#1+190#1^2-288#1^3+124#1^4&,1,0],
  Root[9-12#1-98#1^2+128#1^3+124#1^4&,2,0]},
 {Root[9+12#1-98#1^2-128#1^3+124#1^4&,3,0],
  Root[1+36#1+190#1^2+288#1^3+124#1^4&,4,0]},
 {Root[9-12#1-98#1^2+128#1^3+124#1^4&,2,0],
  Root[1-36#1+190#1^2-288#1^3+124#1^4&,1,0]},
 {Root[9-12#1-98#1^2+128#1^3+124#1^4&,2,0],
  Root[1+36#1+190#1^2+288#1^3+124#1^4&,4,0]},
 {Root[1+36#1+190#1^2+288#1^3+124#1^4&,4,0],
  Root[9+12#1-98#1^2-128#1^3+124#1^4&,3,0]},
 {Root[1+36#1+190#1^2+288#1^3+124#1^4&,4,0],
  Root[9-12#1-98#1^2+128#1^3+124#1^4&,2,0]},
 {Root[-2759-11776#1+13856#1^2-4096#1^3+256#1^4&,2,0],
  Root[121-1716#1+1630#1^2-408#1^3+4#1^4&,1,0]},
 {Root[-5679-864#1+8096#1^2-3584#1^3+256#1^4&,2,0],
  Root[121+1716#1+1630#1^2+408#1^3+4#1^4&,4,0]},
 {Root[-340831-167968#1+936320#1^2-362496#1^3+4096#1^4&,2,0],
  Root[-9+60#1+104#1^2-200#1^3+4#1^4&,2,0]},
 {Root[-340831-167968#1+936320#1^2-362496#1^3+4096#1^4&,2,0],
  Root[-9-60#1+104#1^2+200#1^3+4#1^4&,3,0]},
 {Root[81-6048#1+32128#1^2-43008#1^3+4096#1^4&,3,0],
  Root[-1+12#1-38#1^2+32#1^3+4#1^4&,2,0]},
 {Root[4729-23776#1+37760#1^2-22528#1^3+4096#1^4&,2,0],
  Root[9+48#1-40#1^2-64#1^3+16#1^4&,2,0]},
 {Root[4729-23776#1+37760#1^2-22528#1^3+4096#1^4&,2,0],
  Root[9-48#1-40#1^2+64#1^3+16#1^4&,3,0]},
 {Root[-57591+12960#1+59040#1^2-38400#1^3+6400#1^4&,3,0],
  Root[-1-100#1-190#1^2+100#1^4&,3,0]},
 {Root[-40751+46400#1+11040#1^2-25600#1^3+6400#1^4&,3,0],
  Root[-1+100#1-190#1^2+100#1^4&,2,0]},
 {Root[-90641+74080#1+40544#1^2-43520#1^3+7936#1^4&,3,0],0},
 {Root[-48409+85952#1-12832#1^2-27648#1^3+7936#1^4&,3,0],0},
 {Root[-99511+239584#1-111232#1^2-67584#1^3+36864#1^4&,3,0],0}}

PolyhedronPolyhedra[Cube10Compound]:=Partition[Range[6 10],6]
PolyhedronFaces[Cube10Compound]:=
{{16,35,52,42},{16,42,38,53},{16,53,47,35},{35,47,1,52},{1,47,53,38},{52,1,38,
    42},{30,79,64,69},{30,69,62,77},{30,77,60,79},{79,60,27,64},{27,60,77,
    62},{64,27,62,69},{32,68,74,58},{32,58,73,67},{32,67,71,68},{68,71,25,
    74},{25,71,67,73},{74,25,73,58},{31,57,76,66},{31,66,72,65},{31,65,75,
    57},{57,75,26,76},{26,75,65,72},{76,26,72,66},{15,54,37,41},{15,41,51,
    36},{15,36,48,54},{54,48,2,37},{2,48,36,51},{37,2,51,41},{29,80,59,
    78},{29,78,61,70},{29,70,63,80},{80,63,28,59},{28,63,70,61},{59,28,61,
    78},{7,21,12,17},{7,17,20,9},{7,9,24,21},{21,24,6,12},{6,24,9,20},{12,6,
    20,17},{3,40,55,45},{3,45,33,50},{3,50,44,40},{40,44,14,55},{14,44,50,
    33},{55,14,33,45},{8,10,19,18},{8,18,11,22},{8,22,23,10},{10,23,5,19},{5,
    23,22,11},{19,5,11,18},{4,39,43,49},{4,49,34,46},{4,46,56,39},{39,56,13,
    43},{13,56,46,34},{43,13,34,49}}
PolyhedronVertices[Cube10Compound]:=
{{-1/2,-1/2,-1/2},{-1/2,-1/2,1/2},{-1/2,1/2,-1/2},{-1/2,1/2,1/2},
 {0,(-1-Sqrt[5])/4,(1-Sqrt[5])/4},{0,(-1-Sqrt[5])/4,(-1+Sqrt[5])/4},
 {0,(1+Sqrt[5])/4,(1-Sqrt[5])/4},{0,(1+Sqrt[5])/4,(-1+Sqrt[5])/4},
 {0,Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0],
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0]},
 {0,Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0],
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0]},
 {0,Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0],
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0]},
 {0,Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0],
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0]},{1/2,-1/2,-1/2},
 {1/2,-1/2,1/2},{1/2,1/2,-1/2},{1/2,1/2,1/2},
 {-(1/Sqrt[2]),Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0]},
 {-(1/Sqrt[2]),Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0]},
 {-(1/Sqrt[2]),Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0]},
 {-(1/Sqrt[2]),Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0]},
 {1/Sqrt[2],Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0]},
 {1/Sqrt[2],Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0]},
 {1/Sqrt[2],Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0]},
 {1/Sqrt[2],Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0]},
 {(-1-Sqrt[5])/4,(1-Sqrt[5])/4,0},{(-1-Sqrt[5])/4,(-1+Sqrt[5])/4,0},
 {(1-Sqrt[5])/4,0,(-1-Sqrt[5])/4},{(1-Sqrt[5])/4,0,(1+Sqrt[5])/4},
 {(-1+Sqrt[5])/4,0,(-1-Sqrt[5])/4},{(-1+Sqrt[5])/4,0,(1+Sqrt[5])/4},
 {(1+Sqrt[5])/4,(1-Sqrt[5])/4,0},{(1+Sqrt[5])/4,(-1+Sqrt[5])/4,0},
 {(1-Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6},
 {(1-Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6},
 {(1-Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6},
 {(1-Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6},
 {(-1+Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6},
 {(-1+Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6},
 {(-1+Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6},
 {(-1+Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6},
 {(1-Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6},
 {(1-Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6},
 {(1-Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6},
 {(1-Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6},
 {(-1+Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6},
 {(-1+Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6},
 {(-1+Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6,(-1-Sqrt[7+3Sqrt[5]])/6},
 {(-1+Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6,(1+Sqrt[7+3Sqrt[5]])/6},
 {(-1-Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6},
 {(-1-Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6},
 {(-1-Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6},
 {(-1-Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6},
 {(1+Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6},
 {(1+Sqrt[7+3Sqrt[5]])/6,(1-Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6},
 {(1+Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6,(1-Sqrt[10])/6},
 {(1+Sqrt[7+3Sqrt[5]])/6,(-1+Sqrt[7-3Sqrt[5]])/6,(-1+Sqrt[10])/6},
 {Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0],
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0],0},
 {Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0],
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0],0},
 {Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0],0,
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0]},
 {Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0],0,
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],-(1/Sqrt[2]),
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],-(1/Sqrt[2]),
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],1/Sqrt[2],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],1/Sqrt[2],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],-(1/Sqrt[2])},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],1/Sqrt[2]},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],-(1/Sqrt[2])},
 {Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],1/Sqrt[2]},
 {Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0],0,
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,3,0]},
 {Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0],0,
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0]},
 {Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0],
  Root[1+44#1-100#1^2-48#1^3+144#1^4&,4,0],0},
 {Root[1-44#1-100#1^2+48#1^3+144#1^4&,2,0],
  Root[1-44#1-100#1^2+48#1^3+144#1^4&,1,0],0},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],-(1/Sqrt[2])},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,1,0],1/Sqrt[2]},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],-(1/Sqrt[2])},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],1/Sqrt[2]},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],-(1/Sqrt[2]),
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0]},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],-(1/Sqrt[2]),
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0]},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],1/Sqrt[2],
  Root[-1+12#1-28#1^2-48#1^3+144#1^4&,2,0]},
 {Root[-1-12#1-28#1^2+48#1^3+144#1^4&,4,0],1/Sqrt[2],
  Root[-1-12#1-28#1^2+48#1^3+144#1^4&,3,0]}}

(* Cube-Octahedron Compound *)

PolyhedronName[CubeOctahedronCompound]:="cube-octahedron compound"
NetFaces[CubeOctahedronCompound]:=
{{1,4,5},{1,5,2},{1,2,7},{1,7,6},{3,11,10},{3,10,8},{3,8,9}}
NetVertices[CubeOctahedronCompound]:=
{{0,0},{0,1/Sqrt[2]},{3/2,0},
 {-Sqrt[3/2]/2,-1/(2Sqrt[2])},{-Sqrt[3/2]/2,1/(2Sqrt[2])},
 {Sqrt[3/2]/2,-1/(2Sqrt[2])},{Sqrt[3/2]/2,1/(2Sqrt[2])},
 {(6-Sqrt[2])/4,-1/(2Sqrt[2])},{(6-Sqrt[2])/4,
  1/(2Sqrt[2])},{(6+Sqrt[2])/4,-1/(2Sqrt[2])},
 {(6+Sqrt[2])/4,1/(2Sqrt[2])}}
PolyhedronPolyhedra[CubeOctahedronCompound]:={Range[6],Range[7,14]}
PolyhedronFaces[CubeOctahedronCompound]:=
{{13,5,3,11},{13,11,10,12},{13,12,4,5},{5,4,2,3},{2,4,12,10},{3,2,10,11},{1,7,
    6},{8,1,6},{7,1,9},{8,9,1},{6,7,14},{6,14,8},{7,9,14},{8,14,9}}
PolyhedronVertices[CubeOctahedronCompound]:=
{{-1,0,0},{-1/2,-1/2,-1/2},{-1/2,-1/2,1/2},
 {-1/2,1/2,-1/2},{-1/2,1/2,1/2},{0,-1,0},{0,0,-1},
 {0,0,1},{0,1,0},{1/2,-1/2,-1/2},{1/2,-1/2,1/2},
 {1/2,1/2,-1/2},{1/2,1/2,1/2},{1,0,0}}
PolyhedronFaces[CubeOctahedronCompound,Split->True]:=
{{25,16,22},{9,6,16},{4,12,6},{20,22,12},{16,6,14},{6,12,14},{12,22,14},{22,
    16,14},{25,22,24},{20,19,22},{18,21,19},{23,24,21},{22,19,26},{19,21,
    26},{21,24,26},{24,22,26},{25,24,16},{23,15,24},{7,8,15},{9,16,8},{24,15,
    17},{15,8,17},{8,16,17},{16,24,17},{9,8,6},{7,5,8},{2,3,5},{4,6,3},{8,5,
    1},{5,3,1},{3,6,1},{6,8,1},{2,5,11},{7,15,5},{23,21,15},{18,11,21},{5,15,
    13},{15,21,13},{21,11,13},{11,5,13},{4,3,12},{2,11,3},{18,19,11},{20,12,
    19},{3,11,10},{11,19,10},{19,12,10},{12,3,10}}
PolyhedronVertices[CubeOctahedronCompound,Split->True]:=
{{-2,0,0},{-1,-1,-1},{-1,-1,0},{-1,-1,1},{-1,0,-1},{-1,0,1},{-1,1,-1},{-1,1,
    0},{-1,1,1},{0,-2,0},{0,-1,-1},{0,-1,1},{0,0,-2},{0,0,2},{0,1,-1},{0,1,
    1},{0,2,0},{1,-1,-1},{1,-1,0},{1,-1,1},{1,0,-1},{1,0,1},{1,1,-1},{1,1,
    0},{1,1,1},{2,0,0}}/2

(* Cube-Octahedron 5-Compound *)

(* Dodecahedron *)

PolyhedronName[Dodecahedron]:="dodecahedron"
PolyhedronDual[Dodecahedron]:=Icosahedron
NetFaces[Dodecahedron]:={{11,17,24,25,18},{38,33,25,24,32},{26,19,18,25,31},{5,4,11,18,12},{2,10,17,11,3},{23,30,24,17,16},{16,9,15,22,23},{1,6,14,15,7},{13,20,21,14,8},{34,35,28,21,27},{37,29,22,28,36},{28,22,15,14,21}}
NetVertices[Dodecahedron]:={{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/80,(-3(3+Sqrt[5]))/4},{(-10Sqrt[2(5-Sqrt[5])]-25Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/80,(-3-Sqrt[5])/4},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/80,(1-Sqrt[5])/4},{(5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]-5Sqrt[2(5+Sqrt[5])]-13Sqrt[10(5+Sqrt[5])])/80,(-1+Sqrt[5])/4},{(10Sqrt[2(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]-13Sqrt[10(5+Sqrt[5])])/80,(3+Sqrt[5])/4},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]-25Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-5-2Sqrt[5])/2},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]-25Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-4-Sqrt[5])/2},{(-35Sqrt[2(5-Sqrt[5])]-15Sqrt[10(5-Sqrt[5])]+20Sqrt[2(5+Sqrt[5])]+2Sqrt[10(5+Sqrt[5])])/80,-3-Sqrt[5]},{(-35Sqrt[2(5-Sqrt[5])]-15Sqrt[10(5-Sqrt[5])]+20Sqrt[2(5+Sqrt[5])]+2Sqrt[10(5+Sqrt[5])])/80,(-3-Sqrt[5])/2},{(-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/80,(-1-Sqrt[5])/2},{-Sqrt[(5+Sqrt[5])/10],0},{(15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]-5Sqrt[2(5+Sqrt[5])]-13Sqrt[10(5+Sqrt[5])])/80,(1+Sqrt[5])/2},{(-20Sqrt[2(5-Sqrt[5])]-10Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-13-5Sqrt[5])/4},{(-25Sqrt[2(5-Sqrt[5])]-15Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-11-3Sqrt[5])/4},{(-25Sqrt[2(5-Sqrt[5])]-15Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-7-3Sqrt[5])/4},{(-20Sqrt[2(5-Sqrt[5])]-10Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-5-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(-1-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(1+Sqrt[5])/4},{(-10Sqrt[2(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(5+Sqrt[5])/4},{(-5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+20Sqrt[2(5+Sqrt[5])]+2Sqrt[10(5+Sqrt[5])])/80,(-7-2Sqrt[5])/2},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-5-2Sqrt[5])/2},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-4-Sqrt[5])/2},{(-5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+20Sqrt[2(5+Sqrt[5])]+2Sqrt[10(5+Sqrt[5])])/80,(-2-Sqrt[5])/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),-1/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),1/2},{(5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+2Sqrt[10(5+Sqrt[5])])/80,(2+Sqrt[5])/2},{(-15Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+11Sqrt[10(5+Sqrt[5])])/40,(-11-5Sqrt[5])/4},{(5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-3(3+Sqrt[5]))/4},{(-5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+10Sqrt[2(5+Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/40,(-7-Sqrt[5])/4},{(10Sqrt[2(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(-3-Sqrt[5])/4},{(20Sqrt[2(5-Sqrt[5])]+10Sqrt[10(5-Sqrt[5])]-15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(3+Sqrt[5])/4},{(Sqrt[(5+Sqrt[5])/2](15+Sqrt[5]))/20,(-1-Sqrt[5])/4},{(Sqrt[(5+Sqrt[5])/2](15+Sqrt[5]))/20,(1+Sqrt[5])/4},{(-25Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+20Sqrt[2(5+Sqrt[5])]+22Sqrt[10(5+Sqrt[5])])/80,-3-Sqrt[5]},{(-10Sqrt[2(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+11Sqrt[10(5+Sqrt[5])])/40,-2-Sqrt[5]},{(Sqrt[(5+Sqrt[5])/2](5+3Sqrt[5]))/10,(-5-Sqrt[5])/2},{(-5Sqrt[2(5-Sqrt[5])]-5Sqrt[10(5-Sqrt[5])]+30Sqrt[2(5+Sqrt[5])]+12Sqrt[10(5+Sqrt[5])])/80,(-3-Sqrt[5])/2},{(Sqrt[(5+Sqrt[5])/2](5+3Sqrt[5]))/10,0}}
PolyhedronPolyhedra[Dodecahedron]:={Range[12]}
PolyhedronFaces[Dodecahedron]:=PolyhedronFaces[Dodecahedron,"C3"]
PolyhedronVertices[Dodecahedron]:=PolyhedronVertices[Dodecahedron,"C3"]

(* Dodecahedron C2 *)

PolyhedronName[Dodecahedron,"C2"]:="dodecahedron oriented with z-axis along a C2 axis of \
symmetry"
PolyhedronDual[Dodecahedron,"C2"]:=Sequence[Icosahedron,"C2"]
PolyhedronPolyhedra[Dodecahedron,"C2"]:={Range[12]}
PolyhedronFaces[Dodecahedron,"C2"]:=
{{14,10,9,12,2},{7,17,20,19,15},{15,19,16,4,3},{19,20,18,8,16},{20,17,5,6,
    18},{17,7,1,13,5},{7,15,3,11,1},{6,5,13,10,14},{13,1,11,9,10},{11,3,4,12,
    9},{4,16,8,2,12},{8,18,6,14,2}}
PolyhedronVertices[Dodecahedron,"C2"]:=
{{-1/2,0,(-3-Sqrt[5])/4},{-1/2,0,(3+Sqrt[5])/4},{0,(-3-Sqrt[5])/4,-1/2},
 {0,(-3-Sqrt[5])/4,1/2},{0,(3+Sqrt[5])/4,-1/2},{0,(3+Sqrt[5])/4,1/2},{1/2,0,(-3-Sqrt[5])/4},
 {1/2,0,(3+Sqrt[5])/4},{(-3-Sqrt[5])/4,-1/2,0},{(-3-Sqrt[5])/4,1/2,0},
 {(-1-Sqrt[5])/4,(-1-Sqrt[5])/4,(-1-Sqrt[5])/4},{(-1-Sqrt[5])/4,(-1-Sqrt[5])/4,(1+Sqrt[5])/4},
 {(-1-Sqrt[5])/4,(1+Sqrt[5])/4,(-1-Sqrt[5])/4},{(-1-Sqrt[5])/4,(1+Sqrt[5])/4,(1+Sqrt[5])/4},
 {(1+Sqrt[5])/4,(-1-Sqrt[5])/4,(-1-Sqrt[5])/4},{(1+Sqrt[5])/4,(-1-Sqrt[5])/4,(1+Sqrt[5])/4},
 {(1+Sqrt[5])/4,(1+Sqrt[5])/4,(-1-Sqrt[5])/4},{(1+Sqrt[5])/4,(1+Sqrt[5])/4,(1+Sqrt[5])/4},
 {(3+Sqrt[5])/4,-1/2,0},{(3+Sqrt[5])/4,1/2,0}}

(* Dodecahedron C3 *)

PolyhedronName[Dodecahedron,"C3"]:="dodecahedron oriented with z-axis along a C3 axis of \
symmetry"
PolyhedronDual[Dodecahedron,"C3"]:=Sequence[Icosahedron,"C3"]
PolyhedronPolyhedra[Dodecahedron,"C3"]:={Range[12]}
PolyhedronFaces[Dodecahedron,"C3"]:={{15,10,9,14,1},{2,6,12,11,5},{5,11,7,3,19},{11,12,8,16,7},{12,6,20,4,8},{6,2,
    13,18,20},{2,5,19,17,13},{4,20,18,10,15},{18,13,17,9,10},{17,19,3,14,
    9},{3,7,16,1,14},{16,8,4,15,1}}
PolyhedronVertices[Dodecahedron,"C3"]:=
{{0,0,Sqrt[9/8+(3Sqrt[5])/8]},{0,0,-Sqrt[(3(3+Sqrt[5]))/2]/2},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,
  Sqrt[1/8+Sqrt[5]/24]},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[(3+Sqrt[5])/6]/2},{Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(3+Sqrt[5])/6],0,-Sqrt[(5(3+Sqrt[5]))/6]/2},{-Sqrt[(3+Sqrt[5])/6]/2,(-1-Sqrt[5])/4,
  Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[(3+Sqrt[5])/6]/2,(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[(3+Sqrt[5])/6],0,Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[(5(3+Sqrt[5]))/6]/2,(-1-Sqrt[5])/4,
  -Sqrt[(3+Sqrt[5])/6]/2},{-Sqrt[(5(3+Sqrt[5]))/6]/2,(1+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2}}

(* Dodecahedron C5 *)

PolyhedronName[Dodecahedron,"C5"]:="dodecahedron oriented with z-axis along a C5 axis of \
symmetry"
PolyhedronDual[Dodecahedron,"C5"]:=Sequence[Icosahedron,"C5"]
PolyhedronPolyhedra[Dodecahedron,"C5"]:={Range[12]}
PolyhedronFaces[Dodecahedron,"C5"]:={{18,10,9,17,4},{3,16,12,11,15},{15,11,7,19,13},{11,12,8,2,7},
{12,16,14,20,
    8},{16,3,1,6,14},{3,15,13,5,1},{20,14,6,10,18},{6,1,5,9,10},{5,13,19,17,
    9},{19,7,2,4,17},{2,8,20,18,4}}
PolyhedronVertices[Dodecahedron,"C5"]:={
 {Root[1-10#1^2+5#1^4&,1,0],0,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-10#1^2+5#1^4&,4,0],0,Root[1-20#1^2+80#1^4&,3,0]},
 {Root[1-5#1^2+5#1^4&,1,0],0,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-5#1^2+5#1^4&,4,0],0,Root[1-100#1^2+80#1^4&,4,0]},
 {Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,3,0]},
 {Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,3,0]},
 {Root[1-100#1^2+80#1^4&,4,0],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-100#1^2+80#1^4&,4,0],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-40#1^2+80#1^4&,1,0],-1/2,Root[1-100#1^2+80#1^4&,4,0]},
 {Root[1-40#1^2+80#1^4&,1,0],1/2,Root[1-100#1^2+80#1^4&,4,0]},
 {Root[1-40#1^2+80#1^4&,4,0],-1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-40#1^2+80#1^4&,4,0],1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,3,0],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,4,0]},
 {Root[1-20#1^2+80#1^4&,3,0],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,4,0]},
 {Root[1-20#1^2+80#1^4&,4,0],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,3,0]},
 {Root[1-20#1^2+80#1^4&,4,0],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,3,0]}}

(* Dodecahedron 2-Compound C2 *)

PolyhedronName[Dodecahedron2Compound,"C2"]:="dodecahedron 2-compound with 4-fold rotational symmetry"
NetPieces[Dodecahedron2Compound,"C2"]:={{24,{1,2,3}}}
NetFaces[Dodecahedron2Compound,"C2"]:={{1,2,3},{2,5,3},{2,4,1}}
NetVertices[Dodecahedron2Compound,"C2"]:=
{{0,0},{(1+Sqrt[5])/4,Sqrt[(5-Sqrt[5])/2]/2},{(1+Sqrt[5])/2,0},
 {(3+Sqrt[5])/8,Sqrt[25/32+(5Sqrt[5])/32]},
 {(1+3Sqrt[5])/8,Sqrt[25/32+(5Sqrt[5])/32]}}
 
PolyhedronPolyhedra[Dodecahedron2Compound,"C2"]:=
{{1,2,3,4,5,6,7,8,9,10,11,12},{13,14,15,16,17,18,19,20,21,22,23,24}}
PolyhedronFaces[Dodecahedron2Compound,"C2"]:=
{{24,15,14,23,1},{2,9,17,16,8},{8,16,12,3,31},{16,17,13,26,12},{17,9,32,4,
    13},{9,2,19,29,32},{2,8,31,28,19},{4,32,29,15,24},{29,19,28,14,15},{28,31,
    3,23,14},{3,12,26,1,23},{26,13,4,24,1},{29,21,20,28,30},{18,13,6,5,
    12},{12,5,23,22,7},{5,6,24,27,23},{6,13,10,25,24},{13,18,11,9,10},{18,12,
    7,8,11},{25,10,9,21,29},{9,11,8,20,21},{8,7,22,28,20},{22,23,27,30,
    28},{27,24,25,29,30}}
PolyhedronVertices[Dodecahedron2Compound,"C2"]:=
{{0,0,Sqrt[9/8+(3Sqrt[5])/8]},{0,0,-Sqrt[(3(3+Sqrt[5]))/2]/2},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,
  Sqrt[1/8+Sqrt[5]/24]},{Sqrt[1/8+Sqrt[5]/24],-1/2,Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/8+Sqrt[5]/24],1/2,Sqrt[3/4+Sqrt[5]/3]},{Sqrt[1/8+Sqrt[5]/24],(-3-Sqrt[5])/4,
  Root[1-36#1^2+144#1^4&,2,0]},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[1/8+Sqrt[5]/24],(3+Sqrt[5])/4,Root[1-36#1^2+144#1^4&,2,0]},
 {Sqrt[5/8+(5Sqrt[5])/24],0,-Sqrt[(3+Sqrt[5])/6]},{Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,
  Sqrt[1/8+Sqrt[5]/24]},{Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[(3+Sqrt[5])/6]/2},{Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {Sqrt[9/8+(3Sqrt[5])/8],0,0},{-Sqrt[(3+Sqrt[5])/6],0,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {-Sqrt[(3+Sqrt[5])/6]/2,-1/2,-Sqrt[3/4+Sqrt[5]/3]},{-Sqrt[(3+Sqrt[5])/6]/2,1/2,-Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[(3+Sqrt[5])/6]/2,(-3-Sqrt[5])/4,Sqrt[1/8-Sqrt[5]/24]},{-Sqrt[(3+Sqrt[5])/6]/2,(-1-Sqrt[5])/4,
  Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[(3+Sqrt[5])/6]/2,(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[(3+Sqrt[5])/6]/2,(3+Sqrt[5])/4,Sqrt[1/8-Sqrt[5]/24]},
 {Sqrt[(3+Sqrt[5])/6],0,Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[(5(3+Sqrt[5]))/6]/2,0,Sqrt[(3+Sqrt[5])/6]},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(-1-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(1+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},{-Sqrt[(3(3+Sqrt[5]))/2]/2,0,0},
 {Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2}}

(* Dodecahedron2Compound C3 *)

PolyhedronName[Dodecahedron2Compound,"C3"]:="dodecahedron 2-compound with 5-fold rotational symmetry"
PolyhedronPolyhedra[Dodecahedron2Compound,"C3"]:=
{{1,2,3,4,5,6,7,8,9,10,11,12},{13,14,15,16,17,18,19,20,21,22,23,24}}
PolyhedronFaces[Dodecahedron2Compound,"C3"]:=
{{27,17,15,25,1},{2,10,22,20,8},{8,20,11,3,36},{20,22,13,29,11},{22,10,38,5,
    13},{10,2,24,34,38},{2,8,36,32,24},{5,38,34,17,27},{34,24,32,15,17},{32,
    36,3,25,15},{3,11,29,1,25},{29,13,5,27,1},{9,37,33,23,1},{2,30,12,4,
    26},{26,4,35,31,16},{4,12,19,7,35},{12,30,14,21,19},{30,2,28,6,14},{2,26,
    16,18,28},{21,14,6,37,9},{6,28,18,33,37},{18,16,31,23,33},{31,35,7,1,
    23},{7,19,21,9,1}}
PolyhedronVertices[Dodecahedron2Compound,"C3"]:=
{{0,0,Sqrt[9/8+(3Sqrt[5])/8]},{0,0,-Sqrt[(3(3+Sqrt[5]))/2]/2},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,
  -Sqrt[(3+Sqrt[5])/6]/2},{Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,
  Sqrt[5/8+(5Sqrt[5])/24]},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(3+Sqrt[5])/6],0,Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[(3+Sqrt[5])/6],0,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {-Sqrt[(3+Sqrt[5])/6]/2,(-1-Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[(3+Sqrt[5])/6]/2,(-1-Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {-Sqrt[(3+Sqrt[5])/6]/2,(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[(3+Sqrt[5])/6]/2,(1+Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[(3+Sqrt[5])/6],0,Sqrt[5/8+(5Sqrt[5])/24]},{Sqrt[(3+Sqrt[5])/6],0,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(-1-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(1+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2}}

(* Dodecahedron2Compound C5 *)

PolyhedronPolyhedra[Dodecahedron2Compound,"C5"]:=
{{1,2,3,4,5,6,7,8,9,10,11,12},{13,14,15,16,17,18,19,20,21,22,23,24}}
PolyhedronName[Dodecahedron2Compound,"C5"]:="dodecahedron 2-compound with 10-fold rotational symmetry"
PolyhedronFaces[Dodecahedron2Compound,"C5"]:=
{{36,20,19,35,8},{6,32,24,23,31},{31,23,15,39,27},{23,24,16,4,15},{24,32,28,
    40,16},{32,6,2,12,28},{6,31,27,11,2},{40,28,12,20,36},{12,2,11,19,20},{11,
    27,39,35,19},{39,15,4,8,35},{4,16,40,36,8},{7,33,17,18,34},{29,21,22,30,
    5},{25,37,13,21,29},{13,3,14,22,21},{14,38,26,30,22},{26,10,1,5,30},{1,9,
    25,29,5},{34,18,10,26,38},{18,17,9,1,10},{17,33,37,25,9},{33,7,3,13,
    37},{7,34,38,14,3}}
PolyhedronVertices[Dodecahedron2Compound,"C5"]:=
{{Sqrt[1+2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,2,0]},
 {-Sqrt[1+2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,2,0]},{-Sqrt[1+2/Sqrt[5]],0,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1+2/Sqrt[5]],0,Sqrt[1/8-1/(8Sqrt[5])]},{Sqrt[(5+Sqrt[5])/10],0,
  Root[1-100#1^2+80#1^4&,1,0]},{Root[1-5#1^2+5#1^4&,1,0],0,
  Root[1-100#1^2+80#1^4&,1,0]},{Root[1-5#1^2+5#1^4&,1,0],0,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[(5+Sqrt[5])/10],0,Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,
  Sqrt[1/8-1/(8Sqrt[5])]},{Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[1/4+1/(2Sqrt[5])],1/2,
  Sqrt[5/8+11/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]]/2,-1/2,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1+2/Sqrt[5]]/2,1/2,Sqrt[5/8+11/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]]/2,-1/2,
  Root[1-100#1^2+80#1^4&,1,0]},{-Sqrt[1+2/Sqrt[5]]/2,1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]}}

(* Dodecahedron 5-Compound *)

PolyhedronName[Dodecahedron5Compound]:="compound of 5 dodecahedra"
NetPieces[Dodecahedron5Compound]:={{30,{1,2,3,4}},{60,{5,6}},{60,{7,8}}}
NetFaces[Dodecahedron5Compound]:=
{{1,8,13,11,2,18,20,15,4},{1,9,14,12,3,19,21,16,4},{9,7,10,1},{16,17,22,
    4},{26,25,5},{24,25,5},{28,27,6},{23,27,6}}
NetVertices[Dodecahedron5Compound]:=
{{0,0},{1/2,-Sqrt[5/16-Sqrt[5]/8]},{1/2,Sqrt[5/16-Sqrt[5]/8]},{1,0},{7/4,-1/4},
 {2,-1/4},{-Sqrt[5]/8,Sqrt[5/64-Sqrt[5]/32]},
 {(9-5Sqrt[5])/44,-Sqrt[65/968-(19Sqrt[5])/968]},
 {(9-5Sqrt[5])/44,Sqrt[65/968-(19Sqrt[5])/968]},
 {(1-3Sqrt[5])/44,-Sqrt[145/968-(61Sqrt[5])/968]},
 {(5-Sqrt[5])/20,-Sqrt[5/8-11/(8Sqrt[5])]},{(5-Sqrt[5])/20,Sqrt[5/8-11/(8Sqrt[5])]},
 {(5-Sqrt[5])/20,-Sqrt[1/8-1/(8Sqrt[5])]},{(5-Sqrt[5])/20,Sqrt[1/8-1/(8Sqrt[5])]},
 {(5(7+Sqrt[5]))/44,-Sqrt[65/968-(19Sqrt[5])/968]},
 {(5(7+Sqrt[5]))/44,Sqrt[65/968-(19Sqrt[5])/968]},
 {(8+Sqrt[5])/8,Sqrt[5/64-Sqrt[5]/32]},{(15+Sqrt[5])/20,-Sqrt[5/8-11/(8Sqrt[5])]},
 {(15+Sqrt[5])/20,Sqrt[5/8-11/(8Sqrt[5])]},{(15+Sqrt[5])/20,-Sqrt[1/8-1/(8Sqrt[5])]},
 {(15+Sqrt[5])/20,Sqrt[1/8-1/(8Sqrt[5])]},{(43+3Sqrt[5])/44,
  -Sqrt[145/968-(61Sqrt[5])/968]},{(160-Sqrt[10(25-11Sqrt[5])])/80,
  (-15+11Sqrt[5])/80},{(140+Sqrt[10(25-11Sqrt[5])])/80,(-15+11Sqrt[5])/80},
 {(35-4Sqrt[5(5-2Sqrt[5])])/20,(-5+4Sqrt[5])/20},
 {(35-2Sqrt[5(5-2Sqrt[5])])/20,-1/4},{(10+Sqrt[5(5-2Sqrt[5])])/5,
  (-5+4Sqrt[5])/20},{(20+Sqrt[5(5-2Sqrt[5])])/10,-1/4}}
PolyhedronPolyhedra[Dodecahedron5Compound]:=
{{1,2,3,4,5,6,7,8,9,10,11,12},{13,14,15,16,17,18,19,20,21,22,23,24},{25,26,27,
    28,29,30,31,32,33,34,35,36},{37,38,39,40,41,42,43,44,45,46,47,48},{49,50,
    51,52,53,54,55,56,57,58,59,60}}
PolyhedronDual[Dodecahedron5Compound]:=Icosahedron5Compound
PolyhedronFaces[Dodecahedron5Compound]:=
{{48,34,33,47,3},{6,77,57,56,76},{76,56,31,29,99},{56,57,32,49,31},{57,77,100,
    30,32},{77,6,78,59,100},{6,76,99,58,78},{30,100,59,34,48},{59,78,58,33,
    34},{58,99,29,47,33},{29,31,49,3,47},{49,32,30,48,3},{25,20,22,23,2},{9,
    87,68,70,85},{85,70,15,11,95},{70,68,17,28,15},{68,87,97,13,17},{87,9,89,
    74,97},{9,85,95,72,89},{13,97,74,20,25},{74,89,72,22,20},{72,95,11,23,
    22},{11,15,28,2,23},{28,17,13,25,2},{52,44,46,50,5},{7,81,60,62,79},{79,
    62,39,35,91},{62,60,41,55,39},{60,81,93,37,41},{81,7,83,66,93},{7,79,91,
    64,83},{37,93,66,44,52},{66,83,64,46,44},{64,91,35,50,46},{35,39,55,5,
    50},{55,41,37,52,5},{53,45,43,51,4},{8,82,63,61,80},{80,61,40,36,92},{61,
    63,42,54,40},{63,82,94,38,42},{82,8,84,67,94},{8,80,92,65,84},{38,94,67,
    45,53},{67,84,65,43,45},{65,92,36,51,43},{36,40,54,4,51},{54,42,38,53,
    4},{26,21,19,24,1},{10,88,71,69,86},{86,69,16,12,96},{69,71,18,27,16},{71,
    88,98,14,18},{88,10,90,75,98},{10,86,96,73,90},{14,98,75,21,26},{75,90,73,
    19,21},{73,96,12,24,19},{12,16,27,1,24},{27,18,14,26,1}}
PolyhedronVertices[Dodecahedron5Compound]:=
{{Sqrt[1/16-1/(8Sqrt[5])],-1/4,Sqrt[1+2/Sqrt[5]]},{Sqrt[1/16-1/(8Sqrt[5])],1/4,Sqrt[1+2/Sqrt[5]]},
 {Sqrt[1/8-1/(8Sqrt[5])],0,Sqrt[1+2/Sqrt[5]]},{-Sqrt[(5+Sqrt[5])/10]/4,(1-Sqrt[5])/8,Sqrt[1+2/Sqrt[5]]},
 {-Sqrt[(5+Sqrt[5])/10]/4,(-1+Sqrt[5])/8,Sqrt[1+2/Sqrt[5]]},{Root[1-20#1^2+80#1^4&,2,0],0,
  -Sqrt[1+2/Sqrt[5]]},{Sqrt[(5+Sqrt[5])/10]/4,(1-Sqrt[5])/8,-Sqrt[1+2/Sqrt[5]]},
 {Sqrt[(5+Sqrt[5])/10]/4,(-1+Sqrt[5])/8,-Sqrt[1+2/Sqrt[5]]},
 {-Sqrt[1-2/Sqrt[5]]/4,-1/4,-Sqrt[1+2/Sqrt[5]]},{-Sqrt[1-2/Sqrt[5]]/4,1/4,-Sqrt[1+2/Sqrt[5]]},
 {Sqrt[29/32+61/(32Sqrt[5])],(1-Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[25/2+41/(2Sqrt[5])]/4,(-3-Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[25/2+41/(2Sqrt[5])]/4,(3+Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[29/32+61/(32Sqrt[5])],(-1+Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[(65+19Sqrt[5])/10]/4,(5+Sqrt[5])/8,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[(65+19Sqrt[5])/10]/4,(-5-Sqrt[5])/8,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/32-1/(32Sqrt[5])],(3(1+Sqrt[5]))/8,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/32-1/(32Sqrt[5])],(-3(1+Sqrt[5]))/8,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[5/8+11/(8Sqrt[5])]},{Root[1-5#1^2+5#1^4&,1,0],0,
  Sqrt[5/8+11/(8Sqrt[5])]},{Root[1-5#1^2+5#1^4&,1,0],0,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[1/16+1/(8Sqrt[5])],(-2-Sqrt[5])/4,
  Sqrt[(5+Sqrt[5])/10]},{Sqrt[1/16+1/(8Sqrt[5])],(2+Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,1,0],-1/2,Sqrt[1/4+1/(2Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,1,0],1/2,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/32+11/(32Sqrt[5])],(3(1+Sqrt[5]))/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[(85+31Sqrt[5])/10]/4,(5+Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[(85+31Sqrt[5])/10]/4,(-5-Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[5/32+11/(32Sqrt[5])],(-3(1+Sqrt[5]))/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[1+2/Sqrt[5]],0,Sqrt[1/8-1/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]],0,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/16+1/(8Sqrt[5])],(2+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/16+1/(8Sqrt[5])],(-2-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[13/16+11/(8Sqrt[5])],1/4,Sqrt[1/4+1/(2Sqrt[5])]},{Sqrt[13/16+11/(8Sqrt[5])],-1/4,
  Sqrt[1/4+1/(2Sqrt[5])]},{Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],0,Sqrt[(5+Sqrt[5])/10]},{Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[5/8+11/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[5/8+11/(8Sqrt[5])]},{Root[1-1040#1^2+1280#1^4&,1,0],
  (-3-Sqrt[5])/8,Sqrt[(5+Sqrt[5])/10]},{Root[1-1040#1^2+1280#1^4&,1,0],(3+Sqrt[5])/8,
  Sqrt[(5+Sqrt[5])/10]},{Sqrt[5/8+11/(8Sqrt[5])],-1/2,-Sqrt[1+2/Sqrt[5]]/2},
 {Sqrt[5/8+11/(8Sqrt[5])],1/2,-Sqrt[1+2/Sqrt[5]]/2},{Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,
  Root[1-20#1^2+80#1^4&,2,0]},{Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,
  Root[1-20#1^2+80#1^4&,2,0]},{-Sqrt[13+22/Sqrt[5]]/4,1/4,-Sqrt[1+2/Sqrt[5]]/2},
 {-Sqrt[13+22/Sqrt[5]]/4,-1/4,-Sqrt[1+2/Sqrt[5]]/2},{-Sqrt[5+2/Sqrt[5]]/4,(2+Sqrt[5])/4,
  -Sqrt[1+2/Sqrt[5]]/2},{-Sqrt[5+2/Sqrt[5]]/4,(-2-Sqrt[5])/4,-Sqrt[1+2/Sqrt[5]]/2},
 {Sqrt[1+2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,2,0]},{Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,
  Root[1-20#1^2+80#1^4&,2,0]},{Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,
  Root[1-20#1^2+80#1^4&,2,0]},{Sqrt[1+2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-80#1^2+1280#1^4&,2,0],(3(1+Sqrt[5]))/8,-Sqrt[1+2/Sqrt[5]]/2},
 {Root[1-80#1^2+1280#1^4&,2,0],(-3(1+Sqrt[5]))/8,-Sqrt[1+2/Sqrt[5]]/2},
 {Sqrt[13/32+19/(32Sqrt[5])],(5+Sqrt[5])/8,-Sqrt[1+2/Sqrt[5]]/2},
 {Sqrt[13/32+19/(32Sqrt[5])],(-5-Sqrt[5])/8,-Sqrt[1+2/Sqrt[5]]/2},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-100#1^2+80#1^4&,1,0],0,Root[1-5#1^2+5#1^4&,1,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {-Sqrt[1+2/Sqrt[5]]/2,1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[13/32+29/(32Sqrt[5])],(-3-Sqrt[5])/8,Root[1-5#1^2+5#1^4&,1,0]},
 {Sqrt[13/32+29/(32Sqrt[5])],(3+Sqrt[5])/8,Root[1-5#1^2+5#1^4&,1,0]},
 {Sqrt[(5+Sqrt[5])/10],0,Root[1-100#1^2+80#1^4&,1,0]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {-Sqrt[1+2/Sqrt[5]]/2,1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[(5+Sqrt[5])/10],0,Root[1-100#1^2+80#1^4&,1,0]},{-Sqrt[1+2/Sqrt[5]]/4,(-2-Sqrt[5])/4,
  Root[1-5#1^2+5#1^4&,1,0]},{-Sqrt[1+2/Sqrt[5]]/4,(2+Sqrt[5])/4,Root[1-5#1^2+5#1^4&,1,0]},
 {Sqrt[17/32+31/(32Sqrt[5])],(5+Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Root[1-400#1^2+1280#1^4&,1,0],(3(1+Sqrt[5]))/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Root[1-400#1^2+1280#1^4&,1,0],(-3(1+Sqrt[5]))/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Sqrt[17/32+31/(32Sqrt[5])],(-5-Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Sqrt[25/32+41/(32Sqrt[5])],(-3-Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {-Sqrt[29/2+61/(2Sqrt[5])]/4,(1-Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {-Sqrt[29/2+61/(2Sqrt[5])]/4,(-1+Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Sqrt[25/32+41/(32Sqrt[5])],(3+Sqrt[5])/8,Root[1-20#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]}}

(* Dodecahedron 6-Compound *)

PolyhedronName[Dodecahedron6Compound]:="compound of 6 dodecahedra"
PolyhedronDual[Dodecahedron6Compound]:=Icosahedron6Compound
NetPieces[Dodecahedron6Compound]:={{60,{1,2}},{60,{3,4,5}},{60,{6,7,8}}}
NetFaces[Dodecahedron6Compound]:=
{{7,8,10},{1,7,10,9},{2,18,16,12,3},{2,17,15,11,3},{17,14,2},{4,20,5},{4,21,
    5},{20,13,6,19,5}}
NetVertices[Dodecahedron6Compound]:=
{{0,0},{1,1/4},{1,(3-2Sqrt[5])/4},{2,-1/4},{2,(5-2Sqrt[5])/4},{2,(4-Sqrt[5])/4},
 {(3(5-3Sqrt[5]))/40,Sqrt[(5-Sqrt[5])/10]/4},
 {(3-Sqrt[5])/8,(3Sqrt[(1465-149Sqrt[5])/10])/116},{(3-Sqrt[5])/4,0},
 {(15-Sqrt[5])/40,Sqrt[(5-Sqrt[5])/10]/4},{(76-Sqrt[2(125-41Sqrt[5])])/76,
  (-16+13Sqrt[5])/76},{(76+Sqrt[2(125-41Sqrt[5])])/76,(-16+13Sqrt[5])/76},
 {(8-Sqrt[5-2Sqrt[5]])/4,(3-Sqrt[5])/2},{(10+Sqrt[5(5-2Sqrt[5])])/10,
  (5+2Sqrt[5])/20},{(8-Sqrt[2(5-Sqrt[5])])/8,(-1+Sqrt[5])/8},
 {(8+Sqrt[2(5-Sqrt[5])])/8,(-1+Sqrt[5])/8},{(20-Sqrt[10(5-Sqrt[5])])/20,
  3/(4Sqrt[5])},{(20+Sqrt[10(5-Sqrt[5])])/20,3/(4Sqrt[5])},
 {(152+Sqrt[2(85+Sqrt[5])])/76,(3(34-11Sqrt[5]))/76},
 {(76-Sqrt[65+22Sqrt[5]])/38,(93-34Sqrt[5])/76},{(76+Sqrt[65+22Sqrt[5]])/38,
  (93-34Sqrt[5])/76}}
PolyhedronPolyhedra[Dodecahedron6Compound]:=
{{1,2,3,4,5,6,7,8,9,10,11,12},{13,14,15,16,17,18,19,20,21,22,23,24},{25,26,27,
    28,29,30,31,32,33,34,35,36},{37,38,39,40,41,42,43,44,45,46,47,48},{49,50,
    51,52,53,54,55,56,57,58,59,60},{61,62,63,64,65,66,67,68,69,70,71,72}}
PolyhedronFaces[Dodecahedron6Compound]:=
{{67,68,6,69,5},{66,8,70,7,65},{41,39,95,65,7},{97,41,7,70,120},{120,70,8,42,
    98},{96,40,42,8,66},{96,66,65,95,119},{40,6,68,98,42},{96,119,69,6,
    40},{119,95,39,5,69},{97,67,5,39,41},{97,120,98,68,67},{110,50,26,21,
    89},{107,88,19,27,44},{27,85,79,9,44},{27,19,38,102,85},{19,88,78,12,
    38},{107,99,84,78,88},{107,44,9,35,99},{26,50,12,78,84},{21,26,84,99,
    35},{21,35,9,79,89},{110,89,79,85,102},{110,102,38,12,50},{63,2,77,51,
    34},{58,33,52,80,3},{80,117,62,1,3},{80,52,81,118,117},{52,33,59,4,
    81},{58,115,116,59,33},{58,3,1,76,115},{77,2,4,59,116},{51,77,116,115,
    76},{51,76,1,62,34},{63,34,62,117,118},{63,118,81,4,2},{23,36,100,83,
    25},{17,28,86,101,37},{101,109,48,11,37},{101,86,82,90,109},{86,28,46,10,
    82},{17,87,108,46,28},{17,37,11,75,87},{100,36,10,46,108},{83,100,108,87,
    75},{83,75,11,48,25},{23,25,48,109,90},{23,90,82,10,36},{47,30,91,57,
    15},{45,14,64,94,31},{94,113,55,22,31},{94,64,74,105,113},{64,14,54,20,
    74},{45,104,112,54,14},{45,31,22,71,104},{91,30,20,54,112},{57,91,112,104,
    71},{57,71,22,55,15},{47,15,55,113,105},{47,105,74,20,30},{106,49,29,18,
    73},{103,72,24,32,43},{32,93,61,13,43},{32,24,56,114,93},{24,72,60,16,
    56},{103,111,92,60,72},{103,43,13,53,111},{29,49,16,60,92},{18,29,92,111,
    53},{18,53,13,61,73},{106,73,61,93,114},{106,114,56,16,49}}
PolyhedronVertices[Dodecahedron6Compound]:=
{{-Sqrt[1/8-11/(40Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[1/8-11/(40Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[1/8-11/(40Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[1/8-11/(40Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/20-1/(10Sqrt[5])],(-5-4Sqrt[5])/10,Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[1/20-1/(10Sqrt[5])],(5+4Sqrt[5])/10,Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[1/20-1/(10Sqrt[5])],(-5-4Sqrt[5])/10,-Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[1/20-1/(10Sqrt[5])],(5+4Sqrt[5])/10,-Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[1/10-1/(10Sqrt[5])],(-5-3Sqrt[5])/10,-Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[1/10-1/(10Sqrt[5])],(5+3Sqrt[5])/10,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[1/10-1/(10Sqrt[5])],(-5-3Sqrt[5])/10,Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[1/10-1/(10Sqrt[5])],(5+3Sqrt[5])/10,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[41/40+71/(40Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[41/40+71/(40Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(3(5+Sqrt[5]))/20,Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[41/40+71/(40Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,-Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[41/40+71/(40Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(3(5+Sqrt[5]))/20,-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[1/40+1/(40Sqrt[5])],(-5-3Sqrt[5])/20,Sqrt[37/40+59/(40Sqrt[5])]},
 {-Sqrt[1/40+1/(40Sqrt[5])],(5+3Sqrt[5])/20,Sqrt[37/40+59/(40Sqrt[5])]},
 {Sqrt[1/40+1/(40Sqrt[5])],(-5-3Sqrt[5])/20,-Sqrt[37/40+59/(40Sqrt[5])]},
 {Sqrt[1/40+1/(40Sqrt[5])],(5+3Sqrt[5])/20,-Sqrt[37/40+59/(40Sqrt[5])]},
 {-Sqrt[1/20+1/(10Sqrt[5])],-1/(2Sqrt[5]),Sqrt[41/40+71/(40Sqrt[5])]},
 {-Sqrt[1/20+1/(10Sqrt[5])],1/(2Sqrt[5]),Sqrt[41/40+71/(40Sqrt[5])]},
 {Sqrt[1/20+1/(10Sqrt[5])],-1/(2Sqrt[5]),-Sqrt[41/40+71/(40Sqrt[5])]},
 {Sqrt[1/20+1/(10Sqrt[5])],1/(2Sqrt[5]),-Sqrt[41/40+71/(40Sqrt[5])]},
 {-Sqrt[1/10+1/(10Sqrt[5])],0,-Sqrt[41/40+71/(40Sqrt[5])]},
 {Sqrt[1/10+1/(10Sqrt[5])],0,Sqrt[41/40+71/(40Sqrt[5])]},
 {-Sqrt[1/4+1/(10Sqrt[5])],(-5-2Sqrt[5])/10,Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[1/4+1/(10Sqrt[5])],(5+2Sqrt[5])/10,Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/4+1/(10Sqrt[5])],(-5-2Sqrt[5])/10,-Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/4+1/(10Sqrt[5])],(5+2Sqrt[5])/10,-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[1/8+11/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[37/40+59/(40Sqrt[5])]},
 {-Sqrt[1/8+11/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[1/8+11/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[37/40+59/(40Sqrt[5])]},
 {-Sqrt[1/8+11/(40Sqrt[5])],(3(5+Sqrt[5]))/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[1/8+11/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[37/40+59/(40Sqrt[5])]},
 {Sqrt[1/8+11/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[1/8+11/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[37/40+59/(40Sqrt[5])]},
 {Sqrt[1/8+11/(40Sqrt[5])],(3(5+Sqrt[5]))/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[1/5+2/(5Sqrt[5])],0,Sqrt[37/40+59/(40Sqrt[5])]},
 {Sqrt[1/5+2/(5Sqrt[5])],0,-Sqrt[37/40+59/(40Sqrt[5])]},
 {-Sqrt[2/5+2/(5Sqrt[5])],(-5-3Sqrt[5])/10,Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[2/5+2/(5Sqrt[5])],(5+3Sqrt[5])/10,Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[2/5+2/(5Sqrt[5])],(-5-3Sqrt[5])/10,-Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[2/5+2/(5Sqrt[5])],(5+3Sqrt[5])/10,-Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(3(5+Sqrt[5]))/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(1+Sqrt[5])/4,Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(3(5+Sqrt[5]))/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],-1/2,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],1/2,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/2+1/(2Sqrt[5])],0,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/2+1/(2Sqrt[5])],0,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(-5-7Sqrt[5])/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(5+7Sqrt[5])/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(-5-7Sqrt[5])/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(5+7Sqrt[5])/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[17/40+31/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,-Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[17/40+31/(40Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[17/40+31/(40Sqrt[5])],(1+Sqrt[5])/4,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[17/40+31/(40Sqrt[5])],(3(5+Sqrt[5]))/20,-Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[17/40+31/(40Sqrt[5])],(3(-5-Sqrt[5]))/20,Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[17/40+31/(40Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[17/40+31/(40Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[17/40+31/(40Sqrt[5])],(3(5+Sqrt[5]))/20,Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[5/8+41/(40Sqrt[5])],(-5-3Sqrt[5])/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[5/8+41/(40Sqrt[5])],(5+3Sqrt[5])/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[5/8+41/(40Sqrt[5])],(-5-3Sqrt[5])/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[5/8+41/(40Sqrt[5])],(5+3Sqrt[5])/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],-(1/Sqrt[5]),-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],1/Sqrt[5],-Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],-(1/Sqrt[5]),Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],1/Sqrt[5],Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[13/20+11/(10Sqrt[5])],-1/(2Sqrt[5]),Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[13/20+11/(10Sqrt[5])],1/(2Sqrt[5]),Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[13/20+11/(10Sqrt[5])],-1/(2Sqrt[5]),-Sqrt[17/40+31/(40Sqrt[5])]},
 {Sqrt[13/20+11/(10Sqrt[5])],1/(2Sqrt[5]),-Sqrt[17/40+31/(40Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {-Sqrt[37/40+59/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[37/40+59/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[37/40+59/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[37/40+59/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[29/40+61/(40Sqrt[5])],(5-Sqrt[5])/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[29/40+61/(40Sqrt[5])],(-5+Sqrt[5])/20,-Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[29/40+61/(40Sqrt[5])],(5-Sqrt[5])/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {Sqrt[29/40+61/(40Sqrt[5])],(-5+Sqrt[5])/20,Sqrt[13/40+19/(40Sqrt[5])]},
 {-Sqrt[4/5+8/(5Sqrt[5])],-(1/Sqrt[5]),-Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[4/5+8/(5Sqrt[5])],1/Sqrt[5],-Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[4/5+8/(5Sqrt[5])],-(1/Sqrt[5]),Sqrt[1/8+11/(40Sqrt[5])]},
 {Sqrt[4/5+8/(5Sqrt[5])],1/Sqrt[5],Sqrt[1/8+11/(40Sqrt[5])]},
 {-Sqrt[41/40+71/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[41/40+71/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[41/40+71/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[41/40+71/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[17/20+19/(10Sqrt[5])],-1/2,-Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[17/20+19/(10Sqrt[5])],1/2,-Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[17/20+19/(10Sqrt[5])],-1/2,Sqrt[1/40-1/(40Sqrt[5])]},
 {Sqrt[17/20+19/(10Sqrt[5])],1/2,Sqrt[1/40-1/(40Sqrt[5])]},
 {-Sqrt[(5+2Sqrt[5])/5],0,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[(5+2Sqrt[5])/5],0,-Sqrt[1/8-1/(8Sqrt[5])]}}

(* Dodecahedron-Icosahedron Compound *)

PolyhedronName[DodecahedronIcosahedronCompound]:="dodecahedron-icosahedron compound"
NetPieces[DodecahedronIcosahedronCompound]:={{0,{1,2,3,4,5}},{0,{6,7,8}}}
NetFaces[DodecahedronIcosahedronCompound]:=
{{1,10,11},{1,11,9},{1,9,3},{1,5,6},{1,6,4},{13,2,12},{7,2,13},{8,2,7}}
NetVertices[DodecahedronIcosahedronCompound]:=
{{0,0},{3/2,-1/4},{(-1-Sqrt[5])/8,-(Sqrt[3](1+Sqrt[5]))/8},
 {(-1-Sqrt[5])/8,(Sqrt[3](1+Sqrt[5]))/8},{(-1-Sqrt[5])/8,-Sqrt[(3(3+Sqrt[5]))/2]/4},
 {(-1-Sqrt[5])/4,0},{(11-Sqrt[5])/8,(-2-Sqrt[10-2Sqrt[5]])/8},
 {(13-Sqrt[5])/8,(-2+Sqrt[2(5+Sqrt[5])])/8},{(1+Sqrt[5])/8,-(Sqrt[3](1+Sqrt[5]))/8},
 {(1+Sqrt[5])/8,Sqrt[(3(3+Sqrt[5]))/2]/4},{(1+Sqrt[5])/4,0},
 {(11+Sqrt[5])/8,(-2+Sqrt[2(5+Sqrt[5])])/8},{(13+Sqrt[5])/8,(-2-Sqrt[10-2Sqrt[5]])/8}}

PolyhedronPolyhedra[DodecahedronIcosahedronCompound]:={Range[12],Range[13,32]}
PolyhedronFaces[DodecahedronIcosahedronCompound]:=
{{7,26,25,5,2},{1,11,28,27,9},{9,27,23,3,31},{27,28,24,19,23},{28,11,32,4,
    24},{11,1,17,22,32},{1,9,31,21,17},{4,32,22,26,7},{22,17,21,25,26},{21,31,
    3,5,25},{3,23,19,2,5},{19,24,4,7,2},{18,10,12},{6,8,20},{10,13,15},{16,14,
    12},{20,15,6},{8,16,20},{15,30,10},{30,16,12},{18,29,13},{18,14,29},{30,
    15,20},{16,30,20},{8,6,29},{18,13,10},{12,14,18},{12,10,30},{13,29,6},{29,
    14,8},{13,6,15},{16,8,14}}
PolyhedronVertices[DodecahedronIcosahedronCompound]:=
{{0,0,-Sqrt[9/8+(3Sqrt[5])/8]},{0,0,Sqrt[9/8+(3Sqrt[5])/8]},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[7/24+Sqrt[5]/8],(-3-Sqrt[5])/4,1/(2Sqrt[3])},{-Sqrt[7/24+Sqrt[5]/8],(3+Sqrt[5])/4,
  1/(2Sqrt[3])},{Sqrt[7/24+Sqrt[5]/8],(-3-Sqrt[5])/4,-1/(2Sqrt[3])},
 {Sqrt[7/24+Sqrt[5]/8],(3+Sqrt[5])/4,-1/(2Sqrt[3])},{-Sqrt[1/2+Sqrt[5]/6],0,
  -Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[1/2+Sqrt[5]/6],0,Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/2+Sqrt[5]/6],0,Sqrt[5/8+(5Sqrt[5])/24]},{Sqrt[1/2+Sqrt[5]/6],0,-Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],1/2,
  Sqrt[1/8+Sqrt[5]/24]},{Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[7/6+Sqrt[5]/2],0,-1/(2Sqrt[3])},
 {Sqrt[7/6+Sqrt[5]/2],0,1/(2Sqrt[3])},{Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,
  -Sqrt[1/8+Sqrt[5]/24]},{Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]}}

PolyhedronFaces[DodecahedronIcosahedronCompound,Split->True]:=
{{18,34,12},{55,54,34},{53,33,54},{16,11,33},{2,12,11},{34,54,38},{54,33,
    38},{33,11,38},{11,12,38},{12,34,38},{1,14,13},{23,36,14},{58,57,36},{56,
    35,57},{21,13,35},{14,36,40},{36,57,40},{57,35,40},{35,13,40},{13,14,
    40},{21,35,7},{56,51,35},{43,27,51},{9,3,27},{61,7,3},{35,51,31},{51,27,
    31},{27,3,31},{3,7,31},{7,35,31},{56,57,51},{58,52,57},{44,48,52},{39,47,
    48},{43,51,47},{57,52,60},{52,48,60},{48,47,60},{47,51,60},{51,57,60},{58,
    36,52},{23,8,36},{62,4,8},{10,28,4},{44,52,28},{36,8,32},{8,4,32},{4,28,
    32},{28,52,32},{52,36,32},{23,14,8},{1,15,14},{37,46,15},{42,26,46},{62,8,
    26},{14,15,19},{15,46,19},{46,26,19},{26,8,19},{8,14,19},{1,13,15},{21,7,
    13},{61,25,7},{41,45,25},{37,15,45},{13,7,17},{7,25,17},{25,45,17},{45,15,
    17},{15,13,17},{10,4,6},{62,26,4},{42,50,26},{55,34,50},{18,6,34},{4,26,
    30},{26,50,30},{50,34,30},{34,6,30},{6,4,30},{42,46,50},{37,45,46},{41,49,
    45},{53,54,49},{55,50,54},{46,45,59},{45,49,59},{49,54,59},{54,50,59},{50,
    46,59},{41,25,49},{61,3,25},{9,5,3},{16,33,5},{53,49,33},{25,3,29},{3,5,
    29},{5,33,29},{33,49,29},{49,25,29},{9,27,5},{43,47,27},{39,20,47},{2,11,
    20},{16,5,11},{27,47,22},{47,20,22},{20,11,22},{11,5,22},{5,27,22},{39,48,
    20},{44,28,48},{10,6,28},{18,12,6},{2,20,12},{48,28,24},{28,6,24},{6,12,
    24},{12,20,24},{20,48,24}}
PolyhedronVertices[DodecahedronIcosahedronCompound,Split->True]:=
{{0,0,-Sqrt[9/8+(3Sqrt[5])/8]},{0,0,Sqrt[9/8+(3Sqrt[5])/8]},{0,(-3-Sqrt[5])/4,0},
 {0,(3+Sqrt[5])/4,0},{-1/(4Sqrt[3]),(-2-Sqrt[5])/4,Sqrt[7/24+Sqrt[5]/8]},
 {-1/(4Sqrt[3]),(2+Sqrt[5])/4,Sqrt[7/24+Sqrt[5]/8]},{1/(4Sqrt[3]),(-2-Sqrt[5])/4,
  -Sqrt[7/24+Sqrt[5]/8]},{1/(4Sqrt[3]),(2+Sqrt[5])/4,-Sqrt[7/24+Sqrt[5]/8]},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[1/32+Sqrt[5]/96],(-1-Sqrt[5])/8,Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[1/32+Sqrt[5]/96],(1+Sqrt[5])/8,Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/32+Sqrt[5]/96],(-1-Sqrt[5])/8,-Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/32+Sqrt[5]/96],(1+Sqrt[5])/8,-Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[1/8+Sqrt[5]/24],0,-Sqrt[3/4+Sqrt[5]/3]},{-Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,
  Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/8+Sqrt[5]/24],0,Sqrt[3/4+Sqrt[5]/3]},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,
  -Sqrt[5/8+(5Sqrt[5])/24]},{Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,Sqrt[3/4+Sqrt[5]/3]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[3/4+Sqrt[5]/3]},
 {-Sqrt[3/16+Sqrt[5]/12],(-2-Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/16+Sqrt[5]/12],(2+Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/16+Sqrt[5]/12],(-2-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/16+Sqrt[5]/12],(2+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[7/24+Sqrt[5]/8],(-3-Sqrt[5])/4,1/(2Sqrt[3])},{-Sqrt[7/24+Sqrt[5]/8],(3+Sqrt[5])/4,
  1/(2Sqrt[3])},{Sqrt[7/24+Sqrt[5]/8],(-3-Sqrt[5])/4,-1/(2Sqrt[3])},
 {Sqrt[7/24+Sqrt[5]/8],(3+Sqrt[5])/4,-1/(2Sqrt[3])},{-Sqrt[35/96+(5Sqrt[5])/32],(-3-Sqrt[5])/8,
  Sqrt[7/24+Sqrt[5]/8]},{-Sqrt[35/96+(5Sqrt[5])/32],(3+Sqrt[5])/8,Sqrt[7/24+Sqrt[5]/8]},
 {Sqrt[35/96+(5Sqrt[5])/32],(-3-Sqrt[5])/8,-Sqrt[7/24+Sqrt[5]/8]},
 {Sqrt[35/96+(5Sqrt[5])/32],(3+Sqrt[5])/8,-Sqrt[7/24+Sqrt[5]/8]},
 {-Sqrt[1/2+Sqrt[5]/6],0,-Sqrt[5/8+(5Sqrt[5])/24]},{-Sqrt[1/2+Sqrt[5]/6],0,
  Sqrt[3/4+Sqrt[5]/3]},{Sqrt[1/2+Sqrt[5]/6],0,Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[1/2+Sqrt[5]/6],0,-Sqrt[3/4+Sqrt[5]/3]},{-Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,
  -Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[47/96+(7Sqrt[5])/32],(-1-Sqrt[5])/8,-Sqrt[7/24+Sqrt[5]/8]},
 {-Sqrt[47/96+(7Sqrt[5])/32],(1+Sqrt[5])/8,-Sqrt[7/24+Sqrt[5]/8]},
 {Sqrt[47/96+(7Sqrt[5])/32],(-1-Sqrt[5])/8,Sqrt[7/24+Sqrt[5]/8]},
 {Sqrt[47/96+(7Sqrt[5])/32],(1+Sqrt[5])/8,Sqrt[7/24+Sqrt[5]/8]},
 {-Sqrt[21/32+(9Sqrt[5])/32],(-3-Sqrt[5])/8,0},{-Sqrt[21/32+(9Sqrt[5])/32],(3+Sqrt[5])/8,0},
 {Sqrt[21/32+(9Sqrt[5])/32],(-3-Sqrt[5])/8,0},{Sqrt[21/32+(9Sqrt[5])/32],(3+Sqrt[5])/8,0},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[3/4+Sqrt[5]/3],0,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},{Sqrt[3/4+Sqrt[5]/3],-1/2,
  -Sqrt[1/8+Sqrt[5]/24]},{Sqrt[3/4+Sqrt[5]/3],0,-Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[1/8+Sqrt[5]/24]},{-Sqrt[7/6+Sqrt[5]/2],0,-1/(2Sqrt[3])},
 {Sqrt[7/6+Sqrt[5]/2],0,1/(2Sqrt[3])},{Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,
  -Sqrt[1/8+Sqrt[5]/24]},{Root[1-36#1^2+144#1^4&,2,0],(3+Sqrt[5])/4,-Sqrt[1/8+Sqrt[5]/24]}}

(* Great Dodecahedron *)

PolyhedronName[GreatDodecahedron]:="great dodecahedron"
PolyhedronDual[GreatDodecahedron]:=SmallStellatedDodecahedron

PolyhedronFaces[GreatDodecahedron]:=
{{11,1,3,9,7},{12,8,10,3,1},{4,8,6,1,11},{4,12,1,5,7},{6,10,9,5,1},{8,6,3,9,
    2},{7,2,10,3,5},{4,2,9,5,11},{4,12,6,10,2},{8,2,7,11,12},{11,12,6,3,5},{4,
    8,10,9,7}}
PolyhedronVertices[GreatDodecahedron]:=
{{0,0,-5/Sqrt[50-10Sqrt[5]]},{0,0,5/Sqrt[50-10Sqrt[5]]},
 {-Sqrt[2/(5-Sqrt[5])],0,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[2/(5-Sqrt[5])],0,1/Sqrt[10-2Sqrt[5]]},
 {-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  -Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  -Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,1/Sqrt[10-2Sqrt[5]]},
 {(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,1/Sqrt[10-2Sqrt[5]]},
 {-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-1/2,
  1/Sqrt[10-2Sqrt[5]]},{-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  1/2,1/Sqrt[10-2Sqrt[5]]},{(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  -1/2,-(1/Sqrt[10-2Sqrt[5]])},
 {(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),1/2,-(1/Sqrt[10-2Sqrt[5]])}}

PolyhedronFaces[GreatDodecahedron,Split->True]:=
{{24,2,8},{24,8,10},{24,10,2},{13,2,10},{13,10,9},{13,9,2},{23,2,9},{23,9,
    7},{23,7,2},{19,2,7},{19,7,4},{19,4,2},{20,2,4},{20,4,8},{20,8,2},{27,11,
    5},{27,5,1},{27,1,11},{14,12,11},{14,11,1},{14,1,12},{28,6,12},{28,12,
    1},{28,1,6},{18,3,6},{18,6,1},{18,1,3},{17,5,3},{17,3,1},{17,1,5},{21,8,
    6},{21,6,10},{21,10,8},{15,10,3},{15,3,9},{15,9,10},{22,9,5},{22,5,7},{22,
    7,9},{26,7,11},{26,11,4},{26,4,7},{25,4,12},{25,12,8},{25,8,4},{32,11,
    7},{32,7,5},{32,5,11},{16,12,4},{16,4,11},{16,11,12},{31,6,8},{31,8,
    12},{31,12,6},{29,3,10},{29,10,6},{29,6,3},{30,5,9},{30,9,3},{30,3,5}}
PolyhedronVertices[GreatDodecahedron,Split->True]:=
{{0,0,-5/Sqrt[50-10Sqrt[5]]},{0,0,5/Sqrt[50-10Sqrt[5]]},{Root[1-5#1^2+5#1^4&,1,0],0,
  -(1/Sqrt[10-2Sqrt[5]])},{Sqrt[(5+Sqrt[5])/10],0,1/Sqrt[10-2Sqrt[5]]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,1/Sqrt[10-2Sqrt[5]]},{-Sqrt[1+2/Sqrt[5]]/2,1/2,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,-(1/Sqrt[10-2Sqrt[5]])},{Sqrt[1/4+1/(2Sqrt[5])],1/2,
  -(1/Sqrt[10-2Sqrt[5]])},{-Sqrt[1-2/Sqrt[5]],0,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1-2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,1,0]},{Root[1-5#1^2+5#1^4&,2,0],0,
  Sqrt[5/8-11/(8Sqrt[5])]},{Root[1-5#1^2+5#1^4&,3,0],0,Root[1-100#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-3+Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,2,0],(3-Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/8-1/(8Sqrt[5])],(-3+Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[1/8-1/(8Sqrt[5])],(3-Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {-Sqrt[1-2/Sqrt[5]]/2,1/2,Sqrt[5/8-11/(8Sqrt[5])]},{-Sqrt[1-2/Sqrt[5]]/2,-1/2,Sqrt[5/8-11/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,2,0],(1-Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Root[1-100#1^2+80#1^4&,2,0],(-1+Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-1+Sqrt[5])/4,Sqrt[5/8-11/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(1-Sqrt[5])/4,Sqrt[5/8-11/(8Sqrt[5])]},
 {Sqrt[5/8-11/(8Sqrt[5])],(1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]},
 {Sqrt[5/8-11/(8Sqrt[5])],(-1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(-1+Sqrt[5])/4,-(1/Sqrt[50+22Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,1,0],(1-Sqrt[5])/4,-(1/Sqrt[50+22Sqrt[5]])},
 {Sqrt[1/4-1/(2Sqrt[5])],1/2,Root[1-100#1^2+80#1^4&,2,0]},
 {Sqrt[1/4-1/(2Sqrt[5])],-1/2,Root[1-100#1^2+80#1^4&,2,0]}}

(* Great Icosahedron *)

PolyhedronName[GreatIcosahedron]:="great icosahedron"
PolyhedronDual[GreatIcosahedron]:=GreatStellatedDodecahedron
PolyhedronFaces[GreatIcosahedron]:=
{{1,7,5},{1,7,6},{1,5,12},{1,6,11},{1,11,12},{2,8,3},{2,8,4},{2,3,10},{2,4,
    9},{2,9,10},{8,3,12},{8,4,11},{8,11,12},{7,5,10},{7,6,9},{7,9,10},{3,5,
    10},{3,5,12},{4,6,9},{4,6,11}}
PolyhedronVertices[GreatIcosahedron]:=
{{0,0,-5/Sqrt[50-10Sqrt[5]]},{0,0,5/Sqrt[50-10Sqrt[5]]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,-(1/Sqrt[10-2Sqrt[5]])},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,1/Sqrt[10-2Sqrt[5]]},
 {-Sqrt[1+2/Sqrt[5]]/2,1/2,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[(5+Sqrt[5])/10],0,1/Sqrt[10-2Sqrt[5]]},
 {Root[1-5#1^2+5#1^4&,1,0],0,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,
  -(1/Sqrt[10-2Sqrt[5]])},{Root[1-20#1^2+80#1^4&,2,0],
  (1+Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,3,0],(-1-Sqrt[5])/4,
  1/Sqrt[10-2Sqrt[5]]},{Root[1-20#1^2+80#1^4&,3,0],
  (1+Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]}}

PolyhedronFaces[GreatIcosahedron,Split->True]:=
{{79,87,2},{2,87,47},{79,47,87},{47,14,2},{2,14,48},{47,48,14},{48,90,2},{2,
    90,80},{48,80,90},{80,8,2},{2,8,51},{80,51,8},{51,7,2},{2,7,79},{51,79,
    7},{52,9,1},{1,9,81},{52,81,9},{81,83,1},{1,83,43},{81,43,83},{43,11,
    1},{1,11,44},{43,44,11},{44,86,1},{1,86,82},{44,82,86},{82,10,1},{1,10,
    52},{82,52,10},{82,4,46},{46,4,44},{82,44,4},{44,22,46},{46,22,66},{44,66,
    22},{66,27,46},{46,27,18},{66,18,27},{18,76,46},{46,76,20},{18,20,76},{20,
    89,46},{46,89,82},{20,82,89},{44,33,73},{73,33,43},{44,43,33},{43,39,
    73},{73,39,65},{43,65,39},{65,61,73},{73,61,91},{65,91,61},{91,62,73},{73,
    62,66},{91,66,62},{66,40,73},{73,40,44},{66,44,40},{43,3,45},{45,3,
    81},{43,81,3},{81,88,45},{45,88,19},{81,19,88},{19,75,45},{45,75,17},{19,
    17,75},{17,26,45},{45,26,65},{17,65,26},{65,21,45},{45,21,43},{65,43,
    21},{81,29,71},{71,29,52},{81,52,29},{52,56,71},{71,56,92},{52,92,56},{92,
    59,71},{71,59,67},{92,67,59},{67,37,71},{71,37,19},{67,19,37},{19,15,
    71},{71,15,81},{19,81,15},{52,32,72},{72,32,82},{52,82,32},{82,16,72},{72,
    16,20},{82,20,16},{20,38,72},{72,38,68},{20,68,38},{68,60,72},{72,60,
    92},{68,92,60},{92,55,72},{72,55,52},{92,52,55},{17,77,49},{49,77,19},{17,
    19,77},{19,30,49},{49,30,67},{19,67,30},{67,23,49},{49,23,47},{67,47,
    23},{47,5,49},{49,5,79},{47,79,5},{79,84,49},{49,84,17},{79,17,84},{67,63,
    74},{74,63,92},{67,92,63},{92,64,74},{74,64,68},{92,68,64},{68,42,74},{74,
    42,48},{68,48,42},{48,36,74},{74,36,47},{48,47,36},{47,41,74},{74,41,
    67},{47,67,41},{68,31,50},{50,31,20},{68,20,31},{20,78,50},{50,78,18},{20,
    18,78},{18,85,50},{50,85,80},{18,80,85},{80,6,50},{50,6,48},{80,48,6},{48,
    24,50},{50,24,68},{48,68,24},{18,35,70},{70,35,66},{18,66,35},{66,58,
    70},{70,58,91},{66,91,58},{91,53,70},{70,53,51},{91,51,53},{51,28,70},{70,
    28,80},{51,80,28},{80,13,70},{70,13,18},{80,18,13},{91,57,69},{69,57,
    65},{91,65,57},{65,34,69},{69,34,17},{65,17,34},{17,12,69},{69,12,79},{17,
    79,12},{79,25,69},{69,25,51},{79,51,25},{51,54,69},{69,54,91},{51,91,54}}
PolyhedronVertices[GreatIcosahedron,Split->True]:=
{{0, 0, -Sqrt[25/8 + (11*Sqrt[5])/8]}, {0, 0, Sqrt[25/8 + (11*Sqrt[5])/8]}, 
 {-Sqrt[1/40 + 1/(40*Sqrt[5])], (-5 - 3*Sqrt[5])/20, -Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {-Sqrt[1/40 + 1/(40*Sqrt[5])], (5 + 3*Sqrt[5])/20, -Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {Sqrt[1/40 + 1/(40*Sqrt[5])], (-5 - 3*Sqrt[5])/20, Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {Sqrt[1/40 + 1/(40*Sqrt[5])], (5 + 3*Sqrt[5])/20, Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {-Sqrt[1/20 + 1/(10*Sqrt[5])], -1/(2*Sqrt[5]), Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {-Sqrt[1/20 + 1/(10*Sqrt[5])], 1/(2*Sqrt[5]), Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {Sqrt[1/20 + 1/(10*Sqrt[5])], -1/(2*Sqrt[5]), -Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {Sqrt[1/20 + 1/(10*Sqrt[5])], 1/(2*Sqrt[5]), -Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {-Sqrt[1/10 + 1/(10*Sqrt[5])], 0, -Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {-Sqrt[1/10 + 1/(10*Sqrt[5])], (-5 - Sqrt[5])/10, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[1/10 + 1/(10*Sqrt[5])], (5 + Sqrt[5])/10, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[1/10 + 1/(10*Sqrt[5])], 0, Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {Sqrt[1/10 + 1/(10*Sqrt[5])], (-5 - Sqrt[5])/10, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[1/10 + 1/(10*Sqrt[5])], (5 + Sqrt[5])/10, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[1/8 + 1/(8*Sqrt[5])], (-3 - Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 3, 0]}, 
 {-Sqrt[1/8 + 1/(8*Sqrt[5])], (3 + Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 3, 0]}, 
 {Sqrt[1/8 + 1/(8*Sqrt[5])], (-3 - Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 2, 0]}, 
 {Sqrt[1/8 + 1/(8*Sqrt[5])], (3 + Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 2, 0]}, 
 {-Sqrt[9/40 + 9/(40*Sqrt[5])], (-5 - 3*Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[9/40 + 9/(40*Sqrt[5])], (5 + 3*Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[9/40 + 9/(40*Sqrt[5])], (-5 - 3*Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[9/40 + 9/(40*Sqrt[5])], (5 + 3*Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[1/8 + 11/(40*Sqrt[5])], (-5 - Sqrt[5])/20, Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {-Sqrt[1/8 + 11/(40*Sqrt[5])], (-1 - Sqrt[5])/4, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[1/8 + 11/(40*Sqrt[5])], (1 + Sqrt[5])/4, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[1/8 + 11/(40*Sqrt[5])], (5 + Sqrt[5])/20, Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {Sqrt[1/8 + 11/(40*Sqrt[5])], (-5 - Sqrt[5])/20, -Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {Sqrt[1/8 + 11/(40*Sqrt[5])], (-1 - Sqrt[5])/4, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[1/8 + 11/(40*Sqrt[5])], (1 + Sqrt[5])/4, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[1/8 + 11/(40*Sqrt[5])], (5 + Sqrt[5])/20, -Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {-Sqrt[1/5 + 2/(5*Sqrt[5])], 0, -Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {-Sqrt[1/5 + 2/(5*Sqrt[5])], (-5 - Sqrt[5])/10, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[1/5 + 2/(5*Sqrt[5])], (5 + Sqrt[5])/10, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[1/5 + 2/(5*Sqrt[5])], 0, Sqrt[13/40 + 19/(40*Sqrt[5])]}, 
 {Sqrt[1/5 + 2/(5*Sqrt[5])], (-5 - Sqrt[5])/10, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[1/5 + 2/(5*Sqrt[5])], (5 + Sqrt[5])/10, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[13/40 + 19/(40*Sqrt[5])], (-5 - Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[13/40 + 19/(40*Sqrt[5])], (5 + Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[13/40 + 19/(40*Sqrt[5])], (-5 - Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[13/40 + 19/(40*Sqrt[5])], (5 + Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2, Root[1 - 100*#1^2 + 80*#1^4 & , 1, 0]}, 
 {-Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2, Root[1 - 100*#1^2 + 80*#1^4 & , 1, 0]}, 
 {-Sqrt[1/4 + 1/(2*Sqrt[5])], (-2 - Sqrt[5])/2, -Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {-Sqrt[1/4 + 1/(2*Sqrt[5])], (2 + Sqrt[5])/2, -Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {Sqrt[1/4 + 1/(2*Sqrt[5])], -1/2, Root[1 - 100*#1^2 + 80*#1^4 & , 4, 0]}, 
 {Sqrt[1/4 + 1/(2*Sqrt[5])], 1/2, Root[1 - 100*#1^2 + 80*#1^4 & , 4, 0]}, 
 {Sqrt[1/4 + 1/(2*Sqrt[5])], (-2 - Sqrt[5])/2, Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {Sqrt[1/4 + 1/(2*Sqrt[5])], (2 + Sqrt[5])/2, Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {-Sqrt[1/2 + 1/(2*Sqrt[5])], 0, Root[1 - 100*#1^2 + 80*#1^4 & , 4, 0]}, 
 {Sqrt[1/2 + 1/(2*Sqrt[5])], 0, Root[1 - 100*#1^2 + 80*#1^4 & , 1, 0]}, 
 {-Sqrt[13/40 + 29/(40*Sqrt[5])], (5 - Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[13/40 + 29/(40*Sqrt[5])], (-5 + Sqrt[5])/20, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[13/40 + 29/(40*Sqrt[5])], (5 - Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[13/40 + 29/(40*Sqrt[5])], (-5 + Sqrt[5])/20, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[17/40 + 31/(40*Sqrt[5])], (-5 - Sqrt[5])/20, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[17/40 + 31/(40*Sqrt[5])], (5 + Sqrt[5])/20, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[17/40 + 31/(40*Sqrt[5])], (-5 - Sqrt[5])/20, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[17/40 + 31/(40*Sqrt[5])], (5 + Sqrt[5])/20, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[9/20 + 9/(10*Sqrt[5])], -1/(2*Sqrt[5]), -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[9/20 + 9/(10*Sqrt[5])], 1/(2*Sqrt[5]), -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[9/20 + 9/(10*Sqrt[5])], -1/(2*Sqrt[5]), Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[9/20 + 9/(10*Sqrt[5])], 1/(2*Sqrt[5]), Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[5/8 + 11/(8*Sqrt[5])], (-1 - Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 2, 0]}, 
 {-Sqrt[5/8 + 11/(8*Sqrt[5])], (1 + Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 2, 0]}, 
 {Sqrt[5/8 + 11/(8*Sqrt[5])], (-1 - Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 3, 0]}, 
 {Sqrt[5/8 + 11/(8*Sqrt[5])], (1 + Sqrt[5])/4, Root[1 - 20*#1^2 + 80*#1^4 & , 3, 0]}, 
 {-Sqrt[13/8 + 29/(8*Sqrt[5])], (-3 - Sqrt[5])/4, Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {-Sqrt[13/8 + 29/(8*Sqrt[5])], (3 + Sqrt[5])/4, Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {Sqrt[13/8 + 29/(8*Sqrt[5])], (-3 - Sqrt[5])/4, -Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {Sqrt[13/8 + 29/(8*Sqrt[5])], (3 + Sqrt[5])/4, -Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {-Sqrt[5/2 + 11/(2*Sqrt[5])], 0, -Sqrt[5/8 + 11/(8*Sqrt[5])]}, 
 {Sqrt[5/2 + 11/(2*Sqrt[5])], 0, Sqrt[5/8 + 11/(8*Sqrt[5])]}, {-Sqrt[5 - 2*Sqrt[5]]/10, (-5 - 2*Sqrt[5])/10, 
  -Sqrt[(5 - Sqrt[5])/2]/10}, {-Sqrt[5 - 2*Sqrt[5]]/10, (5 + 2*Sqrt[5])/10, -Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[5 - 2*Sqrt[5]]/10, (-5 - 2*Sqrt[5])/10, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {Sqrt[5 - 2*Sqrt[5]]/10, (5 + 2*Sqrt[5])/10, Sqrt[(5 - Sqrt[5])/2]/10}, 
 {-Sqrt[(5 - Sqrt[5])/10]/2, (-1 - Sqrt[5])/4, Root[1 - 100*#1^2 + 80*#1^4 & , 4, 0]}, 
 {-Sqrt[(5 - Sqrt[5])/10]/2, (1 + Sqrt[5])/4, Root[1 - 100*#1^2 + 80*#1^4 & , 4, 0]}, 
 {Sqrt[(5 - Sqrt[5])/10]/2, (-1 - Sqrt[5])/4, Root[1 - 100*#1^2 + 80*#1^4 & , 1, 0]}, 
 {Sqrt[(5 - Sqrt[5])/10]/2, (1 + Sqrt[5])/4, Root[1 - 100*#1^2 + 80*#1^4 & , 1, 0]}, 
 {-Sqrt[(5 - Sqrt[5])/2]/10, (-5 - Sqrt[5])/20, -Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {-Sqrt[(5 - Sqrt[5])/2]/10, (-1 - Sqrt[5])/4, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[(5 - Sqrt[5])/2]/10, (1 + Sqrt[5])/4, Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {-Sqrt[(5 - Sqrt[5])/2]/10, (5 + Sqrt[5])/20, -Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {Sqrt[(5 - Sqrt[5])/2]/10, (-5 - Sqrt[5])/20, Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {Sqrt[(5 - Sqrt[5])/2]/10, (-1 - Sqrt[5])/4, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[(5 - Sqrt[5])/2]/10, (1 + Sqrt[5])/4, -Sqrt[1/8 + 11/(40*Sqrt[5])]}, 
 {Sqrt[(5 - Sqrt[5])/2]/10, (5 + Sqrt[5])/20, Sqrt[17/40 + 31/(40*Sqrt[5])]}, 
 {-Sqrt[(5 + 2*Sqrt[5])/5], 0, Root[1 - 20*#1^2 + 80*#1^4 & , 3, 0]}, 
 {Sqrt[(5 + 2*Sqrt[5])/5], 0, Root[1 - 20*#1^2 + 80*#1^4 & , 2, 0]}}

(* Great Stellated Dodecahedron *)

PolyhedronName[GreatStellatedDodecahedron]:="great stellated dodecahedron"
PolyhedronDual[GreatStellatedDodecahedron]:=GreatIcosahedron

PolyhedronFaces[GreatStellatedDodecahedron]:=
{{4,3,6,1,5},{7,10,5,1,13},{8,13,1,6,9},{11,15,2,16,18},{12,17,16,2,14},{20,
    14,2,15,19},{4,3,18,16,17},{11,18,3,6,9},{12,10,5,4,17},{20,7,13,8,
    19},{12,10,7,20,14},{11,15,19,8,9}}
PolyhedronVertices[GreatStellatedDodecahedron]:=
{{0,0,Sqrt[9/8+(3Sqrt[5])/8]},{0,0,-Sqrt[(3(3+Sqrt[5]))/2]/2},
 {Sqrt[1/8-Sqrt[5]/24],(-3-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[1/8-Sqrt[5]/24],(3+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {Sqrt[5/8+(5Sqrt[5])/24],(-1-Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[5/8+(5Sqrt[5])/24],(1+Sqrt[5])/4,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],-1/2,Sqrt[1/8+Sqrt[5]/24]},
 {-Sqrt[3/4+Sqrt[5]/3],1/2,Sqrt[1/8+Sqrt[5]/24]},
 {Sqrt[3/4+Sqrt[5]/3],-1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {Sqrt[3/4+Sqrt[5]/3],1/2,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(3+Sqrt[5])/6],0,-Sqrt[(5(3+Sqrt[5]))/6]/2},
 {-Sqrt[(3+Sqrt[5])/6]/2,(-1-Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[(3+Sqrt[5])/6]/2,(1+Sqrt[5])/4,Sqrt[5/8+(5Sqrt[5])/24]},
 {Sqrt[(3+Sqrt[5])/6],0,Sqrt[5/8+(5Sqrt[5])/24]},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(-1-Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {-Sqrt[(5(3+Sqrt[5]))/6]/2,(1+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2},
 {Root[1-36#1^2+144#1^4&,2,0],(-3-Sqrt[5])/4,
  -Sqrt[(3+Sqrt[5])/6]/2},{Root[1-36#1^2+144#1^4&,2,0],
  (3+Sqrt[5])/4,-Sqrt[(3+Sqrt[5])/6]/2}}

PolyhedronFaces[GreatStellatedDodecahedron,Split->True]:=
{{24,2,8},{24,8,10},{24,10,2},{13,2,10},{13,10,9},{13,9,2},{23,2,9},{23,9,
    7},{23,7,2},{19,2,7},{19,7,4},{19,4,2},{20,2,4},{20,4,8},{20,8,2},{27,11,
    5},{27,5,1},{27,1,11},{14,12,11},{14,11,1},{14,1,12},{28,6,12},{28,12,
    1},{28,1,6},{18,3,6},{18,6,1},{18,1,3},{17,5,3},{17,3,1},{17,1,5},{22,8,
    6},{22,6,10},{22,10,8},{15,10,3},{15,3,9},{15,9,10},{21,9,5},{21,5,7},{21,
    7,9},{26,7,11},{26,11,4},{26,4,7},{25,4,12},{25,12,8},{25,8,4},{31,11,
    7},{31,7,5},{31,5,11},{16,12,4},{16,4,11},{16,11,12},{32,6,8},{32,8,
    12},{32,12,6},{29,3,10},{29,10,6},{29,6,3},{30,5,9},{30,9,3},{30,3,5}}
PolyhedronVertices[GreatStellatedDodecahedron,Split->True]:=
{{0,0,-5/Sqrt[50-10Sqrt[5]]},{0,0,5/Sqrt[50-10Sqrt[5]]},{Root[1-5#1^2+5#1^4&,1,0],0,
  -(1/Sqrt[10-2Sqrt[5]])},{Sqrt[(5+Sqrt[5])/10],0,1/Sqrt[10-2Sqrt[5]]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,1/Sqrt[10-2Sqrt[5]]},{-Sqrt[1+2/Sqrt[5]]/2,1/2,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,-(1/Sqrt[10-2Sqrt[5]])},{Sqrt[1/4+1/(2Sqrt[5])],1/2,
  -(1/Sqrt[10-2Sqrt[5]])},{-Sqrt[1+2/Sqrt[5]],0,Sqrt[13/8+29/(8Sqrt[5])]},
 {Sqrt[1+2/Sqrt[5]],0,Root[1-260#1^2+80#1^4&,1,0]},{Root[1-25#1^2+5#1^4&,1,0],0,
  Sqrt[1/8+1/(8Sqrt[5])]},{Sqrt[5/2+11/(2Sqrt[5])],0,Root[1-20#1^2+80#1^4&,1,0]},
 {-Sqrt[10+22/Sqrt[5]]/4,(-1-Sqrt[5])/4,Root[1-260#1^2+80#1^4&,1,0]},
 {-Sqrt[10+22/Sqrt[5]]/4,(1+Sqrt[5])/4,Root[1-260#1^2+80#1^4&,1,0]},
 {Sqrt[10+22/Sqrt[5]]/4,(-1-Sqrt[5])/4,Sqrt[13/8+29/(8Sqrt[5])]},
 {Sqrt[10+22/Sqrt[5]]/4,(1+Sqrt[5])/4,Sqrt[13/8+29/(8Sqrt[5])]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1-Sqrt[5]/2,1/Sqrt[10-2Sqrt[5]]},{-Sqrt[1+2/Sqrt[5]]/2,(2+Sqrt[5])/2,
  1/Sqrt[10-2Sqrt[5]]},{Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Sqrt[13/8+29/(8Sqrt[5])]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Sqrt[13/8+29/(8Sqrt[5])]},
 {Sqrt[13/8+29/(8Sqrt[5])],(3+Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {Sqrt[13/8+29/(8Sqrt[5])],(-3-Sqrt[5])/4,1/Sqrt[10-2Sqrt[5]]},
 {((3+Sqrt[5])/10)^(1/4)/2,(-3-Sqrt[5])/4,Root[1-260#1^2+80#1^4&,1,0]},
 {((3+Sqrt[5])/10)^(1/4)/2,(3+Sqrt[5])/4,Root[1-260#1^2+80#1^4&,1,0]},
 {Root[1-260#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Root[1-260#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/4+1/(2Sqrt[5])],-1-Sqrt[5]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[1/4+1/(2Sqrt[5])],(2+Sqrt[5])/2,-(1/Sqrt[10-2Sqrt[5]])}}

(* Icosahedron *)

PolyhedronName[Icosahedron]:="icosahedron"
PolyhedronDual[Icosahedron]:=Dodecahedron
NetFaces[Icosahedron]:={{1,6,7},{6,12,13},{2,7,8},{7,13,14},{3,8,9},{8,14,15},{4,9,10},{9,15,16},{5,10,11},{10,16,17},{13,7,6},{18,13,12},{14,8,7},{19,14,13},{15,9,8},{20,15,14},{16,10,9},{21,16,15},{17,11,10},{22,17,16}}
NetVertices[Icosahedron]:={{-(1/Sqrt[3]),0},{-(1/Sqrt[3]),1},{-(1/Sqrt[3]),2},{-(1/Sqrt[3]),3},{-(1/Sqrt[3]),4},{1/(2Sqrt[3]),-1/2},{1/(2Sqrt[3]),1/2},{1/(2Sqrt[3]),3/2},{1/(2Sqrt[3]),5/2},{1/(2Sqrt[3]),7/2},{1/(2Sqrt[3]),9/2},{2/Sqrt[3],-1},{2/Sqrt[3],0},{2/Sqrt[3],1},{2/Sqrt[3],2},{2/Sqrt[3],3},{2/Sqrt[3],4},{7/(2Sqrt[3]),-1/2},{7/(2Sqrt[3]),1/2},{7/(2Sqrt[3]),3/2},{7/(2Sqrt[3]),5/2},{7/(2Sqrt[3]),7/2}}
PolyhedronPolyhedra[Icosahedron]:={Range[20]}
PolyhedronFaces[Icosahedron]:=PolyhedronFaces[Icosahedron,"C5"]
PolyhedronVertices[Icosahedron]:=PolyhedronVertices[Icosahedron,"C5"]

(* Icosahedron C2 *)

PolyhedronName[Icosahedron,"C2"]:="icosahedron oriented with the z-axis along a C2 symmetry \
axis"
PolyhedronDual[Icosahedron,"C2"]:=Sequence[Dodecahedron,"C2"]
PolyhedronPolyhedra[Icosahedron,"C2"]:={Range[20]}
PolyhedronFaces[Icosahedron,"C2"]:=
{{2,6,10},{2,10,9},{2,9,4},{2,4,8},{2,
8,6},{11,3,7},{12,11,7},{5,12,7},{1,5,7},{3,1,7},{6,5,10},{
10,1,9},{9,3,4},{4,11,8},{8,12,6},{11,4,3},{12,8,11},{
5,6,12},{1,10,5},{3,9,1}}
PolyhedronVertices[Icosahedron,"C2"]:=
{{-1/2,0,(-1-Sqrt[5])/4},{-1/2,0,(1+Sqrt[5])/4},
{0,(-1-Sqrt[5])/4,-1/2},{0,(-1-Sqrt[5])/4,1/2},
{0,(1+Sqrt[5])/4,-1/2},{0,(1+Sqrt[5])/4,1/2},
{1/2,0,(-1-Sqrt[5])/4},{1/2,0,(1+Sqrt[5])/4},
{(-1-Sqrt[5])/4,-1/2,0},{(-1-Sqrt[5])/4,1/2,0},
{(1+Sqrt[5])/4,-1/2,0},{(1+Sqrt[5])/4,1/2,0}}

(* Icosahedron C3 *)

PolyhedronName[Icosahedron,"C3"]:="icosahedron oriented with the z-axis along a C3 symmetry \
axis"
PolyhedronDual[Icosahedron,"C3"]:=Sequence[Dodecahedron,"C5"]
PolyhedronPolyhedra[Icosahedron,"C3"]:={Range[20]}
PolyhedronFaces[Icosahedron,"C3"]:=
{{6,3,2},{2,3,11},{6,2,9},{3,6,10},{9,12,6},{6,12,10},{10,8,3},{3,8,11},{11,7,
    2},{2,7,9},{5,4,1},{12,4,5},{8,5,1},{7,1,4},{1,11,8},{7,11,1},{4,9,7},{12,
    9,4},{5,10,12},{8,10,5}}
PolyhedronVertices[Icosahedron,"C3"]:=
{{-(1/Sqrt[3]),0,-Sqrt[7/24+Sqrt[5]/8]},{-1/(2Sqrt[3]),-1/2,Sqrt[7/24+Sqrt[5]/8]},
 {-1/(2Sqrt[3]),1/2,Sqrt[7/24+Sqrt[5]/8]},{1/(2Sqrt[3]),-1/2,-Sqrt[7/24+Sqrt[5]/8]},
 {1/(2Sqrt[3]),1/2,-Sqrt[7/24+Sqrt[5]/8]},{1/Sqrt[3],0,Sqrt[7/24+Sqrt[5]/8]},
 {-Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,-Sqrt[1/8-Sqrt[5]/24]},
 {-Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,-Sqrt[1/8-Sqrt[5]/24]},
 {Sqrt[1/8+Sqrt[5]/24],(-1-Sqrt[5])/4,Sqrt[1/8-Sqrt[5]/24]},
 {Sqrt[1/8+Sqrt[5]/24],(1+Sqrt[5])/4,Sqrt[1/8-Sqrt[5]/24]},
 {-Sqrt[1/2+Sqrt[5]/6],0,Sqrt[1/8-Sqrt[5]/24]},{Sqrt[1/2+Sqrt[5]/6],0,-Sqrt[1/8-Sqrt[5]/24]}}

(* Icosahedron C5 *)

PolyhedronName[Icosahedron,"C5"]:="icosahedron oriented with the z-axis along a C5 symmetry \
axis"
PolyhedronDual[Icosahedron,"C5"]:=Sequence[Dodecahedron,"C3"]
PolyhedronPolyhedra[Icosahedron,"C5"]:={Range[20]}
PolyhedronFaces[Icosahedron,"C5"]:={{2,12,8},{2,8,7},{2,7,11},{2,11,4},{2,4,12},{5,9,1},{6,5,1},{10,6,1},{3,10,
    1},{9,3,1},{12,10,8},{8,3,7},{7,9,11},{11,5,4},{4,6,12},{5,11,9},{6,4,
    5},{10,12,6},{3,8,10},{9,7,3}}
PolyhedronVertices[Icosahedron,"C5"]:={{0,0,-5/Sqrt[50-10Sqrt[5]]},
 {0,0,5/Sqrt[50-10Sqrt[5]]},
 {-Sqrt[2/(5-Sqrt[5])],0,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[2/(5-Sqrt[5])],0,1/Sqrt[10-2Sqrt[5]]},
 {(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-1/2, -(1/Sqrt[10-2Sqrt[5]])},
 {(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),1/2,-(1/Sqrt[10-2Sqrt[5]])},
 {-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-1/2,1/Sqrt[10-2Sqrt[5]]},
 {-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),1/2,1/Sqrt[10-2Sqrt[5]]},
 {-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2, 1/Sqrt[10-2Sqrt[5]]},
 {(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,1/Sqrt[10-2Sqrt[5]]}}

(* Icosahedron 2-Compound *)

(* Icosahedron 5-Compound *)

PolyhedronName[Icosahedron5Compound]:="5-icosahedron compound"
PolyhedronDual[Icosahedron5Compound]:=Dodecahedron5Compound
PolyhedronPolyhedra[Icosahedron5Compound]:=
{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},{21,22,23,24,25,26,27,
    28,29,30,31,32,33,34,35,36,37,38,39,40},{41,42,43,44,45,46,47,48,49,50,51,
    52,53,54,55,56,57,58,59,60},{61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,
    76,77,78,79,80},{81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,
    100}}
PolyhedronFaces[Icosahedron5Compound]:=
{{21,28,29},{28,22,27},{26,27,23},{24,30,26},{30,25,29},{60,27,26},{29,28,
    60},{30,60,26},{27,60,28},{60,30,29},{21,59,22},{24,23,59},{21,25,59},{22,
    59,23},{59,25,24},{23,24,26},{22,23,27},{21,22,28},{29,25,21},{30,24,
    25},{17,31,11},{6,34,16},{6,51,41},{16,34,54},{41,51,17},{6,41,34},{54,50,
    11},{41,17,50},{50,54,34},{34,41,50},{31,38,11},{31,17,51},{38,47,16},{38,
    31,47},{11,50,17},{6,47,51},{16,47,6},{51,47,31},{54,38,16},{38,54,
    11},{15,12,40},{57,5,3},{18,5,57},{2,46,12},{18,46,2},{3,40,57},{46,40,
    12},{18,57,46},{56,43,35},{3,43,15},{46,57,40},{56,12,15},{43,56,15},{18,
    2,35},{40,3,15},{43,5,35},{12,56,2},{35,5,18},{35,2,56},{43,3,5},{39,9,
    14},{8,58,4},{19,58,8},{9,45,1},{1,45,19},{39,4,58},{9,39,45},{19,45,
    58},{44,55,36},{14,44,4},{58,45,39},{9,55,14},{55,44,14},{19,36,1},{4,39,
    14},{36,8,44},{55,9,1},{19,8,36},{1,36,55},{8,4,44},{32,20,10},{7,13,
    33},{7,42,52},{33,13,53},{52,42,20},{33,42,7},{49,53,10},{49,20,42},{53,
    49,33},{49,42,33},{10,37,32},{20,32,52},{13,48,37},{48,32,37},{20,49,
    10},{7,52,48},{7,48,13},{48,52,32},{37,53,13},{53,37,10}}
PolyhedronVertices[Icosahedron5Compound]:=
{{-Sqrt[1/16-1/(8Sqrt[5])],(-2-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/16-1/(8Sqrt[5])],(2+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/16-1/(8Sqrt[5])],(-2-Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/16-1/(8Sqrt[5])],(2+Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/32+1/(32Sqrt[5])],(-5-3Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[1/32+1/(32Sqrt[5])],(-3-Sqrt[5])/8,Sqrt[(5+2Sqrt[5])/5]},
 {-Sqrt[1/32+1/(32Sqrt[5])],(3+Sqrt[5])/8,Sqrt[(5+2Sqrt[5])/5]},
 {-Sqrt[1/32+1/(32Sqrt[5])],(5+3Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/32+1/(32Sqrt[5])],(-5-3Sqrt[5])/8,-Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/32+1/(32Sqrt[5])],(-3-Sqrt[5])/8,-Sqrt[(5+2Sqrt[5])/5]},
 {Sqrt[1/32+1/(32Sqrt[5])],(3+Sqrt[5])/8,-Sqrt[(5+2Sqrt[5])/5]},
 {Sqrt[1/32+1/(32Sqrt[5])],(5+3Sqrt[5])/8,-Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[5/32+11/(32Sqrt[5])],(-5-Sqrt[5])/8,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[5/32+11/(32Sqrt[5])],(-1-Sqrt[5])/8,-Sqrt[(5+2Sqrt[5])/5]},
 {-Sqrt[5/32+11/(32Sqrt[5])],(1+Sqrt[5])/8,-Sqrt[(5+2Sqrt[5])/5]},
 {-Sqrt[5/32+11/(32Sqrt[5])],(5+Sqrt[5])/8,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[5/32+11/(32Sqrt[5])],(-5-Sqrt[5])/8,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[5/32+11/(32Sqrt[5])],(-1-Sqrt[5])/8,Sqrt[(5+2Sqrt[5])/5]},
 {Sqrt[5/32+11/(32Sqrt[5])],(1+Sqrt[5])/8,Sqrt[(5+2Sqrt[5])/5]},
 {Sqrt[5/32+11/(32Sqrt[5])],(5+Sqrt[5])/8,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],0,Sqrt[(5+2Sqrt[5])/5]},
 {-Sqrt[1/4+1/(2Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1/4+1/(2Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],0,-Sqrt[(5+2Sqrt[5])/5]},
 {Sqrt[1/4+1/(2Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[17/32+31/(32Sqrt[5])],(-1-Sqrt[5])/8,-Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[17/32+31/(32Sqrt[5])],(1+Sqrt[5])/8,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[17/32+31/(32Sqrt[5])],(-1-Sqrt[5])/8,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[17/32+31/(32Sqrt[5])],(1+Sqrt[5])/8,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[9/16+9/(8Sqrt[5])],-1/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[9/16+9/(8Sqrt[5])],1/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[9/16+9/(8Sqrt[5])],(-2-Sqrt[5])/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[9/16+9/(8Sqrt[5])],(2+Sqrt[5])/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[9/16+9/(8Sqrt[5])],-1/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[9/16+9/(8Sqrt[5])],1/4,-Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[9/16+9/(8Sqrt[5])],(-2-Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[9/16+9/(8Sqrt[5])],(2+Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[29/32+61/(32Sqrt[5])],(-3-Sqrt[5])/8,-Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[29/32+61/(32Sqrt[5])],(3+Sqrt[5])/8,-Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[29/32+61/(32Sqrt[5])],(-3-Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[29/32+61/(32Sqrt[5])],(3+Sqrt[5])/8,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[17/16+19/(8Sqrt[5])],-1/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[17/16+19/(8Sqrt[5])],1/4,Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[17/16+19/(8Sqrt[5])],-1/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {Sqrt[17/16+19/(8Sqrt[5])],1/4,-Sqrt[1/8+1/(8Sqrt[5])]},
 {-Sqrt[5/32+Sqrt[5]/32],(-5-3Sqrt[5])/8,0},
 {-Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,0},{Sqrt[5/32+Sqrt[5]/32],
  (-5-3Sqrt[5])/8,0},{Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,0},
 {-Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,0},
 {-Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,0},
 {Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,0},
 {Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,0},{-Sqrt[5/4+Sqrt[5]/2],0,0},
 {Sqrt[5/4+Sqrt[5]/2],0,0}}

(* Icosahedron 6-Compound *)

PolyhedronName[Icosahedron6Compound]:="6-icosahedron compound"
PolyhedronDual[Icosahedron6Compound]:=Dodecahedron6Compound
PolyhedronPolyhedra[Icosahedron6Compound]:=
{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},{21,22,23,24,25,26,27,
    28,29,30,31,32,33,34,35,36,37,38,39,40},{41,42,43,44,45,46,47,48,49,50,51,
    52,53,54,55,56,57,58,59,60},{61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,
    76,77,78,79,80},{81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,
    100},{101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,
    118,119,120}}
PolyhedronFaces[Icosahedron6Compound]:=
{{2,52,24},{2,26,54},{55,19,1},{21,57,1},{24,52,19},{54,26,21},{19,55,24},{57,
    21,26},{1,19,69},{69,21,1},{2,24,72},{72,26,2},{2,54,52},{57,55,1},{52,69,
    19},{21,69,54},{72,24,55},{57,26,72},{52,54,69},{55,57,72},{15,43,23},{14,
    22,50},{14,40,31},{34,37,15},{34,22,37},{40,23,31},{15,37,43},{40,14,
    50},{31,23,43},{50,22,34},{14,66,22},{67,15,23},{37,22,66},{23,40,67},{66,
    14,31},{34,15,67},{66,43,37},{50,67,40},{43,66,31},{34,67,50},{4,35,
    39},{42,38,5},{8,39,35},{9,38,42},{59,9,8},{5,4,60},{5,70,4},{9,71,8},{35,
    59,8},{9,59,38},{60,4,39},{5,60,42},{4,70,35},{5,38,70},{71,39,8},{71,9,
    42},{59,35,70},{70,38,59},{39,71,60},{42,60,71},{25,46,18},{20,11,47},{11,
    32,41},{36,33,18},{36,20,33},{32,25,41},{18,46,36},{41,47,11},{25,32,
    46},{33,20,47},{20,65,11},{68,25,18},{36,65,20},{25,68,41},{32,11,65},{18,
    33,68},{36,46,65},{68,47,41},{65,46,32},{47,68,33},{53,10,17},{12,3,
    56},{10,45,30},{3,27,48},{30,45,12},{17,48,27},{27,53,17},{12,56,30},{10,
    53,45},{56,3,48},{12,61,3},{10,64,17},{3,61,27},{64,10,30},{12,45,61},{64,
    48,17},{53,27,61},{30,56,64},{61,45,53},{48,64,56},{7,51,16},{6,13,
    58},{29,44,7},{6,49,28},{29,13,44},{49,16,28},{28,16,51},{58,13,29},{7,44,
    51},{49,6,58},{6,62,13},{63,7,16},{62,6,28},{29,7,63},{44,13,62},{16,49,
    63},{51,62,28},{29,63,58},{62,51,44},{58,63,49}}
PolyhedronVertices[Icosahedron6Compound]:=
{{0,0,-Sqrt[5/4+Sqrt[5]/2]},{0,0,Sqrt[5/4+Sqrt[5]/2]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(-15-7Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(1+Sqrt[5])/4,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[1/40-1/(40Sqrt[5])],(15+7Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(-15-7Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[1/40-1/(40Sqrt[5])],(15+7Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[1/10+1/(10Sqrt[5])],(-5-3Sqrt[5])/10,-Sqrt[9/20+9/(10Sqrt[5])]},
 {-Sqrt[1/10+1/(10Sqrt[5])],(-5-Sqrt[5])/10,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[1/10+1/(10Sqrt[5])],(5+Sqrt[5])/10,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[1/10+1/(10Sqrt[5])],(5+3Sqrt[5])/10,-Sqrt[9/20+9/(10Sqrt[5])]},
 {Sqrt[1/10+1/(10Sqrt[5])],(-5-3Sqrt[5])/10,Sqrt[9/20+9/(10Sqrt[5])]},
 {Sqrt[1/10+1/(10Sqrt[5])],(-5-Sqrt[5])/10,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[1/10+1/(10Sqrt[5])],(5+Sqrt[5])/10,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[1/10+1/(10Sqrt[5])],(5+3Sqrt[5])/10,Sqrt[9/20+9/(10Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[9/40+9/(40Sqrt[5])],(-5-3Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[9/40+9/(40Sqrt[5])],(5+3Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[9/40+9/(40Sqrt[5])],(-5-3Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[9/40+9/(40Sqrt[5])],(5+3Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[13/40+19/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[13/40+19/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(-3-Sqrt[5])/4,-Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(5-Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(-5+Sqrt[5])/20,Sqrt[17/20+19/(10Sqrt[5])]},
 {-Sqrt[13/40+29/(40Sqrt[5])],(3+Sqrt[5])/4,-Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(5-Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(-5+Sqrt[5])/20,-Sqrt[17/20+19/(10Sqrt[5])]},
 {Sqrt[13/40+29/(40Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],(-5-3Sqrt[5])/10,Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],(-5-Sqrt[5])/10,Sqrt[9/20+9/(10Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],(5+Sqrt[5])/10,Sqrt[9/20+9/(10Sqrt[5])]},
 {-Sqrt[1/2+11/(10Sqrt[5])],(5+3Sqrt[5])/10,Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],(-5-3Sqrt[5])/10,-Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],(-5-Sqrt[5])/10,-Sqrt[9/20+9/(10Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],(5+Sqrt[5])/10,-Sqrt[9/20+9/(10Sqrt[5])]},
 {Sqrt[1/2+11/(10Sqrt[5])],(5+3Sqrt[5])/10,-Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[4/5+8/(5Sqrt[5])],0,-Sqrt[9/20+9/(10Sqrt[5])]},
 {Sqrt[4/5+8/(5Sqrt[5])],0,Sqrt[9/20+9/(10Sqrt[5])]},
 {-Sqrt[41/40+89/(40Sqrt[5])],(-5-3Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[41/40+89/(40Sqrt[5])],(5+3Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[41/40+89/(40Sqrt[5])],(-5-3Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[41/40+89/(40Sqrt[5])],(5+3Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[9/8+99/(40Sqrt[5])],(-5-Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[9/8+99/(40Sqrt[5])],(5+Sqrt[5])/20,-Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[9/8+99/(40Sqrt[5])],(-5-Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {Sqrt[9/8+99/(40Sqrt[5])],(5+Sqrt[5])/20,Sqrt[1/20-1/(10Sqrt[5])]},
 {-Sqrt[(5+2Sqrt[5])/5],0,-Sqrt[1/4+1/(2Sqrt[5])]},
 {-Sqrt[(5+2Sqrt[5])/5],0,Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[(5+2Sqrt[5])/5],0,-Sqrt[1/4+1/(2Sqrt[5])]},
 {Sqrt[(5+2Sqrt[5])/5],0,Sqrt[1/4+1/(2Sqrt[5])]}}

(* Kepler-Poinsot Solids *)

KeplerPoinsotSolids:={GreatDodecahedron,GreatIcosahedron,
    GreatStellatedDodecahedron,SmallStellatedDodecahedron}

(* Octahedron *)

PolyhedronName[Octahedron]:="octahedron"
PolyhedronDual[Octahedron]:=Cube
NetFaces[Octahedron]:={{2,6,7},{2,7,3},{3,7,8},{7,10,8},{1,3,4},{3,8,4},{4,8,9},{4,9,5}}
NetVertices[Octahedron]:={{-5/(2Sqrt[3]),3/2},{-(1/Sqrt[3]),0},{-(1/Sqrt[3]),1},{-(1/Sqrt[3]),2},{-(1/Sqrt[3]),3},{1/(2Sqrt[3]),-1/2},{1/(2Sqrt[3]),1/2},{1/(2Sqrt[3]),3/2},{1/(2Sqrt[3]),5/2},{2/Sqrt[3],1}}
PolyhedronPolyhedra[Octahedron]:={Range[8]}
PolyhedronFaces[Octahedron]:=PolyhedronFaces[Octahedron,"C4Square"]
PolyhedronVertices[Octahedron]:=PolyhedronVertices[Octahedron,"C4Square"]

(* Octahedron C3 *)

PolyhedronName[Octahedron,"C3"]:="octahedron oriented with z-axis along a C3 \
symmetry axis"
PolyhedronDual[Octahedron,"C3"]:=Sequence[Cube,"C3"]
PolyhedronPolyhedra[Octahedron,"C3"]:={Range[8]}
PolyhedronFaces[Octahedron,"C3"]:={{4,1,5},{6,3,2},{5,3,6},{1,2,3},{4,6,2},{5,1,3},{1,4,2},{4,5,6}}
PolyhedronVertices[Octahedron,"C3"]:={{-(1/Sqrt[3]),0,-(1/Sqrt[6])},{-1/(2Sqrt[3]),-1/2,
  1/Sqrt[6]},{-1/(2Sqrt[3]),1/2,1/Sqrt[6]},
 {1/(2Sqrt[3]),-1/2,-(1/Sqrt[6])},{1/(2Sqrt[3]),1/2,-(1/Sqrt[6])},
 {1/Sqrt[3],0,1/Sqrt[6]}}

(* Octahedron C4 Diamond *)

PolyhedronName[Octahedron,"C4Diamond"]:="octahedron oriented with z-axis along a C4 \
symmetry axis and midplane projected onto the xy-plane a diamond"
(*
PolyhedronDual[Octahedron,"C4Diamond"]:=Sequence[Cube,"C4"]
*)
PolyhedronPolyhedra[Octahedron,"C4Diamond"]:={Range[8]}
PolyhedronFaces[Octahedron,"C4Diamond"]:=
{{2,6,4},{2,4,5},{2,5,3},{2,3,6},{6,3,1},{6,1,4},{1,3,5},{4,1,5}}
PolyhedronVertices[Octahedron,"C4Diamond"]:=
{{0,0,-1},{0,0,1},{0,-1,0},{0,1,0},{-1,0,0},{1,0,0}}/Sqrt[2]
 
(* Octahedron C4 Square *)

PolyhedronName[Octahedron,"C4Square"]:="octahedron oriented with z-axis along a C4 \
symmetry axis and midplane projected onto the xy-plane a square"
(*
PolyhedronDual[Octahedron,"C4Square"]:=Sequence[Cube,"C4"]
*)
PolyhedronPolyhedra[Octahedron,"C4Square"]:={Range[8]}
PolyhedronFaces[Octahedron,"C4Square"]:=
{{4,5,6},{4,6,2},{4,2,1},{4,1,5},{5,1,3},{5,3,6},{3,1,2},{6,3,2}}
PolyhedronVertices[Octahedron,"C4Square"]:=
{{-1/2,-1/2,0},{-1/2,1/2,0},{0,0,-(1/Sqrt[2])},
 {0,0,1/Sqrt[2]},{1/2,-1/2,0},{1/2,1/2,0}}

(* Octahedron 2-Compound C3 *)

PolyhedronName[Octahedron2Compound,"C3"]:="octahedron 2-compound"
PolyhedronDual[Octahedron2Compound,"C3"]:=Sequence[Cube2Compound,"C3"]
PolyhedronPolyhedra[Octahedron2Compound,"C3"]:={{1,2,3,4,5,6,7,8},{9,10,11,12,13,14,15,16}}
PolyhedronFaces[Octahedron2Compound,"C3"]:=
{{5,3,9},{8,2,12},{2,5,9},{3,8,12},{2,8,5},{3,5,8},{12,2,9},{9,3,12},{7,11,
    1},{4,6,10},{10,6,1},{11,7,4},{6,7,1},{6,4,7},{1,11,10},{11,4,10}}
PolyhedronVertices[Octahedron2Compound,"C3"]:=
{{0,-2Sqrt[2/3],-2/Sqrt[3]},{0,-2Sqrt[2/3],2/Sqrt[3]},{0,2Sqrt[2/3],-2/Sqrt[3]},
 {0,2Sqrt[2/3],2/Sqrt[3]},{-Sqrt[2],-Sqrt[2/3],-2/Sqrt[3]},{-Sqrt[2],-Sqrt[2/3],2/Sqrt[3]},
 {-Sqrt[2],Sqrt[2/3],-2/Sqrt[3]},{-Sqrt[2],Sqrt[2/3],2/Sqrt[3]},{Sqrt[2],-Sqrt[2/3],-2/Sqrt[3]},
 {Sqrt[2],-Sqrt[2/3],2/Sqrt[3]},{Sqrt[2],Sqrt[2/3],-2/Sqrt[3]},
 {Sqrt[2],Sqrt[2/3],2/Sqrt[3]}}/(2Sqrt[2])

(* Octahedron 2-Compound C4 *)

PolyhedronName[Octahedron2Compound,"C4"]:="octahedron 2-compound"
PolyhedronDual[Octahedron2Compound,"C4"]:=Sequence[Cube2Compound,"C4"]
NetPieces[Octahedron2Compound,"C4"]:={{15,{1,2,3}}}
NetFaces[Octahedron2Compound,"C4"]:={{1,3,4},{1,2,4},{4,5,3},{4,6,2}}
NetVertices[Octahedron2Compound,"C4"]:=
 {{0,0},{1/2-1/Sqrt[2],-Sqrt[3]/2},{1/2-1/Sqrt[2],Sqrt[3]/2},
 {1-1/Sqrt[2],0},{(-3(-2+Sqrt[2]))/4,-(Sqrt[3](-2+Sqrt[2]))/4},
 {(-3(-2+Sqrt[2]))/4,(Sqrt[3](-2+Sqrt[2]))/4}}
PolyhedronPolyhedra[Octahedron2Compound,"C4"]:={{1,2,3,4,5,6,7,8},{9,10,11,12,13,14,15,16}}
PolyhedronFaces[Octahedron2Compound,"C4"]:=
{{4,10,6},{4,6,9},{4,9,5},{4,5,10},{10,5,3},{10,3,6},{3,5,9},{6,3,9},{4,7,
    8},{4,8,2},{4,2,1},{4,1,7},{7,1,3},{7,3,8},{3,1,2},{8,3,2}}
PolyhedronVertices[Octahedron2Compound,"C4"]:=
{{-1/2,-1/2,0},{-1/2,1/2,0},{0,0,-(1/Sqrt[2])},{0,0,1/Sqrt[2]},{0,-(1/Sqrt[2]),0},
 {0,1/Sqrt[2],0},{1/2,-1/2,0},{1/2,1/2,0},{-(1/Sqrt[2]),0,0},{1/Sqrt[2],0,0}}
 
(* Octahedron 3-Compound *)

PolyhedronName[Octahedron3Compound]:="octahedron 3-compound"
PolyhedronDual[Octahedron3Compound]:=Cube3Compound
NetPieces[Octahedron3Compound]:={{6,{1,2,3,4}},{12,{5,6,7,8}}}
NetFaces[Octahedron3Compound]:=
{{9,1,13,3,9},{13,1,14,11,13},{14,1,12,10,14},{12,1,8,2,12},{5,15,4},{5,16,
    4},{5,16,7},{5,15,6}}
NetVertices[Octahedron3Compound]:=
{{0,0},{0,-Sqrt[9/4-3/Sqrt[2]]},{0,Sqrt[9/4-3/Sqrt[2]]},{1,0},{3/2,0},{7/4,-Sqrt[3]/4},
 {7/4,Sqrt[3]/4},{1-Sqrt[2],-Sqrt[3(3-2Sqrt[2])]},{1-Sqrt[2],Sqrt[3(3-2Sqrt[2])]},
 {(3(-1+Sqrt[2]))/4,-Sqrt[9/16-3/(4Sqrt[2])]},
 {(3(-1+Sqrt[2]))/4,Sqrt[9/16-3/(4Sqrt[2])]},{-1+Sqrt[2],-Sqrt[3(3-2Sqrt[2])]},
 {-1+Sqrt[2],Sqrt[3(3-2Sqrt[2])]},{2(-1+Sqrt[2]),0},
 {(1+Sqrt[2])/2,-Sqrt[(3(3-2Sqrt[2]))/2]},{(1+Sqrt[2])/2,Sqrt[(3(3-2Sqrt[2]))/2]}}/Sqrt[2]
PolyhedronPolyhedra[Octahedron3Compound]:=
{{1,2,3,4,5,6,7,8},{9,10,11,12,13,14,15,16},{17,18,19,20,21,22,23,24}}
PolyhedronFaces[Octahedron3Compound]:=
{{6,1,8},{9,1,7},{1,6,7},{9,8,1},{6,8,10},{7,10,9},{7,6,10},{9,10,8},{11,15,
    2},{2,16,12},{15,11,5},{12,16,5},{12,11,2},{12,5,11},{2,15,16},{15,5,
    16},{13,3,17},{13,17,4},{3,14,18},{4,18,14},{14,3,13},{4,14,13},{3,18,
    17},{4,17,18}}
PolyhedronVertices[Octahedron3Compound]:=
{{-1,0,0},{0,-1,0},{0,0,-1},{0,0,1},{0,1,0},
 {0,-(1/Sqrt[2]),-(1/Sqrt[2])},{0,-(1/Sqrt[2]),
  1/Sqrt[2]},{0,1/Sqrt[2],-(1/Sqrt[2])},
 {0,1/Sqrt[2],1/Sqrt[2]},{1,0,0},
 {-(1/Sqrt[2]),0,-(1/Sqrt[2])},{-(1/Sqrt[2]),0,
  1/Sqrt[2]},{-(1/Sqrt[2]),-(1/Sqrt[2]),0},
 {-(1/Sqrt[2]),1/Sqrt[2],0},{1/Sqrt[2],0,
  -(1/Sqrt[2])},{1/Sqrt[2],0,1/Sqrt[2]},
 {1/Sqrt[2],-(1/Sqrt[2]),0},{1/Sqrt[2],1/Sqrt[2],0}}/Sqrt[2]

(* Octahedron 4-Compound *)

PolyhedronName[Octahedron4Compound]:="octahedron 4-compound"
PolyhedronDual[Octahedron4Compound]:=Cube4Compound
NetPieces[Octahedron4Compound]:={{24,{1,2}},{24,{3,4,5,6}}}
NetFaces[Octahedron4Compound]:=
{{1,4,5},{1,3,5},{2,8,9},{2,8,7,6},{9,8,11,12},{8,10,13,11}}
NetVertices[Octahedron4Compound]:=
{{0,0},{3/4,-1/4},{1/(3Sqrt[2]),-Sqrt[3/2]/5},{1/(3Sqrt[2]),1/(5Sqrt[6])},{Sqrt[2]/3,0},
 {(45-8Sqrt[2])/60,(-15+4Sqrt[6])/60},{(45-2Sqrt[2])/60,(-3+2Sqrt[6])/12},
 {(9+2Sqrt[2])/12,(-3+2Sqrt[6])/12},{(9+4Sqrt[2])/12,-1/4},
 {(45+16Sqrt[2])/60,(-15+16Sqrt[6])/60},{(45+22Sqrt[2])/60,(-3+2Sqrt[6])/12},
 {(45+28Sqrt[2])/60,(-15+4Sqrt[6])/60},{(63+32Sqrt[2])/84,(-21+20Sqrt[6])/84}}/Sqrt[2]
PolyhedronPolyhedra[Octahedron4Compound]:=
{{1,2,3,4,5,6,7,8},{9,10,11,12,13,14,15,16},{17,18,19,20,21,22,23,24},{25,26,
    27,28,29,30,31,32}}
PolyhedronFaces[Octahedron4Compound]:=
{{12,5,2},{5,13,2},{2,20,12},{12,23,5},{2,13,20},{13,5,23},{12,20,23},{13,23,
    20},{8,3,10},{15,3,8},{3,17,10},{8,10,22},{3,15,17},{22,15,8},{22,10,
    17},{22,17,15},{4,7,9},{4,16,7},{4,9,18},{21,9,7},{18,16,4},{21,7,16},{9,
    21,18},{18,21,16},{11,1,6},{14,6,1},{11,19,1},{24,11,6},{14,1,19},{24,6,
    14},{19,11,24},{14,19,24}}
PolyhedronVertices[Octahedron4Compound]:=
{{-2/3,-2/3,-1/3},{-2/3,-2/3,1/3},
 {-2/3,-1/3,-2/3},{-2/3,-1/3,2/3},{-2/3,1/3,-2/3},
 {-2/3,1/3,2/3},{-2/3,2/3,-1/3},{-2/3,2/3,1/3},
 {-1/3,-2/3,-2/3},{-1/3,-2/3,2/3},{-1/3,2/3,-2/3},
 {-1/3,2/3,2/3},{1/3,-2/3,-2/3},{1/3,-2/3,2/3},
 {1/3,2/3,-2/3},{1/3,2/3,2/3},{2/3,-2/3,-1/3},
 {2/3,-2/3,1/3},{2/3,-1/3,-2/3},{2/3,-1/3,2/3},
 {2/3,1/3,-2/3},{2/3,1/3,2/3},{2/3,2/3,-1/3},
 {2/3,2/3,1/3}}

(* Octahedron 5-Compound *)

PolyhedronName[Octahedron5Compound]:="octahedron 5-compound"
PolyhedronDual[Octahedron5Compound]:=Cube5Compound
NetPieces[Octahedron5Compound]:={{30,{1,2,3,4}}}
NetFaces[Octahedron5Compound]:={{2,6,1},{2,5,1},{4,6,1},{3,5,1}}
NetVertices[Octahedron5Compound]:=
{{0,0},{0,Sqrt[2/5]},{-Sqrt[3/10],-(1/Sqrt[10])},{Sqrt[3/10],-(1/Sqrt[10])},
 {-Sqrt[9/4-(3Sqrt[5])/4],Sqrt[3/4-Sqrt[5]/4]},
 {Sqrt[9/4-(3Sqrt[5])/4],Sqrt[3/4-Sqrt[5]/4]}}/Sqrt[3+Sqrt[5]]
PolyhedronPolyhedra[Octahedron5Compound]:=
{{1,2,3,4,5,6,7,8},{9,10,11,12,13,14,15,16},{17,18,19,20,21,22,23,24},{25,26,
    27,28,29,30,31,32},{33,34,35,36,37,38,39,40}}
PolyhedronFaces[Octahedron5Compound]:=
{{1,11,17},{24,11,1},{17,14,1},{1,14,24},{17,11,2},{2,11,24},{2,14,17},{24,14,
    2},{3,5,20},{23,5,3},{3,20,28},{28,23,3},{21,6,4},{4,6,22},{27,21,4},{4,
    22,27},{30,20,5},{5,23,30},{6,21,29},{29,22,6},{7,9,16},{18,9,7},{7,16,
    26},{26,18,7},{15,10,8},{8,10,19},{25,15,8},{8,19,25},{9,13,16},{18,13,
    9},{15,12,10},{10,12,19},{12,15,25},{25,19,12},{26,16,13},{13,18,26},{30,
    28,20},{21,27,29},{29,27,22},{23,28,30}}
PolyhedronVertices[Octahedron5Compound]:=
	{{0,(-1-Sqrt[5])/2,0},{0,(1+Sqrt[5])/2,0},
 {Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,
  -Sqrt[1+2/Sqrt[5]]},{Sqrt[1/8-1/(8Sqrt[5])],
  (1+Sqrt[5])/4,-Sqrt[1+2/Sqrt[5]]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,
  Sqrt[(5+Sqrt[5])/10]},{Sqrt[1/8+1/(8Sqrt[5])],
  (3+Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[1+2/Sqrt[5]]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[1+2/Sqrt[5]]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,
  Root[1-5#1^2+5#1^4&,1,0]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,
  Root[1-5#1^2+5#1^4&,1,0]},
 {-Sqrt[1+2/Sqrt[5]],0,Root[1-5#1^2+5#1^4&,1,
   0]},{-Sqrt[1+2/Sqrt[5]]/2,-1/2,
  -Sqrt[1+2/Sqrt[5]]},{-Sqrt[1+2/Sqrt[5]]/2,1/2,
  -Sqrt[1+2/Sqrt[5]]},{Sqrt[1+2/Sqrt[5]],0,
  Sqrt[(5+Sqrt[5])/10]},{Sqrt[5/8+Sqrt[5]/8],
  -(1+Sqrt[5])^2/8,0},{Sqrt[5/8+Sqrt[5]/8],
  (3+Sqrt[5])/4,0},{Sqrt[(5+Sqrt[5])/10],0,
  -Sqrt[1+2/Sqrt[5]]},{-Sqrt[(5+Sqrt[5])/2]/2,
  -(1+Sqrt[5])^2/8,0},{-Sqrt[(5+Sqrt[5])/2]/2,
  (3+Sqrt[5])/4,0},{-Sqrt[5+2Sqrt[5]]/2,-1/2,0},
 {-Sqrt[5+2Sqrt[5]]/2,1/2,0},{Sqrt[5+2Sqrt[5]]/2,
  -1/2,0},{Sqrt[5+2Sqrt[5]]/2,1/2,0},
 {Root[1-5#1^2+5#1^4&,1,0],0,
  Sqrt[1+2/Sqrt[5]]},{Root[1-100#1^2+80#1^4&,1,
   0],(-1-Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
 {Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,
  Sqrt[(5+Sqrt[5])/10]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,
  Root[1-5#1^2+5#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,
  Root[1-5#1^2+5#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,
  Sqrt[1+2/Sqrt[5]]},{Root[1-20#1^2+80#1^4&,2,
   0],(1+Sqrt[5])/4,Sqrt[1+2/Sqrt[5]]}}/Sqrt[3+Sqrt[5]]

(* Octahedron 6-Compound *)

(* Octahedron 10-Compound *)

PolyhedronName[Octahedron10Compound]:="octahedron 10-compound"
PolyhedronDual[Octahedron10Compound]:="cube 10-compound"
PolyhedronPolyhedra[Octahedron10Compound]:=Partition[Range[8 10],8]
PolyhedronFaces[Octahedron10Compound]:=
{{15,33,22},{32,18,27},{32,27,15},{22,33,18},{22,18,32},{33,15,27},{32,15,
    22},{33,27,18},{48,46,38},{59,57,43},{46,48,43},{38,46,57},{59,48,38},{38,
    57,59},{46,43,57},{59,43,48},{54,53,41},{52,51,40},{41,51,52},{53,40,
    51},{52,40,54},{53,54,40},{41,53,51},{52,54,41},{42,55,56},{50,39,49},{50,
    49,42},{55,49,39},{56,39,50},{56,55,39},{55,42,49},{50,42,56},{34,16,
    21},{17,31,28},{16,28,31},{17,34,21},{21,31,17},{16,34,28},{21,16,31},{17,
    28,34},{47,37,45},{44,58,60},{44,47,45},{45,37,58},{37,47,60},{37,60,
    58},{45,58,44},{44,60,47},{12,4,8},{1,5,9},{4,9,5},{1,12,8},{8,5,1},{8,4,
    5},{1,9,12},{4,12,9},{35,13,24},{20,30,25},{25,30,13},{35,24,20},{30,20,
    24},{25,13,35},{30,24,13},{35,20,25},{3,11,7},{6,2,10},{6,10,3},{7,11,
    2},{7,2,6},{6,3,7},{11,10,2},{11,3,10},{23,14,36},{19,26,29},{29,26,
    14},{23,36,19},{23,19,29},{26,36,14},{29,14,23},{26,19,36}}
PolyhedronVertices[Octahedron10Compound]:=
{{0,Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0],
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0]},
 {0,Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0],
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0]},
 {0,Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0],
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0]},
 {0,Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0],
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0]},
 {-(1/Sqrt[2]),Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0]},
 {-(1/Sqrt[2]),Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0]},
 {-(1/Sqrt[2]),Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0]},
 {-(1/Sqrt[2]),Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0]},
 {1/Sqrt[2],Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0]},
 {1/Sqrt[2],Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0]},
 {1/Sqrt[2],Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0]},
 {1/Sqrt[2],Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0]},
 {(-2-Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6},
 {(-2-Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6},
 {(-2-Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6},
 {(-2-Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6},
 {(2+Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6},
 {(2+Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6},
 {(2+Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6},
 {(2+Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6},
 {(-2-Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6},
 {(-2-Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6},
 {(-2-Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6},
 {(-2-Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6},
 {(2+Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6},
 {(2+Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6},
 {(2+Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6,(2-Sqrt[7+3Sqrt[5]])/6},
 {(2+Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6,(-2+Sqrt[7+3Sqrt[5]])/6},
 {(2-Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6},
 {(2-Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6},
 {(2-Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6},
 {(2-Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6},
 {(-2+Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6},
 {(-2+Sqrt[7+3Sqrt[5]])/6,(-2-Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6},
 {(-2+Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6,(-2-Sqrt[10])/6},
 {(-2+Sqrt[7+3Sqrt[5]])/6,(2+Sqrt[7-3Sqrt[5]])/6,(2+Sqrt[10])/6},
 {Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0],0,
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0]},
 {Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0],0,
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0]},
 {Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0],
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0],0},
 {Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0],
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0],0},
 {Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0],
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,1,0],0},
 {Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0],
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0],0},
 {Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0],0,
  Root[-1+6#1-7#1^2-6#1^3+9#1^4&,2,0]},
 {Root[-1-6#1-7#1^2+6#1^3+9#1^4&,4,0],0,
  Root[-1-6#1-7#1^2+6#1^3+9#1^4&,3,0]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],-(1/Sqrt[2]),
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],-(1/Sqrt[2]),
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],1/Sqrt[2],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],1/Sqrt[2],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],-(1/Sqrt[2])},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],1/Sqrt[2]},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],-(1/Sqrt[2])},
 {Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],1/Sqrt[2]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],-(1/Sqrt[2])},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,2,0],1/Sqrt[2]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],-(1/Sqrt[2])},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],1/Sqrt[2]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],-(1/Sqrt[2]),
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],-(1/Sqrt[2]),
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],1/Sqrt[2],
  Root[-1+8#1-10#1^2-24#1^3+36#1^4&,4,0]},
 {Root[-1-8#1-10#1^2+24#1^3+36#1^4&,3,0],1/Sqrt[2],
  Root[-1-8#1-10#1^2+24#1^3+36#1^4&,1,0]}}

(* Platonic *)

Platonic[1]:=Cube
Platonic[2]:=Dodecahedron
Platonic[3]:=Icosahedron
Platonic[4]:=Octahedron
Platonic[5]:=Tetrahedron

Platonics:=Platonic/@Range[5]

Inradius[Cube]:=1/2
Midradius[Cube]:=Sqrt[2]/2
Circumradius[Cube]:=Sqrt[3]/2

Inradius[Dodecahedron]:=Sqrt[250+110Sqrt[5]]/20
Midradius[Dodecahedron]:=(3+Sqrt[5])/4
Circumradius[Dodecahedron]:=(Sqrt[15]+Sqrt[3])/4

Inradius[Icosahedron]:=(3Sqrt[3]+Sqrt[15])/12
Midradius[Icosahedron]:=(1+Sqrt[5])/4
Circumradius[Icosahedron]:=Sqrt[10+2Sqrt[5]]/4

Inradius[Octahedron]:=Sqrt[6]/6
Midradius[Octahedron]:=1/2
Circumradius[Octahedron]:=Sqrt[2]/2

Inradius[Tetrahedron]:=Sqrt[6]/12
Midradius[Tetrahedron]:=Sqrt[2]/4
Circumradius[Tetrahedron]:=Sqrt[6]/4

(* Small Stellated Dodecahedron *)

PolyhedronName[SmallStellatedDodecahedron]:="small stellated dodecahedron"
PolyhedronDual[SmallStellatedDodecahedron]:=GreatDodecahedron

PolyhedronFaces[SmallStellatedDodecahedron]:=
{{11,3,7,1,9},{12,10,1,8,3},{4,6,11,8,1},{4,1,7,12,5},{6,9,1,10,5},{8,3,2,6,
    9},{7,10,5,2,3},{4,9,11,2,5},{4,6,2,12,10},{8,7,12,2,11},{11,6,5,12,3},{4,
    10,7,8,9}}
PolyhedronVertices[SmallStellatedDodecahedron]:=
{{0,0,-5/Sqrt[50-10Sqrt[5]]},{0,0,5/Sqrt[50-10Sqrt[5]]},
 {-Sqrt[2/(5-Sqrt[5])],0,-(1/Sqrt[10-2Sqrt[5]])},
 {Sqrt[2/(5-Sqrt[5])],0,1/Sqrt[10-2Sqrt[5]]},
 {-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,
  -(1/Sqrt[10-2Sqrt[5]])},{-(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,-(1/Sqrt[10-2Sqrt[5]])},
 {(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,
  1/Sqrt[10-2Sqrt[5]]},{(-1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),
  Sqrt[(5+Sqrt[5])/(5-Sqrt[5])]/2,1/Sqrt[10-2Sqrt[5]]},
 {-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-1/2,1/Sqrt[10-2Sqrt[5]]},
 {-(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),1/2,1/Sqrt[10-2Sqrt[5]]},
 {(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),-1/2,-(1/Sqrt[10-2Sqrt[5]])},
 {(1+Sqrt[5])/(2Sqrt[10-2Sqrt[5]]),1/2,-(1/Sqrt[10-2Sqrt[5]])}}

PolyhedronFaces[SmallStellatedDodecahedron,Split->True]:=
{{20,19,10},{20,10,9},{20,9,18},{20,18,4},{20,4,19},{17,3,16},{17,16,12},{17,
    12,11},{17,11,15},{17,15,3},{28,15,11},{28,11,7},{28,7,25},{28,25,13},{28,
    13,15},{23,11,12},{23,12,8},{23,8,2},{23,2,7},{23,7,11},{27,12,16},{27,16,
    14},{27,14,26},{27,26,8},{27,8,12},{24,16,3},{24,3,1},{24,1,6},{24,6,
    14},{24,14,16},{21,3,15},{21,15,13},{21,13,5},{21,5,1},{21,1,3},{32,26,
    14},{32,14,6},{32,6,10},{32,10,19},{32,19,26},{22,6,1},{22,1,5},{22,5,
    9},{22,9,10},{22,10,6},{30,5,13},{30,13,25},{30,25,18},{30,18,9},{30,9,
    5},{31,25,7},{31,7,2},{31,2,4},{31,4,18},{31,18,25},{29,2,8},{29,8,
    26},{29,26,19},{29,19,4},{29,4,2}}
PolyhedronVertices[SmallStellatedDodecahedron,Split->True]:=
{{-Sqrt[1+2/Sqrt[5]],0,Root[1-20#1^2+80#1^4&,2,0]},{Sqrt[1+2/Sqrt[5]],0,Sqrt[1/8-1/(8Sqrt[5])]},
 {Root[1-5#1^2+5#1^4&,1,0],0,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[(5+Sqrt[5])/10],0,Sqrt[5/8+11/(8Sqrt[5])]},{Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,
  Sqrt[1/8-1/(8Sqrt[5])]},{Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1/2,Sqrt[5/8+11/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]]/2,1/2,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[1/4+1/(2Sqrt[5])],-1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/4+1/(2Sqrt[5])],1/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,2,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {0,0,Root[5-100#1^2+16#1^4&,1,0]},{Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,
  Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {0,0,Sqrt[25/8+(11Sqrt[5])/8]},{Root[1-260#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,
  Root[1-100#1^2+80#1^4&,1,0]},{Root[1-25#1^2+5#1^4&,1,0],0,Sqrt[5/8+11/(8Sqrt[5])]},
 {Sqrt[5/2+11/(2Sqrt[5])],0,Root[1-100#1^2+80#1^4&,1,0]},
 {Root[1-260#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[1/8-1/(8Sqrt[5])]},
 {Sqrt[1+2/Sqrt[5]]/2,(2+Sqrt[5])/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[1+2/Sqrt[5]]/2,-1-Sqrt[5]/2,Root[1-100#1^2+80#1^4&,1,0]},
 {Sqrt[13/8+29/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[5/8+11/(8Sqrt[5])]},
 {-Sqrt[1+2/Sqrt[5]]/2,-1-Sqrt[5]/2,Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[13/8+29/(8Sqrt[5])],(-3-Sqrt[5])/4,
  Sqrt[5/8+11/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]]/2,(2+Sqrt[5])/2,Sqrt[5/8+11/(8Sqrt[5])]}}

(* Stella Octangula *)

PolyhedronName[StellaOctangula]:="stella octangula"

NetPieces[StellaOctangula]:={{8,{1,2,3}}}
NetFaces[StellaOctangula]:={{2,3,1},{2,4,3},{4,3,5}}
NetVertices[
    StellaOctangula]:={{-1,-(1/Sqrt[3])},{-1/2,
      1/(2Sqrt[3])},{0,-(1/Sqrt[3])},{1/2,1/(2Sqrt[3])},{1,-(1/Sqrt[3])}}

PolyhedronPolyhedra[StellaOctangula]:={{1,2,3,4},{5,6,7,8}}
PolyhedronFaces[StellaOctangula]:=
{{4,5,8},{5,4,2},{8,2,4},{2,8,5},{6,7,3},{7,6,1},{3,1,6},{1,3,7}}
PolyhedronVertices[StellaOctangula]:=
{{0,0,-Sqrt[3/2]/2},{0,0,Sqrt[3/2]/2},{-(1/Sqrt[3]),0,1/(2Sqrt[6])},
 {-1/(2Sqrt[3]),-1/2,-1/(2Sqrt[6])},{-1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},
 {1/(2Sqrt[3]),-1/2,1/(2Sqrt[6])},{1/(2Sqrt[3]),1/2,1/(2Sqrt[6])},
 {1/Sqrt[3],0,-1/(2Sqrt[6])}}

PolyhedronFaces[StellaOctangula,Split->True]:=
{{4,5,9},{6,10,5},{14,9,10},{5,10,1},{10,9,1},{9,5,1},{6,5,8},{4,7,5},{2,8,
    7},{5,7,3},{7,8,3},{8,5,3},{14,12,9},{2,7,12},{4,9,7},{12,7,11},{7,9,
    11},{9,12,11},{2,12,8},{14,10,12},{6,8,10},{12,10,13},{10,8,13},{8,12,13}}
PolyhedronVertices[StellaOctangula,Split->True]:=
{{0,0,-Sqrt[3/2]/2},{0,0,Sqrt[3/2]/2},{-(1/Sqrt[3]),0,1/(2Sqrt[6])},
 {-1/(2Sqrt[3]),-1/2,-1/(2Sqrt[6])},{-1/(2Sqrt[3]),0,-1/(2Sqrt[6])},
 {-1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},{-1/(4Sqrt[3]),-1/4,1/(2Sqrt[6])},
 {-1/(4Sqrt[3]),1/4,1/(2Sqrt[6])},{1/(4Sqrt[3]),-1/4,-1/(2Sqrt[6])},
 {1/(4Sqrt[3]),1/4,-1/(2Sqrt[6])},{1/(2Sqrt[3]),-1/2,1/(2Sqrt[6])},
 {1/(2Sqrt[3]),0,1/(2Sqrt[6])},{1/(2Sqrt[3]),1/2,1/(2Sqrt[6])},
 {1/Sqrt[3],0,-1/(2Sqrt[6])}}

(* Tetrahedron *)

PolyhedronName[Tetrahedron]:="tetrahedron"
PolyhedronDual[Tetrahedron]:=Tetrahedron
NetFaces[Tetrahedron]:={{2,3,1},{4,2,5},{2,5,3},{5,3,6}}
NetVertices[Tetrahedron]:={{-1,-(1/Sqrt[3])},{-1/2,1/(2Sqrt[3])},{0,-(1/Sqrt[3])},{0,2/Sqrt[3]},{1/2,1/(2Sqrt[3])},{1,-(1/Sqrt[3])}}
PolyhedronPolyhedra[Tetrahedron]:={Range[4]}
PolyhedronFaces[Tetrahedron]:=PolyhedronFaces[Tetrahedron,"C3"]
PolyhedronVertices[Tetrahedron]:=PolyhedronVertices[Tetrahedron,"C3"]

(* Tetrahedron C2 *)

PolyhedronName[Tetrahedron,"C2"]:="tetrahedron oriented with the z-axis along a \
C2 symmetry axis and top edge having slope -1 in the xy-plane."
PolyhedronDual[Tetrahedron,"C2"]:=Tetrahedron
PolyhedronPolyhedra[Tetrahedron,"C2"]:={Range[4]}
PolyhedronVertices[Tetrahedron,"C2"]:=
{{-1,-1,-1},{-1,1,1},{1,-1,1},{1,1,-1}}/(2Sqrt[2])
PolyhedronFaces[Tetrahedron,"C2"]:={{3,2,1},{1,2,4},{4,3,1},{2,3,4}}

(* Tetrahedron C3 *)

PolyhedronName[Tetrahedron,"C3"]:="tetrahedron oriented with the z-axis along a \
C3 symmetry axis and vertex pointing in the +z direction."
PolyhedronPolyhedra[Tetrahedron,"C3"]:={Range[4]}
PolyhedronVertices[Tetrahedron,"C3"]:=
{{0,0,Sqrt[2/3]-1/(2Sqrt[6])},{-1/(2Sqrt[3]),-1/2,
  -1/(2Sqrt[6])},{-1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},{1/Sqrt[3],0,-1/(2Sqrt[6])}}
PolyhedronFaces[Tetrahedron,"C3"]:=
{{2,3,4},{3,2,1},{4,1,2},{1,4,3}}

(* Tetrahedron 2-Compound *)

PolyhedronName[Tetrahedron2Compound,chiral_:1]:=
	"tetrahedron 2-compound (dextro)"
PolyhedronFaces[Tetrahedron2Compound,chiral_:1]=
{{3,4,6},{4,3,2},{6,2,3},{2,6,4},{8,7,5},{1,5,7},{5,1,8},{7,8,1}}
PolyhedronVertices[Tetrahedron2Compound,chiral_:1]=
{{0,0,-Sqrt[3/2]/2},{0,0,Sqrt[3/2]/2},{-1/(2Sqrt[3]),-1/2,-1/(2Sqrt[6])},
 {-1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},{-1/(4Sqrt[3]),-Sqrt[5]/4,1/(2Sqrt[6])},{1/Sqrt[3],0,-1/(2Sqrt[6])},
 {-Sqrt[(23-3Sqrt[5])/6]/4,(1+Sqrt[5])/8,1/(2Sqrt[6])},{Sqrt[23/96+Sqrt[5]/32],(-1+Sqrt[5])/8,
  1/(2Sqrt[6])}}

(* Tetrahedron 3-Compound *)

PolyhedronName[Tetrahedron3Compound]:="tetrahedron 3-compound"
PolyhedronPolyhedra[Tetrahedron3Compound]:=Partition[Range[3 4],4]
PolyhedronFaces[Tetrahedron3Compound]:={{3,2,1},{1,2,4},{4,3,1},{2,3,4},{9,12,6},{6,12,7},{7,9,6},{12,9,7},{8,5,
    11},{11,5,10},{10,8,11},{5,8,10}}
PolyhedronVertices[Tetrahedron3Compound]:=
{{-1/(2Sqrt[2]),-1/(2Sqrt[2]),-1/(2Sqrt[2])},
 {-1/(2Sqrt[2]),1/(2Sqrt[2]),1/(2Sqrt[2])},
 {1/(2Sqrt[2]),-1/(2Sqrt[2]),1/(2Sqrt[2])},
 {1/(2Sqrt[2]),1/(2Sqrt[2]),-1/(2Sqrt[2])},
 {-Sqrt[2-Sqrt[3]]/4,-Sqrt[1/8+Sqrt[3]/16],1/(2Sqrt[2])},
 {-Sqrt[2-Sqrt[3]]/4,Sqrt[1/8+Sqrt[3]/16],-1/(2Sqrt[2])},
 {Sqrt[2-Sqrt[3]]/4,-Sqrt[1/8+Sqrt[3]/16],-1/(2Sqrt[2])},
 {Sqrt[2-Sqrt[3]]/4,Sqrt[1/8+Sqrt[3]/16],1/(2Sqrt[2])},
 {-Sqrt[1/8+Sqrt[3]/16],-Sqrt[2-Sqrt[3]]/4,1/(2Sqrt[2])},
 {-Sqrt[1/8+Sqrt[3]/16],Sqrt[2-Sqrt[3]]/4,-1/(2Sqrt[2])},
 {Sqrt[1/8+Sqrt[3]/16],-Sqrt[2-Sqrt[3]]/4,-1/(2Sqrt[2])},
 {Sqrt[1/8+Sqrt[3]/16],Sqrt[2-Sqrt[3]]/4,1/(2Sqrt[2])}}

(* Tetrahedron 4-Compound *)

PolyhedronName[Tetrahedron4Compound,"C3"]:="tetrahedron rotation compound of \
4 tetrahedra by angle Pi/3."
NetPieces[Tetrahedron4Compound,"C3"]:=
 {{4,{1,2,3}},{12,{4,5,6}},{12,{7,8}},{12,{9,10}}}
NetFaces[Tetrahedron4Compound,"C3"]:=
 {{10,1,2,6,5,7,4,3},{10,3,8,9,11,12,13,18},{10,18,17,14,16,15,19,20},{24,27,
    26,25},{24,21,22,23},{23,24,25},{28,29,31},{28,30,31},{35,34,32},{35,33,
    32}}
NetVertices[Tetrahedron4Compound,"C3"]:=
{{-3/5,0},{-5/14,Sqrt[3]/14},{-3/10,(3Sqrt[3])/10},{-2/7,Sqrt[3]/7},{-9/32,(3Sqrt[3])/32},
 {-5/18,1/(6Sqrt[3])},{-2/9,1/(3Sqrt[3])},{-1/14,(3Sqrt[3])/14},{-1/18,1/(2Sqrt[3])},{0,0},
 {0,(3Sqrt[3])/16},{1/18,1/(2Sqrt[3])},{1/14,(3Sqrt[3])/14},{2/9,1/(3Sqrt[3])},{5/18,1/(6Sqrt[3])},
 {9/32,(3Sqrt[3])/32},{2/7,Sqrt[3]/7},{3/10,(3Sqrt[3])/10},{5/14,Sqrt[3]/14},{3/5,0},{23/30,1/(2Sqrt[3])},
 {37/42,1/(14Sqrt[3])},{1,0},{7/6,1/(2Sqrt[3])},{4/3,0},{61/42,1/(14Sqrt[3])},{47/30,1/(2Sqrt[3])},
 {15/8,1/8},{187/96,(4+Sqrt[3])/32},{331/168,(21-8Sqrt[3])/168},{143/72,1/8},{181/72,1/8},
 {425/168,(21-8Sqrt[3])/168},{245/96,(4+Sqrt[3])/32},{21/8,1/8}}

PolyhedronPolyhedra[Tetrahedron4Compound,"C3"]:=Partition[Range[4 4],4]
PolyhedronFaces[Tetrahedron4Compound,"C3"]:=
{{12,2,13},{2,12,1},{13,1,12},{1,13,2},{4,9,16},{9,4,8},{16,8,4},{8,16,9},{3,
    7,10},{7,3,15},{10,15,3},{15,10,7},{6,11,14},{11,6,5},{14,5,6},{5,14,11}}
PolyhedronVertices[Tetrahedron4Compound,"C3"]:=
{{0,0,Sqrt[3/2]/2},{-(1/Sqrt[3]),0,-1/(2Sqrt[6])},
 {-2/(3Sqrt[3]),-1/3,5/(6Sqrt[6])},{-2/(3Sqrt[3]),0,-7/(6Sqrt[6])},
 {-2/(3Sqrt[3]),1/3,5/(6Sqrt[6])},{-1/(2Sqrt[3]),-1/2,-1/(2Sqrt[6])},
 {-1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},{-1/(6Sqrt[3]),-1/2,5/(6Sqrt[6])},
 {-1/(6Sqrt[3]),1/2,5/(6Sqrt[6])},{1/(3Sqrt[3]),-1/3,-7/(6Sqrt[6])},
 {1/(3Sqrt[3]),1/3,-7/(6Sqrt[6])},{1/(2Sqrt[3]),-1/2,-1/(2Sqrt[6])},
 {1/(2Sqrt[3]),1/2,-1/(2Sqrt[6])},{5/(6Sqrt[3]),-1/6,5/(6Sqrt[6])},
 {5/(6Sqrt[3]),1/6,5/(6Sqrt[6])},{1/Sqrt[3],0,-1/(2Sqrt[6])}}

(* Tetrahedron 5-Compound *)

PolyhedronName[Tetrahedron5Compound,1]:=
	"tetrahedron 5-compound (dextro)"
NetPieces[Tetrahedron5Compound,1]:={{20,{1,2,3}}}
NetFaces[Tetrahedron5Compound,1]:=
{{1,7,9,10,4},{1,6,11,8,7},{1,3,5,2,6}}
NetVertices[Tetrahedron5Compound,1]:=
{{0,0},{-Sqrt[5/2]/2,Sqrt[3/2]/2},{-Sqrt[3-Sqrt[5]],0},{Sqrt[3-Sqrt[5]],0},
 {-Sqrt[15/16-(5Sqrt[5])/16],Sqrt[9/16-(3Sqrt[5])/16]},
 {-Sqrt[3/4-Sqrt[5]/4],Sqrt[9/4-(3Sqrt[5])/4]},
 {Sqrt[3/4-Sqrt[5]/4],Sqrt[9/4-(3Sqrt[5])/4]},
 {Sqrt[7/16-(3Sqrt[5])/16],Sqrt[9/16+(3Sqrt[5])/16]},
 {Sqrt[3/16+Sqrt[5]/16],Sqrt[21/16-(9Sqrt[5])/16]},
 {Sqrt[7/16+(3Sqrt[5])/16],Sqrt[9/16-(3Sqrt[5])/16]},
 {1/(2Sqrt[2(9+4Sqrt[5])]),Sqrt[3/2]/2}}
PolyhedronFaces[Tetrahedron5Compound,1]:=
{{17,11,1},{1,11,20},{20,17,1},{11,17,20},{14,9,2},{2,9,15},{2,14,15},{9,14,
    15},{3,8,10},{19,8,3},{3,10,19},{8,10,19},{12,6,4},{4,6,13},{4,12,13},{6,
    12,13},{16,7,5},{5,7,18},{18,16,5},{7,16,18}}
PolyhedronVertices[Tetrahedron5Compound,1]:=PolyhedronVertices[Dodecahedron]

PolyhedronName[Tetrahedron5Compound,-1]:=
	"tetrahedron 5-compound (laevo)"
PolyhedronFaces[Tetrahedron5Compound,-1]:=
{{1,12,18},{19,12,1},{1,18,19},{19,18,12},{13,10,2},{2,10,16},{2,13,16},{16,
    13,10},{3,7,9},{3,7,20},{3,9,20},{20,9,7},{11,5,4},{14,5,4},{14,11,4},{5,
    11,14},{15,8,6},{6,8,17},{17,15,6},{8,15,17}}
PolyhedronVertices[Tetrahedron5Compound,-1]:=PolyhedronVertices[Dodecahedron]
PolyhedronPolyhedra[Tetrahedron5Compound]:=
	{{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16},{17,18,19,20}}

(* Tetrahedron 6-Compound *)

PolyhedronName[Tetrahedron6Compound]:="tetrahedron 6-compound"
NetPieces[Tetrahedron6Compound]:={{24,{1,2,3}},{24,{4,5}}}
NetFaces[Tetrahedron6Compound]:=
{{9,10,8,2,6,7},{10,8,11,1},{2,8,3,12},{4,14,5},{4,13,5}}
NetVertices[Tetrahedron6Compound]:=
{{-1/2,0},{0,0},{0,Sqrt[9/8-3/(2Sqrt[2])]},{1/2,1/8},{1/2,(-3+2Sqrt[2])/8},
 {(-2+Sqrt[2])/6,-Sqrt[1/4-1/(3Sqrt[2])]},{(-2+Sqrt[2])/4,0},
 {(-2+Sqrt[2])/4,Sqrt[9/8-3/(2Sqrt[2])]},{(-2+Sqrt[2])/3,-Sqrt[1/4-1/(3Sqrt[2])]},
 {(-2+Sqrt[2])/2,0},{(-2+Sqrt[2])/2,Sqrt[9/8-3/(2Sqrt[2])]},{(-1+Sqrt[2])/2,0},
 {(6-Sqrt[6(3-2Sqrt[2])])/12,(-5+4Sqrt[2])/24},{(6+Sqrt[6(3-2Sqrt[2])])/12,
  (-5+4Sqrt[2])/24}}

PolyhedronPolyhedra[Tetrahedron6Compound]:=Partition[Range[6 4],4]
PolyhedronFaces[Tetrahedron6Compound]:=
{{6,8,1},{1,8,13},{13,6,1},{8,6,13},{2,14,7},{7,14,5},{5,2,7},{14,2,5},{4,16,
    9},{9,16,10},{10,4,9},{16,4,10},{11,12,15},{15,12,3},{3,11,15},{12,11,
    3},{22,23,17},{17,23,20},{20,22,17},{23,22,20},{21,24,19},{19,24,18},{18,
    21,19},{24,21,18}}
PolyhedronVertices[Tetrahedron6Compound]:=
{{-1/2,0,-1/(2Sqrt[2])},{-1/2,0,1/(2Sqrt[2])},
 {-1/2,-1/(2Sqrt[2]),0},{-1/2,1/(2Sqrt[2]),0},
 {0,-1/2,-1/(2Sqrt[2])},{0,-1/2,1/(2Sqrt[2])},
 {0,1/2,-1/(2Sqrt[2])},{0,1/2,1/(2Sqrt[2])},
 {0,-1/(2Sqrt[2]),-1/2},{0,-1/(2Sqrt[2]),1/2},
 {0,1/(2Sqrt[2]),-1/2},{0,1/(2Sqrt[2]),1/2},
 {1/2,0,-1/(2Sqrt[2])},{1/2,0,1/(2Sqrt[2])},
 {1/2,-1/(2Sqrt[2]),0},{1/2,1/(2Sqrt[2]),0},
 {-1/(2Sqrt[2]),-1/2,0},{-1/(2Sqrt[2]),0,-1/2},
 {-1/(2Sqrt[2]),0,1/2},{-1/(2Sqrt[2]),1/2,0},
 {1/(2Sqrt[2]),-1/2,0},{1/(2Sqrt[2]),0,-1/2},
 {1/(2Sqrt[2]),0,1/2},{1/(2Sqrt[2]),1/2,0}}

(* Tetrahedron 10-Compound *)

PolyhedronName[Tetrahedron10Compound]:="tetrahedron 10-compound"
PolyhedronFaces[Tetrahedron10Compound]:=
{{17,11,1},{1,11,20},{20,17,1},{11,17,20},{1,12,18},{19,12,1},{1,18,19},{19,
    18,12},{14,9,2},{2,9,15},{2,14,15},{9,14,15},{13,10,2},{2,10,16},{2,13,
    16},{16,13,10},{3,7,9},{3,7,20},{3,9,20},{20,9,7},{3,8,10},{19,8,3},{3,10,
    19},{8,10,19},{11,5,4},{14,5,4},{14,11,4},{5,11,14},{12,6,4},{4,6,13},{4,
    12,13},{6,12,13},{16,7,5},{5,7,18},{18,16,5},{7,16,18},{15,8,6},{6,8,
    17},{17,15,6},{8,15,17}}
PolyhedronVertices[Tetrahedron10Compound]:=PolyhedronVertices[Dodecahedron]


End[]

(* Protect[  ] *)

EndPackage[]