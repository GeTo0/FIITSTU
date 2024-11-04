(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.71 *)

(*:Name: MathWorld`MagicSquares` *)

(*:Author: 
  Algorithms and code by Eric W. Weisstein
  
  Methods due to J.H. Conway, math-fun e-mail 11/3/97
  
  Magic squares of order 4 obtained from Heinz, H.  "Downloads."
    http://www.geocities.com/~harveyh/downloads.htm
  
  Magic cubes from
    http://www.multimagie.com/English/Cube.htm

*)

(*:URL:
  http://mathworld.wolfram.com/packages/MagicSquares.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (1997-11-03): into the wee hours of 11-04; Written
  v1.10 (1997-11-05): added Origin, Ordinary, and Break options for Siamese method
                      added SumDiffs
  v1.20 (1997-12-01): added Border, BorderQ, NestedBorderQ
  v1.30 (1998-03-07): added AdditionMultiplicationMagicQ,
                      ColProds, MultiplicationMagicQ, RowProds
  v1.40 (1998-03-08): added HeterosquareSums, HeterosquareQ,
                      AntimagicQ, TalismanDiffs, Talisman,
                      fixed ColSums/Prods, RowSums/Prods
  v1.45 (1998-03-26): corrected MagicQ to SemiMagicQ,
                      added correct MagicQ
  v1.46 (1998-08-03): AssociativeQ, HalfToursPlot,
                      MagicCubePlot, PerfectMagicQ,
                      SemiperfectMagicQ, TourPlot
  v1.50 (1998-05-28): Magic Circle routines
  v1.51 (1999-09-01): AntimagicSquarePlot
  v1.52 (2000-01-01): URL updated
  v1.53 (2000-05-21): MagicSquarePlot extended to plot grids for rectangles
  v1.54 (2002-05-25): Fixed documentation for MagicQ, added continuation characters
                      to usage messages
  v1.55 (2002-11-03): Spelling of AntimagicSquarePlot corrected
  v1.56 (2003-03-14): MagicSquares[n] added
  v1.57 (2003-08-08): Suppress Showing of MagicSquarePlot and TourPlot.
                      Renamed SemimagicQ.  Added BimagicQ, MultimagicQ,
                      CanonicalizeArray.
  v1.58 (2003-10-19): updated contexts
  v1.60 (2003-11-17): Added perfect magic cubes, changed syntaxes
  v1.61 (2003-11-18): Added PerfectMagicCubes[6]
  v1.62 (2003-11-19): Added bimagic cubes, trimagic cube, corrected PerfectMagicQ,
                      cleaned up MagicConstant
  v1.63 (2003-11-20): defined more multimagic squares
  v1.64 (2003-11-29): Added all order-3 semiperfect cubes, PandiagonalPerfectMagicQ
  v1.65 (2003-12-03): Added MagicCube[256]
  v1.66 (2003-12-03): Using some idea from Michael Trott, greatly increased the
                      efficiency and reduced the memory requirements for PerfectMagicQ
                      and SemiperfectMagicQ (at the price of slighly more repetitive
                      code syntax)
  v1.67 (2003-12-06): Implemented procedural versions of PerfectMagicQ and 
                      SemiperfectMagicQ so I can handle Boyer's 256-trimagic cube
  v1.68 (2004-01-18): PerfectMagicSquares[9]
  v1.69 (2004-03-04): DuerersMagicSquare, fixed PanmagicQ
  v1.70 (2005-09-20): Context corrected from MagicSquare to MagicSquares
  v1.71 (2005-11-28): Fixed AdditionMultiplicationQ

  (c) 1997-2007 Eric W. Weisstein
*)

(*:Keywords:
  magic squares, magic cubes, multimagic squares, multimagic cubes
*)

(*:Requirements:

To list some magic squares of order, you need to download and install the
files in

   http://mathworld.wolfram.com/packages/MagicSquares/
   
*)

(*:Discussion:
*)

(*:References: *)

(*:Limitations:  

The MagicSquare construction code is procedural and ugly and should
be rewritten

*)

BeginPackage["MathWorld`MagicSquares`",{"Utilities`FilterOptions`"}]

AdditionMultiplicationMagicQ::usage =
"AdditionMultiplicationMagicQ[array] returns True if all rows and columns \
have the same product and sum."

AndrewsCubeQ::usage =
"AndrewsCubeQ[array] returns True if array is an Andrews (semiperfect) \
magic cube."

AntimagicQ::usage =
"AntimagicQ[array] returns True if array is an antimagic square."

AntimagicSquarePlot::usage =
"AntimagicSquarePlot[array] plots the antimagic square and the \
sums corresponding to list."

AssociativeQ::usage =
"AssociativeQ[array] returns True if array is an associative square."

BimagicQ::usage =
"BimagicQ[a] returns True if a and a^2 are both magic."

Border::usage =
"Border[array,n:1] returns a list with the outer n rings removed."

BorderQ::usage =
"BorderQ[array] returns True if list and Border[list] are magic squares."

Break::usage =
"An option for the Siamese method."

CanonicalizeArray::usage =
"CanonicalizeArray[array] returns the lexigraphically smallest form of \
array via rotation and reflection."

ColProds::usage =
"ColProds[array] gives the products of the columns of list."

ColSums::usage =
"ColSums[array] gives the sum of the columns of list."

DiagSums::usage =
"DiagSums[array] gives the sum of the diagonals of list."

Diamond::usage =
"Method for odd magic squares."

DiskStyle::usage =
"DiskStyle is an option to specify the style used for the disks in TourPlot."

DuerersMagicSquare::usage =
"DuerersMagicSquare gives the ordering of the unique magic square of \
order 4 appearing in Albrecht D\[UDoubleDot]rer's _Melancholia_ engraving."

HalfToursPlot::usage =
"HalfToursPlot[array] connects consecutive numbers in the two halves \
of the array array."

HeterosquareQ::usage =
"HeterosquareQ[array] returns True if array is a heterosquare."

HeterosquareSums::usage =
"HeterosquareSums[array] gives the row, column, and main diagonal \
sums of list."

MagicCircle::usage =
"MagicCircle[{c,{r1,...,rn}}] plots a magic circle."

LineStyle::usage =
"LineStyle is an option to specify the style used for the lines in TourPlot."

Loops::usage =
"Method->Loops is an option for PerfectMagicQ and SemiperfectMagicQ."

MagicCircleQ::usage =
"MagicCircleQ[{c,{r1,...,rn}}] returns True if the given expression is \
a magic circle."

MagicCircleSums::usage =
"MagicCircleSums[{c,{r1,...,rn}}] gives the circumferential and diameter \
sums."

MagicConstant::usage =
"MagicConstant[n] returns the magic constant of a normal order n magic square.  \
MagicConstant[d,n] returns the magic constant of a normal order n magic \
d-hypercube."

MagicQ::usage =
"MagicQ[array] returns True if all rows, columns, and main \
diagonals of a magic square.  For a magic cube, use PerfectMagicQ \
or SemiperfectMagicQ."

