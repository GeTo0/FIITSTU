(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.03 *)

(*:Name: MathWorld`FairDice` *)

(*:Author:
  regular solids by Eric W. Weisstein
  unusual shapes by Ed Pegg, Jr.
  consolidated into package format with corrections by Eric W. Weisstein
*)

(*:URL:
  http://mathworld.wolfram.com/packages/FairDice.m
*)

(*:Summary:

  Gives graphics objects corresponding to all 30 of the 'fair' dice.
  The numbering follows that given on Ed Pegg's web page.
*)

(*:History:
  v1.00 (1999-01-27): Written
  v1.01 (1999-01-29): FairDie30 fixed
  v1.02 (2000-01-01): URL updated
  v1.03 (2003-10-18): context updated
  
  (c) 1999-2007 Eric W. Weisstein and Ed Pegg, Jr.
*)

(*:Keywords:
  
*)

(*:Requirements: 
  Requires the JohnsonSolids.m and Polyhedra.m packages, available from 
    http://mathworld.wolfram.com/packages/
*)

(*:Discussion:
*)

(*:References:
  http://mathworld.wolfram.com/FairDice.html
  http://www.mathpuzzle.com/Fairdice.htm
*)

(*:Limitations: 
  None known.
*)

BeginPackage["MathWorld`FairDice`",
	{
	"MathWorld`JohnsonSolids`",
	"MathWorld`Polyhedra`"
	}
]


FairDie::usage =
"FairDie[n] gives a Graphics3D object corresponding to the nth
fair die."



Begin["`Private`"]


n0 = {1,1,1};
n1 = {-1,-1,1};
n2 = {-1,1,-1};
n3 = {1,-1,-1};
n4 = {1,1,2};
n5 = {-1,-1,2};
n6 = {-1,1,-2};
n7 = {1,-1,-2};
n8 = {1,4,2};
n9 = {-1,-4,2};
n10 = {-1,4,-2};
n11 = {1,-4,-2};

FairDie[1]:=Tetrahedron

FairDie[2]:=Module[{},
	Graphics3D[{
		Polygon[{n6,n4,n5}],
		Polygon[{n6,n7,n4}],
		Polygon[{n4,n7,n5}],
		Polygon[{n5,n7,n6}]
	}]
]

FairDie[3]:=Module[{},
		Graphics3D[{
	Polygon[{n10,n8,n9}],
	Polygon[{n10,n8,n11}],
	Polygon[{n10,n9,n11}],
	Polygon[{n9,n8,n11}] 
}]
	]

FairDie[4]:=Cube

FairDie[5]:=Octahedron

FairDie[6]:=Dodecahedron

ma1={{1,0,0},{0,1,0},{0,0,1}};
mb1={{0,1,0},{0,0,1},{1,0,0}};
mc1={{0,0,1},{1,0,0},{0,1,0}};
ma2={{1,0,0},{0,-1,0},{0,0,-1}};
mb2={{0,1,0},{0,0,-1},{-1,0,0}};
mc2={{0,0,1},{-1,0,0},{0,-1,0}};
ma3={{-1,0,0},{0,1,0},{0,0,-1}};
mb3={{0,-1,0},{0,0,1},{-1,0,0}};
mc3={{0,0,-1},{1,0,0},{0,-1,0}};
ma4={{-1,0,0},{0,-1,0},{0,0,1}};
mb4={{0,-1,0},{0,0,-1},{1,0,0}};
mc4={{0,0,-1},{-1,0,0},{0,1,0}};


FairDie[7]:=Module[{lst,
	f1={0,1.,5.},
	f2={1.,5.,0},
	f3={-1.,5.,0},
	f4={2.77777,2.77777,2.77777},
	f5={-2.77777,2.77777,2.77777}
	},
	lst={f1,f4,f2,f3,f5};
	Graphics3D[{
		Polygon[lst.ma1],Polygon[lst.ma2],Polygon[lst.ma3],
		Polygon[lst.ma4],Polygon[lst.mb1],Polygon[lst.mb2],
		Polygon[lst.mb3],Polygon[lst.mb4],Polygon[lst.mc1],
		Polygon[lst.mc2],Polygon[lst.mc3],Polygon[lst.mc4]
	}]
]

