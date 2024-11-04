(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.10 *)

(*:Name: MathWorld`CellularAutomata` *)

(*:Author: Eric W. Weisstein 

*)

(*:URL:
  http://mathworld.wolfram.com/packages/CellularAutomata.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2002-09-05): Package created
  v1.01 (2002-09-12): Rewrote RasterGraphics and add translation/scaling for
                      ElementaryCARule, added ElementaryCADiagram
  v1.02 (2002-09-13): ElementaryCATriangle, TotalisticCARules,
                      TotalisticCellularAutomaton
  v1.03 (2002-11-05): Life
  v1.04 (2003-01-22): Fixed typo in Life; added ColorFunctionScaling->False
                      to RasterGraphics
  v1.05 (2003-01-29): Added BlockSize to PixelPerfect
  v1.06 (2003-02-28): Disable scaling and explicit flipping of data in PixelPerfect
  v1.07 (2003-05-04): Moved PixelPerfect and RasterGraphics to Plot.m
  v1.08 (2003-10-18): updated context
  v1.09 (2005-03-15): Exported Panel and changed RasterGraphics to ArrayPlot
  v1.10 (2006-04-12): ElementaryCAVariants
  
  (c) 2002-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:

Utility routines for cellular automata

*)

(*:References: *)

(*:Limitations: None known. *)

BeginPackage["MathWorld`CellularAutomata`",
	{
	"Utilities`FilterOptions`"
	}
]

ElementaryCADiagram::usage =
"ElementaryCADiagram[r,n,<opts>] generates a diagram for elementary CA rule r.  \
If not specified, n=15 generations are assumed."

ElementaryCAVariants::usage =
"ElementaryCAVariants[n] gives the rule numbers of variants of the given rule \
in the order {mirror, complemented, mirrored and complemented}."

ElementaryCARuless::usage =
"ElementaryCARules[rule] creates a rule diagram for the specified elementary \
CA rule.  ElementaryCARules[rule,pos] places the diagram at position pos.  \
ElementaryCARules[rule,pos,scale] first scales the diagram then repositions it."

ElementaryCATriangle::usage =
"ElementaryCATriangle[r,n] gives n rows of the triangle of numbers produced by \
the rule r elementary cellular automaton."

ElementaryCellularAutomaton::usage =
"ElementaryCellularAutomaton[rule,n] computes the specified rule elementary CA \
for n generations."

Life::usage =
"Life[m,g] gives g steps of the Life CA with initial condition given by \
the binary matrix m.  Life[m,{g1,g2}] gives steps g1 to g2.  The algorithm \
used is the built-in CellularAutomaton command."

Panel::usage =
"Panel[l,b,pos] gives a panel showing the result of a CA rule l that gives \
a color b (0|1) and placed at position pos."

TotalisticCARules::usage =
"TotalisticCARules[code] creates a rule diagram for the specified totalistic \
CA rule."

TotalisticCellularAutomaton::usage =
"TotalisticCellularAutomaton[c,n,i] gives n steps of totalistic cellular \
automaton code c with starting color i."

Begin["`Private`"]

ElementaryCellularAutomaton[r_, n_:256] := 
  CellularAutomaton[r, {{1}, 0}, n, {All, All}]