MagicSquare::usage =
"MagicSquare[n] returns an array containing a magic square of order n.  \
For odd n, options are Method->Siamese (default) or Method->Diamond.  \
For Method->Siamese, additional options are Origin->{x0,y0}, \
Ordinary->{x,y}, and Break->{u,v}"

MagicSquarePlot::usage =
"MagicSquarePlot[array] plots the magic square corresponding to list."

MagicSquares::usage =
"MagicSquares[n] gives a list of all magic squares of order n for n = 3 \
or 4."

MultimagicQ::usage =
"MultimagicQ[a,p] returns True if a, a^2, ..., a^p are all magic."

MultiplicationMagicQ::usage =
"MultiplicationMagicQ[array] returns True if all rows and columns \
have the same product."

NestedBorderQ::usage =
"NestedBorderQ[array] returns True if list is magic and all squares \
obtained by reoving succesive borders are also magic."

Ordinary::usage =
"An option for the Siamese method."

Origin::usage =
"An option for the Siamese method."

PandiagonalPerfectMagicQ::usage =
"PandiagonalPerfectMagicQ[array] returns True if array is a \
pandiagonal perfect magic cube."

PandiagonalSemiperfectMagicQ::usage =
"PandiagonalSemiperfectMagicQ[array] returns True if array is a \
pandiagonal semiperfect magic cube."

PanmagicQ::usage =
"PanmagicQ[array] returns True if all diagonals of list are the same."

PerfectMagicCubes::usage =
"PerfectMagicCubes[n] gives a list of perfect magic cubes of order n."

PerfectMagicQ::usage =
"PerfectMagicQ[array] returns True if array is a perfect magic cube.  \
PerfectMagicQ[array,Method->Loops] uses sum loops instead of Plus@@Table \
to conserve memory for large arrays."

PointStyle::usage =
"PointStyle is an option to specify the style used for the points in TourPlot."

RotationReflectionQ::usage =
"RotationReflectionQ[x,y] returns True if x and y can be transformed into \
one another by rotations and reflections."

RowProds::usage =
"RowProds[array] gives the products of the rows of list."

RowSums::usage =
"RowSums[array] gives the sum of the rows of list."

SemimagicQ::usage =
"SemimagicQ[array] returns True if all rows and columns have the \
same sum."

SemiperfectMagicQ::usage =
"SemiperfectMagicQ[array] returns True if array is a semiperfect (Andrews) \
magic cube."

SemiperfectMagicCubes::usage =
"SemiperfectMagicCubes[n] gives a list of semiperfect magic cubes \
of order n.  SemiperfectMagicQ[array,Method->Loops] uses sum loops instead \
of Plus@@Table to conserve memory for large arrays."

Siamese::usage =
"Method for odd magic squares."

SumDiffs::usage =
"SumDiffs[{x,y},{u,v}] gives the absolute sums and differences of the \
coordinates (x,y) and (x-u,y-v)."

Talisman::usage =
"Talisman[array] returns the order of a Talisman square \
(or 0 if array is not a Talisman square)."

TalismanDiffs::usage =
"TalismanDiffs[array] gives the differences of neighboring \
entries in array."

TourPlot::usage =
"TourPlot[array] connects consecutive numbers in the array array."

Options[MagicSquare]={
	Method->Siamese,
	Origin->{0,0},
	Ordinary->{1,-1},
	Break->{0,1}
};

Options[TourPlot]={
	LineStyle->Red,
	DiskStyle->Red,
	PointStyle->None
};


Begin["`Private`"]

$path="/Volumes/Data/Mathematica/Packages/MathWorld/MagicSquares";



AdditionMultiplicationMagicQ[list_List]:=MultiplicationMagicQ[list] &&
  MagicQ[list]
  
AndrewsCubeQ[m_List]:=SemiperfectMagicQ[m]

AntimagicQ[list_List]:=Module[{h=Flatten[HeterosquareSums[list]],hs},
  hs=Sort[h];
  (HeterosquareQ[list] && (hs[[-1]]-hs[[1]]+1==Length[h]))
]

AntimagicSquarePlot[list_List,opts___]:=
	Module[{i,j,n=Length[list],h=HeterosquareSums[list]},
	Show[Graphics[{
          Table[{Line[{{0,i},{n,i}}],Line[{{i,0},{i,n}}]},{i,0,n}],
          Table[Text[ToString[list[[i,j]]],{j-.5,(n-i+1)-.5}],{i,n},{j,n}],
          Table[Text["= "<>ToString[h[[1,i]]],{n+.5,i-.5}],{i,n}],
          Table[Text["\[DoubleVerticalBar]",{i-.5,-.2}],{i,n}],
          Table[Text[ToString[h[[2,i]]],{i-.5,-.5}],{i,n}],
          Text[ToString[h[[3,1]]],{n+.5,-.5}],
          Text[" "<>ToString[h[[3,2]]],{n+.5,n+.5}]
          }],opts,AspectRatio->Automatic]
]

AssociativeQ[{{1}}]:=True
AssociativeQ[l_List?MatrixQ]:=Module[{i,j,n=Length[l]},
	(Length[Union[Apply[Plus,
	Flatten[Table[{l[[i,j]],l[[n-i+1,n-j+1]]},{i,n-1},{j,n-i+1}],1],2]]]==1)
]

BimagicQ[a_List?ArrayQ]:=MultimagicQ[a,2]

Border[square_List,1]:=Border[square]
Border[square_List]:=Module[{len=Length[square]},
  Transpose[Take[Transpose[Take[square,{2,len-1}]],{2,len-1}]]
]
Border[square_List,0]:=square
Border[square_List,n_Integer?Positive]:=Nest[Border,square,n]
BorderQ[square_List]:=(MagicQ[square] && MagicQ[Border[square]])
NestedBorderQ[square_List]:=Module[{sq=square},
  While[Length[sq]>1 && MagicQ[sq=Border[sq]]];
  Length[sq]==1
]

CanonicalizeArray[x_]:=Module[{r,t},
    Sort[{x,Reverse[x],r=Reverse/@x,Reverse[r],t=Transpose[x],Reverse[t],
        r=Reverse/@t,Reverse[r]}][[1]]
]

(*
ColProds[list_List]:=Apply[Times,list]

ColSums[list_List]:=Apply[Plus,list]

DiagSums[list_List]:=Module[{n=Length[list],i,j},
  a=Table[Sum[list[[Mod[j,n]+1,Mod[i+j,n]+1]],{j,0,n-1}],{i,0,n-1}];
  b=Table[Sum[list[[Mod[j,n]+1,Mod[i-j,n]+1]],{j,0,n-1}],{i,0,n-1}];
  {a,b}
]
*)

(* DuerersMagicSquare *)

DuerersMagicSquare:={{16,3,2,13},{5,10,11,8},{9,6,7,12},{4,15,14,1}}