FairDie[8]:=Module[{lst,
	ma1={{1,0,0},{0,1,0},{0,0,1}},
	mb1={{0,1,0},{0,0,1},{1,0,0}},
	mc1={{0,0,1},{1,0,0},{0,1,0}},
	ma2={{1,0,0},{0,-1,0},{0,0,-1}},
	mb2={{0,1,0},{0,0,-1},{-1,0,0}},
	mc2={{0,0,1},{-1,0,0},{0,-1,0}},
	ma3={{-1,0,0},{0,1,0},{0,0,-1}},
	mb3={{0,-1,0},{0,0,1},{-1,0,0}},
	mc3={{0,0,-1},{1,0,0},{0,-1,0}},
	ma4={{-1,0,0},{0,-1,0},{0,0,1}},
	mb4={{0,-1,0},{0,0,-1},{1,0,0}},
	mc4={{0,0,-1},{-1,0,0},{0,1,0}},
	p3={3.,-1.15384615384,1.442307692},
	p4={3.,1.1538461,-1.442307692},
	p14={1.44230769230,3.00000000000,-1.1538461538},
	p16={1.27659574,1.27659574,1.27659574},
	p22={3.6108973372,-1.1174388179,0.3786362936},
	p26={2.60869565217,2.60869565217,-2.60869565217}
	},
	lst={p16,p14,p26,p4,p3};
	Graphics3D[{
	(*
		Polygon[lst . ma1],Polygon[lst . ma1],Polygon[lst . ma3],Polygon[lst . ma4],
		Polygon[lst . mb1],Polygon[lst . mb2],Polygon[lst . mb3],Polygon[lst . mb4],
		Polygon[lst . mc1],Polygon[lst . mc2],Polygon[lst . mc3],Polygon[lst . mc4]
	*)
	
		Polygon[lst . ma1],Polygon[lst . ma2],Polygon[lst . ma3],Polygon[lst . ma4],
		Polygon[lst . mb1],Polygon[lst . mb2],Polygon[lst . mb3],Polygon[lst . mb4],
		Polygon[lst . mc1],Polygon[lst . mc2],Polygon[lst . mc3],Polygon[lst . mc4]
	}]
]


FairDie[9]:=RhombicDodecahedron

FairDie[10]:=Module[
	{
	a=0.857143,
	b=1.2,
	g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13
	},
	g0={0.5,0.353553,0.866025}b;
	g1={-0.5,0.707107,0.866025};
	g2={-0.5,-0.353553,0.866025}a;
	g3={0.5,-0.707107,0.866025};
	g4={1,-0.353553,0}a;
	g5={1.,0.707107,0};
	g6={0,1.06066,0}a;
	g7={-1.,0.353553,0}b;
	g8={-1.,-0.707107,0};
	g9={0,-1.06066 ,0}b;
	g10={0.5,-0.707107,-0.866025};
	g11={0.5,0.353553,-0.866025}b;
	g12={-0.5,0.707107,-0.866025};
	g13={-0.5,-0.353553,-0.866025}a;
	
	Graphics3D[{
		Polygon[{g3,g0,g1,g2}],
		Polygon[{g3,g4,g5,g0}],
		Polygon[{g0,g5,g6,g1}],
		Polygon[{g1,g7,g8,g2}],
		Polygon[{g2,g8,g9,g3}],
		Polygon[{g5,g4,g10,g11}],
		Polygon[{g4,g3,g9,g10}],
		Polygon[{g1,g6,g12,g7}],
		Polygon[{g6,g5,g11,g12}],
		Polygon[{g8,g7,g12,g13}],
		Polygon[{g9,g8,g13,g10}],
		Polygon[{g10,g13,g12,g11}]
	}]
]

FairDie[11]:=TriakisTetrahedron

FairDie[12]:=Icosahedron

