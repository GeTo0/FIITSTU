(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.01 *)

(*:Name: MathWorld`Polygons` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Polygons.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2005-02-15): Written
  v1.01 (2006-04-19): tridecagon
  
  (c) 2005-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`Polygons`"]


PolygonName::usage =
"PolygonName[n] gives the name of the n-gon."

PolygonalName::usage =
"PolygonalName[n] gives the name of the n-gonal."

Begin["`Private`"]

PolygonName[3]:="triangle"
PolygonName[4]:="square"
PolygonName[5]:="pentagon"
PolygonName[6]:="hexagon"
PolygonName[7]:="heptagon"
PolygonName[8]:="octagon"
PolygonName[9]:="nonagon"
PolygonName[10]:="decagon"
PolygonName[11]:="undecagon"
PolygonName[12]:="dodecagon"
PolygonName[13]:="tridecagon"
PolygonName[14]:="tetradecagon"
PolygonName[15]:="pentadecagon"
PolygonName[16]:="hexadecagon"
PolygonName[17]:="heptadecagon"
PolygonName[18]:="octadecagon"
PolygonName[19]:="nonadecagon"
PolygonName[20]:="icosagon"

PolygonalName[3]:="triangular"
PolygonalName[4]:="square"
PolygonalName[5]:="pentagonal"
PolygonalName[6]:="hexagonal"
PolygonalName[7]:="heptagonal"
PolygonalName[8]:="octagonal"
PolygonalName[9]:="nonagonal"
PolygonalName[10]:="decagonal"
PolygonalName[11]:="undecagonal"
PolygonalName[12]:="dodecagonal"
PolygonalName[13]:="tridecagonal"
PolygonalName[14]:="tetradecagonal"
PolygonalName[15]:="pentadecagonal"
PolygonalName[16]:="hexadecagonal"
PolygonalName[17]:="heptadecagonal"
PolygonalName[18]:="octadecagonal"
PolygonalName[19]:="nonadecagonal"
PolygonalName[20]:="icosagonal"

End[]

EndPackage[]

(* Protect[  ] *)