HalfToursPlot[k_List,opts___]:=Module[{i,len=Length[k]},
	Show[Graphics[{
		{Red,
		Line[Table[xypos[i,k],{i,len^2/2}]],
		Line[Table[xypos[i,k],{i,len^2/2+1,len^2}]],
		Disk[xypos[1,k],.3],Disk[xypos[len^2/2,k],.3],
		Disk[xypos[len^2/2+1,k],.3],Disk[xypos[len^2,k],.3]
		},
		MagicSquarePlot[k,DisplayFunction->Identity][[1]]
		}],
		opts,AspectRatio->Automatic,DisplayFunction->$DisplayFunction]
]

(* Heterosquare *)

HeterosquareQ[list_List]:=Module[{l=Flatten[HeterosquareSums[list]],n},
	n=Length[l];
	Length[Union[l]]==n
]

HeterosquareSums[list_List]:=
	{RowSums[list],ColSums[list],MainDiagSums[list]}

(* Magic Circles *)

MagicCircle::DifferentLengths=
"The rings in the specified magic circle do not have the same lengths";

bullet[r_,fn_,val_]:=Module[{c=r{Cos[2Pi fn],Sin[2Pi fn]},R=.3},
	{{GrayLevel[.7],Disk[c,R]},Circle[c,R],Text[val,c]}]

wbullet[r_,fn_,val_]:=Module[{c=r{Cos[2Pi fn],Sin[2Pi fn]},R=.3},
	{{GrayLevel[1],Disk[c,R]},Circle[c,R],Text[val,c]}]

MagicCircle[c_Integer?Positive,l_List /; Length[Union[Length/@Drop[l,1]]]>1]:=
    Message[MagicCircle::DifferentLengths];

MagicCircle[l0_List,opts___]:=Module[{r,n,i,k,l=Drop[l0,1],c=l0[[1]]},
	r=Length[l];
	n=Length[l[[1]]];
	Show[Graphics[{
		Table[Line[{{0,0},r{Cos[2Pi k/n],Sin[2Pi k/n]}}],{k,0,n-1}],
		wbullet[0,0,c],
		Table[{Circle[{0,0},i],Table[bullet[i,k/n,l[[i,k+1]]],{k,0,n-1}]},{i,r}]},
	opts,AspectRatio->Automatic]]
]

MagicCircleQ[c_Integer?Positive,l_List/; Length[Union[Length/@Drop[l,1]]]>1]:=
	Message[MagicCircle::DifferentLengths];

MagicCircleQ[l_List]:=Module[{j=Sort[Flatten[l]]},
	(Length[Union[Flatten[MagicCircleSums[l]]]]==1 && j==Range[Max[j]])
]

MagicCircleSums[l0_List]:=Module[{l=Drop[l0,1],i,n},
	t=Transpose[l];
	n=Length[t]/2;
	{Apply[Plus,l,1],Table[Plus@@t[[i]]+Plus@@t[[i+n]],{i,n}]}
]

(* Magic Square Constants *)

MagicConstant[d_,n_]:=n(n^d+1)/2
MagicConstant[n_]:=MagicConstant[2,n]

MagicQ[l_List?MatrixQ]:=Equal@@Flatten[
	{
	Plus@@@l,
	Plus@@@Transpose[l],
	Tr[l],
	Tr[Reverse/@l]
	}
] /; Equal@@Dimensions[l]

(*
MagicQ[list_List /; Depth[list]==3]:=Module[{a,b,c},
  {a,b,c}={RowSums[list],ColSums[list],MainDiagSums[list]};
  (Length[Union[a,b,c]]==1)
]
*)

MagicSquare[n_Integer?OddQ]:=MagicSquare[n,Method->Siamese]

MagicSquare[n_Integer?OddQ,opts___]:=Module[
  {a=Table[0,{n},{n}],j,i,it,
   diag,start=1,i0,j0,meth,odi,odj,bdi,bdj},
  meth=Method/.{opts}/.Options[MagicSquare];
  {odj,odi}=Ordinary/.{opts}/.Options[MagicSquare];
  {bdj,bdi}=Break/.{opts}/.Options[MagicSquare];
  {i0,j0}=Origin/.{opts}/.Options[MagicSquare];
  If[{i0,j0}=={0,0},j0=(n-1)/2-odj;i0=-odi,j0-=odj;i0-=odi];
  Switch[meth,Siamese,
    j=j0;i=i0;
    Do[
      j=Mod[j+odj,n];
      i=Mod[i+odi,n];
      If[a[[i+1,j+1]]!=0,
        i=Mod[i+bdi-odi,n];
        j=Mod[j+bdj-odj,n];
      ];
      a[[i+1,j+1]]=it,
      {it,1,n^2}
    ]; a,
  Diamond,
    i=(n-1)/2;j=0;
    a[[i+1,j+1]]=1;
    Do[
      j++;i--;
      If[j-i>(n-1)/2,
        i0=i+3;j0=j-2;
        i0=i+(n+1)/2;j0=j-(n-1)/2;
        Do[
        i=Mod[i,n];j=Mod[j,n];
          a[[i+1,j+1]]=k;
          i=Mod[i-1,n];
          j=Mod[j+1,n],
          {k,start+(-1)^(1+Mod[start,n]),start+(n+3)/2,2}
        ];
        i=i0;j=j0;start=diag;
      ];
      If[diag<=n^2,a[[i+1,j+1]]=diag], (* skip the last time to avoid overwriting *)
      {diag,3,n^2+2,2}
    ]; a
  ]
]

MagicSquare[n_Integer]:=Module[{a,i,j,nsq=n^2+1},
  a=Table[i+n(j-1),{j,n},{i,n}];
  Do[
    a[[i,j]]=nsq-a[[i,j]];
    a[[i,j+3]]=nsq-a[[i,j+3]];
    a[[i+1,j+1]]=nsq-a[[i+1,j+1]];
    a[[i+1,j+2]]=nsq-a[[i+1,j+2]];
    a[[i+2,j+1]]=nsq-a[[i+2,j+1]];
    a[[i+2,j+2]]=nsq-a[[i+2,j+2]];
    a[[i+3,j]]=nsq-a[[i+3,j]];
    a[[i+3,j+3]]=nsq-a[[i+3,j+3]],
    {j,1,n,4},{i,1,n,4}
  ];
  a
] /; Mod[n,4]==0

MagicSquare[2]:=$DoesNotExist
MagicSquarePlot[2]:=$DoesNotExist

MagicSquare[nn_Integer]:=Module[{n=nn/2,m=(nn/2-1)/2,a,a4,i,j,lux},
  a4=MagicSquare[n];
  a=Table[0,{nn},{nn}];
  lux=Join[Table["L",{m+1},{2m+1}],Table["U",{1},{2m+1}],Table["X",{m-1},{2m+1}]];
  lux[[m+2,m+1]]="L";
  lux[[m+1,m+1]]="U";
  b[j_,i_]:=4(a4[[j,i]]-1);
  Do[
    Switch[lux[[i,j]],
      "L",a[[2i-1,2j  ]]=b[i,j]+1; a[[2i,  2j-1]]=b[i,j]+2;
          a[[2i  ,2j  ]]=b[i,j]+3; a[[2i-1,2j-1]]=b[i,j]+4;
      "U",a[[2i-1,2j-1]]=b[i,j]+1; a[[2i,  2j-1]]=b[i,j]+2;
          a[[2i  ,2j  ]]=b[i,j]+3; a[[2i-1,2j  ]]=b[i,j]+4;
      "X",a[[2i-1,2j-1]]=b[i,j]+1; a[[2i  ,2j  ]]=b[i,j]+2;
          a[[2i,  2j-1]]=b[i,j]+3; a[[2i-1,2j  ]]=b[i,j]+4;
    ],
    {j,n},{i,n}
  ];
  a
] /; Mod[nn,4]==2