FairDie[13]:=Module[{
	a=0.857143,
	j0,j1,j2,j3,j4,j5,j6,j7,j8,j9,j10,j11,j12,j13
	},
	j0={0.316228, 0.707107, 0.948683} a;
	j1={-0.737865, -0.235702, 0.948683};
	j2={0.316228, -0.353553, 0.948683};
	j3={1.1595, -0.235702, 0.316228};
	j4={-0.632456, 0.707107, 0.474342};
	j5={0.105409, -1.17851, 0.316228} a;
	j6={0.790569, 0.707107, 0};
	j7={-1.1595, 0.235702, -0.316228} a;
	j8={-0.105409, 1.17851, -0.316228};
	j9={-0.790569, -0.707107, 0};
	j10={0.737865, 0.235702, -0.948683} a;
	j11={0.632456, -0.707107, -0.474342};
	j12={-0.316228, -0.707107, -0.948683};
	j13={-0.316228, 0.353553, -0.948683};

	Graphics3D[{
		Polygon[{j2,j0,j1}],
		Polygon[{j2,j3,j0}],
		Polygon[{j0,j4,j1}],
		Polygon[{j1,j5,j2}],
		Polygon[{j0,j3,j6}],
		Polygon[{j3,j2,j5}],
		Polygon[{j1,j4,j7}],
		Polygon[{j4,j0,j8}],
		Polygon[{j5,j1,j9}],
		Polygon[{j3,j10,j6}],
		Polygon[{j6,j8,j0}],
		Polygon[{j5,j11,j3}],
		Polygon[{j4,j8,j7}],
		Polygon[{j7,j9,j1}],
		Polygon[{j9,j12,j5}],
		Polygon[{j6,j10,j8}],
		Polygon[{j10,j3,j11}],
		Polygon[{j11,j5,j12}],
		Polygon[{j7,j8,j13}],
		Polygon[{j9,j7,j12}],
		Polygon[{j10,j13,j8}],
		Polygon[{j11,j12,j10}],
		Polygon[{j13,j12,j7}],
		Polygon[{j13,j10,j12}]
	}]
]

FairDie[14]:=TetrakisHexahedron

FairDie[15]:=TriakisOctahedron

FairDie[16]:=DeltoidalIcositetrahedron

FairDie[17]:=PentagonalIcositetrahedron

FairDie[18]:=Module[{lst,
	f1={0,1.,3.},
	f2={1.,3.,0},
	f3={0,3.33333,0},
	f4={1.57895,1.57895,1.57895},
	mmm={{1,0,0},{0,-1,0},{0,0,1}}
	},
	lst={f1,f4,f2,f3};
	Graphics3D[{
		Polygon[lst.ma1],Polygon[lst.ma2],Polygon[lst.ma3],
		Polygon[lst.ma4],Polygon[lst.mb1],Polygon[lst.mb2],
		Polygon[lst.mb3],Polygon[lst.mb4],Polygon[lst.mc1],
		Polygon[lst.mc2],Polygon[lst.mc3],Polygon[lst.mc4], 
		Polygon[lst.ma1.mmm],Polygon[lst.ma2.mmm],
		Polygon[lst.ma3.mmm],Polygon[lst.ma4.mmm],
		Polygon[lst.mb1.mmm],Polygon[lst.mb2.mmm],
		Polygon[lst.mb3.mmm],Polygon[lst.mb4.mmm],
		Polygon[lst.mc1.mmm],Polygon[lst.mc2.mmm],
		Polygon[lst.mc3.mmm],Polygon[lst.mc4.mmm]
	}]
]

FairDie[19]:=RhombicTriacontahedron

FairDie[20]:=DisdyakisDodecahedron

FairDie[21]:=TriakisIcosahedron

FairDie[22]:=PentakisDodecahedron

FairDie[23]:=DeltoidalHexecontahedron

FairDie[24]:=PentagonalHexecontahedron

FairDie[25]:=DisdyakisTriacontahedron

FairDie[26]:=Module[{
	n0={0,0,3},
	n5={0,0,-3},
	n2={2,0,1},
	n4={-2,0,1},
	n1={0,2,-1},
	n3={0,-2,-1}
	},
	Graphics3D[{
		Polygon[{n0,n1,n2}],
		Polygon[{n0,n1,n4}],
		Polygon[{n1,n2,n5}],
		Polygon[{n0,n2,n3}],
		Polygon[{n1,n4,n5}],
		Polygon[{n2,n3,n5}],
		Polygon[{n0,n3,n4}],
		Polygon[{n3,n4,n5}]
	}]
]

