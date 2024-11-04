(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.02 *)

(*:Name: MathWorld`Chess` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/
*)

(*:Summary:
*)

(*:History:
  v1.00 (2002-03-19): Written in package format.  ChessPieces written.
  v1.01 (2002-04-11): PrivateFontOptions switch added to fix problem with +,=.
                      As a result, ripped out all the hacky code to use
                      placeholders and replace with correct characters later.
  v1.02 (2003-10-18): updated context
  
  (c) 2002-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References: *)

(*:Limitations:

ChessPieces needs to be extended to nxm boards.

*)

BeginPackage["MathWorld`Chess`",
	{
	"Graphics`Colors`"
	}
]

BlackColor::usage =
"BlackColor is an option for ChessBoard."

BlackSquareHack::usage =
"BlackSquareHack is an option for ChessPieces."

ChessBoard::usage =
"ChessBoard[n] gives a graphic representing an nxn chessboard.  Options \
include WhiteColor->color, BlackColor->color, and GridLines->True|False."

ChessBoard3D::usage =
"ChessBoard3D[n] gives a graphic representing a nxn chessboard in relief."

ChessFont::usage =
"ChessFont is an option for ChessPieces."

ChessPieces::usage =
"ChessPieces[string] gives a graphic representing pieces on a normal \
8x8 chessboard.  string is a 64-character string (shorter strings are \
automatically padded) containing the characters for chess pieces in \
the given chess font.  Pieces are automatically converted to upper case \
(assumed to be the version for pieces on a black square) as needed.  \
Options include ChessFont->font."

GridLines::usage =
"GridLines is an option for ChessBoard."

OutputFormat::usage =
"OutputFormat is an option for ChessPieces that takes values \"EPS\" or \
\"Display\"."

WhiteColor::usage =
"WhiteColor is an option for ChessBoard."


Options[ChessBoard]={
	BlackColor->Black,
	WhiteColor->White,
	GridLines->True
};

Options[ChessPieces]={
	(*
	ChessFont->"Chess Alpha",
	ChessFont->"Chess Leipzig"
	*)
	ChessFont->"Chess Leipzig",
	OutputFormat->"EPS"
};

Begin["`Private`"]

ChessBoard[n_Integer?Positive,opts___] := Module[
	{
		i,j,h=1/2,x=n/2,
		gridlines=GridLines/.{opts}/.Options[ChessBoard],
		bcolor=BlackColor/.{opts}/.Options[ChessBoard],
		wcolor=WhiteColor/.{opts}/.Options[ChessBoard],
		grid
	},
	grid=If[gridlines,
		{
		Table[Line[{{i,-x},{i,x}}],{i,-x,x}],
		Table[Line[{{-x,j},{x,j}}],{j,-x,x}]
		},
		{}
	];
	{
     {wcolor,Polygon[{{-x, -x}, {x, -x}, {x, x}, {-x, x}, {-x, -x}}]},
      Table[BlackSquare[h+i+Mod[x+j,2],h+j,1,bcolor],{j,-x,x-1},{i,-x,x-h-Mod[x+j,\
2],2}],
      Line[{{-x, -x}, {x, -x}, {x, x}, {-x, x}, {-x, -x}}],
      grid
	}
]

ChessBoard[opts___]:=ChessBoard[8,opts]

ChessPieces::unknown="Unknown option to OutputFormat."