(* Magic Squares *)

(**** BEGIN MAGIC SQUARES ****)

MagicSquares[1]:={{{1}}}
MagicSquares[2]:={}
MagicSquares[3]:={MagicSquare[3]}
MagicSquares[n_Integer?Positive]:=(MagicSquares[n]=
	Get[ToFileName["MagicSquares","MagicSquares"<>ToString[n]<>".m"]]) /; n==4
MagicSquares[8]:={
	(* Pfefferman 1891 *)
	{
	{56,34,8,57,18,47,9,31},
	{33,20,54,48,7,29,59,10},
	{26,43,13,23,64,38,4,49},
	{19,5,35,30,53,12,46,60},
	{15,25,63,2,41,24,50,40},
	{6,55,17,11,36,58,32,45},
	{61,16,42,52,27,1,39,22},
	{44,62,28,37,14,51,21,3}
	},
	(* somebody else's *)
    {
	{16,41,36,5,27,62,55,18},
	{26,63,54,19,13,44,33,8},
	{1,40,45,12,22,51,58,31},
	{23,50,59,30,4,37,48,9},
	{38,3,10,47,49,24,29,60},
	{52,21,32,57,39,2,11,46},
	{43,14,7,34,64,25,20,53},
	{61,28,17,56,42,15,6,35}
	}
}

MagicSquares[9]:={
	(* Pfefferman Les Tablettes du Chercheur, on July 15 1891 *)
	{
	{22,3,81,42,34,47,17,59,64},
	{37,54,15,71,76,57,32,20,7},
	{33,38,8,55,72,77,52,13,21},
	{68,73,43,12,26,4,63,51,29},
	{2,16,58,46,41,36,24,66,80},
	{53,31,19,78,56,70,39,9,14},
	{61,69,30,5,10,27,74,44,49},
	{75,62,50,25,6,11,67,28,45},
	{18,23,65,35,48,40,1,79,60}
	}
}

(* trimagic; Walter Trump *)
MagicSquares[12]:={
	{
	{1,22,33,41,62,66,79,83,104,112,123,144},
	{9,119,45,115,107,93,52,38,30,100,26,136},
	{75,141,35,48,57,14,131,88,97,110,4,70},
	{74,8,106,49,12,43,102,133,96,39,137,71},
	{140,101,124,42,60,37,108,85,103,21,44,5},
	{122,76,142,86,67,126,19,78,59,3,69,23},
	{55,27,95,135,130,89,56,15,10,50,118,90},
	{132,117,68,91,11,99,46,134,54,77,28,13},
	{73,64,2,121,109,32,113,36,24,143,81,72},
	{58,98,84,116,138,16,129,7,29,61,47,87},
	{80,34,105,6,92,127,18,53,139,40,111,65},
	{51,63,31,20,25,128,17,120,125,114,82,94}
	}
}

(* tetramagic; Christian Boyer *)
MagicSquares[512]:={Get["MagicSquare512.m",Path->$path]}

(* pentamagic; Li Wen *)
MagicSquares[729]:={Get["MagicSquare729.m",Path->$path]}

(* pentamagic; Christian Boyer *)
MagicSquares[1024]:={Get["MagicSquare1024.m",Path->$path]}

(**** END MAGIC SQUARES ****)


MagicSquarePlot[list_List?MatrixQ,opts___?OptionQ]:=Module[
	{i,j,n=Length[list],m=Length[list[[1]]]},
  Graphics[{
    Table[Line[{{0,i},{m,i}}],{i,0,n}],
    Table[Line[{{i,0},{i,n}}],{i,0,m}],
    Table[Text[ToString[list[[i,j]]],{j-.5,(n-i+1)-.5}],{i,n},{j,m}]
  },
  opts,AspectRatio->Automatic]
]

(*
MainDiagSums[list_List]:=Module[{n=Length[list]},
  {Sum[list[[i,i]],{i,n}],Sum[list[[i,n-i+1]],{i,n}]}
]
*)

MultiplicationMagicQ[list_List]:=
	Equal@@Flatten[Times@@@{boyer,Transpose[boyer]}]

MultimagicQ[a_List?ArrayQ,p_Integer]:=
  MagicQ/@And@@FoldList[Times,a,Table[a,{p-1}]] /; p>1

PandiagonalPerfectMagicQ[m_]:=PandiagonalMagicQ[m,PerfectMagicQ]
PandiagonalSemiperfectMagicQ[m_]:=PandiagonalMagicQ[m,SemiperfectMagicQ]

PandiagonalMagicQ[m_,op_]:=Module[{n=Length[m]},
	op[m]&&
	op/@And@@NestList[Map[RotateLeft,#,{2}]&,m,n-1]&&
	op/@And@@NestList[RotateLeft/@#&,m,n-1]&&
	op/@And@@NestList[RotateLeft,m,n-1]
]

PanmagicQ[{{1}}]:=True
PanmagicQ[m_List?MatrixQ]:=Equal@@Join[
	{Tr[m],Tr[Reverse/@m]},
	Plus@@@m,
	Plus@@@Transpose[m],
	Plus@@@Transpose[MapIndexed[RotateRight[#1,#2[[1]]]&,Transpose[m]]],
	Plus@@@Transpose[MapIndexed[RotateLeft[#1,#2[[1]]]&,m]]
]

(* Perfect Magic Cubes *)

(* found by Christian Boyer and Walter Trump (Nov 14, 2003)  *)
PerfectMagicCubes[5]:={{
      {{25,16,80,104,90},{115,98,4,1,97},{42,111,85,2,75},{66,72,27,102,
          48},{67,18,119,106,5}},{{91,77,71,6,70},{52,64,117,69,13},{30,118,
          21,123,23},{26,39,92,44,114},{116,17,14,73,95}},{{47,61,45,76,
          86},{107,43,38,33,94},{89,68,63,58,37},{32,93,88,83,19},{40,50,81,
          65,79}},{{31,53,112,109,10},{12,82,34,87,100},{103,3,105,8,96},{113,
          57,9,62,74},{56,120,55,49,35}},{{121,108,7,20,59},{29,28,122,125,
          11},{51,15,41,124,84},{78,54,99,24,60},{36,110,46,22,101}}
      }}

(* due to Trumpler *)
PerfectMagicCubes[6]:={
{{{109,143,76,123,88,112},{87,156,49,170,63,126},{140,174,52,150,53,82},{75,
      66,182,51,139,138},{136,40,148,65,176,86},{104,72,144,92,132,
      107}},{{137,48,157,68,158,83},{155,2,198,27,207,62},{34,187,212,13,22,
      183},{147,32,1,208,193,70},{44,213,23,186,12,173},{134,169,60,149,59,
      80}},{{103,101,159,36,119,133},{162,196,201,8,29,55},{46,206,28,197,3,
      171},{163,15,191,18,210,54},{93,17,14,211,192,124},{84,116,58,181,98,
      114}},{{90,56,57,184,175,89},{118,21,16,209,188,99},{180,11,189,20,214,
      37},{64,202,26,199,7,153},{71,200,203,6,25,146},{128,161,160,33,42,
      127}},{{102,178,117,95,38,121},{50,215,19,190,10,167},{120,30,5,204,195,
      97},{111,185,216,9,24,106},{172,4,194,31,205,45},{96,39,100,122,179,
      115}},{{110,125,85,145,73,113},{79,61,168,47,154,142},{131,43,165,67,
      164,81},{91,151,35,166,78,130},{135,177,69,152,41,77},{105,94,129,74,
      141,108}}}
}

PerfectMagicCubes[7]:={
{{{327,41,98,99,156,213,270},{52,109,166,223,280,330,44},{169,226,283,340,5,
      62,119},{293,301,8,65,122,179,236},{18,75,132,189,239,247,304},{135,192,
      200,257,314,28,78},{210,260,317,31,88,145,153}},{{113,170,227,284,341,6,
      63},{237,294,295,9,66,123,180},{305,19,76,133,183,240,248},{79,136,193,
      201,258,315,22},{154,204,261,318,32,89,146},{271,328,42,92,100,157,
      214},{45,53,110,167,224,274,331}},{{249,306,20,77,127,184,241},{23,80,
      137,194,202,259,309},{147,148,205,262,319,33,90},{215,272,329,36,93,101,
      158},{332,46,54,111,168,218,275},{57,114,171,228,285,342,7},{181,238,
      288,296,10,67,124}},{{91,141,149,206,263,320,34},{159,216,273,323,37,94,
      102},{276,333,47,55,112,162,219},{1,58,115,172,229,286,343},{125,182,
      232,289,297,11,68},{242,250,307,21,71,128,185},{310,24,81,138,195,203,
      253}},{{220,277,334,48,56,106,163},{337,2,59,116,173,230,287},{69,126,
      176,233,290,298,12},{186,243,251,308,15,72,129},{254,311,25,82,139,196,
      197},{35,85,142,150,207,264,321},{103,160,217,267,324,38,95}},{{13,70,
      120,177,234,291,299},{130,187,244,252,302,16,73},{198,255,312,26,83,140,
      190},{322,29,86,143,151,208,265},{96,104,161,211,268,325,39},{164,221,
      278,335,49,50,107},{281,338,3,60,117,174,231}},{{191,199,256,313,27,84,
      134},{266,316,30,87,144,152,209},{40,97,105,155,212,269,326},{108,165,
      222,279,336,43,51},{225,282,339,4,61,118,175},{300,14,64,121,178,235,
      292},{74,131,188,245,246,303,17}}}
}

PerfectMagicCubes[8]:={
	(* Frankenstein *)
	{
	{{19,497,255,285,432,78,324,162},{303,205,451,33,148,370,128,414},{336,174,
      420,66,243,273,31,509},{116,402,160,382,463,45,291,193},{486,8,266,236,
      89,443,181,343},{218,316,54,472,357,135,393,107},{185,347,85,439,262,
      232,490,12},{389,103,361,139,58,476,214,312}},{{134,360,106,396,313,219,
      469,55},{442,92,342,184,5,487,233,267},{473,59,309,215,102,392,138,
      364},{229,263,9,491,346,188,438,88},{371,145,415,125,208,302,36,
      450},{79,429,163,321,500,18,288,254},{48,462,196,290,403,113,383,
      157},{276,242,512,30,175,333,67,417}},{{306,212,478,64,141,367,97,
      387},{14,496,226,260,433,83,349,191},{109,399,129,355,466,52,318,
      224},{337,179,445,95,238,272,2,484},{199,293,43,457,380,154,408,
      118},{507,25,279,245,72,422,172,330},{412,122,376,150,39,453,203,
      297},{168,326,76,426,283,249,503,21}},{{423,69,331,169,28,506,248,
      278},{155,377,119,405,296,198,460,42},{252,282,24,502,327,165,427,
      73},{456,38,300,202,123,409,151,373},{82,436,190,352,493,15,257,
      227},{366,144,386,100,209,307,61,479},{269,239,481,3,178,340,94,
      448},{49,467,221,319,398,112,354,132}},{{381,159,401,115,194,292,46,
      464},{65,419,173,335,510,32,274,244},{34,452,206,304,413,127,369,
      147},{286,256,498,20,161,323,77,431},{140,362,104,390,311,213,475,
      57},{440,86,348,186,11,489,231,261},{471,53,315,217,108,394,136,
      358},{235,265,7,485,344,182,444,90}},{{492,10,264,230,87,437,187,
      345},{216,310,60,474,363,137,391,101},{183,341,91,441,268,234,488,
      6},{395,105,359,133,56,470,220,314},{29,511,241,275,418,68,334,
      176},{289,195,461,47,158,384,114,404},{322,164,430,80,253,287,17,
      499},{126,416,146,372,449,35,301,207}},{{96,446,180,338,483,1,271,
      237},{356,130,400,110,223,317,51,465},{259,225,495,13,192,350,84,
      434},{63,477,211,305,388,98,368,142},{425,75,325,167,22,504,250,
      284},{149,375,121,411,298,204,454,40},{246,280,26,508,329,171,421,
      71},{458,44,294,200,117,407,153,379}},{{201,299,37,455,374,152,410,
      124},{501,23,281,251,74,428,166,328},{406,120,378,156,41,459,197,
      295},{170,332,70,424,277,247,505,27},{320,222,468,50,131,353,111,
      397},{4,482,240,270,447,93,339,177},{99,385,143,365,480,62,308,
      210},{351,189,435,81,228,258,16,494}}
      }
	}
	
PerfectMagicCubes[9]:={
	(* Benson and Jacoby 1981, pp. 76-78 *)
	(* m2 = Map[FromDigits[IntegerDigits[#], 9] &, m, {3}]; *)
(*	1+{
	{{586,412,328,645,867,774,101,53,230},{864,771,103,50,236,582,418,325,647},{232,588,415,327,644,861,773,100,56},{641,863,770,106,52,238,585,417,324},{58,235,587,414,321,643,860,776,102},{323,640,866,772,108,55,237,584,411},{105,57,234,581,413,320,646,862,778},{410,326,642,868,775,107,54,231,583},{777,104,51,233,580,416,322,648,865}},
	{{358,635,887,714,121,43,260,576,402},{123,40,266,572,408,355,637,884,711},{405,357,634,881,713,120,46,262,578},{710,126,42,268,575,407,354,631,883},{577,404,351,633,880,716,122,48,265},{886,712,128,45,267,574,401,353,630},{264,571,403,350,636,882,718,125,47},{632,888,715,127,44,261,573,400,356},{41,263,570,406,352,638,885,717,124}},
	{{877,704,151,33,280,516,422,348,665},{286,512,428,345,667,874,701,153,30},{664,871,703,150,36,282,518,425,347},{32,288,515,427,344,661,873,700,156},{341,663,870,706,152,38,285,517,424},{158,35,287,514,421,343,660,876,702},{423,340,666,872,708,155,37,284,511},{705,157,34,281,513,420,346,662,878},{510,426,342,668,875,707,154,31,283}},
	{{141,63,270,506,452,338,685,817,724},{458,335,687,814,721,143,60,276,502},{723,140,66,272,508,455,337,684,811},{505,457,334,681,813,720,146,62,278},{810,726,142,68,275,507,454,331,683},{277,504,451,333,680,816,722,148,65},{686,812,728,145,67,274,501,453,330},{64,271,503,450,336,682,818,725,147},{332,688,815,727,144,61,273,500,456}},
	{{210,526,442,368,675,807,754,131,83},{677,804,751,133,80,216,522,448,365},{86,212,528,445,367,674,801,753,130},{364,671,803,750,136,82,218,525,447},{132,88,215,527,444,361,673,800,756},{441,363,670,806,752,138,85,217,524},{758,135,87,214,521,443,360,676,802},{523,440,366,672,808,755,137,84,211},{805,757,134,81,213,520,446,362,678}},
	{{432,388,615,827,744,161,73,200,556},{741,163,70,206,552,438,385,617,824},{558,435,387,614,821,743,160,76,202},{823,740,166,72,208,555,437,384,611},{205,557,434,381,613,820,746,162,78},{610,826,742,168,75,207,554,431,383},{77,204,551,433,380,616,822,748,165},{386,612,828,745,167,74,201,553,430},{164,71,203,550,436,382,618,825,747}},
	{{605,857,734,181,13,220,546,462,378},{10,226,542,468,375,607,854,731,183},{377,604,851,733,180,16,222,548,465},{186,12,228,545,467,374,601,853,730},{464,371,603,850,736,182,18,225,547},{732,188,15,227,544,461,373,600,856},{541,463,370,606,852,738,185,17,224},{858,735,187,14,221,543,460,376,602},{223,540,466,372,608,855,737,184,11}},
	{{764,171,3,250,536,482,318,625,847},{532,488,315,627,844,761,173,0,256},{841,763,170,6,252,538,485,317,624},{258,535,487,314,621,843,760,176,2},{623,840,766,172,8,255,537,484,311},{5,257,534,481,313,620,846,762,178},{310,626,842,768,175,7,254,531,483},{177,4,251,533,480,316,622,848,765},{486,312,628,845,767,174,1,253,530}},
	{{23,240,566,472,308,655,837,784,111},{305,657,834,781,113,20,246,562,478},{110,26,242,568,475,307,654,831,783},{477,304,651,833,780,116,22,248,565},{786,112,28,245,567,474,301,653,830},{564,471,303,650,836,782,118,25,247},{832,788,115,27,244,561,473,300,656},{241,563,470,306,652,838,785,117,24},{658,835,787,114,21,243,560,476,302}}
	}
*)
	{
	{{483,335,269,527,709,634,82,48,189},{706,631,84,45,195,479,341,266,529},{191,485,338,268,526,703,633,81,51},{523,705,630,87,47,197,482,340,265},{53,194,484,337,262,525,702,636,83},{264,522,708,632,89,50,196,481,334},{86,52,193,478,336,261,528,704,638},{333,267,524,710,635,88,49,190,480},{637,85,46,192,477,339,263,530,707}},
	{{296,518,727,580,100,39,216,474,326},{102,36,222,470,332,293,520,724,577},{329,295,517,721,579,99,42,218,476},{576,105,38,224,473,331,292,514,723},{475,328,289,516,720,582,101,44,221},{726,578,107,41,223,472,325,291,513},{220,469,327,288,519,722,584,104,43},{515,728,581,106,40,217,471,324,294},{37,219,468,330,290,521,725,583,103}},
	{{718,571,127,30,234,420,344,287,545},{240,416,350,284,547,715,568,129,27},{544,712,570,126,33,236,422,347,286},{29,242,419,349,283,541,714,567,132},{280,543,711,573,128,35,239,421,346},{134,32,241,418,343,282,540,717,569},{345,279,546,713,575,131,34,238,415},{572,133,31,235,417,342,285,542,719},{414,348,281,548,716,574,130,28,237}},
	{{118,57,225,411,371,278,563,664,589},{377,275,565,661,586,120,54,231,407},{588,117,60,227,413,374,277,562,658},{410,376,274,559,660,585,123,56,233},{657,591,119,62,230,412,373,271,561},{232,409,370,273,558,663,587,125,59},{564,659,593,122,61,229,406,372,270},{58,226,408,369,276,560,665,590,124},{272,566,662,592,121,55,228,405,375}},
	{{171,429,362,305,554,655,616,109,75},{556,652,613,111,72,177,425,368,302},{78,173,431,365,304,553,649,615,108},{301,550,651,612,114,74,179,428,367},{110,80,176,430,364,298,552,648,618},{361,300,549,654,614,116,77,178,427},{620,113,79,175,424,363,297,555,650},{426,360,303,551,656,617,115,76,172},{653,619,112,73,174,423,366,299,557}},
	{{353,323,500,673,607,136,66,162,456},{604,138,63,168,452,359,320,502,670},{458,356,322,499,667,606,135,69,164},{669,603,141,65,170,455,358,319,496},{167,457,355,316,498,666,609,137,71},{495,672,605,143,68,169,454,352,318},{70,166,451,354,315,501,668,611,140},{321,497,674,608,142,67,163,453,351},{139,64,165,450,357,317,503,671,610}},
	{{491,700,598,154,12,180,447,380,314},{9,186,443,386,311,493,697,595,156},{313,490,694,597,153,15,182,449,383},{159,11,188,446,385,310,487,696,594},{382,307,489,693,600,155,17,185,448},{596,161,14,187,445,379,309,486,699},{442,381,306,492,695,602,158,16,184},{701,599,160,13,181,444,378,312,488},{183,441,384,308,494,698,601,157,10}},
	{{625,145,3,207,438,398,260,509,691},{434,404,257,511,688,622,147,0,213},{685,624,144,6,209,440,401,259,508},{215,437,403,256,505,687,621,150,2},{507,684,627,146,8,212,439,400,253},{5,214,436,397,255,504,690,623,152},{252,510,686,629,149,7,211,433,399},{151,4,208,435,396,258,506,692,626},{402,254,512,689,628,148,1,210,432}},
	{{21,198,465,389,251,536,682,643,91},{248,538,679,640,93,18,204,461,395},{90,24,200,467,392,250,535,676,642},{394,247,532,678,639,96,20,206,464},{645,92,26,203,466,391,244,534,675},{463,388,246,531,681,641,98,23,205},{677,647,95,25,202,460,390,243,537},{199,462,387,249,533,683,644,97,22},{539,680,646,94,19,201,459,393,245}}
	}
}

(* bimagic; constructed by Christian Boyer, cboyer@club-internet.fr, January 23rd, 2003 *)
PerfectMagicCubes[16]:={Get["MagicCube16.m",Path->$path]}

(* bimagic; Hendricks 2000 *)
PerfectMagicCubes[25]:={Get["MagicCube25.m",Path->$path]}

(* bimagic; constructed by Christian Boyer, cboyer@club-internet.fr, February 3rd, 2003 *)
PerfectMagicCubes[27]:={Get["MagicCube27.m",Path->$path]}

(* bimagic; constructed by Christian Boyer, cboyer@club-internet.fr, January 27th, 2003 *)
PerfectMagicCubes[32]:={Get["MagicCube32.m",Path->$path]}

(* trimagic; constructed by Christian Boyer, cboyer@club-internet.fr, February 1st, 2003 *)
PerfectMagicCubes[64]:={Get["MagicCube64.m",Path->$path]}

(* trimagic; constructed by Christian Boyer, cboyer@club-internet.fr, 2003 *)
PerfectMagicCubes[256]:={Get["MagicCube256.m",Path->$path]+1}

(*
PerfectMagicQ[l_]:=Module[{n=Length[l],m,i,j,n1},
      n1=n+1;
      (*
      m=MagicCubeConstant[n];
      Sort[Flatten[l]]==Range[n^3]&&
      *)
        Equal@@Flatten[{
              (*m,*)
              Plus@@@l,
              Plus@@@(Transpose/@l),
              Plus@@@Transpose[l],
          
              Plus@@Table[l[[i,   i,   i]],{i,n}],
              Plus@@Table[l[[n1-i,i,   i]],{i,n}],
              Plus@@Table[l[[i,   n1-i,i]],{i,n}],
              Plus@@Table[l[[i,   i,n1-i]],{i,n}],
                            
              Plus@@@Table[l[[i,i,   j]],{j,n},{i,n}],
              Plus@@@Table[l[[i,n1-i,j]],{j,n},{i,n}],
              Plus@@@Table[l[[j,i,   i]],{j,n},{i,n}],
              Plus@@@Table[l[[j,n1-i,j]],{j,n},{i,n}],
              Plus@@@Table[l[[i,j,   i]],{j,n},{i,n}],
              Plus@@@Table[l[[i,n1-j,i]],{j,n},{i,n}]
              }]
      ] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]
*)
(*
PerfectMagicQ[l_]:=Module[{n=Length[l],m,i,j,n1,
	c=Union[Flatten[Plus@@@l]]},
      n1=n+1;
      Length[c]==1&&
      Union[Flatten[Plus@@@(Transpose/@l)]]===c&&
      Union[Flatten[Plus@@@Transpose[l]]]===c&&
      {Plus@@Table[l[[i,i,i]],{i,n}]}===c&&
      {Plus@@Table[l[[n1-i,i,i]],{i,n}]}===c&&
      {Plus@@Table[l[[i,n1-i,i]],{i,n}]}===c&&
      {Plus@@Table[l[[i,i,n1-i]],{i,n}]}===c&&
      Union[Flatten[Plus@@@Table[l[[i,i,j]],{j,n},{i,n}]]]===c&&
      Union[Flatten[Plus@@@Table[l[[i,n1-i,j]],{j,n},{i,n}]]]===c&&
      Union[Flatten[Plus@@@Table[l[[j,i,i]],{j,n},{i,n}]]]===c&&
      Union[Flatten[Plus@@@Table[l[[j,n1-i,j]],{j,n},{i,n}]]]===c&&
      Union[Flatten[Plus@@@Table[l[[i,j,i]],{j,n},{i,n}]]]===c&&
      Union[Flatten[Plus@@@Table[l[[i,n1-j,i]],{j,n},{i,n}]]]===c
] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]
*)

PerfectMagicQ[l_]:=Module[{n=Length[l],i,j,c=Tr[l]},
	Union[Flatten[Plus@@@l]]==={c}&&
	Union[Flatten[Plus@@@(Transpose/@l)]]==={c}&&
	Union[Flatten[Plus@@@Transpose[l]]]==={c}&&
	Plus@@Table[l[[n+1-i,i,    i    ]],{i,n}]===c&&
	Plus@@Table[l[[i,    n+1-i,i    ]],{i,n}]===c&&
	Plus@@Table[l[[i,    i,    n+1-i]],{i,n}]===c&&
	And@@Table[Plus@@Table[l[[i,i,    j]],{j,n}]===c,{i,n}]&&
	And@@Table[Plus@@Table[l[[i,n+1-i,j]],{j,n}]===c,{i,n}]&&
	And@@Table[Plus@@Table[l[[j,i,    i]],{j,n}]===c,{i,n}]&&
	And@@Table[Plus@@Table[l[[j,n+1-i,j]],{j,n}]===c,{i,n}]&&
	And@@Table[Plus@@Table[l[[i,j,    i]],{j,n}]===c,{i,n}]&&
	And@@Table[Plus@@Table[l[[i,n+1-j,i]],{j,n}]===c,{i,n}]
] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]

PerfectMagicQ[l_,Method->Loops]:=Module[{n=Length[l],i,j,c=Tr[l],tot},
	Union[Flatten[Plus@@@l]]==={c}&&
	Union[Flatten[Plus@@@(Transpose/@l)]]==={c}&&
	Union[Flatten[Plus@@@Transpose[l]]]==={c}&&
	           (For[tot=0;i=1,i<=n,i++,tot+=l[[n+1-i,i,    i    ]]];tot===c)&&
	           (For[tot=0;i=1,i<=n,i++,tot+=l[[i,    n+1-i,i    ]]];tot===c)&&
	           (For[tot=0;i=1,i<=n,i++,tot+=l[[i,    i,    n+1-i]]];tot===c)&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[i,    i,    j    ]]];tot===c),{i,n}]&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[i,    n+1-i,j    ]]];tot===c),{i,n}]&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[j,    i,    i    ]]];tot===c),{i,n}]&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[j,    n+1-i,j    ]]];tot===c),{i,n}]&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[i,    j,    i    ]]];tot===c),{i,n}]&&
	And@@Table[(For[tot=0;j=1,j<=n,j++,tot+=l[[i,    n+1-j,i    ]]];tot===c),{i,n}]
] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]


