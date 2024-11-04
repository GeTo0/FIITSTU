(*:Mathematica Version: 4.1 *)

(*:Package Version: 1.28 *)

(*:Name: MathWorld`Graphs41` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Graphs41.m
*)

(*:Summary:
*)

(*:History:
  v1.00 (2000-01-08): Written
  v1.01 (2000-01-23): LabeledGraphs
  v1.02 (2000-01-24): Nicer embedding of LeviGraph and McGeeGraph.
                      Added CageGraph[n,g]
  v1.03 (2000-01-30): MooreGraphQ, ReadG
  v1.04 (2000-02-01): QuarticQ, QuniticQ
  v1.05 (2000-02-04): LabeledTrees
  v1.06 (2000-02-12): CirculantGraphQ, RecognizeGraph
  v1.07 (2000-02-15): Skeleton moved here and extended.
                      DodecahedralGraph, IcosahedralGraph.
  v1.08 (2000-02-17): CompleteBinaryTree, CompleteNaryTree
  v1.09 (2000-02-22): NonLineGraphs
  v1.10 (2000-02-23): OctahedralGraph, SquareGraph, TetrahedralGraph,
                      TriangleGraph.
  v1.11 (2000-02-27): OddGraph
  v1.12 (2000-02-28): BooleanAlgebra, CayleyTreeQ, CaterpillarGraphQ
  v1.13 (2000-03-01): FolkmanGraph, OreGraphQ
  v1.14 (2000-03-05): Reimplemented showGraph using options
  v1.15 (2000-03-11): IndpendenceNumber, MaximumCliqueSize, 
  v1.16 (2000-03-19): RobertsonGraph
  v1.17 (2000-03-21): ConnectedQ[k,g], PolyhedralQ
  v1.18 (2000-03-28): Trees13.m now computed (after 9.4 CPU days ;)
  v1.19 (2000-04-29): Theta0.
  v1.20 (2000-05-30): Leaves, RootedTrees.
  v1.21 (2000-08-03): Documentation updated.
  v1.22 (2000-08-07): Fixed syntax error for Digraphs[4]
  v1.23 (2000-08-11): AddEdges improved, ChvatalGraph, FranklinGraph,
                      HypohamiltonianQ, HoffmanSingletonGraph, MeredithGraph,
                      ThomassenGraph
  v1.24 (2000-08-26): HamiltonConnectedQ, HamiltonianPath, HypotraceableQ,
                      TraceableQ
  v1.25 (2000-09-08): GrayGraph
  v1.26 (2001-03-21): Renamed CoxetersGraph to CoxetersUnitransitiveGraph
  v1.27 (2002-02-05): Documentation updated
  v1.28 (2003-10-18): Context added
  
  (c) 2000-2006 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Notes:

THIS PACKAGE IS OBSOLETE AND NO LONGER MAINTAINED.  YOU SHOULD REALLY 
UPGRADE TO A MODERN VERSION OF MATHEMATICA IF YOU WANT THIS
FUNCTIONALITY.

A new version of this package that works with the New Combinatorica
that ships with Mathematica 4.2 is available at

	http://mathworld.wolfram.com/packages/Graphs.m
	
Mathematica 4.2 and up users should use that package instead, as
a number of the commands in this package have been incorporated
into the new Combinatorica and will cause shadowing errors.  Also, this
package manipluates raw Graph sturctures which breaks under the
new Cmobinatorica structure for Graph.

*)

(*:Requirements:
If you want to work with n-node graphs or trees,
you will probably want to download the following pre-computed lists
from http://mathworld.wolfram.com/packages/:
	
	Graphs4.m, Graphs5.m, Graphs6.m, Graphs7.m,
	Digraphs4.m, Digraphs5.m,
	Trees7.m, Trees8.m, Trees9.m, Trees10.m, Trees11.m, Trees12.m, Trees13.m
	
You will need to modified the Directory parameter in Options[Graphs] to 
indicate where these files are located on your system.

Also, you will need to download
	
	http://mathworld.wolfram.com/packages/Platonic.m
	http://mathworld.wolfram.com/packages/PolyhedronOperations.m

if you want to use DodecahedralGraph, IcosahedralGraph, or Skeleton.
Otherwise, comment the above two packages out of the BeginPackage statement.

*)

(*:Discussion:

To convert from Combinatorica 1 to 2 format, use a replacement like

  Graphs[3] /.Graph[l_List,e_]:>FromAdjacencyMatrix[l]

The following need to be upgraded for Combinatorica 2:

  Trees

*)

(*:References: *)

(*:Limitations: 
The brute-force approach to enumerating graphs is much too inefficient.
IsomorphicQ-ing a huge list takes forever and a day.
With more clever record-keeping and preprocessing using graph invariants,
it should be possible to compute graphs much more quickly, and therefore
go beyond the current practical maximum of 7 nodes.

RootedTrees currently includes some duplications and is still under construction.
*)


BeginPackage["MathWorld`Graphs41`",
	{
	"DiscreteMath`Combinatorica`",
	"Graphics`Colors`",
	"MathWorld`Platonic`",					(* These two needed for Dodecahedral Graph, *)
	"MathWorld`PolyhedronOperations`"			(* Icosahedral Graph, Skeleton, etc. *)
	}
]


AddEdges::usage =
"AddEdges[g,edges] recursively adds edges {e11,e12},{e21,e22},... to g \
and returns the result.  edges can also contain lists of lists, e.g., \
{{e1,e2,e3}} -> {{e1,e2},{e2,e3}}"

Arrowhead::usage =
"Arrowhead[{v12,v2}] gives an images of an arrowhead appropriate for \
nice display of digraphs."

BicenteredTrees::usage =
"BicenteredTrees[n] gives a list of bicentered trees on n nodes."

BooleanAlgebra::usage =
"BooleanAlgebra[n] gives the Hasse diagram for the boolean algebra on \
n elements."

CageGraph::usage =
"CageGraph[n,g] for gives the smallest n-regular graph of girth g. \
CageGraph[g] gives CageGraph[3,g]."

CaterpillarGraphQ::usage =
"CaterpillarGraphQ[g] returns True if g is a caterpillar graph."

CayleyTreeQ::usage =
"CayleyTreeQ[g,n] returns True if g is an n-Cayley tree."

CenteredTrees::usage =
"CenteredTrees[n] gives a list of centered trees on n nodes."

ChvatalGraph::usage =
"ChvatalGraph gives an embedding of the Chv\[AAcute]tal graph."

CirculantGraphQ::usage =
"CirculantGraphQ[g] returns True if g is a circulant graph."

CompleteBinaryTree::usage =
"CompleteBinaryTree[n] returns a complete binary tree on n nodes."

CompleteNaryTree::usage =
"CompleteNaryTree[n,b] returns a complete b-ary tree on n nodes."

ConnectedGraphs::usage =
"ConnectedGraphs[n] gives a list of the n-node connected graphs."

ConnectedQ::usage =
"ConnectedQ[g] yields True if undirected graph g is connected. ConnectedQ[g, \
Directed] and ConnectedQ[g, Undirected] yields True if g is strongly or \
weakly connected, respectively.  In the Graphs` package, the function is \
extended to ConnectedQ[k,g], which returns True if g is k-connected."

CubicalGraph::usage =
"CubicalGraph gives a Graph object corresponding to the cubical graph."

CubicQ::usage =
"CubicQ[g] returns True if g is a cubic graph."