square[pos_, r_:.9] := pos + # & /@ ({{-1, -1}, {1, -1}, {1, 1}, {-1, 1}}r/2)
square[1, pos_, r_:.9] := Polygon[square[pos, r]]
square[0, pos_, r_:.9] := Line[Append[#, First[#]] &@square[pos, r]]
square[c_,pos_,r_:.9]:={{GrayLevel[1-c],square[1,pos,r]},square[0,pos,r]}

rectangle[pos_,r_:.9]:=pos+#&/@({{-3,-1},{3,-1},{3,1},{-3,1}}r/2)
rectangle[1,pos_,r_:.9]:=Polygon[rectangle[pos,r]]
rectangle[0,pos_,r_:.9]:=Line[Append[#,First[#]]&@rectangle[pos,r]]
rectangle[c_,pos_,r_:.9]:={{GrayLevel[1-c],rectangle[1,pos,r]},
    rectangle[0,pos,r]}

Panel[l_, b_, pos_] := Module[{sc = .8},
    {
      Table[square[l[[i]], sc{i - 2, 0} + {3pos, -1/2}, .9sc], {i, 3}],
      square[b, sc{0, -1} + {3 pos, -1/2}, .9sc],
      Line[{3pos, -1/2sc} + # & /@ ( {{-3, -3}, {3, -3}, {3, 1}, {-3, 
                  1}, {-3, -3}}/2)],
      Text[ToString[b], {3pos, -2.5}]
      }
    ]

ElementaryCADiagram[r_,n_Integer:15,opts___]:=Show[{
    Block[{$DisplayFunction=Identity},ArrayPlot[ElementaryCellularAutomaton[r,n],Mesh->True]],
    Graphics[ElementaryCARules[r,{-2,21},1.3]]
    },PlotRange->All,
    opts,
  	ImageSize->350,
 	PlotLabel->StyleForm["rule "<>ToString[r],FontFamily->"Times",FontSize->14,
      FontSlant->"Italic"]]

ElementaryCAMirrored[n_]:=FromDigits[IntegerDigits[n,2,8][[{1,5,3,7,2,6,4,8}]],2]
ElementaryCAComplemented[n_]:=FromDigits[1-Reverse[IntegerDigits[n,2,8]],2]
ElementaryCAVariants[n_]:={ElementaryCAMirrored[n],ElementaryCAComplemented[n],
  ElementaryCAMirrored[ElementaryCAComplemented[n]]}

ElementaryCARules[rule_] := 
  Panel @@@ 
    Transpose[{Flatten[Outer[List, Sequence @@ Table[{1, 0}, {3}]], 2], 
        IntegerDigits[rule, 2, 8], Range[8]}
      ]

ElementaryCARules[n_,pos_,sc_:1]:=
  ElementaryCARules[n]/.{
      Text[t_,p_]:>Text[t,sc p+pos],
      Line[l_List]:>Line[sc #+pos&/@l],
      Polygon[l_List]:>Polygon[sc #+pos&/@l]
      }

ElementaryCATriangle[r_,n_]:=Module[{e=ElementaryCellularAutomaton[r,n],i},
    Table[Take[e[[i+1]],n+1+{-1,1}i],{i,0,n}]
]
(* MapIndexed[Take[#1,n+#2[[1]]{-1,1}+{2,0}]&,ElementaryCellularAutomaton[r,n]] *)

(* rule 224, 2-colors, rules with weights {{2,2,2},{2,1,2},{2,2,2}} *)

Life[m_List?MatrixQ,{g1_Integer?NonNegative,g2_Integer?NonNegative}]:=
  CellularAutomaton[{224,{2,{{2,2,2},{2,1,2},{2,2,2}}},{1,1}},
  {m,0},g2,{{g1,g2},Automatic}] /; g2>=g1

Life[m_List?MatrixQ,g1_Integer:1]:=Life[m,{0,g1}] /; NonNegative[g1]

Panel2[l_,b_,pos_]:=Module[{sc=.8},
    {
      rectangle[l,sc{0,0}+{3pos,-1/2},.9sc],
      square[b,sc{0,-1}+{3 pos,-1/2},.9sc],
      Line[{3pos,-1/2sc}+#&/@( {{-3,-3},{3,-3},{3,1},{-3,1},{-3,-3}}/2)],
      Text[ToString[2b],{3pos,-2.5}]
      }
    ]

TotalisticCARules[l_]:=Module[{n,d=IntegerDigits[l,3,7]},
    Table[Panel2[(6-n)/6,d[[n+1]]/2,n],{n,0,6}]
    ]

TotalisticCellularAutomaton[r_,n_:256,i_:1]:=
  CellularAutomaton[{r,{3,1}},{{i},0},n,{All,All}]

End[]

EndPackage[]

(* Protect[  ] *)