FairDie[27]:=Module[{
	n0={0,0,3},
	n9={0,0,-3},
	n1={2,0,0},
	n2={Sqrt[2],Sqrt[2],0},
	n3={0,2,0},
	n4={-Sqrt[2],Sqrt[2],0},
	n5={-2,0,0},
	n6={-Sqrt[2],-Sqrt[2],0},
	n7={0,-2,0},
	n8={Sqrt[2],-Sqrt[2],0}
	},
	Graphics3D[{
		Polygon[{n0,n1,n2}],
		Polygon[{n0,n2,n3}],
		Polygon[{n0,n3,n4}],
		Polygon[{n0,n4,n5}],
		Polygon[{n0,n5,n6}],
		Polygon[{n0,n6,n7}],
		Polygon[{n0,n7,n8}],
		Polygon[{n0,n8,n1}],
		Polygon[{n9,n1,n2}],
		Polygon[{n9,n2,n3}],
		Polygon[{n9,n3,n4}],
		Polygon[{n9,n4,n5}],
		Polygon[{n9,n5,n6}],
		Polygon[{n9,n6,n7}],
		Polygon[{n9,n7,n8}],
		Polygon[{n9,n8,n1}]
	}]
]

FairDie[28]:=Module[{
	x=(3+Sqrt[3])/(3-Sqrt[3]),
	n0,n1,n2,n3,n4,n5,n6,n7
	},
	n0={0,0,x};
	n1={0,2,1};
	n2={-1,Sqrt[3],-1};
	n3={-Sqrt[3],-1,1};
	n4={-1,-Sqrt[3],-1};
	n5={0,0,-x};
	n6={2,0,-1};
	n7={Sqrt[3],-1,1};
	Graphics3D[{
		Polygon[{n0,n1,n2,n3}],
		Polygon[{n0,n1,n6,n7}],
		Polygon[{n1,n2,n5,n6}],
		Polygon[{n2,n3,n4,n5}],
		Polygon[{n0,n3,n4,n7}],
		Polygon[{n4,n5,n6,n7}] 
	}]
]

FairDie[29]:=Module[{
	n0={3,3,3},
	n1={-1,2,2},
	n2={-2,-2,1},
	n3={2,-1,2},
	n4={1,-2,-2},
	n5={-3,-3,-3},
	n6={-2,1,-2},
	n7={2,2,-1}
	},
	Graphics3D[{
		Polygon[{n0,n1,n2,n3}],
		Polygon[{n0,n1,n6,n7}],
		Polygon[{n1,n2,n5,n6}],
		Polygon[{n2,n3,n4,n5}],
		Polygon[{n0,n3,n4,n7}],
		Polygon[{n4,n5,n6,n7}]
	}]
]

FairDie[30]:=Module[{
	n0={0,0,3},
	n1={0,0,-3},
	n2={1.7,0,0},
	n3={1,1,0},
	n4={0,1.7,0},
	n5={-1,1,0},
	n6={-1.7,0,0},
	n7={-1,-1,0},
	n8={0,-1.7,0},
	n9={1,-1,0}
	},
	Graphics3D[{
		Polygon[{n0,n2,n3}],
		Polygon[{n0,n3,n4}],
		Polygon[{n0,n4,n5}],
		Polygon[{n0,n5,n6}],
		Polygon[{n0,n6,n7}],
		Polygon[{n0,n7,n8}],
		Polygon[{n0,n8,n9}],
		Polygon[{n0,n9,n2}],
		Polygon[{n1,n2,n3}],
		Polygon[{n1,n3,n4}],
		Polygon[{n1,n4,n5}],
		Polygon[{n1,n5,n6}],
		Polygon[{n1,n6,n7}],
		Polygon[{n1,n7,n8}],
		Polygon[{n1,n8,n9}],
		Polygon[{n1,n9,n2}]
	}]
]



End[]

(* Protect[  ] *)

EndPackage[]
