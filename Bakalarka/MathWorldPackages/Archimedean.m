(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.47 *)

(*:Name: MathWorld`Archimedean` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Archimedean.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1999-07-25): Put in package format
  v1.02 (1999-07-26): Added factor of 1/2 to TruncatedCube,
                      1/(4Sqrt[3]) to TruncatedOctahedron, and
                      9/5 to TruncatedTetrahedron
                      to get unit side lengths
  v1.03 (1999-07-28): Multiplied cuboctahedron by 1/2,
                      TruncatedCube by 2
  v1.04 (1999-07-29): Multiplied TruncatedDodecahedronExact by (3 + Sqrt[5])/4
                      Corrected TruncatedOctahedronExact.
                      Multiplied TruncatedTetrahedron by 9/5
  v1.05 (1999-07-30): Archimdeanr, ArchimdeanR, ArchimdeanRho.
                      Scaled GreatRhombicuboctahedronExact and
                      SmallRhombicuboctahedronExact.
  v1.06 (1999-07-31): Moved Netlist Archimedean solids
                      here
  v1.07 (1999-08-02): Renamed ArchimedeanExact` to Archimedean`
  v1.08 (1999-08-03): Implemented OrientCentered instead of Orient
  v1.09 (1999-08-14): GreatRhombicosidodecahedronExact, IcosidodecahedronExact,
                      SnubCubeExact, SnubDodecahedronExact
  v1.10 (1999-08-18): Simplified DodecahedronExact.
  v1.11 (1999-08-27): CuboctahedronDualExact
  v1.12 (1999-08-29): DeltoidalIcositetrahedronExact,
                      IcosidodecahedronDualExact,
                      PentakisDodecahedronExact,
                      RhombicTriacontahedronExact,
                      SmallRhombicuboctahedronDualExact
                      TetrakisHexahedronExact, TruncatedIcosahedronDualExact,
                      TruncatedOctahedronDualExact
  v1.13 (1999-08-30): Corrected TruncatedDodecahedronExact
  v1.14 (1999-08-30): PentagonalIcositetrahedronExact, TruncatedDodecahedronDualExact
  v1.15 (1999-08-31): SnubCubeDualExact
  v1.16 (1999-10-01): Added  context for SnubDodecahedronExact
  v1.17 (1999-10-07): Added  contexts
  v1.18 (2000-01-01): Updated URL
  v1.19 (2000-01-04): rhombicDodecahedron moved from  to here
  v1.20 (2000-02-15): fixed UniformPolyhedron non-exact entries.
                      Fixed ToExactN for SnubDodecahedronExact
  v1.21 (2000-02-25): Added names for some duals.  ArchimedeanName,
                      ArchimedeanDualName, ArchimedeanCompound,
                      PentagonalHexecontahedron.  Archimedean, ArchimedeanDual.
  v1.22 (2000-11-13): PolyhedronOperations now added to BeginPackage
  v1.23 (2000-12-29): Added OrientCentered to TriakisTetrahedronExact
  v1.24 (2002-10-11): Added missing non-exact definitions,
  v1.25 (2002-10-14): Added nice embedding for the SnubCube.
                      GreatRhombicosidodecahedronExact
  v1.26 (2002-10-27): Added remaining missing inexact versions
  v1.30 (2002-11-09): Switched to new syntax Polyhedron[poly].  Completely cleaned
                      up and uniformized syntax and documentation, moving
                      incomplete code into individual notebooks.  This package
                      is now free-standing, requiring only PolyhedronOperations.m
                      to define the Polyhedron[] commands.  Added nets.
  v1.31 (2002-11-15): Added numerical vertices for SmallRhombicosidodecahedron,
                      snub cube, snub dodecahedron
  v1.35 (2003-02-19): Corrected orientations as needed, cleaned up radii.
                      Added SnubCube, PentagonalIcositetrahedron, 
                      SmallRhombicosidodecahedron, and  DeltoidalHexecontahedron
  v1.36 (2003-08-10): GreatRhombicTriacontahedron, RhombicHexecontahedron
  v1.37 (2003-08-13): Fixed remaining occurrences of Exact
  v1.38 (2003-10-18): updated context
  v1.39 (2003-11-09): updated context of PolyhedronOperations in BeginPackage.
                      Fixed approximate zeros for NetVertices of Archimedean duals
  v1.40 (2003-11-21): Added Archimedeans and ArchimedeanDuals, fixed some PolyhedronDuals
  v1.41 (2003-12-07): Moved GreatRhombicTriacontahedron to MiscPolyhedra` where it
                      belongs
  v1.42 (2003-12-20): Added versions of SnubCube and SnubDodecahedron constructed by
                      snubification and that therefore have simpler and more natural
                      coordinates.  Also added both handednesses for these
  v1.43 (2004-05-16): Return ArchimedeanDuals as lists
  v1.44 (2004-09-08): Document Archimedeans to be in alphabetical order
  v1.45 (2004-11-10): Fixed RhombicDodecahedron and PentagonalHexecontahedron
  v1.46 (2004-12-01): Fixed PentagonalHexecontahedron "dextro" and "laevo"
  v1.47 (2005-09-16): Fixed orientation of RhombicDodecahedron
 
  (c) 1999-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion: *)

(*:References: *)

(*:Limitations: 

Exact net vertices still missing for some solids

Need to add Archimedean compounds for Archimedeans #2,3,5,9

Definitions of laevo and dextro for snubs unceratain.

Currently, the duals of the laevo snubs are listed as laevo, etc., 
but this should perhaps be inverted...

Neeed to add ArchimedeanDual[7,8] dextro

*)

BeginPackage["MathWorld`Archimedean`",{"MathWorld`PolyhedronOperations`"}]


Archimedean::usage =
"Archimedean[n] gives a representation of the nth Archimedean solid as \
a list of Polygons."

ArchimedeanCompound::usage =
"ArchimedeanCompound[n] gives a list of Polygons forming the \
compound of the nth Archimedean solid and its dual."

ArchimedeanDual::usage =
"ArchimedeanDual[n] gives an exact representation (or inexact if exact is not available) \
of the nth Archimedean dual."

ArchimedeanDuals::usage =
"ArchimedeanDuals gives a list of Archimedean duals."

Archimedeans::usage =
"Archimedeans gives a list of Archimedean solids in alphabetical order."

Cuboctahedron::usage =
"Polyhedron[Cuboctahedron] gives a list of Polygons with analytic vertices \
representing this Archimedean solid."

DeltoidalHexecontahedron::usage =
"Polyhedron[DeltoidalHexecontahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean dual."

DeltoidalIcositetrahedron::usage =
"Polyhedron[DeltoidalIcositetrahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean dual."

DisdyakisTriacontahedron::usage =
"Polyhedron[DisdyakisTriacontahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean dual."

DisdyakisDodecahedron::usage =
"Polyhedron[DisdyakisDodecahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean dual."

GreatRhombicosidodecahedron::usage =
"Polyhedron[GreatRhombicosidodecahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean solid."

GreatRhombicuboctahedron::usage =
"Polyhedron[GreatRhombicuboctahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean solid."
 
Icosidodecahedron::usage =
"Polyhedron[Icosidodecahedron] gives a list of Polygons with analytic vertices \
representing the icosidodecahedron with unit edge lengths."

PentagonalHexecontahedron::usage =
"Polyhedron[PentagonalHexecontahedron] gives a list of Polygons with \
analytic vertices representing the left-handed version of thie Archimedean dual.  \
Polyhedron[PentagonalHexecontahedron,(\"laevo\"|\"dextro\")] gives the pentagonal \
hexecontahedron with specified handedness."

PentagonalIcositetrahedron::usage =
"Polyhedron[PentagonalIcositetrahedron] gives a list of Polygons with \
analytic vertices representing the left-handed version of this Archimedean dual.  \
Polyhedron[PentagonalIcositetrahedron,(\"laevo\"|\"dextro\")] gives the pentagonal \
icositetrahedron with specified handedness."

PentakisDodecahedron::usage =
"Polyhedron[PentakisDodecahedron] gives a list of Polygons with \
analytic vertices representing this Archimedean dual."

RhombicDodecahedron::usage =
"Polyhedron[RhombicDodecahedron] gives a list of Polygons with analytic \
vertices representing the rhombic dodecahedron Archimedean dual."

RhombicHexecontahedron::usage =
"Polyhedron[RhombicHexecontahedron] gives a list of Polygons with analytic \
vertices representing the rhombic hexecontahedron."

RhombicTriacontahedron::usage =
"Polyhedron[RhombicTriacontahedron] gives a list of Polygons with analytic \
vertices representing the rhombic dodecahedron Archimedean dual."

SmallRhombicosidodecahedron::usage =
"Polyhedron[SmallRhombicosidodecahedron] gives a list of Polygons with exact \
vertices representing this Archimedean solid."

SmallRhombicuboctahedron::usage =
"Polyhedron[SmallRhombicuboctahedron] gives a list of Polygons with exact \
vertices representing this Archimedean solid."

SmallTriakisOctahedron::usage =
"Polyhedron[SmallTriakisOctahedron] gives a list of Polygons with analytic \
vertices representing the small triakis octahedron Archimedean dual."

SnubCube::usage =
"Polyhedron[SnubCube] gives a list of Polygons with analytic vertices \
representing the laevo-handed snub cube Archimedean solid \
constructed  by snubification of a cube in normal position.  \
Polyhedron[SnubCube,(\"laevo\"|\"dextro\")] gives the snub cube with specified \
handedness."

SnubDodecahedron::usage =
"Polyhedron[SnubDodecahedron] gives a list of Polygons with analytic \
vertices representing the laevo-handed snub dodecahedron Archimedean solid \
constructed  by snubification of a dodecahedron in normal position.  \
Polyhedron[SnubDodecahedron,(\"laevo\"|\"dextro\")] gives the snub dodecahedron \
with specified handedness."

TetrakisHexahedron::usage =
"Polyhedron[TetrakisHexahedron] gives a list of Polygons with analytic \
vertices representing the triakis hexahedron Archimedean dual."

TriakisIcosahedron::usage =
"Polyhedron[TriakisIcosahedron] gives a list of Polygons with analytic \
vertices representing thetriakis icosahedron Archimedean dual."

TriakisTetrahedron::usage =
"Polyhedron[TriakisTetrahedron] gives a list of Polygons with analytic \
vertices representing the tetrakis tetrahedron Archimedean dual."

TruncatedCube::usage =
"Polyhedron[TruncatedCube] gives Polygons with analytic vertices representing \
this Archimedean solid."

TruncatedDodecahedron::usage =
"Polyhedron[TruncatedDodecahedron] gives a list of Polygons with analytic \
vertices representing this Archimedean solid."

TruncatedIcosahedron::usage =
"Polyhedron[TruncatedIcosahedron] gives a list of Polygons with analytic \
vertices representing this Archimedean solid."

TruncatedOctahedron::usage =
"Polyhedorn[TruncatedOctahedron] gives a list of Polygons with analytic \
vertices representing this Archimedean solid."

TruncatedTetrahedron::usage =
"Polyhedron[TruncatedTetrahedron] gives a list of Polygons with analytic \
vertices representing this Archimedean solid."


Begin["`Private`"]

Archimedean[ 1]:=Cuboctahedron
Archimedean[ 2]:=GreatRhombicosidodecahedron
Archimedean[ 3]:=GreatRhombicuboctahedron
Archimedean[ 4]:=Icosidodecahedron
Archimedean[ 5]:=SmallRhombicosidodecahedron
Archimedean[ 6]:=SmallRhombicuboctahedron
Archimedean[ 7]:=SnubCube
Archimedean[ 8]:=SnubDodecahedron
Archimedean[ 9]:=TruncatedCube
Archimedean[10]:=TruncatedDodecahedron
Archimedean[11]:=TruncatedIcosahedron
Archimedean[12]:=TruncatedOctahedron
Archimedean[13]:=TruncatedTetrahedron

Inradius[Cuboctahedron]:=3/4
Midradius[Cuboctahedron]:=Sqrt[3]/2
Circumradius[Cuboctahedron]:=1

Inradius[GreatRhombicosidodecahedron]:=1/241(105+6Sqrt[5])Sqrt[31+12Sqrt[5]]
Midradius[GreatRhombicosidodecahedron]:=1/2Sqrt[30+12Sqrt[5]]
Circumradius[GreatRhombicosidodecahedron]:= 1/2Sqrt[31+12Sqrt[5]]

Inradius[GreatRhombicuboctahedron]:=3/97(14+Sqrt[2])Sqrt[13+6Sqrt[2]]
Midradius[GreatRhombicuboctahedron]:=1/2Sqrt[12+6Sqrt[2]]
Circumradius[GreatRhombicuboctahedron]:=1/2Sqrt[13+6Sqrt[2]]

Inradius[Icosidodecahedron]:=1/8(5+3Sqrt[5])
Midradius[Icosidodecahedron]:=1/2Sqrt[5+2Sqrt[5]]
Circumradius[Icosidodecahedron]:=1/2(1+Sqrt[5])

Inradius[SmallRhombicosidodecahedron]:=1/41(15+2Sqrt[5])Sqrt[11+4Sqrt[5]]
Midradius[SmallRhombicosidodecahedron]:=1/2Sqrt[10+4Sqrt[5]]
Circumradius[SmallRhombicosidodecahedron]:=1/2Sqrt[11+4Sqrt[5]]

Inradius[SmallRhombicuboctahedron]:=1/17(6+Sqrt[2])Sqrt[5+2Sqrt[2]]
Midradius[SmallRhombicuboctahedron]:=1/2Sqrt[4+2Sqrt[2]]
Circumradius[SmallRhombicuboctahedron]:=1/2Sqrt[5+2Sqrt[2]]

Inradius[SnubCube]:=Root[-1+64#1^2-1248#1^4+896#1^6&,2]
Midradius[SnubCube]:=Root[-1+20#1^2-112#1^4+64#1^6&,2]
Circumradius[SnubCube]:=Root[-7+44#1^2-80#1^4+32#1^6&,2]

Inradius[SnubDodecahedron]:=Root[1-128#1^2+6384#1^4-149376#1^6+1443072#1^8-3900416#1^10+856064#1^12&,8]
Midradius[SnubDodecahedron]:=Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8]
Circumradius[SnubDodecahedron]:=Root[209-2696#1^2+13872#1^4-35776#1^6+47104#1^8-27648#1^10+4096#1^12&,8]

Inradius[TruncatedCube]:=1/17(5+2Sqrt[2])Sqrt[7+4Sqrt[2]]
Midradius[TruncatedCube]:=1/2(2+Sqrt[2])
Circumradius[TruncatedCube]:=1/2Sqrt[7+4Sqrt[2]]

Inradius[TruncatedDodecahedron]:=5/488(17Sqrt[2]+3Sqrt[10])Sqrt[37+15Sqrt[5]]
Midradius[TruncatedDodecahedron]:=1/4(5+3Sqrt[5])
Circumradius[TruncatedDodecahedron]:=1/4Sqrt[74+30Sqrt[5]]

Inradius[TruncatedIcosahedron]:=9/872(21+Sqrt[5])Sqrt[58+18Sqrt[5]]
Midradius[TruncatedIcosahedron]:=3/4(1+Sqrt[5])
Circumradius[TruncatedIcosahedron]:=1/4Sqrt[58+18Sqrt[5]]

Inradius[TruncatedOctahedron]:=9/20Sqrt[10]
Midradius[TruncatedOctahedron]:=3/2
Circumradius[TruncatedOctahedron]:=1/2Sqrt[10]

Inradius[TruncatedTetrahedron]:=9/44Sqrt[22]
Midradius[TruncatedTetrahedron]:=3/4Sqrt[2]
Circumradius[TruncatedTetrahedron]:=1/4Sqrt[22]

(* Archimedean Compound *)

ArchimedeanCompound[1]:=MidpointCumulate[
	Polyhedron[Cuboctahedron],
	{{3,1/4/Sqrt[6]},{4,1/2/Sqrt[2]}}
]
	
ArchimedeanCompound[2]:={}

ArchimedeanCompound[3]:={}

ArchimedeanCompound[4]:=MidpointCumulate[
	Polyhedron[Icosidodecahedron],
	{{3,Sqrt[(7-3Sqrt[5])/6]/4},{5,Sqrt[(5+2Sqrt[5])/5]/4}}
]
 	
ArchimedeanCompound[5]:={}

ArchimedeanCompound[6]:=MidpointCumulate[
	Polyhedron[SmallRhombicuboctahedron],
	{{3,Sqrt[(11-6Sqrt[2])/3]/14},{4,(Sqrt[2]-1)/2}}
]

ArchimedeanCompound[7]:=MidpointCumulate[
	Polyhedron[SnubCube],
{{3,Root[-1+216#1^2-864#1^4+3456#1^6&,2]},
{4,Root[-1+16#1^2+96#1^4+128#1^6&,2]}}
]

ArchimedeanCompound[8]:=MidpointCumulate[
	Polyhedron[TruncatedCube],
	{{8,(1+Sqrt[2])/2},{3,Sqrt[(17-12Sqrt[2])/3]/2}}
]

ArchimedeanCompound[9]:={}

ArchimedeanCompound[10]:=MidpointCumulate[
	Polyhedron[TruncatedDodecahedron],
	{{3,Sqrt[(63+5Sqrt[5])/6]/62},{10,Sqrt[(5+Sqrt[5])/2]/2}}
]

ArchimedeanCompound[11]:=MidpointCumulate[
	Polyhedron[TruncatedIcosahedron],
	{{5,Sqrt[(305+131Sqrt[5])/10]/38},{6,Sqrt[3/2(7-3Sqrt[5])]/2}}
]

ArchimedeanCompound[12]:=MidpointCumulate[
	Polyhedron[TruncatedOctahedron],
	{{4,Sqrt[2]/8},{6,Sqrt[6]/4}}
]

ArchimedeanCompound[13]:=MidpointCumulate[
	Polyhedron[TruncatedTetrahedron],
	{{3,Sqrt[6]/30},{6,Sqrt[6]/2}}
]

(* Archimedean Duals *)

ArchimedeanDual[n_Integer]:={PolyhedronDual[Archimedean[n]]} /; 1<=n<=13

ArchimedeanDuals:=ArchimedeanDual/@Range[13]


(* Archimedeans *)

Archimedeans:=Archimedean/@Range[13]

(* Cuboctahedron *)

PolyhedronName[Cuboctahedron]:="cuboctahedron"
NetFaces[Cuboctahedron]:={{2,4,5},{5,4,8,9},{9,8,13},{4,7,8},{1,3,7,4},{8,7,11,12},{12,11,15},{6,10,11},{11,10,14,15},{15,14,17},{12,15,18,16},{16,18,19},{19,18,20,21},{21,20,22}}
NetVertices[Cuboctahedron]:={{-(1/Sqrt[3]),-1},{-(1/Sqrt[3]),0},{(3-2Sqrt[3])/6,(-2-Sqrt[3])/2},{1/(2Sqrt[3]),-1/2},{1/(2Sqrt[3]),1/2},{(3+Sqrt[3])/6,(-3-Sqrt[3])/2},{(3+Sqrt[3])/6,(-1-Sqrt[3])/2},{(6+Sqrt[3])/6,-1/2},{(6+Sqrt[3])/6,1/2},{(3+4Sqrt[3])/6,(-4-Sqrt[3])/2},{(3+4Sqrt[3])/6,(-2-Sqrt[3])/2},{(3+2Sqrt[3])/3,-1},{(3+2Sqrt[3])/3,0},{(9+4Sqrt[3])/6,(-4-Sqrt[3])/2},{(9+4Sqrt[3])/6,(-2-Sqrt[3])/2},{(6+7Sqrt[3])/6,-1/2},{(9+7Sqrt[3])/6,(-3-Sqrt[3])/2},{(9+7Sqrt[3])/6,(-1-Sqrt[3])/2},{(12+7Sqrt[3])/6,-1/2},{(9+10Sqrt[3])/6,(-2-Sqrt[3])/2},{(6+5Sqrt[3])/3,-1},{(5(3+2Sqrt[3]))/6,(-2-Sqrt[3])/2}}
PolyhedronDual[Cuboctahedron]:=RhombicDodecahedron
PolyhedronFaces[Cuboctahedron]:=
{{4,10,8,2},{3,9,11,5},{9,6,8,12},{3,1,2,6},{5,7,4,1},{11,12,10,7},{12,11,
    9},{3,5,1},{6,9,3},{5,11,7},{8,10,12},{1,4,2},{2,8,6},{7,10,4}}
PolyhedronVertices[Cuboctahedron]:=
{{-1,0,0},{-1/2,-1/2,-(1/Sqrt[2])},
{-1/2,-1/2,1/Sqrt[2]},{-1/2,1/2,-(1/Sqrt[2])},
{-1/2,1/2,1/Sqrt[2]},{0,-1,0},{0,1,0},
{1/2,-1/2,-(1/Sqrt[2])},{1/2,-1/2,1/Sqrt[2]},
{1/2,1/2,-(1/Sqrt[2])},{1/2,1/2,1/Sqrt[2]},{1,0,0}}

(* Deltoidal Hexecontahedron *)

PolyhedronName[DeltoidalHexecontahedron]:="deltoidal hexecontahedron"
NetFaces[DeltoidalHexecontahedron]:={{33,29,24,22},{33,22,20,26},{33,26,32,41},{33,41,45,44},
{33,44,43,36},{28,16,24,29},{28,29,38,40},{28,40,42,34},{28,34,25,19},{28,19,13,15},{9,11,20,22},
{9,22,23,14},{9,14,6,4},{9,4,1,2},{9,2,3,7},{21,31,32,26},{21,26,17,12},{21,12,5,8},{21,8,10,18},
{21,18,27,30},{47,51,45,41},{47,41,35,37},{47,37,39,46},{47,46,52,56},{47,56,58,55},{54,49,43,44},
{54,44,48,53},{54,53,59,62},{54,62,64,61},{54,61,57,50},{68,75,84,79},{68,79,73,66},{68,66,64,62},
{68,62,60,63},{68,63,65,71},{89,101,97,88},{89,88,83,78},{89,78,74,81},{89,81,87,95},{89,95,103,104},
{113,112,106,102},{113,102,98,105},{113,105,110,116},{113,116,121,122},{113,122,120,115},{109,96,94,100},
{109,100,108,114},{109,114,118,119},{109,119,117,111},{109,111,107,99},{82,72,80,86},{82,86,92,93},
{82,93,91,85},{82,85,76,70},{82,70,67,69},{90,79,84,88},{90,88,97,102},{90,102,106,100},{90,100,94,86},
{90,86,80,77}}
NetVertices[DeltoidalHexecontahedron]:={{-3.08833572923,0.641509221705},{-2.92700102126,0.0122346606165},
{-2.70022373872,-0.596524261577},{-2.61051993394,1.08163128091},{-2.14974158858,-1.37845515939},
{-2.08896677291,1.46892659646},{-2.05666433631,-0.685105618551},{-1.98840688061,-2.00772972048},
{-1.97279056825,0.311370769042},{-1.76162959806,-2.61648864267},{-1.69256484556,-0.648563366375},
{-1.67192579328,-0.938333100188},{-1.57323330852,2.27420016506},{-1.50085056964,1.19300143871},
{-1.41189860055,1.64492560397},{-1.24039771319,1.32167458542},{-1.15037263225,-0.551037784637},
{-1.11807019565,-2.70506999965},{-1.09541751322,2.71432222426},{-1.07944438301,-0.433857382216},
{-1.03419642759,-1.70859361205},{-0.978165739025,0.207826338554},{-0.945101407048,0.85661144256},
{-0.809801596111,0.835256714461},{-0.573864352191,3.10161753981},{-0.562256428978,-0.826962942382},
{-0.468758482208,-2.72531005927},{-0.457688147535,1.9440617124},{-0.177462424841,0.984127576979},
{-0.143413883677,-2.16302343001},{-0.0395715983674,-1.81213804254},{-0.00650726638988,-1.16335293854},
{0.,0.},{0.014251851082,2.82569238207},{0.07515443278469999,-1.27332307148},
{0.188460498661,0.982080770835},{0.236489140755,-1.90259763257},{0.435658037708,1.19883356114},
{0.463266423302,-2.51135655476},{0.536936681692,1.84051728191},{0.552970228079,-0.833201012277},
{0.57000101367,2.48930238591},{0.819094722771,0.826145410473},{0.980429430741,0.196870849384},
{1.07452338911,-0.445905696725},{1.10682582571,-2.59993791174},{1.19069959377,-1.60346152414},
{1.20720671329,-0.41188807281},{1.29691051806,1.26626746968},{1.61671016133,1.44412123974},
{1.66263959238,-0.721830854471},{1.75613753915,-2.62017797136},{1.85076611569,-0.500469429784},
{1.93463988375,0.49600695781},{1.94821037046,-0.950638865842},{2.08148213768,-2.0578913421},
{2.24267446659,1.61785681403},{2.34573423521,-1.46443857213},{2.50007782914,-0.520709489403},
{2.62520808409,-0.57642737296},{2.69215066045,1.14882961611},{2.82542242767,0.0415771398494},
{3.07468427795,-1.04545457088},{3.08967452519,0.635029909818},{3.57110311096,-1.46448166243},
{3.73750156935,0.683356735527},{3.7451089792,2.4035489347},{3.75914935688,-0.316408923663},
{3.99575860435,1.80422420916},{4.15424671232,2.90814944656},{4.1752628557,-1.22572160701},
{4.2122077198,1.5091758135},{4.3868132828,0.663116675908},{4.43454876665,-1.87546600064},
{4.47452997228,-1.01514390569},{4.61430222188,3.36680431609},{4.63277706175,0.44496485983},
{4.63476311023,-1.25746148783},{4.67650556696,0.081658387011},{4.70862655281,1.09014872195},
{4.8840249605,-2.34449319856},{4.89667279873,2.23822146072},{4.89901520775,-0.664008717866},
{4.90328284951,-0.527100535182},{5.23614167585,3.17883874818},{5.31278629755,1.32890877737},
{5.38044379352,-2.76352029012},{5.54684225191,-0.615681892157},{5.56849003944,-1.61544755135},
{5.63071601997,0.380794495437},{5.83469935037,2.92636286518},{5.88840774805,1.63003218555},
{5.89581563433,2.27961704102},{5.93875060281,1.50264435165},{5.98460353826,-2.5247602347},
{6.13896494639,2.12064886446},{6.19615396536,-0.635921951776},{6.32128422031,-0.691639835333},
{6.33026578919,2.43259078679},{6.38822679667,1.03361715374},{6.48584624952,-1.21738024067},
{6.52149856389,-0.0736353225234},{6.56022498875,-2.22363682651},{6.56763287504,-1.57405197104},
{6.77076041416,-1.16066703325},{6.78575066141,0.519817447445},{6.79032129875,2.89124565633},
{6.88464562968,0.614590062179},{7.0726918756,1.76266280095},{7.26717924718,-1.57969412481},
{7.41216075272,2.70328008841},{7.43357770557,0.568144273154},{7.4552254931,-0.431621386035},
{7.48880537442,0.853350117601},{7.79469437021,0.508995901425},{7.87133899192,-1.34093406939},
{8.01071842724,2.45080420541},{8.06442682491,1.15447352579},{8.0718347112,1.80405838125},
{8.39325204474,0.256520018424},{8.44696044241,-1.0398106612},{8.4543683287,-0.390225805733}}
PolyhedronDual[DeltoidalHexecontahedron]:=SmallRhombicosidodecahedron
PolyhedronFaces[DeltoidalHexecontahedron]:=
{{43,33,1,7},{8,2,34,44},{33,45,9,1},{2,10,46,34},{31,15,5,3},{3,6,14,31},{17,
    32,4,11},{12,4,32,16},{39,5,43,7},{40,8,44,6},{9,45,11,41},{12,46,10,
    42},{39,7,1,47},{48,2,8,40},{1,9,41,47},{48,42,10,2},{53,3,5,19},{18,6,3,
    53},{11,4,54,21},{20,54,4,12},{33,37,23,35},{24,38,34,36},{15,25,43,5},{6,
    44,26,14},{45,27,17,11},{12,16,28,46},{29,37,25,15},{14,26,38,29},{27,35,
    30,17},{16,30,36,28},{29,13,23,37},{38,24,13,29},{23,13,30,35},{36,30,13,
    24},{15,31,14,29},{25,37,33,43},{44,34,38,26},{33,35,27,45},{46,28,36,
    34},{17,30,16,32},{19,5,39,57},{58,40,6,18},{41,11,21,59},{60,20,12,
    42},{19,57,51,55},{55,52,58,18},{49,59,21,56},{56,20,60,50},{55,51,61,
    22},{22,62,52,55},{61,49,56,22},{22,56,50,62},{55,18,53,19},{57,39,47,
    51},{52,48,40,58},{47,41,59,49},{50,60,42,48},{54,20,56,21},{49,61,51,
    47},{50,48,52,62}}
PolyhedronVertices[DeltoidalHexecontahedron]:=
{{0,0,-Sqrt[5]},{0,0,Sqrt[5]},{0,-Sqrt[5],0},{0,Sqrt[5],0},
{0,(-5-3Sqrt[5])/6,(-5-Sqrt[5])/6},
{0,(-5-3Sqrt[5])/6,(5+Sqrt[5])/6},{0,(-15-Sqrt[5])/22,
(-25-9Sqrt[5])/22},{0,(-15-Sqrt[5])/22,(25+9Sqrt[5])/22},
{0,(15+Sqrt[5])/22,(-25-9Sqrt[5])/22},
{0,(15+Sqrt[5])/22,(25+9Sqrt[5])/22},
{0,(5+3Sqrt[5])/6,(-5-Sqrt[5])/6},
{0,(5+3Sqrt[5])/6,(5+Sqrt[5])/6},{-Sqrt[5],0,0},
{-Sqrt[5]/2,(-5-Sqrt[5])/4,(5-Sqrt[5])/4},
{-Sqrt[5]/2,(-5-Sqrt[5])/4,(-5+Sqrt[5])/4},
{-Sqrt[5]/2,(5+Sqrt[5])/4,(5-Sqrt[5])/4},
{-Sqrt[5]/2,(5+Sqrt[5])/4,(-5+Sqrt[5])/4},
{Sqrt[5]/2,(-5-Sqrt[5])/4,(5-Sqrt[5])/4},
{Sqrt[5]/2,(-5-Sqrt[5])/4,(-5+Sqrt[5])/4},
{Sqrt[5]/2,(5+Sqrt[5])/4,(5-Sqrt[5])/4},
{Sqrt[5]/2,(5+Sqrt[5])/4,(-5+Sqrt[5])/4},{Sqrt[5],0,0},
{(-25-9Sqrt[5])/22,0,(-15-Sqrt[5])/22},
{(-25-9Sqrt[5])/22,0,(15+Sqrt[5])/22},
{(-5-4Sqrt[5])/11,(-5-4Sqrt[5])/11,(-5-4Sqrt[5])/11},
{(-5-4Sqrt[5])/11,(-5-4Sqrt[5])/11,(5+4Sqrt[5])/11},
{(-5-4Sqrt[5])/11,(5+4Sqrt[5])/11,(-5-4Sqrt[5])/11},
{(-5-4Sqrt[5])/11,(5+4Sqrt[5])/11,(5+4Sqrt[5])/11},
{(-5-3Sqrt[5])/6,(-5-Sqrt[5])/6,0},
{(-5-3Sqrt[5])/6,(5+Sqrt[5])/6,0},
{(-15-Sqrt[5])/22,(-25-9Sqrt[5])/22,0},
{(-15-Sqrt[5])/22,(25+9Sqrt[5])/22,0},
{(-5-Sqrt[5])/6,0,(-5-3Sqrt[5])/6},
{(-5-Sqrt[5])/6,0,(5+3Sqrt[5])/6},
{(-5-Sqrt[5])/4,(5-Sqrt[5])/4,-Sqrt[5]/2},
{(-5-Sqrt[5])/4,(5-Sqrt[5])/4,Sqrt[5]/2},
{(-5-Sqrt[5])/4,(-5+Sqrt[5])/4,-Sqrt[5]/2},
{(-5-Sqrt[5])/4,(-5+Sqrt[5])/4,Sqrt[5]/2},
{(5-Sqrt[5])/4,-Sqrt[5]/2,(-5-Sqrt[5])/4},
{(5-Sqrt[5])/4,-Sqrt[5]/2,(5+Sqrt[5])/4},
{(5-Sqrt[5])/4,Sqrt[5]/2,(-5-Sqrt[5])/4},
{(5-Sqrt[5])/4,Sqrt[5]/2,(5+Sqrt[5])/4},
{(-5+Sqrt[5])/4,-Sqrt[5]/2,(-5-Sqrt[5])/4},
{(-5+Sqrt[5])/4,-Sqrt[5]/2,(5+Sqrt[5])/4},
{(-5+Sqrt[5])/4,Sqrt[5]/2,(-5-Sqrt[5])/4},
{(-5+Sqrt[5])/4,Sqrt[5]/2,(5+Sqrt[5])/4},
{(5+Sqrt[5])/6,0,(-5-3Sqrt[5])/6},
{(5+Sqrt[5])/6,0,(5+3Sqrt[5])/6},
{(5+Sqrt[5])/4,(5-Sqrt[5])/4,-Sqrt[5]/2},
{(5+Sqrt[5])/4,(5-Sqrt[5])/4,Sqrt[5]/2},
{(5+Sqrt[5])/4,(-5+Sqrt[5])/4,-Sqrt[5]/2},
{(5+Sqrt[5])/4,(-5+Sqrt[5])/4,Sqrt[5]/2},
{(15+Sqrt[5])/22,(-25-9Sqrt[5])/22,0},
{(15+Sqrt[5])/22,(25+9Sqrt[5])/22,0},
{(5+3Sqrt[5])/6,(-5-Sqrt[5])/6,0},
{(5+3Sqrt[5])/6,(5+Sqrt[5])/6,0},
{(5+4Sqrt[5])/11,(-5-4Sqrt[5])/11,(-5-4Sqrt[5])/11},
{(5+4Sqrt[5])/11,(-5-4Sqrt[5])/11,(5+4Sqrt[5])/11},
{(5+4Sqrt[5])/11,(5+4Sqrt[5])/11,(-5-4Sqrt[5])/11},
{(5+4Sqrt[5])/11,(5+4Sqrt[5])/11,(5+4Sqrt[5])/11},
{(25+9Sqrt[5])/22,0,(-15-Sqrt[5])/22},
{(25+9Sqrt[5])/22,0,(15+Sqrt[5])/22}}

(* Deltoidal Icositetrahedron *)

PolyhedronName[DeltoidalIcositetrahedron]:="deltoidal icositetrahedron"
NetFaces[DeltoidalIcositetrahedron]:={{6,9,14,11},{16,18,14,9},{20,15,14,18},{3,8,7,1},{16,9,7,8},{4,2,7,9},
{19,17,13,12},{16,8,13,17},{5,10,13,8},{27,21,22,25},{16,17,22,21},{23,24,22,17},{28,33,29,26},{35,31,29,33},
{27,25,29,31},{44,42,37,38},{35,33,37,42},{30,36,37,33},{48,43,45,50},{35,42,45,43},{47,49,45,42},{32,34,39,40},
{35,43,39,34},{46,41,39,43}}
NetVertices[DeltoidalIcositetrahedron]:={{-0.717169671553,-1.56293776056},{-0.708574552532,-1.37178918934},
{-0.49304027041,-2.53749715411},{-0.397883124879,-0.421278359951},{-0.134572525766,-2.99278531964},
{0.,0.},{0.0538725395261,-1.50184064366},{0.43818899398100003,-2.17306326828},
{0.496880137844,-0.867819179678},{0.760190736957,-3.43932613937},{0.931229264391,0.36443388583},
{0.948019728299,-3.47582165091},{1.00049784286,-2.70414490742},{1.10458418488,-0.389347926435},
{1.12157570781,0.383924494583},{1.22388543544,-1.55445102956},{1.72076557328,-2.42227020924},
{1.79664695518,-0.734728978195},{1.94489497442,-3.39682960278},{2.10733838284,0.215781851193},
{2.15511469983,-1.19001714373},{2.32846962031,-1.943798956},{2.44777087087,-3.10890205912},
{3.02053239062,-2.28918000776},{3.0841413475,-2.10872072438},{3.12273327544,-2.2961302104},
{3.15198994595,-1.1110250956},{3.5792437972,-3.18584822388},{3.85518355858,-2.04762360748},
{4.03850885676,-3.53920645952},{4.12899279768,-1.32425133158},{4.36665263887,0.0621364895147},
{4.39251496525,-2.60396334933},{4.54579913906,-0.921685918988},{5.00230966082,-1.81140393247},
{5.01551170849,-3.7524326955},{5.06798982305,-2.98075595201},{5.20655231033,-3.74170232731},
{5.27824942219,-0.67317931607},{5.36610343814,0.0952740792913},{5.55205866129,0.050192959831},
{5.69702179275,-2.53069181208},{5.81558082886,-1.22951905792},{6.15353231451,-3.42040982556},
{6.16867303719,-1.9176795344},{6.42537552443,-0.436959641065},{6.57033865589,-3.01784441297},
{6.76256083304,-0.908226556181},{6.92434476437,-2.08260130278},{6.94170733323,-1.89204896468}}
PolyhedronDual[DeltoidalIcositetrahedron]:=SmallRhombicuboctahedron
PolyhedronFaces[DeltoidalIcositetrahedron]:=
{{26,2,7,5},{6,8,3,25},{2,24,9,7},{8,10,23,3},{1,26,5,11},{11,6,25,1},{24,4,
    12,9},{10,12,4,23},{22,5,7,14},{15,8,6,21},{7,9,20,14},{15,19,10,8},{11,5,
    22,13},{13,21,6,11},{20,9,12,16},{16,12,10,19},{1,17,2,26},{25,3,17,1},{2,
    17,4,24},{23,4,17,3},{13,22,14,18},{18,15,21,13},{14,20,16,18},{18,16,19,
    15}}
PolyhedronVertices[DeltoidalIcositetrahedron]:=
{{-1,-1,0},{-1,0,-1},{-1,0,1},{-1,1,0},
{0,-1,-1},{0,-1,1},
{0,0,-Sqrt[2]},{0,0,Sqrt[2]},
{0,1,-1},{0,1,1},
{0,-Sqrt[2],0},{0,Sqrt[2],0},
{1,-1,0},{1,0,-1},{1,0,1},{1,1,0},
{-Sqrt[2],0,0},
{Sqrt[2],0,0},
{(4+Sqrt[2])/7,(4+Sqrt[2])/7,(4+Sqrt[2])/7},
{(4+Sqrt[2])/7,(4+Sqrt[2])/7,-1+(3+Sqrt[2])^(-1)},
{(4+Sqrt[2])/7,-1+(3+Sqrt[2])^(-1),(4+Sqrt[2])/7},
{(4+Sqrt[2])/7,-1+(3+Sqrt[2])^(-1),-1+(3+Sqrt[2])^(-1)},
{-1+(3+Sqrt[2])^(-1),(4+Sqrt[2])/7,(4+Sqrt[2])/7},
{-1+(3+Sqrt[2])^(-1),(4+Sqrt[2])/7,-1+(3+Sqrt[2])^(-1)},
{-1+(3+Sqrt[2])^(-1),-1+(3+Sqrt[2])^(-1),(4+Sqrt[2])/7},
{-1+(3+Sqrt[2])^(-1),-1+(3+Sqrt[2])^(-1),-1+(3+Sqrt[2])^(-1)}}

(* Disdyakis Dodecahedron *)

PolyhedronName[DisdyakisDodecahedron]:="disdyakis dodecahedron"
NetFaces[DisdyakisDodecahedron]:={{8,4,12},{12,4,9},{9,15,12},{12,15,17},{17,18,12},{12,18,11},{2,5,7},{7,5,10},
{10,15,7},{7,15,9},{9,3,7},{7,3,1},{16,21,14},{14,21,19},{19,15,14},{14,15,10},{10,6,14},{14,6,13},{25,26,22},
{22,26,20},{20,15,22},{22,15,19},{19,23,22},{22,23,24},{27,28,29},{29,28,32},{32,36,29},{29,36,31},{31,26,29},
{29,26,25},{38,45,37},{37,45,40},{40,36,37},{37,36,32},{32,30,37},{37,30,35},{50,49,44},{44,49,42},{42,36,44},
{44,36,40},{40,46,44},{44,46,48},{41,33,39},{39,33,34},{34,36,39},{39,36,42},{42,47,39},{39,47,43}}
NetVertices[DisdyakisDodecahedron]:={{-0.981950574124,-1.82661434192},{-0.918314183829,-2.20641099531},
{-0.839111324828,-0.836868440758},{-0.746765412868,-0.665087526679},{-0.460661844222,-3.09554222075},
{-0.317366293461,-3.22784050128},{-0.237738700707,-1.89714836735},{0.,0.},
{0.0836590020264,-1.2222188318},{0.286103568646,-2.43045469407},{0.351893506789,0.156416265076},
{0.469340487706,-0.581846945408},{0.605404033393,-3.61319089232},{0.85945444607,-2.91013701878},
{0.964454166201,-1.69571632785},{0.989063699762,-3.64636239367},{1.20312740914,-0.724616393187},
{1.34596665843,0.265129507972},{1.50662871985,-2.5359822104},{1.91344870367,-1.38042381629},
{1.96428105946,-3.42511343584},{2.11423303147,-2.10050160028},{2.12815757382,-3.31937348153},
{2.73162743593,-2.52198767433},{2.85950715976,-2.15874964722},{2.88866606337,-1.15917485846},
{2.96599518837,-2.52882448812},{3.52195684134,-3.36003242867},{3.60690941581,-2.1440449222},
{3.67939078623,-3.47514542921},{3.84932781454,-1.43689594127},{4.18809503093,-2.61420408892},
{4.51176912215,0.172778910569},{4.59667020813,-0.823610473959},{4.6400525374,-3.75286651202},
{4.77832925316,-1.80697205108},{4.81235818573,-3.0254483896},{5.02499346356,-3.74211609496},
{5.33753179797,-0.723858451472},{5.41269621603,-2.58000410502},{5.49781464684,0.00630301672299},
{5.68522823404,-1.38562393079},{5.83999178971,-0.170360196756},{5.96673573129,-2.07814099937},
{5.968657869,-3.41121204557},{6.11942181303,-3.28749186501},{6.54671738672,-0.877847956747},
{6.62812605774,-2.42655052472},{6.62889263948,-1.0547198814},{6.71379372547,-2.05110926593}}
PolyhedronDual[DisdyakisDodecahedron]:=GreatRhombicuboctahedron
PolyhedronFaces[DisdyakisDodecahedron]:=
{{15,3,23},{26,1,13},{2,8,23},{26,16,4},{22,4,16},{8,2,22},{25,13,1},{3,15,
    25},{23,3,11},{7,1,26},{2,23,14},{12,26,4},{12,4,22},{22,2,14},{7,25,
    1},{3,25,11},{14,23,17},{5,26,12},{23,11,17},{5,7,26},{22,14,18},{18,12,
    22},{11,25,6},{6,25,7},{8,9,23},{26,19,16},{9,15,23},{26,13,19},{10,8,
    22},{22,16,10},{15,20,25},{25,20,13},{16,19,21},{21,9,8},{13,21,19},{9,21,
    15},{21,20,15},{13,20,21},{10,21,8},{16,21,10},{24,5,12},{14,17,24},{24,7,
    5},{17,11,24},{11,6,24},{24,6,7},{18,14,24},{24,12,18}}
PolyhedronVertices[DisdyakisDodecahedron]:=
{{0,(3+6Sqrt[2])/7,(3+6Sqrt[2])/7},
{0,(-3-6Sqrt[2])/7,(-3-6Sqrt[2])/7},
{0,(3+6Sqrt[2])/7,(-3-6Sqrt[2])/7},
{0,(-3-6Sqrt[2])/7,(3+6Sqrt[2])/7},
{(3+6Sqrt[2])/7,0,(3+6Sqrt[2])/7},
{(3+6Sqrt[2])/7,(3+6Sqrt[2])/7,0},
{Sqrt[2],Sqrt[2],Sqrt[2]},
{-Sqrt[2],-Sqrt[2],-Sqrt[2]},
{(-3-6Sqrt[2])/7,0,(-3-6Sqrt[2])/7},
{(-3-6Sqrt[2])/7,(-3-6Sqrt[2])/7,0},
{Sqrt[2],Sqrt[2],-Sqrt[2]},
{Sqrt[2],-Sqrt[2],Sqrt[2]},
{-Sqrt[2],Sqrt[2],Sqrt[2]},
{Sqrt[2],-Sqrt[2],-Sqrt[2]},
{-Sqrt[2],Sqrt[2],-Sqrt[2]},
{-Sqrt[2],-Sqrt[2],Sqrt[2]},
{(3+6Sqrt[2])/7,0,(-3-6Sqrt[2])/7},
{(3+6Sqrt[2])/7,(-3-6Sqrt[2])/7,0},
{(-3-6Sqrt[2])/7,0,(3+6Sqrt[2])/7},
{(-3-6Sqrt[2])/7,(3+6Sqrt[2])/7,0},
{(-6-9Sqrt[2])/7,0,0},
{0,(-6-9Sqrt[2])/7,0},
{0,0,(-6-9Sqrt[2])/7},
{(6+9Sqrt[2])/7,0,0},
{0,(6+9Sqrt[2])/7,0},
{0,0,(6+9Sqrt[2])/7}}

(* Disdyakis Triacontahedron *)

PolyhedronName[DisdyakisTriacontahedron]:="disdyakis triacontahedron"
NetFaces[DisdyakisTriacontahedron]:={{34,35,39},{26,35,34},{22,35,26},{17,35,22},{24,35,17},{32,35,24},{38,35,32},{44,35,38},{46,35,44},{47,35,46},{34,33,25},{39,33,34},{43,33,39},{49,33,43},{42,33,49},{37,33,42},{29,33,37},{21,33,29},{20,33,21},{18,33,20},{22,10,16},{26,10,22},{19,10,26},{13,10,19},{8,10,13},{3,10,8},{2,10,3},{1,10,2},{7,10,1},{11,10,7},{24,14,31},{17,14,24},{12,14,17},{6,14,12},{5,14,6},{4,14,5},{9,14,4},{15,14,9},{23,14,15},{28,14,23},{38,40,45},{32,40,38},{30,40,32},{27,40,30},{36,40,27},{41,40,36},{50,40,41},{55,40,50},{53,40,55},{52,40,53},{46,56,48},{44,56,46},{51,56,44},{57,56,51},{59,56,57},{62,56,59},{61,56,62},{60,56,61},{58,56,60},{54,56,58},{77,68,75},{78,68,77},{73,68,78},{66,68,73},{64,68,66},{60,68,64},{61,68,60},{63,68,61},{65,68,63},{71,68,65},{83,79,89},{76,79,83},{72,79,76},{67,79,72},{69,79,67},{70,79,69},{74,79,70},{81,79,74},{87,79,81},{92,79,87},{97,106,104},{90,106,97},{93,106,90},{95,106,93},{102,106,95},{110,106,102},{115,106,110},{118,106,115},{116,106,118},{112,106,116},{100,114,99},{103,114,100},{111,114,103},{117,114,111},{120,114,117},{122,114,120},{121,114,122},{119,114,121},{113,114,119},{107,114,113},{91,96,85},{98,96,91},{105,96,98},{109,96,105},{108,96,109},{101,96,108},{94,96,101},{86,96,94},{82,96,86},{80,96,82},{77,88,78},{76,88,77},{83,88,76},{90,88,83},{97,88,90},{103,88,97},{100,88,103},{98,88,100},{91,88,98},{84,88,91}}
NetVertices[DisdyakisTriacontahedron]:={{-2.85502180042,-0.741645768258},{-2.78868588456,-0.108501343786},{-2.7001135482,0.521916975432},{-2.47288835012,-2.87240398412},{-2.40655243426,-2.23925955965},{-2.3179800979,-1.60884124043},{-2.3178539244,-1.08329323121},{-2.09632461224,0.723687232855},{-1.9357204741,-3.21405144708},{-1.79611715981,-0.230186703003},{-1.76899763044,-1.40582863168},{-1.71419116193,-1.40707098301},{-1.48581015794,0.904087945363},{-1.41398370951,-2.36094491886},{-1.38686418013,-3.53658684754},{-1.14503462396,-1.20945221595},{-1.10367670764,-1.2266702705},{-1.07371134708,0.488431309458},{-1.05214963846,0.43802907589400003},{-1.00737543122,1.12157573393},{-0.91880309486,1.75199405315},{-0.8798316600180001,-0.630712461061},{-0.853464177687,-3.18908612328},{-0.670016188151,-1.69272913997},{-0.636607542581,0.00177558494799},{-0.635156150914,-0.0429997666107},{-0.375133934991,-3.40680361185},{-0.332621439739,-2.82303263224},{-0.315014158896,1.95376431057},{-0.308798019132,-2.77365918738},{-0.25302270061,-2.17375798247},{-0.22022568277,-2.14324086816},{-0.0148067064715,0.999890374713},{0,0},{0.0499791692707,-0.998750260395},{0.16203394103,-3.74845107481},{0.295500295396,2.13416502308},{0.383563253194,-1.94147061074},{0.636275829378,0.0206248617664},{0.683770705618,-2.8953445466},{0.710890234991,-4.07098647527},{0.729160814884,1.66810615361},{0.901478793322,0.599364616655},{0.979878937404,-1.71858068109},{0.994077707486,-1.76106989823},{1.04621485326,-1.08543625662},{1.09023219809,-0.450349814213},{1.13478718962,-0.45501793740200003},{1.14615430243,1.18707731111},{1.24429023744,-3.72348575101},{1.51704681342,-2.06022814405},{1.55212515399,-2.10235654837},{1.66967259672,-2.72802012784},{1.67650392626,-0.0883620941972},{1.76513297539,-3.35743225998},{2.03878357801,-1.20712161584},{2.06590310739,-2.38276354451},{2.29468747132,-0.240419387956},{2.59930310983,-2.03526282025},{2.90713802638,-0.414133617608},{3.02468546912,-1.03979719708},{3.12014584778,-1.66920932922},{3.16417440495,-1.66093740086},{3.41477848714,-0.0299806811739},{3.78235795001,-1.81299469462},{3.93562122509,0.336072809862},{3.95019772006,-2.31102133798},{4.0040894974,-0.837886946272},{4.0677451628,-2.93668491746},{4.20723409863,-3.55782512124},{4.40550892534,-1.94320674443},{4.4578381808200005,-1.92686840155},{4.49548623226,0.0330489003744},{4.82541764369,-3.709882415},{4.93398926554,-1.55771736697},{4.97868091877,-1.56081491051},{5.00032518139,-0.924572942496},{5.04434252622,-0.28948650009},{5.04714919109,-2.73477466665},{5.258275126,0.73432280484},{5.44856861903,-3.84009446481},{5.47224903915,1.33389555311},{5.53854592594,-1.86383882},{5.55893199886,0.114359020817},{5.56809514798,0.158210763577},{5.70718671939,1.9255682687},{5.84293775924,-3.34034923249},{5.99899408436,-0.976152223616},{6.0874022199,-2.18637422047},{6.10872630837,-2.1469759731},{6.18627869304,0.00615346981785},{6.21947892564,-2.82703737214},{6.22627375111,-2.77263955257},{6.3415462513900005,1.9790500426},{6.36576268694,-3.39377975635},{6.40801024043,0.981261218168},{6.61636676913,-1.76282303666},{6.80942966838,-0.124058579993},{6.85313991118,-0.114242607341},{6.97068735392,-0.739906186813},{6.97739476966,2.01017845061},{6.98394623201,-3.54583705011},{7.11017628975,-1.3610463906},{7.13720950708,-1.39676954563},{7.20379880859,0.375686652323},{7.2056777794,-2.57072930176},{7.24926786116,0.406311114528},{7.28873274255,1.45489385456},{7.58033997498,0.888998512678},{7.60709720734,-3.67604909992},{7.72835983481,-1.51310368435},{7.77506230862,-1.54181206932},{7.88362739315,0.459792888427},{7.9500913822,-0.537995936004},{8.00146634755,-3.1763038676},{8.08640028152,-2.09709666536},{8.35151081014,-1.64331573416},{8.378007513950001,-2.66299200725},{8.51947591142,0.490921296437},{8.74587995035,-1.14357050185},{8.83081388432,-0.0643632996082},{9.12242111675,-0.630258641494}}
PolyhedronDual[DisdyakisTriacontahedron]:=GreatRhombicosidodecahedron
PolyhedronFaces[DisdyakisTriacontahedron]:=
{{15,23,5},{41,7,57},{6,23,18},{57,8,44},{5,23,1},{57,7,2},{1,23,6},{2,8,
    57},{14,25,3},{3,33,14},{25,15,5},{7,41,33},{58,53,4},{4,53,60},{6,18,
    58},{60,44,8},{34,5,1},{7,61,2},{1,6,34},{2,61,8},{25,22,3},{3,22,33},{5,
    28,25},{33,48,7},{55,58,4},{4,60,55},{58,31,6},{8,51,60},{28,5,34},{48,61,
    7},{34,6,31},{8,61,51},{13,16,24},{24,19,21},{32,26,13},{21,29,32},{16,11,
    24},{24,35,19},{32,36,26},{29,38,32},{15,11,23},{57,35,41},{36,18,23},{57,
    44,38},{17,25,14},{14,33,27},{11,15,25},{33,41,35},{18,36,58},{44,60,
    38},{42,53,58},{60,53,47},{23,11,16},{19,35,57},{26,36,23},{57,38,29},{9,
    13,24},{24,21,9},{32,13,9},{9,21,32},{11,25,17},{27,33,35},{42,58,36},{47,
    38,60},{23,16,13},{21,19,57},{13,26,23},{57,29,21},{17,14,24},{24,14,
    27},{32,53,42},{47,53,32},{24,11,17},{27,35,24},{42,36,32},{32,38,47},{25,
    37,20},{39,33,30},{40,58,45},{50,60,12},{20,37,59},{59,39,30},{62,40,
    45},{50,12,62},{59,54,10},{10,56,59},{10,54,62},{62,56,10},{59,22,20},{30,
    22,59},{45,55,62},{62,55,50},{20,22,25},{33,22,30},{37,25,28},{33,39,
    48},{40,31,58},{60,51,12},{45,58,55},{55,60,50},{43,37,34},{61,39,46},{34,
    40,49},{52,12,61},{54,43,34},{61,46,56},{34,49,54},{56,52,61},{37,28,
    34},{61,48,39},{31,40,34},{61,12,51},{59,37,43},{46,39,59},{49,40,62},{62,
    12,52},{59,43,54},{56,46,59},{54,49,62},{62,52,56}}
PolyhedronVertices[DisdyakisTriacontahedron]:=
{{0,0,(-3(5+4Sqrt[5]))/11},{0,0,(3(5+4Sqrt[5]))/11},{0,(-3(5+4Sqrt[5]))/11,0},
{0,(3(5+4Sqrt[5]))/11,0},{0,(-5+Sqrt[5])/2,(-5-Sqrt[5])/2},{0,(5-Sqrt[5])/2,(-5-Sqrt[5])/2},
{0,(-5+Sqrt[5])/2,(5+Sqrt[5])/2},{0,(5-Sqrt[5])/2,(5+Sqrt[5])/2},{(-3(5+4Sqrt[5]))/11,0,0},
{(3(5+4Sqrt[5]))/11,0,0},{-Sqrt[5],-Sqrt[5],-Sqrt[5]},{Sqrt[5],Sqrt[5],Sqrt[5]},
{(-5-Sqrt[5])/2,0,(-5+Sqrt[5])/2},{(-5+Sqrt[5])/2,(-5-Sqrt[5])/2,0},
{(-3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44},
{(-3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22},
{(-3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44},
{(-3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44},
{(-3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22},
{(3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44},{(-5-Sqrt[5])/2,0,(5-Sqrt[5])/2},
{(5-Sqrt[5])/2,(-5-Sqrt[5])/2,0},{(-3(5+Sqrt[5]))/10,0,(-3(5+3Sqrt[5]))/10},
{(-3(5+3Sqrt[5]))/10,(-3(5+Sqrt[5]))/10,0},{0,(-3(5+3Sqrt[5]))/10,(-3(5+Sqrt[5]))/10},
{(-3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22},
{(-3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44},
{(3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44},
{(-3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22},
{(3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44},
{(3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22,(-3(25+9Sqrt[5]))/44},
{(-3(5+3Sqrt[5]))/10,(3(5+Sqrt[5]))/10,0},{0,(-3(5+3Sqrt[5]))/10,(3(5+Sqrt[5]))/10},
{(3(5+Sqrt[5]))/10,0,(-3(5+3Sqrt[5]))/10},{-Sqrt[5],-Sqrt[5],Sqrt[5]},{-Sqrt[5],Sqrt[5],-Sqrt[5]},
{Sqrt[5],-Sqrt[5],-Sqrt[5]},{-Sqrt[5],Sqrt[5],Sqrt[5]},{Sqrt[5],-Sqrt[5],Sqrt[5]},
{Sqrt[5],Sqrt[5],-Sqrt[5]},{(-3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44},
{(-3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44},
{(3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22},
{(-3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44},
{(3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44},
{(3(25+9Sqrt[5]))/44,(-3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22},
{(-3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44},
{(3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44},
{(3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44,(-3(5+4Sqrt[5]))/22},
{(3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44},
{(3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22,(3(25+9Sqrt[5]))/44},
{(3(25+9Sqrt[5]))/44,(3(15+Sqrt[5]))/44,(3(5+4Sqrt[5]))/22},{(-5+Sqrt[5])/2,(5+Sqrt[5])/2,0},
{(5+Sqrt[5])/2,0,(-5+Sqrt[5])/2},{(5-Sqrt[5])/2,(5+Sqrt[5])/2,0},{(5+Sqrt[5])/2,0,(5-Sqrt[5])/2},
{(-3(5+Sqrt[5]))/10,0,(3(5+3Sqrt[5]))/10},{0,(3(5+3Sqrt[5]))/10,(-3(5+Sqrt[5]))/10},
{(3(5+3Sqrt[5]))/10,(-3(5+Sqrt[5]))/10,0},{0,(3(5+3Sqrt[5]))/10,(3(5+Sqrt[5]))/10},
{(3(5+Sqrt[5]))/10,0,(3(5+3Sqrt[5]))/10},{(3(5+3Sqrt[5]))/10,(3(5+Sqrt[5]))/10,0}}

(* Great Rhombicosidodecahedron *)

PolyhedronName[GreatRhombicosidodecahedron]:="great rhombicosidodecahedron"
NetFaces[GreatRhombicosidodecahedron]:=
{{16,20,34,27},{10,5,9,15,20,16},{9,8,14,15},{8,4,7,13,19,14},{19,13,26,32},{7,3,1,2,6,12,23,28,24,13},{33,22,17,21,32,38,48,52,49,39},{32,26,31,37,43,38},{38,43,54,50},{31,30,36,37},{30,25,29,35,42,36},{11,18,29,25},{64,69,86,78},{57,51,56,63,69,64},{56,55,62,63},{55,50,54,61,68,62},{68,61,77,84},{54,45,40,44,53,60,72,79,73,61},{85,71,66,70,84,90,97,101,98,91},{84,77,83,89,94,90},{90,94,103,99},{83,82,88,89},{82,76,81,87,93,88},{59,67,81,76},{112,116,130,123},{106,100,105,111,116,112},{105,104,110,111},{104,99,103,109,115,110},{115,109,122,128},{103,96,92,95,102,108,119,124,120,109},{129,118,113,117,128,134,141,145,142,135},{128,122,127,133,138,134},{134,138,147,143},{127,126,132,133},{126,121,125,131,137,132},{107,114,125,121},{156,161,178,170},{150,144,149,155,161,156},{149,148,154,155},{148,143,147,153,160,154},{160,153,169,176},{147,140,136,139,146,152,166,171,167,153},{177,165,158,164,176,183,192,197,193,184},{176,169,175,182,187,183},{183,187,199,194},{175,174,181,182},{174,168,173,180,186,181},{151,159,173,168},{208,212,226,219},{202,195,201,207,212,208},{201,200,206,207},{200,194,199,205,211,206},{211,205,218,224},{199,189,185,188,198,204,215,220,216,205},{225,214,209,213,224,230,234,237,235,231},{224,218,223,229,233,230},{230,233,238,236},{223,222,228,229},{222,217,221,227,232,228},{203,210,221,217},{58,47,41,46,57,64,74,80,75,65},{173,163,157,162,172,179,190,196,191,180}}
NetVertices[GreatRhombicosidodecahedron]:={{(-1-Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(-3-Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(-3-Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{-1,-1-Sqrt[3]},{-1,0},{-1/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{-1/2,(-2-3Sqrt[3])/2},{-1/2,(-2-Sqrt[3])/2},{-1/2,-Sqrt[3]/2},{-1/2,Sqrt[3]/2},{1/2,(-6-5Sqrt[3])/2},{1/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{1/2,(-2-3Sqrt[3])/2},{1/2,(-2-Sqrt[3])/2},{1/2,-Sqrt[3]/2},{1/2,Sqrt[3]/2},{(2+Sqrt[3]-Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{1,-3(1+Sqrt[3])},{1,-1-Sqrt[3]},{1,0},{(3+2Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(3+2Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(3+Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(3+Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(1+Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(1+Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(1+Sqrt[3])/2,(1+Sqrt[3])/2},{(1+Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(2+Sqrt[3])/2,(-5-6Sqrt[3])/2},{(2+Sqrt[3])/2,(-5-4Sqrt[3])/2},{(2+Sqrt[3])/2,(-3-4Sqrt[3])/2},{(2+Sqrt[3])/2,(-3-2Sqrt[3])/2},{(2+Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(2+Sqrt[3])/2,1/2},{(4+Sqrt[3])/2,(-5-6Sqrt[3])/2},{(4+Sqrt[3])/2,(-5-4Sqrt[3])/2},{(4+Sqrt[3])/2,(-3-4Sqrt[3])/2},{(4+Sqrt[3])/2,(-3-2Sqrt[3])/2},{(4+Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(5+2Sqrt[3]-Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(5+2Sqrt[3]-Sqrt[5])/2,(4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(5+Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(5+Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(9+4Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(9+4Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(9+4Sqrt[3]-Sqrt[5])/4,(4Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(9+4Sqrt[3]-Sqrt[5])/4,(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(9+2Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(9+2Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{2+Sqrt[3],-1-Sqrt[3]},{2+Sqrt[3],0},{(4+Sqrt[3]+Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(5+2Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(5+2Sqrt[3])/2,(-2-3Sqrt[3])/2},{(5+2Sqrt[3])/2,(-2-Sqrt[3])/2},{(5+2Sqrt[3])/2,-Sqrt[3]/2},{(5+2Sqrt[3])/2,Sqrt[3]/2},{(5+2Sqrt[3])/2,(2Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(7+2Sqrt[3])/2,(-6-5Sqrt[3])/2},{(7+2Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(7+2Sqrt[3])/2,(-2-3Sqrt[3])/2},{(7+2Sqrt[3])/2,(-2-Sqrt[3])/2},{(7+2Sqrt[3])/2,-Sqrt[3]/2},{(7+2Sqrt[3])/2,Sqrt[3]/2},{(7+2Sqrt[3])/2,(2Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(8+3Sqrt[3]-Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{4+Sqrt[3],-3(1+Sqrt[3])},{4+Sqrt[3],-1-Sqrt[3]},{4+Sqrt[3],0},{(15+6Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(15+6Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(15+4Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(15+4Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(15+4Sqrt[3]+Sqrt[5])/4,(4Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(15+4Sqrt[3]+Sqrt[5])/4,(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(7+3Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(7+3Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(7+3Sqrt[3])/2,(1+Sqrt[3])/2},{(7+2Sqrt[3]+Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(7+2Sqrt[3]+Sqrt[5])/2,(4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(8+3Sqrt[3])/2,(-5-6Sqrt[3])/2},{(8+3Sqrt[3])/2,(-5-4Sqrt[3])/2},{(8+3Sqrt[3])/2,(-3-4Sqrt[3])/2},{(8+3Sqrt[3])/2,(-3-2Sqrt[3])/2},{(8+3Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(8+3Sqrt[3])/2,1/2},{(10+3Sqrt[3])/2,(-5-6Sqrt[3])/2},{(10+3Sqrt[3])/2,(-5-4Sqrt[3])/2},{(10+3Sqrt[3])/2,(-3-4Sqrt[3])/2},{(10+3Sqrt[3])/2,(-3-2Sqrt[3])/2},{(10+3Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(11+4Sqrt[3]-Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(11+3Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(11+3Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(21+8Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(21+8Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(21+6Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(21+6Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{5+2Sqrt[3],-1-Sqrt[3]},{5+2Sqrt[3],0},{(10+3Sqrt[3]+Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(11+4Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(11+4Sqrt[3])/2,(-2-3Sqrt[3])/2},{(11+4Sqrt[3])/2,(-2-Sqrt[3])/2},{(11+4Sqrt[3])/2,-Sqrt[3]/2},{(11+4Sqrt[3])/2,Sqrt[3]/2},{(13+4Sqrt[3])/2,(-6-5Sqrt[3])/2},{(13+4Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(13+4Sqrt[3])/2,(-2-3Sqrt[3])/2},{(13+4Sqrt[3])/2,(-2-Sqrt[3])/2},{(13+4Sqrt[3])/2,-Sqrt[3]/2},{(13+4Sqrt[3])/2,Sqrt[3]/2},{(14+5Sqrt[3]-Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{7+2Sqrt[3],-3(1+Sqrt[3])},{7+2Sqrt[3],-1-Sqrt[3]},{7+2Sqrt[3],0},{(27+10Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(27+10Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(27+8Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(27+8Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(13+5Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(13+5Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(13+5Sqrt[3])/2,(1+Sqrt[3])/2},{(13+4Sqrt[3]+Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(14+5Sqrt[3])/2,(-5-6Sqrt[3])/2},{(14+5Sqrt[3])/2,(-5-4Sqrt[3])/2},{(14+5Sqrt[3])/2,(-3-4Sqrt[3])/2},{(14+5Sqrt[3])/2,(-3-2Sqrt[3])/2},{(14+5Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(14+5Sqrt[3])/2,1/2},{(16+5Sqrt[3])/2,(-5-6Sqrt[3])/2},{(16+5Sqrt[3])/2,(-5-4Sqrt[3])/2},{(16+5Sqrt[3])/2,(-3-4Sqrt[3])/2},{(16+5Sqrt[3])/2,(-3-2Sqrt[3])/2},{(16+5Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(17+6Sqrt[3]-Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(17+5Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(17+5Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(33+12Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(33+12Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(33+10Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(33+10Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{8+3Sqrt[3],-1-Sqrt[3]},{8+3Sqrt[3],0},{(16+5Sqrt[3]+Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(17+6Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(17+6Sqrt[3])/2,(-2-3Sqrt[3])/2},{(17+6Sqrt[3])/2,(-2-Sqrt[3])/2},{(17+6Sqrt[3])/2,-Sqrt[3]/2},{(17+6Sqrt[3])/2,Sqrt[3]/2},{(19+6Sqrt[3])/2,(-6-5Sqrt[3])/2},{(19+6Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(19+6Sqrt[3])/2,(-2-3Sqrt[3])/2},{(19+6Sqrt[3])/2,(-2-Sqrt[3])/2},{(19+6Sqrt[3])/2,-Sqrt[3]/2},{(19+6Sqrt[3])/2,Sqrt[3]/2},{(20+7Sqrt[3]-Sqrt[5])/2,(-20-24Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(20+7Sqrt[3]-Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{10+3Sqrt[3],-3(1+Sqrt[3])},{10+3Sqrt[3],-1-Sqrt[3]},{10+3Sqrt[3],0},{(39+14Sqrt[3]-Sqrt[5])/4,(-20-24Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(39+14Sqrt[3]-Sqrt[5])/4,(-20-24Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(39+14Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(39+14Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(39+12Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(39+12Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(19+7Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(19+7Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(19+7Sqrt[3])/2,(1+Sqrt[3])/2},{(19+6Sqrt[3]+Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(20+7Sqrt[3])/2,(-10-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(20+7Sqrt[3])/2,(-5-6Sqrt[3])/2},{(20+7Sqrt[3])/2,(-5-4Sqrt[3])/2},{(20+7Sqrt[3])/2,(-3-4Sqrt[3])/2},{(20+7Sqrt[3])/2,(-3-2Sqrt[3])/2},{(20+7Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(20+7Sqrt[3])/2,1/2},{(22+7Sqrt[3])/2,(-10-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(22+7Sqrt[3])/2,(-5-6Sqrt[3])/2},{(22+7Sqrt[3])/2,(-5-4Sqrt[3])/2},{(22+7Sqrt[3])/2,(-3-4Sqrt[3])/2},{(22+7Sqrt[3])/2,(-3-2Sqrt[3])/2},{(22+7Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(23+8Sqrt[3]-Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(23+7Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(23+7Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(45+16Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(45+16Sqrt[3]-Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(45+14Sqrt[3]+Sqrt[5])/4,(-20-24Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(45+14Sqrt[3]+Sqrt[5])/4,(-20-24Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(45+14Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(45+14Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{11+4Sqrt[3],-1-Sqrt[3]},{11+4Sqrt[3],0},{(22+7Sqrt[3]+Sqrt[5])/2,(-20-24Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(22+7Sqrt[3]+Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(23+8Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(23+8Sqrt[3])/2,(-2-3Sqrt[3])/2},{(23+8Sqrt[3])/2,(-2-Sqrt[3])/2},{(23+8Sqrt[3])/2,-Sqrt[3]/2},{(23+8Sqrt[3])/2,Sqrt[3]/2},{(25+8Sqrt[3])/2,(-6-5Sqrt[3])/2},{(25+8Sqrt[3])/2,(-4-6Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/4},{(25+8Sqrt[3])/2,(-2-3Sqrt[3])/2},{(25+8Sqrt[3])/2,(-2-Sqrt[3])/2},{(25+8Sqrt[3])/2,-Sqrt[3]/2},{(25+8Sqrt[3])/2,Sqrt[3]/2},{(26+9Sqrt[3]-Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{13+4Sqrt[3],-3(1+Sqrt[3])},{13+4Sqrt[3],-1-Sqrt[3]},{13+4Sqrt[3],0},{(51+18Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(51+18Sqrt[3]-Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(51+16Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(51+16Sqrt[3]+Sqrt[5])/4,(-8-12Sqrt[3]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(25+9Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(25+9Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(25+9Sqrt[3])/2,(1+Sqrt[3])/2},{(25+8Sqrt[3]+Sqrt[5])/2,(-8-12Sqrt[3]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/8},{(26+9Sqrt[3])/2,(-5-6Sqrt[3])/2},{(26+9Sqrt[3])/2,(-5-4Sqrt[3])/2},{(26+9Sqrt[3])/2,(-3-4Sqrt[3])/2},{(26+9Sqrt[3])/2,(-3-2Sqrt[3])/2},{(26+9Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(26+9Sqrt[3])/2,1/2},{(28+9Sqrt[3])/2,(-5-6Sqrt[3])/2},{(28+9Sqrt[3])/2,(-5-4Sqrt[3])/2},{(28+9Sqrt[3])/2,(-3-4Sqrt[3])/2},{(28+9Sqrt[3])/2,(-3-2Sqrt[3])/2},{(28+9Sqrt[3])/2,(-6-4Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/4},{(29+9Sqrt[3])/2,(-5(1+Sqrt[3]))/2},{(29+9Sqrt[3])/2,(-3(1+Sqrt[3]))/2},{(57+18Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]-Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(57+18Sqrt[3]+Sqrt[5])/4,(-12-8Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{14+5Sqrt[3],-1-Sqrt[3]},{(28+9Sqrt[3]+Sqrt[5])/2,(-12-8Sqrt[3]+Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/8},{(29+10Sqrt[3])/2,(-2-3Sqrt[3])/2}}
PolyhedronDual[GreatRhombicosidodecahedron]:=DisdyakisTriacontahedron
PolyhedronFaces[GreatRhombicosidodecahedron]:=
{{2,6,8,4,44,56,68,66,54,42},{109,29,17,19,31,111,103,107,105,101},{24,30,18,
    6,2,12},{7,3,15,27,31,19},{58,57,33,37,73,69,70,74,38,34},{84,116,120,88,
    87,119,115,83,91,92},{90,89,81,113,117,85,86,118,114,82},{36,40,76,72,71,
    75,39,35,59,60},{5,17,29,23,11,1},{4,8,20,32,28,16},{67,55,43,3,7,5,1,41,
    53,65},{18,30,110,102,106,108,104,112,32,20},{79,83,115,103,111,97},{38,
    74,62,48,42,54},{4,16,50,44},{23,29,109,95},{96,110,30,24},{43,49,15,
    3},{53,41,47,61,73,37},{98,112,104,116,84,80},{69,45,9,10,46,70},{26,100,
    92,91,99,25},{82,114,102,110,96,78},{55,39,75,63,49,43},{1,11,47,41},{28,
    32,112,98},{61,47,11,23,95,77,93,21,9,45},{50,16,28,98,80,100,26,14,52,
    64},{97,111,31,27},{42,48,12,2},{44,50,64,76,40,56},{77,95,109,101,113,
    81},{63,51,13,25,99,79,97,27,15,49},{46,10,22,94,78,96,24,12,48,62},{52,
    14,13,51,71,72},{22,21,93,89,90,94},{115,119,107,103},{34,38,54,66},{71,
    51,63,75},{94,90,82,78},{114,118,106,102},{35,39,55,67},{70,46,62,74},{99,
    91,83,79},{65,53,37,33},{104,108,120,116},{77,81,89,93},{76,64,52,72},{59,
    35,67,65,33,57},{106,118,86,88,120,108},{68,56,40,36},{101,105,117,
    113},{80,84,92,100},{73,61,45,69},{34,66,68,36,60,58},{105,107,119,87,85,
    117},{7,19,17,5},{6,18,20,8},{14,26,25,13},{9,21,22,10},{58,60,59,57},{85,
    87,88,86}}
PolyhedronVertices[GreatRhombicosidodecahedron]:=
{{-1,(-3-Sqrt[5])/4,(-7-3Sqrt[5])/4},
{-1,(-3-Sqrt[5])/4,(7+3Sqrt[5])/4},
{-1,(3+Sqrt[5])/4,(-7-3Sqrt[5])/4},
{-1,(3+Sqrt[5])/4,(7+3Sqrt[5])/4},
{-1/2,-1/2,-3/2-Sqrt[5]},{-1/2,-1/2,3/2+Sqrt[5]},
{-1/2,1/2,-3/2-Sqrt[5]},{-1/2,1/2,3/2+Sqrt[5]},
{-1/2,-3/2-Sqrt[5],-1/2},{-1/2,-3/2-Sqrt[5],1/2},
{-1/2,-1-Sqrt[5]/2,-2-Sqrt[5]/2},
{-1/2,-1-Sqrt[5]/2,(4+Sqrt[5])/2},
{-1/2,3/2+Sqrt[5],-1/2},{-1/2,3/2+Sqrt[5],1/2},
{-1/2,(2+Sqrt[5])/2,-2-Sqrt[5]/2},
{-1/2,(2+Sqrt[5])/2,(4+Sqrt[5])/2},
{1/2,-1/2,-3/2-Sqrt[5]},{1/2,-1/2,3/2+Sqrt[5]},
{1/2,1/2,-3/2-Sqrt[5]},{1/2,1/2,3/2+Sqrt[5]},
{1/2,-3/2-Sqrt[5],-1/2},{1/2,-3/2-Sqrt[5],1/2},
{1/2,-1-Sqrt[5]/2,-2-Sqrt[5]/2},
{1/2,-1-Sqrt[5]/2,(4+Sqrt[5])/2},
{1/2,3/2+Sqrt[5],-1/2},{1/2,3/2+Sqrt[5],1/2},
{1/2,(2+Sqrt[5])/2,-2-Sqrt[5]/2},
{1/2,(2+Sqrt[5])/2,(4+Sqrt[5])/2},
{1,(-3-Sqrt[5])/4,(-7-3Sqrt[5])/4},
{1,(-3-Sqrt[5])/4,(7+3Sqrt[5])/4},
{1,(3+Sqrt[5])/4,(-7-3Sqrt[5])/4},
{1,(3+Sqrt[5])/4,(7+3Sqrt[5])/4},
{(-7-3Sqrt[5])/4,-1,(-3-Sqrt[5])/4},
{(-7-3Sqrt[5])/4,-1,(3+Sqrt[5])/4},
{(-7-3Sqrt[5])/4,1,(-3-Sqrt[5])/4},
{(-7-3Sqrt[5])/4,1,(3+Sqrt[5])/4},
{(-5-3Sqrt[5])/4,(-5-Sqrt[5])/4,(-1-Sqrt[5])/2},
{(-5-3Sqrt[5])/4,(-5-Sqrt[5])/4,(1+Sqrt[5])/2},
{(-5-3Sqrt[5])/4,(5+Sqrt[5])/4,(-1-Sqrt[5])/2},
{(-5-3Sqrt[5])/4,(5+Sqrt[5])/4,(1+Sqrt[5])/2},
{(-5-Sqrt[5])/4,(-1-Sqrt[5])/2,(-5-3Sqrt[5])/4},
{(-5-Sqrt[5])/4,(-1-Sqrt[5])/2,(5+3Sqrt[5])/4},
{(-5-Sqrt[5])/4,(1+Sqrt[5])/2,(-5-3Sqrt[5])/4},
{(-5-Sqrt[5])/4,(1+Sqrt[5])/2,(5+3Sqrt[5])/4},
{(-3-Sqrt[5])/4,(-7-3Sqrt[5])/4,-1},
{(-3-Sqrt[5])/4,(-7-3Sqrt[5])/4,1},
{(-3-Sqrt[5])/4,(-3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2},
{(-3-Sqrt[5])/4,(-3(1+Sqrt[5]))/4,(3+Sqrt[5])/2},
{(-3-Sqrt[5])/4,(3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2},
{(-3-Sqrt[5])/4,(3(1+Sqrt[5]))/4,(3+Sqrt[5])/2},
{(-3-Sqrt[5])/4,(7+3Sqrt[5])/4,-1},
{(-3-Sqrt[5])/4,(7+3Sqrt[5])/4,1},
{(-3-Sqrt[5])/2,(-3-Sqrt[5])/4,(-3(1+Sqrt[5]))/4},
{(-3-Sqrt[5])/2,(-3-Sqrt[5])/4,(3(1+Sqrt[5]))/4},
{(-3-Sqrt[5])/2,(3+Sqrt[5])/4,(-3(1+Sqrt[5]))/4},
{(-3-Sqrt[5])/2,(3+Sqrt[5])/4,(3(1+Sqrt[5]))/4},
{-3/2-Sqrt[5],-1/2,-1/2},{-3/2-Sqrt[5],-1/2,1/2},
{-3/2-Sqrt[5],1/2,-1/2},{-3/2-Sqrt[5],1/2,1/2},
{(-1-Sqrt[5])/2,(-5-3Sqrt[5])/4,(-5-Sqrt[5])/4},
{(-1-Sqrt[5])/2,(-5-3Sqrt[5])/4,(5+Sqrt[5])/4},
{(-1-Sqrt[5])/2,(5+3Sqrt[5])/4,(-5-Sqrt[5])/4},
{(-1-Sqrt[5])/2,(5+3Sqrt[5])/4,(5+Sqrt[5])/4},
{-2-Sqrt[5]/2,-1/2,-1-Sqrt[5]/2},
{-2-Sqrt[5]/2,-1/2,(2+Sqrt[5])/2},
{-2-Sqrt[5]/2,1/2,-1-Sqrt[5]/2},
{-2-Sqrt[5]/2,1/2,(2+Sqrt[5])/2},
{-1-Sqrt[5]/2,-2-Sqrt[5]/2,-1/2},
{-1-Sqrt[5]/2,-2-Sqrt[5]/2,1/2},
{-1-Sqrt[5]/2,(4+Sqrt[5])/2,-1/2},
{-1-Sqrt[5]/2,(4+Sqrt[5])/2,1/2},
{(-3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2,(-3-Sqrt[5])/4},
{(-3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2,(3+Sqrt[5])/4},
{(-3(1+Sqrt[5]))/4,(3+Sqrt[5])/2,(-3-Sqrt[5])/4},
{(-3(1+Sqrt[5]))/4,(3+Sqrt[5])/2,(3+Sqrt[5])/4},
{(1+Sqrt[5])/2,(-5-3Sqrt[5])/4,(-5-Sqrt[5])/4},
{(1+Sqrt[5])/2,(-5-3Sqrt[5])/4,(5+Sqrt[5])/4},
{(1+Sqrt[5])/2,(5+3Sqrt[5])/4,(-5-Sqrt[5])/4},
{(1+Sqrt[5])/2,(5+3Sqrt[5])/4,(5+Sqrt[5])/4},
{(3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2,(-3-Sqrt[5])/4},
{(3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2,(3+Sqrt[5])/4},
{(3(1+Sqrt[5]))/4,(3+Sqrt[5])/2,(-3-Sqrt[5])/4},
{(3(1+Sqrt[5]))/4,(3+Sqrt[5])/2,(3+Sqrt[5])/4},
{3/2+Sqrt[5],-1/2,-1/2},{3/2+Sqrt[5],-1/2,1/2},
{3/2+Sqrt[5],1/2,-1/2},{3/2+Sqrt[5],1/2,1/2},
{(2+Sqrt[5])/2,-2-Sqrt[5]/2,-1/2},
{(2+Sqrt[5])/2,-2-Sqrt[5]/2,1/2},
{(2+Sqrt[5])/2,(4+Sqrt[5])/2,-1/2},
{(2+Sqrt[5])/2,(4+Sqrt[5])/2,1/2},
{(3+Sqrt[5])/4,(-7-3Sqrt[5])/4,-1},
{(3+Sqrt[5])/4,(-7-3Sqrt[5])/4,1},
{(3+Sqrt[5])/4,(-3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2},
{(3+Sqrt[5])/4,(-3(1+Sqrt[5]))/4,(3+Sqrt[5])/2},
{(3+Sqrt[5])/4,(3(1+Sqrt[5]))/4,(-3-Sqrt[5])/2},
{(3+Sqrt[5])/4,(3(1+Sqrt[5]))/4,(3+Sqrt[5])/2},
{(3+Sqrt[5])/4,(7+3Sqrt[5])/4,-1},
{(3+Sqrt[5])/4,(7+3Sqrt[5])/4,1},
{(3+Sqrt[5])/2,(-3-Sqrt[5])/4,(-3(1+Sqrt[5]))/4},
{(3+Sqrt[5])/2,(-3-Sqrt[5])/4,(3(1+Sqrt[5]))/4},
{(3+Sqrt[5])/2,(3+Sqrt[5])/4,(-3(1+Sqrt[5]))/4},
{(3+Sqrt[5])/2,(3+Sqrt[5])/4,(3(1+Sqrt[5]))/4},
{(4+Sqrt[5])/2,-1/2,-1-Sqrt[5]/2},
{(4+Sqrt[5])/2,-1/2,(2+Sqrt[5])/2},
{(4+Sqrt[5])/2,1/2,-1-Sqrt[5]/2},
{(4+Sqrt[5])/2,1/2,(2+Sqrt[5])/2},
{(5+Sqrt[5])/4,(-1-Sqrt[5])/2,(-5-3Sqrt[5])/4},
{(5+Sqrt[5])/4,(-1-Sqrt[5])/2,(5+3Sqrt[5])/4},
{(5+Sqrt[5])/4,(1+Sqrt[5])/2,(-5-3Sqrt[5])/4},
{(5+Sqrt[5])/4,(1+Sqrt[5])/2,(5+3Sqrt[5])/4},
{(5+3Sqrt[5])/4,(-5-Sqrt[5])/4,(-1-Sqrt[5])/2},
{(5+3Sqrt[5])/4,(-5-Sqrt[5])/4,(1+Sqrt[5])/2},
{(5+3Sqrt[5])/4,(5+Sqrt[5])/4,(-1-Sqrt[5])/2},
{(5+3Sqrt[5])/4,(5+Sqrt[5])/4,(1+Sqrt[5])/2},
{(7+3Sqrt[5])/4,-1,(-3-Sqrt[5])/4},
{(7+3Sqrt[5])/4,-1,(3+Sqrt[5])/4},
{(7+3Sqrt[5])/4,1,(-3-Sqrt[5])/4},
{(7+3Sqrt[5])/4,1,(3+Sqrt[5])/4}}

(* Great Rhombicuboctahedron *)

PolyhedronName[GreatRhombicuboctahedron]:="great rhombicuboctahedron"
NetFaces[GreatRhombicuboctahedron]:={{6,5,9,10},{5,2,1,4,8,14,15,9},{4,3,7,8},{16,12,15,21,26,22},{15,14,20,21},{14,11,13,19,25,20},{31,30,36,37},{30,21,20,29,35,44,45,36},{29,28,34,35},{46,40,45,51,54,52},{45,44,50,51},{44,39,43,49,53,50},{58,57,61,62},{57,51,50,56,60,66,67,61},{56,55,59,60},{68,64,67,71,74,72},{67,66,70,71},{66,63,65,69,73,70},{78,77,81,82},{77,71,70,76,80,86,87,81},{76,75,79,80},{88,84,87,91,94,92},{87,86,90,91},{86,83,85,89,93,90},{32,24,23,31,37,47,48,38},{28,18,17,27,33,41,42,34}}
NetVertices[GreatRhombicuboctahedron]:={{(-1-Sqrt[2])/2,(-3-Sqrt[2])/2},{(-1-Sqrt[2])/2,(-1-Sqrt[2])/2},{-1/2,(-5-2Sqrt[2])/2},{-1/2,(-3-2Sqrt[2])/2},{-1/2,-1/2},{-1/2,1/2},{1/2,(-5-2Sqrt[2])/2},{1/2,(-3-2Sqrt[2])/2},{1/2,-1/2},{1/2,1/2},{1/Sqrt[2],(-3-Sqrt[2]-Sqrt[3])/2},{1/Sqrt[2],(-1-Sqrt[2]+Sqrt[3])/2},{(1+Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(1+Sqrt[2])/2,(-3-Sqrt[2])/2},{(1+Sqrt[2])/2,(-1-Sqrt[2])/2},{(1+Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(3+Sqrt[2])/2,(-7-3Sqrt[2])/2},{(3+Sqrt[2])/2,(-5-3Sqrt[2])/2},{(3+Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(3+Sqrt[2])/2,(-3-Sqrt[2])/2},{(3+Sqrt[2])/2,(-1-Sqrt[2])/2},{(3+Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(3+Sqrt[2])/2,(1+Sqrt[2])/2},{(3+Sqrt[2])/2,(3+Sqrt[2])/2},{(4+Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(4+Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(3+2Sqrt[2])/2,(-7-4Sqrt[2])/2},{(3+2Sqrt[2])/2,(-5-2Sqrt[2])/2},{(3+2Sqrt[2])/2,(-3-2Sqrt[2])/2},{(3+2Sqrt[2])/2,-1/2},{(3+2Sqrt[2])/2,1/2},{(3+2Sqrt[2])/2,(3+2Sqrt[2])/2},{(5+2Sqrt[2])/2,(-7-4Sqrt[2])/2},{(5+2Sqrt[2])/2,(-5-2Sqrt[2])/2},{(5+2Sqrt[2])/2,(-3-2Sqrt[2])/2},{(5+2Sqrt[2])/2,-1/2},{(5+2Sqrt[2])/2,1/2},{(5+2Sqrt[2])/2,(3+2Sqrt[2])/2},{(4+3Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(4+3Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(5+3Sqrt[2])/2,(-7-3Sqrt[2])/2},{(5+3Sqrt[2])/2,(-5-3Sqrt[2])/2},{(5+3Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(5+3Sqrt[2])/2,(-3-Sqrt[2])/2},{(5+3Sqrt[2])/2,(-1-Sqrt[2])/2},{(5+3Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(5+3Sqrt[2])/2,(1+Sqrt[2])/2},{(5+3Sqrt[2])/2,(3+Sqrt[2])/2},{(7+3Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(7+3Sqrt[2])/2,(-3-Sqrt[2])/2},{(7+3Sqrt[2])/2,(-1-Sqrt[2])/2},{(7+3Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(8+3Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(8+3Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(7+4Sqrt[2])/2,(-5-2Sqrt[2])/2},{(7+4Sqrt[2])/2,(-3-2Sqrt[2])/2},{(7+4Sqrt[2])/2,-1/2},{(7+4Sqrt[2])/2,1/2},{(9+4Sqrt[2])/2,(-5-2Sqrt[2])/2},{(9+4Sqrt[2])/2,(-3-2Sqrt[2])/2},{(9+4Sqrt[2])/2,-1/2},{(9+4Sqrt[2])/2,1/2},{(8+5Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(8+5Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(9+5Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(9+5Sqrt[2])/2,(-3-Sqrt[2])/2},{(9+5Sqrt[2])/2,(-1-Sqrt[2])/2},{(9+5Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(11+5Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(11+5Sqrt[2])/2,(-3-Sqrt[2])/2},{(11+5Sqrt[2])/2,(-1-Sqrt[2])/2},{(11+5Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(12+5Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(12+5Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(11+6Sqrt[2])/2,(-5-2Sqrt[2])/2},{(11+6Sqrt[2])/2,(-3-2Sqrt[2])/2},{(11+6Sqrt[2])/2,-1/2},{(11+6Sqrt[2])/2,1/2},{(13+6Sqrt[2])/2,(-5-2Sqrt[2])/2},{(13+6Sqrt[2])/2,(-3-2Sqrt[2])/2},{(13+6Sqrt[2])/2,-1/2},{(13+6Sqrt[2])/2,1/2},{(12+7Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(12+7Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2},{(13+7Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(13+7Sqrt[2])/2,(-3-Sqrt[2])/2},{(13+7Sqrt[2])/2,(-1-Sqrt[2])/2},{(13+7Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(15+7Sqrt[2])/2,(-3-Sqrt[2]-2Sqrt[3])/2},{(15+7Sqrt[2])/2,(-3-Sqrt[2])/2},{(15+7Sqrt[2])/2,(-1-Sqrt[2])/2},{(15+7Sqrt[2])/2,(-1-Sqrt[2]+2Sqrt[3])/2},{(16+7Sqrt[2])/2,(-3-Sqrt[2]-Sqrt[3])/2},{(16+7Sqrt[2])/2,(-1-Sqrt[2]+Sqrt[3])/2}}
PolyhedronDual[GreatRhombicuboctahedron]:=DisdyakisDodecahedron
PolyhedronFaces[GreatRhombicuboctahedron]:=
	{{44,42,17,19},{14,6,3,11},{34,36,27,25},{8,16,9,1},{20,18,41,43},{12,4,5,
    13},{26,28,35,33},{2,10,15,7},{45,23,24,46},{39,29,30,40},{48,22,21,
    47},{38,32,31,37},{9,19,17,11,3,25,27,1},{2,28,26,4,12,18,20,10},{41,48,
    47,42,44,45,46,43},{35,38,37,36,34,39,40,33},{15,24,23,16,8,31,32,7},{5,
    30,29,6,14,21,22,13},{46,24,15,10,20,43},{35,28,2,7,32,38},{41,18,12,13,
    22,48},{40,30,5,4,26,33},{44,19,9,16,23,45},{37,31,8,1,27,36},{47,21,14,
    11,17,42},{34,25,3,6,29,39}}
PolyhedronVertices[GreatRhombicuboctahedron]:=
	{{-1/2,1/2+1/Sqrt[2],-1/2-Sqrt[2]},
{-1/2,1/2+1/Sqrt[2],1/2+Sqrt[2]},
{-1/2,(2-2Sqrt[2])^(-1),-1/2-Sqrt[2]},
{-1/2,(2-2Sqrt[2])^(-1),1/2+Sqrt[2]},
{-1/2,-1/2-Sqrt[2],1/2+1/Sqrt[2]},
{-1/2,-1/2-Sqrt[2],(2-2Sqrt[2])^(-1)},
{-1/2,1/2+Sqrt[2],1/2+1/Sqrt[2]},
{-1/2,1/2+Sqrt[2],(2-2Sqrt[2])^(-1)},
{1/2,1/2+1/Sqrt[2],-1/2-Sqrt[2]},
{1/2,1/2+1/Sqrt[2],1/2+Sqrt[2]},
{1/2,(2-2Sqrt[2])^(-1),-1/2-Sqrt[2]},
{1/2,(2-2Sqrt[2])^(-1),1/2+Sqrt[2]},
{1/2,-1/2-Sqrt[2],1/2+1/Sqrt[2]},
{1/2,-1/2-Sqrt[2],(2-2Sqrt[2])^(-1)},
{1/2,1/2+Sqrt[2],1/2+1/Sqrt[2]},
{1/2,1/2+Sqrt[2],(2-2Sqrt[2])^(-1)},
{1/2+1/Sqrt[2],-1/2,-1/2-Sqrt[2]},
{1/2+1/Sqrt[2],-1/2,1/2+Sqrt[2]},
{1/2+1/Sqrt[2],1/2,-1/2-Sqrt[2]},
{1/2+1/Sqrt[2],1/2,1/2+Sqrt[2]},
{1/2+1/Sqrt[2],-1/2-Sqrt[2],-1/2},
{1/2+1/Sqrt[2],-1/2-Sqrt[2],1/2},
{1/2+1/Sqrt[2],1/2+Sqrt[2],-1/2},
{1/2+1/Sqrt[2],1/2+Sqrt[2],1/2},
{(2-2Sqrt[2])^(-1),-1/2,-1/2-Sqrt[2]},
{(2-2Sqrt[2])^(-1),-1/2,1/2+Sqrt[2]},
{(2-2Sqrt[2])^(-1),1/2,-1/2-Sqrt[2]},
{(2-2Sqrt[2])^(-1),1/2,1/2+Sqrt[2]},
{(2-2Sqrt[2])^(-1),-1/2-Sqrt[2],-1/2},
{(2-2Sqrt[2])^(-1),-1/2-Sqrt[2],1/2},
{(2-2Sqrt[2])^(-1),1/2+Sqrt[2],-1/2},
{(2-2Sqrt[2])^(-1),1/2+Sqrt[2],1/2},
{-1/2-Sqrt[2],-1/2,1/2+1/Sqrt[2]},
{-1/2-Sqrt[2],-1/2,(2-2Sqrt[2])^(-1)},
{-1/2-Sqrt[2],1/2,1/2+1/Sqrt[2]},
{-1/2-Sqrt[2],1/2,(2-2Sqrt[2])^(-1)},
{-1/2-Sqrt[2],1/2+1/Sqrt[2],-1/2},
{-1/2-Sqrt[2],1/2+1/Sqrt[2],1/2},
{-1/2-Sqrt[2],(2-2Sqrt[2])^(-1),-1/2},
{-1/2-Sqrt[2],(2-2Sqrt[2])^(-1),1/2},
{1/2+Sqrt[2],-1/2,1/2+1/Sqrt[2]},
{1/2+Sqrt[2],-1/2,(2-2Sqrt[2])^(-1)},
{1/2+Sqrt[2],1/2,1/2+1/Sqrt[2]},
{1/2+Sqrt[2],1/2,(2-2Sqrt[2])^(-1)},
{1/2+Sqrt[2],1/2+1/Sqrt[2],-1/2},
{1/2+Sqrt[2],1/2+1/Sqrt[2],1/2},
{1/2+Sqrt[2],(2-2Sqrt[2])^(-1),-1/2},
{1/2+Sqrt[2],(2-2Sqrt[2])^(-1),1/2}}

(* Icosidodecahedron *)

PolyhedronName[Icosidodecahedron]:="icosidodecahedron"
NetFaces[Icosidodecahedron]:={{17,20,18,11,10},{6,10,11},{4,2,6,11,9},{8,4,9},{12,17,10},{3,7,12,10,5},{1,3,5},{23,20,17},{19,25,23,17,15},{14,19,15},{24,18,20},{30,28,24,20,26},{29,30,26},{13,11,18},{21,16,13,18,22},{27,21,22},{41,39,44,49,47},{52,47,49},{56,57,52,49,51},{54,56,51},{45,41,47},{55,50,45,47,53},{58,55,53},{35,39,41},{36,32,35,41,42},{43,36,42},{37,44,39},{30,31,37,39,33},{28,30,33},{48,49,44},{40,46,48,44,38},{34,40,38}}
NetVertices[Icosidodecahedron]:={{(-8Sqrt[3]-24Sqrt[15]-27Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-16-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]+2Sqrt[6(5+Sqrt[5])])/32},{(-5Sqrt[3]-3Sqrt[15]-3Sqrt[2(5+Sqrt[5])])/24,(1-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(-8Sqrt[3]-24Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-24-8Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]+2Sqrt[6(5+Sqrt[5])])/32},{(-4Sqrt[3]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/48,(4+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(4Sqrt[3]-12Sqrt[15]-15Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-20-4Sqrt[5]+2Sqrt[6(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{-(1/Sqrt[3]),0},{(-20Sqrt[3]-12Sqrt[15]+6Sqrt[2(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-28-4Sqrt[5]-4Sqrt[6(5-Sqrt[5])]-2Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(-4Sqrt[3]+12Sqrt[2(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/48,(8+4Sqrt[5]+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(Sqrt[3]+3Sqrt[15]-3Sqrt[2(5+Sqrt[5])])/24,(3+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{1/(2Sqrt[3]),-1/2},{1/(2Sqrt[3]),1/2},{(7Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-6-2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(14Sqrt[3]-6Sqrt[15]+3Sqrt[2(5-Sqrt[5])]+3Sqrt[10(5-Sqrt[5])])/48,(6+2Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])])/16},{(-8Sqrt[3]-6Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(-8-16Sqrt[5]-2Sqrt[6(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(4Sqrt[3]-12Sqrt[15]+6Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(-12-12Sqrt[5]+2Sqrt[30(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(40Sqrt[3]+6Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(16+8Sqrt[5]+4Sqrt[6(5-Sqrt[5])]+2Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(8Sqrt[3]+3Sqrt[2(5-Sqrt[5])]+3Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/48,(-1-Sqrt[5])/4},{(4Sqrt[3]+3Sqrt[2(5-Sqrt[5])]+3Sqrt[10(5-Sqrt[5])])/24,(1+Sqrt[5])/4},{(-8Sqrt[3]+6Sqrt[2(5-Sqrt[5])]+12Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(-16-8Sqrt[5]-2Sqrt[6(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(4Sqrt[3]+9Sqrt[2(5-Sqrt[5])]+3Sqrt[10(5-Sqrt[5])])/24,0},{(52Sqrt[3]+12Sqrt[15]+9Sqrt[2(5-Sqrt[5])]+9Sqrt[10(5-Sqrt[5])]-6Sqrt[2(5+Sqrt[5])])/96,(20+12Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]+2Sqrt[6(5+Sqrt[5])])/32},{(64Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]-6Sqrt[2(5+Sqrt[5])])/96,(24+8Sqrt[5]-2Sqrt[6(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(14Sqrt[3]+6Sqrt[15]+6Sqrt[2(5-Sqrt[5])]+6Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-1-Sqrt[5]-Sqrt[6(5-Sqrt[5])])/8},{(7Sqrt[3]+3Sqrt[15]+6Sqrt[2(5-Sqrt[5])]+3Sqrt[10(5-Sqrt[5])])/24,(1+Sqrt[5]+Sqrt[6(5-Sqrt[5])])/8},{(40Sqrt[3]+9Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(-8Sqrt[5]-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(4Sqrt[3]+12Sqrt[15]+30Sqrt[2(5-Sqrt[5])]+12Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(-4+4Sqrt[5]+2Sqrt[6(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(52Sqrt[3]+12Sqrt[15]+21Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]-6Sqrt[2(5+Sqrt[5])])/96,(28+4Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]+2Sqrt[6(5+Sqrt[5])])/32},{(40Sqrt[3]+24Sqrt[15]+27Sqrt[2(5-Sqrt[5])]+9Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(8+8Sqrt[5]+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(52Sqrt[3]+12Sqrt[15]+30Sqrt[2(5-Sqrt[5])]+12Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(-20+4Sqrt[5]+2Sqrt[6(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(52Sqrt[3]+12Sqrt[15]+30Sqrt[2(5-Sqrt[5])]+12Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(3+Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(64Sqrt[3]+24Sqrt[15]+21Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(8-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(76Sqrt[3]+12Sqrt[15]+12Sqrt[2(5-Sqrt[5])]+18Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(12+12Sqrt[5]+2Sqrt[6(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(40Sqrt[3]+24Sqrt[15]+39Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(16+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(88Sqrt[3]+24Sqrt[15]+21Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-16+5Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-8Sqrt[6(5+Sqrt[5])]-2Sqrt[30(5+Sqrt[5])])/32},{(88Sqrt[3]+24Sqrt[15]+9Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(8+8Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(64Sqrt[3]+24Sqrt[15]+15Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(16+8Sqrt[5]+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(76Sqrt[3]+36Sqrt[15]+27Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(4-4Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(88Sqrt[3]+24Sqrt[15]+45Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-8+8Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-10Sqrt[6(5+Sqrt[5])])/32},{(88Sqrt[3]+24Sqrt[15]+33Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(100Sqrt[3]+36Sqrt[15]+33Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(-12+4Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-8Sqrt[6(5+Sqrt[5])]-2Sqrt[30(5+Sqrt[5])])/32},{(100Sqrt[3]+36Sqrt[15]+33Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(4+4Sqrt[5]+5Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(112Sqrt[3]+24Sqrt[15]+18Sqrt[2(5-Sqrt[5])]+24Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(8Sqrt[5]+4Sqrt[6(5-Sqrt[5])]+2Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(112Sqrt[3]+24Sqrt[15]+15Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/96,(32+8Sqrt[5]+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/32},{(76Sqrt[3]+36Sqrt[15]+39Sqrt[2(5-Sqrt[5])]+27Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(-4+4Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-6Sqrt[6(5+Sqrt[5])])/32},{(100Sqrt[3]+36Sqrt[15]+57Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(12+12Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-4Sqrt[6(5+Sqrt[5])]+2Sqrt[30(5+Sqrt[5])])/32},{(112Sqrt[3]+48Sqrt[15]+33Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(-16+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-10Sqrt[6(5+Sqrt[5])])/32},{(112Sqrt[3]+48Sqrt[15]+45Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+6Sqrt[2(5+Sqrt[5])])/96,(8+8Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(124Sqrt[3]+36Sqrt[15]+33Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+12Sqrt[2(5+Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(-20+4Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-6Sqrt[6(5+Sqrt[5])])/32},{(124Sqrt[3]+36Sqrt[15]+39Sqrt[2(5-Sqrt[5])]+27Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(12+4Sqrt[5]+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-6Sqrt[6(5+Sqrt[5])])/32},{(88Sqrt[3]+48Sqrt[15]+54Sqrt[2(5-Sqrt[5])]+24Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(16+8Sqrt[5]+2Sqrt[30(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]+3Sqrt[30(5+Sqrt[5])])/32},{(68Sqrt[3]+24Sqrt[15]+15Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(2-Sqrt[6(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])])/8},{(112Sqrt[3]+48Sqrt[15]+45Sqrt[2(5-Sqrt[5])]+33Sqrt[10(5-Sqrt[5])]+6Sqrt[10(5+Sqrt[5])])/96,(16+Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-2Sqrt[6(5+Sqrt[5])])/32},{(124Sqrt[3]+60Sqrt[15]+48Sqrt[2(5-Sqrt[5])]+18Sqrt[10(5-Sqrt[5])]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(4+4Sqrt[5]-2Sqrt[6(5-Sqrt[5])]-3Sqrt[6(5+Sqrt[5])]+3Sqrt[30(5+Sqrt[5])])/32},{(68Sqrt[3]+24Sqrt[15]+27Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])])/8},{(136Sqrt[3]+48Sqrt[15]+51Sqrt[2(5-Sqrt[5])]+21Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(8Sqrt[5]-Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+3Sqrt[30(5+Sqrt[5])])/32},{(74Sqrt[3]+30Sqrt[15]+21Sqrt[2(5-Sqrt[5])]+15Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(1-Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(160Sqrt[3]+48Sqrt[15]+51Sqrt[2(5-Sqrt[5])]+33Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(124Sqrt[3]+60Sqrt[15]+57Sqrt[2(5-Sqrt[5])]+27Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/96,(-4+12Sqrt[5]-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]+3Sqrt[30(5+Sqrt[5])])/32}}
PolyhedronDual[Icosidodecahedron]:=RhombicTriacontahedron
PolyhedronFaces[Icosidodecahedron]:=
	{{30,24,29,7,8},{26,24,30},{25,29,24},{5,7,29},{14,8,7},{6,30,8},{16,2,6},{19,
    21,26},{20,18,25},{1,15,5},{22,23,14},{2,19,26,30,6},{21,20,25,24,26},{18,
    1,5,29,25},{15,22,14,7,5},{23,16,6,8,14},{12,13,4,17,3},{3,17,9},{17,4,
    10},{4,13,28},{13,12,11},{12,3,27},{27,1,18},{9,22,15},{10,16,23},{28,19,
    2},{11,20,21},{27,3,9,15,1},{9,17,10,23,22},{10,4,28,2,16},{28,13,11,21,
    19},{11,12,27,18,20}}
PolyhedronVertices[Icosidodecahedron]:=
{{0,(-1-Sqrt[5])/2,0},
{0,(1+Sqrt[5])/2,0},
{Sqrt[1/8-1/(8Sqrt[5])],(-1-Sqrt[5])/4,-Sqrt[1+2/Sqrt[5]]},
{Sqrt[1/8-1/(8Sqrt[5])],(1+Sqrt[5])/4,-Sqrt[1+2/Sqrt[5]]},
{Sqrt[1/8+1/(8Sqrt[5])],(-3-Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
{Sqrt[1/8+1/(8Sqrt[5])],(3+Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
{Sqrt[1/4+1/(2Sqrt[5])],-1/2,Sqrt[1+2/Sqrt[5]]},
{Sqrt[1/4+1/(2Sqrt[5])],1/2,Sqrt[1+2/Sqrt[5]]},
{Sqrt[5/8+11/(8Sqrt[5])],(-1-Sqrt[5])/4,Root[1-5#1^2+5#1^4&,1,0]},
{Sqrt[5/8+11/(8Sqrt[5])],(1+Sqrt[5])/4,Root[1-5#1^2+5#1^4&,1,0]},
{-Sqrt[1+2/Sqrt[5]],0,Root[1-5#1^2+5#1^4&,1,0]},
{-Sqrt[1+2/Sqrt[5]]/2,-1/2,-Sqrt[1+2/Sqrt[5]]},
{-Sqrt[1+2/Sqrt[5]]/2,1/2,-Sqrt[1+2/Sqrt[5]]},
{Sqrt[1+2/Sqrt[5]],0,Sqrt[(5+Sqrt[5])/10]},
{Sqrt[5/8+Sqrt[5]/8],-(1+Sqrt[5])^2/8,0},
{Sqrt[5/8+Sqrt[5]/8],(3+Sqrt[5])/4,0},
{Sqrt[(5+Sqrt[5])/10],0,-Sqrt[1+2/Sqrt[5]]},
{-Sqrt[(5+Sqrt[5])/2]/2,-(1+Sqrt[5])^2/8,0},
{-Sqrt[(5+Sqrt[5])/2]/2,(3+Sqrt[5])/4,0},
{-Sqrt[5+2Sqrt[5]]/2,-1/2,0},
{-Sqrt[5+2Sqrt[5]]/2,1/2,0},
{Sqrt[5+2Sqrt[5]]/2,-1/2,0},
{Sqrt[5+2Sqrt[5]]/2,1/2,0},
{Root[1-5#1^2+5#1^4&,1,0],0,Sqrt[1+2/Sqrt[5]]},
{Root[1-100#1^2+80#1^4&,1,0],(-1-Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
{Root[1-100#1^2+80#1^4&,1,0],(1+Sqrt[5])/4,Sqrt[(5+Sqrt[5])/10]},
{Root[1-20#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,Root[1-5#1^2+5#1^4&,1,0]},
{Root[1-20#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,Root[1-5#1^2+5#1^4&,1,0]},
{Root[1-20#1^2+80#1^4&,2,0],(-1-Sqrt[5])/4,Sqrt[1+2/Sqrt[5]]},
{Root[1-20#1^2+80#1^4&,2,0],(1+Sqrt[5])/4,Sqrt[1+2/Sqrt[5]]}}

(* Pentagonal Hexecontahedron *)

PolyhedronFaces[PentagonalHexecontahedron]:=PolyhedronFaces[PentagonalHexecontahedron,"dextro"]
PolyhedronName[PentagonalHexecontahedron]:=PolyhedronName[PentagonalHexecontahedron,"dextro"]
PolyhedronDual[PentagonalHexecontahedron]:=PolyhedronDual[PentagonalHexecontahedron,"dextro"]
PolyhedronVertices[PentagonalHexecontahedron]:=PolyhedronVertices[PentagonalHexecontahedron,"dextro"]

NetFaces[PentagonalHexecontahedron]:={{49,65,69,62,55},{49,55,50,41,36},{49,36,26,23,33},{49,33,30,43,48},
{49,48,57,63,61},{58,74,81,80,70},{58,70,68,59,53},{58,53,46,38,45},{58,45,35,44,51},{58,51,55,62,67},
{18,28,27,20,14},{18,14,10,4,8},{18,8,2,7,12},{18,12,16,22,25},{18,25,36,41,32},{17,13,9,3,6},{17,6,1,5,11},
{17,11,15,21,24},{17,24,34,39,29},{17,29,33,23,19},{54,40,31,37,47},{54,47,52,60,66},{54,66,77,78,71},
{54,71,75,64,56},{54,56,48,43,42},{84,79,83,86,88},{84,88,93,94,91},{84,91,92,87,85},{84,85,82,73,72},
{84,72,61,63,76},{134,118,114,121,128},{134,128,133,142,147},{134,147,157,160,150},{134,150,153,140,135},
{134,135,126,120,122},{125,109,102,103,113},{125,113,115,124,130},{125,130,137,145,138},{125,138,148,139,132},
{125,132,128,121,116},{165,155,156,163,169},{165,169,173,179,175},{165,175,181,176,171},{165,171,167,161,158},
{165,158,147,142,151},{166,170,174,180,177},{166,177,182,178,172},{166,172,168,162,159},{166,159,149,144,154},
{166,154,150,160,164},{129,143,152,146,136},{129,136,131,123,117},{129,117,106,105,112},{129,112,108,119,127},
{129,127,135,140,141},{99,104,100,97,95},{99,95,90,89,92},{99,92,91,96,98},{99,98,101,110,111},
{99,111,122,120,107}}
NetVertices[PentagonalHexecontahedron]:={{-5.78978791158,-2.80761669086},
{-5.62044484574,1.74245918164},{-5.61659031376,-1.05249040074},{-5.44724724792,3.49758547176},
{-5.31891465278,-3.68981756036},{-5.23389293563,-1.9763641566},{-5.1495715869400005,0.860258312137},
{-5.0645498698,2.5737117159},{-4.98236552247,-0.279341699569},{-4.81302245663,4.27073417293},
{-4.31891496984,-3.69061388707},{-4.14957190401,0.859461985426},{-4.0014982338,-0.474019284345},
{-3.83215516796,4.07605658815},{-3.7643445957,-4.52275071483},{-3.59500152986,0.0273251576639},
{-3.49249862184,-2.14820666942},{-3.32315555601,2.40186920308},{-3.31500500407,-0.407379273907},
{-3.12563306362,4.78374756314},{-2.76902314758,-4.42613179884},{-2.59968008175,0.123944073655},
{-2.38989400094,-0.0276825108488},{-2.38485484459,-3.5028687188},{-2.21551177875,1.0472071537},
{-2.19203385945,0.952547750064},{-2.16839442405,4.49444808696},{-1.97209570009,3.51390394671},
{-1.81666800484,-1.64464361633},{-1.72024133332,-1.6592556802},{-1.65241191737,-4.70866571759},
{-1.647324939,2.90543225617},{-1.61880786335,-0.6644133554180001},{-1.4036787461,-3.30975356207},
{-1.35320542483,3.33070829436},{-1.23433568027,1.24032231042},{-1.18153865857,-5.59086658708},
{-1.18000782701,5.08583458449},{-1.11127390266,-2.35345893826},{-1.09651694143,-3.87741318332},
{-0.941930836821,2.19661693424},{-0.894839437395,-3.21783753958},{-0.890797435108,-2.2178457085},
{-0.882332166028,2.44850742486},{-0.797310448886,4.16196082862},{-0.545783035725,5.85898328566},
{-0.181538975637,-5.59166291379},{-0.0070729080754,-1.74983827232},{0.,0.},
{0.0392452616672,2.38973209096},{0.117667516904,2.44771109815},{0.37303139851,-6.42379974156},
{0.435084252947,5.66430570088},{0.644877372364,-4.04925569614},{0.672237891051,1.61557427039},
{0.8223709901340001,-2.30842830063},{0.872839399411,-2.22497439085},{0.944083864904,3.99011831581},
{1.14160635729,6.37199667587},{1.36835284662,-6.32718082557},{1.61338389116,-0.677477988604},
{1.66755933916,1.71219318638},{1.70677180253,-1.67310778828},{1.74748199327,-1.92873153757},
{1.74985201191,-0.00139345433874},{1.75252114962,-5.40391774552},{2.05172764216,2.63545626643},
{2.09884499686,6.08269719969},{2.22212971331,0.880056358619},{2.29514372082,5.10215305944},
{2.32070798937,-3.54569264305},{2.44731629428,-0.125611386034},{2.45135829657,0.874380445041},
{2.48916524201,3.16871248223},{2.51856813085,-2.56546238214},{2.62878313184,-2.06027068502},
{2.7336972481,-5.2108025888},{3.02610209155,-4.25450796499},{3.16061675604,-2.49943676025},
{3.21964882551,4.7209833972},{3.31949772829,3.72598078584},{3.3350828236,1.34238788122},
{3.71518713019,-3.33157358801},{3.98703310404,-0.957029542596},{4.16452672181,0.783797852916},
{4.7105085783,-3.23495467202},{5.08963772495,1.16349461597},{5.09467688129,-2.31169159198},
{5.15532976035,1.23557909334},{5.44773460379,2.19187371715},{5.66286372104,-0.453466489509},
{5.86072386253,0.526763771404},{6.0758529797800005,-2.11857643525},{6.36825782322,-1.16228181144},
{6.4289107022800005,2.38498887387},{6.43394985862,-1.09019733408},{6.81307900527,3.30825195392},
{7.35906086176,-0.71050057102},{7.53655447953,1.03032682449},{7.80840045338,3.40487086991},
{8.18850475997,-1.26909059933},{8.20408985528,-3.65268350395},{8.30393875807,-4.64768611531},
{8.36297082753,2.57273404214},{8.49748549202,4.32780524688},{8.78989033547,5.28409987069},
{8.89480445173,2.13356796692},{9.00501945272,2.63875966404},{9.03442234156,-3.09541520033},
{9.072229287,-0.801083163146},{9.07627128929,0.19890866793},{9.20287959421,3.61898992495},
{9.22844386275,-5.02885577754},{9.30145787026,-0.806759076724},{9.42474258672,-6.00939991779},
{9.47185994142,-2.56215898453},{9.77106643396,5.47721502742},{9.77373557166,0.0746907362343},
{9.7761055903,2.00202881947},{9.81681578104,1.74640507018},{9.85602824441,-1.63889590449},
{9.91020369241,0.7507752705},{10.1552347369,6.40047810746},{10.3819812263,-6.29869939397},
{10.5795037187,-3.91682103391},{10.6507481842,2.29827167275},{10.7012165934,2.38172558252},
{10.8513496925,-1.5422769885},{10.8787102112,4.12255297804},{11.0885033306,-5.59100841899},
{11.1505561851,6.49709702345},{11.4059200667,-2.37441381626},{11.4843423219,-2.31643480906},
{11.5235875836,0.0732972818956},{11.5306604916,1.82313555422},{11.7051265592,5.66496019569},
{12.0693706193,-5.78568600376},{12.3208980325,-4.08866354673},{12.4059197496,-2.37521014297},
{12.4143850187,2.2911429904},{12.418427021,3.29113482147},{12.4655184204,-2.12331965234},
{12.620104525,3.95071046522},{12.6348614862,2.42675622016},{12.7035954106,-5.01253730259},
{12.7051262421,5.66416386898},{12.7579232638,-1.16702502853},{12.8767930084,-3.25741101247},
{12.9272663297,3.38305084397},{13.1423954469,0.737710637314},{13.1709125226,-2.83213497427},
{13.1759995009,4.78196299948},{13.2438289169,1.73255296209},{13.3402555884,1.71794089823},
{13.4956832837,-3.44060666482},{13.6919820076,-4.42115080506},{13.715621443,-0.879250468169},
{13.7390993623,-0.973909871805},{13.9084424282,3.57616600069},{13.9134815845,0.100979792744},
{14.1232676653,-0.050646791759},{14.2926107312,4.49942908074},{14.6492206472,-4.71045028124},
{14.8385925876,0.480676555802},{14.8467431396,-2.32857192118},{15.0160862054,2.22150395131},
{15.1185891134,0.0459721242317},{15.2879321793,4.59604799673},{15.3557427515,-4.00275930626},
{15.5250858174,0.54731656624},{15.6731594876,-0.786164703531},{15.8425025534,3.76391116897},
{16.3366100402,-4.19743689103},{16.505953106,0.352638981464},{16.5881374534,-2.500414434},
{16.6731591705,-0.786961030241},{16.7574805192,2.0496614385},{16.8425022363,3.76311484226},
{16.9708348315,-3.42428818987},{17.1401778973,1.12578768263},{17.1440324293,-1.66916189974},
{17.3133754952,2.88091397276}}

PolyhedronName[PentagonalHexecontahedron,"dextro"]:="pentagonal hexecontahedron (dextro)"
PolyhedronDual[PentagonalHexecontahedron,"dextro"]:=Sequence[SnubDodecahedron,"laevo"]
PolyhedronFaces[PentagonalHexecontahedron,"dextro"]:=
{{29,33,17,5,11},{12,30,35,18,6},{61,67,34,27,7},{8,62,68,36,28},{34,15,5,17,27},{18,28,36,16,
6},{75,22,31,86,77},{32,88,78,76,24},{7,27,17,33,55},{35,56,8,28,18},{90,75,77,48,57},{76,78,
50,58,92},{65,86,67,61,70},{62,72,66,88,68},{9,5,15,31,22},{6,16,32,24,10},{45,7,55,81,69},
{82,71,46,8,56},{29,11,21,59,85},{12,23,60,87,30},{79,3,25,90,83},{26,92,84,80,4},{89,79,83,
1,64},{80,84,2,63,91},{85,81,55,33,29},{30,87,82,56,35},{21,11,5,13,37},{6,14,38,23,12},
{86,31,15,34,67},{36,68,88,32,16},{53,69,81,85,43},{87,44,54,71,82},{47,73,89,54,44},{74,91,
53,43,49},{85,59,73,47,41},{60,74,49,42,87},{73,59,21,37,89},{23,38,91,74,60},{13,5,9,25,3},{6,
10,26,4,14},{37,13,3,79,89},{14,4,80,91,38},{51,70,61,7,39},{40,52,72,62,8},{25,9,22,75,90},
{10,24,76,92,26},{1,83,90,52,40},{92,51,39,2,84},{48,77,86,19,20},{88,20,19,50,78},{50,19,86,
65,58},{66,57,48,20,88},{92,58,65,70,51},{52,90,57,66,72},{2,39,7,45,63},{46,64,1,40,8},
{49,43,85,41,42},{42,41,47,44,87},{91,63,45,69,53},{54,89,64,46,71}}
PolyhedronVertices[PentagonalHexecontahedron,"dextro"]:=
{{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,1,0]},
{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,8,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,1,0],0,Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,8,0],0,Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,1,0],0,Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,8,0],0,Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,1,0],0,Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,8,0],0,Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[116281-4894656#1^2+36660528#1^4-70670016#1^6+59222016#1^8-22146048#1^10+2985984#1^12&,1,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[116281-4894656#1^2+36660528#1^4-70670016#1^6+59222016#1^8-22146048#1^10+2985984#1^12&,8,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[434281-5981244#1^2+24945984#1^4-47186496#1^6+44727552#1^8-19906560#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[434281-5981244#1^2+24945984#1^4-47186496#1^6+44727552#1^8-19906560#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[3721-998784#1^2+9821664#1^4-28826496#1^6+34359552#1^8-17418240#1^10+2985984#1^12&,1,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[3721-998784#1^2+9821664#1^4-28826496#1^6+34359552#1^8-17418240#1^10+2985984#1^12&,8,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,3,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,6,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,7,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,4,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,5,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,4,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,5,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,2,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,7,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,1,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,8,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,2,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,7,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,1,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,1,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,8,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,8,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,8,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,8,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]}}
(*
PolyhedronFaces[PentagonalHexecontahedron,"dextro"]:=
{{29,33,17,11,6},{5,30,35,18,12},{61,67,34,27,13},{14,62,68,36,28},{34,15,11,17,27},{18,28,36,16,12},
{75,22,31,8,77},{32,10,78,76,24},{13,27,17,33,55},{35,56,14,28,18},{92,75,77,48,57},{76,78,50,58,90},
{65,8,67,61,70},{62,72,66,10,68},{86,11,15,31,22},{12,16,32,24,85},{45,13,55,81,69},{82,71,46,14,56},
{29,6,21,59,7},{5,23,60,9,30},{79,3,25,92,83},{26,90,84,80,4},{91,79,83,1,64},{80,84,2,63,89},
{7,81,55,33,29},{30,9,82,56,35},{21,6,11,88,37},{12,87,38,23,5},{8,31,15,34,67},{36,68,10,32,16},
{53,69,81,7,43},{9,44,54,71,82},{47,73,91,54,44},{74,89,53,43,49},{7,59,73,47,41},{60,74,49,42,9},
{73,59,21,37,91},{23,38,89,74,60},{88,11,86,25,3},{12,85,26,4,87},{37,88,3,79,91},{87,4,80,89,38},
{51,70,61,13,39},{40,52,72,62,14},{25,86,22,75,92},{85,24,76,90,26},{1,83,92,52,40},{90,51,39,2,84},
{48,77,8,19,20},{10,20,19,50,78},{50,19,8,65,58},{66,57,48,20,10},{90,58,65,70,51},{52,92,57,66,72},
{2,39,13,45,63},{46,64,1,40,14},{49,43,7,41,42},{42,41,47,44,9},{89,63,45,69,53},{54,91,64,46,71}}
PolyhedronVertices[PentagonalHexecontahedron,"dextro"]:=
{{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,1,0]},{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,8,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,1,0],0,
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,8,0],0,
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[35524181+9280074#1+331640#1^2-8136657#1^3+13434194#1^4+12082486#1^5-8785299#1^6-5381244#1^7+30355561#1^8-9670918#1^9+11778297#1^10-8092410#1^11+144200#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[35524181-9280074#1+331640#1^2+8136657#1^3+13434194#1^4-12082486#1^5-8785299#1^6+5381244#1^7+30355561#1^8+9670918#1^9+11778297#1^10+8092410#1^11+144200#1^12&,2,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[-26339835-4995971#1-5628179#1^2-20852907#1^3+25113869#1^4+5641451#1^5+8454790#1^6+6297800#1^7-4384236#1^8-9306987#1^9-30480710#1^10-11934132#1^11+372238#1^12&,2,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[-26339835-4995971#1-5628179#1^2-20852907#1^3+25113869#1^4+5641451#1^5+8454790#1^6+6297800#1^7-4384236#1^8-9306987#1^9-30480710#1^10-11934132#1^11+372238#1^12&,2,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[-26339835+4995971#1-5628179#1^2+20852907#1^3+25113869#1^4-5641451#1^5+8454790#1^6-6297800#1^7-4384236#1^8+9306987#1^9-30480710#1^10+11934132#1^11+372238#1^12&,3,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[-26339835+4995971#1-5628179#1^2+20852907#1^3+25113869#1^4-5641451#1^5+8454790#1^6-6297800#1^7-4384236#1^8+9306987#1^9-30480710#1^10+11934132#1^11+372238#1^12&,3,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,1,0],0,
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,8,0],0,
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,1,0],0,Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,8,0],0,Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],
Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],
Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],
Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],
Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],
Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],
Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,3,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,6,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,7,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],
Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],
Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,4,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,5,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,4,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,5,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],
Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,2,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,7,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,1,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,8,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,2,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,7,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[4451309+4239891#1+25585637#1^2+26195962#1^3+12670977#1^4+31234656#1^5-19026992#1^6-8300265#1^7+20344044#1^8+4631411#1^9+1859159#1^10-14607929#1^11+4772350#1^12&,3,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[4451309-4239891#1+25585637#1^2-26195962#1^3+12670977#1^4-31234656#1^5-19026992#1^6+8300265#1^7+20344044#1^8-4631411#1^9+1859159#1^10+14607929#1^11+4772350#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[-733597-6256840#1-12734255#1^2+6126819#1^3+22979407#1^4-18322356#1^5+25812303#1^6+13537551#1^7-15428379#1^8+19460333#1^9-22685448#1^10-1745412#1^11+4903405#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[-733597+6256840#1-12734255#1^2-6126819#1^3+22979407#1^4+18322356#1^5+25812303#1^6-13537551#1^7-15428379#1^8-19460333#1^9-22685448#1^10+1745412#1^11+4903405#1^12&,1,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[302813-10499516#1-9739290#1^2+41433808#1^3-11574965#1^4-15958684#1^5+29215167#1^6-732721#1^7-5842077#1^8+16196953#1^9+7887217#1^10-4707171#1^11+14303515#1^12&,4,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],
Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[302813-10499516#1-9739290#1^2+41433808#1^3-11574965#1^4-15958684#1^5+29215167#1^6-732721#1^7-5842077#1^8+16196953#1^9+7887217#1^10-4707171#1^11+14303515#1^12&,4,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],
Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[302813+10499516#1-9739290#1^2-41433808#1^3-11574965#1^4+15958684#1^5+29215167#1^6+732721#1^7-5842077#1^8-16196953#1^9+7887217#1^10+4707171#1^11+14303515#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],
Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]},
{Root[302813+10499516#1-9739290#1^2-41433808#1^3-11574965#1^4+15958684#1^5+29215167#1^6+732721#1^7-5842077#1^8-16196953#1^9+7887217#1^10+4707171#1^11+14303515#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],
Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]}}
*)

PolyhedronName[PentagonalHexecontahedron,"laevo"]:="pentagonal hexecontahedron (laevo)"
PolyhedronDual[PentagonalHexecontahedron,"laevo"]:=Sequence[SnubDodecahedron,"dextro"]
PolyhedronFaces[PentagonalHexecontahedron,"laevo"]:=
{{29,11,5,17,34},{18,36,30,12,6},{61,7,27,33,67},{35,68,62,8,28},{33,27,17,5,15},{16,35,
28,18,6},{85,31,21,75,77},{32,23,76,78,87},{7,55,34,17,27},{28,8,56,36,18},{47,77,75,89,
57},{76,91,58,49,78},{65,69,61,67,85},{87,66,71,62,68},{31,15,5,9,21},{6,10,23,32,16},
{45,70,81,55,7},{8,46,72,82,56},{59,22,11,29,86},{12,30,88,60,24},{89,25,3,79,83},{26,4,
80,84,91},{1,83,79,90,64},{80,92,63,2,84},{86,29,34,55,81},{56,82,88,30,36},{13,5,11,
22,37},{6,12,24,38,14},{85,67,33,15,31},{32,87,68,35,16},{53,43,86,81,70},{72,54,44,88,
82},{54,90,73,48,44},{74,50,43,53,92},{48,73,59,86,41},{60,88,42,50,74},{37,22,59,73,90},
{24,60,74,92,38},{25,9,5,13,3},{6,14,4,26,10},{79,3,13,37,90},{14,38,92,80,4},{51,39,7,
61,69},{62,71,52,40,8},{75,21,9,25,89},{10,26,91,76,23},{52,89,83,1,40},{91,84,2,39,51},
{19,85,77,47,20},{87,78,49,19,20},{49,58,65,85,19},{20,47,57,66,87},{91,51,69,65,58},
{66,57,89,52,71},{2,63,45,7,39},{40,1,64,46,8},{50,42,41,86,43},{44,48,41,42,88},{92,
53,70,45,63},{46,64,90,54,72}}
PolyhedronVertices[PentagonalHexecontahedron,"laevo"]:=
{{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,1,0]},{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,8,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,1,0],0,Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,8,0],0,Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,1,0],0,Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,8,0],0,Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,1,0],0,Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,8,0],0,Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[116281-4894656#1^2+36660528#1^4-70670016#1^6+59222016#1^8-22146048#1^10+2985984#1^12&,1,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[116281-4894656#1^2+36660528#1^4-70670016#1^6+59222016#1^8-22146048#1^10+2985984#1^12&,8,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[434281-5981244#1^2+24945984#1^4-47186496#1^6+44727552#1^8-19906560#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[434281-5981244#1^2+24945984#1^4-47186496#1^6+44727552#1^8-19906560#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[3721-998784#1^2+9821664#1^4-28826496#1^6+34359552#1^8-17418240#1^10+2985984#1^12&,1,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[3721-998784#1^2+9821664#1^4-28826496#1^6+34359552#1^8-17418240#1^10+2985984#1^12&,8,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,3,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,6,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,7,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,4,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,5,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,4,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,5,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,2,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,7,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,1,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,8,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,2,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,7,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,1,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,1,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,7,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,8,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+96#1^2-6624#1^4-2782080#1^6+212191488#1^8-3587659776#1^10+2869530624#1^12&,8,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],Root[1+1776#1^2+1313136#1^4-40556160#1^6+429919488#1^8-1881916416#1^10+2869530624#1^12&,2,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,1,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,8,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]},
{Root[1+624#1^2+155376#1^4-12216960#1^6+262372608#1^8-1823192064#1^10+2869530624#1^12&,8,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],Root[1-336#1^2+17136#1^4+1745280#1^6+28470528#1^8-8939787264#1^10+2869530624#1^12&,8,0]}}
(*
PolyhedronFaces[PentagonalHexecontahedron,"laevo"]:=
{{29,6,11,17,34},{18,36,30,5,12},{61,13,27,33,67},{35,68,62,14,28},{33,27,17,11,15},
{16,35,28,18,12},{7,31,21,75,77},{32,23,76,78,9},{13,55,34,17,27},{28,14,56,36,18},
{47,77,75,91,57},{76,89,58,49,78},{65,69,61,67,7},{9,66,71,62,68},{31,15,11,86,21},
{12,85,23,32,16},{45,70,81,55,13},{14,46,72,82,56},{59,22,6,29,8},{5,30,10,60,24},
{91,25,3,79,83},{26,4,80,84,89},{1,83,79,92,64},{80,90,63,2,84},{8,29,34,55,81},
{56,82,10,30,36},{88,11,6,22,37},{12,5,24,38,87},{7,67,33,15,31},{32,9,68,35,16},
{53,43,8,81,70},{72,54,44,10,82},{54,92,73,48,44},{74,50,43,53,90},{48,73,59,8,41},
{60,10,42,50,74},{37,22,59,73,92},{24,60,74,90,38},{25,86,11,88,3},{12,87,4,26,85},
{79,3,88,37,92},{87,38,90,80,4},{51,39,13,61,69},{62,71,52,40,14},{75,21,86,25,91},
{85,26,89,76,23},{52,91,83,1,40},{89,84,2,39,51},{19,7,77,47,20},{9,78,49,19,20},
{49,58,65,7,19},{20,47,57,66,9},{89,51,69,65,58},{66,57,91,52,71},{2,63,45,13,39},
{40,1,64,46,14},{50,42,41,8,43},{44,48,41,42,10},{90,53,70,45,63},{46,64,92,54,72}}
PolyhedronVertices[PentagonalHexecontahedron,"laevo"]:=
{{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,1,0]},{0,0,Root[729-7776#1^2+34992#1^4-79488#1^6+85248#1^8-33792#1^10+4096#1^12&,8,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,1,0],0,
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-24#1^2+243#1^4-1242#1^6+2997#1^8-2673#1^10+729#1^12&,8,0],0,
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[35524181+9280074#1+331640#1^2-8136657#1^3+13434194#1^4+12082486#1^5-8785299#1^6-5381244#1^7+30355561#1^8-9670918#1^9+11778297#1^10-8092410#1^11+144200#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[35524181-9280074#1+331640#1^2+8136657#1^3+13434194#1^4-12082486#1^5-8785299#1^6+5381244#1^7+30355561#1^8+9670918#1^9+11778297#1^10+8092410#1^11+144200#1^12&,2,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,7,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[-26339835-4995971#1-5628179#1^2-20852907#1^3+25113869#1^4+5641451#1^5+8454790#1^6+6297800#1^7-4384236#1^8-9306987#1^9-30480710#1^10-11934132#1^11+372238#1^12&,2,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[-26339835-4995971#1-5628179#1^2-20852907#1^3+25113869#1^4+5641451#1^5+8454790#1^6+6297800#1^7-4384236#1^8-9306987#1^9-30480710#1^10-11934132#1^11+372238#1^12&,2,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[-26339835+4995971#1-5628179#1^2+20852907#1^3+25113869#1^4-5641451#1^5+8454790#1^6-6297800#1^7-4384236#1^8+9306987#1^9-30480710#1^10+11934132#1^11+372238#1^12&,3,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,1,0],
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[-26339835+4995971#1-5628179#1^2+20852907#1^3+25113869#1^4-5641451#1^5+8454790#1^6-6297800#1^7-4384236#1^8+9306987#1^9-30480710#1^10+11934132#1^11+372238#1^12&,3,0],Root[1+32#1^2-736#1^4-103040#1^6+2619648#1^8-14764032#1^10+3936256#1^12&,8,0],
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,1,0],0,
Root[-2187711-8841998#1-12614098#1^2-3217970#1^3+9686313#1^4+3042903#1^5+30885087#1^6-21760483#1^7-15557618#1^8-38208092#1^9-15899559#1^10-17321368#1^11+4079327#1^12&,1,0]},
{Root[1+24#1^2-414#1^4-43470#1^6+828873#1^8-3503574#1^10+700569#1^12&,8,0],0,
Root[-2187711+8841998#1-12614098#1^2+3217970#1^3+9686313#1^4-3042903#1^5+30885087#1^6+21760483#1^7-15557618#1^8+38208092#1^9-15899559#1^10+17321368#1^11+4079327#1^12&,2,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,1,0],0,Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[1+156#1^2+9711#1^4-190890#1^6+1024893#1^8-1780461#1^10+700569#1^12&,8,0],0,Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[44521-890592#1^2+6120288#1^4-18508608#1^6+25754112#1^8-16920576#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,2,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],
Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[1-24828#1^2+830016#1^4-6725376#1^6+17604864#1^8-16174080#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,7,0],
Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},
{Root[1-15864#1^2+1723824#1^4-20903616#1^6+30108672#1^8-16174080#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,1,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[961-155784#1^2+2810304#1^4-9593856#1^6+19533312#1^8-13685760#1^10+2985984#1^12&,8,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,1,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[361-10764#1^2+289152#1^4-2661120#1^6+9725184#1^8-13188096#1^10+2985984#1^12&,8,0],Root[1-84#1^2+2176#1^4-17152#1^6-16128#1^8+3072#1^10+4096#1^12&,2,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],
Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,7,0]},{Root[961-29940#1^2+381168#1^4-2474496#1^6+8211456#1^8-11695104#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,7,0],
Root[1-2064#1^2+130608#1^4-1828224#1^6+5412096#1^8+7216128#1^10+2985984#1^12&,2,0]},{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],
Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[5041-127716#1^2+484416#1^4-2764800#1^6+10015488#1^8-11695104#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,1,0],
Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,1,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,2,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+31968#1^4-770688#1^6+4499712#1^8-11446272#1^10+2985984#1^12&,8,0],Root[1-48#1^2+992#1^4-6016#1^6+14592#1^8-14336#1^10+4096#1^12&,7,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[361-62676#1^2+1016208#1^4-5325696#1^6+11840256#1^8-10948608#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,3,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,4,0]},
{Root[841-86424#1^2+2005488#1^4-14641344#1^6+18164736#1^8-10202112#1^10+2985984#1^12&,6,0],Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],Root[961-74064#1^2+1300464#1^4-6742656#1^6+1181952#1^8+1244160#1^10+2985984#1^12&,5,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,3,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[5041-292164#1^2+4406112#1^4-14999040#1^6+16671744#1^8-9455616#1^10+2985984#1^12&,6,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,8,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[203401-2385840#1^2+10369008#1^4-20661696#1^6+19408896#1^8-9206784#1^10+2985984#1^12&,7,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,4,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-336#1^2+47088#1^4-874368#1^6+4499712#1^8-7713792#1^10+2985984#1^12&,5,0],Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,1,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],
Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-372#1^2+31248#1^4-874368#1^6+6780672#1^8-6967296#1^10+2985984#1^12&,8,0],Root[841-6876#1^2+17040#1^4-14720#1^6+3840#1^8-4096#1^10+4096#1^12&,2,0],
Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,4,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[3721-128748#1^2+1370016#1^4-5835456#1^6+9828864#1^8-6220800#1^10+2985984#1^12&,5,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,8,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,1,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[109561-1106784#1^2+2849184#1^4+817344#1^6-5764608#1^8-4976640#1^10+2985984#1^12&,8,0],Root[1-720#1^2+6112#1^4-14528#1^6+16896#1^8-12288#1^10+4096#1^12&,7,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,4,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,1,0]},
{Root[961-329148#1^2+5899536#1^4-14967936#1^6+8481024#1^8-4976640#1^10+2985984#1^12&,5,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],Root[961-170352#1^2+7742448#1^4-18188928#1^6+18185472#1^8-10699776#1^10+2985984#1^12&,8,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[361-457836#1^2+13053456#1^4+3974400#1^6-8957952#1^8-4230144#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,1,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,8,0]},
{Root[292681-2155404#1^2+4638528#1^4-1905984#1^6-808704#1^8-3981312#1^10+2985984#1^12&,8,0],Root[1-212#1^2+4992#1^4-17344#1^6+24832#1^8-16384#1^10+4096#1^12&,2,0],Root[3721-752784#1^2+7512624#1^4-16004736#1^6+11135232#1^8-8709120#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],
Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,2,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[19321-437004#1^2+3336912#1^4-9884160#1^6+10036224#1^8-3234816#1^10+2985984#1^12&,7,0],Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,1,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[1-22884#1^2+631728#1^4-2329344#1^6-7962624#1^8-2737152#1^10+2985984#1^12&,8,0],Root[361-11292#1^2+54448#1^4-92160#1^6+72704#1^8-27648#1^10+4096#1^12&,2,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,1,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,1,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[1-96#1^2+3888#1^4-79488#1^6+767232#1^8-2737152#1^10+2985984#1^12&,8,0],
Root[1-32#1^2+432#1^4-2944#1^6+9472#1^8-11264#1^10+4096#1^12&,8,0],
Root[15625-300000#1^2+2430000#1^4-9936000#1^6+19180800#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,2,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[14641-1163052#1^2+6839568#1^4-1012608#1^6-12918528#1^8-1990656#1^10+2985984#1^12&,7,0],Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,1,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,1,0]},
{Root[841-542844#1^2+3713184#1^4+558144#1^6-5764608#1^8-1244160#1^10+2985984#1^12&,8,0],Root[121-1108#1^2-96#1^4+9920#1^6+4608#1^8-13312#1^10+4096#1^12&,1,0],Root[961-148608#1^2+2974896#1^4-14103936#1^6+22166784#1^8-13685760#1^10+2985984#1^12&,8,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,2,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,2,0]},
{Root[7921-369780#1^2+4366368#1^4-5170176#1^6-1741824#1^8-497664#1^10+2985984#1^12&,7,0],Root[1-188#1^2+8928#1^4-8960#1^6+16384#1^8-18432#1^10+4096#1^12&,1,0],Root[39601-600384#1^2+3539952#1^4-10247040#1^6+15116544#1^8-10699776#1^10+2985984#1^12&,7,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,1,0]},
{Root[130321-1654824#1^2+4097664#1^4+48384#1^6-6594048#1^8+1244160#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],Root[121-155616#1^2+1668528#1^4+1102464#1^6+14121216#1^8-14681088#1^10+2985984#1^12&,8,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,1,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[1-1044#1^2+270144#1^4-3476736#1^6-4831488#1^8+1244160#1^10+2985984#1^12&,8,0],Root[121-3420#1^2+21504#1^4-44288#1^6+40704#1^8-19456#1^10+4096#1^12&,8,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],Root[1-218304#1^2+422064#1^4-245376#1^6+26065152#1^8-18662400#1^10+2985984#1^12&,8,0]},
{Root[4451309+4239891#1+25585637#1^2+26195962#1^3+12670977#1^4+31234656#1^5-19026992#1^6-8300265#1^7+20344044#1^8+4631411#1^9+1859159#1^10-14607929#1^11+4772350#1^12&,3,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,8,0]},
{Root[4451309-4239891#1+25585637#1^2-26195962#1^3+12670977#1^4-31234656#1^5-19026992#1^6+8300265#1^7+20344044#1^8-4631411#1^9+1859159#1^10+14607929#1^11+4772350#1^12&,2,0],Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],Root[14641-263280#1^2+1504368#1^4-2699136#1^6+435456#1^8-1741824#1^10+2985984#1^12&,1,0]},
{Root[-733597-6256840#1-12734255#1^2+6126819#1^3+22979407#1^4-18322356#1^5+25812303#1^6+13537551#1^7-15428379#1^8+19460333#1^9-22685448#1^10-1745412#1^11+4903405#1^12&,6,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,7,0]},
{Root[-733597+6256840#1-12734255#1^2-6126819#1^3+22979407#1^4+18322356#1^5+25812303#1^6-13537551#1^7-15428379#1^8-19460333#1^9-22685448#1^10+1745412#1^11+4903405#1^12&,1,0],Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],Root[212521-2455056#1^2+7899696#1^4-12666240#1^6+16443648#1^8-11695104#1^10+2985984#1^12&,2,0]},
{Root[302813-10499516#1-9739290#1^2+41433808#1^3-11574965#1^4-15958684#1^5+29215167#1^6-732721#1^7-5842077#1^8+16196953#1^9+7887217#1^10-4707171#1^11+14303515#1^12&,4,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],
Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[302813-10499516#1-9739290#1^2+41433808#1^3-11574965#1^4-15958684#1^5+29215167#1^6-732721#1^7-5842077#1^8+16196953#1^9+7887217#1^10-4707171#1^11+14303515#1^12&,4,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],
Root[50712847+14719519#1-16919466#1^2+6949449#1^3-7715885#1^4-1032652#1^5-1650384#1^6+281720#1^7-36438168#1^8+28772184#1^9+49944993#1^10-30795213#1^11+1016#1^12&,1,0]},
{Root[302813+10499516#1-9739290#1^2-41433808#1^3-11574965#1^4+15958684#1^5+29215167#1^6+732721#1^7-5842077#1^8-16196953#1^9+7887217#1^10+4707171#1^11+14303515#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,1,0],
Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]},
{Root[302813+10499516#1-9739290#1^2-41433808#1^3-11574965#1^4+15958684#1^5+29215167#1^6+732721#1^7-5842077#1^8-16196953#1^9+7887217#1^10+4707171#1^11+14303515#1^12&,1,0],Root[1+208#1^2+17264#1^4-452480#1^6+3239168#1^8-7502848#1^10+3936256#1^12&,8,0],
Root[50712847-14719519#1-16919466#1^2-6949449#1^3-7715885#1^4+1032652#1^5-1650384#1^6-281720#1^7-36438168#1^8-28772184#1^9+49944993#1^10+30795213#1^11+1016#1^12&,2,0]}}
*)

(* Pentagonal Icositetrahedron *)

PolyhedronName[PentagonalIcositetrahedron]:=PolyhedronName[PentagonalIcositetrahedron,"dextro"]
PolyhedronFaces[PentagonalIcositetrahedron]:=
	PolyhedronFaces[PentagonalIcositetrahedron,"dextro"]
PolyhedronVertices[PentagonalIcositetrahedron]:=
	PolyhedronVertices[PentagonalIcositetrahedron,"dextro"]

NetFaces[PentagonalIcositetrahedron]:={{60,57,64,69,67},{73,74,72,67,69},{62,67,72,71,66},{58,56,50,47,52},
{41,44,48,52,47},{60,52,48,54,57},{53,55,61,65,59},{70,68,63,59,65},{51,59,63,57,54},{49,54,48,45,43},
{39,35,40,43,45},{46,43,40,38,42},{25,18,13,14,20},{5,16,21,20,14},{28,20,21,26,33},{29,36,40,35,32},
{37,30,24,32,35},{25,32,24,19,18},{8,3,1,4,6},{2,7,11,6,4},{10,6,11,18,19},{15,19,24,27,22},{34,31,23,22,27},
{12,22,23,17,9}}
NetVertices[PentagonalIcositetrahedron]:={{-10.548175435,-1.32023134861},
{-10.154023521,-3.48802246942},{-10.1178760126,-0.417545131235},{-9.90938933094,-2.08961572149},
{-9.08737168902,-4.86858137149},{-8.942965191919999,-1.83266361794},{-8.73447851028,-3.50473420819},
{-8.69833100189,-0.43425687001200003},{-8.36000784507,1.49970577605},{-8.332093466449999,-0.551171107385},
{-8.30417908784,-2.60204799082},{-8.22046419767,0.0869372564203},{-8.19979959047,-2.851928242},
{-8.10150473022,-3.84708557652},{-8.07228253547,-0.267803587364},{-7.92071229567,-5.67746528126},
{-7.49796320342,2.00653813078},{-7.33775494882,-2.34509588727},{-7.1654340731,-1.36005501716},
{-7.15696251426,-4.17547559201},{-7.05866765402,-5.17063292653},{-6.84848656875,0.45171760858800003},
{-6.67616569303,1.4367584787},{-6.19900993408,-1.10310291361},{-6.17109555546,-3.15397979704},
{-6.11412543806,-5.49902294201},{-6.02668905836,-0.118062043493},{-5.93316654754,-3.45595439605},
{-5.80485802003,-3.27089403441},{-5.76871051163,-0.200416696229},{-5.70974155401,1.69371058225},
{-5.56022383,-1.87248728648},{-5.41967852671,-4.77947899803},{-4.80289309164,0.601459152459},
{-4.59379969098,-1.61553518293},{-4.38531300934,-3.28760577319},{-4.34916550094,-0.217128435006},
{-4.12733446261,-3.36996042593},{-3.98292796551,-0.334042672379},{-3.95501358689,-2.38491955581},
{-3.43030874369,0.421315759488},{-3.30553695222,-3.93974007801},{-2.98858944787,-2.12796745226},
{-2.84977514326,-0.874202692079},{-2.81626857216,-1.14292658215},{-2.0817409855,-3.22021888205},
{-2.05833111477,0.786096111655},{-1.84984443314,-0.885974478599},{-1.82193005452,-2.93685136203},
{-1.62803169232,1.68878232903},{-1.45569251909,-3.05376559941},{-1.41954501069,0.0167117387766},
{-1.40812513732,-3.43525769035},{-1.21105832905,-1.65535885148},{-0.827591536883,-4.73077614192},
{-0.628100982203,1.67701054251},{-0.244634190033,-1.39840674793},{-0.0475673817687,0.381492090944},
{-0.036147508398,-3.07047733818},{0.,0.},{0.172339173237,-4.74254792844},
{0.174253708405,0.342687199014},{0.39415191405,-2.16779112081},{0.577163320352,-1.96818640001},
{0.602638595685,-3.83986171106},{1.1601206672,1.36418299398},{1.34091310176,-0.466196710756},
{1.39408262417,-2.17956290733},{1.439207962,-1.46135404528},{1.97461622461,-3.47508135889},
{2.10466288316,1.0357929785},{2.20295774341,0.040635643975},{2.78012106376,-1.92755075603},
{3.02475525379,-0.529144008105}}

PolyhedronDual[PentagonalIcositetrahedron,"dextro"]:=Sequence[SnubCube,"dextro"]
PolyhedronName[PentagonalIcositetrahedron,"dextro"]="pentagonal icositetrahedron (dextro)"
PolyhedronFaces[PentagonalIcositetrahedron,"dextro"]:=
{{5,13,8,21,17},{22,20,6,13,7},{15,18,7,13,5},{8,13,6,16,19},{14,12,29,26,9},
{11,30,27,10,14},{9,23,25,11,14},{14,10,24,28,12},{35,33,18,15,3},{34,19,16,4,36},
{31,17,21,1,37},{38,32,20,22,2},{3,31,37,25,23},{28,24,4,32,38},{26,29,2,33,35},
{1,34,36,27,30},{15,5,17,31,3},{4,16,6,20,32},{2,22,7,18,33},{21,8,19,34,1},
{9,26,35,3,23},{27,36,4,24,10},{25,37,1,30,11},{12,28,38,2,29}}
PolyhedronVertices[PentagonalIcositetrahedron,"dextro"]:=
{{0,0,Root[-1-24#1^2-224#1^4+128#1^6&,1,0]},
{0,0,Root[-1-24#1^2-224#1^4+128#1^6&,2,0]},
{0,Root[-1-24#1^2-224#1^4+128#1^6&,1,0],0},
{0,Root[-1-24#1^2-224#1^4+128#1^6&,2,0],0},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1-24#1^2-224#1^4+128#1^6&,1,0],0,0},
{Root[-1-24#1^2-224#1^4+128#1^6&,2,0],0,0},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]}}

PolyhedronDual[PentagonalIcositetrahedron,"laevo"]:=Sequence[SnubCube,"laevo"]
PolyhedronName[PentagonalIcositetrahedron,"laevo"]:="pentagonal icositetrahedron (laevo)"
PolyhedronFaces[PentagonalIcositetrahedron,"laevo"]:=
{{18,21,8,13,5},{7,13,6,19,22},{5,13,7,17,15},{20,16,6,13,8},{9,25,29,12,14},
{14,10,28,30,11},{14,11,26,23,9},{12,27,24,10,14},{3,15,17,33,35},{36,4,16,20,34},
{37,2,21,18,31},{1,22,19,32,38},{23,26,37,31,3},{38,32,4,24,27},{35,33,1,29,25},
{30,28,36,34,2},{3,31,18,5,15},{32,19,6,16,4},{33,17,7,22,1},{2,34,20,8,21},
{23,3,35,25,9},{10,24,4,36,28},{11,30,2,37,26},{29,1,38,27,12}}
PolyhedronVertices[PentagonalIcositetrahedron,"laevo"]:=
{{0,0,Root[-1-24#1^2-224#1^4+128#1^6&,1,0]},
{0,0,Root[-1-24#1^2-224#1^4+128#1^6&,2,0]},
{0,Root[-1-24#1^2-224#1^4+128#1^6&,1,0],0},
{0,Root[-1-24#1^2-224#1^4+128#1^6&,2,0],0},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1-24#1^2-224#1^4+128#1^6&,1,0],0,0},
{Root[-1-24#1^2-224#1^4+128#1^6&,2,0],0,0},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,1,0],Root[-49+208#1^2-288#1^4+128#1^6&,2,0]},
{Root[-1+16#1^2+96#1^4+128#1^6&,2,0],Root[-1+16#1^2-96#1^4+128#1^6&,2,0],Root[-49+208#1^2-288#1^4+128#1^6&,1,0]}}

(* Pentakis Dodecahedron *)

PolyhedronName[PentakisDodecahedron]:="pentakis dodecahedron"
NetFaces[PentakisDodecahedron]:={{16,20,12},{16,12,10},{16,10,17},{16,17,24},{16,24,22},{15,12,20},{15,20,21},
  {15,21,14},{15,14,7},{15,7,9},{5,10,12},{5,12,4},{5,4,1},{5,1,2},{5,2,8},{11,17,10},{11,10,3},{11,3,6},
  {11,6,13},{11,13,18},{25,24,17},{25,17,19},{25,19,27},{25,27,30},{25,30,26},{28,22,24},{28,24,31},{28,31,32},
  {28,32,29},{28,29,23},{34,42,38},{34,38,32},{34,32,31},{34,31,33},{34,33,39},{45,50,42},{45,42,36},{45,36,44},
  {45,44,51},{45,51,52},{58,53,50},{58,50,55},{58,55,61},{58,61,62},{58,62,56},{57,47,53},{57,53,59},{57,59,60},
  {57,60,54},{57,54,48},{43,40,47},{43,47,49},{43,49,41},{43,41,35},{43,35,37},{46,38,42},{46,42,50},{46,50,53},
  {46,53,47},{46,47,40}}
NetVertices[PentakisDodecahedron]:={{-2.26049084372,0.629397262407},{-2.02733656302,-0.343042494797},
  {-1.64334617913,-0.90301180923},{-1.43998091638,1.20102953857},{-1.43139209459,0.314013121388},
  {-1.41019189843,-1.87545156643},{-1.05854385087,1.76274122002},{-1.0368233344,-0.480459902509},
  {-0.825389570175,0.790301462816},{-0.8228362518010001,-0.331379533066},{-0.814247430003,-1.21839595025},
  {-0.608555842786,0.645392654454},{-0.41967866982,-2.01286897415},{-0.238033923543,2.33437349618},
  {-0.229445101745,1.447357079},{0.,0.},{0.00858882179785,-0.8870164171830001},
  {0.0693949164729,-1.14062644641},{0.241743102496,-1.85945617439},{0.379110741041,0.801964424547},
  {0.593391150056,1.77873661207},{0.59594446843,0.657055616185},{0.723493723379,0.884534440774},
  {0.829098749128,-0.315384141019},{0.837687570926,-1.2024005582},{1.08742229771,-0.351222281663},
  {1.23225633111,-1.9968735821},{1.42504321756,0.341671475166},{1.67477794434,1.19284975171},
  {1.7213299174,-1.12463105436},{1.81961197774,-0.452801548731},{2.30868556403,0.419440979005},
  {2.45351959744,-1.22621032143},{2.70325432422,-0.375032044892},{2.80841438067,1.54324341797},
  {3.04327948705,-1.56265871365},{3.19001100441,0.618914463131},{3.29919879265,0.282023571293},
  {3.4048038184,-0.917895010501},{3.4267480476,0.509502395881},{3.53000672872,2.23556161304},
  {3.53235307335,-0.690416185912},{3.67648277437,1.36068067242},{3.67718710675,-2.33606748635},
  {3.92692183353,-1.48488920981},{4.12829754178,-0.0333605697268},{4.37803226855,0.817817706813},
  {4.39360622132,1.0781499562},{4.43774887715,1.81603307769},{4.52286630196,-0.827833593624},
  {4.62847132771,-2.02775217542},{4.6881879363,-1.02953680454},{5.01193988825,0.0444089341121},
  {5.1151985693799995,1.77046815127},{5.15677392166,-1.60124236632},{5.26003260278,0.124816850836},
  {5.26167461503,0.895587210652},{5.40650864843,-0.750064089785},{5.96322410921,0.352724245044},
  {6.0229407178,1.35093961592},{6.10805814261,-1.29292705539},{6.1677747512,-0.294711684514}}
PolyhedronDual[PentakisDodecahedron]:=TruncatedIcosahedron
PolyhedronFaces[PentakisDodecahedron]:=
{{7,9,19},{21,10,8},{31,14,24},{25,15,32},{6,14,17},{24,19,31},{6,16,15},{21,
    25,32},{9,12,3},{7,19,24},{3,11,10},{8,25,21},{13,14,6},{6,15,13},{7,24,
    18},{8,20,25},{4,1,22},{22,1,5},{9,1,4},{1,10,5},{26,17,31},{32,16,27},{3,
    1,9},{3,10,1},{28,14,13},{13,15,30},{18,12,7},{8,11,20},{16,17,29},{11,12,
    2},{19,26,31},{27,21,32},{29,17,26},{27,16,29},{28,13,23},{23,13,30},{23,
    18,28},{30,20,23},{2,18,23},{23,20,2},{19,9,4},{5,10,21},{24,14,28},{30,
    15,25},{26,22,29},{22,27,29},{4,26,19},{5,21,27},{18,24,28},{25,20,30},{2,
    12,18},{20,11,2},{3,12,11},{4,22,26},{5,27,22},{6,17,16},{17,14,31},{15,
    16,32},{7,12,9},{10,11,8}}
PolyhedronVertices[PentakisDodecahedron]:=
{{Root[81-45#1^2+5#1^4&,2,0],0,Sqrt[9/4+9/(2Sqrt[5])]},
{(9Sqrt[13+22/Sqrt[5]])/19,0,(9Sqrt[13+22/Sqrt[5]])/38},{0,0,(9Sqrt[65+22Sqrt[5]])/38},
{(-9Sqrt[61/2+131/(2Sqrt[5])])/38,(-9(9+Sqrt[5]))/76,(9Sqrt[13+22/Sqrt[5]])/38},
{(-9Sqrt[61/2+131/(2Sqrt[5])])/38,(9(9+Sqrt[5]))/76,(9Sqrt[13+22/Sqrt[5]])/38},
{0,0,(-9Sqrt[65+22Sqrt[5]])/38},{(9Sqrt[(85+Sqrt[5])/10])/38,(-9(7+5Sqrt[5]))/76,
(9Sqrt[13+22/Sqrt[5]])/38},{(9Sqrt[(85+Sqrt[5])/10])/38,(9(7+5Sqrt[5]))/76,(9Sqrt[13+22/Sqrt[5]])/38},
{-Sqrt[9/4-9/(2Sqrt[5])],-3/2,Sqrt[9/4+9/(2Sqrt[5])]},{-Sqrt[9/4-9/(2Sqrt[5])],3/2,
Sqrt[9/4+9/(2Sqrt[5])]},{Sqrt[9/8+9/(8Sqrt[5])],(3(-1+Sqrt[5]))/4,Sqrt[9/4+9/(2Sqrt[5])]},
{Sqrt[9/8+9/(8Sqrt[5])],(-3(-1+Sqrt[5]))/4,Sqrt[9/4+9/(2Sqrt[5])]},
{Sqrt[9/2-9/(2Sqrt[5])],0,(-3Sqrt[1+2/Sqrt[5]])/2},{Sqrt[9/4-9/(2Sqrt[5])],-3/2,
(-3Sqrt[1+2/Sqrt[5]])/2},{Sqrt[9/4-9/(2Sqrt[5])],3/2,(-3Sqrt[1+2/Sqrt[5]])/2},
{(-3Sqrt[(5+Sqrt[5])/10])/2,(3(-1+Sqrt[5]))/4,(-3Sqrt[1+2/Sqrt[5]])/2},
{(-3Sqrt[(5+Sqrt[5])/10])/2,(-3(-1+Sqrt[5]))/4,(-3Sqrt[1+2/Sqrt[5]])/2},
{Sqrt[9/4+9/(2Sqrt[5])],-3/2,Sqrt[9/4-9/(2Sqrt[5])]},{-Sqrt[9/8-9/(8Sqrt[5])],(-3(1+Sqrt[5]))/4,
Sqrt[9/4-9/(2Sqrt[5])]},{Sqrt[9/4+9/(2Sqrt[5])],3/2,Sqrt[9/4-9/(2Sqrt[5])]},
{-Sqrt[9/8-9/(8Sqrt[5])],(3(1+Sqrt[5]))/4,Sqrt[9/4-9/(2Sqrt[5])]},
{-3Sqrt[(5+Sqrt[5])/10],0,Sqrt[9/4-9/(2Sqrt[5])]},{3Sqrt[(5+Sqrt[5])/10],0,-Sqrt[9/4-9/(2Sqrt[5])]},
{Sqrt[9/8-9/(8Sqrt[5])],(-3(1+Sqrt[5]))/4,-Sqrt[9/4-9/(2Sqrt[5])]},
{Sqrt[9/8-9/(8Sqrt[5])],(3(1+Sqrt[5]))/4,-Sqrt[9/4-9/(2Sqrt[5])]},
{(-3Sqrt[1+2/Sqrt[5]])/2,-3/2,-Sqrt[9/4-9/(2Sqrt[5])]},{(-3Sqrt[1+2/Sqrt[5]])/2,3/2,
-Sqrt[9/4-9/(2Sqrt[5])]},{(9Sqrt[61/2+131/(2Sqrt[5])])/38,(-9(9+Sqrt[5]))/76,
(-9Sqrt[13+22/Sqrt[5]])/38},{(-9Sqrt[13+22/Sqrt[5]])/19,0,(-9Sqrt[13+22/Sqrt[5]])/38},
{(9Sqrt[61/2+131/(2Sqrt[5])])/38,(9(9+Sqrt[5]))/76,(-9Sqrt[13+22/Sqrt[5]])/38},
{(-9Sqrt[(85+Sqrt[5])/10])/38,(-9(7+5Sqrt[5]))/76,(-9Sqrt[13+22/Sqrt[5]])/38},
{(-9Sqrt[(85+Sqrt[5])/10])/38,(9(7+5Sqrt[5]))/76,(-9Sqrt[13+22/Sqrt[5]])/38}}

(* Rhombic Dodecahedron *)

PolyhedronName[RhombicDodecahedron]:="rhombic dodecahedron"
NetFaces[RhombicDodecahedron]:={{3,5,2,1},{7,4,2,5},{7,5,6,8},{11,8,6,9},{10,8,11,13},{15,12,10,13},{15,13,14,16},
{19,16,14,17},{18,16,19,21},{23,20,18,21},{23,21,22,24},{26,24,22,25}}
NetVertices[RhombicDodecahedron]:={{-0.824527579823,0.565821765321},{-0.565908230162,1.53180107772},
{0.,0.},{0.242396172715,2.1205658799},{0.258619349661,0.9659793123980001},
{0.544277327566,0.0076476789542},{1.06692375254,1.55474411458},{1.35258173044,0.5964124811379999},
{1.36880490739,-0.558174086367},{1.6112010801,1.56239179354},{2.17710931027,0.0305907158168},
{2.41950548298,2.15115659572},{2.43572865993,0.996570028215},{2.72138663783,0.038238394771},
{3.2440330628,1.5853348304},{3.52969104071,0.627003196955},{3.54591421766,-0.52758337055},
{3.78831039037,1.59298250935},{4.35421862053,0.0611814316336},{4.59661479325,2.18174731154},
{4.61283797019,1.02716074403},{4.8984959481,0.0688291105878},{5.42114237307,1.61592554622},
{5.70680035097,0.657593912772},{5.72302352792,-0.496992654733},{6.5313279308,0.09177214745040001}}
PolyhedronDual[RhombicDodecahedron]:=Cuboctahedron
PolyhedronFaces[RhombicDodecahedron]:=
{Reverse@{4,3,1,2},Reverse@{5,7,2,1},{6,8,3,1},Reverse@{7,9,4,2},{8,10,4,3},{11,6,1,5},
Reverse@{14,10,4,9},Reverse@{11,12,7,5},{11,13,8,6},Reverse@{12,14,9,7},{13,14,10,8},{14,13,11,12}}
PolyhedronVertices[RhombicDodecahedron]:=
{{-3/4, -3/4, 0}, {-3/4, 0, -3/(4*Sqrt[2])}, {-3/4, 0, 3/(4*Sqrt[2])}, 
 {-3/4, 3/4, 0}, {0, -3/4, -3/(4*Sqrt[2])}, {0, -3/4, 3/(4*Sqrt[2])}, 
 {0, 0, -3/(2*Sqrt[2])}, {0, 0, 3/(2*Sqrt[2])}, {0, 3/4, -3/(4*Sqrt[2])}, 
 {0, 3/4, 3/(4*Sqrt[2])}, {3/4, -3/4, 0}, {3/4, 0, -3/(4*Sqrt[2])}, 
 {3/4, 0, 3/(4*Sqrt[2])}, {3/4, 3/4, 0}}

(* Rhombic Hexecontahedron *)

PolyhedronName[RhombicHexecontahedron]:="rhombic hexecontahedron"
PolyhedronFaces[RhombicHexecontahedron]:=
{{9,10,44,43},{6,40,39,5},{7,41,42,8},{45,46,12,11},{61,13,21,35},{36,24,15,
    63},{28,38,30,19},{17,25,37,26},{61,51,59,47},{43,57,37,9},{63,47,59,
    52},{38,58,45,11},{26,53,60,49},{39,55,35,5},{28,49,60,54},{36,56,41,
    7},{5,3,25,17},{41,56,52,31},{7,19,30,4},{51,55,39,31},{9,3,21,13},{45,58,
    54,33},{11,15,24,4},{53,57,43,33},{5,17,18,6},{47,48,62,61},{63,64,48,
    47},{8,20,19,7},{26,49,50,27},{13,14,10,9},{11,12,16,15},{29,50,49,28},{2,
    27,50,29},{52,59,51,31},{1,22,48,23},{54,60,53,33},{2,29,20,8},{35,21,3,
    5},{7,4,24,36},{6,18,27,2},{9,37,25,3},{23,16,12,1},{1,10,14,22},{4,30,38,
    11},{61,35,55,51},{12,46,34,1},{63,52,56,36},{34,44,10,1},{26,37,57,
    53},{8,42,32,2},{28,54,58,38},{32,40,6,2},{61,62,14,13},{32,42,41,31},{31,
    39,40,32},{15,16,64,63},{33,34,46,45},{27,18,17,26},{28,19,20,29},{43,44,
    34,33}}
PolyhedronVertices[RhombicHexecontahedron]:=
{{0,0,-Sqrt[25/16+(5Sqrt[5])/8]},{0,0,Sqrt[25/16+(5Sqrt[5])/8]},{0,(-5-3Sqrt[5])/4,0},
{0,(5+3Sqrt[5])/4,0},{-Sqrt[5/32+Sqrt[5]/32],(-5-3Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[5/32+Sqrt[5]/32],(-5-3Sqrt[5])/8,Sqrt[25/8+(11Sqrt[5])/8]},
{-Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[5/32+Sqrt[5]/32],(-5-3Sqrt[5])/8,-Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[5/32+Sqrt[5]/32],(-5-3Sqrt[5])/8,-Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,-Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[5/32+Sqrt[5]/32],(5+3Sqrt[5])/8,-Sqrt[25/8+(11Sqrt[5])/8]},
{-Sqrt[5/16+Sqrt[5]/8],(-5-2Sqrt[5])/4,-Sqrt[5/4+Sqrt[5]/2]},
{-Sqrt[5/16+Sqrt[5]/8],(-5-2Sqrt[5])/4,-Sqrt[85/16+(19Sqrt[5])/8]},
{-Sqrt[5/16+Sqrt[5]/8],(5+2Sqrt[5])/4,-Sqrt[5/4+Sqrt[5]/2]},
{-Sqrt[5/16+Sqrt[5]/8],(5+2Sqrt[5])/4,-Sqrt[85/16+(19Sqrt[5])/8]},
{Sqrt[5/16+Sqrt[5]/8],(-5-2Sqrt[5])/4,Sqrt[5/4+Sqrt[5]/2]},
{Sqrt[5/16+Sqrt[5]/8],(-5-2Sqrt[5])/4,Sqrt[85/16+(19Sqrt[5])/8]},
{Sqrt[5/16+Sqrt[5]/8],(5+2Sqrt[5])/4,Sqrt[5/4+Sqrt[5]/2]},
{Sqrt[5/16+Sqrt[5]/8],(5+2Sqrt[5])/4,Sqrt[85/16+(19Sqrt[5])/8]},
{-Sqrt[25/32+(11Sqrt[5])/32],(-15-7Sqrt[5])/8,-Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,-Sqrt[25/8+(11Sqrt[5])/8]},
{-Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,-Sqrt[25/8+(11Sqrt[5])/8]},
{-Sqrt[25/32+(11Sqrt[5])/32],(15+7Sqrt[5])/8,-Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(-15-7Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[25/32+(11Sqrt[5])/32],(15+7Sqrt[5])/8,Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[5/4+Sqrt[5]/2],0,Sqrt[5/16+Sqrt[5]/8]},{-Sqrt[5/4+Sqrt[5]/2],0,
Sqrt[25/8+(11Sqrt[5])/8]},{Sqrt[5/4+Sqrt[5]/2],0,-Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[5/4+Sqrt[5]/2],0,-Sqrt[25/8+(11Sqrt[5])/8]},{-Sqrt[25/16+(5Sqrt[5])/8],(-5-2Sqrt[5])/4,
0},{-Sqrt[25/16+(5Sqrt[5])/8],(5+2Sqrt[5])/4,0},{Sqrt[25/16+(5Sqrt[5])/8],(-5-2Sqrt[5])/4,
0},{Sqrt[25/16+(5Sqrt[5])/8],(5+2Sqrt[5])/4,0},{-Sqrt[65/32+(29Sqrt[5])/32],
(-5-3Sqrt[5])/8,Sqrt[5/4+Sqrt[5]/2]},{-Sqrt[65/32+(29Sqrt[5])/32],(-5-3Sqrt[5])/8,
Sqrt[85/16+(19Sqrt[5])/8]},{-Sqrt[65/32+(29Sqrt[5])/32],(5+3Sqrt[5])/8,Sqrt[5/4+Sqrt[5]/2]},
{-Sqrt[65/32+(29Sqrt[5])/32],(5+3Sqrt[5])/8,Sqrt[85/16+(19Sqrt[5])/8]},
{Sqrt[65/32+(29Sqrt[5])/32],(-5-3Sqrt[5])/8,-Sqrt[5/4+Sqrt[5]/2]},
{Sqrt[65/32+(29Sqrt[5])/32],(-5-3Sqrt[5])/8,-Sqrt[85/16+(19Sqrt[5])/8]},
{Sqrt[65/32+(29Sqrt[5])/32],(5+3Sqrt[5])/8,-Sqrt[5/4+Sqrt[5]/2]},
{Sqrt[65/32+(29Sqrt[5])/32],(5+3Sqrt[5])/8,-Sqrt[85/16+(19Sqrt[5])/8]},
{-Sqrt[25/8+(11Sqrt[5])/8],0,-Sqrt[5/4+Sqrt[5]/2]},{-Sqrt[25/8+(11Sqrt[5])/8],0,
-Sqrt[85/16+(19Sqrt[5])/8]},{Sqrt[25/8+(11Sqrt[5])/8],0,Sqrt[5/4+Sqrt[5]/2]},
{Sqrt[25/8+(11Sqrt[5])/8],0,Sqrt[85/16+(19Sqrt[5])/8]},
{-Sqrt[125/32+(55Sqrt[5])/32],(-5-Sqrt[5])/8,0},{-Sqrt[125/32+(55Sqrt[5])/32],(5+Sqrt[5])/8,
0},{Sqrt[125/32+(55Sqrt[5])/32],(-5-Sqrt[5])/8,0},{Sqrt[125/32+(55Sqrt[5])/32],
(5+Sqrt[5])/8,0},{-Sqrt[85/16+(19Sqrt[5])/8],(-5-2Sqrt[5])/4,Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[85/16+(19Sqrt[5])/8],(5+2Sqrt[5])/4,Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[85/16+(19Sqrt[5])/8],(-5-2Sqrt[5])/4,-Sqrt[5/16+Sqrt[5]/8]},
{Sqrt[85/16+(19Sqrt[5])/8],(5+2Sqrt[5])/4,-Sqrt[5/16+Sqrt[5]/8]},
{-Sqrt[65/8+(29Sqrt[5])/8],0,-Sqrt[5/16+Sqrt[5]/8]},{Sqrt[65/8+(29Sqrt[5])/8],0,
Sqrt[5/16+Sqrt[5]/8]},{Root[5-400#1^2+256#1^4&,1,0],(-5-Sqrt[5])/8,
-Sqrt[5/16+Sqrt[5]/8]},{Root[5-400#1^2+256#1^4&,1,0],(-5-Sqrt[5])/8,
-Sqrt[25/8+(11Sqrt[5])/8]},{Root[5-400#1^2+256#1^4&,1,0],(5+Sqrt[5])/8,
-Sqrt[5/16+Sqrt[5]/8]},{Root[5-400#1^2+256#1^4&,1,0],(5+Sqrt[5])/8,
-Sqrt[25/8+(11Sqrt[5])/8]}}

(* Rhombic Triacontahedron *)

PolyhedronName[RhombicTriacontahedron]:="rhombic triacontahedron"
NetFaces[RhombicTriacontahedron]:={{4,1,3,6},{3,7,10,6},{3,2,5,7},{10,7,9,13},{9,14,17,13},{9,8,11,14},
  {16,12,15,18},{15,19,22,18},{15,13,17,19},{22,19,21,25},{21,26,29,25},{21,20,23,26},{28,24,27,30},{27,31,34,30},
  {27,25,29,31},{34,31,33,37},{33,38,41,37},{33,32,35,38},{40,36,39,42},{39,43,46,42},{39,37,41,43},{46,43,45,49},
  {45,50,53,49},{45,44,47,50},{52,48,51,54},{51,55,58,54},{51,49,53,55},{58,55,57,60},{57,61,62,60},{57,56,59,61}}
NetVertices[RhombicTriacontahedron]:={{-0.848521685476,-0.529160608206},{-0.840481007634,-2.52106300735},
  {-0.754696482912,-1.52474929404},{0.,0.},{0.0122850625731,-3.0433560568},
  {0.0938252025637,-0.995588685836},{0.0980695872942,-2.04704234349},{0.106110265137,-4.03894474263},
  {0.191894789858,-3.04263102933},{0.94659127277,-1.51788173529},{0.958876335344,-4.56123779208},
  {1.03237579749,-0.521568021982},{1.04041647533,-2.51347042112},{1.04466086006,-3.56492407878},
  {1.12620100006,-1.51715670782},{1.88089748297,0.00759258622409},{1.89318254554,-3.03576347057},
  {1.97472268553,-0.987996099612},{1.97896707026,-2.03944975727},{1.9870077481,-4.03135215641},
  {2.07279227283,-3.0350384431},{2.82748875574,-1.51028914906},{2.83977381831,-4.55364520586},
  {2.91327328046,-0.513975435758},{2.9213139583,-2.5058778349},{2.92555834303,-3.55733149255},
  {3.00709848302,-1.50956412159},{3.76179496594,0.0151851724482},{3.77408002851,-3.02817088435},
  {3.8556201685,-0.980403513387},{3.85986455323,-2.03185717104},{3.86790523107,-4.02375957018},
  {3.95368975579,-3.02744585688},{4.70838623871,-1.50269656284},{4.72067130128,-4.54605261963},
  {4.79417076343,-0.506382849533},{4.80221144127,-2.49828524867},{4.806455826,-3.54973890633},
  {4.88799596599,-1.50197153537},{5.6426924489,0.0227777586723},{5.65497751148,-3.02057829812},
  {5.73651765147,-0.972810927163},{5.7407620362,-2.02426458482},{5.74880271404,-4.01616698396},
  {5.83458723876,-3.01985327066},{6.58928372167,-1.49510397661},{6.60156878425,-4.53846003341},
  {6.6750682464,-0.498790263309},{6.68310892424,-2.49069266245},{6.68735330897,-3.54214632011},
  {6.76889344896,-1.49437894914},{7.52358993187,0.0303703448963},{7.53587499444,-3.0129857119},
  {7.61741513444,-0.965218340939},{7.62165951917,-2.0166719986},{7.62970019701,-4.00857439774},
  {7.71548472173,-3.01226068443},{8.47018120464,-1.48751139039},{8.48246626721,-4.53086744719},
  {8.56400640721,-2.48310007623},{8.56825079194,-3.53455373388},{9.41677247741,-3.00539312568}}
PolyhedronDual[RhombicTriacontahedron]:=Icosidodecahedron
PolyhedronFaces[RhombicTriacontahedron]:={{16,15,11,12},{14,13,17,18},{10,28,20,30},{8,
      5,6,25},{12,28,31,16},{32,30,14,18},{6,3,11,15},{8,17,13,4},{11,21,19,
      27},{13,29,19,22},{7,16,23,26},{24,18,9,26},{12,11,27,28},{30,29,13,
      14},{7,6,15,16},{18,17,8,9},{2,22,19,21},{23,1,24,26},{3,2,21,11},{4,13,
      22,2},{16,31,1,23},{1,32,18,24},{31,28,10,1},{10,30,32,1},{6,5,2,3},{8,
      4,2,5},{28,27,19,20},{20,19,29,30},{26,25,6,7},{9,8,25,26}}
PolyhedronVertices[RhombicTriacontahedron]:=
	{{0,0,-Sqrt[5(5+2Sqrt[5])]/4},{0,0,
      Sqrt[5(5+2Sqrt[5])]/4},{Sqrt[5/32-Sqrt[5]/32],(-5-Sqrt[5])/8,
      Sqrt[25/32+(11Sqrt[5])/32]},{Sqrt[5/32-Sqrt[5]/32],(5+Sqrt[5])/8,
      Sqrt[25/32+(11Sqrt[5])/32]},{Sqrt[5/8+Sqrt[5]/8],0,
      Sqrt[25/32+(11Sqrt[5])/32]},{Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/
        8,Sqrt[5+2Sqrt[5]]/4},{Sqrt[25/32+(11Sqrt[5])/32],(-5-Sqrt[5])/8,
      Root[5-80#1^2+256#1^4&,2,0]},{Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/
        8,Sqrt[5+2Sqrt[5]]/4},{Sqrt[25/32+(11Sqrt[5])/32],(5+Sqrt[5])/8,
      Root[5-80#1^2+256#1^4&,2,0]},{-Sqrt[(5+Sqrt[5])/2]/2,0,
      Root[5-400#1^2+256#1^4&,1,0]},{-Sqrt[(5+Sqrt[5])/2]/4,(-5-3Sqrt[5])/
        8,Sqrt[5+2Sqrt[5]]/4},{-Sqrt[(5+Sqrt[5])/2]/4,(-5-3Sqrt[5])/8,
      Root[5-80#1^2+256#1^4&,2,0]},{-Sqrt[(5+Sqrt[5])/2]/4,(5+3Sqrt[5])/8,
      Sqrt[5+2Sqrt[5]]/4},{-Sqrt[(5+Sqrt[5])/2]/4,(5+3Sqrt[5])/8,
      Root[5-80#1^2+256#1^4&,2,0]},{Sqrt[(5+Sqrt[5])/2]/4,(-5-3Sqrt[5])/8,
      Sqrt[5/32-Sqrt[5]/32]},{Sqrt[(5+Sqrt[5])/2]/4,(-5-3Sqrt[5])/
        8,-Sqrt[5+2Sqrt[5]]/4},{Sqrt[(5+Sqrt[5])/2]/4,(5+3Sqrt[5])/8,
      Sqrt[5/32-Sqrt[5]/32]},{Sqrt[(5+Sqrt[5])/2]/4,(5+3Sqrt[5])/
        8,-Sqrt[5+2Sqrt[5]]/4},{-Sqrt[5+2Sqrt[5]]/2,0,
      Sqrt[5+2Sqrt[5]]/4},{-Sqrt[5+2Sqrt[5]]/2,0,
      Root[5-80#1^2+256#1^4&,2,0]},{-Sqrt[5+2Sqrt[5]]/4,-Sqrt[5]/4,
      Sqrt[25/32+(11Sqrt[5])/32]},{-Sqrt[5+2Sqrt[5]]/4,Sqrt[5]/4,
      Sqrt[25/32+(11Sqrt[5])/32]},{Sqrt[5+2Sqrt[5]]/4,-Sqrt[5]/4,
      Root[5-400#1^2+256#1^4&,1,0]},{Sqrt[5+2Sqrt[5]]/4,Sqrt[5]/4,
      Root[5-400#1^2+256#1^4&,1,0]},{Sqrt[5+2Sqrt[5]]/2,0,
      Sqrt[5/32-Sqrt[5]/32]},{Sqrt[5+2Sqrt[5]]/2,
      0,-Sqrt[5+2Sqrt[5]]/4},{Root[5-400#1^2+256#1^4&,1,0],(-5-Sqrt[5])/8,
      Sqrt[5/32-Sqrt[5]/32]},{Root[5-400#1^2+256#1^4&,1,0],(-5-Sqrt[5])/
        8,-Sqrt[5+2Sqrt[5]]/4},{Root[5-400#1^2+256#1^4&,1,0],(5+Sqrt[5])/8,
      Sqrt[5/32-Sqrt[5]/32]},{Root[5-400#1^2+256#1^4&,1,0],(5+Sqrt[5])/
        8,-Sqrt[5+2Sqrt[5]]/4},{Root[5-80#1^2+256#1^4&,2,0],(-5-Sqrt[5])/8,
      Root[5-400#1^2+256#1^4&,1,0]},{Root[5-80#1^2+256#1^4&,2,
        0],(5+Sqrt[5])/8,Root[5-400#1^2+256#1^4&,1,0]}}

(* Small Rhombicosidodecahedron *)

PolyhedronName[SmallRhombicosidodecahedron]:="small rhombicosidodecahedron"
NetFaces[SmallRhombicosidodecahedron]:={{11,8,14,17},{17,14,21},{14,13,20,21},{5,1,4,13,14},{13,16,20},{20,16,25,29},{7,10,16,13},{7,3,10},{3,2,9,10},{10,9,18,22,19},{2,6,9},{9,6,12,15},{33,30,37,40},{40,37,45},{37,36,44,45},{27,23,26,36,37},{36,39,44},{44,39,50,54},{29,32,39,36},{29,25,32},{25,24,31,32},{32,31,41,46,42},{24,28,31},{31,28,35,38},{58,55,61,64},{64,61,68},{61,60,67,68},{52,47,51,60,61},{60,63,67},{67,63,72,76},{54,57,63,60},{54,50,57},{50,49,56,57},{57,56,65,69,66},{49,53,56},{56,53,59,62},{80,77,83,86},{86,83,90},{83,82,89,90},{74,70,73,82,83},{82,85,89},{89,85,95,100},{76,79,85,82},{76,72,79},{72,71,78,79},{79,78,87,92,88},{71,75,78},{78,75,81,84},{104,101,108,111},{111,108,115},{108,107,114,115},{98,93,97,107,108},{107,110,114},{114,110,117,118},{100,103,110,107},{100,95,103},{95,94,102,103},{103,102,112,116,113},{94,99,102},{102,99,106,109},{34,33,40,48,43},{99,91,96,105,106}}
NetVertices[SmallRhombicosidodecahedron]:={{(-8-4Sqrt[2(5-Sqrt[5])]-2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/16,0},{(-2-Sqrt[3])/2,(-4-Sqrt[3])/2},{(-2-Sqrt[3])/2,(-2-Sqrt[3])/2},{(-4-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/8,(-1-Sqrt[5])/4},{(-8-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-2Sqrt[2(5+Sqrt[5])])/16,(1+Sqrt[5])/4},{(-1-Sqrt[3])/2,-2-Sqrt[3]},{(-1-Sqrt[3])/2,-1},{(-1-Sqrt[3])/2,1},{-Sqrt[3]/2,(-4-Sqrt[3])/2},{-Sqrt[3]/2,(-2-Sqrt[3])/2},{-Sqrt[3]/2,(2+Sqrt[3])/2},{-1/2,(-5-2Sqrt[3])/2},{-1/2,-1/2},{-1/2,1/2},{0,(-5-Sqrt[3])/2},{0,(-1-Sqrt[3])/2},{0,(1+Sqrt[3])/2},{(-8Sqrt[3]-2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-7-2Sqrt[3]-Sqrt[5])/4},{(-8Sqrt[3]+Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+2Sqrt[2(5+Sqrt[5])])/16,(-5-2Sqrt[3]+Sqrt[5])/4},{1/2,-1/2},{1/2,1/2},{(-8Sqrt[3]+2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-3-Sqrt[3])/2},{(8+16Sqrt[3]-4Sqrt[2(5-Sqrt[5])]-2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/16,0},{Sqrt[3]/2,(-4-Sqrt[3])/2},{Sqrt[3]/2,(-2-Sqrt[3])/2},{(4+8Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/8,(-1-Sqrt[5])/4},{(8+16Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-2Sqrt[2(5+Sqrt[5])])/16,(1+Sqrt[5])/4},{(1+Sqrt[3])/2,-2-Sqrt[3]},{(1+Sqrt[3])/2,-1},{(1+Sqrt[3])/2,1},{(2+Sqrt[3])/2,(-4-Sqrt[3])/2},{(2+Sqrt[3])/2,(-2-Sqrt[3])/2},{(2+Sqrt[3])/2,(2+Sqrt[3])/2},{(32+20Sqrt[3]-4Sqrt[15]+3Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/32,(28+16Sqrt[3]+4Sqrt[5]+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])]+3Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(1+2Sqrt[3])/2,(-5-2Sqrt[3])/2},{(1+2Sqrt[3])/2,-1/2},{(1+2Sqrt[3])/2,1/2},{1+Sqrt[3],(-5-Sqrt[3])/2},{1+Sqrt[3],(-1-Sqrt[3])/2},{1+Sqrt[3],(1+Sqrt[3])/2},{(16+8Sqrt[3]-2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-7-2Sqrt[3]-Sqrt[5])/4},{(16+8Sqrt[3]+Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+2Sqrt[2(5+Sqrt[5])])/16,(-5-2Sqrt[3]+Sqrt[5])/4},{(16+12Sqrt[3]+3Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])])/16,(12+8Sqrt[3]+3Sqrt[6(5-Sqrt[5])]+Sqrt[30(5-Sqrt[5])])/16},{(3+2Sqrt[3])/2,-1/2},{(3+2Sqrt[3])/2,1/2},{(16+8Sqrt[3]+2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-3-Sqrt[3])/2},{(24+32Sqrt[3]-4Sqrt[2(5-Sqrt[5])]-2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/16,0},{(32+28Sqrt[3]+4Sqrt[15]+4Sqrt[2(5-Sqrt[5])]+2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/32,(20+16Sqrt[3]-4Sqrt[5]+4Sqrt[6(5-Sqrt[5])]+2Sqrt[30(5-Sqrt[5])]+Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(2+3Sqrt[3])/2,(-4-Sqrt[3])/2},{(2+3Sqrt[3])/2,(-2-Sqrt[3])/2},{(12+16Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/8,(-1-Sqrt[5])/4},{(24+32Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-2Sqrt[2(5+Sqrt[5])])/16,(1+Sqrt[5])/4},{(3(1+Sqrt[3]))/2,-2-Sqrt[3]},{(3(1+Sqrt[3]))/2,-1},{(3(1+Sqrt[3]))/2,1},{(4+3Sqrt[3])/2,(-4-Sqrt[3])/2},{(4+3Sqrt[3])/2,(-2-Sqrt[3])/2},{(4+3Sqrt[3])/2,(2+Sqrt[3])/2},{(3+4Sqrt[3])/2,(-5-2Sqrt[3])/2},{(3+4Sqrt[3])/2,-1/2},{(3+4Sqrt[3])/2,1/2},{2(1+Sqrt[3]),(-5-Sqrt[3])/2},{2(1+Sqrt[3]),(-1-Sqrt[3])/2},{2(1+Sqrt[3]),(1+Sqrt[3])/2},{(32+24Sqrt[3]-2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-7-2Sqrt[3]-Sqrt[5])/4},{(32+24Sqrt[3]+Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+2Sqrt[2(5+Sqrt[5])])/16,(-5-2Sqrt[3]+Sqrt[5])/4},{(5+4Sqrt[3])/2,-1/2},{(5+4Sqrt[3])/2,1/2},{(32+24Sqrt[3]+2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-3-Sqrt[3])/2},{(40+48Sqrt[3]-4Sqrt[2(5-Sqrt[5])]-2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/16,0},{(4+5Sqrt[3])/2,(-4-Sqrt[3])/2},{(4+5Sqrt[3])/2,(-2-Sqrt[3])/2},{(20+24Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/8,(-1-Sqrt[5])/4},{(40+48Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-2Sqrt[2(5+Sqrt[5])])/16,(1+Sqrt[5])/4},{(5(1+Sqrt[3]))/2,-2-Sqrt[3]},{(5(1+Sqrt[3]))/2,-1},{(5(1+Sqrt[3]))/2,1},{(6+5Sqrt[3])/2,(-4-Sqrt[3])/2},{(6+5Sqrt[3])/2,(-2-Sqrt[3])/2},{(6+5Sqrt[3])/2,(2+Sqrt[3])/2},{(5+6Sqrt[3])/2,(-5-2Sqrt[3])/2},{(5+6Sqrt[3])/2,-1/2},{(5+6Sqrt[3])/2,1/2},{3(1+Sqrt[3]),(-5-Sqrt[3])/2},{3(1+Sqrt[3]),(-1-Sqrt[3])/2},{3(1+Sqrt[3]),(1+Sqrt[3])/2},{(48+40Sqrt[3]-2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-7-2Sqrt[3]-Sqrt[5])/4},{(48+40Sqrt[3]+Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+2Sqrt[2(5+Sqrt[5])])/16,(-5-2Sqrt[3]+Sqrt[5])/4},{(7+6Sqrt[3])/2,-1/2},{(7+6Sqrt[3])/2,1/2},{(56+58Sqrt[3]-2Sqrt[15]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/16,(-34-16Sqrt[3]+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(48+40Sqrt[3]+2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-3-Sqrt[3])/2},{(56+64Sqrt[3]-4Sqrt[2(5-Sqrt[5])]-2Sqrt[10(5-Sqrt[5])]+Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/16,0},{(6+7Sqrt[3])/2,(-4-Sqrt[3])/2},{(6+7Sqrt[3])/2,(-2-Sqrt[3])/2},{(112+120Sqrt[3]-3Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/32,(-72-32Sqrt[3]-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(28+32Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])])/8,(-1-Sqrt[5])/4},{(56+64Sqrt[3]-Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-2Sqrt[2(5+Sqrt[5])])/16,(1+Sqrt[5])/4},{(7(1+Sqrt[3]))/2,-2-Sqrt[3]},{(7(1+Sqrt[3]))/2,-1},{(7(1+Sqrt[3]))/2,1},{(8+7Sqrt[3])/2,(-4-Sqrt[3])/2},{(8+7Sqrt[3])/2,(-2-Sqrt[3])/2},{(8+7Sqrt[3])/2,(2+Sqrt[3])/2},{(112+124Sqrt[3]+4Sqrt[15]+Sqrt[2(5-Sqrt[5])]-Sqrt[10(5-Sqrt[5])]-Sqrt[2(5+Sqrt[5])]-Sqrt[10(5+Sqrt[5])])/32,(-76-32Sqrt[3]-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(7+8Sqrt[3])/2,(-5-2Sqrt[3])/2},{(7+8Sqrt[3])/2,-1/2},{(7+8Sqrt[3])/2,1/2},{4(1+Sqrt[3]),(-5-Sqrt[3])/2},{4(1+Sqrt[3]),(-1-Sqrt[3])/2},{4(1+Sqrt[3]),(1+Sqrt[3])/2},{(64+56Sqrt[3]-2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-7-2Sqrt[3]-Sqrt[5])/4},{(64+56Sqrt[3]+Sqrt[2(5-Sqrt[5])]+Sqrt[10(5-Sqrt[5])]+2Sqrt[2(5+Sqrt[5])])/16,(-5-2Sqrt[3]+Sqrt[5])/4},{(9+8Sqrt[3])/2,-1/2},{(9+8Sqrt[3])/2,1/2},{(64+56Sqrt[3]+2Sqrt[2(5-Sqrt[5])]+3Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/16,(-3-Sqrt[3])/2},{(8+9Sqrt[3])/2,(-2-Sqrt[3])/2},{(9(1+Sqrt[3]))/2,-1}}
PolyhedronDual[SmallRhombicosidodecahedron]:=DeltoidalHexecontahedron
PolyhedronFaces[SmallRhombicosidodecahedron]:=
{{36,23,27},{37,28,24},{40,8,7},{35,5,6},{38,29,25},{39,26,30},{10,14,2},{9,1,
    13},{12,4,16},{11,15,3},{54,45,41},{55,42,46},{58,19,20},{53,18,17},{56,
    43,47},{57,48,44},{34,32,22},{33,21,31},{59,51,49},{60,50,52},{27,31,21,
    36},{23,36,1,9},{10,2,37,24},{37,22,32,28},{8,40,30,26},{25,29,40,7},{35,
    27,23,5},{6,24,28,35},{3,38,25,11},{21,33,29,38},{39,30,34,22},{12,26,39,
    4},{55,14,10,42},{41,9,13,54},{57,44,12,16},{15,11,43,56},{45,54,59,
    49},{50,60,55,46},{48,58,20,44},{43,19,58,47},{53,17,41,45},{46,42,18,
    53},{59,56,47,51},{52,48,57,60},{31,32,34,33},{17,18,6,5},{1,3,15,13},{14,
    16,4,2},{7,8,20,19},{51,52,50,49},{3,1,36,21,38},{22,37,2,4,39},{29,33,34,
    30,40},{27,35,28,32,31},{42,10,24,6,18},{41,17,5,23,9},{20,8,26,12,
    44},{11,25,7,19,43},{56,59,54,13,15},{57,16,14,55,60},{58,48,52,51,
    47},{49,50,46,53,45}}
PolyhedronVertices[SmallRhombicosidodecahedron]:=
{{-1/2,-1/2,-1-Sqrt[5]/2},{-1/2,-1/2,(2+Sqrt[5])/2},{-1/2,1/2,-1-Sqrt[5]/2},
{-1/2,1/2,(2+Sqrt[5])/2},{-1/2,-1-Sqrt[5]/2,-1/2},{-1/2,-1-Sqrt[5]/2,1/2},
{-1/2,(2+Sqrt[5])/2,-1/2},{-1/2,(2+Sqrt[5])/2,1/2},
{0,(-3+Sqrt[5])^(-1),(-5-Sqrt[5])/4},{0,(-3+Sqrt[5])^(-1),(5+Sqrt[5])/4},
{0,(3+Sqrt[5])/4,(-5-Sqrt[5])/4},{0,(3+Sqrt[5])/4,(5+Sqrt[5])/4},
{1/2,-1/2,-1-Sqrt[5]/2},{1/2,-1/2,(2+Sqrt[5])/2},{1/2,1/2,-1-Sqrt[5]/2},
{1/2,1/2,(2+Sqrt[5])/2},{1/2,-1-Sqrt[5]/2,-1/2},{1/2,-1-Sqrt[5]/2,1/2},
{1/2,(2+Sqrt[5])/2,-1/2},{1/2,(2+Sqrt[5])/2,1/2},
{(-5-Sqrt[5])/4,0,(-3+Sqrt[5])^(-1)},{(-5-Sqrt[5])/4,0,(3+Sqrt[5])/4},
{(-1-Sqrt[5])/4,(-1-Sqrt[5])/2,(-3+Sqrt[5])^(-1)},
{(-1-Sqrt[5])/4,(-1-Sqrt[5])/2,(3+Sqrt[5])/4},{(-1-Sqrt[5])/4,(1+Sqrt[5])/2,
(-3+Sqrt[5])^(-1)},{(-1-Sqrt[5])/4,(1+Sqrt[5])/2,(3+Sqrt[5])/4},
{(-1-Sqrt[5])/2,(-3+Sqrt[5])^(-1),(-1-Sqrt[5])/4},
{(-1-Sqrt[5])/2,(-3+Sqrt[5])^(-1),(1+Sqrt[5])/4},
{(-1-Sqrt[5])/2,(3+Sqrt[5])/4,(-1-Sqrt[5])/4},{(-1-Sqrt[5])/2,(3+Sqrt[5])/4,
(1+Sqrt[5])/4},{-1-Sqrt[5]/2,-1/2,-1/2},{-1-Sqrt[5]/2,-1/2,1/2},
{-1-Sqrt[5]/2,1/2,-1/2},{-1-Sqrt[5]/2,1/2,1/2},{(-3+Sqrt[5])^(-1),(-5-Sqrt[5])/4,
0},{(-3+Sqrt[5])^(-1),(-1-Sqrt[5])/4,(-1-Sqrt[5])/2},
{(-3+Sqrt[5])^(-1),(-1-Sqrt[5])/4,(1+Sqrt[5])/2},
{(-3+Sqrt[5])^(-1),(1+Sqrt[5])/4,(-1-Sqrt[5])/2},
{(-3+Sqrt[5])^(-1),(1+Sqrt[5])/4,(1+Sqrt[5])/2},{(-3+Sqrt[5])^(-1),(5+Sqrt[5])/4,
0},{(1+Sqrt[5])/4,(-1-Sqrt[5])/2,(-3+Sqrt[5])^(-1)},
{(1+Sqrt[5])/4,(-1-Sqrt[5])/2,(3+Sqrt[5])/4},{(1+Sqrt[5])/4,(1+Sqrt[5])/2,
(-3+Sqrt[5])^(-1)},{(1+Sqrt[5])/4,(1+Sqrt[5])/2,(3+Sqrt[5])/4},
{(1+Sqrt[5])/2,(-3+Sqrt[5])^(-1),(-1-Sqrt[5])/4},
{(1+Sqrt[5])/2,(-3+Sqrt[5])^(-1),(1+Sqrt[5])/4},
{(1+Sqrt[5])/2,(3+Sqrt[5])/4,(-1-Sqrt[5])/4},{(1+Sqrt[5])/2,(3+Sqrt[5])/4,
(1+Sqrt[5])/4},{(2+Sqrt[5])/2,-1/2,-1/2},{(2+Sqrt[5])/2,-1/2,1/2},
{(2+Sqrt[5])/2,1/2,-1/2},{(2+Sqrt[5])/2,1/2,1/2},
{(3+Sqrt[5])/4,(-5-Sqrt[5])/4,0},{(3+Sqrt[5])/4,(-1-Sqrt[5])/4,(-1-Sqrt[5])/2},
{(3+Sqrt[5])/4,(-1-Sqrt[5])/4,(1+Sqrt[5])/2},{(3+Sqrt[5])/4,(1+Sqrt[5])/4,
(-1-Sqrt[5])/2},{(3+Sqrt[5])/4,(1+Sqrt[5])/4,(1+Sqrt[5])/2},
{(3+Sqrt[5])/4,(5+Sqrt[5])/4,0},{(5+Sqrt[5])/4,0,(-3+Sqrt[5])^(-1)},
{(5+Sqrt[5])/4,0,(3+Sqrt[5])/4}}

(* Small Rhombicuboctahedron *)

PolyhedronName[SmallRhombicuboctahedron]:="small rhombicuboctahedron"
NetFaces[SmallRhombicuboctahedron]:={{4,3,7,8},{3,2,6,7},{2,1,5,6},{10,7,14},{7,6,13,14},{6,9,13},{15,14,20,21},{14,13,19,20},{13,12,18,19},{24,20,27},{20,19,26,27},{19,23,26},{28,27,31,32},{27,26,30,31},{26,25,29,30},{34,31,37},{31,30,36,37},{30,33,36},{38,37,41,42},{37,36,40,41},{36,35,39,40},{44,41,46},{41,40,45,46},{40,43,45},{16,15,21,22},{12,11,17,18}}
NetVertices[SmallRhombicuboctahedron]:={{-1/2,-5/2},{-1/2,-3/2},{-1/2,-1/2},{-1/2,1/2},{1/2,-5/2},{1/2,-3/2},{1/2,-1/2},{1/2,1/2},{1,(-3-Sqrt[3])/2},{1,(-1+Sqrt[3])/2},{3/2,-7/2},{3/2,-5/2},{3/2,-3/2},{3/2,-1/2},{3/2,1/2},{3/2,3/2},{5/2,-7/2},{5/2,-5/2},{5/2,-3/2},{5/2,-1/2},{5/2,1/2},{5/2,3/2},{3,(-3-Sqrt[3])/2},{3,(-1+Sqrt[3])/2},{7/2,-5/2},{7/2,-3/2},{7/2,-1/2},{7/2,1/2},{9/2,-5/2},{9/2,-3/2},{9/2,-1/2},{9/2,1/2},{5,(-3-Sqrt[3])/2},{5,(-1+Sqrt[3])/2},{11/2,-5/2},{11/2,-3/2},{11/2,-1/2},{11/2,1/2},{13/2,-5/2},{13/2,-3/2},{13/2,-1/2},{13/2,1/2},{7,(-3-Sqrt[3])/2},{7,(-1+Sqrt[3])/2},{15/2,-3/2},{15/2,-1/2}}
PolyhedronDual[SmallRhombicuboctahedron]:=DeltoidalIcositetrahedron
PolyhedronFaces[SmallRhombicuboctahedron]:=
	{{3,11,9,1},{2,10,12,4},{24,22,21,23},{19,17,18,20},{5,13,14,6},{8,16,15,
    7},{13,21,22,14},{16,24,23,15},{6,18,17,5},{7,19,20,8},{6,14,10,2},{4,12,
    16,8},{22,24,12,10},{2,4,20,18},{1,9,13,5},{7,15,11,3},{9,11,23,21},{17,
    19,3,1},{22,10,14},{16,12,24},{6,2,18},{20,4,8},{13,9,21},{23,11,15},{17,
    1,5},{7,3,19}}
PolyhedronVertices[SmallRhombicuboctahedron]:={{-1/2, -1/2, -1/2 - 1/Sqrt[2]}, 
{-1/2,-1/2,1/2+1/Sqrt[2]},
{-1/2,1/2,-1/2-1/Sqrt[2]},
{-1/2,1/2,1/2+1/Sqrt[2]},{-1/2,-1/2-1/Sqrt[2],
-1/2},{-1/2,-1/2-1/Sqrt[2],1/2},
{-1/2,1/2+1/Sqrt[2],-1/2},{-1/2,1/2+1/Sqrt[2],
1/2},{1/2,-1/2,-1/2-1/Sqrt[2]},
{1/2,-1/2,1/2+1/Sqrt[2]},{1/2,1/2,-1/2-1/Sqrt[2]},
{1/2,1/2,1/2+1/Sqrt[2]},{1/2,-1/2-1/Sqrt[2],-1/2},
{1/2,-1/2-1/Sqrt[2],1/2},{1/2,1/2+1/Sqrt[2],-1/2},
{1/2,1/2+1/Sqrt[2],1/2},{-1/2-1/Sqrt[2],-1/2,
-1/2},{-1/2-1/Sqrt[2],-1/2,1/2},
{-1/2-1/Sqrt[2],1/2,-1/2},{-1/2-1/Sqrt[2],1/2,
1/2},{1/2+1/Sqrt[2],-1/2,-1/2},
{1/2+1/Sqrt[2],-1/2,1/2},{1/2+1/Sqrt[2],1/2,-1/2},
{1/2+1/Sqrt[2],1/2,1/2}}

(* Small Triakis Octahedron *)

PolyhedronName[SmallTriakisOctahedron]:="small triakis octahedron"
NetFaces[SmallTriakisOctahedron]:={{24,25,26},{24,26,22},{24,22,23},{21,20,18},{21,18,23},{21,23,22},{16,18,20},
{16,20,13},{16,13,14},{17,15,13},{17,13,20},{17,20,19},{10,12,14},{10,14,7},{10,7,8},{11,9,7},{11,7,14},
{11,14,13},{6,7,9},{6,9,4},{6,4,5},{3,2,1},{3,1,5},{3,5,4}}
NetVertices[SmallTriakisOctahedron]:={{-3.21637012435,-0.573638749873},{-2.75634063762,0.314264888667},
{-2.71536906624,-0.270086958122},{-2.67055466396,0.313982746499},{-2.21637553277,-0.57692764001},
{-2.17156113049,0.00714206461077},{-2.13058955911,-0.577209782179},{-1.67641042792,-1.46812016869},
{-1.67056007237,0.310693856362},{-1.63159602564,-0.884050464067},{-1.62958850099,-0.273657990428},
{-1.59062445426,-1.46840231086},{-1.58477409872,0.310411714193},{-1.13059496752,-0.580498672316},
{-1.12474461198,1.19831535273},{-1.08578056524,0.00357103230539},{-1.0837730406,0.613963505945},
{-1.04480899387,-0.580780814484},{-1.03895863832,1.19803321057},{-0.58477950713,0.307122824057},
{-0.54380793575,-0.277229022733},{-0.498993533471,0.306840681888},{-0.044814402279,-0.584069704621},
{0.,0.},{0.0409715713793,-0.58435184679},{0.501001058115,0.303551791751}}
PolyhedronDual[SmallTriakisOctahedron]:=TruncatedCube
PolyhedronFaces[SmallTriakisOctahedron]:=
{{6,8,4},{3,8,5},{7,6,2},{1,5,7},{12,8,6},{5,8,11},{10,6,7},{7,5,9},{14,6,
    10},{9,5,14},{14,12,6},{5,11,14},{11,8,14},{14,8,12},{7,9,14},{14,10,
    7},{6,13,2},{1,13,5},{6,4,13},{13,3,5},{3,13,8},{8,13,4},{13,1,7},{7,2,
    13}}
PolyhedronVertices[SmallTriakisOctahedron]:=
{{-1,-1,-1},{-1,-1,1},{-1,1,-1},{-1,1,1},
{0,0,-1-Sqrt[2]},{0,0,1+Sqrt[2]},
{0,-1-Sqrt[2],0},{0,1+Sqrt[2],0},{1,-1,-1},
{1,-1,1},{1,1,-1},{1,1,1},{-1-Sqrt[2],0,0},
{1+Sqrt[2],0,0}}

(* Snub Cube *)

PolyhedronName[SnubCube]:=PolyhedronName[SnubCube,"laevo"]
PolyhedronDual[SnubCube]:=PolyhedronDual[SnubCube,"laevo"]
PolyhedronFaces[SnubCube]:=PolyhedronFaces[SnubCube,"laevo"]
PolyhedronVertices[SnubCube]:=PolyhedronVertices[SnubCube,"laevo"]

NetFaces[SnubCube]:={{2,1,4},{1,3,4},{4,3,7,8},{6,4,8},{3,5,7},{8,7,11},{7,10,11},{9,8,12},{8,11,12},{12,11,16,17},{14,12,17},{11,13,16},{17,16,23},{16,22,23},{18,17,24},{17,23,24},{24,23,31,32},{28,24,32},{23,27,31},{32,31,38},{31,37,38},{33,32,39},{32,38,39},{39,38,43,44},{42,39,44},{38,41,43},{44,43,46},{43,45,46},{25,20,29},{15,19,20},{20,19,28,29},{29,28,34},{19,24,28},{31,27,36},{21,26,27},{27,26,35,36},{36,35,40},{26,30,35}}
NetVertices[SnubCube]:={{-1/(2Sqrt[3]),-1/2},{-1/(2Sqrt[3]),1/2},{1/Sqrt[3],-1},{1/Sqrt[3],0},{(3+2Sqrt[3])/6,(-2-Sqrt[3])/2},{(3+2Sqrt[3])/6,Sqrt[3]/2},{(3+Sqrt[3])/3,-1},{(3+Sqrt[3])/3,0},{(3+Sqrt[3])/3,1},{(6+5Sqrt[3])/6,-3/2},{(6+5Sqrt[3])/6,-1/2},{(6+5Sqrt[3])/6,1/2},{(9+5Sqrt[3])/6,(-1-Sqrt[3])/2},{(9+5Sqrt[3])/6,(1+Sqrt[3])/2},{(9+5Sqrt[3])/6,(3+Sqrt[3])/2},{(12+5Sqrt[3])/6,-1/2},{(12+5Sqrt[3])/6,1/2},{(12+5Sqrt[3])/6,3/2},{(9+8Sqrt[3])/6,(2+Sqrt[3])/2},{(9+8Sqrt[3])/6,(4+Sqrt[3])/2},{(5(3+Sqrt[3]))/6,(-1-Sqrt[3])/2},{(2(3+2Sqrt[3]))/3,-1},{(2(3+2Sqrt[3]))/3,0},{(2(3+2Sqrt[3]))/3,1},{(2(3+2Sqrt[3]))/3,2+Sqrt[3]},{(15+8Sqrt[3])/6,(-2-Sqrt[3])/2},{(15+8Sqrt[3])/6,-Sqrt[3]/2},{(15+8Sqrt[3])/6,(2+Sqrt[3])/2},{(15+8Sqrt[3])/6,(4+Sqrt[3])/2},{(9+4Sqrt[3])/3,-1-Sqrt[3]},{(9+4Sqrt[3])/3,0},{(9+4Sqrt[3])/3,1},{(9+4Sqrt[3])/3,2},{(15+11Sqrt[3])/6,(3+Sqrt[3])/2},{(21+8Sqrt[3])/6,(-2-Sqrt[3])/2},{(21+8Sqrt[3])/6,-Sqrt[3]/2},{(18+11Sqrt[3])/6,-1/2},{(18+11Sqrt[3])/6,1/2},{(18+11Sqrt[3])/6,3/2},{(21+11Sqrt[3])/6,(-1-Sqrt[3])/2},{(21+11Sqrt[3])/6,(1-Sqrt[3])/2},{(21+11Sqrt[3])/6,(3+Sqrt[3])/2},{(24+11Sqrt[3])/6,1/2},{(24+11Sqrt[3])/6,3/2},{(12+7Sqrt[3])/3,0},{(12+7Sqrt[3])/3,1}}

PolyhedronDual[SnubCube,"laevo"]:=Sequence[PentagonalIcositetrahedron,"dextro"]
PolyhedronName[SnubCube,"laevo"]:="snub cube (laevo)"
PolyhedronFaces[SnubCube,"laevo"]:=
{{3,1,17},{3,17,9},{3,19,2},{3,9,19},{1,4,20},{1,20,11},{1,11,17},{2,19,12},{2,18,4},
{2,12,18},{4,18,10},{4,10,20},{17,11,13},{19,9,15},{18,12,14},{20,10,16},{9,21,15},
{11,23,13},{12,24,14},{10,22,16},{13,23,7},{13,7,21},{15,21,5},{15,5,24},{16,22,6},
{16,6,23},{14,24,8},{14,8,22},{21,7,5},{23,6,7},{24,5,8},{22,8,6},{1,3,2,4},{21,9,17,13},
{24,12,19,15},{10,18,14,22},{11,20,16,23},{8,5,7,6}}
PolyhedronVertices[SnubCube,"laevo"]:=
{{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]}}

PolyehdronName[SnubCube,"dextro"]:="snub cube (dextro)"
PolyhedronDual[SnubCube,"dextro"]:=Sequence[PentagonalIcositetrahedron,"laevo"]
PolyhedronFaces[SnubCube,"dextro"]:=
{{3,2,19},{3,17,1},{3,19,9},{3,9,17},{1,17,11},{1,20,4},{1,11,20},{2,4,18},
{2,18,12},{2,12,19},{4,20,10},{4,10,18},{17,13,11},{19,15,9},{18,14,12},
{20,16,10},{9,15,21},{11,13,23},{12,14,24},{10,16,22},{13,21,7},{13,7,23},
{15,24,5},{15,5,21},{16,23,6},{16,6,22},{14,22,8},{14,8,24},{21,5,7},{23,
7,6},{24,8,5},{22,6,8},{2,3,1,4},{21,13,17,9},{15,19,12,24},{14,18,10,22},
{23,16,20,11},{8,6,7,5}}
PolyhedronVertices[SnubCube,"dextro"]:=
{{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,1,0],Root[-1-12#1^2-32#1^4+32#1^6&,2,0]},
{Root[-1+4#1^2-16#1^4+32#1^6&,2,0],Root[-1+12#1^2-32#1^4+32#1^6&,2,0],Root[-1-12#1^2-32#1^4+32#1^6&,1,0]}}

(* Snub Dodecahedron *)

PolyhedronName[SnubDodecahedron]:=PolyhedronName[SnubDodecahedron,"laevo"]
PolyhedronDual[SnubDodecahedron]:=PolyhedronDual[SnubDodecahedron,"laevo"]
PolyhedronFaces[SnubDodecahedron]:=PolyhedronFaces[SnubDodecahedron,"laevo"]
PolyhedronVertices[SnubDodecahedron]:=PolyhedronVertices[SnubDodecahedron,"laevo"]

NetFaces[SnubDodecahedron]:={{27,18,17,25,29},{11,10,17},{17,10,16},{17,16,25},{10,9,16},{10,6,9},{6,3,5},{6,5,9},{9,5,8},{36,35,46},{46,35,45},{46,45,58},{35,34,45},{35,25,34},{25,16,24},{25,24,34},{34,24,33},{16,12,13,19,24},{48,37,33,44,50},{24,23,33},{33,23,32},{33,32,44},{23,22,32},{23,15,22},{15,7,14},{15,14,22},{22,14,21},{57,56,68},{68,56,67},{68,67,80},{56,55,67},{56,44,55},{44,32,43},{44,43,55},{55,43,54},{32,26,28,38,43},{70,59,54,66,72},{43,42,54},{54,42,53},{54,53,66},{42,41,53},{42,31,41},{31,20,30},{31,30,41},{41,30,40},{79,78,89},{89,78,88},{89,88,99},{78,77,88},{78,66,77},{66,53,65},{66,65,77},{77,65,76},{53,47,49,60,65},{91,81,76,87,93},{65,64,76},{76,64,75},{76,75,87},{64,63,75},{64,52,63},{52,39,51},{52,51,63},{63,51,62},{98,97,105},{105,97,104},{105,104,112},{97,96,104},{97,87,96},{87,75,86},{87,86,96},{96,86,95},{75,69,71,82,86},{106,100,95,103,107},{86,85,95},{95,85,94},{95,94,103},{85,84,94},{85,74,84},{74,61,73},{74,73,84},{84,73,83},{111,110,114},{114,110,113},{114,113,116},{110,109,113},{110,103,109},{103,94,102},{103,102,109},{109,102,108},{94,90,92,101,102},{3,1,2,4,5},{117,115,114,116,118}}
NetVertices[SnubDodecahedron]:={{(-50Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-26+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(-88Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-56-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{-7/(2Sqrt[3]),-3/2},{(-76Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-60-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{-2/Sqrt[3],-2},{-2/Sqrt[3],-1},{-1/(2Sqrt[3]),-7/2},{-1/(2Sqrt[3]),-5/2},{-1/(2Sqrt[3]),-3/2},{-1/(2Sqrt[3]),-1/2},{-1/(2Sqrt[3]),1/2},{(22Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-18+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(56Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-40-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{1/Sqrt[3],-4},{1/Sqrt[3],-3},{1/Sqrt[3],-1},{1/Sqrt[3],0},{(11Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-1+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(68Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-44-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{5/(2Sqrt[3]),-11/2},{5/(2Sqrt[3]),-9/2},{5/(2Sqrt[3]),-7/2},{5/(2Sqrt[3]),-5/2},{5/(2Sqrt[3]),-3/2},{5/(2Sqrt[3]),-1/2},{(70Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-50+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(28Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-4+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(152Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-104-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(17Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-3-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{4/Sqrt[3],-6},{4/Sqrt[3],-5},{4/Sqrt[3],-3},{4/Sqrt[3],-2},{4/Sqrt[3],-1},{4/Sqrt[3],0},{4/Sqrt[3],1},{(35Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-17+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(164Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-108-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{11/(2Sqrt[3]),-15/2},{11/(2Sqrt[3]),-13/2},{11/(2Sqrt[3]),-11/2},{11/(2Sqrt[3]),-9/2},{11/(2Sqrt[3]),-7/2},{11/(2Sqrt[3]),-5/2},{11/(2Sqrt[3]),-1/2},{11/(2Sqrt[3]),1/2},{(118Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-82+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(76Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-36+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(248Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-168-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(41Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-19-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{7/Sqrt[3],-8},{7/Sqrt[3],-7},{7/Sqrt[3],-5},{7/Sqrt[3],-4},{7/Sqrt[3],-3},{7/Sqrt[3],-2},{7/Sqrt[3],-1},{7/Sqrt[3],0},{(59Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-33+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(260Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-172-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{17/(2Sqrt[3]),-19/2},{17/(2Sqrt[3]),-17/2},{17/(2Sqrt[3]),-15/2},{17/(2Sqrt[3]),-13/2},{17/(2Sqrt[3]),-11/2},{17/(2Sqrt[3]),-9/2},{17/(2Sqrt[3]),-5/2},{17/(2Sqrt[3]),-3/2},{(166Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-114+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(124Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-68+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(344Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-232-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(65Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-35-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{10/Sqrt[3],-10},{10/Sqrt[3],-9},{10/Sqrt[3],-7},{10/Sqrt[3],-6},{10/Sqrt[3],-5},{10/Sqrt[3],-4},{10/Sqrt[3],-3},{10/Sqrt[3],-2},{(83Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-49+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(356Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-236-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{23/(2Sqrt[3]),-21/2},{23/(2Sqrt[3]),-19/2},{23/(2Sqrt[3]),-17/2},{23/(2Sqrt[3]),-15/2},{23/(2Sqrt[3]),-13/2},{23/(2Sqrt[3]),-9/2},{23/(2Sqrt[3]),-7/2},{(214Sqrt[3]-6Sqrt[15]-3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])])/48,(-146+2Sqrt[5]-Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])])/16},{(172Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-100+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(440Sqrt[3]-9Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-296-3Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{(89Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-51-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{13/Sqrt[3],-9},{13/Sqrt[3],-8},{13/Sqrt[3],-7},{13/Sqrt[3],-6},{13/Sqrt[3],-5},{13/Sqrt[3],-4},{(107Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-65+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(452Sqrt[3]+12Sqrt[15]+3Sqrt[2(5-Sqrt[5])]-3Sqrt[10(5-Sqrt[5])]-3Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/96,(-300-4Sqrt[5]+Sqrt[6(5-Sqrt[5])]-Sqrt[30(5-Sqrt[5])]-Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/32},{29/(2Sqrt[3]),-19/2},{29/(2Sqrt[3]),-17/2},{29/(2Sqrt[3]),-13/2},{29/(2Sqrt[3]),-11/2},{(220Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-132+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(113Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-67-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{16/Sqrt[3],-10},{16/Sqrt[3],-9},{16/Sqrt[3],-8},{16/Sqrt[3],-7},{16/Sqrt[3],-6},{35/(2Sqrt[3]),-17/2},{35/(2Sqrt[3]),-15/2},{(143Sqrt[3]-3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-61+Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{19/Sqrt[3],-8},{(292Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-124+Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(149Sqrt[3]+3Sqrt[15]+3Sqrt[2(5+Sqrt[5])])/24,(-63-Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8}}

PolyhedronName[SnubDodecahedron,"laevo"]:="snub dodecahedron (laevo)"
PolyhedronDual[SnubDodecahedron,"laevo"]:=Sequence[PentagonalHexecontahedron,"dextro"]
PolyhedronFaces[SnubDodecahedron,"laevo"]:=
{{5,1,9},{5,9,3},{5,29,15},{5,3,29},{1,27,19},{1,19,25},{1,25,9},{15,29,7},
{15,45,39},{15,7,45},{27,39,41},{27,41,37},{27,37,19},{9,25,17},{39,45,21},
{39,21,41},{29,3,13},{3,43,13},{19,37,35},{25,31,17},{45,7,11},{7,49,11},
{41,21,23},{37,33,35},{17,31,59},{17,59,55},{13,43,53},{13,53,51},{21,47,23},
{43,55,48},{43,48,53},{35,33,58},{35,58,57},{31,57,34},{31,34,59},{11,49,52},
{11,52,54},{55,59,24},{55,24,48},{49,51,50},{49,50,52},{23,47,56},{23,56,60},
{51,53,12},{51,12,50},{33,60,32},{33,32,58},{57,58,36},{57,36,34},{47,54,44},
{47,44,56},{48,24,22},{54,52,14},{54,14,44},{60,56,18},{60,18,32},{34,36,38},
{24,42,22},{50,12,8},{12,46,8},{32,18,26},{36,20,38},{44,14,4},{22,42,40},
{22,40,46},{14,30,4},{18,10,26},{38,20,28},{38,28,42},{42,28,40},{8,46,16},
{8,16,30},{46,40,16},{26,10,2},{26,2,20},{20,2,28},{4,30,6},{4,6,10},
{30,16,6},{10,6,2},{39,27,1,5,15},{3,9,17,55,43},{51,49,7,29,13},
{57,31,25,19,35},{47,21,45,11,54},{33,37,41,23,60},{42,24,59,34,38},
{46,12,53,48,22},{36,58,32,26,20},{14,52,50,8,30},{44,4,10,18,56},
{16,40,28,2,6}}
PolyhedronVertices[SnubDodecahedron,"laevo"]:=
{{Root[3721-65628#1^2+31104#1^4+1050624#1^6+2426112#1^8-13188096#1^10+2985984#1^12&,1,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[3721-65628#1^2+31104#1^4+1050624#1^6+2426112#1^8-13188096#1^10+2985984#1^12&,8,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[5041-289884#1^2+2745792#1^4-10091520#1^6+17190144#1^8-13188096#1^10+2985984#1^12&,1,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[5041-289884#1^2+2745792#1^4-10091520#1^6+17190144#1^8-13188096#1^10+2985984#1^12&,8,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[1-1272#1^2+158544#1^4+763776#1^6-787968#1^8-12939264#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,6,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[1-1272#1^2+158544#1^4+763776#1^6-787968#1^8-12939264#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,6,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[17161-386076#1^2+3170448#1^4-11460096#1^6+17750016#1^8-12192768#1^10+2985984#1^12&,1,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[17161-386076#1^2+3170448#1^4-11460096#1^6+17750016#1^8-12192768#1^10+2985984#1^12&,8,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[3481-83304#1^2+701136#1^4-2782080#1^6+7423488#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,3,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[3481-83304#1^2+701136#1^4-2782080#1^6+7423488#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,3,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[6241-211068#1^2+2283984#1^4-9542016#1^6+16941312#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[6241-211068#1^2+2283984#1^4-9542016#1^6+16941312#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[361-83964#1^2+2241792#1^4-11102400#1^6+17812224#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,8,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[361-83964#1^2+2241792#1^4-11102400#1^6+17812224#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,8,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[361-56064#1^2+1461024#1^4+1707264#1^6-373248#1^8-11197440#1^10+2985984#1^12&,1,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[361-56064#1^2+1461024#1^4+1707264#1^6-373248#1^8-11197440#1^10+2985984#1^12&,8,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[14641-604032#1^2+5589216#1^4-15704064#1^6+18537984#1^8-11197440#1^10+2985984#1^12&,1,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,1,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[14641-604032#1^2+5589216#1^4-15704064#1^6+18537984#1^8-11197440#1^10+2985984#1^12&,8,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,1,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[961-109116#1^2+1807488#1^4-6492096#1^6+11010816#1^8-10948608#1^10+2985984#1^12&,1,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[961-109116#1^2+1807488#1^4-6492096#1^6+11010816#1^8-10948608#1^10+2985984#1^12&,8,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[5041-240000#1^2+3312288#1^4-11062656#1^6+15365376#1^8-10450944#1^10+2985984#1^12&,1,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[5041-240000#1^2+3312288#1^4-11062656#1^6+15365376#1^8-10450944#1^10+2985984#1^12&,8,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[361-38172#1^2+1001376#1^4-4472064#1^6+8169984#1^8-9953280#1^10+2985984#1^12&,1,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[361-38172#1^2+1001376#1^4-4472064#1^6+8169984#1^8-9953280#1^10+2985984#1^12&,8,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[5041-180336#1^2+912816#1^4+1028160#1^6-4396032#1^8-9206784#1^10+2985984#1^12&,1,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[5041-180336#1^2+912816#1^4+1028160#1^6-4396032#1^8-9206784#1^10+2985984#1^12&,8,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[6241-97356#1^2+351648#1^4+110592#1^6+870912#1^8-8957952#1^10+2985984#1^12&,1,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[6241-97356#1^2+351648#1^4+110592#1^6+870912#1^8-8957952#1^10+2985984#1^12&,8,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[7921-275484#1^2+2564496#1^4-8951040#1^6+13022208#1^8-8211456#1^10+2985984#1^12&,1,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[7921-275484#1^2+2564496#1^4-8951040#1^6+13022208#1^8-8211456#1^10+2985984#1^12&,8,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[1-1452#1^2+348624#1^4-5457024#1^6+11964672#1^8-7962624#1^10+2985984#1^12&,2,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[1-1452#1^2+348624#1^4-5457024#1^6+11964672#1^8-7962624#1^10+2985984#1^12&,7,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[841-73056#1^2+1265328#1^4-6887808#1^6+11964672#1^8-7713792#1^10+2985984#1^12&,1,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[841-73056#1^2+1265328#1^4-6887808#1^6+11964672#1^8-7713792#1^10+2985984#1^12&,8,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[1-3384#1^2+1219104#1^4-5679936#1^6+7921152#1^8-7464960#1^10+2985984#1^12&,1,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,1,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[1-3384#1^2+1219104#1^4-5679936#1^6+7921152#1^8-7464960#1^10+2985984#1^12&,8,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,1,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[1-20280#1^2+1035648#1^4-781056#1^6-8999424#1^8-6718464#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[1-20280#1^2+1035648#1^4-781056#1^6-8999424#1^8-6718464#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[10201-246120#1^2+1816128#1^4-4962816#1^6+5101056#1^8-6718464#1^10+2985984#1^12&,1,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[10201-246120#1^2+1816128#1^4-4962816#1^6+5101056#1^8-6718464#1^10+2985984#1^12&,8,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[11881-341376#1^2+3016368#1^4-8434368#1^6+8957952#1^8-5225472#1^10+2985984#1^12&,1,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[11881-341376#1^2+3016368#1^4-8434368#1^6+8957952#1^8-5225472#1^10+2985984#1^12&,8,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[361-29856#1^2+588816#1^4-1926720#1^6-1907712#1^8-4230144#1^10+2985984#1^12&,1,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[361-29856#1^2+588816#1^4-1926720#1^6-1907712#1^8-4230144#1^10+2985984#1^12&,8,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[1-18792#1^2+524016#1^4-3443904#1^6+6718464#1^8-1244160#1^10+2985984#1^12&,2,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[1-18792#1^2+524016#1^4-3443904#1^6+6718464#1^8-1244160#1^10+2985984#1^12&,7,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[1-7104#1^2+351216#1^4-3300480#1^6+2757888#1^8+4230144#1^10+2985984#1^12&,2,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[1-7104#1^2+351216#1^4-3300480#1^6+2757888#1^8+4230144#1^10+2985984#1^12&,7,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[361-23352#1^2+432864#1^4-2666304#1^6+2115072#1^8+4478976#1^10+2985984#1^12&,4,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,8,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[361-23352#1^2+432864#1^4-2666304#1^6+2115072#1^8+4478976#1^10+2985984#1^12&,5,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,8,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[961-36984#1^2+466992#1^4-2185920#1^6+1741824#1^8+6718464#1^10+2985984#1^12&,4,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[961-36984#1^2+466992#1^4-2185920#1^6+1741824#1^8+6718464#1^10+2985984#1^12&,5,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[1-528#1^2+69264#1^4-1498176#1^6+2737152#1^8+6718464#1^10+2985984#1^12&,2,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,1,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[1-528#1^2+69264#1^4-1498176#1^6+2737152#1^8+6718464#1^10+2985984#1^12&,7,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,1,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]}}

PolyhedronName[SnubDodecahedron,"dextro"]:="snub dodecahedron (dextro)"
PolyhedronDual[SnubDodecahedron,"dextro"]:=Sequence[PentagonalHexecontahedron,"laevo"]
PolyhedronFaces[SnubDodecahedron,"dextro"]:=
{{5,15,29},{5,9,1},{5,29,3},{5,3,9},{1,9,25},{1,19,27},{1,25,19},{15,39,45},
{15,45,7},{15,7,29},{27,19,37},{27,41,39},{27,37,41},{9,17,25},{39,41,21},
{39,21,45},{29,13,3},{3,13,43},{19,35,37},{25,17,31},{45,11,7},{7,11,49},
{41,23,21},{37,35,33},{17,55,59},{17,59,31},{13,51,53},{13,53,43},{21,23,47},
{43,53,48},{43,48,55},{35,57,58},{35,58,33},{31,59,34},{31,34,57},{11,54,52},
{11,52,49},{55,48,24},{55,24,59},{49,52,50},{49,50,51},{23,60,56},{23,56,47},
{51,50,12},{51,12,53},{33,58,32},{33,32,60},{57,34,36},{57,36,58},{47,56,44},
{47,44,54},{48,22,24},{54,44,14},{54,14,52},{60,32,18},{60,18,56},{34,38,36},
{24,22,42},{50,8,12},{12,8,46},{32,26,18},{36,38,20},{44,4,14},{22,46,40},
{22,40,42},{14,4,30},{18,26,10},{38,42,28},{38,28,20},{42,40,28},{8,30,16},
{8,16,46},{46,16,40},{26,20,2},{26,2,10},{20,28,2},{4,10,6},{4,6,30},{30,6,16},
{10,2,6},{39,15,5,1,27},{9,3,43,55,17},{51,13,29,7,49},{57,35,19,25,31},
{11,45,21,47,54},{23,41,37,33,60},{42,38,34,59,24},{46,22,48,53,12},
{26,32,58,36,20},{8,50,52,14,30},{18,10,4,44,56},{28,40,16,6,2}}
PolyhedronVertices[SnubDodecahedron,"dextro"]:=
{{Root[3721-65628#1^2+31104#1^4+1050624#1^6+2426112#1^8-13188096#1^10+2985984#1^12&,1,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[3721-65628#1^2+31104#1^4+1050624#1^6+2426112#1^8-13188096#1^10+2985984#1^12&,8,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[5041-289884#1^2+2745792#1^4-10091520#1^6+17190144#1^8-13188096#1^10+2985984#1^12&,1,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[5041-289884#1^2+2745792#1^4-10091520#1^6+17190144#1^8-13188096#1^10+2985984#1^12&,8,0],
Root[1-68#1^2+1216#1^4-5888#1^6+9472#1^8-5120#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[1-1272#1^2+158544#1^4+763776#1^6-787968#1^8-12939264#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,3,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[1-1272#1^2+158544#1^4+763776#1^6-787968#1^8-12939264#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,3,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[17161-386076#1^2+3170448#1^4-11460096#1^6+17750016#1^8-12192768#1^10+2985984#1^12&,1,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[17161-386076#1^2+3170448#1^4-11460096#1^6+17750016#1^8-12192768#1^10+2985984#1^12&,8,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,1,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[3481-83304#1^2+701136#1^4-2782080#1^6+7423488#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,6,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[3481-83304#1^2+701136#1^4-2782080#1^6+7423488#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+912#1^4-6016#1^6+15872#1^8-12288#1^10+4096#1^12&,6,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[6241-211068#1^2+2283984#1^4-9542016#1^6+16941312#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[6241-211068#1^2+2283984#1^4-9542016#1^6+16941312#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,1,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[361-83964#1^2+2241792#1^4-11102400#1^6+17812224#1^8-11943936#1^10+2985984#1^12&,1,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,1,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[361-83964#1^2+2241792#1^4-11102400#1^6+17812224#1^8-11943936#1^10+2985984#1^12&,8,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,1,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[361-56064#1^2+1461024#1^4+1707264#1^6-373248#1^8-11197440#1^10+2985984#1^12&,1,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[361-56064#1^2+1461024#1^4+1707264#1^6-373248#1^8-11197440#1^10+2985984#1^12&,8,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[14641-604032#1^2+5589216#1^4-15704064#1^6+18537984#1^8-11197440#1^10+2985984#1^12&,1,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,8,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[14641-604032#1^2+5589216#1^4-15704064#1^6+18537984#1^8-11197440#1^10+2985984#1^12&,8,0],
Root[1-160#1^2+1312#1^4-2048#1^6-3584#1^8+3072#1^10+4096#1^12&,8,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[961-109116#1^2+1807488#1^4-6492096#1^6+11010816#1^8-10948608#1^10+2985984#1^12&,1,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[961-109116#1^2+1807488#1^4-6492096#1^6+11010816#1^8-10948608#1^10+2985984#1^12&,8,0],
Root[1-116#1^2+3456#1^4-7488#1^6+1792#1^8-8192#1^10+4096#1^12&,8,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[5041-240000#1^2+3312288#1^4-11062656#1^6+15365376#1^8-10450944#1^10+2985984#1^12&,1,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[5041-240000#1^2+3312288#1^4-11062656#1^6+15365376#1^8-10450944#1^10+2985984#1^12&,8,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,2,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,3,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[11881-272016#1^2+2297376#1^4-8899200#1^6+15614208#1^8-10450944#1^10+2985984#1^12&,6,0],
Root[1-48#1^2+672#1^4-3456#1^6+4352#1^8+6144#1^10+4096#1^12&,7,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[361-38172#1^2+1001376#1^4-4472064#1^6+8169984#1^8-9953280#1^10+2985984#1^12&,1,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[361-38172#1^2+1001376#1^4-4472064#1^6+8169984#1^8-9953280#1^10+2985984#1^12&,8,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[5041-180336#1^2+912816#1^4+1028160#1^6-4396032#1^8-9206784#1^10+2985984#1^12&,1,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[5041-180336#1^2+912816#1^4+1028160#1^6-4396032#1^8-9206784#1^10+2985984#1^12&,8,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,8,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[6241-97356#1^2+351648#1^4+110592#1^6+870912#1^8-8957952#1^10+2985984#1^12&,1,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[6241-97356#1^2+351648#1^4+110592#1^6+870912#1^8-8957952#1^10+2985984#1^12&,8,0],
Root[1-132#1^2+4256#1^4-3072#1^6-9728#1^8+4096#1^12&,1,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[7921-275484#1^2+2564496#1^4-8951040#1^6+13022208#1^8-8211456#1^10+2985984#1^12&,1,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[7921-275484#1^2+2564496#1^4-8951040#1^6+13022208#1^8-8211456#1^10+2985984#1^12&,8,0],
Root[1-100#1^2+1872#1^4-9472#1^6+9216#1^8-13312#1^10+4096#1^12&,8,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[1-1452#1^2+348624#1^4-5457024#1^6+11964672#1^8-7962624#1^10+2985984#1^12&,2,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[1-1452#1^2+348624#1^4-5457024#1^6+11964672#1^8-7962624#1^10+2985984#1^12&,7,0],
Root[1-36#1^2+272#1^4+384#1^6-768#1^8-12288#1^10+4096#1^12&,8,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[841-73056#1^2+1265328#1^4-6887808#1^6+11964672#1^8-7713792#1^10+2985984#1^12&,1,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,3,0]},
{Root[841-73056#1^2+1265328#1^4-6887808#1^6+11964672#1^8-7713792#1^10+2985984#1^12&,8,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,8,0],
Root[961-95784#1^2+1076976#1^4-3568320#1^6+1824768#1^8+1741824#1^10+2985984#1^12&,6,0]},
{Root[1-3384#1^2+1219104#1^4-5679936#1^6+7921152#1^8-7464960#1^10+2985984#1^12&,1,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,8,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,1,0]},
{Root[1-3384#1^2+1219104#1^4-5679936#1^6+7921152#1^8-7464960#1^10+2985984#1^12&,8,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,8,0],
Root[22801-432792#1^2+2409264#1^4-3340224#1^6-3898368#1^8+746496#1^10+2985984#1^12&,8,0]},
{Root[1-20280#1^2+1035648#1^4-781056#1^6-8999424#1^8-6718464#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,1,0]},
{Root[1-20280#1^2+1035648#1^4-781056#1^6-8999424#1^8-6718464#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,4,0],
Root[361-71736#1^2+1573488#1^4-167616#1^6-3400704#1^8-2239488#1^10+2985984#1^12&,8,0]},
{Root[10201-246120#1^2+1816128#1^4-4962816#1^6+5101056#1^8-6718464#1^10+2985984#1^12&,1,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[10201-246120#1^2+1816128#1^4-4962816#1^6+5101056#1^8-6718464#1^10+2985984#1^12&,8,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,7,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[11881-341376#1^2+3016368#1^4-8434368#1^6+8957952#1^8-5225472#1^10+2985984#1^12&,1,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[11881-341376#1^2+3016368#1^4-8434368#1^6+8957952#1^8-5225472#1^10+2985984#1^12&,8,0],
Root[1-128#1^2+1392#1^4-4672#1^6+4096#1^8-1024#1^10+4096#1^12&,1,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[361-29856#1^2+588816#1^4-1926720#1^6-1907712#1^8-4230144#1^10+2985984#1^12&,1,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,1,0]},
{Root[361-29856#1^2+588816#1^4-1926720#1^6-1907712#1^8-4230144#1^10+2985984#1^12&,8,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,1,0],
Root[361-292488#1^2+2858544#1^4-6492096#1^6+1078272#1^8-3234816#1^10+2985984#1^12&,8,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,3,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[1-504#1^2+65664#1^4-2647296#1^6+8335872#1^8-3732480#1^10+2985984#1^12&,6,0],
Root[1-328#1^2+2944#1^4-8960#1^6+9728#1^8-3072#1^10+4096#1^12&,2,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[1-18792#1^2+524016#1^4-3443904#1^6+6718464#1^8-1244160#1^10+2985984#1^12&,2,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,3,0]},
{Root[1-18792#1^2+524016#1^4-3443904#1^6+6718464#1^8-1244160#1^10+2985984#1^12&,7,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,1,0],
Root[1-10584#1^2+441072#1^4-3430080#1^6+7962624#1^8-3234816#1^10+2985984#1^12&,6,0]},
{Root[1-7104#1^2+351216#1^4-3300480#1^6+2757888#1^8+4230144#1^10+2985984#1^12&,2,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,8,0]},
{Root[1-7104#1^2+351216#1^4-3300480#1^6+2757888#1^8+4230144#1^10+2985984#1^12&,7,0],
Root[1-48#1^2+752#1^4-4736#1^6+14592#1^8-19456#1^10+4096#1^12&,1,0],
Root[1-176136#1^2+2371248#1^4-9332928#1^6+14764032#1^8-10202112#1^10+2985984#1^12&,1,0]},
{Root[361-23352#1^2+432864#1^4-2666304#1^6+2115072#1^8+4478976#1^10+2985984#1^12&,4,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,1,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[361-23352#1^2+432864#1^4-2666304#1^6+2115072#1^8+4478976#1^10+2985984#1^12&,5,0],
Root[1-488#1^2+5728#1^4-20160#1^6+29184#1^8-18432#1^10+4096#1^12&,1,0],
Root[1681-113304#1^2+1571184#1^4-7390656#1^6+11446272#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,1,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[5041-143496#1^2+1133568#1^4-2958336#1^6+124416#1^8+5225472#1^10+2985984#1^12&,8,0],
Root[1-56#1^2+1024#1^4-7168#1^6+18944#1^8-15360#1^10+4096#1^12&,5,0],
Root[1-360#1^2+12528#1^4-478656#1^6+5723136#1^8-14183424#1^10+2985984#1^12&,1,0]},
{Root[961-36984#1^2+466992#1^4-2185920#1^6+1741824#1^8+6718464#1^10+2985984#1^12&,4,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,8,0]},
{Root[961-36984#1^2+466992#1^4-2185920#1^6+1741824#1^8+6718464#1^10+2985984#1^12&,5,0],
Root[1-40#1^2+624#1^4-4672#1^6+16384#1^8-21504#1^10+4096#1^12&,8,0],
Root[841-44232#1^2+705456#1^4-4688064#1^6+12939264#1^8-11197440#1^10+2985984#1^12&,1,0]},
{Root[1-528#1^2+69264#1^4-1498176#1^6+2737152#1^8+6718464#1^10+2985984#1^12&,2,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,8,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,8,0]},
{Root[1-528#1^2+69264#1^4-1498176#1^6+2737152#1^8+6718464#1^10+2985984#1^12&,7,0],
Root[1-416#1^2+6672#1^4-21696#1^6+28672#1^8-17408#1^10+4096#1^12&,8,0],
Root[961-90696#1^2+1566576#1^4-7750080#1^6+15925248#1^8-14183424#1^10+2985984#1^12&,1,0]}}

(* Tetrakis Hexahedron *)

PolyhedronName[TetrakisHexahedron]:="tetrakis hexahedron"
NetFaces[TetrakisHexahedron]:={{11,15,16},{11,16,7},{11,7,6},{11,6,14},{13,18,17},{13,17,8},{13,8,7},{13,7,16},
{4,6,7},{4,7,2},{4,2,1},{4,1,5},{9,12,14},{9,14,6},{9,6,3},{9,3,10},{19,22,21},{19,21,16},{19,16,15},
{19,15,20},{23,26,24},{23,24,21},{23,21,22},{23,22,25}}
NetVertices[TetrakisHexahedron]:={{-1.81018796079,0.0420586415981},{-1.3766342059,0.943186347101},
{-1.09030548402,-1.26331159012},{-1.08966538187,0.250258577394},{-0.962812686481,-0.488935844712},
{-0.656751729135,-0.36218388462},{-0.432913652733,0.612442462014},{-0.429844986981,1.61243775365},
{-0.369782905099,-1.05511165433},{-0.242930209712,-1.79430607643},{0.,0.},
{0.0631307476338,-1.66755411634},{0.127635042462,1.11072467153},{0.286968824036,-0.692927769707},
{0.557480029443,-0.501713082122},{0.560548695194,0.49828220951200003},{0.564299286669,1.72049867706},
{0.782151570617,0.744516923968},{1.11802872464,-0.00343087261061},{1.55094237737,-0.615873334625},
{1.55469296884,0.606343132928},{1.77254525279,-0.369638620169},{2.209209497,0.24013538537},
{2.50042562384,0.931288890367},{2.76668952644,-0.261577696752},{2.92844072001,0.027517305589}}
PolyhedronDual[TetrakisHexahedron]:=TruncatedOctahedron
PolyhedronFaces[TetrakisHexahedron]:=
{{3,2,1},{1,2,4},{3,1,5},{6,2,3},{1,4,9},{10,4,2},{5,6,3},{1,7,5},{6,8,2},{1,
    9,7},{8,10,2},{4,10,9},{11,6,5},{5,7,13},{14,8,6},{7,9,13},{14,10,8},{9,
    10,12},{11,5,13},{14,6,11},{9,12,13},{14,12,10},{13,14,11},{12,14,13}}
PolyhedronVertices[TetrakisHexahedron]:=
{{-3/2,0,-3/(2Sqrt[2])},{-3/2,0,3/(2Sqrt[2])},
{-9/8,-9/8,0},{-9/8,9/8,0},{0,-3/2,-3/(2Sqrt[2])},
{0,-3/2,3/(2Sqrt[2])},{0,0,-9/(4Sqrt[2])},
{0,0,9/(4Sqrt[2])},{0,3/2,-3/(2Sqrt[2])},
{0,3/2,3/(2Sqrt[2])},{9/8,-9/8,0},{9/8,9/8,0},
{3/2,0,-3/(2Sqrt[2])},{3/2,0,3/(2Sqrt[2])}}

(* Triakis Icosahedron *)

PolyhedronName[TriakisIcosahedron]:="triakis icosahedron"
NetFaces[TriakisIcosahedron]:={{5,7,9},{5,9,1},{5,1,3},{17,19,21},{17,21,13},{17,13,15},{29,31,33},{29,33,25},
{29,25,27},{41,43,45},{41,45,37},{41,37,39},{53,55,57},{53,57,49},{53,49,51},{10,8,6},{10,6,14},{10,14,12},
{22,20,18},{22,18,26},{22,26,24},{34,32,30},{34,30,38},{34,38,36},{46,44,42},{46,42,50},{46,50,48},{58,56,54},
{58,54,62},{58,62,60},{4,2,1},{4,1,9},{4,9,6},{11,13,14},{11,14,6},{11,6,9},{16,14,13},{16,13,21},{16,21,18},
{23,25,26},{23,26,18},{23,18,21},{28,26,25},{28,25,33},{28,33,30},{35,37,38},{35,38,30},{35,30,33},{40,38,37},
{40,37,45},{40,45,42},{47,49,50},{47,50,42},{47,42,45},{52,50,49},{52,49,57},{52,57,54},{59,61,62},{59,62,54},
{59,54,57}}
NetVertices[TriakisIcosahedron]:={{-1.01320351487,-1.16977998261},{-0.528830295465,-0.294918516823},
{-0.526757023452,-2.04349035281},{-0.513552805645,-0.874896063864},{-0.512854927033,-1.46347820769},
{-0.499650709226,-0.294883918748},{-0.497577437213,-2.04345575473},{-0.0152774898199,0.579977547041},
{-0.0132042178064,-1.16859428894},{0.,0.},{0.000697878612331,-0.588582143827},
{0.0139020964188,0.580012145116},{0.0159753684323,-1.16855969087},{0.500348587839,-0.293698225079},
{0.502421859852,-2.04227006106},{0.515626077659,-0.873675772119},{0.516323956271,-1.46225791595},
{0.529528174077,-0.293663627004},{0.531601446091,-2.04223546299},{1.01390139348,0.581197838785},
{1.0159746655,-1.1673739972},{1.0291788833,0.00122029174424},{1.02987676192,-0.587361852082},
{1.04308097972,0.58123243686},{1.04515425174,-1.16733939912},{1.52952747114,-0.292477933334},
{1.53160074316,-2.04104976932},{1.54480496096,-0.872455480375},{1.54550283957,-1.4610376242},
{1.55870705738,-0.292443335259},{1.56078032939,-2.04101517124},{2.04308027679,0.582418130529},
{2.0451535488,-1.16615370545},{2.05835776661,0.00244058348848},{2.05905564522,-0.586141560338},
{2.07225986303,0.582452728604},{2.07433313504,-1.16611910738},{2.55870635445,-0.29125764159},
{2.56077962646,-2.03982947757},{2.57398384427,-0.871235188631},{2.57468172288,-1.45981733246},
{2.58788594068,-0.291223043515},{2.5899592127,-2.0397948795},{3.07225916009,0.583638422273},
{3.0743324321,-1.16493341371},{3.08753664991,0.00366087523273},{3.08823452852,-0.584921268594},
{3.10143874633,0.583673020348},{3.10351201834,-1.16489881563},{3.58788523775,-0.290037349846},
{3.58995850976,-2.03860918583},{3.60316272757,-0.870014896887},{3.60386060618,-1.45859704071},
{3.61706482399,-0.290002751771},{3.619138096,-2.03857458775},{4.10143804339,0.584858714018},
{4.10351131541,-1.16371312197},{4.11671553321,0.00488116697697},{4.11741341183,-0.58370097685},
{4.13061762963,0.584893312093},{4.13269090165,-1.16367852389},{4.61706412105,-0.288817058102}}
PolyhedronDual[TriakisIcosahedron]:=TruncatedDodecahedron
PolyhedronFaces[TriakisIcosahedron]:=
{{1,26,2},{5,31,6},{3,27,1},{7,32,5},{19,26,31},{32,27,20},{26,23,2},{3,24,
    27},{30,29,13},{29,26,21},{22,27,30},{16,26,29},{30,27,17},{31,29,6},{7,
    30,32},{31,23,19},{20,24,32},{18,24,23},{8,28,31},{9,32,28},{14,23,
    31},{32,24,15},{23,24,4},{31,28,14},{28,32,15},{21,25,29},{30,25,22},{28,
    23,14},{15,24,28},{18,23,28},{28,24,18},{29,25,13},{13,25,30},{2,23,1},{8,
    31,5},{1,24,3},{5,32,9},{19,23,26},{27,24,20},{11,26,1},{6,29,5},{1,27,
    12},{5,30,7},{1,25,11},{5,29,10},{12,25,1},{10,30,5},{1,23,4},{5,28,8},{4,
    24,1},{9,28,5},{10,29,30},{21,26,25},{22,25,27},{16,29,31},{32,30,17},{25,
    26,11},{27,25,12},{31,26,16},{17,27,32}}
PolyhedronVertices[TriakisIcosahedron]:=
{{0,0,Sqrt[25/4+(5Sqrt[5])/2]},{Sqrt[5(25+2Sqrt[5])]/22,(-5(3+2Sqrt[5]))/22,
Sqrt[1325+590Sqrt[5]]/22},{Sqrt[5(25+2Sqrt[5])]/22,(5(3+2Sqrt[5]))/22,Sqrt[1325+590Sqrt[5]]/22},
{Sqrt[(5(85+31Sqrt[5]))/2]/11,0,Sqrt[1325+590Sqrt[5]]/22},{0,0,-Sqrt[5(5+2Sqrt[5])]/2},
{-Sqrt[5(25+2Sqrt[5])]/22,(-5(3+2Sqrt[5]))/22,-Sqrt[1325+590Sqrt[5]]/22},
{-Sqrt[5(25+2Sqrt[5])]/22,(5(3+2Sqrt[5]))/22,-Sqrt[1325+590Sqrt[5]]/22},
{Sqrt[(5(205+89Sqrt[5]))/2]/22,(-5(7+Sqrt[5]))/44,-Sqrt[1325+590Sqrt[5]]/22},
{Sqrt[(5(205+89Sqrt[5]))/2]/22,(5(7+Sqrt[5]))/44,-Sqrt[1325+590Sqrt[5]]/22},
{Root[125-425#1^2+121#1^4&,1,0],0,-Sqrt[1325+590Sqrt[5]]/22},
{-Sqrt[(5(205+89Sqrt[5]))/2]/22,(-5(7+Sqrt[5]))/44,Sqrt[1325+590Sqrt[5]]/22},
{-Sqrt[(5(205+89Sqrt[5]))/2]/22,(5(7+Sqrt[5]))/44,Sqrt[1325+590Sqrt[5]]/22},
{Root[125-1025#1^2+121#1^4&,1,0],0,-Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[1325+590Sqrt[5]]/22,(-5(3+2Sqrt[5]))/22,-Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[1325+590Sqrt[5]]/22,(5(3+2Sqrt[5]))/22,-Sqrt[5(25+2Sqrt[5])]/22},
{-Sqrt[(5(85+31Sqrt[5]))/2]/22,(-5(13+5Sqrt[5]))/44,-Sqrt[5(25+2Sqrt[5])]/22},
{-Sqrt[(5(85+31Sqrt[5]))/2]/22,(5(13+5Sqrt[5]))/44,-Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[(5(205+89Sqrt[5]))/2]/11,0,Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[(5(85+31Sqrt[5]))/2]/22,(-5(13+5Sqrt[5]))/44,Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[(5(85+31Sqrt[5]))/2]/22,(5(13+5Sqrt[5]))/44,Sqrt[5(25+2Sqrt[5])]/22},
{-Sqrt[1325+590Sqrt[5]]/22,(-5(3+2Sqrt[5]))/22,Sqrt[5(25+2Sqrt[5])]/22},
{-Sqrt[1325+590Sqrt[5]]/22,(5(3+2Sqrt[5]))/22,Sqrt[5(25+2Sqrt[5])]/22},
{Sqrt[25/8+(11Sqrt[5])/8],(-5-Sqrt[5])/4,Sqrt[5+2Sqrt[5]]/2},
{Sqrt[25/8+(11Sqrt[5])/8],(5+Sqrt[5])/4,Sqrt[5+2Sqrt[5]]/2},
{-Sqrt[5+2Sqrt[5]],0,Sqrt[5+2Sqrt[5]]/2},{-Sqrt[(5+Sqrt[5])/2]/2,(-5-3Sqrt[5])/4,
Sqrt[5+2Sqrt[5]]/2},{-Sqrt[(5+Sqrt[5])/2]/2,(5+3Sqrt[5])/4,Sqrt[5+2Sqrt[5]]/2},
{Sqrt[5+2Sqrt[5]],0,-Sqrt[5+2Sqrt[5]]/2},{Root[5-100#1^2+16#1^4&,1,0],(-5-Sqrt[5])/4,
-Sqrt[5+2Sqrt[5]]/2},{Root[5-100#1^2+16#1^4&,1,0],(5+Sqrt[5])/4,-Sqrt[5+2Sqrt[5]]/2},
{Sqrt[5/8+Sqrt[5]/8],(-5-3Sqrt[5])/4,-Sqrt[5+2Sqrt[5]]/2},{Sqrt[5/8+Sqrt[5]/8],(5+3Sqrt[5])/4,
-Sqrt[5+2Sqrt[5]]/2}}

(* Triakis Tetrahedron *)

PolyhedronName[TriakisTetrahedron]:="triakis tetrahedron"
NetFaces[TriakisTetrahedron]:={{8,10,11},{8,11,4},{8,4,6},{12,11,10},{12,10,14},{12,14,13},{7,4,11},{7,11,9},{7,9,3},{2,6,4},{2,4,1},{2,1,5}}
NetVertices[TriakisTetrahedron]:={{-1.19569314749,-0.390563847883},{-0.609881600786,-0.260853278728},
{-0.588955493862,0.533606938224},{-0.50156635741,0.329288914351},{-0.262565641171,-0.750109473576},
{-0.108315243376,-0.590142193079},{-0.00314394716,0.66331750738},{0.,0.},
{0.105171296216,1.25345970046},{0.113904482771,-0.589088931151},{0.49842241025,0.334028593029},
{0.612326893021,-0.255060338122},{0.720642136397,0.335081854957},{1.11389325043,-0.584349252474}}
PolyhedronDual[TriakisTetrahedron]:=TruncatedTetrahedron
PolyhedronFaces[TriakisTetrahedron]:=
{{6,4,1},{1,5,7},{6,3,4},{7,5,3},{6,2,3},{7,3,2},{7,2,6},{7,6,8},{4,3,1},{3,5,
    1},{6,1,8},{1,7,8}}
PolyhedronVertices[TriakisTetrahedron]:=
{{0, 0, (-3Sqrt[3/2])/2}, {0, 0, (9Sqrt[3/2])/10}, 
 {-Sqrt[3], 0, Sqrt[3/2]/2}, {(-3Sqrt[3])/10, -9/10, 
  (-3Sqrt[3/2])/10}, {(-3Sqrt[3])/10, 9/10, 
  (-3Sqrt[3/2])/10}, {Sqrt[3]/2, -3/2, Sqrt[3/2]/2}, 
 {Sqrt[3]/2, 3/2, Sqrt[3/2]/2}, {(3Sqrt[3])/5, 0, 
  (-3Sqrt[3/2])/10}}

(* Truncated Cube *)

PolyhedronName[TruncatedCube]:="truncated cube"
NetFaces[TruncatedCube]:={{4,2,1,3,5,11,12,6},{17,12,11,16,20,25,26,21},{32,26,25,31,33,35,36,34},{40,36,35,39,41,43,44,42},{18,14,13,17,21,27,28,22},{16,10,9,15,19,23,24,20},{42,44,46},{41,45,43},{34,36,38},{33,37,35},{21,26,30},{20,29,25},{8,12,17},{7,16,11}}
NetVertices[TruncatedCube]:={{(-1-Sqrt[2])/2,-1/2},{(-1-Sqrt[2])/2,1/2},{-1/2,(-1-Sqrt[2])/2},{-1/2,(1+Sqrt[2])/2},{1/2,(-1-Sqrt[2])/2},{1/2,(1+Sqrt[2])/2},{(2+3Sqrt[2]-Sqrt[6])/4,(-2-Sqrt[2]-Sqrt[6])/4},{(2+3Sqrt[2]-Sqrt[6])/4,(2+Sqrt[2]+Sqrt[6])/4},{(1+Sqrt[2])/2,(-3-2Sqrt[2])/2},{(1+Sqrt[2])/2,(-1-2Sqrt[2])/2},{(1+Sqrt[2])/2,-1/2},{(1+Sqrt[2])/2,1/2},{(1+Sqrt[2])/2,(1+2Sqrt[2])/2},{(1+Sqrt[2])/2,(3+2Sqrt[2])/2},{(1+2Sqrt[2])/2,(-3(1+Sqrt[2]))/2},{(1+2Sqrt[2])/2,(-1-Sqrt[2])/2},{(1+2Sqrt[2])/2,(1+Sqrt[2])/2},{(1+2Sqrt[2])/2,(3(1+Sqrt[2]))/2},{(3+2Sqrt[2])/2,(-3(1+Sqrt[2]))/2},{(3+2Sqrt[2])/2,(-1-Sqrt[2])/2},{(3+2Sqrt[2])/2,(1+Sqrt[2])/2},{(3+2Sqrt[2])/2,(3(1+Sqrt[2]))/2},{(3(1+Sqrt[2]))/2,(-3-2Sqrt[2])/2},{(3(1+Sqrt[2]))/2,(-1-2Sqrt[2])/2},{(3(1+Sqrt[2]))/2,-1/2},{(3(1+Sqrt[2]))/2,1/2},{(3(1+Sqrt[2]))/2,(1+2Sqrt[2])/2},{(3(1+Sqrt[2]))/2,(3+2Sqrt[2])/2},{(6+5Sqrt[2]+Sqrt[6])/4,(-2-Sqrt[2]-Sqrt[6])/4},{(6+5Sqrt[2]+Sqrt[6])/4,(2+Sqrt[2]+Sqrt[6])/4},{(3+4Sqrt[2])/2,(-1-Sqrt[2])/2},{(3+4Sqrt[2])/2,(1+Sqrt[2])/2},{(5+4Sqrt[2])/2,(-1-Sqrt[2])/2},{(5+4Sqrt[2])/2,(1+Sqrt[2])/2},{(5(1+Sqrt[2]))/2,-1/2},{(5(1+Sqrt[2]))/2,1/2},{(10+9Sqrt[2]+Sqrt[6])/4,(-2-Sqrt[2]-Sqrt[6])/4},{(10+9Sqrt[2]+Sqrt[6])/4,(2+Sqrt[2]+Sqrt[6])/4},{(5+6Sqrt[2])/2,(-1-Sqrt[2])/2},{(5+6Sqrt[2])/2,(1+Sqrt[2])/2},{(7+6Sqrt[2])/2,(-1-Sqrt[2])/2},{(7+6Sqrt[2])/2,(1+Sqrt[2])/2},{(7(1+Sqrt[2]))/2,-1/2},{(7(1+Sqrt[2]))/2,1/2},{(14+13Sqrt[2]+Sqrt[6])/4,(-2-Sqrt[2]-Sqrt[6])/4},{(14+13Sqrt[2]+Sqrt[6])/4,(2+Sqrt[2]+Sqrt[6])/4}}
PolyhedronDual[TruncatedCube]:=SmallTriakisOctahedron
PolyhedronFaces[TruncatedCube]:=
{{6,12,10,8,4,18,20,2},{1,19,17,3,7,9,11,5},{3,24,23,4,8,15,16,7},{5,14,13,6,
    2,21,22,1},{9,16,15,10,12,13,14,11},{19,22,21,20,18,23,24,17},{16,9,7},{5,
    11,14},{3,17,24},{22,19,1},{8,10,15},{13,12,6},{23,18,4},{2,20,21}}
PolyhedronVertices[TruncatedCube]:=
{{-1/2,1/2+1/Sqrt[2],1/2+1/Sqrt[2]},
{-1/2,1/2+1/Sqrt[2],(2-2Sqrt[2])^(-1)},
{-1/2,(2-2Sqrt[2])^(-1),1/2+1/Sqrt[2]},
{-1/2,(2-2Sqrt[2])^(-1),(2-2Sqrt[2])^(-1)},
{1/2,1/2+1/Sqrt[2],1/2+1/Sqrt[2]},
{1/2,1/2+1/Sqrt[2],(2-2Sqrt[2])^(-1)},
{1/2,(2-2Sqrt[2])^(-1),1/2+1/Sqrt[2]},
{1/2,(2-2Sqrt[2])^(-1),(2-2Sqrt[2])^(-1)},
{1/2+1/Sqrt[2],-1/2,1/2+1/Sqrt[2]},
{1/2+1/Sqrt[2],-1/2,(2-2Sqrt[2])^(-1)},
{1/2+1/Sqrt[2],1/2,1/2+1/Sqrt[2]},
{1/2+1/Sqrt[2],1/2,(2-2Sqrt[2])^(-1)},
{1/2+1/Sqrt[2],1/2+1/Sqrt[2],-1/2},
{1/2+1/Sqrt[2],1/2+1/Sqrt[2],1/2},
{1/2+1/Sqrt[2],(2-2Sqrt[2])^(-1),-1/2},
{1/2+1/Sqrt[2],(2-2Sqrt[2])^(-1),1/2},
{(2-2Sqrt[2])^(-1),-1/2,1/2+1/Sqrt[2]},
{(2-2Sqrt[2])^(-1),-1/2,(2-2Sqrt[2])^(-1)},
{(2-2Sqrt[2])^(-1),1/2,1/2+1/Sqrt[2]},
{(2-2Sqrt[2])^(-1),1/2,(2-2Sqrt[2])^(-1)},
{(2-2Sqrt[2])^(-1),1/2+1/Sqrt[2],-1/2},
{(2-2Sqrt[2])^(-1),1/2+1/Sqrt[2],1/2},
{(2-2Sqrt[2])^(-1),(2-2Sqrt[2])^(-1),-1/2},
{(2-2Sqrt[2])^(-1),(2-2Sqrt[2])^(-1),1/2}}

(* Truncated Dodecahedron *)

PolyhedronName[TruncatedDodecahedron]:="truncated dodecahedron"
NetFaces[TruncatedDodecahedron]:={{80,90,94,97,98,95,91,81,75,74},{67,74,75},{53,60,73,79,80,74,61,54,49,48},{42,49,54},{83,90,80},{99,107,108,100,94,90,86,85,89,93},{78,89,85},{103,97,94},{118,116,112,106,98,97,105,111,115,117},{114,115,111},{104,95,98},{96,92,88,87,91,95,101,109,110,102},{113,110,109},{84,81,91},{51,50,55,62,75,81,82,76,63,56},{72,63,76},{28,38,44,45,39,29,25,22,21,24},{15,24,21},{23,27,31,32,28,24,18,10,9,17},{6,9,10},{35,38,28},{68,69,64,57,44,38,37,43,56,63},{47,56,43},{52,45,44},{66,59,46,40,39,45,58,65,70,71},{77,70,65},{36,29,39},{20,12,11,19,25,29,33,34,30,26},{41,30,34},{16,22,25},{1,3,7,13,21,22,14,8,4,2},{5,4,8}}
NetVertices[TruncatedDodecahedron]:={{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-6Sqrt[10(5+Sqrt[5])])/12,(13+5Sqrt[5])/4},{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-6Sqrt[10(5+Sqrt[5])])/12,(17+5Sqrt[5])/4},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,3+Sqrt[5]},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,(3(3+Sqrt[5]))/2},{(7Sqrt[3]-3Sqrt[15]-30Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,(35+13Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(-4Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(5+Sqrt[5])/2},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,(13+3Sqrt[5])/4},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,(17+7Sqrt[5])/4},{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(4+Sqrt[5])/2},{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(6+Sqrt[5])/2},{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(9+4Sqrt[5])/2},{(2Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(11+4Sqrt[5])/2},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,3+Sqrt[5]},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/24,(3(3+Sqrt[5]))/2},{(2Sqrt[3]-6Sqrt[15]-51Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/48,(50+18Sqrt[5]+Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/16},{(2Sqrt[3]-6Sqrt[15]-51Sqrt[2(5+Sqrt[5])]-9Sqrt[10(5+Sqrt[5])])/48,(70+22Sqrt[5]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(7+Sqrt[5])/4},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(13+3Sqrt[5])/4},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(17+7Sqrt[5])/4},{(4Sqrt[3]-33Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(23+9Sqrt[5])/4},{(2Sqrt[3]-12Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(13+5Sqrt[5])/4},{(2Sqrt[3]-12Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/12,(17+5Sqrt[5])/4},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,2},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,3+Sqrt[5]},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(3(3+Sqrt[5]))/2},{(4Sqrt[3]-27Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(11+5Sqrt[5])/2},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(7+Sqrt[5])/4},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(13+3Sqrt[5])/4},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(17+7Sqrt[5])/4},{(4Sqrt[3]-21Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(23+9Sqrt[5])/4},{(Sqrt[3]-6Sqrt[2(5+Sqrt[5])])/6,(4+Sqrt[5])/2},{(Sqrt[3]-6Sqrt[2(5+Sqrt[5])])/6,(6+Sqrt[5])/2},{(Sqrt[3]-6Sqrt[2(5+Sqrt[5])])/6,(9+4Sqrt[5])/2},{(Sqrt[3]-6Sqrt[2(5+Sqrt[5])])/6,(11+4Sqrt[5])/2},{(Sqrt[3]+3Sqrt[15]-18Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(25+7Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(Sqrt[3]+3Sqrt[15]-18Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(35+13Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(4Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,2+Sqrt[5]},{(4Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,3+Sqrt[5]},{(4Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(3(3+Sqrt[5]))/2},{(4Sqrt[3]-15Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(11+3Sqrt[5])/2},{(14Sqrt[3]+6Sqrt[15]-45Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/48,(90+34Sqrt[5]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(2Sqrt[3]-6Sqrt[15]-21Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/48,(-10-2Sqrt[5]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(2Sqrt[3]-9Sqrt[2(5+Sqrt[5])])/12,(7+3Sqrt[5])/4},{(2Sqrt[3]-9Sqrt[2(5+Sqrt[5])])/12,(13+5Sqrt[5])/4},{(2Sqrt[3]-9Sqrt[2(5+Sqrt[5])])/12,(17+5Sqrt[5])/4},{(2Sqrt[3]-9Sqrt[2(5+Sqrt[5])])/12,(23+7Sqrt[5])/4},{(7Sqrt[3]-3Sqrt[15]-15Sqrt[2(5+Sqrt[5])])/24,(15+5Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(-7-Sqrt[5])/4},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(-3-Sqrt[5])/4},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(3+Sqrt[5])/4},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]-3Sqrt[10(5+Sqrt[5])])/24,(7+Sqrt[5])/4},{(8Sqrt[3]-9Sqrt[2(5+Sqrt[5])])/12,(5(3+Sqrt[5]))/4},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,(-4-Sqrt[5])/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,-1/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,1/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,(4+Sqrt[5])/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,(3(2+Sqrt[5]))/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,(9+2Sqrt[5])/2},{(Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/6,(11+4Sqrt[5])/2},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(-7-3Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(-3+Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(3-Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(7+3Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(13+5Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(17+5Sqrt[5])/4},{(2Sqrt[3]-3Sqrt[2(5+Sqrt[5])])/12,(23+7Sqrt[5])/4},{-(1/Sqrt[3]),0},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,2+Sqrt[5]},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,3+Sqrt[5]},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(3(3+Sqrt[5]))/2},{(4Sqrt[3]-9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(11+3Sqrt[5])/2},{(Sqrt[3]+3Sqrt[15]-3Sqrt[2(5+Sqrt[5])])/24,(15+5Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{1/(2Sqrt[3]),(-4-Sqrt[5])/2},{1/(2Sqrt[3]),-1/2},{1/(2Sqrt[3]),1/2},{1/(2Sqrt[3]),(4+Sqrt[5])/2},{(14Sqrt[3]+6Sqrt[15]-15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(70+22Sqrt[5]+Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/16},{(2Sqrt[3]-6Sqrt[15]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/48,(-30-14Sqrt[5]+Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/16},{(4Sqrt[3]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-7-Sqrt[5])/4},{(4Sqrt[3]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-3-Sqrt[5])/4},{(4Sqrt[3]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(3+Sqrt[5])/4},{(4Sqrt[3]-3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(7+Sqrt[5])/4},{(7Sqrt[3]-3Sqrt[15]+3Sqrt[10(5+Sqrt[5])])/24,(-5-3Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(7Sqrt[3]-3Sqrt[15]+3Sqrt[10(5+Sqrt[5])])/24,(5+3Sqrt[5]+Sqrt[6(5+Sqrt[5])])/8},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])])/12,(-7-3Sqrt[5])/4},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])])/12,(-3(1+Sqrt[5]))/4},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])])/12,(3(1+Sqrt[5]))/4},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])])/12,(7+3Sqrt[5])/4},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,-2-Sqrt[5]},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-1-Sqrt[5])/2},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(1+Sqrt[5])/2},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,2+Sqrt[5]},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-7-5Sqrt[5])/4},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-3-Sqrt[5])/4},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(3+Sqrt[5])/4},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(7+5Sqrt[5])/4},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,-1/2},{(2Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,1/2},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,-2-Sqrt[5]},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(-1-Sqrt[5])/2},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,(1+Sqrt[5])/2},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/24,2+Sqrt[5]},{(14Sqrt[3]+6Sqrt[15]+15Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/48,(-10-2Sqrt[5]+Sqrt[6(5+Sqrt[5])]-Sqrt[30(5+Sqrt[5])])/16},{(14Sqrt[3]+6Sqrt[15]+15Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/48,(10+2Sqrt[5]-Sqrt[6(5+Sqrt[5])]+Sqrt[30(5+Sqrt[5])])/16},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(-3-Sqrt[5])/4},{(4Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(3+Sqrt[5])/4},{(2Sqrt[3]+6Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,(-7-3Sqrt[5])/4},{(2Sqrt[3]+6Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,(-3(1+Sqrt[5]))/4},{(2Sqrt[3]+6Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,(3(1+Sqrt[5]))/4},{(2Sqrt[3]+6Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,(7+3Sqrt[5])/4},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(-1-Sqrt[5])/2},{(4Sqrt[3]+9Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(1+Sqrt[5])/2},{(8Sqrt[3]+6Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/12,(5+3Sqrt[5])/4},{(Sqrt[3]+3Sqrt[15]+12Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(-5-3Sqrt[5]-Sqrt[6(5+Sqrt[5])])/8},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(-3-Sqrt[5])/4},{(4Sqrt[3]+15Sqrt[2(5+Sqrt[5])]+9Sqrt[10(5+Sqrt[5])])/24,(3+Sqrt[5])/4},{(Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/6,-1/2},{(Sqrt[3]+3Sqrt[2(5+Sqrt[5])]+3Sqrt[10(5+Sqrt[5])])/6,1/2}}
PolyhedronDual[TruncatedDodecahedron]:=TriakisIcosahedron
PolyhedronFaces[TruncatedDodecahedron]:=
{{3,42,46,44,40,1,34,48,50,36},{47,43,4,37,51,49,35,2,41,45},{2,35,19,24,21,
    16,5,59,55,14},{49,51,20,25,29,31,30,28,24,19},{37,4,15,56,60,6,17,22,25,
    20},{43,47,52,9,33,27,11,13,56,15},{45,41,14,55,12,10,26,32,9,52},{6,60,
    13,11,54,58,42,3,8,39},{27,33,32,26,53,57,44,46,58,54},{10,12,59,5,38,7,1,
    40,57,53},{16,21,28,30,18,23,48,34,7,38},{31,29,22,17,39,8,36,50,23,
    18},{9,32,33},{18,30,31},{47,45,52},{50,48,23},{10,53,26},{27,54,11},{21,
    24,28},{29,25,22},{40,44,57},{58,46,42},{35,49,19},{20,51,37},{12,55,
    59},{60,56,13},{41,2,14},{15,4,43},{34,1,7},{8,3,36},{38,5,16},{17,6,39}}
PolyhedronVertices[TruncatedDodecahedron]:=
{{0,(-1-Sqrt[5])/2,Sqrt[25/8+(11Sqrt[5])/8]},
{0,(-1-Sqrt[5])/2,Root[5-100#1^2+16#1^4&,1,
0]},{0,(1+Sqrt[5])/2,Sqrt[25/8+(11Sqrt[5])/8]},
{0,(1+Sqrt[5])/2,Root[5-100#1^2+16#1^4&,1,
0]},{Sqrt[1/8+1/(8Sqrt[5])],(-5-3Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,3,0]},
{Sqrt[1/8+1/(8Sqrt[5])],(5+3Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,3,0]},
{Sqrt[1/4+1/(2Sqrt[5])],-1-Sqrt[5]/2,
Sqrt[17/8+31/(8Sqrt[5])]},{Sqrt[1/4+1/(2Sqrt[5])],
(2+Sqrt[5])/2,Sqrt[17/8+31/(8Sqrt[5])]},
{-2Sqrt[1+2/Sqrt[5]],0,Root[1-100#1^2+80#1^4&,
1,0]},{(-3Sqrt[1+2/Sqrt[5]])/2,-1-Sqrt[5]/2,
Root[1-20#1^2+80#1^4&,3,0]},
{(-3Sqrt[1+2/Sqrt[5]])/2,(2+Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,3,0]},
{-Sqrt[1+2/Sqrt[5]],(-3-Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,2,0]},
{-Sqrt[1+2/Sqrt[5]],(3+Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,2,0]},
{-Sqrt[1+2/Sqrt[5]]/2,-1-Sqrt[5]/2,
-Sqrt[17/8+31/(8Sqrt[5])]},{-Sqrt[1+2/Sqrt[5]]/2,
(2+Sqrt[5])/2,-Sqrt[17/8+31/(8Sqrt[5])]},
{Sqrt[1+2/Sqrt[5]],(-3-Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,3,0]},
{Sqrt[1+2/Sqrt[5]],(3+Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,3,0]},
{2Sqrt[1+2/Sqrt[5]],0,Sqrt[5/8+11/(8Sqrt[5])]},
{Sqrt[13/8+29/(8Sqrt[5])],(-3-Sqrt[5])/4,
-Sqrt[17/8+31/(8Sqrt[5])]},
{Sqrt[13/8+29/(8Sqrt[5])],(3+Sqrt[5])/4,
-Sqrt[17/8+31/(8Sqrt[5])]},{Sqrt[9/4+9/(2Sqrt[5])],
-1-Sqrt[5]/2,Root[1-20#1^2+80#1^4&,2,0]},
{Sqrt[9/4+9/(2Sqrt[5])],(2+Sqrt[5])/2,
Root[1-20#1^2+80#1^4&,2,0]},
{Sqrt[5/2+11/(2Sqrt[5])],0,
Sqrt[17/8+31/(8Sqrt[5])]},{Sqrt[5/2+11/(2Sqrt[5])],
(-1-Sqrt[5])/2,Root[1-100#1^2+80#1^4&,1,0]},
{Sqrt[5/2+11/(2Sqrt[5])],(1+Sqrt[5])/2,
Root[1-100#1^2+80#1^4&,1,0]},
{-Sqrt[29/8+61/(8Sqrt[5])],(-3-Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,3,0]},
{-Sqrt[29/8+61/(8Sqrt[5])],(3+Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,3,0]},
{Sqrt[29/8+61/(8Sqrt[5])],(-3-Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,2,0]},
{Sqrt[29/8+61/(8Sqrt[5])],(3+Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,2,0]},
{Sqrt[17/4+19/(2Sqrt[5])],-1/2,
Root[1-20#1^2+80#1^4&,3,0]},
{Sqrt[17/4+19/(2Sqrt[5])],1/2,
Root[1-20#1^2+80#1^4&,3,0]},
{-Sqrt[17+38/Sqrt[5]]/2,-1/2,
Root[1-20#1^2+80#1^4&,2,0]},
{-Sqrt[17+38/Sqrt[5]]/2,1/2,
Root[1-20#1^2+80#1^4&,2,0]},
{Sqrt[5/8+Sqrt[5]/8],(-3-Sqrt[5])/4,
Sqrt[25/8+(11Sqrt[5])/8]},{Sqrt[5/8+Sqrt[5]/8],
(-3-Sqrt[5])/4,Root[5-100#1^2+16#1^4&,1,0]},
{Sqrt[5/8+Sqrt[5]/8],(3+Sqrt[5])/4,
Sqrt[25/8+(11Sqrt[5])/8]},{Sqrt[5/8+Sqrt[5]/8],
(3+Sqrt[5])/4,Root[5-100#1^2+16#1^4&,1,0]},
{Sqrt[(5+Sqrt[5])/10],(-3-Sqrt[5])/2,
Sqrt[5/8+11/(8Sqrt[5])]},{Sqrt[(5+Sqrt[5])/10],
(3+Sqrt[5])/2,Sqrt[5/8+11/(8Sqrt[5])]},
{-Sqrt[(5+Sqrt[5])/2]/2,(-3-Sqrt[5])/4,
Sqrt[25/8+(11Sqrt[5])/8]},{-Sqrt[(5+Sqrt[5])/2]/2,
(-3-Sqrt[5])/4,Root[5-100#1^2+16#1^4&,1,0]},
{-Sqrt[(5+Sqrt[5])/2]/2,(3+Sqrt[5])/4,
Sqrt[25/8+(11Sqrt[5])/8]},{-Sqrt[(5+Sqrt[5])/2]/2,
(3+Sqrt[5])/4,Root[5-100#1^2+16#1^4&,1,0]},
{-Sqrt[5+2Sqrt[5]]/2,-1/2,
Sqrt[25/8+(11Sqrt[5])/8]},{-Sqrt[5+2Sqrt[5]]/2,
-1/2,Root[5-100#1^2+16#1^4&,1,0]},
{-Sqrt[5+2Sqrt[5]]/2,1/2,Sqrt[25/8+(11Sqrt[5])/8]},
{-Sqrt[5+2Sqrt[5]]/2,1/2,
Root[5-100#1^2+16#1^4&,1,0]},
{Sqrt[5+2Sqrt[5]]/2,-1/2,Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[5+2Sqrt[5]]/2,-1/2,
Root[5-100#1^2+16#1^4&,1,0]},
{Sqrt[5+2Sqrt[5]]/2,1/2,Sqrt[25/8+(11Sqrt[5])/8]},
{Sqrt[5+2Sqrt[5]]/2,1/2,
Root[5-100#1^2+16#1^4&,1,0]},
{Root[1-25#1^2+5#1^4&,1,0],0,
-Sqrt[17/8+31/(8Sqrt[5])]},
{Root[1-25#1^2+5#1^4&,1,0],(-1-Sqrt[5])/2,
Sqrt[5/8+11/(8Sqrt[5])]},
{Root[1-25#1^2+5#1^4&,1,0],(1+Sqrt[5])/2,
Sqrt[5/8+11/(8Sqrt[5])]},
{Root[1-5#1^2+5#1^4&,1,0],(-3-Sqrt[5])/2,
Root[1-100#1^2+80#1^4&,1,0]},
{Root[1-5#1^2+5#1^4&,1,0],(3+Sqrt[5])/2,
Root[1-100#1^2+80#1^4&,1,0]},
{Root[1-260#1^2+80#1^4&,1,0],(-3-Sqrt[5])/4,
Sqrt[17/8+31/(8Sqrt[5])]},
{Root[1-260#1^2+80#1^4&,1,0],(3+Sqrt[5])/4,
Sqrt[17/8+31/(8Sqrt[5])]},
{Root[1-20#1^2+80#1^4&,1,0],(-5-3Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,2,0]},
{Root[1-20#1^2+80#1^4&,1,0],(5+3Sqrt[5])/4,
Root[1-20#1^2+80#1^4&,2,0]}}

(* Truncated Icosahedron *)

PolyhedronName[TruncatedIcosahedron]:="truncated icosahedron"
NetFaces[TruncatedIcosahedron]:={{24,29,49,50,30},{49,60,71,72,61,50},{71,96,106,107,97,72},{4,14,39,40,15,5},{39,50,61,62,51,40},{61,81,91,82,62},{25,31,51,52,32},{51,62,73,74,63,52},{73,98,108,109,99,74},{6,16,41,42,17,7},{41,52,63,64,53,42},{63,83,92,84,64},{26,33,53,54,34},{53,64,75,76,65,54},{75,100,110,111,101,76},{8,18,43,44,19,9},{43,54,65,66,55,44},{65,85,93,86,66},{27,35,55,56,36},{55,66,77,78,67,56},{77,102,112,113,103,78},{10,20,45,46,21,11},{45,56,67,68,57,46},{67,87,94,88,68},{28,37,57,58,38},{57,68,79,80,69,58},{79,104,114,115,105,80},{12,22,47,48,23,13},{47,58,69,70,59,48},{69,89,95,90,70},{1,2,4,5,3},{108,116,118,117,109}}
NetVertices[TruncatedIcosahedron]:={{(-15Sqrt[3]-Sqrt[10(5+Sqrt[5])])/10,3/2},{(-60Sqrt[3]-5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(5-Sqrt[5])/4},{(-60Sqrt[3]-5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(7+Sqrt[5])/4},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,2},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,4},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,8},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,10},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13},{(-60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,14},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,17/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,19/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,23/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,25/2},{(-40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,29/2},{-Sqrt[(5+Sqrt[5])/10],0},{-Sqrt[(5+Sqrt[5])/10],3},{-Sqrt[(5+Sqrt[5])/10],6},{-Sqrt[(5+Sqrt[5])/10],9},{-Sqrt[(5+Sqrt[5])/10],12},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(-1-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(1+Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(11-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(13+Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(23-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(25+Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(35-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(37+Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(47-Sqrt[5])/4},{((-5+Sqrt[5])Sqrt[(5+Sqrt[5])/2])/20,(49+Sqrt[5])/4},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,2},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,4},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,8},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,10},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13},{(-20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,14},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),-1/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),1/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),5/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),7/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),11/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),13/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),17/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),19/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),23/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),25/2},{(5+Sqrt[5])^(3/2)/(20Sqrt[2]),29/2},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,-1},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,2},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,4},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,8},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,10},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13},{(20Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,14},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,-1/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,17/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,19/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,23/2},{(40Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,25/2},{(20Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(5-Sqrt[5])/4},{(40Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(7+Sqrt[5])/4},{(20Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(17-Sqrt[5])/4},{(40Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(19+Sqrt[5])/4},{(20Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(29-Sqrt[5])/4},{(40Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(31+Sqrt[5])/4},{(20Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(41-Sqrt[5])/4},{(40Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(43+Sqrt[5])/4},{(20Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(53-Sqrt[5])/4},{(40Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(55+Sqrt[5])/4},{(40Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,3/2},{(40Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,9/2},{(40Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,15/2},{(40Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,21/2},{(40Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,27/2},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,-1},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,2},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,4},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,8},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,10},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11},{(60Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,-1/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,1/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,5/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,7/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,11/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,13/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,17/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,19/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,23/2},{(80Sqrt[3]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,25/2},{(80Sqrt[3]+5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+5Sqrt[2(5+Sqrt[5])]+Sqrt[10(5+Sqrt[5])])/40,(11-Sqrt[5])/4},{(160Sqrt[3]-5Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,(13+Sqrt[5])/4},{(160Sqrt[3]+15Sqrt[2(5-Sqrt[5])]+5Sqrt[10(5-Sqrt[5])]+15Sqrt[2(5+Sqrt[5])]+7Sqrt[10(5+Sqrt[5])])/80,3}}
PolyhedronDual[TruncatedIcosahedron]:=PentakisDodecahedron
PolyhedronFaces[TruncatedIcosahedron]:=
{{53,11,24,23,9},{51,39,40,52,30},{60,28,16,12,2},{20,42,48,55,18},{19,17,54,
    47,41},{1,10,15,27,59},{36,26,44,50,38},{4,58,22,32,8},{34,29,33,45,
    46},{21,57,3,6,31},{37,49,43,25,35},{13,5,56,7,14},{9,59,27,51,30,53},{53,
    30,52,28,60,11},{11,60,2,42,20,24},{24,20,18,17,19,23},{23,19,41,1,59,
    9},{13,25,43,3,57,5},{5,57,21,33,29,56},{56,29,34,22,58,7},{7,58,4,44,26,
    14},{14,26,36,35,25,13},{40,38,50,16,28,52},{16,50,44,4,8,12},{12,8,32,48,
    42,2},{48,32,22,34,46,55},{55,46,45,54,17,18},{54,45,33,21,31,47},{47,31,
    6,10,1,41},{10,6,3,43,49,15},{15,49,37,39,51,27},{39,37,35,36,38,40}}
PolyhedronVertices[TruncatedIcosahedron]:=
{{-Sqrt[1-2/Sqrt[5]]/2,-1-Sqrt[5]/2,Sqrt[9/8+9/(8Sqrt[5])]},
{-Sqrt[1-2/Sqrt[5]]/2,(2+Sqrt[5])/2,Sqrt[9/8+9/(8Sqrt[5])]},
{Sqrt[1-2/Sqrt[5]]/2,-1-Sqrt[5]/2,(-3Sqrt[(5+Sqrt[5])/10])/2},
{Sqrt[1-2/Sqrt[5]]/2,(2+Sqrt[5])/2,(-3Sqrt[(5+Sqrt[5])/10])/2},
{-Sqrt[2-2/Sqrt[5]]/4,(1-Sqrt[5])^(-1),-Sqrt[25/8+41/(8Sqrt[5])]},
{-Sqrt[2-2/Sqrt[5]]/4,(-3(1+Sqrt[5]))/4,Root[1-20#1^2+80#1^4&,1,0]},
{-Sqrt[2-2/Sqrt[5]]/4,(1+Sqrt[5])/4,-Sqrt[25/8+41/(8Sqrt[5])]},
{-Sqrt[2-2/Sqrt[5]]/4,(3(1+Sqrt[5]))/4,Root[1-20#1^2+80#1^4&,1,0]},
{Sqrt[2-2/Sqrt[5]]/4,(1-Sqrt[5])^(-1),Sqrt[25/8+41/(8Sqrt[5])]},
{Sqrt[2-2/Sqrt[5]]/4,(-3(1+Sqrt[5]))/4,Sqrt[1/8+1/(8Sqrt[5])]},
{Sqrt[2-2/Sqrt[5]]/4,(1+Sqrt[5])/4,Sqrt[25/8+41/(8Sqrt[5])]},
{Sqrt[2-2/Sqrt[5]]/4,(3(1+Sqrt[5]))/4,Sqrt[1/8+1/(8Sqrt[5])]},
{Sqrt[1/4+1/(2Sqrt[5])],-1/2,-Sqrt[25/8+41/(8Sqrt[5])]},
{Sqrt[1/4+1/(2Sqrt[5])],1/2,-Sqrt[25/8+41/(8Sqrt[5])]},
{Sqrt[5/4+1/(2Sqrt[5])],-1-Sqrt[5]/2,Sqrt[1/8+1/(8Sqrt[5])]},
{Sqrt[5/4+1/(2Sqrt[5])],(2+Sqrt[5])/2,Sqrt[1/8+1/(8Sqrt[5])]},
{(-3Sqrt[1+2/Sqrt[5]])/2,-1/2,Sqrt[9/8+9/(8Sqrt[5])]},
{(-3Sqrt[1+2/Sqrt[5]])/2,1/2,Sqrt[9/8+9/(8Sqrt[5])]},
{-Sqrt[1+2/Sqrt[5]],-1,Sqrt[26+58/Sqrt[5]]/4},
{-Sqrt[1+2/Sqrt[5]],1,Sqrt[26+58/Sqrt[5]]/4},
{-Sqrt[1+2/Sqrt[5]],-2/(-1+Sqrt[5]),(-3Sqrt[(5+Sqrt[5])/10])/2},
{-Sqrt[1+2/Sqrt[5]],(1+Sqrt[5])/2,(-3Sqrt[(5+Sqrt[5])/10])/2},
{-Sqrt[1+2/Sqrt[5]]/2,-1/2,Sqrt[25/8+41/(8Sqrt[5])]},
{-Sqrt[1+2/Sqrt[5]]/2,1/2,Sqrt[25/8+41/(8Sqrt[5])]},
{Sqrt[1+2/Sqrt[5]],-1,Root[1-260#1^2+80#1^4&,1,0]},
{Sqrt[1+2/Sqrt[5]],1,Root[1-260#1^2+80#1^4&,1,0]},
{Sqrt[1+2/Sqrt[5]],-2/(-1+Sqrt[5]),Sqrt[9/8+9/(8Sqrt[5])]},
{Sqrt[1+2/Sqrt[5]],(1+Sqrt[5])/2,Sqrt[9/8+9/(8Sqrt[5])]},
{-Sqrt[2+2/Sqrt[5]],0,Root[1-260#1^2+80#1^4&,1,0]},
{Sqrt[2+2/Sqrt[5]],0,Sqrt[26+58/Sqrt[5]]/4},
{-Sqrt[5+2/Sqrt[5]]/2,-1-Sqrt[5]/2,Root[1-20#1^2+80#1^4&,1,0]},
{-Sqrt[5+2/Sqrt[5]]/2,(2+Sqrt[5])/2,Root[1-20#1^2+80#1^4&,1,0]},
{-Sqrt[17/8+31/(8Sqrt[5])],(1-Sqrt[5])^(-1),(-3Sqrt[(5+Sqrt[5])/10])/2},
{-Sqrt[17/8+31/(8Sqrt[5])],(1+Sqrt[5])/4,(-3Sqrt[(5+Sqrt[5])/10])/2},
{Sqrt[9/4+9/(2Sqrt[5])],-1/2,(-3Sqrt[(5+Sqrt[5])/10])/2},
{Sqrt[9/4+9/(2Sqrt[5])],1/2,(-3Sqrt[(5+Sqrt[5])/10])/2},
{Sqrt[5/2+11/(2Sqrt[5])],-1,Root[1-20#1^2+80#1^4&,1,0]},
{Sqrt[5/2+11/(2Sqrt[5])],1,Root[1-20#1^2+80#1^4&,1,0]},
{Sqrt[13/4+11/(2Sqrt[5])],-1/2,Sqrt[1/8+1/(8Sqrt[5])]},
{Sqrt[13/4+11/(2Sqrt[5])],1/2,Sqrt[1/8+1/(8Sqrt[5])]},
{-Sqrt[10+22/Sqrt[5]]/4,(-5-Sqrt[5])/4,Sqrt[9/8+9/(8Sqrt[5])]},
{-Sqrt[10+22/Sqrt[5]]/4,(5+Sqrt[5])/4,Sqrt[9/8+9/(8Sqrt[5])]},
{Sqrt[10+22/Sqrt[5]]/4,(-5-Sqrt[5])/4,(-3Sqrt[(5+Sqrt[5])/10])/2},
{Sqrt[10+22/Sqrt[5]]/4,(5+Sqrt[5])/4,(-3Sqrt[(5+Sqrt[5])/10])/2},
{-Sqrt[13+22/Sqrt[5]]/2,-1/2,Root[1-20#1^2+80#1^4&,1,0]},
{-Sqrt[13+22/Sqrt[5]]/2,1/2,Root[1-20#1^2+80#1^4&,1,0]},
{-Sqrt[26+38/Sqrt[5]]/4,(-5-Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
{-Sqrt[26+38/Sqrt[5]]/4,(5+Sqrt[5])/4,Sqrt[1/8+1/(8Sqrt[5])]},
{Sqrt[26+38/Sqrt[5]]/4,(-5-Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]},
{Sqrt[26+38/Sqrt[5]]/4,(5+Sqrt[5])/4,Root[1-20#1^2+80#1^4&,1,0]},
{Sqrt[34+62/Sqrt[5]]/4,(1-Sqrt[5])^(-1),Sqrt[9/8+9/(8Sqrt[5])]},
{Sqrt[34+62/Sqrt[5]]/4,(1+Sqrt[5])/4,Sqrt[9/8+9/(8Sqrt[5])]},
{Sqrt[(5+Sqrt[5])/10],0,Sqrt[25/8+41/(8Sqrt[5])]},
{Root[1-25#1^2+5#1^4&,1,0],-1,Sqrt[1/8+1/(8Sqrt[5])]},
{Root[1-25#1^2+5#1^4&,1,0],1,Sqrt[1/8+1/(8Sqrt[5])]},
{Root[1-5#1^2+5#1^4&,1,0],0,-Sqrt[25/8+41/(8Sqrt[5])]},
{Root[1-5#1^2+5#1^4&,2,0],-2/(-1+Sqrt[5]),Root[1-260#1^2+80#1^4&,1,0]},
{Root[1-5#1^2+5#1^4&,2,0],(1+Sqrt[5])/2,Root[1-260#1^2+80#1^4&,1,0]},
{Root[1-5#1^2+5#1^4&,3,0],-2/(-1+Sqrt[5]),Sqrt[26+58/Sqrt[5]]/4},
{Root[1-5#1^2+5#1^4&,3,0],(1+Sqrt[5])/2,Sqrt[26+58/Sqrt[5]]/4}}

(* Truncated Octahedron *)

PolyhedronName[TruncatedOctahedron]:="truncated octahedron"
PolyhedronDual[TruncatedOctahedron]:=TetrakisHexahedron
NetFaces[TruncatedOctahedron]:={{4,3,6,7},{3,1,2,5,9,6},{10,6,9,13,17,14},{9,8,12,13},{18,17,21,22},{17,13,16,20,26,21},{27,21,26,30,34,31},{26,25,29,30},{35,34,38,39},{34,30,33,37,41,38},{42,38,41,44,46,45},{41,40,43,44},{28,23,27,31,36,32},{16,11,15,19,24,20}}
NetVertices[TruncatedOctahedron]:={{-1,(-1-Sqrt[3])/2},{-1/2,(-1-2Sqrt[3])/2},{-1/2,-1/2},{-1/2,1/2},{1/2,(-1-2Sqrt[3])/2},{1/2,-1/2},{1/2,1/2},{1,(-3-Sqrt[3])/2},{1,(-1-Sqrt[3])/2},{1,(-1+Sqrt[3])/2},{2,(-1-3Sqrt[3])/2},{2,(-3-Sqrt[3])/2},{2,(-1-Sqrt[3])/2},{2,(-1+Sqrt[3])/2},{5/2,(-1-4Sqrt[3])/2},{5/2,(-1-2Sqrt[3])/2},{5/2,-1/2},{5/2,1/2},{7/2,(-1-4Sqrt[3])/2},{7/2,(-1-2Sqrt[3])/2},{7/2,-1/2},{7/2,1/2},{7/2,(-1+2Sqrt[3])/2},{4,(-1-3Sqrt[3])/2},{4,(-3-Sqrt[3])/2},{4,(-1-Sqrt[3])/2},{4,(-1+Sqrt[3])/2},{4,(-1+3Sqrt[3])/2},{5,(-3-Sqrt[3])/2},{5,(-1-Sqrt[3])/2},{5,(-1+Sqrt[3])/2},{5,(-1+3Sqrt[3])/2},{11/2,(-1-2Sqrt[3])/2},{11/2,-1/2},{11/2,1/2},{11/2,(-1+2Sqrt[3])/2},{13/2,(-1-2Sqrt[3])/2},{13/2,-1/2},{13/2,1/2},{7,(-3-Sqrt[3])/2},{7,(-1-Sqrt[3])/2},{7,(-1+Sqrt[3])/2},{8,(-3-Sqrt[3])/2},{8,(-1-Sqrt[3])/2},{8,(-1+Sqrt[3])/2},{17/2,-1/2}}
PolyhedronVertices[TruncatedOctahedron]:=TetrakisHexahedron
PolyhedronFaces[TruncatedOctahedron]:=
{{17,11,9,15},{14,8,10,16},{22,24,21,18},{12,5,2,6},{13,19,23,20},{4,1,3,
    7},{19,13,7,3,8,14},{15,9,4,7,13,20},{16,10,5,12,18,21},{22,18,12,6,11,
    17},{20,23,24,22,17,15},{14,16,21,24,23,19},{9,11,6,2,1,4},{3,1,2,5,10,8}}
PolyhedronVertices[TruncatedOctahedron]:=
{{-3/2,-1/2,0},{-3/2,1/2,0},{-1,-1,-(1/Sqrt[2])},
{-1,-1,1/Sqrt[2]},{-1,1,-(1/Sqrt[2])},
{-1,1,1/Sqrt[2]},{-1/2,-3/2,0},
{-1/2,-1/2,-Sqrt[2]},{-1/2,-1/2,Sqrt[2]},
{-1/2,1/2,-Sqrt[2]},{-1/2,1/2,Sqrt[2]},
{-1/2,3/2,0},{1/2,-3/2,0},{1/2,-1/2,-Sqrt[2]},
{1/2,-1/2,Sqrt[2]},{1/2,1/2,-Sqrt[2]},
{1/2,1/2,Sqrt[2]},{1/2,3/2,0},{1,-1,-(1/Sqrt[2])},
{1,-1,1/Sqrt[2]},{1,1,-(1/Sqrt[2])},
{1,1,1/Sqrt[2]},{3/2,-1/2,0},{3/2,1/2,0}}

(* Truncated Tetrahedron *)

PolyhedronName[TruncatedTetrahedron]:="truncated tetrahedron"
NetFaces[TruncatedTetrahedron]:={{3,1,2,5,8,6},{2,4,5},{9,8,11},{8,5,7,10,12,11},{13,11,12,15,18,16},{12,14,15},{19,18,21},{18,15,17,20,22,21}}
NetVertices[TruncatedTetrahedron]:={{-1,0},{-1/2,-Sqrt[3]/2},{-1/2,Sqrt[3]/2},{0,-Sqrt[3]},{1/2,-Sqrt[3]/2},{1/2,Sqrt[3]/2},{1,-Sqrt[3]},{1,0},{3/2,Sqrt[3]/2},{2,-Sqrt[3]},{2,0},{5/2,-Sqrt[3]/2},{5/2,Sqrt[3]/2},{3,-Sqrt[3]},{7/2,-Sqrt[3]/2},{7/2,Sqrt[3]/2},{4,-Sqrt[3]},{4,0},{9/2,Sqrt[3]/2},{5,-Sqrt[3]},{5,0},{11/2,-Sqrt[3]/2}}
PolyhedronDual[TruncatedTetrahedron]:=TriakisTetrahedron
PolyhedronFaces[TruncatedTetrahedron]:=
{{11,12,8},{3,9,1},{2,10,4},{6,5,7},{11,8,7,5,3,1},{2,4,6,7,8,12},{9,3,5,6,4,
    10},{2,12,11,1,9,10}}
PolyhedronVertices[TruncatedTetrahedron]:=
{{0,-1,-Sqrt[3/2]/2},{0,1,-Sqrt[3/2]/2},
{-(1/Sqrt[3]),-1,1/(2Sqrt[6])},
{-(1/Sqrt[3]),1,1/(2Sqrt[6])},
{-1/(2Sqrt[3]),-1/2,5/(2Sqrt[6])},
{-1/(2Sqrt[3]),1/2,5/(2Sqrt[6])},
{1/Sqrt[3],0,5/(2Sqrt[6])},
{2/Sqrt[3],0,1/(2Sqrt[6])},
{-Sqrt[3]/2,-1/2,-Sqrt[3/2]/2},
{-Sqrt[3]/2,1/2,-Sqrt[3/2]/2},
{Sqrt[3]/2,-1/2,-Sqrt[3/2]/2},
{Sqrt[3]/2,1/2,-Sqrt[3/2]/2}}
  
End[]

(* Protect[  ] *)

EndPackage[]