RotationReflectionQ[x_List,y_List]:=Module[{r},
	MemberQ[Flatten[
		{#,Reverse[#],r=Reverse/@#,Reverse[r]}&/@{x,Transpose[x]},1],
	y]
]

(*
RowProds[list_List]:=Apply[Times,Transpose[list]]

RowSums[list_List]:=Apply[Plus,Transpose[list]]

SemimagicQ[list_List]:=Module[{a,b},
  {a,b}={RowSums[list],ColSums[list]};
  If[Length[Union[a,b]]==1,True,False]
]
*)

SemimagicQ[l_List?MatrixQ]:=Equal@@Flatten[
	Plus@@@l,
	Plus@@@Transpose[l]
] /; Equal@@Dimensions[l]

(* Benson and Jacobi p. 13 *)
SemiperfectMagicCubes[3]:=
{
	{
	{{4,12,26},{11,25,6},{27,5,10}},
	{{20,7,15},{9,14,19},{13,21,8}},
	{{18,23,1},{22,3,17},{2,16,24}}
	},
	{
	{{6,10,26},{11,27,4},{25,5,12}},
	{{20,9,13},{7,14,21},{15,19,8}},
	{{16,23,3},{24,1,17},{2,18,22}}
	},
	{
	{{4,18,20},{17,19,6},{21,5,16}},
	{{26,1,15},{3,14,25},{13,27,2}},
	{{12,23,7},{22,9,11},{8,10,24}}
	},
	{
	{{6,16,20},{17,21,4},{19,5,18}},
	{{26,3,13},{1,14,27},{15,25,2}},
	{{10,23,9},{24,7,11},{8,12,22}}
	}
}

SemiperfectMagicCubes[4]:=
{
	{
	{{60,37,12,21},{13,20,61,36},{56,41,8,25},{1,32,49,48}},
	{{7,26,55,42},{50,47,2,31},{11,22,59,38},{62,35,14,19}},
	{{57,40,9,24},{16,17,64,33},{53,44,5,28},{4,29,52,45}},
	{{6,27,54,43},{51,46,3,30},{10,23,58,39},{63,34,15,18}}
	}
}

(* Benson and Jacobi 1981, p. 30 *)
SemiperfectMagicCubes[5]:=
{
	{
	{{110,86,67,48,4},{89,70,46,2,108},{68,49,5,106,87},{47,3,109,90,66},{1,107,88,69,50}},
	{{14,120,96,52,33},{118,99,55,31,12},{97,53,34,15,116},{51,32,13,119,100},{35,11,117,98,54}},
	{{43,24,105,81,62},{22,103,84,65,41},{101,82,63,44,25},{85,61,42,23,104},{64,45,21,102,83}},
	{{72,28,9,115,91},{26,7,113,94,75},{10,111,92,73,29},{114,95,71,27,8},{93,74,30,6,112}},
	{{76,57,38,19,125},{60,36,17,123,79},{39,20,121,77,58},{18,124,80,56,37},{122,78,59,40,16}}
	}
}
(*
SemiperfectMagicQ[l_]:=Module[{n=Length[l],m,i,n1},
      n1=n+1;
      (*m=MagicCubeConstant[n];
      Sort[Flatten[l]]==Range[n^3]&&*)
        Equal@@Flatten[{
              (*m,*)
              Plus@@@l,
              Plus@@@(Transpose/@l),
              Plus@@@Transpose[l],
              Plus@@Table[l[[i,i,i]],{i,n}],
              Plus@@Table[l[[n1-i,i,i]],{i,n}],
              Plus@@Table[l[[i,n1-i,i]],{i,n}],
              Plus@@Table[l[[i,i,n1-i]],{i,n}]
              }]
      ] /;ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]
*)

(*
SemiperfectMagicQ[l_]:=Module[{n=Length[l],m,i,n1,c=Union[Flatten[Plus@@@l]]},
	n1=n+1;
	Length[c]==1&&
	Union[Flatten[Plus@@@Transpose[l]]]===c&&
	{Plus@@Table[l[[i,i,i]],{i,n}]}===c&&
	{Plus@@Table[l[[n1-i,i,i]],{i,n}]}===c&&
	{Plus@@Table[l[[i,n1-i,i]],{i,n}]}===c&&
	{Plus@@Table[l[[i,i,n1-i]],{i,n}]}===c
] /;ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]
*)

