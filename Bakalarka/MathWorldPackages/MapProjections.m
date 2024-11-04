(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.19 *)

(*:Name: MathWorld`MapMapProjections` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/MapMapProjections.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2003-07-22): Plunked into a package
  v1.01 (2003-10-19): updated contexts
  v1.10 (2004-02-14): actually implemented MapProjectionPlot function
  v1.15 (2004-02-18): added LineType and a bunch of new projections
  v1.16 (2004-02-19): now disable error messages from degenerate
                      transformation points and remove such points
                      from the list before returning them
  v1.17 (2004-02-23): fixed orthographic projection to discard points in back.
                      Added some InverseMapProjections
  v1.18 (2005-10-10): Added Heads->False in MapProjections, apparently needed starting in v5.1
  v1.19 (2006-07-10): Changed Projection -> MapProjection
  
  (c) 2004-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements: None. *)

(*:Discussion:
*)

(*:References:
Data files from the CIA World DataBank II can be used, see
http://www.evl.uic.edu/pape/data/WDB/
*)

(*:Limitations: 
MapCoordinates needs to be modified to handle the CIA data format
*)

BeginPackage["MathWorld`MapMapProjections`",
	{
	"Graphics`Shapes`",
	"Graphics`Colors`"
	}
]

Albers::usage =
"MapProjection[Albers[{phi0,phi1,phi2},lambda0]] gives the Albers \
projection with central latitude and longitude {phi0,lambda0} and \
standard parallels and phi1 and phi2."

Bonne::usage =
"MapProjection[Bonne[phi0,lambda0]]."

Cassini::usage =
"MapProjection[Cassini[lambda0]]."

ClosedLine::usage =
"ClosedLine[list] gives a line with the first and last points connected."

CylindricalEqualArea::usage =
"MapProjection[CylindricalEqualArea[phis,l0]] gives the cylindrical \
equal-area projection."

CylindricalEquidistant::usage =
"MapProjection[CylindricalEquidistant[phi1,l0]] gives the cylindrical \
equidistant projection."

EckertIV::usage =
"MapProjection[EckertIV[lambda0]]."

EckertVI::usage =
"MapProjection[EckertVI[lambda0]]."

Equirectangular::usage =
"MapProjection[Equirectangular[phi0,lambda0]]."

GlobePlot::usage =
"GlobePlot[{{lambda1,phi1},...}] gives a list of the specified lines \
mapped onto the surface of a solid sphere with a grid.  GlobePlot[] \
used MapCoordinates[] as the default dataset."

Gnomonic::usage =
"MapProjection[Gnomonic[phi0,lambda0]]."

GridSegments::usage =
"GridSegments->{nlon,nlat} or GridSegments->n is an option to MapProjectionPlot."

InverseMapProjection::usage =
"InverseMapProjection[proj[params]] is a pure function in x and y specifying the \
transformation of the given inverse projection taking (x,y) to (phi,lambda)."

LambertAzimuthal::usage =
"MapProjection[LambertAzimuthal[phi1,lambda0]]."

LambertConic::usage =
"MapProjection[LambertConic[{phi0,phi1,phi2},lambda0]]."

LineType::usage =
"LineType->(Line|SplitLine) is an option to MapProjectionPlot."

MapCoordinates::usage =
"MapCoordinates[] reads in a text file containing a set of latitudes \
and longitudes of the earth.  The name and location of this file is \
set by the options MapDirectory, Directory, and MapFile, which should be \
given valid default values."

MapDirectory::usage =
"MapDirectory is an option to MapCoordinates that specifies the full path to the \
top directory of map files.  The full file specification is MapDirectory<>\
Directory<>MapFile."

MapFile::usage =
"MapFile is an option to MapCoordinates that specifies the name of the \
the map file to use.  The file is assumed to live in MapDirectory<>Directory."

Mercator::usage =
"MapProjection[Mercator[lambda0]]."

MillerCylindrical::usage =
"MapProjection[MillerCylindrical[lambda0]]."

Mollweide::usage =
"MapProjection[Mollweide[lamba0]]."

Orthographic::usage =
"MapProjection[Orthographic[phi1,l0]]."

Polyconic::usage =
"MapProjection[Polyconic[phi0,l0]]."

MapProjection::usage =
"MapProjection[proj[params]] is a pure function in phi and lambda specifying the \
transformation of the given projection that takes (phi,lambda) to (x,y)."

MapProjectionPlot::usage =
"MapProjectionPlot[proj,coords] makes a plot of the specified projection of \
the given set of coordinates.  MapProjectionPlot[proj] takes coords to be \
the default value of MapCoordinates.  LineType->(Line|SplitLine) \
specified the type of line to use.  GridLines->{lat,lon} or \
GridLines->None specifies how many grid lines should be drawn.  \
PlotStyle->{map,grid} can be usd to specify the styles to use for the \
map and grid.  GridSegments->{nlat,nlon} gives the number of segments \
to use when drawing the merridians and parallels."