Digraphs::usage =
"Digraphs[n] gives a list of the nonisomorphic unlabeled simple digraphs \
on n vertices with standard embedding."

DodecahedralGraph::usage =
"DodecahedralGraph gives an embedding of the dodecahedral graph."

EdgeColors::usage =
"EdgeColors->colors_list is an option for showGraph."

FolkmanGraphConstruction::usage =
"FolkmanGraphConstruction gives an embedding of the Folkman graph."

FranklinGraph::usage =
"FranklinGraph gives an embedding of the Franklin graph."

FruchtGraphConstruction::usage =
"FruchtGraphConstruction gives an embedding of the Frucht graph."

GraphicalPartitionQ::usage =
"GraphicalPartitionQ[g] returns True if g is a graphical partition."

GraphicalPartitions::usage =
"GraphicalPartitions[n] gives a list of graphical partitions on n nodes."

GraphicalPartitionsCount::usage =
"GraphicalPartitionsCount[n] gives the number of graphical partitions \
whose degrees sum to n."

Graphs::usage =
"Graphs[n] gives a list of the nonisomorphic unlabeled simple graphs \
on n vertices with standard embedding."

(*
GraphUnion::usage =
"GraphUnion[g1,g2,...] extends GraphUnion to an arbitrary number of \
graphs."
*)

GrayGraph::usage =
"GrayGraph gives a Graph object representing the Gray graph."

HamiltonConnectedQ::usage =
"HamiltonConnectedQ[g] returns True if g is Hamilton-connected."

HamiltonianPath::usage =
"HamiltonianPath[g] returns a Hamiltonian path of the graph g if it exists.  \
HamiltonianPath[g,All] returns all Hamiltonian paths of the given graph.  The \
routine used is a hacked version of HamiltonianCycle."

HeawoodGraph::usage =
"HeawoodGraph gives a Graph object representing the Heawood graph."

HoffmanSingletonGraph::usage =
"HoffmanSingletonGraph gives a Graph object representing the Hoffman-Singleton \
graph."

HypohamiltonianQ::usage =
"HypohamiltonianQ[g] returns True if g is hypohamiltonian."

HypotraceableQ::usage =
"HypotraceableQ[g] returns True if g is hypotraceable."

IcosahedralGraph::usage =
"IcosahedralGraph gives an embedding of the icosahedral graph."

IndependenceNumber::usage =
"IndependenceNumber[g] gives the independence number of g."

LabeledGraphs::usage =
"LabeledGraphs[n] gives a list of the labeled simple graphs \
on n vertices with standard embedding."

LabeledTrees::usage =
"LabeledTrees[n] gives a list of the labeled simple trees \
on n vertices."

Leaves::usage =
"Leaves[g] gives the number of leaves in graph g."

LeviGraph::usage =
"LeviGraph gives a Graph object representing the Levi graph."

LeviGraph2::usage =
"LeviGraph2 gives a Graph object representing an alternative embedding \
of the Levi graph."

MakeLoopless::usage =
"MakeLoopless[g] returns a Graph object equivalent to g but with loops removed."

MaximumCliqueSize::usage =
"MaximumCliqueSize[g] gives the size of the largest clique in g."

McGeeGraph::usage =
"McGeeGraph gives a Graph object representing the McGee graph."

McGeeGraph2::usage =
"McGeeGraph2 gives a Graph object representing an alternative \
embedding of the McGee graph."

MeredithGraph::usage =
"MeredithGraph gives a Graph object representing the Meredith graph."

MooreGraphQ::usage =
"MooreGraphQ[g] returns True if g is a Moore graph."

NonadjacentVertexPairs::usage =
"NonadjacentVertexPairs[g] gives a list of nonadjacent vertex pairs \
of g."

NonLineGraphs::usage =
"NonLineGraphs gives a list of the six non-line graphs."

OctahedralGraph::usage =
"OctahedralGraph gives a Graph object representing the \
octahedral graph."

OddGraph::usage =
"OddGraph[n] gives the odd graph of order n."

OreGraphQ::usage =
"OreGraphQ[g] returns True if g is an Ore graph."

PetersenGraph::usage =
"PetersenGraph gives a Graph object representing the Petersen graph."

PolyhedralQ::usage =
"PolyhedralQ[g] returns True if g is planar and 3-connected."

QuarticQ::usage =
"QuarticQ[g] returns True if g is a quartic graph."

QuinticQ::usage =
"QuinticQ[g] returns True if g is a quintic graph."

RamseyNumber::usage =
"RamseyNumber[m,n] computes the Ramsey number R(m,n)."

ReadG::usage =
"ReadG[file] reads a file created with the command readg -a > file."

RecognizeGraph::usage =
"RecognizeGraph[g] returns a simple form of the embedding of graph g \
if it exists."

RobertsonGraph::usage =
"RobertsonGraph gives the Robertson graph."

RootedTrees::usage =
"RootedTrees[n] gives the rooted trees of order n.  It currently includes some \
duplications and is still under construction."

showGraph::usage =
"showGraph[{{a1,...},{v1,...}},<graphopts>] is a replacement for \
ShowGraph with more user-friendly option passing.  It returns, \
but does not display, a Graphics object.  PlotStyles->{} can \
contain Graphics primitives such as PointSize[], Thickness[], etc. \
EdgeColors->colors_list and VertexColors->colors_list can also be passed. \
showGraph[{{a1,...},{v1,...}},Directed,<graphopts>] plots a \
directed graph.  graphopts can include PointSize[.05], etc."

showLabeledGraph::usage =
"showLabeledGraph[{a1,...},{v1,...},l,r,<graphopts>] is a replacement for \
ShowGraph with more user-friendly option passing.  l is the vertex \
labels, and r is the fractional radius by which to increase the text \
coordinates.  graphopts can include PointSize[.05], etc."

Skeleton::usage =
"Skeleton[poly] gives the Graph object corresponding to the \
given polyhedron using a circular embedding.  Skeleton[poly,h] \
constructs the embedding by projecting the vertices from a height \
z=h onto the plane z=0."

SquareGraph::usage =
"SquareGraph returns a Graph object representing the square graph."

StandardEmbedding::usage =
"StandardEmbedding[{{a1,...},...}] returns a Graph object having the \
specified adjacency matrix and standard embedding."

TetrahedralGraph::usage =
"TetrahedralGraph gives an embedding of the tetrahedral graph."

Theta0::usage =
"Theta0 gives the theta-0 graph."

ThomassenGraph::usage =
"ThomassenGraph gives an embedding of the Thomassen graph."

TopologicalGraph::usage =
"TopologicalGraph[g] returns the topologically reduced graph having \
minimal number of nodes."

TopologicalGraphList::usage =
"TopologicalGraphList[g] returns the sequence of topologically \
reduced graphs with the last one having minimal number of nodes."

TopologicalGraphs::usage =
"TopologicalGraphs[n] returns a list of topologically equivalent graphs on \
n nodes."

TopologicalReduce::usage =
"TopologicalReduce[g] returns a topologically equivalent graph \
having one fewer nodes than g if it exists.  Otherwise, g itself \
is returned."

TraceableQ::usage =
"TraceableQ[g] returns True if g is a traceable graph (i.e., it has a Hamiltonian path)."

TransitiveDigraphQ::usage =
"TransitiveDigraphQ[g] returns True if g is a transitive digraph."

