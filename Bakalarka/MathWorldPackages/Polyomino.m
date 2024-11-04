(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.11 *)

(*:Name: Polyomino` *)

(*:Author: Eric W. Weisstein
   Polyomino enumeration code by Jamie Mondragon-Rangel
*)

(*:URL:
  http://mathworld.wolfram.com/packages/Polyomino.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1998-11-19): Written
  v1.05 (1998-11-22): Added polyhexes
  v1.06 (2000-01-01): Updated URL
  v1.07 (2000-05-15): Made Polyhexes much more elegant.  Also added
                      "Polyhex" to polyhex names.
  v1.08 (2000-05-21): Made Polyominoes more elegant.  Should do the
                      same for polyiamonds and polyominoes.
  v1.10 (2003-05-14): Polyominoes and polyomino-plotting routines added
  v1.11 (2003-10-19): context updated
  
  (c) 1998-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: 
Uses SparseArray and therefore requires v5
*)

(*:Discussion:
*)

(*:References: *)

(*:Limitations: 

This package should be rewritten to use strings instead of symbols
*)


BeginPackage["MathWorld`Polyomino`",
	{
	"LinearAlgebra`MatrixManipulation`",
	"Graphics`Colors`"
	}
]


ArchPolyhex::usage =
"ArchPolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."

Bar::usage =
"Bar[n,{x,y},rot,flip] gives the triangulated form of the n-bar polyiamond."

BarPoliamond::usage =
"BarPoliamond[n,{x,y},rot,flip] gives the outline of the n-bar polyiamond."

BarPolyhex::usage =
"BarPolyhex[n,{x,y},rot,flip] gives the outline of this n-polyhex."

BeePolyhex::usage =
"BeePolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."

Butterfly::usage =
"Butterfly[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

butterfly::usage =
"butterfly[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Chevron::usage =
"Chevron[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

chevron::usage =
"chevron[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Crook::usage =
"Crook[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

crook::usage =
"crook[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Crown::usage =
"Crown[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

crown::usage =
"crown[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Fixed::usage =
"Type->Fixed is a option in Polyominoes."

Free::usage =
"Type->Free is a option in Polyominoes."

Hexagon::usage =
"Hexagon[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

hexagon::usage =
"hexagon[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Hook::usage =
"Hook[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

hook::usage =
"hook[{x,y},rot,flip] gives the outline of this 6-polyiamond."

LineStyle::usage =
"LineStyle is an option to Polyhex which specified how to render internal \
boundaried."

Lobster::usage =
"Lobster[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

lobster::usage =
"lobster[{x,y},rot,flip] gives the outline of this 6-polyiamond."

LPolyomino::usage =
"LPolyomino[n,x]."

OneSided::usage =
"Type->OneSided is a option in Polyominoes."

Pentominoes::usage =
"Pentominoes gives a list of the free pentominoes in alphabetical order: \
f, I, L, N, P, T, U, V, W, X, y, and Z."

PistolPolyhex::usage =
"PistolPolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."

Polyhex::usage =
"Polyhex[l] gives a polyhex traced out by the path l, where l is a list \
of directions from 1 (up-right) to 6 (down-right) in clockwise order.  \
Polyhex[l,{x,y},rot,flip,LineStyle->...] can also be specified. \
Polyhex[1,1], Polyhex[2,1], Polyhex[3,1], Polyhex[3,2], and Polyhex[3,3] \
give the unnamed kth n-polyhex."

Polyiamond::usage =
"Polyiamond[string,{x,y},rot,flip] gives a triangulated form the \
polyiamond defined by the string."

PolyiamondEdge::usage =
"PolyiamondEdge[string,{x,y},rot,flip] gives the outline of the \
polyiamond defined by the string."

Polyomino::usage =
"Polyomino[string,{x,y},rot,flip] gives the outline of the polyomino \
defined by the string, which may containe e|f, w|b, n|u, s|d."

PolyominoArray::usage =
"PolyominoArray[polys,n] produces a matrix of 1s and 0s consisting of the \
polyominoes represented by the given list, partitioned into n per row, \
and arranged so that polyominoes are stacked by row and column."

Polyominoes::usage =
"Polyominoes[n] gives a complete list of distinct n-polyominoes represented as \
a list of coordinates of the constituent squares and with the lower-left corner \
assigned position {0,0}."

PolyominoPlot::usage =
"PolyominoPlot"

PropellerPolyhex::usage =
"PropellerPolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."

Signpost::usage =
"Signpost[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

signpost::usage =
"signpost[{x,y},rot,flip] gives the outline of this 6-polyiamond."

SkewPolyomino::usage =
"SkewPolyomino[n,x]."

Snake::usage =
"Snake[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

snake::usage =
"snake[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Sphinx::usage =
"Sphinx[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

sphinx::usage =
"sphinx[{x,y},rot,flip] gives the outline of this 6-polyiamond."

Square::usage =
"Square[{x,y}] gives a square."

SquarePolyomino::usage =
"SquarePolyomino[n,x]."

StraightPolyomino::usage =
"StraightPolyomino[n,x]."

TPolyomino::usage =
"TPolyomino[n,x]."

Type::usage =
"Type is an option to Polyominoes that specified the sort to generate.  Possibilities \
include Fixed and Free."

Yacht::usage =
"Yacht[{x,y},rot,flip] gives the triangulated form of this 6-polyiamond."

yacht::usage =
"yacht[{x,y},rot,flip] gives the outline of this 6-polyiamond."

WavePolyhex::usage =
"WavePolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."

WormPolyhex::usage =
"WormPolyhex[{x,y},rot,flip] gives the outline of this 4-polyhex."


Options[Polyhex]={LineStyle->{}};
Options[Polyominoes]:={
	Type->Free
};


Begin["`Private`"]

(* Setup *)

line[p_List]:=Line[Join[p,{p[[1]]}]]

lineSegments[l_List]:=Line/@Sort/@Partition[l,2,1]

Pentominoes:={
      (* f *) {{1,0},{2,0},{0,1},{1,1},{1,2}},
      (* I *) {{0,0},{0,1},{0,2},{0,3},{0,4}},
      (* L *) {{0,0},{0,1},{0,2},{0,3},{1,3}},
      (* N *) {{1,0},{0,1},{1,1},{0,2},{0,3}},
      (* P *) {{0,0},{1,0},{0,1},{1,1},{0,2}},
      (* T *) {{0,0},{1,0},{2,0},{1,1},{1,2}},
      (* U *) {{0,0},{2,0},{0,1},{1,1},{2,1}},
      (* V *) {{0,0},{0,1},{0,2},{1,2},{2,2}},
      (* W *) {{0,0},{0,1},{1,1},{1,2},{2,2}},
      (* X *) {{1,0},{0,1},{1,1},{2,1},{1,2}},
      (* y *) {{1,0},{0,1},{1,1},{1,2},{1,3}},
      (* Z *) {{0,0},{1,0},{1,1},{1,2},{2,2}}
}

(* Polyhexes *)

hex[l_,o_,rot_,f_]:=Module[
	{
		i,
		m={{1,0},{0,f}}.{{Cos[rot],-Sin[rot]},{Sin[rot],Cos[rot]}}
	},
	Line[Table[o+m.(l+{Cos[#],Sin[#]})&[2Pi i/6],{i,0,6}]]
]

Polyhex[l_List]:=Polyhex[l,{0,0},0,1]

Polyhex[l_List,o_List]:=Polyhex[l,o,0,1]

Polyhex[l_List,o_List,rot_,f_,opts___]:=Module[
	{
		style=LineStyle/.{opts}/.Options[Polyhex],
		p,v,segs
	},
	p=Union[
		hex[#,o,rot,f]&/@FoldList[Plus,{0,0},
			Function[v,Sqrt[3]{Cos[v],Sin[v]}][2Pi (#-1/2)/6]&/@l]
	];
	If[style=={},Return[p]];
	segs=Split[Sort[Flatten[p/.Line:>lineSegments]]];
	If[style==None,Return[Flatten[Select[segs,Length[#]==1&]]]];
	{Flatten[Select[segs,Length[#]==1&]],
		Sequence@@style,First/@Select[segs,Length[#]>1&]
	}
]

Polyhex[1,1,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{},o,r,f,opts]
Polyhex[2,1,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1},o,r,f,opts]
Polyhex[3,1,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,5},o,r,f,opts]
Polyhex[3,2,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{6,1},o,r,f,opts]
Polyhex[3,3,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,1},o,r,f,opts]

Polyhex[1,1,o_:{0,0},r_:0,f_:1]:=Polyhex[{},o,r,f]
Polyhex[2,1,o_:{0,0},r_:0,f_:1]:=Polyhex[{1},o,r,f]
Polyhex[3,1,o_:{0,0},r_:0,f_:1]:=Polyhex[{1,5},o,r,f]
Polyhex[3,2,o_:{0,0},r_:0,f_:1]:=Polyhex[{6,1},o,r,f]
Polyhex[3,3,o_:{0,0},r_:0,f_:1]:=Polyhex[{1,1},o,r,f]

BeePolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,5,1},o,r,f,opts] 
BarPolyhex[n_,o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[Table[1,{n-1}],o,r,f,opts]
PistolPolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{6,2,1},o,r,f,opts]
PropellerPolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,2,5,6},o,r,f,opts] 
WormPolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,1,2},o,r,f,opts]
ArchPolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{1,6,5},o,r,f,opts]
WavePolyhex[o_:{0,0},r_:0,f_:1,opts__Rule]:=Polyhex[{6,1,6},o,r,f,opts]

BeePolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{1,5,1},o,r,f] 
BarPolyhex[n_,o_:{0,0},r_:0,f_:1]:=Polyhex[Table[1,{n-1}],o,r,f]
PistolPolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{6,2,1},o,r,f]
PropellerPolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{1,2,5,6},o,r,f] 
WormPolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{1,1,2},o,r,f]
ArchPolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{1,6,5},o,r,f]
WavePolyhex[o_:{0,0},r_:0,f_:1]:=Polyhex[{6,1,6},o,r,f]

(* Polyiamond *)

Polyiamond[s_String,o_:{0,0},rot_:0,f_:1]:=Module[{i,p={},r=o,
	m={{Cos[rot],Sin[rot]},{-Sin[rot],Cos[rot]}}},
	Do[
		Switch[StringTake[s,{i}],
			"u",AppendTo[p,{r,r+m.{1,f Sqrt[3]}/2,r+m.{1,0}}];r+=m.{1,0},
			"d",AppendTo[p,{r,r+m.{-1,f Sqrt[3]}/2,r+m.{1,f Sqrt[3]}/2}],
			(*flip up*)
			"f",AppendTo[p,{r+m.{-1,f Sqrt[3]}/2,r+m.{1,f Sqrt[3]}/2,r+m.{0,f Sqrt[3]}}]; 
        		r+=m.{1,f Sqrt[3]}/2, 
        	(*flip down*)
			"g",AppendTo[p,{r-m.{1,f Sqrt[3]}/2,r-m.{1,0},r}];r-=m.{1,f Sqrt[3]}/2, 
			(*flip from up to down point-to-point*)
			"p",AppendTo[p,{r+m.{-1,f Sqrt[3]},r+m.{-1,f Sqrt[3]}/2,r+m.{0,f Sqrt[3]}}];r+=m.{-1,f Sqrt[3]}/2 
		],
		{i,StringLength[s]}
	];
	Union[Table[line[Sort[p[[i]]]],{i,Length[p]}]]
]

PolyiamondEdge[s_String,o_:{0,0},rot_:0,f_:1]:=Module[{i,p={o},r=o,
	m={{Cos[rot],Sin[rot]},{-Sin[rot],Cos[rot]}}},
	Do[
		AppendTo[p,p[[-1]]+Switch[StringTake[s,{i}],
			"f",m.{1,0},
			"1",m.{1,f Sqrt[3]}/2,
			"2",m.{-1,f Sqrt[3]}/2,
			"b",m.{-1,0},
			"3",m.{-1,-f Sqrt[3]}/2,
			"4",m.{1,-f Sqrt[3]}/2]],
	{i,StringLength[s]}];
	Line[p]
]

Bar[1,o_:{0,0},r_:0,f_:1]:=Polyiamond["u",o,r,f]

Bar[2,o_:{0,0},r_:0,f_:1]:=Polyiamond["ud",o,r,f]

Bar[n_Integer?EvenQ /; n>=3,o_:{0,0},r_:0,f_:1]:=Module[{i,s=""},
		Do[s=s<>"ud",{i,n/2}];
		Polyiamond[s,o,r,f]
]

Bar[n_Integer?OddQ /; n>=3,o_:{0,0},r_:0,f_:1]:=Module[{i,s=""},
		Do[s=s<>"ud",{i,n/2}];
		Polyiamond[s<>"u",o,r,f]
]

bar[6,o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["fff1bbb3",o,r,f]

Crook[o_:{0,0},r_:0,f_:1]:=Polyiamond["ugdudud",o,r,f]
		
crook[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ff1bb234",o,r,f]
				
Crown[o_:{0,0},r_:0,f_:1]:=Polyiamond["dudfgud",o,r,f]

crown[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ff1b23b4",o,r,f]
		
Sphinx[o_:{0,0},r_:0,f_:1]:=Polyiamond["udfgudu",o,r,f]

sphinx[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["fff2b233",o,r,f]
		
Snake[o_:{0,0},r_:0,f_:1]:=Polyiamond["dfdudf",o,r,f]

snake[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["1f123b34",o,r,f]
		
Yacht[o_:{0,0},r_:0,f_:1]:=Polyiamond["udfgudf",o,r,f]

yacht[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ff123233",o,r,f]
		
Chevron[o_:{0,0},r_:0,f_:1]:=Polyiamond["ududfd",o,r,f]

chevron[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ff11b3b3",o,r,f]
	
SignPost[o_:{0,0},r_:0,f_:1]:=Polyiamond["dfdfgud",o,r,f]

signpost[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["1f1b2334",o,r,f]
		
Lobster[o_:{0,0},r_:0,f_:1]:=Polyiamond["dfdfgug",o,r,f]

lobster[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["14122334",o,r,f]

Hook[o_:{0,0},r_:0,f_:1]:=Polyiamond["udfdug",o,r,f]

hook[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["f1412b33",o,r,f]

Hexagon[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ugupug",o,r,f]

hexagon[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["f12b34",o,r,f]

Butterfly[o_:{0,0},r_:0,f_:1]:=Polyiamond["upugup",o,r,f]

butterfly[o_:{0,0},r_:0,f_:1]:=PolyiamondEdge["ff21bb43",o,r,f]

(* This code by Jamie Rangel-Mondrag\[OAcute]n *)

r[square_] := ({{0, -1}, {1, 0}} . #1 + {-1, 0} & )/@ square
f[square_] := ({-1 - #1[[1]], #1[[2]]} & ) /@ square

cyclic[polyomino_]:=FixedPointList[r,polyomino,3]

dihedral[polyomino_]:=Union[Flatten[{#,f[#]}& /@ cyclic[polyomino],1]]

canonical[polyomino_]:=Module[{u=Sort[polyomino]},
    (#-First[u])& /@ u]

allPieces[polyomino_]:=Union[canonical /@ dihedral[polyomino]]
allPieces[polyomino_,Type->Free]:=Union[canonical /@ dihedral[polyomino]]
allPieces[polyomino_,Type->Fixed]:=Union[canonical /@ {polyomino}]
allPieces[polyomino_,Type->OneSided]:=Union[canonical /@ cyclic[polyomino]]

draw[polyomino_]:=
  Graphics[Map[({{RGBColor[0,0.5,0.5],Polygon[{#,#+{1,0},#+{1,1},#+{0,1}}]},
            Line[{#,#+{1,0},#+{1,1},#+{0,1},#}]})&,polyomino],
    DisplayFunction\[Rule]Identity,AspectRatio\[Rule]Automatic]

Polyominoes[1,opts___]:={{{0,0}}}
Polyominoes[n_,opts___]:=Polyominoes[n,opts]=Module[
	{ans={},ans2,u={1,0},v={0,1},figure,type},
	type=Type/.{opts}/.Options[Polyominoes];
      Map[(
            figure=#;
            Map[(
                  AppendTo[ans,Join[figure,{#+u}]]; 
                  AppendTo[ans,Join[figure,{#+v}]]; 
                  AppendTo[ans,Join[figure,{#-u}]]; 
                  AppendTo[ans,Join[figure,{#-v}]])&,figure])&,
        Polyominoes[n-1,Type->type]]; 
      ans=Select[canonical /@ Union /@  ans,(Length[#]==n)&];
      ans2={};
      While[ans!={},
        AppendTo[ans2,First[ans]];
        ans=Complement[ans,allPieces[First[ans],Type->type]]];
      ans2]

(* EWW *)

PolyominoArray[l_]:=PolyominoArray[l,Length[l]]
PolyominoArray[l_,n_,pad_:1]:=Module[{p,off,v,dim,heights,widths},
    p=Partition[l,n,n,{1,1},{{}}];
    off=Map[{pad+1,pad+1-Min[Last/@#]}&,p,{2}];
    v=MapThread[Function[{f,g},g+#&/@f],{p,off},2];
    dim=Map[Max/@If[#=={},{0,0},Transpose[#]]&,v,{2}];
    heights=Max/@Map[Last,dim,{2}];
    widths=Max/@Map[First,Transpose[dim],{2}];
    BlockMatrix[
      MapIndexed[
        Transpose@
            Normal[SparseArray[#1,
                Function[{h,w},{widths[[w]],heights[[h]]}][Sequence@@#2]]]&,
        Map[#->1&,v,{3}],{2}]
      ]
    ]

PolyominoPlot[m_List?MatrixQ,opts___]:=
  Module[{ones=Reverse/@Position[Reverse[m],1]},Show[Graphics[{
          {Red,Polygon[{#,#+{1,0},#+{1,1},#+{0,1},#}]&/@ones},
          Line[{#,#+{1,0},#+{1,1},#+{0,1},#}]&/@ones
          }],opts,AspectRatio->Automatic]
    ]

(* Polyominoes *)

Polyomino[l_List]:=Polyomino[l,{0,0},0]

Polyomino[l_List,o_List,rot_,opts___]:=Module[
	{
		style=LineStyle/.{opts}/.Options[Polyhex],
		p,v,segs
	},
	p=Union[
		Square[#,o,rot]&/@FoldList[Plus,{0,0},
			Function[v,{Cos[v],Sin[v]}][2Pi(#-1)/4]&/@l]
	];
	If[style=={},Return[p]];
	segs=Split[Sort[Flatten[p/.Line:>lineSegments]]];
	If[style==None,Return[Flatten[Select[segs,Length[#]==1&]]]];
	{Flatten[Select[segs,Length[#]==1&]],
		Sequence@@style,First/@Select[segs,Length[#]>1&]
	}
]

Square[{x_,y_},o_,rot_]:=Line[{{x,y},{x+1,y},{x+1,y+1},{x,y+1},{x,y}}]

LPolyomino[n_,x_]:=Module[{i},
	{Table[Square[{x,i}],{i,n-1}],Square[{x+1,1}]}
] /; n>=3

SkewPolyomino[n_,x_]:=Module[{i},
	Table[{Square[{x+i,1}],Square[{x+2n-i,0}]},{i,n}]
]

SquarePolyomino[n_,x_]:=Module[{i,j},
	Table[Square[{i+x,j}],{i,n},{j,n}]
]

StraightPolyomino[n_,o_:{0,0}]:=Polyomino[Table[1,{n-1}]]

TPolyomino[n_,x_]:=Module[{i},
	{Table[Square[{x+1,i}],{i,n-2}],Table[Square[{x+i,n-2}],{i,0,2}]}
] /; n>=4

End[]

(* Protect[  ] *)

EndPackage[]