MapProjections::usage =
"MapProjections gives a list of defined map projections."

RemoveDegenerate::usage =
"RemoveDegenerate is an option for MapProjectionPlot."

Sinusoidal::usage =
"MapProjection[Sinusoidal[lambda0]]."

SplitLine::usage =
"SplitLine[eps] is a LineType that splits polylines at places where adjacent points \
are more than eps apart.  It is useful to remove artefacts from points of \
discontinuity in a map transformation."

Stereographic::usage =
"MapProjection[Stereographic[phi1,lambda0]]."

VanDerGrinten::usage =
"MapProjection[VanDerGrinten[lambda0]]."

VerticalPerspective::usage =
"MapProjection[VerticalPerspective[phi1,l0,P]]."


Options[GlobePlot]={
	PlotStyle->{Red,GrayLevel[.7]}
};

Options[MapCoordinates]={
	MapDirectory->"/Volumes/Users/Data/Maps/GPS/",
	Directory->"Planets/",
	MapFile->"Earth.pts"
};

Options[MapProjectionPlot]={
	GridLines->{18,24},
	GridSegments->25,
	LineType->SplitLine,
	RemoveDegenerate->True,
	PlotStyle->{Red,GrayLevel[.7]}
};


Begin["`Private`"]


ClosedLine[l_List]:=Line[Append[l,First[l]]]