ChessPieces[str_String,opts___]:=Module[
	{
      rows=PadRight[
          Partition[Characters[str],8,8,{1,1}," "],
          8,{Table[" ",{8}]}],
      boardstr,dx=1,
      font=ChessFont/.{opts}/.Options[ChessPieces],
      format=OutputFormat/.{opts}/.Options[ChessPieces],
      size,
      spacing
    },
    (*Print[rows];*)
    Switch[format,
    	"EPS",Null,
    	"Display",Null,
    	_,Message[ChessPieces::unknown]
    ];
    size=FontSize/.{opts}/.
    	{FontSize->Switch[format,"EPS",28.7,"Display",36]};
    spacing=LineSpacing/.{opts}/.
    	{LineSpacing->{1,Switch[format,"EPS",-.13,"Display",0]}};
    
    boardstr=StringJoin//@(StringJoin[#,"\n"]&/@(StringJoin@@@
                Table[If[Mod[i+j,2]==1,
                        If[#==" "||#==".","+",ToUpperCase[#]],
                        (*ToLowerCase[#]*)
                        If[#==" "||#==".","=",ToLowerCase[#]]
                        ]&@
                    rows[[i,j]],{i,Length[rows]},{j,8}]));
	{
      Text[boardstr,{-4.05,4.05},{-1,1},
        TextStyle->{
        	FontSize->size,
        	FontFamily->font,
       	 PrivateFontOptions->{"OperatorSubstitution"->False},
       	 LineSpacing->spacing
       	 }
      ],
      Table[Line[dx{{i,-4},{i,4}}],{i,-4,4}],
      Table[Line[dx{{-4,i},{4,i}}],{i,-4,4}]
	}
]
    
ChessBoard3D[n_Integer?Positive,opts___]:=Module[{i,j,h=1/2,x=n/2},
	{
	Table[BlackSquare3D[h+i+Mod[x-j,2],h+j,1],{j,-x,x-1},{i,-x,x-1-Mod[j-x,2],2}],
	Table[WhiteSquare3D[h+i-Mod[i+j,2]+1,h+j,1],{j,-x,x-1},{i,-x,x-1-Mod[x+j,2],2}]
	}
]

ChessBoard3D[opts___]:=ChessBoard3D[8,opts]

InversePoint[{x_, y_}, {x0_, y0_}, r_] := {x0, y0} + 
    r^2{x - x0, y - y0}/((x - x0)^2 + (y - y0)^2)

InversePt[{x_, y_}] := .1^2{x, y}/(x^2 + y^2)

BlackSquareInv[x_, y_, n_:15] := 
  Module[{i, h = 1/2}, {GrayLevel[0], 
      Polygon[Map[InversePt, 
          Flatten[{Table[{x - h + i/n, y + h}, {i, 0, n - 1}], 
              Table[{x + h, y + h - i/n}, {i, 0, n - 1}], 
              Table[{x + h - i/n, y - h}, {i, 0, n - 1}], 
              Table[{x - h, y - h + i/n}, {i, 0, n - 1}]}, 1]]]}]

WhiteSquareInv[x_, y_, n_:15] := 
  Module[{i, h = 1/2}, 
    Line[Map[InversePt, 
        Flatten[{Table[{x - h + i/n, y + h}, {i, 0, n - 1}], 
            Table[{x + h, y + h - i/n}, {i, 0, n - 1}], 
            Table[{x + h - i/n, y - h}, {i, 0, n - 1}], 
            Table[{x - h, y - h + i/n}, {i, 0, n - 1}]}, 1]]]]

BlackSquare[x_, y_, n_:15, color_] := 
  Module[{i, h = 1/2}, {color, 
      Polygon[Flatten[{Table[{x - h + i/n, y + h}, {i, 0, n - 1}], 
            Table[{x + h, y + h - i/n}, {i, 0, n - 1}], 
            Table[{x + h - i/n, y - h}, {i, 0, n - 1}], 
            Table[{x - h, y - h + i/n}, {i, 0, n - 1}]}, 1]]}]

WhiteSquare[x_, y_, n_:15,color_] := 
  Module[{i, h = 1/2},{color, 
    Polygon[Flatten[{Table[{x - h + i/n, y + h}, {i, 0, n-1}], 
          Table[{x + h, y + h - i/n}, {i, 0, n-1}], 
          Table[{x + h - i/n, y - h}, {i, 0, n-1}], 
          Table[{x - h, y - h + i/n}, {i, 0, n-1}]}, 1]]}]

add0[l_List] := Append[#,0]&/@l

(*
BlackSquare3D[x_, y_, n_:1] := 
  Module[{},
  {SurfaceColor[Black], Polygon[add0[BlackSquare[x, y, n,Black][[2]] /. Polygon -> Identity]]
  }]
*)

(* 
WhiteSquare3D[x_, y_, n_:1] := 
  Module[{}, {SurfaceColor[White],
  Polygon[add0[WhiteSquare[x, y, n,White][[2]] /. Polygon -> Identity]]
  }]
*)

BlackSquare3D[x_, y_, n_:1] :=
  BlackSquare[x, y, n,Black] /. {
  	Polygon[l_]->Polygon[add0[l]],
  	RGBColor[l__]->SurfaceColor[RGBColor[l]]
  }

WhiteSquare3D[x_, y_, n_:1] := 
  WhiteSquare[x, y, n,White] /. {
  	Polygon[l_]->Polygon[add0[l]],
  	RGBColor[l__]->SurfaceColor[RGBColor[l]]
  }
  
invboard := 
  Module[{i, j, h = 1/2}, 
    Table[BlackSquareInv[h + i + Mod[j, 2], h + j, 10], {j, -4, 3}, {i, -4, \
3,
         2}]]

End[]

EndPackage[]

(* Protect[  ] *)