TreeMinimumWeight::usage =
"TreeMinimumWeight[g] gives the minimum weight of a given tree."

Trees::usage =
"Trees[n] gives a list of the nonisomorphic unlabeled simple trees \
on n nodes with standard embedding."

TreeWeights::usage =
"TreeWeights[t] gives a list of the weights, where the weight of \
a given node is the maximum number of edge in any branch at the node."

TriangleGraph::usage =
"TriangleGraph returns a Graph object representing the triangle graph."

TriangleQ::usage =
"TriangleQ[edge-list,edge] returns True if belongs to a cycle of \
length 3."

UnitransitiveGraphConstruction::usage =
"UnitransitiveGraphConstruction gives a Graph object representing Coxeter's \
3-unitransitive graph."

UtilityGraph::usage =
"UtilityGraph is a synonym for CompleteGraph[3,3]."

VertexColors::usage =
"VertexColors->colors_list is an option for showGraph."

VertexDegrees::usage =
"VertexDegrees[g] gives a list of the vertex degrees in the same order \
as the vertices are listed."


(* Options *)

(* Set the directory in which pre-computed graphs are kept here *)

Options[Graphs]={
	Directory->If[$OperatingSystem == "MacOS",
      "Phosphine:Mathematica Files:Notebooks:Math:",
      "/home/usr0/eww/packages/math/"
    ],
    EdgeColors->{Black},
    PlotStyles->{},
    VertexColors->{Black}
}


Begin["`Private`"]


(** AddEdges **)