GlobePlot[pts_,g_:Line,opts___?OptionQ]:=Module[
	{styles=PlotStyle/.{opts}/.Options[GlobePlot]},
	{
	{EdgeForm[styles[[2]]],FaceForm[White],Sphere[.995,24,18]},
	styles[[1]],g/@Map[Function[{d,l},{Cos[l]Cos[d],Sin[l]Cos[d],Sin[d]}]@@#&,pts,{2}]
	}
]

GlobePlot[g_:Line]:=GlobePlot[MapCoordinates[],g]

gridLines[{dd_,dl_},n_]:=gridLines[{dd,dl},{n,n}]

gridLines[{dd_,dl_},{nd_,nl_}]:=Module[{x,y},
	Flatten[{
		Table[{y,x},{x,-Pi,Pi,2Pi/dl},{y,-Pi/2,Pi/2,Pi/nd}],
		Table[{y,x},{y,-Pi/2,Pi/2,Pi/dd},{x,-Pi,Pi,2Pi/nl}]
	},1]
]

gridLines[{{d1_,d2_,dd_},{l1_,l2_,dl_}},{nd_,nl_}]:=Module[{x,y},
	Flatten[{
		Table[{y,x},{x,l1,l2,dl},{y,d1,d2,(d2-d1)/nd}],
		Table[{y,x},{y,d1,d2,dd},{x,l1,l2,(l2-l1)/nl}]
	},1]
]

gridLines[None,nd___]:={{}}

MapCoordinates[opts___]:=Module[
	{
	data,pos,
	dir = StringJoin[{MapDirectory,Directory} /. {opts} /. Options[MapCoordinates]],
	file=MapFile/.{opts}/.Options[MapCoordinates]
	},
	data=ReadList[dir<>file,Word,
		RecordLists->True,WordSeparators->{"\t"," "},
		RecordSeparators->{"\n"}];
	pos=Flatten[Position[First/@data,_?(StringTake[#,1]=="#"||StringTake[#,1]=="!"&),{1},Heads->False]];
	ToExpression/@Take[data,#]&/@Transpose[{Most[pos+1],Rest[pos-1]}]Degree
]

(* MapProjections *)

MapProjection[Albers[{phi0_,phi1_,phi2_},lambda0_:0]]:=
  Function[{phi,lambda},Module[{rho,q,rho0,c,n},
      n=(Sin[phi1]+Sin[phi2])/2;
      c=Cos[phi1]^2+2n Sin[phi1];
      q=n(lambda-lambda0);
      rho=Sqrt[c-2n Sin[phi]]/n;
      rho0=Sqrt[c-2n Sin[phi0]]/n;
      {rho Sin[q],rho0-rho Cos[q]}]]

MapProjection[Bonne[phi1_:.0001,lambda0_:0]]:=Function[{phi,lambda},
	Module[{rho,e},
	    rho=Cot[phi1]+phi1-phi;
    	e=(lambda-lambda0)Cos[phi]/rho;
		{rho Sin[e],Cot[phi1]-rho Cos[e]}
	]
]

MapProjection[Cassini[l0_:0]]:=
  Function[{phi,l},{ArcSin[Cos[phi]Sin[l-l0]],ArcTan[Cos[l-l0],Tan[phi]]}]

MapProjection[CylindricalEqualArea[phis_:0,l0_:0]]:=
  Function[{phi,l},{(l-l0)Cos[phis],Sin[phi]Sec[phis]}]

MapProjection[CylindricalEquidistant[phi1_:0,l0_:0]]:=
  Function[{phi,l},{(l-l0)Cos[phi1],phi}]

MapProjection[EckertIV[l0_:0]]:=
  Function[{phi,l},
  {
  2(l-l0)(1+Cos[EckertIVTheta[phi]])/Sqrt[Pi(4+Pi)],
  2Sqrt[Pi/(4+Pi)]Sin[EckertIVTheta[phi]]
  }
]
EckertIVTheta[phi_]:=Module[{q},
	q/.FindRoot[q+Sin[q]Cos[q]+2Sin[q]==(2+Pi/2)Sin[phi],{q,phi/2}]
]

MapProjection[EckertVI[l0_:0]]:=
  Function[{phi,l},
  {
  (l-l0)(1+Cos[EckertVITheta[phi]])/Sqrt[2+Pi],
  2Sin[EckertVITheta[phi]]/Sqrt[2+Pi]
  }
]
EckertVITheta[phi_]:=Module[{q},
	q/.FindRoot[q+Sin[q]==(1+Pi/2)Sin[phi],{q,phi}]
]

MapProjection[Equirectangular[phi0_:0,l0_:0]]:=
  Function[{phi,l},{l-l0,phi-phi0}]

MapProjection[Gnomonic[phi1_:0,l0_:0]]:=
	Function[{phi,l},
		{Cos[phi]Sin[l-l0],Cos[phi1]Sin[phi]-Sin[phi1]Cos[phi]Cos[l-l0]}/
		(Sin[phi1]Sin[phi]+Cos[phi1]Cos[phi]Cos[l-l0])
	]

InverseMapProjection[Gnomonic[phi1_:0,l0_:0]]:=
	Function[{x,y},Module[{rho=Sqrt[x^2+y^2],c},
		c=ArcTan[rho];
		{ArcSin[Cos[c]Sin[phi1]+y Sin[c]Cos[phi1]/rho],
		l0+ArcTan[rho Cos[phi1]Cos[c]-y Sin[phi1]Sin[c],x Sin[c]]}
	]
]

MapProjection[LambertAzimuthal[phi1_:0,l0_:0]]:=Function[{phi,l},
	Module[{k},
	    k=Sqrt[2/(1+Sin[phi1]Sin[phi]+Cos[phi1]Cos[phi]Cos[l-l0])];
		k{Cos[phi]Sin[l-l0],Cos[phi1]Sin[phi]-Sin[phi1]Cos[phi]Cos[l-l0]}
	]
]

MapProjection[LambertConic[phis_List:{0,0,0},l0_:0]]:=Function[{phi,l},
	Module[{n,F,rho,rho0,phi0,phi1,phi2},
		{phi0,phi1,phi2}=phis;
		n=Log[Cos[phi1]Sec[phi2]]/Log[Tan[Pi/4+phi2/2]Cot[Pi/4+phi1/2]];
		F=Cos[phi1]Tan[Pi/4+phi1/2]^n/n;
		rho=F Cot[Pi/4+phi/2]^n;
		rho0=F Cot[Pi/4+phi0/2]^n;
		{rho Sin[n(l-l0)],rho0-rho Cos[n(l-l0)]}
	]
]

MapProjection[Mercator[l0_:0]]:=Function[{phi,l},
	{l-l0,Log[Tan[phi]+Sec[phi]]}
]

MapProjection[MillerCylindrical[l0_:0]]:=Function[{phi,l},
	{l-l0,5Log[Tan[Pi/4+2phi/5]]/4}
]

MollweideTheta[phi_]:=Module[{q},
	q/.FindRoot[2q+Sin[2q]==Pi Sin[phi],{q,2ArcSin[2phi/Pi]}]
]
MapProjection[Mollweide[l0_:0]]:=Function[{phi,l},
	Sqrt[2]{2(l-l0)Cos[MollweideTheta[phi]]/Pi,Sin[MollweideTheta[phi]]}
]

MapProjection[Orthographic[phi1_:0,l0_:0]]:=Function[{phi,l},
	Which[
		Abs[l-l0]>Pi/2,{Indeterminate,Indeterminate},
		True,{Cos[phi]Sin[l-l0],Cos[phi1]Sin[phi]-Sin[phi1]Cos[phi]Cos[l-l0]}
	]
]

InverseMapProjection[Orthographic[phi1_:0,l0_:0]]:=
	Function[{x,y},Module[{rho=Sqrt[x^2+y^2],c},
		c=ArcSin[rho];
		{ArcSin[Cos[c]Sin[phi1]+y Sin[c]Cos[phi1]/rho],
		l0+ArcTan[rho Cos[phi1]Cos[c]-y Sin[phi1]Sin[c],x Sin[c]]}
	]
]

MapProjection[Polyconic[phi0_:0,l0_:0]]:=
  Function[{phi,l},Module[{e=(l-l0)Sin[phi]},
  	{Cot[phi]Sin[e],(phi-phi0)+Cot[phi](1-Cos[e])}
  ]
]

MapProjection[Sinusoidal[l0_:0]]:=
  Function[{phi,l},{(l-l0)Cos[phi],phi}]

MapProjection[Stereographic[phi1_:0,l0_:0]]:=Function[{phi,l},
	Module[{k},
	    k=2/(1+Sin[phi1]Sin[phi]+Cos[phi1]Cos[phi]Cos[l-l0]);
		k{Cos[phi]Sin[l-l0],Cos[phi1]Sin[phi]-Sin[phi1]Cos[phi]Cos[l-l0]}
	]
]

InverseMapProjection[Stereographic[phi1_:0,l0_:0]]:=
	Function[{x,y},Module[{rho=Sqrt[x^2+y^2],c},
		c=2ArcTan[rho/2];
		{ArcSin[Cos[c]Sin[phi1]+y Sin[c]Cos[phi1]/rho],
		l0+ArcTan[rho Cos[phi1]Cos[c]-y Sin[phi1]Sin[c],x Sin[c]]}
	]
]

MapProjection[VanDerGrinten[l0_:0]]:=Function[{phi,l},
	Module[{A,G,P,q,Q},
	    A=Abs[Pi/(l-l0)-(l-l0)/Pi]/2;
	    q=ArcSin[Abs[2phi/Pi]];
	    G=Cos[q]/(Sin[q]+Cos[q]-1);
	    P=G(2/Sin[q]-1);
	    Q=A^2+G;
	    Which[
	    	phi==0,{l-l0,0},
	    	Abs[phi]==Pi/2||l-l0==0,{0,Pi*Sign[phi]Tan[q/2]},
	    	True,{Sign[l-l0]Pi(A(G-P^2)+Sqrt[A^2(G-P^2)^2-(P^2+A^2)(G^2-P^2)]),
				Sign[phi]Pi Abs[P Q-A Sqrt[(A^2+1)(P^2+A^2)-Q^2]]}/(P^2+A^2)
		]
	]
]

MapProjection[VerticalPerspective[phi1_:0,l0_:0,P_:2]]:=Function[{phi,l},
	Module[{k,cosc},
	    cosc=Sin[phi1]Sin[phi]+Cos[phi1]Cos[phi]Cos[l-l0];
	    k=(P-1)/(P-cosc);
	    Which[
	    	cosc<1/P,{Indeterminate,Indeterminate},
			True,k{Cos[phi]Sin[l-l0],Cos[phi1]Sin[phi]-Sin[phi1]Cos[phi]Cos[l-l0]}
		]
	]
]


(* MapProjections List *)

MapProjections:=Sort[#[[1,1,1,0]]&/@DownValues[MapProjection]]

(* MapProjectionPlot *)

MapProjectionPlot[proj_,coords_List,opts___?OptionQ]:=Module[
	{
	grid=Apply[gridLines,
		{GridLines,GridSegments}/.{opts}/.Options[MapProjectionPlot]],
	styles,line,l
	},
	{line,styles,remove}={LineType,PlotStyle,RemoveDegenerate}/.
		{opts}/.Options[MapProjectionPlot];
	l=Internal`DeactivateMessages[
		{
		{styles[[2]],line/@Map[proj[Sequence@@#]&,grid,{2}]},
		{styles[[1]],line/@Map[proj[Sequence@@#]&,coords,{2}]}
		},
		Power::"infy",Infinity::"indet"
	];
	If[remove,
		DeleteCases[DeleteCases[DeleteCases[DeleteCases[l,_?(MemberQ[#,(Indeterminate|ComplexInfinity)]&),-1],
		Line[{}],-1],{},-1],Line[{{x_,y_}}],-1],
		l
	]
]

MapProjectionPlot[proj_,opts___?OptionQ]:=MapProjectionPlot[proj,MapCoordinates[],opts]

SplitLine[l_List,eps_:.5]:=Line/@Split[l,(Norm[#1-#2]<eps&)]

End[]

EndPackage[]

(* Protect[  ] *)