SemiperfectMagicQ[l_]:=Module[{n=Length[l],i,j,c=Tr[l]},
	Union[Flatten[Plus@@@l]]==={c}&&
	Union[Flatten[Plus@@@(Transpose/@l)]]==={c}&&
	Union[Flatten[Plus@@@Transpose[l]]]==={c}&&
	Plus@@Table[l[[n+1-i,i,    i    ]],{i,n}]===c&&
	Plus@@Table[l[[i,    n+1-i,i    ]],{i,n}]===c&&
	Plus@@Table[l[[i,    i,    n+1-i]],{i,n}]===c
] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]

SemiperfectMagicQ[l_,Method->Loops]:=Module[{n=Length[l],i,j,c=Tr[l],tot},
	Union[Flatten[Plus@@@l]]==={c}&&
	Union[Flatten[Plus@@@(Transpose/@l)]]==={c}&&
	Union[Flatten[Plus@@@Transpose[l]]]==={c}&&
	(For[tot=0;i=1,i<=n,i++,tot+=l[[n+1-i,i,    i    ]]];tot===c)&&
	(For[tot=0;i=1,i<=n,i++,tot+=l[[i,    n+1-i,i    ]]];tot===c)&&
	(For[tot=0;i=1,i<=n,i++,tot+=l[[i,    i,    n+1-i]]];tot===c)
] /; ArrayQ[l,3,IntegerQ]&&Equal@@Dimensions[l]

