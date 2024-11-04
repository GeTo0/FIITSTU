(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.07 *)

(*:Name: MathWorld`Figurate` *)

(*:Author: Eric Weisstein 
           Some portions written by Robert Dickau
*)

(*:URL:
  http://mathworld.wolfram.com/packages/Figurate.m
*)

(*:Summary:
*)

(*:Requirements:
*)

(*:Limitations:
*)

(*:History:
	v1.01: (Apr  2, 2002) Routines from IntegerSequences moved here
	v1.02: (May 20, 2002) Extraneous Integer?Positive patterns removed
	                      StarNumber[n] redefined so that StarNumber[1]=1
    v1.03: (Aug 14, 2003) Replaced a few occurrences of pi with Pi.  Added
                          CubicNumber, HexNumber
    v1.04: (Sep  3, 2003) SquareQ
    v1.05: (Oct 18, 2003) updated context
    v1.06: (Nov 30, 2003) Polygonal
    v1.07: (May 30, 2006) PolygonalDiagram now colorized
                          
(c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:

*)

(*:Limitations:

Code should be cleaned up slightly
 
*)


BeginPackage["MathWorld`Figurate`"]

CenteredCubicDiagram::usage = 
"CenteredCubicDiagram[n] gives a Graphics3D \
object corresponding to the nth centered cubic number."

CenteredPolygonalDiagram::usage =
"CenteredPolygonalDiagram[n,m] gives a \
Graphics object corresponding to the mth centered n-gonal number."

CubicDiagram::usage = 
"CubicDiagram[n] gives a Graphics3D object corresponding to the \
nth cubic number."

CubicNumber::usage =
"CubicNumber[n] gives the nth cubic number."

HauyRhombicDodecahedralNumber::usage =
"HauyRhombicDodecahedralNumber[n] gives the nth Hauy \
rhombic dodecahedral number."

HauyOctahedralNumber::usage =
"HauyOctahedralNumber[n] gives the nth Hauy octahedral number."

HeptagonalNumber::usage =
"HeptagonalNumber[n] gives the nth heptagonal number."

HeptagonalQ::usage =
"HeptagonalQ[n] returns True if n is heptagonal."

HexagonalNumber::usage =
"HexagonalNumber[n] gives the nth hexagonal number."

HexagonalQ::usage =
"HexagonalQ[n] returns True if n is hexagonal."

HexNumber::usage =
"HexNumber[n] gives the nth hex number."

LineStyle::usage =
"LineStyle is an option to PolygonDiagram."

NonagonalNumber::usage =
"NonagonalNumber[n] gives the nth nonagonal number."

NonagonalQ::usage =
"NonagonalQ[n] returns True if n is nonagonal."

OblongNumber::usage =
"OblongNumber[n] gives the nth oblong number."

OctagonalNumber::usage =
"OctagonalNumber[n] gives the nth octagonal number."

OctagonalQ::usage =
"OctagonalQ[n] returns True if n is octagonal."

OctahedralNumber::usage =
"OctahedralNumber[n] gives the nth octahedral number."

PentagonalNumber::usage =
"PentagonalNumber[n] gives the nth pentagnal number."

PentagonalQ::usage =
"PentagonalQ[n] returns True if n is pentagonal."

PentatopeNumber::usage =
"PentatopeNumber[n] gives the nth pentatope number."

PointStyle::usage =
"PointStyle is an option to PolygonDiagram."

Polygonal::usage =
"Polygonal[r,n] gives the rth n-gonal number."

PolygonalDiagram::usage =
"PolygonalDiagram[n,m] gives a Graphics object corresponding to the mth \
n-gonal number."

PronicNumber::usage =
"PronicNumber[n] gives the nth pronic number."

PyramidalNumber::usage =
"PyramidalNumber[n] gives the nth pyramidal number."

RhombicDodecahedralNumber::usage =
"RhombicDodecahedralNumber[n] gives the nth rhombic dodecahedral number."

SquarePyramidalNumber::usage =
"SquarePyramidalNumber[n] gives the nth square pyramidal number."

SquareQ::usage =
"SquareQ[n] returns True if n is square."

SquareTriangular::usage =
"SquareTriangular[n,Method->method] gives the nth square triangular number. \
Options are Method->Power, Method->Rounded."

StarNumber::usage =
"StarNumber[n] gives the nth star number."

StellaOctangulaNumber::usage =
"StellaOctangularNumber[n] gives the nth stella octangular number."

SquareNumber::usage =
"SquareNumber[n] gives the nth square number."

TetrahedralNumber::usage =
"TetrahedralNumber[n] gives the nth tetrahedral number."

TetrahedralQ::usage =
"TetrahedralQ[n] returns True if n is a tetrahedral number."

TriangularNumber::usage =
"TriangularNumber[n] gives the nth triangular number."

TriangularQ::usage =
"TriangularQ[n] returns True if n is a triangular number."

TruncatedOctahedralNumber::usage =
"TruncatedOctahedralNumber[n] gives the nth truncated octahedral number."

TruncatedTetrahedralNumber::usage =
"TruncatedTetrahedralNumber[n] gives the nth tetrahedral octahedral number."


Options[SquareTriangular]={Method->Power}

Options[PolygonalDiagram] = {
	PointStyle->{PointSize[.05]},
	LineStyle->{}
};

Begin["`Private`"]


(* Centered Cubic Diagram *)

ccubedots[n_] := 
  Table[Point[{i - (n + 1)/2, j - (n + 1)/2, k - (n + 1)/2}], {i, n}, {j, 
      n}, {k, n}]

ccubedotsarray[n_] := Table[ccubedots[k], {k, n}]
ccube[k_] := 
  Module[{n = (k - 1)/
          2}, {Line[{{-n, n, -n}, {n, n, -n}, {n, -n, -n}, {-n, -n, -n}, {-n, 
            n, -n}}], 
      Line[{{-n, n, n}, {n, n, n}, {n, -n, n}, {-n, -n, n}, {-n, n, n}}], 
      Line[{{-n, -n, -n}, {-n, -n, n}}], Line[{{-n, n, -n}, {-n, n, n}}], 
      Line[{{n, -n, -n}, {n, -n, n}}], Line[{{n, n, -n}, {n, n, n}}]}]
ccubearray[n_] := Table[ccube[k], {k, n}]

CenteredCubicDiagram[n_] := 
  Graphics3D[{PointSize[.05], ccubedotsarray[n], ccubearray[n]}]

(* Centered Polygonal Numbers *)

cvertex[n_, i_, m_] := m Csc[Pi/2]/2 {Cos[2Pi i/n], Sin[2Pi i/n]}
cdots[n_, 0] := Point[{0, 0}]
cdots[n_, m_] := 
  Table[Point[
      cvertex[n, i, m] - j/m(cvertex[n, i, m] - cvertex[n, i - 1, m])], {j,
       m}, {i, n}]
cpolygon[n_, m_] := Line[Table[cvertex[n, i, m], {i, 0, n}]]

CenteredPolygonalDiagram[n_, m_] := 
  Graphics[{PointSize[.05], Table[{cdots[n, i], cpolygon[n, i]}, {i, 0, m}]}]

(* Cubic Diagram *)

cubedots[n_] := 
  Table[Point[{i, j, k}], {i, n}, {j, n}, {k, n}]
cube2[k_] := 
  Table[{Line[{{1, n, 1}, {n, n, 1}, {n, 1, 1}, {1, 1, 1}, {1, n, 1}}], 
      Line[{{1, n, n}, {n, n, n}, {n, 1, n}, {1, 1, n}, {1, n, n}}], 
      Line[{{1, 1, 1}, {1, 1, n}}], Line[{{1, n, 1}, {1, n, n}}], 
      Line[{{n, 1, 1}, {n, 1, n}}], Line[{{n, n, 1}, {n, n, n}}]}, {n, k}]
      
CubicDiagram[n_] := Graphics3D[{PointSize[.05], cubedots[n], cube2[n]}]

(* Cubic Number *)

CubicNumber[n_]:=n^3

(* Hauy Octahedral Number *)

HauyOctahedralNumber[n_]:=(2n-1)(2n^2-2n+3)/3

(* Hauy Rhombic Dodecahedral Number *)

HauyRhombicDodecahedralNumber[n_]:=(2n-1)(8n^2-14n+7)

(* Hex Number *)

HexNumber[n_]:=3n^2+3n+1

(* Heptagonal Number *)

HeptagonalNumber[n_]:=n(5n-3)/2

HeptagonalQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==HeptagonalNumber[n],n],IntegerQ[#] && \
Positive[#]&]]==1
]

(* Hexagonal Number *)

HexagonalNumber[n_]:=n(2n-1)

HexagonalQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==HexagonalNumber[n],n],IntegerQ[#] && \
Positive[#]&]]==1
]

(* Nonagonal Number *)

NonagonalNumber[n_]:=n(7n-5)/2

NonagonalQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==NonagonalNumber[n],n],IntegerQ[#] && \
Positive[#]&]]==1
]

(* Oblong Number *)

OblongNumber[n_]:=n(n+1)

(* Octagonal Number *)

OctagonalNumber[n_]:=n(3n-2)

OctagonalQ[x_]:=Module[{n},
	Length[Select[n /.Solve[x==OctagonalNumber[n],n],IntegerQ[#] && \
Positive[#]&]]==1
]

(* Octahedral Number *)

OctahedralNumber[n_]:=n(2n^2+1)/3

(* Pentagonal Number *)

PentagonalNumber[n_]:=n(3n-1)/2

PentagonalQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==PentagonalNumber[n],n],IntegerQ[#] && \
Positive[#]&]]==1
]

(* Pentatope Number *)

PentatopeNumber[n_]:=n(n+1)(n+2)(n+3)/24

(* Polygonal Number *)

Polygonal[r_,n_:3]:=r((n-2)r-(n-4))/2

(* Robert Dickau code, I believe *)

vertex[n_, i_, m_] := m Csc[Pi/2]/2 {Cos[2Pi i/n] - 1, Sin[2Pi i/n]} // N

maindots[n_, m_] := Table[vertex[n, i, m], {i, n - 1}]

subdots[n_, m_] := Module[{i, j},
    Flatten[Table[vertex[n, i, m] - j/m(vertex[n, i, m] - vertex[n, i - 1, m]), {j, m - 1}, {i, 2, n - 1}], 1]
]

dots[n_, m_] := {maindots[n, m], subdots[n, m]}

polygon[n_, m_] := Module[{i},Line[Table[vertex[n, i, m], {i, 0, n}]]]

PolygonalDiagram[n_, m_, opts___] := Module[{i}, {
      Table[polygon[n, i], {i, 0, m - 1}],
      PointSize[.1],
      Table[{Hue[i/10], Point /@ Flatten[dots[n, i], 1]}, {i, 0, m - 1}],
      MapIndexed[
  Text[#2[[1]], #1] &, Union[Sequence @@ Table[Flatten[
      dots[n, i], 1], {i, 0, m - 1}]]]
      }
]

(* Polyhedral Diagram *)

PolyhedralDiagram[n_] := 
  Module[{m, i, h = Sqrt[6]/3}, 
    Table[{Hue[1 - .93m/n], 
        Table[dots[n, i] /. 
            Point[{x_, y_}] :> Point[{x + m Csc[Pi/2]/2, y, (n - m) h}], {i, 
            0, m}], Line[
          Table[{Cos[2Pi i/n]m/2, Sin[2Pi i/n]m/2, (n - m)h}, {i, 0, 
              n}]]}, {m, 0, n}]]

(* Pronic Number *)

PronicNumber[n_]:=n(n+1)

(* Rhombic Dodecahedral Number *)

RhombicDodecahedralNumber[n_]:=(2n-1)(2n^2-2n+1)

(* Square Number *)

SquareNumber[n_]:=n^2

SquareQ[n_]:=IntegerQ[Sqrt[n]]

(* Square Pyramidal Number *)

SquarePyramidalNumber[n_]:=n(n+1)(2n+1)/6

(* Square Triangular *)

SquareTriangularNumber[n_,opts___]:=Module[
  {
    meth=Method/.{opts}/.Options[SquareTriangular]
  },
  Switch[meth,
    Power,   Round[((1+Sqrt[2])^(2n)-(1-Sqrt[2])^(2n))/(4 Sqrt[2])//N]^2,
    Rounded, Expand[((17+12Sqrt[2])^n+(17-12Sqrt[2])^n-2)/32],
    Product, Simplify[2^(2n-5) Product[3+Cos[k Pi/n],{k,2n}]]
  ]
]

(* Star Number *)

StarNumber[n_]:=6n^2-6n+1

(* Stella Octangular Number *)

StellaOctangulaNumber[n_]:=n(2n^2-1)

(* Tetrahedral *)

TetrahedralNumber[n_]:=n(n+1)(n+2)/6

TetrahedralQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==n(n+1)(n+2)/6,n],IntegerQ[#] && Positive[#]&]]==1
]

(* Triangular Number *)

TriangularNumber[n_]:=n(n+1)/2

TriangularQ[x_Integer?Positive]:=Module[{n},
	Length[Select[n /.Solve[x==n(n+1)/2,n],IntegerQ[#] && Positive[#]&]]==1
]

(* Truncated Octahedral Number *)

TruncatedOctahedralNumber[n_]:=16n^3-33n^2+24n-6

(* Truncated Tetrahedral Number *)

TruncatedTetrahedralNumber[n_]:=n(23n^2-27n+10)/6

End[]

(* Protect[ ] *)

EndPackage[]