(*
AddEdges[g0_Graph,e_List]:=Module[{g=g0},
    FoldList[(g=AddEdge[g,#2])&,g,e];
    g
]

*)

AddEdges[g0_Graph,e0_List]:=Module[{g=g0,e=Flatten[Partition[#,2,1]&/@e0,1]},
    FoldList[(g=AddEdge[g,#2])&,g,e];
    g]


(** Arrowhead **)

Arrowhead[v_List] := Module[{r = .8, l = .3, w = .1, u, tip, base},
    tip = v[[1]] + r(v[[2]] - v[[1]]);
    u = #/Sqrt[#.#] &[v[[2]] - v[[1]]];
    base = tip - l u;
    Polygon[{tip, base + w{u[[2]], -u[[1]]}, base - w{u[[2]], -u[[1]]}}]
]


(** Bicentered Trees **)

BicenteredTrees[n_Integer?Positive]:=
  BicenteredTrees[n]=Select[Trees[n],Length[GraphCenter[#]]==2&]


(** Boolean Algebra **)

BooleanAlgebra[n_]:=
  HasseDiagram[
    MakeGraph[Subsets[n],((Intersection[#2,#1]===#1)&&(#1!=#2))&]]

(** Cage Graphs **)

CageGraph[g_]:=CageGraph[3,g]

CageGraph[3,3]:=CompleteGraph[4]
CageGraph[3,4]:=CompleteGraph[3,3]
CageGraph[3,5]:=PetersenGraph
CageGraph[3,6]:=HeawoodGraph
CageGraph[3,7]:=McGeeGraph
CageGraph[3,8]:=LeviGraph

CageGraph[3,10]:=Module[{p,i},
    p=GraphUnion[CirculantGraph[20,{6}],Cycle[50]];
    MakeUndirected[AddEdges[p,Join[
            Table[{7+5i,32+5i},{i,3,7}],
            Table[{20+10i,10i+29},{i,4}],
            Table[{15+10i,10i+24},{i,4}],
            {{21,20},{1,23},{70,29},{24,65}},
            Flatten[Table[{2i+j,21+5i+2j},{j,0,1},{i,9}],1]]
          ]/.Graph[l_List,v_List]:>
          Graph[l,Join[Table[{Cos[#],Sin[#]}&[2.Pi (i+1/2)/20],{i,20}],
              2 Table[{Cos[#],Sin[#]}&[2.Pi (i+1/2)/50],{i,50}]]]]]

CageGraph[4,3]:=CompleteGraph[5]
CageGraph[4,4]:=CirculantGraph[8,{1,3}]
CageGraph[4,5]:=AddEdges[Cycle[19],Flatten[Partition[#,2,1,1]&/@{
  	{1,5,10,14,18,3,7,11,16},
	{2,9,17,6,13},
	{19,8,15,4,12}
	},1]
]
CageGraph[4,6]:=MakeUndirected[
    MakeGraph[Range[26],
      Mod[#1-#2,26]==1||
          (-1)^#1Mod[#1-#2,26]==11||
          (-1)^#1Mod[#1-#2,26]==7&]
]

CageGraph[5,3]:=CompleteGraph[6]
CageGraph[5,4]:=CirculantGraph[10,{1,3,5}]
CageGraph[5,5]:=MakeUndirected[AddEdges[MakeGraph[Range[30],
        (Mod[#1-#2,30]==1||
              (Mod[#1-#2,30]==15&&Mod[#1,3]==0)||
              (Mod[#1-#2,30]==4&&Mod[#1,2]==0)
            )&],{{1,9},{1,13},{1,19},{2,16},{3,11},{3,18},{3,25},{4,20},{5,
          17},{5,23},{5,27},{6,21},{7,15},{7,19},{7,25},{8,22},{9,17},{9,
          24},{10,26},{11,23},{11,29},{12,27},{13,21},{13,25},{14,28},{15,
          23},{15,30},{17,29},{19,27},{21,29}}]]
CageGraph[5,6]:=MakeUndirected[MakeGraph[Range[42],
	(Mod[#1-#2,42]==1||
	(MemberQ[{7,27,31},Mod[#1-#2,42]]&&Mod[#1,2]==1)||
	(MemberQ[{11,15,35},Mod[#1-#2,42]]&&Mod[#1,2]==0))&]
]


(** Caterpillar Graph **)

CaterpillarGraphQ[g_Graph?TreeQ]:=
  Module[{d=VertexDegrees[g],a=ToAdjacencyLists[g],f},
    Max[Length/@
          Function[f,Select[f,#>1&]]/@
            Map[Length,
              a[[#]]&/@a[[#]]&/@
                Flatten[Position[d,_?(#>2&)]],{2}]]<3
    ]

(** Cayley Tree **)

CayleyTreeQ[g_Graph?TreeQ,n_]:=Union[DegreeSequence[g]]==={1,n}


(** Centered Trees **)

CenteredTrees[n_Integer?Positive]:=
  CenteredTrees[n]=Select[Trees[n],Length[GraphCenter[#]]==1&]

(** Chvatal Graph **)

circularVertices2[n_]:=Module[{i},
    Table[Through[{Cos,Sin}[2.Pi i/n+Pi/2]],{i,n}]
    ]

ChvatalGraph:=
  AddEdges[ChangeVertices[GraphUnion[EmptyGraph[5],Cycle[5],EmptyGraph[2]],
      Join[circularVertices2[5],2circularVertices2[5],
        .3{{-1,0},{1,0}}]],
    {{6,5},{5,9},{9,3},{3,7},{7,1},{1,10},{10,4},{4,8},{8,2},{2,6},{2,11},{11,
        5},{5,12},{12,3},{11,1},{1,12},{12,4},{4,11},{2,3}}
]

(** Circulant Graphs **)

CirculantGraphQ[g_Graph]:=Module[{n=V[g]},
    (Select[Rest[Subsets[Range[n/2]]],IsomorphicQ[CirculantGraph[n,#],g]&,
        1]!={})
]

circularVertices[n_]:=Module[{i},
	Table[{Cos[#],Sin[#]}&[2Pi i/n],{i,0,n-1}]]

(** Complete n-ary Trees **)

(* this routine takes an n-ary number and removes any zeros by borrowing.
   e.g. {1,2,0} becomes {1,1,3}
*)

nary[0,b_]:={}
nary[n_,b_]:=Module[{d=IntegerDigits[n,b],p},
    While[(p=Flatten[Position[d,_?NonPositive]])!={},
      d[[Last[p]]]+=b;
      d[[Last[p]-1]]-=1;
      If[First[d]==0,d=Rest[d]];
      ];
    d
]

CompleteBinaryTree[n_]:=RootedEmbedding[
    MakeGraph[Range[n],
    	((Length[IntegerDigits[#1,2]]== Length[IntegerDigits[#2,2]]-1)&&
        (IntegerDigits[#1,2]== Drop[IntegerDigits[#2,2],-1]))&
    ],
1]

CompleteNaryTree[n_,b_]:=RootedEmbedding[
    MakeGraph[Range[n],
      ((Length[nary[#1-1,b]]==Length[nary[#2-1,b]]-1)&&
      (nary[#1-1,b]==Drop[nary[#2-1,b],-1]))&
    ],
1]

(** Connected Graphs **)

Unprotect[ConnectedQ];
ConnectedQ[k_Integer?Positive,g_Graph]:=VertexConnectivity[g]>=k
Unprotect[ConnectedQ];

ConnectedGraphs[n_]:=ConnectedGraphs[n]=Select[Graphs[n],ConnectedQ]


(** Cubical Graph **)

CubicalGraph:=Module[{i},
	AddEdges[GraphUnion[2,Cycle[4]],
      Table[{i,i+4},{i,4}]] /.Graph[l_List,v_List]:>
      Graph[l,Join[CircularVertices[4],2CircularVertices[4]]]
]


(** CubicQ **)

CubicQ[g_Graph]:=Union[DegreeSequence[g]]=={3}


(** Digraphs **)

Digraphs[n_Integer?(4<=#<=4&)] := Digraphs[n] = Module[
	{dir=Directory/.Options[Graphs]},
    Get[dir <> "Digraphs"<>ToString[n]<>".m"] /. Graph :> StandardEmbedding
]

(* Runs out of memory trying to do 5.  This should be made more clever so that it 
uses graphs on the next smallest number of nodes.
*)

Digraphs[n_] := Digraphs[n] = Module[{p, i},
      p = Subsets /@ Table[Complement[Range[n], {i}], {i, n}];
      Union[
        FromAdjacencyLists /@ Flatten[Outer[List, Sequence @@ p, 1], n - 1],
        SameTest -> (IsomorphicQ[#1, #2] &)]
      ]

(** Dodecahedral Graph **)

DodecahedralGraph:=Skeleton[DodecahedronExact,1.8]


(** Folkman Graph **)

FolkmanGraphConstruction:=Module[{i},
    AddEdges[
      ChangeVertices[GraphUnion[5,Cycle[4]],
        Flatten[Table[i CircularVertices[4],{i,.2,1.,.2}],1]],
      Flatten[{Table[{{4i+3,4i+6},{4i+3,4i+8}},{i,0,3}],
          Table[{{4i+1,4i+10},{4i+1,4i+12}},{i,0,2}],
          {{{2,19},{19,4},{6,17},{8,17},{2,13},{13,4}}}
          },2]]
    ]

(** Franklin Graph **)

FranklinGraph:=AddEdges[Cycle[12],
	{{1,8},{2,11},{3,6},{4,9},{5,12},{7,10}}
]

(** Frucht Graph **)

FruchtGraphConstruction:=
	AddEdges[ChangeVertices[GraphUnion[Cycle[7],EmptyGraph[5]],
    Flatten[Join[CircularVertices[7],.4CircularVertices[4],{{{-.1,.05}}}],
      1]],{{5,10},{10,6},{10,12},{9,12},{4,9},{3,9},{12,8},{8,2},{8,11},{11,
      7},{11,1}}]        

(** Graphical Partition **)

GraphicalPartitionQ[g_Graph]:=PartitionQ[DegreeSequence[g]]

GraphicalPartitionsCount[n_Integer?Positive]:=
	Count[RealizeDegreeSequence/@Partitions[n],_Graph]

gp=Flatten[Table[Select[Graphs[n],GraphicalPartitionQ],{n,7}]];
GraphicalPartitions[n_Integer?Positive]:=
  GraphicalPartitions[n]=Select[gp,Tr[DegreeSequence[#]]==n&]
  
(** Generate graphs at random.  Inefficient is putting it mildly. **)

(*
  GraphMonteCarlo[n_, crit_, max_:100, its_:100] := 
    Union[Select[Table[RandomGraph[n, .5], {its}], 
        Head[#] \[Equal] Graph && crit[#] &], 
      SameTest \[Rule] (IsomorphicQ[#1, #2] &)]
*)

GraphMonteCarlo[n_, crit_, max_:100, its_:100, l0_:{}] := 
  Module[{l = l0, i = 0, g},
    While[Length[l] < max && i < its,
      i++;
      If[Head[#] \[Equal] Graph && crit[#] &[g = RandomGraph[n, .5]],
        l = Union[l, {g}, SameTest -> (IsomorphicQ[#1, #2] &)]
        ]
      ];
    l
]

(** Graphs **)

(* Brute-force compute all possible edge combinations. *)

graphs[n_]:=Module[{v=CircularVertices[n]//N},
    Union[FromUnorderedPairs[#,v]&/@UnorderedPairs[n],
      SameTest->(IsomorphicQ[#1,#2]&)]
]

(* Use graphs of previously smallest order to exclude _many_ cases which are already 
known to be isomorphic for n=5,this gives a speedup from 400 s to 40 s. In particular, 
the number of cases which need to be checked for graphs of order n is 
subsets(n-1)=2^(n-1) \[Times] [number of graphs of order n-1]
Flatten[#,1]&/@Outer[List,Subsets[n-1],{n}] gives all combinations of edges with a 
new edge.  Outer[List,ToUnorderedPairs/@AllGraphs[n-1],%] makes all combinations of 
edges including the new edge n with graphs of order n-1 already known to be nonisomorphic.
FromUnorderedPairs creates the graphs from the lists of edges.
Union keeps only nonisomorphic graphs.
*)

savedgraphs=7;

Graphs[1]:={Graph[{{0}},{{1.,0.}}]}

Graphs[2]:={Graph[{{0, 0}, {0, 0}}, {{-1., 0.}, {1., 0.}}], 
  Graph[{{0, 1}, {1, 0}}, {{-1., 0.}, {1., 0.}}]}

Graphs[n_Integer?(3<=#<=savedgraphs&)]:=Graphs[n]=Module[
	{dir=Directory/.Options[Graphs]},
	Get[dir<>"Graphs"<>ToString[n]<>".m"] /. Graph:>StandardEmbedding
]

(*
Graphs[n_Integer]:=Graphs[n]=Module[{v,i},
      v=CircularVertices[n]//N;
      Union[
        FromUnorderedPairs[#,v]&/@Apply[Union,
            Flatten[Outer[List,ToUnorderedPairs/@Graphs[n-1],
                Flatten[#,1]&/@Outer[List,Subsets[n-1],{n}],1],1],1],
        SameTest->(IsomorphicQ[#1,#2]&)]
      ]
 *)
 
group[l_,f_]:=Split[Sort[l,f[#1]<f[#2]&],f[#1]==f[#2]&]

Graphs[n_Integer]:=Graphs[n]=Module[{v,l},
      v=CircularVertices[n]//N;
      l=FromUnorderedPairs[#,v]&/@
          Apply[Union,
            Flatten[Outer[List,ToUnorderedPairs/@Graphs[n-1],
                Flatten[#,1]&/@Outer[List,Subsets[n-1],{n}],1],1],1];
      Print["Found "<>ToString[Length[l]]<>" possible graphs on "<>ToString[n]<>" nodes."];
      Print["Partitioning by number of edges..."];
      l=group[l,M];
      Print["Partitioning by diameter..."];
      Print[Timing[l=Map[group[#,Diameter]&,l,{1}]][[1]]];
      Print["Partitioning by radius..."];
      Print[Timing[l=Map[group[#,Radius]&,l,{2}]][[1]]];
      Print["Partitioning by girth..."];
      Print[Timing[l=Map[group[#,Girth]&,l,{3}]][[1]]];
      Print["Computing nonisomorphic graphs in each class..."];
      Flatten[Map[Union[#,SameTest->IsomorphicQ]&,l,{4}]]
]

(** Extend GraphUnion to accept any number of graphs **)

Unprotect[GraphUnion]
GraphUnion[g__Graph]:=Fold[GraphUnion,First[{g}],Rest[{g}]]
Protect[GraphUnion]

(** Gray Gray **)

GrayGraph := MakeUndirected[MakeGraph[Range[54],
      Mod[#2 - #1, 54] == 1 ||
          (Mod[#1, 6] == 1 && Mod[#2 - #1, 54] == 25) ||
          (Mod[#1, 6] == 2 && Mod[#2 - #1, 54] == 29) ||
          (Mod[#1, 6] == 5 && Mod[#2 - #1, 54] == 7) ||
          (Mod[#1, 6] == 3 && Mod[#2 - #1, 54] == 13) &]]

(** Hamilton Connected **)

HamiltonConnectedQ[g_Graph]:=Equal[
    Union[Sort/@({First[#],Last[#]}&/@HamiltonianPath[g,All])],
    KSubsets[Range[V[g]],2]]

(** Hamiltonian Path **)

HamiltonianPath[g_Graph,flag_:One]:=
  Module[{s,all,done,adj=Edges[g],e=ToAdjacencyLists[g],x,v,ind,n=V[g],
      paths={}},
    ind=Table[1,{n}];
    Do[s={k};
      all={};
      While[Length[s]>0,
        v=Last[s];
        done=False;
        While[ind[[v]]<=Length[e[[v]]]&&!done,
          If[!MemberQ[s,
            (x=e[[v,ind[[v]]++]])],
            done=True]
        ];
        If[done,AppendTo[s,x],s=Drop[s,-1];ind[[v]]=1];
        If[(Length[s]==n),
          AppendTo[all,s];
          If[SameQ[flag,All],s=Drop[s,-1],all=Flatten[all];s={}];
        ]
      ];
      If[all!={},AppendTo[paths,all]];
      If[SameQ[flag,One]&&Flatten[paths]!={},Break[]],
      (* can skip one vertex since will have already found the 
      path in the opposite direction *)
    {k,n-1}
    ];
	Union[If[#[[1]]<#[[-1]],#,Reverse[#]]&/@
		If[SameQ[flag,One],paths,Flatten[paths,1]]]
]


(** Heawood Graph **)

HeawoodGraph:=MakeUndirected[MakeGraph[
    Range[14],(Mod[(-1)^(#1)(#1-#2),14]==5||Abs[Mod[#1-#2,14]]==1)&]]

(** Hoffman-Singleton **)

ArrayOfFive[g_,sgn_,ang_]:=Module[{i},
    GraphUnion[
      Sequence@@Table[
          ChangeVertices[g,
            Table[Through[{Cos,Sin}[sgn 2Pi i/5+ang]],{i,5}]],{5}]]
]

HoffmanSingletonGraph:=Module[{stars,cycles,g,v,i,j,k},
    stars=ArrayOfFive[CirculantGraph[5,{2}],-1,7Pi/10];
    cycles=ArrayOfFive[Cycle[5],1,-3Pi/10];
    v=Vertices[g=GraphUnion[stars,cycles]];
    g=ChangeVertices[g,Join[Take[v,25],{-14.5,-3}+#&/@Take[v,-25]]];
    AddEdges[g,
      Flatten[Table[{5j+i+1,26+5k+Mod[i+j k,5]},{i,0,4},{j,0,4},{k,0,4}],2]]
]

(** Hypohamiltonian **)

HypohamiltonianQ[g_Graph]:=!HamiltonianQ[g]&&
    HamiltonianQ/@And@@(DeleteVertex[g,#]&/@Range[V[g]])


(** Hypotraceable **)

HypotraceableQ[g_Graph]:=False /; TraceableQ[g]

HypotraceableQ[g_Graph]:=TraceableQ/@And@@(DeleteVertex[g,#]&/@Range[V[g]])


(** Icosahedral Graph **)

IcosahedralGraph:=Skeleton[IcosahedronExact2,.9]


(** Independence Number **)

IndependenceNumber[g_Graph]:=Length[MaximumIndependentSet[g]]


(** Labeled Graphs **)

LabeledGraphs[n_]:=Module[{v=CircularVertices[n]//N},
    FromUnorderedPairs[#,v]&/@UnorderedPairs[n]
]

(** Labeled Trees **)

LabeledTrees[n_Integer?(#<=savedgraphs&)]:=
	RootedEmbedding[#,1]&/@Select[LabeledGraphs[n],TreeQ]

(*
LabeledTrees[1]:={Graph[{{0}},{{0.,0.}}]}

LabeledTrees[2]:={Graph[{{0,1},{1,0}},{{0.,0.},{0.,-1.}}]}
*)

LabeledTrees[n_Integer?(#>savedgraphs&)]:=
  CodeToLabeledTree/@Flatten[Outer[List,Sequence@@Table[Range[n],{n-2}]],n-3]

(* Leaves *)

Leaves[g_Graph]:=Count[DegreeSequence[g],1]

(** Levi Graph **)

LeviGraph:=MakeUndirected[MakeGraph[Range[30],
	(Mod[(-1)^(#1)(#1-#2),30]==7&&(Mod[#1,6]==1||Mod[#1,6]==2))
	||(Mod[(-1)^(#1)(#1-#2),30]==17&&(Mod[#1,6]==4||Mod[#1,6]==5))
	||(Mod[(-1)^(#1)(#1-#2),30]==9&&(Mod[#1,3]==0)
	||(Mod[#1-#2,30]==1))&]]
                      
LeviGraph2:=Module[{i,c=CircularVertices[10]},
    MakeUndirected[
      AddEdges[GraphUnion[AddEdges[
              AddEdges[GraphUnion[Cycle[10],EmptyGraph[10]],
                Table[{i,i+10},{i,10}]],
              Table[{i+10,i+15},{i,5}]
              ],
            MakeGraph[Range[10],(Mod[#1-#2,10]==3)&]
            ],Table[{10+i,20+i},{i,10}]] /. 
        Graph[a_List,v_List]:>Graph[a,Join[2c,1.5c,c]]
      ]
    ]


(** Make Loopless **)

(* same as RemoveSelfLoops? *)

MakeLoopless[Graph[l_List,v_List]]:=Module[{i},
    Graph[Table[ReplacePart[l[[i]],0,i],{i,Length[l]}],v]
]


(** Maximum Clique Size **)

MaximumCliqueSize[g_Graph]:=Length[MaximumClique[g]]


(** McGee graph **)

McGeeGraph:=MakeUndirected[MakeGraph[Range[24],(
          Mod[{#1,#2},3]=={0,0}&&Abs[#1-#2]==12
            ||Mod[#1-#2,24]==1
            ||((Mod[(-1)^(#1)(#1-#2),24]==17||
                    Mod[(-1)^(#1)(#1-#2),24]==7)&&Mod[#1,3]!=0&&
                Mod[#2,3]!=0)
          )&]]

McGeeGraph2:=Module[
	{
	mcg,i,edges,
	vs={5,6,7,8,1,2,3,4},
	r1=1,r2=1.5,r3=2,
	c=CircularVertices[8]
	},
	mcg=MakeUndirected[
		GraphUnion[MakeGraph[Range[8],Mod[#1-#2,8]==3&],Cycle[8],EmptyGraph[8]] /.
		 Graph[l_List,v_List]:>Graph[l,Join[r1 c,r3 c,r2 c]]
	];
	edges=Flatten[Table[{
		16+{i,vs[[i]]},
		{i,i+16},
		{i+8,i+16}
		},
		{i,8}],1];
	MakeUndirected[AddEdges[mcg,edges]]
]

(** Meredith Graph **)

BipartiteRotate[r_,c_,t_,t0_]:=
  r{Cos[t+t0],Sin[t+t0]}+{{Cos[t],-Sin[t]},{Sin[t],Cos[t]}}.(#-c)&/@
    Vertices[CompleteGraph[4,3]]

MeredithGraph:=Module[{i,g},
    g=GraphUnion@@Table[CompleteGraph[4,3],{10}];
    g=ChangeVertices[g,Flatten[Join[
		Table[BipartiteRotate[5,{10/7,0},2Pi i/5.,Pi],{i,5}],
		Table[BipartiteRotate[10,{10/7,0},2Pi i/5.+Pi/5,0],{i,5}]
		],1]
	];
    AddEdges[g,Flatten[Join[
		Table[{
			{i+1,If[i<=21,i+49,i+14]},
			{i,If[i<=21,i+50,i+15]}},
		{i,2,30,7}],
        {{{4,22},{25,8},{15,32},{18,1},{29,11},
        {43,39},{36,67},{64,60},{57,53},{50,46}}}
	],1]]
]

(** Moore Graph **)

MooreGraphQ[g_Graph]:=Module[{d=Diameter[g]},
	d<Infinity && Equal[Girth[g],2d+1]
]


(** Nonadjacent Vertex Lists **)

NonadjacentVertexLists[g_Graph]:=Module[{h,f,n=V[g]},
    Fold[Function[{h,f},Select[h,Length[Intersection[f,#]]<2&]],
      Subsets[Range[n]],ToUnorderedPairs[g]]
    ]

NonadjacentVertexPairs[g_Graph]:=Module[{n=V[g]},
    Complement[KSubsets[Range[n],2],ToUnorderedPairs[g]]
    ]

NonadjacentVertexPairsDegreeSums[g_Graph]:=
  Plus@@@(VertexDegrees[g][[#]]&/@NonadjacentVertexPairs[g])


(** Non-Line Graphs **)

NonLineGraphs:={
    Star[4],
    AddEdges[Star[5],{{1,2},{2,3}}],
    DeleteEdge[
      GraphJoin[GraphJoin[Cycle[3],EmptyGraph[1]],EmptyGraph[1]],{3,5}],
    AddEdges[
      DeleteEdge[DeleteEdge[GridGraph[2,3],{2,4}],{4,6}],{{1,4},{5,4}}],
    AddEdges[GraphUnion[GridGraph[2,1],Wheel[4]],{{2,3},{2,4}}],
    AddEdges[
      GraphUnion[GridGraph[2,1],TranslateVertices[GridGraph[1,2],{0,-1.5}],
        GridGraph[2,1]],{{1,3},{2,3},{1,4},{2,4},{4,5},{4,6},{3,5},{3,6}}],
    AddEdges[GraphUnion[Cycle[4],TranslateVertices[GridGraph[1,2],{0,-1.5}]],
        {{2,4},{1,6},{3,5}}
    ],
    AddEdges[
      GraphUnion[RotateVertices[Cycle[3],-Pi],Cycle[3]],{{2,4},{1,5},{2,5}}],
    Wheel[6]
}

(** Octahedral Graph **)

OctahedralGraph:=Graph[{{0,1,1,1,1,0},{1,0,1,1,0,1},{1,1,0,0,1,1},
	{1,1,0,0,1,1},{1,0,1,1,0,1},{0,1,1,1,1,0}},
	{{-0.343576,0},{-0.903278,-1.56452},{-0.903278,1.56452},
	{0.171788,-0.297546},{0.171788,0.297546},{1.80656,0}}
]

(* = Skeleton[Antiprism[3,Sqrt[6]/3],.6]*)


(** Odd Graph **)

OddGraph[n_]:=MakeGraph[KSubsets[Range[2n-1],n-1],
	(SameQ[Intersection[#1,#2],{}])&]


(** Ore Graph **)

OreGraphQ[g_Graph]:=Module[{s=NonadjacentVertexPairsDegreeSums[g]},
	(* And[] returns True, but s={} means there are _no_ nonadjacent vertices *)
	s=!={}&&And@@Thread[s>V[g]]
]


(** Petersen Graph **)

PetersenGraph:=Module[{p,i,l,v},
	p=GraphUnion[MakeGraph[Range[5],Mod[#1-#2,5]==2&],Cycle[5]];
	MakeUndirected[AddEdges[p,Table[{i,i+5},{i,5}]] /. Graph[l_List,v_List]:>
      Graph[l,Join[CircularVertices[5],1.5 CircularVertices[5]]]
    ]

]


(** Polyhedral Graph **)

PolyhedralQ[g_Graph]:=V[g]>3&&ConnectedQ[3,g]&&PlanarQ[g]


(** QuarticQ **)

QuarticQ[g_Graph]:=Union[DegreeSequence[g]]=={4}


(** QuinticQ **)

QuinticQ[g_Graph]:=Union[DegreeSequence[g]]=={5}

(** Ramsey Number *)

RamseyNumber[m_,n_]:=Module[{i=2,g={}},
    While[i<=7,
      If[(MaximumCliqueSize[#]>=m||IndependenceNumber[#]>=n)&/@
      	And@@Graphs[i],Return[i]
      ];
      i++;
      ]
    ]

(** Read graph **)

(*
ReadG[f_String] := 
  Module[{l = ToExpression[Characters /@ Drop[ReadList[f, String], 2]]},
    Graph[l, CircularVertices[Length[l]]]
]
*)

ReadG[f_String] := Module[{s = Append[ReadList[f, String], ""]},
    Graph[#, CircularVertices[Length[#]]] & /@ 
      ToExpression[
        Map[Characters, 
          Take[s, # + {2, -1}] & /@ 
            Partition[Flatten[Position[s, ""]], 2, 1], {2}]]
    ]


(** Recognize Graph **)

RecognizeGraph::type0="Graph is of type `1`";
RecognizeGraph::type1="Graph is of type `1`[`2`]";
RecognizeGraph::type2="Graph is of type `1`[`2`,`3`]";

RecognizeGraph[g_Graph]:=Module[{n=V[g],c,d},
	If[IsomorphicQ[g,PetersenGraph],
		Message[RecognizeGraph::type0,"PetersenGraph"];
		Return[PetersenGraph]
	];
    If[IsomorphicQ[g,EmptyGraph[n]],
      Message[RecognizeGraph::type1,"EmptyGraph",n];
      Return[g]
    ];
    If[IsomorphicQ[g,Path[n]],
      Message[RecognizeGraph::type1,"Path",n];
      Return[Path[n]]
    ];
    If[IsomorphicQ[g,CompleteGraph[n]],
      Message[RecognizeGraph::type1,"CompleteGraph",n];
      Return[CompleteGraph[n]]
    ];
    If[IsomorphicQ[g,Cycle[n]],Message[RecognizeGraph::type1,"Cycle",n];
      Return[Cycle[n]]
    ];
    If[n>=4&&IsomorphicQ[g,Wheel[n]],Message[RecognizeGraph::type1,"Wheel",n];
      Return[Wheel[n]]
    ];
    If[IsomorphicQ[g,Star[n]],
      Message[RecognizeGraph::type1,"Star",n];
      Return[Star[n]]
    ];
    If[TreeQ[g],
    	Message[RecognizeGraph::type0,"Tree"];
    	Return[RootedEmbedding[g,1]]
    ];
    c=Select[Rest[Subsets[Range[n/2]]],IsomorphicQ[CirculantGraph[n,#],g]&,
        1];
    If[c!={},
      Message[RecognizeGraph::type2,"CirculantGraph",n,First@c];
      Return[CirculantGraph[n,First@c]]
    ];
    d=Select[Divisors[n],#<=n/2&];
    c=Select[Rest[d],IsomorphicQ[GridGraph[#,n/#],g]&,1];
    If[c!={},
      Message[RecognizeGraph::type2,"GridGraph",First@c,n/First@c];
      Return[GridGraph[Sequence@@{#,n/#}&@(c[[1]])]]
    ];
    c=Select[d,IsomorphicQ[RegularGraph[#,n/#],g]&,1];
    If[c!={},
      Message[RecognizeGraph::type2,"RegularGraph",First@c,n/First@c];
      Return[RegularGraph[Sequence[{#,n/#}]&@(c[[1]])]]
    ];
    Return[g]
]

(** Robertson Graph **)

RobertsonGraph:=CageGraph[4,5]

(** Rooted Trees **)

(* need to eliminate cases which are isomorphic but include the same trees
in a different order, corresponding to partitions like {3,3} *)

RootedUnion[t__Graph]:=Module[{v=V/@{t}},
    RootedEmbedding[
      AddEdges[MakeUndirected[GraphUnion[EmptyGraph[1],GraphUnion[t]]],{1,#}&/@
          Rest[FoldList[Plus,1,v]]],1]
    ]

RootedTrees[1]:=Trees[1]
RootedTrees[n_]:=
  Flatten[Outer[RootedUnion,Sequence@@(RootedTrees/@#)]&/@Partitions[n-1]]

(*
  AddEdges[ChangeVertices[GraphUnion[EmptyGraph[4],Cycle[12],EmptyGraph[3]],
      Join[circularVertices[4],1.5circularVertices[12],
        2.5circularVertices[3]]],{{1,3},{1,5},{1,9},{1,13},{2,4},{2,8},{2,
        12},{2,16},{3,7},{3,11},{3,15},{4,6},{4,10},{4,14},{5,19},{6,17},{7,
        18},{8,19},{9,17},{10,18},{11,19},{12,17},{13,18},{14,19},{15,17},{16,
        18}}]
*)

(** showGraph **)

showGraph[g0_Graph,graphopts___] := Module[
	{
		v,
		vcolors=VertexColors/.{graphopts}/.Options[Graphs],
		ecolors=EdgeColors/.{graphopts}/.Options[Graphs],
		styles=PlotStyles/.{graphopts}/.Options[Graphs]
	},
	(* make unweighted *)
	g=RemoveSelfLoops[Graph[Edges[g0]/._?(#>1&):>1,Vertices[g0]]];
	v=Vertices[g];
	vcolors=Take[Flatten[Table[vcolors,{Ceiling[V[g]/Length[vcolors]]}]],V[g]];
	ecolors=Take[Flatten[Table[ecolors,{Ceiling[M[g]/Length[ecolors]]}]],M[g]];
    Graphics[{
    	Sequence@@styles,
        Transpose[{ecolors,Line[v[[#]]]&/@ToUnorderedPairs[g]}],
        Transpose[{vcolors,Point/@v}]
    },AspectRatio->Automatic,PlotRange->All]
]

(*
showGraph[Graph[adj_List, v_List],graphopts___] := Module[{},
    Graphics[{
    	graphopts,
        Point /@ v,
        Line[v[[#]]] & /@ Position[adj, 1]
    },AspectRatio->Automatic,PlotRange->All]
]
*)

showGraph[Graph[adj_List, v_List],Directed,graphopts___]:= Module[
	{styles=PlotStyles/.{graphopts}/.Options[Graphs]},
	Graphics[{
		Sequence@@styles,
        Point /@ v,
        {Line[v[[#]]], Arrowhead[v[[#]]]} & /@ Position[adj, 1]
    },AspectRatio->Automatic,PlotRange->All]
]

showLabeledGraph[Graph[adj_List, v_List],l0_List:{},r_:1,graphopts___]:=
	Module[{i,l=If[l0=={},Range[Length[v]],l0]},
    Graphics[{
    	graphopts,
        Point /@ v,
        Line[v[[#]]] & /@ Position[adj, 1],
        Table[Text[ToString[l[[i]]],(1+r)v[[i]]],{i,Length[v]}]
    },AspectRatio->Automatic,PlotRange->All]
]


(** Skeleton **)

Skeleton[l_List]:=Module[{v=PolyhedronVertices[l]},
    FromUnorderedPairs[
    	PolyhedronEdges[l]/.Thread[v->Range[Length[v]]]
    ]
]

Skeleton[l_List,h_:1]:=Module[{v=PolyhedronVertices[l],vp},
    vp={#[[1]],#[[2]]}h/(h-#[[3]])&/@v;
    Graph[
      FromUnorderedPairs[
          PolyhedronEdges[l]/.Thread[v->Range[Length[v]]]][[1]],vp]
]

(** Square Graph **)

SquareGraph:=Cycle[4]

(** Standard Embedding **)

StandardEmbedding[l_List]:=Graph[l, CircularVertices[Length[l]]]

(** TetrahedralGraph **)

TetrahedralGraph:=Wheel[4]

(** Theta-0 Graph **)

Theta0:=AddEdge[
    ChangeVertices[GraphUnion[Cycle[6],EmptyGraph[1]],
      Append[CircularVertices[6],{0,0}]],{{3,7},{7,6}}]

(** Thomassen Graph **)

ThomassenGraph:=Module[{g,i,j,k},
    g=GraphUnion@@Join[Table[CirculantGraph[5,{2}],{4}],
          Table[EmptyGraph[4],{4}]];
    g=ChangeVertices[g,
        Join[
          Flatten[Table[
              Through[{Cos,Sin}[2.Pi i/5+(j+1)Pi/2]]+2{j,k},{j,-1,1,2},{k,-1,
                1,2},{i,5}],2],
          
          Flatten[Table[
              2.1Through[{Cos,Sin}[2.Pi i/5+(j+1)Pi/2]]+2{j,k},{j,-1,1,
                2},{k,-1,1,2},{i,4}],2]
          ]
        ];
    AddEdges[DeleteVertex[DeleteVertex[g,28],32],{{
          10,20},{5,15},{25,26,27,21,22,23,24,28,29,30,31,32,33,34,25},{6,
          25},{7,26},{8,27},{9,21,1},{2,22},{3,23},{4,24},{11,28},{12,29},{13,
          30},{14,31,16},{17,32},{18,33},{19,34}}]
    ]

(** Topological Graphs **)

TopologicalReduce[g_Graph]:=Module[
    {
      removableedge,d=VertexDegrees[g],pairs=ToUnorderedPairs[g]
    },
    If[(removableedge=
            Flatten[Position[
                pairs/.Thread[
                    Range[Length[d]]->d],_?(#=={2,2}||#\[Equal]{1,2}||#\[Equal]{2,1}&)],
              1])\[Equal]{},Return[g]];

    (* exclude triangles in which {a,b} both share c *)
    
    pairs=Select[pairs[[removableedge]],(!TriangleQ[pairs,#]&)];
    If[pairs=={},g,Contract[g,pairs[[1]]]]
]

TopologicalGraphList[g_Graph]:=FixedPointList[TopologicalReduce,g]

TopologicalGraph[g_Graph]:=FixedPoint[TopologicalReduce,g]

TopologicalGraphs[n_]:=TopologicalGraphs[n]=Union[ConnectedGraphs[n],
      SameTest->(IsomorphicQ[TopologicalGraph[#1],
              TopologicalGraph[#2]]&)]
              
(** Traceable **)

TraceableQ[g_Graph] := False /; !ConnectedQ[g]

TraceableQ[g_Graph]:=HamiltonianPath[g]!={}


(** TransitiveDigraphQ **)

TransitiveDigraphQ[g_Graph]:=(MakeLoopless[TransitiveClosure[g]]==g)


(** Trees **)

TreeEmbedding[l_List]:=RootedEmbedding[Graph[l, CircularVertices[Length[l]]],1]

(*
Trees[n_Integer?(#<=savedgraphs&)]:=Trees[n]=
	RootedEmbedding[#,1]&/@Select[Graphs[n],TreeQ]

Trees[n_Integer?(#>savedgraphs&)]:=Trees[n]=
	Union[LabeledTrees[n],SameTest->(IsomorphicQ[#1,#2]&)]
*)

Trees[1]:={Graph[{{0}}]}/.Graph:>TreeEmbedding

Trees[2]:={Graph[{{0,1},{1,0}}]}/.Graph:>TreeEmbedding

Trees[3]:={Graph[{{0,1,0},{1,0,1},{0,1,0}}]}/.Graph:>TreeEmbedding

Trees[4]:={
	Graph[{{0,1,0,0},{1,0,1,0},{0,1,0,1},{0,0,1,0}}],
	Graph[{{0,1,0,0},{1,0,1,1},{0,1,0,0},{0,1,0,0}}]
	}/.Graph:>TreeEmbedding

Trees[5]:={
	Graph[{{0,1,0,0,0},{1,0,1,0,0},{0,1,0,1,0},{0,0,1,0,1},{0,0,0,1,0}}],
	Graph[{{0,1,0,0,0},{1,0,1,0,0},{0,1,0,1,1},{0,0,1,0,0},{0,0,1,0,0}}],
	Graph[{{0,1,0,0,0},{1,0,1,1,1},{0,1,0,0,0},{0,1,0,0,0},{0,1,0,0,0}}]
	}/.Graph:>TreeEmbedding

Trees[6]:={
	Graph[{{0,1,0,0,0,0},{1,0,1,0,0,0},{0,1,0,1,0,0},{0,0,1,0,1,0},{0,0,0,1,0,1},{0,0,0,0,1,0}}],
	Graph[{{0,1,0,0,0,0},{1,0,1,0,0,0},{0,1,0,1,0,0},{0,0,1,0,1,1},{0,0,0,1,0,0},{0,0,0,1,0,0}}],
	Graph[{{0,1,0,0,0,0},{1,0,1,0,0,0},{0,1,0,1,0,1},{0,0,1,0,1,0},{0,0,0,1,0,0},{0,0,1,0,0,0}}],
	Graph[{{0,1,0,0,0,0},{1,0,1,0,0,0},{0,1,0,1,1,1},{0,0,1,0,0,0},{0,0,1,0,0,0},{0,0,1,0,0,0}}],
	Graph[{{0,1,0,0,0,0},{1,0,1,0,0,1},{0,1,0,1,1,0},{0,0,1,0,0,0},{0,0,1,0,0,0},{0,1,0,0,0,0}}],
	Graph[{{0,1,0,0,0,0},{1,0,1,1,1,1},{0,1,0,0,0,0},{0,1,0,0,0,0},{0,1,0,0,0,0},{0,1,0,0,0,0}}]
	}/.Graph:>TreeEmbedding

Trees[n_Integer?(7<=#<=13&)]:=Trees[n]=Module[
	{dir=Directory/.Options[Graphs]},
	Get[dir<>"Trees"<>ToString[n]<>".m"] /. Graph:>TreeEmbedding
]
          
Trees[n_]:=Trees[n]=Module[{g},
  Union[Flatten[
      Function[g,AddEdge[GraphUnion[g,EmptyGraph[1]],{n,#}]&/@Range[n-1]]/@
        Trees[n-1],1],SameTest->(IsomorphicQ[#1,#2]&)]
]

(** Coxeter's Unitransitive Graph **)

UnitransitiveGraphConstruction:=
  Module[{i,c=CircularVertices[10]},
    MakeUndirected[
      AddEdges[GraphUnion[Cycle[10],
            MakeUndirected[MakeGraph[Range[10],(Mod[#1-#2,10]==3)&]]],
          Table[{i,i+10},{i,10}]]/.Graph[a_List,v_List]:>
          Graph[a,Join[1.5c,c]]]]

(** Weighted Trees **)

(* actually want edges+1, not nodes, but the two are the same for trees *)

TreeWeights[g_Graph?TreeQ]:=Module[{i},
  Max/@Table[Length/@ConnectedComponents[DeleteVertex[g,i]],{i,V[g]}]
]

TreeMinimumWeight[g_Graph?TreeQ]:=Min[TreeWeights[g]]


(** Triangle Graph **)

TriangleGraph:=CompleteGraph[3]


(** TriangleQ **)

TriangleQ[l_List,p_List]:=
  And@@Table[Select[Complement[l,{p}],MemberQ[#,p[[i]]]&]!={},{i,2}]


(** Unordered Pairs **)

UnorderedPairs[n_]:=KSubsets[Range[n],2][[#]]&/@Subsets[Binomial[n,2]]


(** Utility Graph **)

UtilityGraph:=CompleteGraph[3,3]


(** VertexDegrees **)

VertexDegrees[g_Graph]:=Tr/@Transpose[Edges[g]]


End[]

(* Protect[  ] *)

EndPackage[]