SumDiffs[{x_,y_},{u_,v_}]:=
  {Abs[u+v], Abs[u-v], Abs[(u-x)+(v-y)], Abs[u+y-x-v]}

Talisman[list_List]:=Min[Flatten[TalismanDiffs[list]]]

TalismanDiffs[list_List]:=Module[{n=Length[list],i,j},
  dif[{i1_,j1_},{i2_,j2_}]:=Abs[list[[i1,j1]]-list[[i2,j2]]];
  Join[{
    Table[dif[{i,j},{i,j+1}],{i,n},{j,n-1}],
    Table[dif[{i,j},{i+1,j}],{i,n-1},{j,n}],
    Table[dif[{i,j},{i-1,j+1}],{i,2,n},{j,n-1}],
    Table[dif[{i,j},{i+1,j+1}],{i,n-1},{j,n-1}]
  }]
]

xypos[i_,k_List]:=Module[{p=Position[k,i][[1]],len=Length[k]},
		{p[[2]],len+1-p[[1]]}-.5{1,1}
]

TourPlot[k_List,opts___?OptionQ]:=Module[
	{i,len=Length[k],linestyle,pointstyle,pts,
	gopts=FilterOptions[Graphics,opts,Options[TourPlot]]
	},
	pts=Table[xypos[i,k],{i,len^2}];
	{linestyle,pointstyle,diskstyle}={LineStyle,PointStyle,DiskStyle}/.
		{opts}/.Options[TourPlot];
	Graphics[{
		{linestyle,Line[pts]},
		{diskstyle,Disk[xypos[#,k],.3]&/@{1,len^2}},
		If[pointstyle=!=None,{pointstyle,Point/@pts},{}],
		MagicSquarePlot[k][[1]]
		},
		Evaluate[gopts],AspectRatio->Automatic]
]


End[]

(* Protect[  ] *)

EndPackage[]