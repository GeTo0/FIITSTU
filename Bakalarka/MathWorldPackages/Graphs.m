(*:Mathematica Version: 6.0 *)

(*:Package Version: 2.60 *)

(*:Name: MathWorld`Graphs` *)

(*:Author: Eric W. Weisstein
*)

(*:URL:
  http://library.wolfram.com/infocenter/MathSource/4775
*)

(*:Summary:
*)

(*:History:
  v1.00 (2000-01-08): Written
  v1.50 (2001-12-23): Syntax modified for Mathematica 4.2 (new Combinatorica)
  v1.51 (2002-02-05): Documentation updated
  v1.70 (2002-09-19): Moved graphs into new Graphs folder.  Added 8- and 9-vertex listings.  Added GraphsConnectedn.m files.
  v1.80 (2002-10-21): MyIsomorphicQ.  Corrected SymmetricCubicGraph[40].
                      Renamed ConnectedQ[k,n] to KConnectedQ to avoid collision
                      and redefinition of usage message for ConnectedQ
  v1.91 (2003-07-01): Fixed Digraphs and updated Digraphs*.m files
  v1.92 (2003-07-09): Options for Arrow and ShowGraph are now set to nice
                      values by default
  v1.93 (2003-07-15): Fixed Trees and updated Trees.m files.  Corrected corrupted Trees12.m.
                      Added *Graph1-?.m and took out low-order hardwiring.  Cleaned up
                      and alphabetized code for imported graph types.  RootedTrees now
                      stored as external files.  WeaklyBinaryTreeQ.
  v1.94 (2003-07-16): RootedTrees fixed.  Added filed for RootedTrees up to n=10.
                      DirectedQ, OrientedQ, RootedGraphs.
  v1.95 (2003-07-27): ClawFreeQ
  v1.96 (2003-08-04): Added Trees14.m
  v1.97 (2003-08-10): Fixed PolyhedralQ to use KConnectedQ instead of ConnectedQ.
                      Renamed OrientedQ to OrientedGraphQ.
  v1.98 (2003-08-13): Changed VertexStyle and added SemisymmetricQ
  v1.99 (2003-08-14): Renamed TriangleQ to TriangleGraphQ, added RegularQ test
                      to SymmetricGraphQ.  Added SymmetricCubicGraphs.
                      Added RootedTrees12.m.
  v2.00 (2003-08-31): Renamed SquareFreeQ to SquareFreeGraphQ    
  v2.01 (2003-09-03): Fixed RecognizeGraph for Graph[{{1,1}},...]      
  v2.12 (2003-10-17): Added Eccentricity to list of properties tested by MyIsomorphicQ
  v2.13 (2003-10-18): Now load Groups` package to pick up TransitiveGroupQ; updated  context
  v2.18 (2004-01-15): more Frucht notation, rewrote LCFNotation and eliminated GapGraph
  v2.19 (2003-01-21): Renamed FromFruchtNotation to LCFNotation
  v2.21 (2004-01-26): more LCFNotations from Ed, fixed DyckGraph
  v2.22 (2004-02-23): Fixed OreGraphQ and a few others by changing VertexDegrees to
                      Degrees
  v2.23 (2004-02-26): Replaced MyIsomorphicQ with FastIsormorphicQ
  v2.24 (2004-05-20): Switched MyIsomorphicQ back
  v2.25 (2004-05-28): StronglyBinaryQ
  v2.27 (2004-06-02): Changed Leaves to use Degrees instead of DegreeSequence,
                      PlantedTrees.  Fixed TransitiveDigraphQ.
  v2.30 (2004-11-04): CrownGraph
  v2.31 (2005-01-15): CocktailPartyGraph, LadderGraph
  v2.32 (2005-01-17): Renamed LadderGraph to LadderRungGraph and added LadderGraph
  v2.33 (2005-03-16): Tournaments, TournamentQ
  v2.39 (2006-09-19): ArchimedeanQ, Class1Q, Class2Q, CompleteBipartiteQ, PlatonicQ
  v2.40 (2006-09-22): BicubicQ, CombinatoricaGraph, PadVertices
  v2.41 (2006-10-07): GraphClasses, CirculantIndices, CubicSymmetricQ, CompleteBipartiteIndices
  v2.50 (2007-04-13): Updated for v6.  Explicit embeddings now live in GraphData, and constructions
                      live in their respective MathWorld notebooks.  Revamped
                      GraphDataString to be highly configurable via options.  Added
                      BarbellGraph, LollipopGraph, TriangularGraph.
  v2.51 (2007-05-05): Add PerfectMatchingQ, extend HamiltonianCycles to extract multiple cycles
                      and accept a time constraint.  Add Ed's ad hoc GraphDual code.  WriteNautyGraph.
                      InducedSubgraphQ.  LobsterQ.  LineGraphQ
  v2.52 (2007-05-19): ImportRegularGraphs, ImportRegularGraphs2, SpiderQ
  v2.53 (2007-05-25): FastIsomorphism, FindRegularEmbedding, GraphDataEmbeddings, GraphDataTable
  v2.60 (2007-05-30): Rewrote LCF to handle generalized LCFs.  Added HamiltonianCycles so I can use them.
                      Make FastIsomorphism and WriteNautyGraph concurrent-safe.

  (c) 2000-2007 Eric W. Weisstein
*)

(*:Keywords:
  
*)

(*:Requirements:

Requires Mathematica V6.0.0, which includes GraphData.

If you want to work with n-node graphs or trees not included in GraphData, you will need to 
download the following pre-computed lists from http://mathworld.wolfram.com/packages/Graphs/:
	
	ConnectedGraphs1-9.m
	ConnectedPlanarGraphs1-9.m
	Digraphs1-5.m
	Graphs1-9.m
	PlanarGraphs1-9.m
	PolyhedralGraphs1-9.m
	RootedGraphs1-7.m
	RootedTrees1-12.m
	Trees1-14.m
	
You will need to modified the Directory parameter in Options[Graphs] to 
indicate where these files are located on your system.

*)

(*:Discussion:
*)

(*:References: *)

(*:Limitations:
The brute-force approach to enumerating graphs is much too inefficient.
IsomorphicQ-ing a huge list takes forever and a day.

With more clever record-keeping and preprocessing using graph invariants,
it should be possible to compute graphs much more quickly, and therefore
go beyond the current practical maximum of 7 nodes.
*)

BeginPackage["MathWorld`Graphs`",
	{"NautyTools`NautyTools`","Combinatorica`","GraphUtilities`","MathWorld`Groups`"}
]

$Dreadnaut="~/src/nauty22/dreadnaut";

Module[{h=Head[FastIsomorphicQ[Cycle[2], Cycle[3]]]},
	$IsomorphicQ=If[h===Equal||h===FastIsomorphicQ,
		Print["FastIsomorphicQ appears to be unavailable.  Reverting to built-in (slow) IsomorphicQ."];
		IsomorphicQ,
		(* Else *)
		FastIsomorphicQ
	]
];

$Isomorphism=If[FileType[$Dreadnaut]===File,
	FastIsomorphism,
	Print["$Dreadnaut does not appear to be available.  Reverting to built-in (slow) Isomorphism."];Isomorphism
];

AntiprismGraph::usage =
"AntiprismGraph[n] gives a Graph object representing the skeleton of the \
n-antiprism."

ArchimedeanQ::usage =
"ArchimedeanQ[g] returns True if g is an Archimedean graph."

Arrowhead::usage =
"Arrowhead[{v12,v2}] gives an images of an arrowhead appropriate for \
nice display of digraphs."

BarbellGraph::usage =
"BarbellGraph[n] gives a Graph object corresponding to two K_n graphs connecetd by a bridge."

BicenteredTrees::usage =
"BicenteredTrees[n] gives a list of bicentered trees on n nodes."

BicolorableQ::usage =
"BicolorableQ[g] returns True if g is bicolorable."

BicubicQ::usage =
"BicubicQ[g] returns True if g is cubic and bipartite."

BooleanAlgebraConstruction::usage =
"BooleanAlgebraConstruction[n] gives the Hasse diagram for the boolean algebra on \
n elements."

BouquetGraph::usage =
"BouquetGraph[n] gives the bouquet pseudograph, consisting of a single node \
with n loops."

CaterpillarQ::usage =
"CaterpillarQ[g] returns True if g is a caterpillar graph."

CayleyGraph::usage =
"CayleyGraph[pg,s] gives the Cayley graph on the subset s of elements \
(specified as a list of integer indices of elements of the group) for \
the permutation group pg.  The subset must omit the index of the unit \
element and consist of unique integers between 1 and the order of pg."

CayleyTreeQ::usage =
"CayleyTreeQ[g,n] returns True if g is an n-Cayley tree."

CenteredTrees::usage =
"CenteredTrees[n] gives a list of centered trees on n nodes."

CharacteristicPolynomialToSpectrum::usage =
"CharacteristicPolynomialToSpectrum[poly,x] gives an appropriately sorted list of eigenvalues corresponding to the
given characteristic polynomial."

ChordalQ::usage =
"ChordalQ[g] returns True if g possesses no chordless cycles."

Chords::usage =
"Chords[g] gives a list of the chord of graph g."

CirculantGraphQ::usage =
"CirculantGraphQ[g] returns True if g is a circulant graph.  CirculantGraphQ[auto] returns \
True if the given Automorphisms correspond to a circulant graph."

CirculantIndices::usage =
"CirculantIndices[g] gives the smallest indices for a given circulant graph.  CirculantIndices[g,All] \
gives all indices.  CirculantIndices[g,n] gives the smallest indices of length n.  CirculantIndices[g,n,All] \
gives all indices of length n."

Class1Q::usage =
"Class1Q[g] returns True if g is of class 1."

Class2Q::usage =
"Class2Q[g] returns True if g is of class 2."

ClawFreeQ::usage =
"ClawFreeQ[g] returns True if g is claw-free (i.e., does not contain CompleteGraph[1,3] as an \
induced subgraph."

CliqueNumber::usage =
"CliqueNumber[g] gives the size of the largest clique in g."

CocktailPartyGraph::usage =
"CocktailPartyGraph[n] gives the complement of LadderRungGraph[n]."

CographQ::usage =
"CographQ[g] returns True if g is a cograph."

CombinatoricaGraph::usage =
"CombinatoricaGraph[\"graph\"] gives a Combinatorica-style graph corresponding to the \
specified GraphData graph name.  CombinatoricaGraph[\"poly\"] does the same for the \
skeleton of the specificed PolyhedronData object."

CombinatoricaGraphs::usage =
"CombinatoricaGraphs[\"graph\"] gives Combinatorica-style graphs corresponding to the \
specified GraphData graph name.  Equivalent to Graph[] now that Combinatorica supports this \
natively."

CompleteBinaryTreeConstruction::usage =
"CompleteBinaryTreeConstruction[n] returns a complete binary tree on n nodes."

CompleteBipartiteIndices::usage =
"CompleteBipartiteIndices[g] gives the complete bipartite indices."

CompleteBipartiteQ::usage =
"CompleteBipartiteQ[g] returns True if g is complete bipartite."

CompleteKPartiteGraph::usage =
"CompleteKPartiteGraph..."

CompletelyRegularQ::usage =
"CompletelyRegularQ[g] returns True if g is completely regular."

CompleteNaryTree::usage =
"CompleteNaryTree[n,b] returns a complete b-ary tree on n nodes."

ConeGraph::usage =
"ConeGraph[m,n] returns the m-gonal n-cone graph."

ConnectedGraphs::usage =
"ConnectedGraphs[n] gives a list of the n-node connected graphs. n is currently \
restricted to n<=9."

CrossedPrism::usage =
"CrossedPrism[n] gives the nth crossed prism graph."

CrownGraph::usage =
"CrownGraph[n] gives the crown graph for n>=3."

CubicQ::usage =
"CubicQ[g] returns True if g is a cubic graph."

CubicSymmetricQ::usage =
"CubicSymmetricQ[g] returns True if g is cubic and symmetric."

CycleQ::usage =
"CycleQ[g] returns True if g is a cycle graph."

Digraphs::usage =
"Digraphs[n] gives a list of the nonisomorphic unlabeled simple digraphs \
on n vertices with standard embedding.  Digraphs[1] to Digraphs[5] are \
precomputed and read in from files; for larger indexes they are computed \
on the fly (in theory; in practice the primitive algorithm used is much \
too slow to ever return)."

DipoleGraph::usage =
"DipoleGraph[n] gives the dipole multigraph, consisting of two nodes \
and n multiedges."

DirectedQ::usage =
"DirectedQ[g] returns True if g is a directed graph."

$Dreadnaut::usage =
"$Dreadnaut sets the path to the dreadnaut executable."

EdgeColors::usage =
"EdgeColors->colors_list is an option for GraphGraphic."

EdgeTransitiveQ::usage =
"EdgeTransitiveQ[g] returns True if g is edge-transitive."

Excess::usage =
"Excess[g] gives the excess of a specified cage graph."

FastAutomorphisms::usage =
"FastAutomorphisms[g] or FastAutomorphisms[m] uses nauty to calculate automorphisms and express \
them explicitly as permutations."

FastAutomorphismCount::usage =
"FastAutomorphismCount[g] or FastAutomorphismCount[m] uses nauty to calculate the order of the \
automorphism group."

FastHamiltonianQ::usage =
"FastHamiltonianQ[g] returns True if g is Hamiltonian.  Uses GraphUtilities`HamiltonianCycles[g,1], \
which is *much* faster than Combinatorica."

FastIsomorphism::usage =
"FastIsomorphism[g,h] gives a fast nauty-based version of Isomorphism."

FindRegularEmbedding::usage =
"FindRegularEmbedding[g, its] attempts to find symmetric embedding(s) for a regular \
Hamiltonian graph g using its random iterations."

FromCub3::usage =
"FromCub3[l] returns a Graph from a list of triples specifying a cubic graph."

FromSparse6::usage =
"FromSparse6[s] returns a Graph from a string specifying a graph in sparse6 format."

GearGraph::usage =
"GearGraph[n] gives the gear graph on 3n-2 vertices for n>=4, defined as \
Wheel[n] with each edge split into two edges by the addition of a vertex \
in the middle."

GeneralizedMooreGraphQ::usage =
"GeneralizedMooreGraphQ[g] returns True if g is a generalized Moore graph."

GeneralizedPetersenIndices::usage =
"GeneralizedPetersenIndices[g] gives the indices for a given generalized Petersen graph."

GetHamiltonianCycles::usage =
"GetHamiltonianCycles[g] gives the Hamiltonian cycles stored in an external GraphData \
file.  GetHamiltonianCycles[d,g] extracts the cycles for g from the file d."

GraphClassString::usage =
"GraphClassString[g] gives a list of MathWorld subject lines appropriate for a given graph."

GraphCycles::usage =
"GraphCycles[g] gives a list of all distinct cycles of the specified graph.  A cycle \
is specified as list of vertices with last element equal to the first."

GraphDataEmbeddings::usage =
"GraphDataEmbeddings[graph] gives a table of embeddings for the specified graph."

GraphDataTable::usage =
"GraphDataTable[graph,x] gives a table of graph properties for the specified graph, using the \
variable x as the variable for pure functions."

GraphDataString::usage =
"GraphDataString[graph,opts] gives the raw data needed for GraphData for the given graph.  \
\"StandardName\" and \"Name\" are required options.  Options for specifying prperties of \
graphs include \"AlternateNames\", \"AlternateStandardNames\", \"Classes\", \"Information\",
\"Skip\", \"Vertices\", TimeConstraint, MemoryConstraint, and Debug."

GraphDual::usage =
"GraphDual[g] is a slightly ad hoc algorithm that usually returns the geometric dual \
(for plane graphs) or the double cover dual (for nonplanar graphs).  However, it can \
return $Failed."

GraphNameToFileName::usage =
"GraphNameToFileName[g] takes a GraphData name and converts it to a file name using \
ASCII-only characterts."

GraphicalPartitionQ::usage =
"GraphicalPartitionQ[g] returns True if g is a graphical partition."

GraphicalPartitions::usage =
"GraphicalPartitions[n] gives a list of graphical partitions on n nodes."

GraphicalPartitionsCount::usage =
"GraphicalPartitionsCount[n] gives the number of graphical partitions \
whose degrees sum to n."

GraphDataMatrices::usage =
"GraphDataMatrices[graph] gives an array of matrix-related plots."

Graphs::usage =
"Graphs[n] gives a list of the nonisomorphic unlabeled simple graphs \
on n vertices with standard embedding.  At present, n is restricted to n<=9."

(*
GraphUnion::usage =
"GraphUnion[g1,g2,...] extends GraphUnion to an arbitrary number of \
graphs."
*)

GridIndices::usage =
"GridIndices[g] returns the indices {m,n} corresponding to the given grid graph."

HamiltonConnectedQ::usage =
"HamiltonConnectedQ[g] returns True if g is Hamilton-connected.  It computes HamiltonianPath[g,All] \
and so can be very slow.  HamiltonConnectedQ[s] uses the edges and Hamiltonian paths from the GraphData \
graph s."

HelmGraph::usage =
"HelmGraph[n] gives the n-helm graph."

HypohamiltonianQ::usage =
"HypohamiltonianQ[g] returns True if g is hypohamiltonian."

HypotraceableQ::usage =
"HypotraceableQ[g] returns True if g is hypotraceable."

IdentityGraphQ::usage =
"IdentityGraphQ[g] returns True if g is an identity graph."

ImportRegularGraphs::usage =
"ImportRegularGraphs[d,n] imports the d-regular graphs on n nodes using the format \
on Meringer's website."

ImportRegularGraphs2::usage =
"ImportRegularGraphs2[d,n] imports the d-regular graphs on n nodes using the format \
produced by running readscd on the scd files Meringer's website."

IndependenceNumber::usage =
"IndependenceNumber[g] gives the independence number of g."

InducedSubgraphQ::usage =
"InducedSubgraphQ[g,h] returns True if h is an induced subgraph of g."

IntegralGraphQ::usage =
"IntegralGraphQ[g] returns True if g is an integral graph."

$IsomorphicQ::usage =
"$IsomorphicQ specifies which function to use for isomorphism testing.  Possible \
values include IsomorphicQ, FastIsomorphicQ, and MyIsomorphicQ."

$Isomorphism::usage =
"$Isomorphism specifies which function to use for isomorphism testing.  Possible \
values include Isomorphism and FastIsomorphism."

KConnectedQ::usage =
"KConnectedQ[k,g] returns True if g is k-connected."

KingsGraph::usage =
"KingsGraph[m,n] gives the mxn king's graph.  KingsGraph[n] gives the nxn graph."

LabeledGraphs::usage =
"LabeledGraphs[n] gives a list of the labeled simple graphs \
on n vertices with standard embedding."

LabeledTrees::usage =
"LabeledTrees[n] gives a list of the labeled simple trees \
on n vertices."

LadderGraph::usage =
"LadderGraph[n] gives the graph formed by the graph Cartesian product \
K_2 and the path graph P_n."

LadderRungGraph::usage =
"LadderRungGraph[n] gives the graph formed by the graph union of n copies of K_2."

LCF::usage =
"LCF[g] gives the canonicalized LCF notation for the given graph corresponding to \
the first Hamiltonian cycle.  If g is given as a GraphData specification, it is assumed that \
GraphData[g,\"HamiltonianCycles\"] is defined.  LCF[g,All] gives all distinct \
LCF notations for the given graph in canonicalized form.  LCF[edges,hamiltonianCycles,All] \
gives all LCF notations corresponding to the given edge list and Hamiltonian cycle list."

LCFNotation::usage =
"LCFNotation[list,n] gives the symmetric cubic graph corresponding to LCF \
notation [l1,l2,...]^n."

Leaves::usage =
"Leaves[g] gives the number of leaves in graph g."

LineGraphQ::usage =
"LineGraphQ[g] returns True if g is a line graph."

LinesToGraph::usage =
"LinesToGraph[g] converts a Graphics object containing Lines (of the kind \
Ed Pegg likes to generate) to a Graph object."

LobsterQ::usage =
"LobsterQ[g] returns True if g is a lobster graph."

LollipopGraph::usage =
"Lollipop[n,k] gives a Graph object corresponding to a K_n with P_k \"stick\" attached to it."

MinimalColoring::usage =
"MinimalColoring[g,Colors->colors] gives a minimally colored version \
of the graph g with vertex coloring according to the specified colors."

MoebiusLadder::usage =
"MoebiusLadder[n] gives the order-n Moebius ladder graph."

MyIsomorphicQ::usage =
"MyIsomorphicQ[g,h] returns True if a set of invariants is the same for graphs g and h.  \
It tests the invariants sequentially, and so returns False as soon as the first unequal \
invariant is computed.  Invariants should therefore be ordered from fast to slow.  Note \
that a return value of False is definitive, while True simply means all invariants are \
equal and so the graphs are the same unless there exist two graphs with identical sets \
of invariants."

NearestNeighbors::usage =
"NearestNeighbors[] gives the vertices nearest the specified vertex."

NonadjacentVertexPairs::usage =
"NonadjacentVertexPairs[g] gives a list of nonadjacent vertex pairs \
of g."

NonadjacentVertexPairsDegreeSums::usage =
"NonadjacentVertexPairsDegreeSums[g] gives the sums of degrees of nonadjacent \
vertex pairs."

NonLineGraphsConstruction::usage =
"NonLineGraphsConstruction gives a list of the six non-line graphs."

NullGraph::usage =
"NullGraph gives the empty graph on 0 vertices."

NumberOfGraphCycles::usage =
"NumberOfGraphCycles[g] gives the number of distinct cycles of the specified graph."

OddGraphConstruction::usage =
"OddGraphConstruction[n] gives the odd graph of order n."

OreGraphQ::usage =
"OreGraphQ[g] returns True if g is an Ore graph."

OrientedGraphQ::usage =
"OrientedGraphQ[g] returns True if g is an oriented graph."

PadVertices::usage =
"PadVertices[verts, list] pads the list of vertices to {f,n} digits."

PerfectMatchingQ::usage =
"PerfectMatchingQ[g] returns True if a perfect matching exists for the specified graph."

PlanarGraphs::usage =
"PlanarGraphs[n] gives a list of the n-node planar graphs. n is currently \
restricted to n<=9."

PlanarConnectedGraphs::usage =
"PlanarConnectedGraphs[n] gives a list of the n-node planar connected graphs. n is currently \
restricted to n<=9."

PlantedTrees::usage =
"PlantedTrees[n] gives a list of the n-node planted trees for 1<=n<=12."

PlatonicQ::usage =
"PlatonicQ[g] returns True if g is a Platonic graph."

PolyhedralGraphs::usage =
"Polyhedral[n] gives a list of the n-node polyhedral graphs.  n is currently restricted to n<=9."

PolyhedralQ::usage =
"PolyhedralQ[g] returns True if g is planar and 3-connected."

PrismGraph::usage =
"PrismGraph[n] gives the graph corresponding to the skeleton of the n-prism \
for n>=3."

QuarticQ::usage =
"QuarticQ[g] returns True if g is a quartic graph."

QueensGraph::usage =
"QueensGraph[m,n] gives the mxn queen's graph.  QueensGraph[n] gives the nxn graph."

QuinticQ::usage =
"QuinticQ[g] returns True if g is a quintic graph."

ReadG::usage =
"ReadG[file] reads a file created with the command readg -a > file."

RecognizeGraph::usage =
"RecognizeGraph[g] returns a simple form of the embedding of graph g \
if it exists."

RegularParameters::usage =
"RegularParameters[g] returns a list of {n, degree, common neighbors to \
adjacent vertices, common neighbors to nonadjacent vertices}.  No check is \
done to make sure the graph is actually regular or strongly regular."

RootedGraphs::usage =
"RootedGraphs[n] gives the rooted graphs of order n for 1<=n<=7."

RootedTrees::usage =
"RootedTrees[n] gives the rooted trees of order n for 1<=n<=12."

SemisymmetricQ::usage =
"SemisymmetricQ[g] returns True if g is a semisymmetric graph."

SkeletonGraph::usage =
"SkeletonGraph[poly] gives the Graph object corresponding to the \
given polyhedron using a circular embedding.  GraphSkeleton[poly,h] \
constructs the embedding by projecting the vertices from a height \
z=h onto the plane z=0."

SnarkQ::usage =
"SnarkQ[g] returns True if g is a snark, otherwise it returns True."

SpectrumForm::usage =
"SpectrumForm[Spectrum[g]] gives the spectrum g as an explicit product of \
graph eigenvectors."

SpiderQ::usage =
"SpiderQ[g] returns True is g is a spider."

SquareFreeGraphQ::usage =
"SquareFreeGraphQ[g] returns True if g contains no graph cycles of length 4."

StandardDirectedEmbedding::usage =
"StandardDirectedEmbedding[{{a1,...},...}] returns a Graph object having the \
specified adjacency matrix and standard embedding."

StandardEmbedding::usage =
"StandardEmbedding[{{a1,...},...}] returns a Graph object having the \
specified adjacency matrix and standard embedding."

StarQ::usage =
"StarQ[g] returns True if g is a star graph."

StronglyBinaryTreeQ::usage =
"StronglyBinaryTreeQ[g] returns True if g is a strongly binary tree."

StronglyRegularQ::usage =
"StronglyRegularQ[g] returns True if g is strongly regular."

SymmetricGraphQ::usage =
"SymmetricGraphQ[g] returns True if g is a symmetric graph (i.e., \
both edge- and vertex-transitive."

TadpoleGraph::usage =
"TadpoleGraph[n,k] gives a Graph object corresponding to a C_n with P_k \"stick\" attached to it."

ToCommonEdges::usage =
"ToCommonEdges[g1, g2] gives the vertices of g1 permuted to be on the same edge set as \
the isomorphic graph g2.  ToCommonEdges[g, v] reorders the edges of the given graph \
to correspond to the vertex list v."

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

TournamentQ::usage =
"TournamentQ[g] returns True if g is a tournament."

Tournaments::usage =
"Tournaments[n] gives the tournaments on n nodes."

TraceableQ::usage =
"TraceableQ[g] returns True if g is a traceable graph (i.e., it has a \
Hamiltonian path)."

TransitiveDigraphQ::usage =
"TransitiveDigraphQ[g] returns True if g is a transitive digraph."

TreeMinimumWeight::usage =
"TreeMinimumWeight[g] gives the minimum weight of a given tree."

Trees::usage =
"Trees[n] gives a list of the nonisomorphic unlabeled simple trees \
on n nodes with standard embedding.  n can currently be 1 to 14."

TreeWeights::usage =
"TreeWeights[t] gives a list of the weights, where the weight of \
a given node is the maximum number of edge in any branch at the node."

TriangleFreeGraphQ::usage =
"TriangleFreeGraphQ[g] returns True if g contains no cycles of length 3."

TriangleGraphQ::usage =
"TriangleGraphQ[edge-list,edge] returns True if belongs to a cycle of \
length 3."

TriangularGraph::usage =
"TriangularGraph[n] gives a Graph object corresponding to the line graph of K_n."

UnorderedPairs::usage =
"UnorderedPairs[n] gives the number of unordered pairs of n elements."

VertexColors::usage =
"VertexColors->colors_list is an option for GraphGraphic."

VertexTransitiveQ::usage =
"VertexTransitiveQ[g] returns True if g is vertex-transitive."

WeaklyBinaryTreeQ::usage =
"WeaklyBinaryTreeQ[g] returns True if g is a weakly binary tree."

WeaklyRegularQ::usage =
"WeaklyRegularQ[g] returns True if g is weakly regular."

WebGraph::usage =
"WebGraph[n,r] gives the graph composed of r radial n-cycles connected along spokes."

WedgeGraph::usage =
"WedgeGraph gives the wedge graph."

WheelQ::usage =
"WheelQ[g] returns True if g is a wheel graph."

WriteNautyGraph::usage =
"WriteNautyGraph[g, file] writes a dreadnaut-style graph to /tmp, suitable for \
reading in with <file.dre.  g may be either a Combinatorica or GraphData graph."

(* Options *)

(* Set the directory in which pre-computed graphs are kept *)

SetOptions[ShowGraph,
	VertexColor->Red,
	VertexStyle->Disk[.05],
	PlotRange->All
];

If[$VersionNumber>=6,
  Unprotect[GraphPlot,GraphPlot3D];
  (Options[#] = Union[Join[Options[#], {"VertexColor" -> Directive[AbsolutePointSize[5], Red], "EdgeColor" -> Black}]])&/@{GraphPlot,GraphPlot3D};
  Protect[GraphPlot,GraphPlot3D]
];

If[6.0<=$VersionNumber<6.1,
GraphDataPlot[g_,verts_,opts___]:=GraphPlot[MyGraphData[g,"AdjacencyMatrix"], opts, VertexCoordinateRules -> MapIndexed[#2[[1]] -> #1&,verts]];
GraphData[];
Off[GraphData::"notdef"];
Unprotect[GraphData];
GraphData[g_,"Image2D"]:=GraphPlot[GraphData[g,"EdgeRules"]];
GraphData[g_,"Image3D"]:=GraphPlot3D[GraphData[g,"EdgeRules"]];
GraphData[g_,"LabeledImage"]:=GraphDataPlot[g,GraphData[g,"VertexCoordinates"],"VertexLabeling"->True];
GraphData[g_,"LabeledImage2D"]:=GraphPlot[GraphData[g,"EdgeRules"],"VertexLabeling"->True];
GraphData[g_,"LabeledImage3D"]:=GraphPlot3D[GraphData[g,"EdgeRules"],"VertexLabeling"->True];
Protect[GraphData];
]

If[$VersionNumber<6,
	SetOptions[Arrow,
		HeadShape->{Polygon[{{-.35,0},{-.45,.03},{-.45,-.03}}]},
  	 	HeadScaling->Automatic
  	];
]; (* directed graphs *)

Options[Graphs]={
	Directory->{
		"/Volumes/Users/eww/Mathematica/Packages/MathWorld/Graphs",
		"/home/usr2/eww/mma/packages/MathWorld/Graphs",
		"/gridshare/eww/MathWorld/Graphs"
	}
}

Options[GraphDataString]={
	"AlternateNames"->{},
	"AlternateStandardNames"->{},
	"Classes"->{},
	"Information"->None,
	"Name"->"<<default>>",
	"NotationRules"->{},
	"Skip"->{},
	"StandardName"->"DefaultName",
	"Vertices"->Automatic,
	TimeConstraint->3600,
	MemoryConstraint->500*^6,
	Debug->False
}

Options[MinimalColoring]={
	Colors->{Red,Orange,Yellow,Green,Blue,Violet}
}


Begin["`Private`"]

(** Antiprism Graph **)

AntiprismGraph[n_Integer]:=Module[{i,j},
    AddEdges[
      ChangeVertices[GraphUnion[2,Cycle[n]],
        Join@@Table[
            If[j==1,
                1.,.5Cos[Pi/n]]Through[{Cos,Sin}[2Pi(i+(j-1)/2)/n]],{j,2},{i,
              0,n-1}]],
      Flatten[Table[{{i,i+n},{i,If[i==1,2n,i+n-1]}},{i,n}],1]
      ]
    ] /; n>=3


ArchimedeanQ[g_Graph]:=isomorphicQ[g,Graph[#]]&/@Or@@GraphData["Archimedean"]

(** Arrowhead **)

Arrowhead[v_List] := Module[{r = .8, l = .3, w = .1, u, tip, base},
    tip = v[[1]] + r(v[[2]] - v[[1]]);
    u = #/Sqrt[#.#] &[v[[2]] - v[[1]]];
    base = tip - l u;
    Polygon[{tip, base + w{u[[2]], -u[[1]]}, base - w{u[[2]], -u[[1]]}}]
]

(** Automorphisms **)

(* fix Automorphisms[EmptyGraph[]] *)

Unprotect[Automorphisms];
Automorphisms[EmptyGraph[1]]:={{}}
Automorphisms[EmptyGraph[1]]:={{1}}
Protect[Automorphisms];

(** BarbellGraph **)

BarbellGraph[n_] := Module[{g = CompleteGraph[n]},
    AddEdges[ChangeVertices[GraphUnion[2, g], Join[
    Vertices[g], ({3, 0} + {-1, 1}#) & /@ Vertices[g]]], {{n, 2n}}]
    ]

(** Bicentered Trees **)

BicenteredTrees[n_Integer?Positive]:=
  BicenteredTrees[n]=Select[Trees[n],Length[GraphCenter[#]]==2&]

(** BicolorableQ **)

BicolorableQ[g_Graph] := BipartiteQ[g]

(** BicubicQ **)

BicubicQ[g_Graph]:=CubicQ[g]&&BipartiteQ[g]

(** Boolean Algebra **)

BooleanAlgebraConstruction[n_]:=
  HasseDiagram[
    MakeGraph[Subsets[n],((Intersection[#2,#1]===#1)&&(#1!=#2))&]]


(** Bouquet Graph **)

BouquetGraph[n_Integer?Positive]:=AddEdges[EmptyGraph[1],Table[1,{n},{2}]]

(** CaterpillarQ **)

CaterpillarQ[g_Graph,treeq_,d_]:=Module[{a,f},
  	If[treeq,
		a=ToAdjacencyLists[g];
		Max[Length/@Function[f,Select[f,#>1&]]/@Map[Length,a[[#]]&/@a[[#]]&/@Flatten[Position[d,_?(#>2&)]],{2}]]<3,
	(* Else *)
		False
	]
]
CaterpillarQ[g_Graph]:=CaterpillarQ[g,TreeQ[g]]
CaterpillarQ[g_Graph,treeq_]:=If[treeq,CaterpillarQ[g,True,Degrees[g]],False]

(** Cayley Graph **)

CayleyGraph::nounit="Group subset cannot contain the unit element `1`.";
CayleyGraph::badrange="Group subset must be a list of unique integers \
between 1 and the order of group (`1`).";

CayleyGraph[pg_List?PermutationGroupQ,s_List?VectorQ]:=(
      Message[CayleyGraph::badrange,Length[pg]]
      )/;UnsameQ[Complement[s,Range[Length[pg]]],{}]||
      Unequal@@(Length/@{s,Union[s]})

CayleyGraph[pg_List?PermutationGroupQ,s_List?VectorQ]:=(
      Message[CayleyGraph::nounit,Range[Length[pg[[1]]]]]
      )/;MemberQ[pg[[s]],Range[Length[pg[[1]]]]]

CayleyGraph[pg_List?PermutationGroupQ,s_List?VectorQ]:=
  MakeGraph[pg,MemberQ[pg[[s]],Permute[inversePermutation[#1],#2]]&]


CayleyGraph[60]:=Graph[Sort /@ # & /@ {{{1,3}},{{1,60}},{{2,1}},{{2,38}},{{3,5}},{{3,57}},{{6,4}},{{6,
            49}},{{7,9}},{{7,22}},{{8,6}},{{8,53}},{{9,11}},{{9,52}},{{10,
            8}},{{10,48}},{{11,13}},{{11,56}},{{14,12}},{{14,39}},{{15,
            12}},{{15,17}},{{16,14}},{{16,45}},{{17,19}},{{17,44}},{{18,
            16}},{{18,56}},{{19,23}},{{19,48}},{{20,2}},{{20,21}},{{21,
            7}},{{21,25}},{{24,10}},{{24,20}},{{25,15}},{{25,29}},{{26,
            22}},{{26,23}},{{27,4}},{{27,31}},{{28,18}},{{28,24}},{{29,
            27}},{{29,33}},{{30,26}},{{30,31}},{{31,35}},{{32,28}},{{32,
            34}},{{33,37}},{{33,43}},{{34,30}},{{34,57}},{{35,38}},{{35,
            39}},{{36,32}},{{36,46}},{{37,41}},{{37,51}},{{40,36}},{{40,
            54}},{{41,40}},{{41,59}},{{42,13}},{{42,38}},{{43,5}},{{43,
            45}},{{44,42}},{{45,47}},{{46,44}},{{46,49}},{{47,22}},{{47,
            49}},{{50,5}},{{50,48}},{{51,13}},{{51,53}},{{52,50}},{{53,
            55}},{{54,39}},{{54,52}},{{55,12}},{{55,57}},{{58,4}},{{58,
            56}},{{59,23}},{{59,60}},{{60,
            58}}},{{{118.188,-226.063}},{{125.75,-341.563}},{{125.75,-110.5}},{{148.313,-455.188}},{{148.313,3.0625}},{{185.563,-564.813}},{{185.563,
            112.75}},{{236.75,-668.688}},{{236.75,
            216.625}},{{301.125,-765}},{{301.125,
            312.875}},{{377.438,-852.063}},{{377.438,
            399.938}},{{464.5,-928.375}},{{464.5,
            476.313}},{{560.75,-992.75}},{{560.75,
            540.625}},{{664.625,-1043.94}},{{664.625,
            591.875}},{{747.5,-255.188}},{{767.188,-123.375}},{{774.25,-1081.19}},{{774.25,
            629.063}},{{796.375,-379.25}},{{850.188,-19}},{{887.813,-1103.75}},{{887.813,651.688}},{{900.688,-462.25}},{{974.188,
            29.8125}},{{1003.31,-1111.31}},{{1003.31,
            659.25}},{{1032.5,-481.938}},{{1106,
            10.125}},{{1118.88,-1103.75}},{{1118.88,
            651.688}},{{1156.5,-433.063}},{{1210.31,-72.875}},{{1232.44,-1081.19}},{{1232.44,
            629.063}},{{1239.5,-328.75}},{{1259.19,-196.875}},{{1342.06,-1043.94}},{{1342.06,591.875}},{{1445.94,-992.75}},{{1445.94,
            540.625}},{{1542.19,-928.375}},{{1542.19,
            476.313}},{{1629.25,-852.063}},{{1629.25,
            399.938}},{{1705.56,-765}},{{1705.56,
            312.875}},{{1769.88,-668.688}},{{1769.88,
            216.625}},{{1821.13,-564.813}},{{1821.13,
            112.75}},{{1858.31,-455.188}},{{1858.31,
            3.0625}},{{1880.94,-341.563}},{{1880.94,-110.5}},{{1888.5,-226.063}}}]

(** Cayley Tree **)

CayleyTreeQ[g_Graph?TreeQ,n_]:=Union[DegreeSequence[g]]==={1,n}

(** Centered Trees **)

CenteredTrees[n_Integer?Positive]:=
  CenteredTrees[n]=Select[Trees[n],Length[GraphCenter[#]]==1&]

(** CharacteristicPolynomialToSpectrum **)

CharacteristicPolynomialToSpectrum[poly_,x_]:=SortBy[List @@ (Last /@ Roots[poly==0,x,Cubics->False,Quartics->False]),N]

(** Chordal Graph **)

Chords[g_Graph,c_List]:={}/;Length[c]<5
Chords[g_Graph,c0_List]:=Module[{e=Edges[g],c=Drop[c0,-1]},
    Intersection[Complement[Subsets[Union[c],{2}],Sort/@Partition[c,2,1,1]],e]
]
    
ChordalQ[g_Graph]:=Module[{e=Edges[g],c},
    c=Select[Subsets[e],
        Length[#]>3&&
        Union[Length/@Split[Sort[Flatten[#]]]]=={2}&&
        Count[Length/@ConnectedComponents[FromUnorderedPairs[#]],_?(#>2&)]==1&];
    If[Length[c]==1,
      Intersection[Complement[Subsets[Union[Flatten[c[[1]]]],{2}],c[[1]]],e]!={},
      (Intersection[Complement[Subsets[Union[Flatten[#]],{2}],#],e]!={})&/@And@@c
      ]
    ]
 
(** Circulant Graphs **)

(* gives incorrect True for EmptyGraph[n], CompleteGraph[k,n], Star[2n] with n>=3 *)

CirculantGraphQ[g_Graph] := CirculantGraphQ[FastAutomorphisms[g]]
CirculantGraphQ[g_]:=CirculantGraphQ[GraphData[g,"Automorphisms"]] /; Quiet[ListQ[GraphData[g,"Automorphisms"]]]
CirculantGraphQ[a_SparseArray]:=CirculantGraphQ[Normal[a]]
CirculantGraphQ[a_List?MatrixQ] := Module[{n = Length[First[a]]},
	If[Length[a]==1,False,Function[p, Length[NestWhileList[Permute[#, p] &, p, UnsameQ, All, n]] == n + 1] /@ Or @@ a]
]

CirculantIndices[g_Graph]:=Module[{n=V[g],i},
	i=Select[Sort[Subsets[Range[n/2]]],isomorphicQ[CirculantGraph[n,#],g]&,1];
	If[i==={},{},{n,First[i]}]
]

CirculantIndices[g_Graph,k_Integer?NonNegative]:=Module[{n=V[g],i},
	i=Select[Sort[Subsets[Range[n/2],{k}]],isomorphicQ[CirculantGraph[n,#],g]&,1];
	If[i==={},{},{n,First[i]}]
]

CirculantIndices[g_Graph,All]:=Module[{n=V[g],i},
	i=Select[Sort[Subsets[Range[n/2]]],isomorphicQ[CirculantGraph[n,#],g]&];
	If[i==={},{},{n,#}&/@i]
]

CirculantIndices[g_Graph,k_Integer?NonNegative, All]:=Module[{n=V[g],i},
	i=Select[Sort[Subsets[Range[n/2],{k}]],isomorphicQ[CirculantGraph[n,#],g]&];
	If[i==={},{},{n,#}&/@i]
]

circularVertices[n_]:=Module[{i},
	Table[{Cos[#],Sin[#]}&[2Pi i/n],{i,0,n-1}]]

(** Class1|2GraphQ **)

Class1Q[g_Graph]:=EdgeChromaticNumber[g]==Max[Degrees[g]]
Class2Q[g_Graph]:=EdgeChromaticNumber[g]==Max[Degrees[g]]+1

(** Claw-Free **)

ClawFreeQ[g_Graph]:=True /; V[g]<4
ClawFreeQ[g_Graph]:=!isomorphicQ[g,CompleteGraph[1,3]] /; V[g]==4
ClawFreeQ[g_Graph]:=Module[{s},
	(* slight optimization; if there is a vertex of degree >=3 and there are no cycles, there must be a claw *)
	(* Otherwise, just call InducedSubgraphQ[g,CompleteGraph[3,1]] *)
	If[Max[Degrees[g]]>2&&TriangleFreeGraphQ[g],
		False,
	(* Else *)
		If[Head[s=Subsets[Range[V[g]],{4}]]===Subsets,$Failed,
		!(isomorphicQ[CompleteGraph[1,3],#]&/@
			Or@@(InduceSubgraph[g,#]&/@s))
		]
	]
]

(** Clique Number **)

CliqueNumber[g_Graph]:=Length[MaximumClique[g]]

(** Cocktail Party Graph **)

CocktailPartyGraph[n_Integer?Positive]:=GraphComplement[LadderRungGraph[n]]

(** Cograph **)

CographQ[g_Graph]:=True/;V[g]<4
CographQ[g_Graph]:=!isomorphicQ[g,Path[4]]/;V[g]==4
CographQ[g_Graph]:=!(isomorphicQ[Path[4],#]&/@
        Or@@(InduceSubgraph[g,#]&/@Subsets[Range[V[g]],{4}]))

(** CombinatoricaGraph **)

CombinatoricaGraph[g_Graph]:= g

CombinatoricaGraph[g_] := Module[{
   v = GraphData[g, "VertexCoordinates"],
   e = GraphData[g, "EdgeIndices"]},
  If[ListQ[v],
   Graph[If[e=={{}},{},List /@ e], List /@ v],
   Graph[List /@ e, CircularEmbedding[Max[Flatten[e]]]]
   ]
] /; Head[GraphData[g, "EdgeIndices"]]==List

CombinatoricaGraph[p_] := Module[{
	e = PolyhedronData[p, "EdgeIndices"], 
	v = PolyhedronData[p, "SkeletonCoordinates"]
	},
	v = If[Head[v] === Missing, GraphCoordinates[Rule @@@ e][[inversePermutation[VertexList[Rule @@@ e]]]], v];
	Graph[List /@ e, List /@ v]
] /; Head[PolyhedronData[p, "EdgeIndices"]]==List

CombinatoricaGraphs[g_] := Module[{e = GraphData[g, "EdgeIndices"]},
   Graph[List/@e,List/@#]&/@GraphData[g, "Embeddings"]
] /; Head[GraphData[g, "EdgeIndices"]]==List

(** CompleteBipartiteQ **)

CompleteBipartiteQ[g_Graph] := Module[{partitions = {#, V[g] - #} & /@ Range[Floor[V[g]/2]]},
    If[V[g] < 4,
		Or @@ (isomorphicQ[#, g] & /@ (CompleteKPartiteGraph @@@ partitions)),
	(* Else *)
		isomorphicQ[#, g] & /@ Or @@ (CompleteKPartiteGraph @@@ partitions)
	]
]

CompleteBipartiteIndices[g_Graph]:=Module[{partitions = {#, V[g] - #} & /@ Range[Floor[V[g]/2]],i},
	i=Select[partitions,isomorphicQ[CompleteGraph@@#,g]&,1];
	If[i==={},{},First[i]]
]

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

CompleteBinaryTreeConstruction[n_]:=RootedEmbedding[
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

(** CompletelyRegular **)

CompletelyRegularQ[g_Graph]:=PlatonicQ[g]

(** ConeGraph **)

ConeGraph[m_, n_] := GraphJoin[Cycle[m], EmptyGraph[n]]

(** Connected Graphs **)

ConnectedGraphs[n_Integer /; 1<=n<=9]:=ConnectedGraphs[n]=ImportGraphs["ConnectedGraphs",n]

(** CrossedPrism **)

CrossedPrism[k_Integer] := Module[{n}, Graph[List /@ Sort /@ Join[
            Partition[Range[k], 2, 1, 1],
            Partition[Range[k + 1, 2k], 2, 1, 1],
            Table[{n, n + k + 1}, {n, 1, k - 1, 2}],
            Table[{n, n + k - 1}, {n, 2, k, 2}]
            ], List /@ Flatten[Outer[Times, {1, 2}, Through[{Cos, Sin}[2Pi #/
            k]] & /@ Range[0, k - 1]], 1]]
    ]

(** Crown Graph **)

CrownGraph[n_Integer]:=DeleteEdges[CompleteGraph[n,n],{#,#+n}&/@Range[n]] /; n>=3

(** CubicQ **)

CubicQ[g_Graph]:=Equal[3,Sequence@@Degrees[g]]

CubicSymmetricQ[g_Graph]:=CubicQ[g]&&SymmetricQ[g]

(** CycleQ **)

CycleQ[g_Graph]=V[g]>1&&isomorphicQ[g,Cycle[V[g]]]

(** Digraphs **)

(*Digraphs[n_Integer?(1<=#<=2&)]:=ListGraphs[n,Directed]*)

Digraphs[n_Integer?(1<=#<=5&)] := Digraphs[n] =
	ImportGraphs["Digraphs",n,EdgeDirection->True]

(* Runs out of memory trying to do 5.  This should be made more clever so \
that it uses graphs on the next smallest number of nodes.
*)

Digraphs[n_] := Digraphs[n] = Module[{p, i},
      p = Subsets /@ Table[Complement[Range[n], {i}], {i, n}];
      Union[
        FromAdjacencyLists /@ Flatten[Outer[List, Sequence @@ p, 1], n - 1],
        SameTest -> (isomorphicQ[#1, #2] &)]
      ]


(** Dipole Graph **)

DipoleGraph[n_Integer?Positive]:=AddEdges[EmptyGraph[2],Table[{1,2},{n}]]

(** DirectedQ **)

DirectedQ[g_Graph /;Length[g]!=3]:=False
DirectedQ[g_Graph /;Length[g]==3]:=EdgeDirection/.Last[g]

(** EdgeTransitiveQ **)

(* work around bug that Automorphisms[g] fails if M[g]=0 *)

EdgeTransitiveQ[g_Graph]:=Module[{l=LineGraph[g]},
    (*M[l]!=0&&*)Union[Union/@Transpose[FastAutomorphisms[l]]]=={Range[M[g]]}
]

EdgeTransitiveQ[{}]:=True
EdgeTransitiveQ[auto_List?MatrixQ]:=Union[Union/@Transpose[auto]]=={Range[Length[First[auto]]]}

EdgeTransitiveQ[s_]:=Module[{l,lg,a},
	If[Head[lg=GraphData[s,"LineGraphName"]]=!=GraphData&&Head[lg]=!=Missing&&ListQ[a=GraphData[lg,"Automorphisms"]],
		Print["Getting automorphisms from GraphData[\""<>ToString[lg]<>",\"Automorphisms\"]"];
		EdgeTransitiveQ[a],
		(* else *)
		Print["Computing automorphisms of line graph of "<>ToString[s]];
		EdgeTransitiveQ[FastAutomorphisms[LineGraph[CombinatoricaGraph[s]]]]
	]
] /; Head[GraphData[s,"Name"]] =!= GraphData

(** Excess **)

Excess[g_Graph]:=Module[{gi=Girth[g],r,v=Degrees[g][[1]]},
    r=Floor[gi/2];
    V[g]-(If[OddQ[gi],v,2](v-1)^r-2)/(v-2)
]

ToAdj[a_List?MatrixQ, tmpfile_String:"/tmp/auto.adj"] := Export[tmpfile, Prepend[Prepend[# - 1, Length[#]] & /@ (Flatten[Position[#, 1]] & /@ a), {Length[First[a]]}], "Table"]
ToAdj[g_Graph, tmpfile_String:"/tmp/auto.adj"] := ToAdj[ToAdjacencyMatrix[g],tmpfile]
ToAdj[g_, tmpfile_String:"/tmp/auto.adj"] := ToAdj[CombinatoricaGraph[g],tmpfile] /; Head[GraphData[g, "Name"]] =!= GraphData

(** FastAutomorphism **)

FastAutomorphisms[Graph[{}, {}]]:={{}}

FastAutomorphisms[g_] := Module[{tmp="/tmp/auto"<>ToString[Random[Integer,{0,10^10}]],infile,outfile,auto},
    infile=tmp<>".adj";
    outfile=tmp<>".out";
    ToAdj[g,infile];
    Run["~/bin/automorphisms " <> infile <> " > " <> outfile];
    auto=Sort[Import[outfile, "Table"]]+1;
    DeleteFile[{infile,outfile}];
	auto
] /; Head[g]===Graph || Head[GraphData[g, "Name"]] =!= GraphData || ListQ[g]

FastAutomorphismCount[g_] := Module[{tmp="/tmp/auto"<>ToString[Random[Integer,{0,10^10}]],infile,outfile,autoc},
    infile=tmp<>".adj";
    outfile=tmp<>".out";
    ToAdj[g,infile];
    Run["~/bin/automorphisms -c " <> infile <> " > " <> outfile];
    autoc=Import[outfile, "List"];
    DeleteFile[{infile,outfile}];
	autoc[[1]]
] /; Head[g]===Graph || Head[GraphData[g, "Name"]] =!= GraphData || ListQ[g]

(** FastHamiltonianQ **)

FastHamiltonianQ[g_Graph]:=HamiltonianCycles[g]=!={}

(** FastIsomorphism **)

FastIsomorphism[g_Graph,h_Graph]:=Module[{lines,outfile=$TemporaryPrefix<>"-iso"<>ToString[Random[Integer,{0,10^10}]]<>".nty", file1, file2},
	file1=WriteNautyGraph[g];
	file2=WriteNautyGraph[h];
	Run["echo \">"<>outfile<>" ; <"<>file1<>" ; c x @ ; <"<>file2<>" ; x ## ; q\"| "<>$Dreadnaut];
	lines=Import[outfile,"Lines"];
	DeleteFile[{outfile,file1,file2}];
	(1 + ToExpression[Last[StringSplit[#, "-"]]]) & /@ StringSplit[StringJoin@@Drop[lines,Position[lines,"h and h' are identical.",1,1][[1,1]]]]
]

(** FindRegularEmbeddings **)

FindRegularEmbedding[g_Graph, its_: 1] := Module[{n = V[g], gg, ran, rr, i},
  ran = Range[n];
  Monitor[Do[
   gg = Sort[Sort /@ Edges[g] /. Thread[ran -> RandomPermutation[ran]]];
   rr = Most[HamiltonianCycle[FromUnorderedPairs[gg]]];
   s = Sort /@ (gg /. Thread[rr -> ran]);
   If[! MemberQ[l, s] && (Complement[s, Sort /@ (gg /. Thread[rr -> RotateRight[ran, #]])] == {}) & /@ Or @@ Take[Divisors[n], {2, -2}], Print[{Sort[s], GraphPlot[FromUnorderedPairs[s], Method->None]}]
    ],
   {i,its}],i]
]

FindRegularEmbedding[g_, its_: 1] := Module[{n = GraphData[g,"VertexCount"], gg, ran, rr, i},
  ran = Range[n];
  Monitor[
  Do[
   gg = Sort[Sort /@ GraphData[g,"EdgeIndices"] /. Thread[ran -> RandomPermutation[ran]]];
	(*
   rr = Switch[h=GraphData[g,"HamiltonianCycles"],
   	Missing[_,_List],h[[2,1]][[$Isomorphism[Graph[g],FromUnorderedPairs[gg]]]],
   	_List,h[[1]][[$Isomorphism[Graph[g],FromUnorderedPairs[gg]]]],
   	_,Return[$Failed]
   ];
   *)
   rr = Most[HamiltonianCycle[FromUnorderedPairs[gg]]];
   s = Sort /@ (gg /. Thread[rr -> ran]);
   If[! MemberQ[l, s] && (Complement[s, Sort /@ (gg /. Thread[rr -> RotateRight[ran, #]])] == {}) & /@ Or @@ Take[Divisors[n], {2, -2}], Print[{ToCommonEdges[FromUnorderedPairs[s],g], GraphPlot[FromUnorderedPairs[s], Method->None]}]
    ],
   {i,its}],i]
]

(** From Cub3 **)

FromCub3[l_]:=
  MakeUndirected[
    FromOrderedPairs[
      Flatten[MapIndexed[Function[f,{Sequence@@#2,f}]/@#1&,l+1],1]]]

(** Gear Graph **)

(*

(* points along spokes as well *)
GearGraph[nn_Integer?(#>3&)]:=Module[{i,n=nn-1},
    ChangeVertices[
      MakeGraph[
        Range[3n+1],
        (#1==1&&1<#2<=n+1)||
        (#2-#1==n)||
        (#2-#1==n-1&&3n+1>#2>2n+1)||
        (#1==n+2&&#2==3n+1)&,
        Type->Undirected],
      Join[{{0,0}},
          Flatten[{Sequence@@
                    Table[# Through[{Cos,Sin}[2Pi i/n]],{i,0,n-1}]&/@{1/2,1},
              Table[Cos[Pi/n] Through[{Cos,Sin}[2Pi(i+1/2)/n]],{i,0,n-1}]
              },1]]//N]
    ]
 *)
 
 GearGraph[n_Integer?(#>2&)]:=Module[{h,i},
    ChangeVertices[
      MakeGraph[
        Range[2n+1],
        	(#1==1&&1<#2<=n+1)||
        	(#2-#1==n)||
        	(#2-#1==n-1&&#2!=2n+1&&#2!=n+1)||
        	(#2==2n+1&&#1==2)&,
        	Type->Undirected],
      Join[{{0,0}},
          Flatten[{Sequence@@
                Table[If[h==0,1,
                      Cos[Pi/n]] Through[{Cos,Sin}[2Pi(i+h/2)/n]],{h,0,1},{i,
                    0,n-1}]},1]]//N
      ]
]

(** Generalized Moore Graph **)

GeneralizedMooreGraphQ[g_Graph]:=Module[{d=Degrees[g],dist,k,l,r,v=V[g]},
    If[Equal@@d&&(r=First[d])>2,
      dist=Sort/@Map[Length[ShortestPath[g,Sequence@@#]]-1&,
            Outer[List,Range[v],Range[v]],
            {2}];
      Equal@@dist&&
        Equal@@Most/@{
              l=Length/@Split[Rest[First[dist]]],
              Table[r(r-1)^k,{k,0,Length[l]-1}]
              },
      (* Else *)
      False
      ]
    ]

(* Generalized Petersen indices *)

GeneralizedPetersenIndices[g_Graph]:=Module[{nn=V[g],i},
	i=Select[Range[nn/4],isomorphicQ[GeneralizedPetersenGraph[nn/2,#],g]&,1];
	If[i==={},{},{nn/2,First[i]}]
]

GeneralizedPetersenIndices[g_Graph,All]:=Module[{nn=V[g],i},
	i=Select[Range[nn/4],isomorphicQ[GeneralizedPetersenGraph[nn/2,#],g]&];
	If[i==={},{},{nn/2,#}&/@i]
]

(* modified from Combinatorica to pass the Hamiltonian cyles (without last element = first) instead of regenerating them *)
Unprotect[HamiltonianPath];
HamiltonianPath[g_Graph, hc_, All] := Module[{c = hc, nonEdges, p, q, h, a, b, al = ToAdjacencyLists[g], s}, 
            Union[
               Flatten[
                   Map[Table[RotateLeft[#, i - 1], {i, Length[#] - 1}] &, c], 1],
               Flatten[
                   nonEdges = Complement[Flatten[Table[{i, j}, {i, V[g] - 1}, {j, i + 1, V[g]}], 1], Edges[g]];
                   Table[{a, b} = nonEdges[[i]]; 
                         edgesA = Map[{a, #} &, al[[a]]];
                         edgesB = Map[{b, #} &, al[[b]]];
                         h = AddEdges[DeleteEdges[g, Join[edgesA, edgesB]], {a, b}];
                         Table[h = AddEdges[h, {edgesA[[j]], edgesB[[k]]}];
                               If[BiconnectedQ[h],
                                  c = Most/@HamiltonianCycle[h, All];
                                  Map[({p, q} = {Position[#, a][[1, 1]], Position[#, b][[1, 1]]};
                                       s = RotateLeft[#, q - 1];
                                       If[s[[2]] == a, RotateLeft[s, 1], s])&, 
                                       c
                                  ], 
                                  {}
                               ], 
                               {j, Length[edgesA]}, {k, Length[edgesB]}
                         ],
                         {i, Length[nonEdges]}
                   ], 3
               ]
            ]
        ]

DebugPrint[x_]:=Module[{t=AbsoluteTime[]},
	Print[x,StringJoin@@Table[" ",{Max[30-StringLength[x],0]}]<>" (AbsoluteTime: ",t-t0,", Time: ",t-t1,", MaxMemoryUsed: ",MaxMemoryUsed[]/10^6.,", MemoryInUse: ",MemoryInUse[]/10^6.,")"];
	t1=t;
]

PartitionLength[graph_] := PartitionLength[Graph[graph], GraphData[graph, "EdgeIndices"]]
PartitionLength[g_, edges_] := Length[FastIsomorphicSets[(DeleteEdges[g, {#}] & /@ Take[Sort[edges], 3])]]

GraphClassString[g_]:=graphClassString[GraphData[g, "Classes"]] /; Head[GraphData[g,"Name"]]=!=GraphData
GraphClassString[gs_List]:=graphClassString[Union@@(GraphData[#,"Classes"]&/@gs)]
graphClassString[classes_]:=ExportString[StringReplace[
    "\\subj{Mathematics:Discrete Mathematics:Graph Theory:Simple Graphs:" <> StringJoin @@ Riffle[DeleteCases[StringSplit[#, RegularExpression["([A-Z1-9][a-z]+)"] :> "$1"], ""], " "] <> " Graphs}",
    {
     "Cayley Graph Graphs" -> "Cayley Graphs",
     "Claw Free Graphs" -> "Claw-Free Graphs",
     "Determined By Spectrum" -> "Determined by Spectrum",
     "Distance Regular Graphs" -> "Distance-Regular Graphs",
     "Edge Transitive Graphs" -> "Edge-Transitive Graphs",
     "Line Graph Graphs" -> "Line Graphs",
     "Self Complementary Graphs" -> "Self-Complementary Graphs",
     "Self Dual Graphs" -> "Self-Dual Graphs",
     "Snark Graphs"->"Snarks",
     "SquareFree Graphs" -> "Square-Free Graphs",
     "Triangle Free Graphs" -> "Triangle-Free Graphs",
     "Vertex Transitive Graphs" -> "Vertex-Transitive Graphs"
    }] & /@ classes, "Lines"]

Unprotect[ToCombinatoricaGraph];
ToCombinatoricaGraph[gc_Graphics]:= Cases[gc, GraphicsComplex[v_, g_] :> Graph[List /@ First[Cases[g, Line[l_] :> l, {1, Infinity}]], List /@ v], {1, Infinity}][[1]]

GraphDataString[g_Graph,opts___?OptionQ] := Module[
	{
		nn=V[g], (* use nn instead of n to workaround corruption of n by nautytools *)
		ecn,cn,d=Degrees[g],rd,bp,members={},missing={},notations={},
		vt,sym,spec,plan,reg,cubic,adj,vc,bicon,girth,cbi,ds,poly,platonic,rp,sr,edges=Edges[g],ec,in,cln,cp,treeq,
		tf,ecc,m,hyp,hamq,traceq,verts,gridi,bridges,char,ci,gp,con,lg,lgname,auto,autoc,cycl,dual,dualname,can,vv,cospec,lcf,
		nonclasses={"Noncirculant","NoncompleteBipartite","NongeneralizedPetersen","Nongrid","Nonhamiltonian","Nonintegral","Untraceable"}
	},
	{altnames,altstdnames,classes,info,title,notationrules,skip,name,verts,t,mem,debug}=
		{"AlternateNames","AlternateStandardNames","Classes","Information","Name","NotationRules","Skip","StandardName","Vertices",TimeConstraint,MemoryConstraint,Debug}/.{opts}/.Options[GraphDataString];
	t0=AbsoluteTime[];
	t1=t0;
	If[debug,DebugPrint["Starting main routine..."]];
	If[debug,DebugPrint["AlternateStandardNames..."]];
	If[debug,DebugPrint["CanonicalForm..."]];
	(* this isn't quite working? *)
	can=TimeConstrained[CanonicalForm[g],t];
	rec=If[ListQ[can],RecognizeGraph[can,nn],TimeConstrained[RecognizeGraph[g],t]];
	If[debug,DebugPrint["AdjacencyMatrix..."]];
	adj=TimeConstrained[AdjacencyMatrix[g],t];
	If[debug,DebugPrint["VertexConnectivity..."]];
	vc=If[MemberQ[skip,"VertexConnectivity"],$Aborted,TimeConstrained[VertexConnectivity[g],t]];
	If[debug,DebugPrint["CharacteristicPolynomial..."]];
	char=If[MemberQ[skip,"CharacteristicPolynomial"],$Aborted,TimeConstrained[Factor[CharacteristicPolynomial[adj,x]],t]];
	If[debug,DebugPrint["Spectrum..."]];
	spec=If[char===$Aborted,$Aborted,TimeConstrained[CharacteristicPolynomialToSpectrum[char,x],t]];
	If[debug,DebugPrint["CospectralGraphNames..."]];
	cospec=If[char===$Aborted,$Failed,TimeConstrained[DeleteCases[Select[GraphData[All],Abs[Cancel[GraphData[#,"CharacteristicPolynomial"][x]/char]]===1&],rec],t]];
	If[debug,DebugPrint["Girth..."]];
	girth=TimeConstrained[Girth[g],t];
	If[debug,DebugPrint["CompleteBipartiteIndices..."]];
	cbi=If[MemberQ[classes,"NoncompleteBipartite"],{},TimeConstrained[CompleteBipartiteIndices[g],t]];
	If[debug,DebugPrint["EdgeConnectivity..."]];
	ec=If[MemberQ[skip,"EdgeConnecitivity"],$Aborted,TimeConstrained[EdgeConnectivity[g],t]];
	If[debug,DebugPrint["IncidenceMatrix..."]];
	inc=TimeConstrained[IncidenceMatrix[g],t];
	If[debug,DebugPrint["IndependenceNumber..."]];
	(* work around crash bug 76652; stack size *)
	in=If[nn>1000||MemberQ[skip,"IndependenceNumber"],$Failed,TimeConstrained[IndependenceNumber[g],t]];
	If[debug,DebugPrint["CliqueNumber..."]];
	cln=If[MemberQ[skip,"CliqueNumber"],$Aborted,TimeConstrained[CliqueNumber[g],t]];
	If[debug,DebugPrint["ChromaticPolynomial..."]];
	(* work around crash bug 76652; stack size *)
	cp=If[nn>1000||MemberQ[skip,"ChromaticPolynomial"],$Failed,TimeConstrained[ChromaticPolynomial[g, x],t]];
	distm=TimeConstrained[AllPairsShortestPath[g],t];
	If[debug,DebugPrint["Eccentricity..."]];
	ecc=TimeConstrained[Eccentricity[g],t];
	rd=Union[d];
	reg=Length[rd]==1;
	cubic=rd=={3};

	If[debug,DebugPrint["HamiltonianCycles..."]];
	hamq=Which[
		MemberQ[classes,"Hamiltonian"],True,
		Intersection[classes,{"Nonhamiltonian","Snark"}]=!={},False,
		True,$Aborted
	];
	Which[
		hamq===False,h={},
		MemberQ[skip,"HamiltonianCycles"],h=$Aborted,
		(* finish check stuff *)
		True,
			(* fast GraphUtilities code *)
			Switch[h=MemoryConstrained[TimeConstrained[HamiltonianCycles[g,All],t],mem],
				$Aborted,Check[
					(* slow Combinatorica code *)
					h=MemoryConstrained[HamiltonianCycle[g,All,TimeConstraint->t],mem];If[h==={},hamq=False;{},hamq=True;h=Most/@h],
					If[h==={},hamq=$Aborted;h=Missing["NotAvailable"],hamq=True;h=Missing["NotAvailable",h]]],
				{},hamq=False,
				_,hamq=True
			]
	];

	If[debug,DebugPrint["HamiltonianPaths..."]];	
	traceq=Which[
		hamq===True||MemberQ[classes,"Traceable"],True,
		MemberQ[classes,"Traceable"],True,
		MemberQ[classes,"Untraceable"],False,
		True,$Aborted
	];
	hp=Which[
		traceq===False,{},
		MemberQ[skip,"HamiltonianPaths"],$Failed,
		ListQ[h],TimeConstrained[HamiltonianPath[g,h,All],t],
		True,$Aborted
	];
	If[hp===$Aborted,
		If[debug,DebugPrint["HamiltonianPath..."]];
		hp=Switch[h,
			{}|$Aborted|Missing[_],TimeConstrained[HamiltonianPath[g],t],
			Missing[_,_],h[[2,1]]
		]
	];
	Which[
		hp==={},traceq=False,
		hp=!=$Aborted,traceq=True
	];

	If[debug,DebugPrint["Bridges..."]];
	bridges=If[nn>1000,$Failed,TimeConstrained[Bridges[g],t]];
	
	If[debug,DebugPrint["ConnectedQ..."]];
	con=If[nn>1000,$Failed,TimeConstrained[ConnectedQ[g],t]];

	(* work around crash bug 76652 *)
	bp=If[nn>3000,$Failed,TimeConstrained[BipartiteQ[g],t]];
	If[debug,DebugPrint["ChromaticNumber..."]];
	cn=If[nn>3000,$Failed,TimeConstrained[ChromaticNumber[g],t]];
	If[debug,DebugPrint["EdgeChromaticNumber..."]];
	ecn=Which[
		nn>3000||MemberQ[skip,"EdgeChromaticNumber"],$Failed,
		hamq&&cubic,Max[d],
		True,TimeConstrained[EdgeChromaticNumber[g],t]
	];
	If[debug,DebugPrint["Planar..."]];
	plan=Which[
		MemberQ[classes,"Planar"],True,
		MemberQ[classes,"Nonplanar"],False,
		True,If[nn>3000,$Failed,TimeConstrained[PlanarQ[g],t]]
	];
	If[debug,DebugPrint["TreeQ..."]];
	treeq=If[nn>1000,$Failed,TimeConstrained[TreeQ[g],t]];
	If[debug,DebugPrint["Circulant indices..."]];
	ci=If[(treeq===True&&nn=!=2)||MemberQ[classes,"Noncirculant"],{},If[ConnectedQ[g],If[nn>40||MemberQ[skip,"Circulant"],$Failed,TimeConstrained[CirculantIndices[g,All],t]],{}]];
	If[debug,DebugPrint["Cycles..."]];
	cycles=If[treeq===True,{},If[m>15||MemberQ[skip,"Cycles"],$Failed,MemoryConstrained[TimeConstrained[GraphCycles[g],t],mem]]];
	If[debug,DebugPrint["AutomorphismsCount..."]];
	autoc=If[nn>500,$Failed,TimeConstrained[FastAutomorphismCount[g],t]];
	If[debug,DebugPrint["Automorphisms..."]];
	auto=If[IntegerQ[autoc]&&autoc<=10^5,TimeConstrained[FastAutomorphisms[g],t],$Aborted];
	If[!FreeQ[data,"Data"],Print["***** auto contains CRAP!!!!!: ",auto," *****"];Return[]];
	If[debug,DebugPrint["GraphDual..."]];
	dual=TimeConstrained[GraphDual[g],t];
	If[debug,DebugPrint["GridIndices..."]];
	(* sometimes give link errors, e.g., on Graph[{"Cubic", {38, 2}}] *)
	gridi=If[MemberQ[classes,"Nongrid"],{},If[nn>500,$Failed,TimeConstrained[GridIndices[g],t]]];
	If[debug,DebugPrint["LineGraph..."]];
	lg=If[MemberQ[skip,"LineGraph"],$Aborted,MemoryConstrained[TimeConstrained[LineGraphQ[g],t],mem]];
	lgname=If[lg===$Aborted,{},RecognizeGraph[lg]];
	lgname=If[lgname=={},Missing["NotAvailable"],lgname,Missing["NotAvailable"]];
	If[debug,DebugPrint["EdgeTransitive..."]];
	et=If[Intersection[classes,{"Symmetric","EdgeTransitive"}]=!={},True,If[nn<50,TimeConstrained[EdgeTransitiveQ[FastAutomorphisms[LineGraph[g]]],t],$Aborted],$Aborted];
	If[debug,DebugPrint["GeneralizedPetersen..."]];
	(* workaround sporadic crash *)
	gp=If[OddQ[nn]||MemberQ[classes,"NongeneralizedPetersen"],{},If[nn>500,$Failed,TimeConstrained[GeneralizedPetersenIndices[g],t]]];
	hyp=Log[2,nn];
	m=Length[edges];
	If[debug,DebugPrint["LaplacianMatrix..."]];
	lap=TimeConstrained[LaplacianMatrix[g],t];
	If[debug,DebugPrint["NormalizedLaplacianMatrix..."]];
	nlap=TimeConstrained[NormalizedLaplacianMatrix[g],t];
	If[debug,DebugPrint["TriangleFree..."]];
	tf=If[nn>1000,$Failed,TimeConstrained[TriangleFreeGraphQ[adj],t]];
	If[debug,DebugPrint["PlatonicQ..."]];
	platonic=nn>3&&m>3&&plan&&vc>2&&!Unequal[nn, 4, 6, 8, 12, 20]&&PlatonicQ[g];
	If[debug,DebugPrint["ArchimedeanQ..."]];
	arc=n>11&&m>17&&plan&&vc>2&&!Unequal[nn,12, 24, 30, 48, 60, 120]&&ArchimedeanQ[g];
	If[debug,DebugPrint["BiconnectedQ..."]];
	bicon=If[nn>1000,$Failed,TimeConstrained[BiconnectedQ[g],t]];
	ds=Sort[d];
	str="RawGraphData["<>StringReplace[ToString[name,InputForm]," "->""]<>",";
	If[debug,DebugPrint["RegularParameters..."]];
	If[reg,rp=TimeConstrained[RegularParameters[adj,g],t];sr=If[rp===$Aborted,$Aborted,Length/@Take[rp,-2]=={1,1}]];
	If[debug,DebugPrint["VertexTransitive..."]];
	vt=If[Intersection[classes,{"Symmetric","VertexTransitive"}]=!={},True,TimeConstrained[TransitiveGroupQ[auto],t]];
	sym=Length[rd]==1&&vt&&et;
	If[nn>4&&EvenQ[nn]&&m==2nn&&TimeConstrained[isomorphicQ[g,AntiprismGraph[nn/2]],t],AppendTo[members,"Antiprism"];AppendTo[notations,"Antiprism"->nn/2],Null,AppendTo[missing,"Antiprism"]];
	If[arc,AppendTo[members,"Archimedean"],Null,AppendTo[missing,"Archimedean"]];
	(* BananaTree *)
	(* Barbell *)
	If[bp,AppendTo[members,"Bicolorable"],Null,AppendTo[missing,"Bicolorable"]];
	If[bicon,AppendTo[members,"Biconnected"],Null,AppendTo[missing,"Biconnected"]];
	If[cubic&&bp,AppendTo[members,"Bicubic"],Null,AppendTo[missing,"Bicubic"]];
	If[bp,AppendTo[members,"Bipartite"],Null,AppendTo[missing,"Bipartite"]];
	If[ListQ[bridges],If[bridges=!={},AppendTo[members,"Bridged"]],AppendTo[missing,"Bridged"]];
	(* Cage *)
	If[debug,DebugPrint["Caterpillar..."]];
	If[treeq&&TimeConstrained[CaterpillarQ[g,treeq,d],t],AppendTo[members,"Caterpillar"],Null,AppendTo[missing,"Caterpillar"]];
	If[debug,DebugPrint["Circulant..."]];
	If[ci!={},AppendTo[members,"Circulant"];AppendTo[notations,"Circulant"->ci],Null,
		If[TimeConstrained[CirculantGraphQ[auto],t],AppendTo[members,"Circulant"];AppendTo[notations,"Circulant"->Missing["NotAvailable"]],Null,AppendTo[missing,"Circulant"]]];
	If[debug,DebugPrint["Class1..."]];
	Switch[ecn-Max[d],0,AppendTo[members,"Class1"],1,AppendTo[members,"Class2"],_,AppendTo[missing,"Class1"]];
	If[debug,DebugPrint["ClawFree..."]];
	If[MemberQ[classes,"ClawFree"],AppendTo[members,"ClawFree"],If[tf===True&&Max[d]>2,False,If[m>20;False,AppendTo[missing,"ClawFree"],If[TimeConstrained[ClawFreeQ[g],t],AppendTo[members,"ClawFree"],Null,AppendTo[missing,"ClawFree"]]]]];
	If[debug,DebugPrint["CocktailPartyGraph..."]];
	If[EvenQ[nn]&&m==nn(nn-2)/2&&TimeConstrained[isomorphicQ[g,CocktailPartyGraph[nn/2]],t],AppendTo[members,"CocktailParty"];AppendTo[notations,"CocktailParty"->nn/2],Null,AppendTo[missing,"CocktailParty"]];
	If[debug,DebugPrint["ComplementGraph..."]];
	cgraph=If[V[g]>=400,$Aborted,TimeConstrained[GraphComplement[g],t]];
	If[cgraph=!=$Aborted,cgraph=RecognizeGraph[cgraph]];
	If[debug,DebugPrint["Complete..."]];
	If[m==Binomial[nn,2],AppendTo[members,"Complete"];AppendTo[notations,"Complete"->nn],Null,AppendTo[missing,"Complete"]];
	If[cbi!={},AppendTo[members,"CompleteBipartite"];AppendTo[notations,"CompleteBipartite"->cbi],Null,AppendTo[missing,"CompleteBipartite"]];
	If[platonic,AppendTo[members,"CompletelyRegular"],Null,AppendTo[missing,"CompletelyRegular"]];
	If[con,AppendTo[members,"Connected"],Null,AppendTo[missing,"Connected"]];
	(* CrossedPrism *)
	If[debug,DebugPrint["CrownGraph..."]];
	If[nn>5&&EvenQ[nn]&&m==nn(nn-2)/4&&TimeConstrained[isomorphicQ[CrownGraph[nn/2],g],t],AppendTo[members,"Crown"];AppendTo[notations,"Crown"->nn/2],Null,AppendTo[missing,"Crown"]];
	If[m==nn&&ds==Table[2,{nn}],AppendTo[members,"Cycle"];AppendTo[notations,"Cycle"->nn],Null,AppendTo[missing,"Cycle"]];
	If[et,AppendTo[members,"EdgeTransitive"],Null,AppendTo[missing,"EdgeTransitive"]];
	If[m==0,AppendTo[members,"Empty"]];
	If[debug,DebugPrint["Eulerian..."]];
	If[nn>1000,AppendTo[missing,"Eulerian"],If[TimeConstrained[EulerianQ[g],t],AppendTo[members,"Eulerian"],Null,AppendTo[missing,"Eulerian"]]];
	If[debug,DebugPrint["GeneralizedPetersen..."]];
	If[gp=={},Null,AppendTo[members,"GeneralizedPetersen"];AppendTo[notations,"GeneralizedPetersen"->{gp}],AppendTo[missing,"GeneralizedPetersen"]];
	If[gridi=={},Null,AppendTo[members,"Grid"];AppendTo[notations,"Grid"->gridi],AppendTo[missing,"Grid"]];
	If[debug,DebugPrint["HamiltonConnected..."]];
	If[MatrixQ[hp],If[hamq&&!bp&&HamiltonConnectedQ[edges,hp],AppendTo[members,"HamiltonConnected"],Null,AppendTo[missing,"HamiltonConnected"]],Null,AppendTo[missing,"HamiltonConnected"]];
	If[hamq,AppendTo[members,"Hamiltonian"],Null,AppendTo[missing,"Hamiltonian"]];
	If[debug,DebugPrint["Hypercube..."]];
	If[IntegerQ[hyp],If[TimeConstrained[isomorphicQ[g,Hypercube[hyp]],t],AppendTo[members,"Hypercube"];AppendTo[notations,"Hypercube"->hyp],Null,AppendTo[missing,"Hypercube"]]];
	If[debug,DebugPrint["Hypohamiltonian..."]];
	If[nn>9&&hamq!=True&&TimeConstrained[HamiltonianQ/@And@@(DeleteVertex[g,#]&/@Range[nn]),t],AppendTo[members,"Hypohamiltonian"],Null,AppendTo[missing,"Hypohamiltonian"]];
	If[debug,DebugPrint["Hypotraceable..."]];
	If[nn>9&&traceq!=True&&TimeConstrained[TraceableQ/@And@@(DeleteVertex[g,#]&/@Range[nn]),t],AppendTo[members,"Hypotraceable"],Null,AppendTo[missing,"Hypotraceable"]];
	If[Length[auto]==1,AppendTo[members,"Identity"],Null,AppendTo[missing,"Identity"]];
	(* there is some sort of bug here *)
	Which[MemberQ[classes,"Nonintegral"],Null,MemberQ[classes,"Integral"],AppendTo[members,"Integral"],True,If[(Length[spec]==1&&IntegerQ[spec[[1]]])||IntegerQ/@And@@spec,AppendTo[members,"Integral"],Null,AppendTo[missing,"Integral"]]];
	If[debug,DebugPrint["Ladder..."]];
	If[EvenQ[nn]&&m==(3nn-4)/2&&TimeConstrained[isomorphicQ[g,GridGraph[nn/2,2]],t],AppendTo[members,"Ladder"];AppendTo[notations,"Ladder"->nn/2],Null,AppendTo[missing,"Ladder"]];
	If[debug,DebugPrint["LCF..."]];
	If[reg&&hamq,
		AppendTo[members,"LCF"];
		AppendTo[notations,"LCF"->Which[
			MatrixQ[h],lcf=TimeConstrained[LCF[edges,h,All],t];First/@lcf,
			MatchQ[h,Missing[_,_]],lcf=MemoryConstrained[TimeConstrained[LCF[edges,Last[h],All],t],mem];Missing["NotAvailable",First/@lcf],
			True,Print["ERROR: LCF FALLTHROUGH"]
		]],
		Null,
		AppendTo[missing,"LCF"]
	];
	If[lg,AppendTo[members,"LineGraph"],Null,AppendTo[missing,"LineGraph"]];
	If[treeq&&TimeConstrained[LobsterQ[g,treeq,d],t],AppendTo[members,"Lobster"],Null,AppendTo[missing,"Lobster"]];
	(* Lollipop *)
	(* Mycielski *)
	(* Odd *)
	If[debug,DebugPrint["Path..."]];
	If[m==nn-1&&TimeConstrained[isomorphicQ[g,Path[nn]],t],AppendTo[members,"Path"];AppendTo[notations,"Path"->nn],Null,AppendTo[missing,"Path"]];
	If[debug,DebugPrint["Perfect..."]];
	If[nn<28&&!MemberQ[skip,"Perfect"],If[MemoryConstrained[TimeConstrained[PerfectQ[g],t],mem],AppendTo[members,"Perfect"],Null,AppendTo[missing,"Perfect"]],AppendTo[missing,"Perfect"]];
	If[debug,DebugPrint["PerfectMatching..."]];
	If[MemberQ[skip,"PerfectMatching"]||(EvenQ[nn]&&nn>22),AppendTo[missing,"PerfectMatching"],If[TimeConstrained[PerfectMatchingQ[g],t],AppendTo[members,"PerfectMatching"],Null,AppendTo[missing,"PerfectMatching"]]];	
	If[plan,AppendTo[members,"Planar"],Null,AppendTo[missing,"Planar"]];
	If[platonic,AppendTo[members,"Platonic"],Null,AppendTo[missing,"Platonic"]];
	If[poly=(plan&&vc>=3),AppendTo[members,"Polyhedral"],Null,AppendTo[missing,"Polyhedral"]];
	If[debug,DebugPrint["Prism..."]];
	If[nn>4&&EvenQ[nn]&&m==3nn/2&&TimeConstrained[isomorphicQ[g,PrismGraph[nn/2]],t],AppendTo[members,"Prism"];AppendTo[notations,"Prism"->nn/2],Null,AppendTo[missing,"Prism"]];
	If[reg,
		AppendTo[members,"Regular"];
		AppendTo[members,Switch[rd[[1]],
			3,"Cubic",
			4,"Quartic",
			5,"Quintic",
			6,"Sextic",
			7,"Septic",
			8,"Octic",
			_,{}]
		],
		Null,
		Join[missing,{"Regular","Cubic","Quartic","Quintic","Sextic","Septic","Octic"}]
	];
	If[debug,DebugPrint["SelfComplementaryQ..."]];
	If[TimeConstrained[SelfComplementaryQ[g],t],AppendTo[members,"SelfComplementary"],Null,AppendTo[missing,"SelfComplementary"]];
	If[reg&&et&&!vt,AppendTo[members,"Semisymmetric"],Null,AppendTo[missing,"Semisymmetric"]];
	If[(MemberQ[classes,"Snark"]||cubic&&bicon&&ecn>3)&&!MemberQ[classes,"Hamiltonian"],AppendTo[members,"Snark"];AppendTo[notations,"Snark"->Missing["NotAvailable"]],Null,AppendTo[missing,"Snark"]];
	If[treeq&&TimeConstrained[SpiderQ[g,treeq],t],AppendTo[members,"Spider"],Null,AppendTo[missing,"Spider"]];
	If[debug,DebugPrint["SquareFree..."]];
	If[NumberQ[girth]||girth===Infinity,If[TimeConstrained[SquareFreeGraphQ[adj,girth],t],AppendTo[members,"SquareFree"],Null,AppendTo[missing,"SquareFree"]],AppendTo[missing,"SquareFree"]];
	If[ds==Append[Table[1,{nn-1}],nn-1],AppendTo[members,"Star"];AppendTo[notations,"Star"->nn],Null,AppendTo[missing,"Star"]];
	If[MemberQ[classes,"StronglyRegular"]||reg&&sr,AppendTo[members,"StronglyRegular"];If[ListQ[rp],AppendTo[notations,"StronglyRegular"->Flatten[rp]]],Null,If[!MemberQ[classes,"WeaklyRegular"],AppendTo[missing,"StronglyRegular"]]];
	If[reg&&et&&vt,AppendTo[members,"Symmetric"],Null,AppendTo[missing,"Symmetric"]];
	If[traceq,AppendTo[members,"Traceable"],Null,AppendTo[missing,"Traceable"]];
	If[debug,DebugPrint["TreeQ..."]];
	If[treeq,AppendTo[members,"Tree"],Null,AppendTo[missing,"Tree"]];
	If[debug,DebugPrint["TriangleFree..."]];
	If[tf,AppendTo[members,"TriangleFree"],Null,AppendTo[missing,"TriangleFree"]];
	(* Triangular *)
	If[vt,AppendTo[members,"VertexTransitive"],Null,AppendTo[missing,"VertexTransitive"]];
	If[MemberQ[classes,"WeaklyRegular"]||reg&&!sr,AppendTo[members,"WeaklyRegular"];If[ListQ[rp],AppendTo[notations,"WeaklyRegular"->rp]],Null,If[!MemberQ[classes,"StronglyRegular"],AppendTo[missing,"WeaklyRegular"]]];
	If[debug,DebugPrint["Wheel..."]];
	If[m==2(nn-1)&&ds==Append[Table[3,{nn-1}],nn-1]&&TimeConstrained[isomorphicQ[g,Wheel[nn]],t],AppendTo[members,"Wheel"];AppendTo[notations,"Wheel"->nn],Null,AppendTo[missing,"Wheel"]];
	If[debug,DebugPrint["ZeroSymmetric..."]];
	If[cubic&&vt,If[TimeConstrained[PartitionLength[g,edges],t]===3,AppendTo[members,"ZeroSymmetric"],Null,AppendTo[missing,"ZeroSymmetric"]],Null,AppendTo[missing,"ZeroSymmetric"]];
	If[debug,DebugPrint["Vertices..."]];
	vv=Join[
		Which[
			verts===Automatic,{Vertices[g]},
			verts===None||verts==={},{},
			True,If[Depth[verts]===3,{verts},verts]
		],
		(* special-case code for Circulant, Complete, CompleteBipartite, GeneralizedPetersen, Grid, Ladder, ... *)
		If[ListQ[lcf],ToCommonEdges[LCFNotation @@ #, g] & /@ lcf,{}]
		(* add ToCommonEdges version of recognized graph *)
	];
	(* restrict to 50 embeddings *)
	If[Length[vv]>50,vv=Take[vv,50]];
	If[debug,DebugPrint["Generating string..."]];
	StringJoin @@ GraphDataLine[str,Sequence@@#]& /@ {
		{"Name", title, "StringReplacements"->{}},
		{"AlternateStandardNames", SortBy[Union[
			If[rec=!={}&&rec=!=$Aborted,Union[GraphData[rec,"AlternateStandardNames"]/.GraphData[l:{8,_},_]:>{l},{rec},altstdnames],altstdnames],
			If[ci==={}||ci===$Aborted,{},{"Circulant",#}&/@ci],
			If[gp==={}||gp===$Aborted,{},{"GeneralizedPetersen",#}&/@ci]
			],First[Flatten[{#}]]&]},
		{"AlternateNames",  If[rec=!={}&&rec=!=$Aborted,Sort[Union[GraphData[rec,"AlternateNames"]/.GraphData[l:{8,_},_]:>{l},altnames]],altnames],"StringReplacements"->{}},
		{"CanonicalForm", can},
		{"Notation", Missing["NotAvailable"]},
		{"Information",If[info===""||info===None,Missing["NotAvailable"],Hyperlink["http://mathworld.wolfram.com/"<>info<>".html"]]},
		{"VertexCount", nn},
		{"Embeddings", PadVertices[vv], "OutputForm"->OutputForm},
		{"EdgeCount", m},
		{"EdgeIndices", Sort[edges]},
		{"AdjacencyMatrix",SparseArray[adj]},
		{"IncidenceMatrix",SparseArray[inc]},
		{"LaplacianMatrix",If[lap===$Aborted,Missing["NotAvailable"],SparseArray[lap]]},
		{"NormalizedLaplacianMatrix",If[nlap===$Aborted,Missing["NotAvailable"],SparseArray[nlap]]},
		{"DistanceMatrix",If[MatrixQ[distm],SparseArray[distm],Missing["NotAvailable"]]},
		{"Classes",Union[Join[Complement[classes,nonclasses],members]]},
		{Switch[Length[missing],0,Null,1,missing[[1]],_,Alternatives@@missing],Missing["NotAvailable"],"Skip"->missing==={}},
		{"NotationRules",Union[notations,notationrules]},
	  	{"DualGraphName",If[dual===$Aborted||dual===$Failed,Missing["NotAvailable"],If[(dualname=RecognizeGraph[dual])==={},Missing["NotAvailable"],dualname]]},
	  	{"LineGraphName",lgname},
	  	{"ComplementGraphName",If[cgraph===$Aborted||cgraph==={},Missing["NotAvailable"],cgraph]}, (* this isn't working *)
	  	{"PolyhedralEmbeddings",{}},
		{"Girth", If[girth===$Aborted,Missing["NotAvailable"],girth]},
		{"Eccentricities", If[ecc===$Aborted,Missing["NotAvailable"],ecc]},
		{"Diameter", If[ecc===$Aborted,Missing["NotAvailable"],Max[ecc]]},
        {"Radius", If[ecc===$Aborted,Missing["NotAvailable"],Min[ecc]]},
        {"Automorphisms", If[NumberQ[autoc],If[autoc>10^5,Missing["TooLarge"],If[ListQ[auto],auto,Missing["NotAvailable"]]],Missing["NotAvailable"]]},
        {"AutomorphismCount", If[NumericQ[autoc],autoc,Missing["NotAvailable"]], "StringReplacements"->{" "->""}},
        {"CharacteristicPolynomial", If[IntegerQ[char/.x->1],Function[Evaluate[char/.x->#]],Missing["NotAvailable"]]},
        {"Spectrum", If[ListQ[spec],spec,Missing["NotAvailable"]]},
        {"CospectralGraphNames",If[ListQ[cospec],cospec,Missing["NotAvailable"]]},
        {"Degrees", d},
        {"ChromaticNumber", If[NumberQ[cn],cn,Missing["NotAvailable"]]},
		{"EdgeConnectivity", If[NumberQ[ec],ec,Missing["NotAvailable"]]},
		{"VertexConnectivity", If[NumberQ[vc],vc,Missing["NotAvailable"]]},
		{"ChromaticPolynomial",If[cp=!=$Aborted&&cp=!=$Failed,Function[Evaluate[Factor[cp]/.x->#]],Missing["NotAvailable"]]},
		{"EdgeChromaticNumber", If[NumberQ[ecn],ecn,Missing["NotAvailable"]]},
		{"IndependenceNumber", If[NumberQ[in],in,Missing["NotAvailable"]]},
		{"CliqueNumber", If[NumberQ[cln],cln,Missing["NotAvailable"]]},
		{"CrossingNumber",If[plan,0,Missing["NotAvailable"],Missing["NotAvailable"]]},
		{"RectilinearCrossingNumber",If[plan,0,Missing["NotAvailable"],Missing["NotAvailable"]]},
		{"ToroidalCrossingNumber",If[plan,0,Missing["NotAvailable"],Missing["NotAvailable"]]},
		{"ProjectivePlaneCrossingNumber",If[plan,0,Missing["NotAvailable"],Missing["NotAvailable"]]},
		{"ArticulationVertices", If[ListQ[bridges] (* work around bug in ArticulationVertices*),ArticulationVertices[g],Missing["NotAvailable"]]},
		{"Bridges", If[ListQ[bridges],bridges,Missing["NotAvailable"]]},
		{"HamiltonianPaths", Switch[hp,{},{},_?VectorQ,Missing["NotAvailable",hp],_?MatrixQ,hp,_,Missing["NotAvailable"]]},
		{"HamiltonianPathCount", Switch[hp,{},0,_?MatrixQ,Length[hp],_,Missing["NotAvailable"]]},
		{"HamiltonianCycles", h},
		{"HamiltonianCycleCount", If[ListQ[h],Length[h],Missing["NotAvailable"]]},
		{"Cycles", If[ListQ[cycles],Most/@cycles,Missing["NotAvailable"]]},
		{"CycleCount", If[ListQ[cycles],Length[cycles],Missing["NotAvailable"]]}
	}<>"\n"
]

GraphDataLine[pre_,prop_,val_,opts___?OptionQ]:= Module[
	{
		repl="StringReplacements" /. {opts} /. {"StringReplacements" -> {" " -> "", "*" -> ""}},
		skip="Skip" /. {opts} /. {"Skip"->False},
		form="OutputForm" /. {opts} /. {"OutputForm"->InputForm}
	},
	If[skip,
		"",
	(* Else *)
		pre <> StringReplace[ToString[prop,InputForm]," "->""] <>"]:=" <> StringReplace[ToString[val,form],repl] <> "\n"
	]
]

(** Graph Cycles **)

(*
GraphCycles[g_Graph]:=Sort[Flatten[{#,Reverse[#]}&/@CycleFromEdgeList/@Select[Subsets[Edges[g],{3,Infinity}],
    Union[Length/@Split[Sort[Flatten[#]]]]=={2}&&
	Count[Length/@ConnectedComponents[FromUnorderedPairs[#]],_?(#>2&)]==1&
],1]]
*)

GraphCycles[g_Graph]:=Module[{e=Edges[g],n},
		Sort[Flatten[{#,Reverse[#]}&/@CycleFromEdgeList/@(Join@@Table[
			Select[Subsets[e,{n}],
				Union[Length/@Split[Sort[Flatten[#]]]]=={2}&&
				Count[Length/@ConnectedComponents[FromUnorderedPairs[#]],_?(#>2&)]==1&
			],
			{n,3,Length[e]}
		]),1]]
]

CycleFromEdgeList[e_List]:=Module[{indx,v=Union[Flatten[e]]},
    indx=Range[Length[v]];
    HamiltonianCycle[FromUnorderedPairs[e/.Thread[v->indx]]]/.Thread[indx->v]
]

(** GraphDataEmbeddings **)

GraphDataEmbeddings[g_,n_:4,opts___?OptionQ]:=GraphicsGrid[
 Partition[
  GraphPlot[Graph[g], Method -> #, 
     PlotLabel -> #] & /@ {"SpringElectricalEmbedding", 
    "SpringEmbedding", "LayeredDrawing", "LayeredDigraphDrawing", 
    "RadialDrawing", "HighDimensionalEmbedding", "CircularEmbedding", 
    "SpiralEmbedding", "LinearEmbedding", "RandomEmbedding"}, n, n, {1, 1}, {}], opts, ImageSize -> 600]

(** GraphDataTable **)

GraphDataTable[g_,x_]:={GraphData[Flatten[{#}][[1]], "Description"],  If[StringQ[#],GraphData[g, #],First[#]/.GraphData[g,"NotationRules"]]} /. {
     {p:("characteristic polynomial"|"chromatic polynomial"), f_Function} :> {p, f[x]},
     {"spectrum", l_} :> {"spectrum", SpectrumForm[l]},
     {s1 : "polyhedron embedding names", s2_} :> {s1, {PolyhedronData[#, "Name"]} & /@ s2},
     {s1 : "dual graph name"|"graph complement name"|"line graph name", s2_} :> {s1, {GraphData[s2, "Name"]}},
     {"strongly regular", s2_} :> {"strongly regular parameters", s2},
     {"weakly regular", s2_} :> {"weakly regular parameters", s2},
     True -> "Y", 
     False -> "N", _Missing -> "?", {} ->  "---"} & /@ {"AutomorphismCount", 
  "CharacteristicPolynomial", "ChromaticNumber", 
  "ChromaticPolynomial", "ClawFree", "CliqueNumber", 
  "ComplementGraphName", "CospectralGraphNames", 
  "DeterminedBySpectrum", "Diameter", "DistanceRegular", 
  "DualGraphName", "EdgeChromaticNumber", "EdgeConnectivity", 
  "EdgeCount", "Eulerian", "Girth", "Hamiltonian", 
  "HamiltonianCycleCount", "HamiltonianPathCount", "Integral", 
  "IndependenceNumber", "LineGraph", "LineGraphName", 
  "PerfectMatching", "Planar", "Polyhedral", "PolyhedralEmbeddings", 
  "Radius", "Regular", "SquareFree", {"StronglyRegular"}, "Traceable", "TriangleFree", 
  "VertexConnectivity", "VertexCount", {"WeaklyRegular"}}

(** GraphDataMatrices **)

GraphDataMatrices[g_, opts___?OptionQ] := GraphicsArray[{
   ArrayPlot[AdjacencyMatrix[Graph[g]], opts, PlotLabel -> Style["adjacency matrix", FontSlant -> "Italic"]],
   ArrayPlot[IncidenceMatrix[Graph[g]], opts, PlotLabel -> Style["incidence matrix", FontSlant -> "Italic"]],
   ArrayPlot[GraphDistanceMatrix[Graph[g]], opts, ColorFunction->(Hue[0.76#]&), PlotLabel -> Style["distance matrix", FontSlant -> "Italic"]]
   }, ImageSize -> 500, Alignment -> Top]


(** GraphDual *)

VertexEdgeLister[edgelist_, vertexlist_] := 
 Flatten[Table[
   edgelist[[#]] & /@ 
    First /@ Position[edgelist, vertexlist[[v]]], {v, 1, 
    Length[vertexlist]}], 1]

CanonicalCycle[a_List] := 
 First[Sort[
   Flatten[Table[{RotateLeft[a, r], RotateLeft[Reverse[a], r]}, {r, 
      Length[a]}], 1]]]

ShortCycles[g_Graph] := 
 Module[{edgelist = Edges[g]}, Union[Flatten[Table[With[
      {j = 
        ShortestPath[FromUnorderedPairs[Drop[edgelist, {n}]], 
         edgelist[[n, 1]], edgelist[[n, 2]]]},
      With[{k = ShortestPath[FromUnorderedPairs[
           Complement[Drop[edgelist, {n}], 
            VertexEdgeLister[Drop[edgelist, {n}], 
             Drop[Drop[j, 1], -1]]]], edgelist[[n, 1]], 
          edgelist[[n, 2]]]}, {CanonicalCycle[j], 
        CanonicalCycle[k]}]], {n, Length[edgelist]}], 1]]
  ]

SimpleDoubleCoverQ[edgelist_] := Length[Split[Sort[Split[
      Sort[
       Sort /@ Flatten[
         Partition[#, 2, 1, 1] & /@ ShortCycles[edgelist], 1]]]], 
    Length[#1] == Length[#2] &]] == 1

GraphDual[g_Graph] := Module[{myg, gg, hh = Vertices[g]}, 
	If[!ConnectedQ[g] || Bridges[g] =!= {} || !SimpleDoubleCoverQ[g] || (gg = ShortCycles[g]) === $Failed || !FreeQ[gg, Graph],
		$Failed, 
  	(* Else *)
		myg = Graph[{#} & /@ 
		Flatten[Table[If[Length[Intersection[gg[[a]], gg[[b]]]] == 2, {a, b}, Sequence @@ {}], {a, Length[gg] - 1}, {b, a + 1, Length[gg]}], 1], {#} & /@ 
		Table[Mean[Table[hh[[gg[[n, k]]]], {k, Length[First[gg]]}]], {n, Length[gg]}]];
		If[M[myg] === 0 || !ConnectedQ[myg], $Failed, myg]
   ]
]

(** GraphGraphic **)
(* not needed now that ShowGraph is not entirely brain dead? *)

GraphGraphic[g_Graph,graphopts___]:= Module[
	{
	vcolors=VertexColors/.{graphopts}/.Options[Graphs],
	ecolors=EdgeColors/.{graphopts}/.Options[Graphs],
	styles=PlotStyles/.{graphopts}/.Options[Graphs],
	adj=ToAdjacencyMatrix[g],
	v=Vertices[g]
	},
	vcolors=Take[Flatten[Table[vcolors,{Ceiling[V[g]/Length[vcolors]]}]],V[g]];
	ecolors=Take[Flatten[Table[ecolors,{Ceiling[M[g]/Length[ecolors]]}]],M[g]];
	Graphics[{
		Sequence@@styles,
        {Line[v[[#]]], Arrowhead[v[[#]]]} & /@ Position[adj, 1],
        Transpose[{vcolors,Point/@v}]
    },AspectRatio->Automatic,PlotRange->All]
] /; !UndirectedQ[g]

GraphGraphic[g0_Graph,graphopts___] := Module[
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

(** Graphical Partition **)

GraphicalPartitionQ[g_Graph]:=PartitionQ[DegreeSequence[g]]
GraphicalPartitionQ[p_List]:=Head[RealizeDegreeSequence[p]]===Graph

GraphicalPartitionsCount[n_Integer?Positive]:=
	Count[RealizeDegreeSequence/@Partitions[n],_Graph]

GraphicalPartitions[n_Integer?Positive]:=Module[{k},
	If[!ListQ[gp],gp=Flatten[Table[Select[Graphs[k],GraphicalPartitionQ],{k,9}]]];
	GraphicalPartitions[n]=Select[gp,Total[DegreeSequence[#]]==n&]
]
  
(** Generate graphs at random.  Inefficient is putting it mildly. **)

(*
  GraphMonteCarlo[n_, crit_, max_:100, its_:100] := 
    Union[Select[Table[RandomGraph[n, .5], {its}], 
        Head[#] == Graph && crit[#] &], 
      SameTest -> (isomorphicQ[#1, #2] &)]
*)

GraphMonteCarlo[n_, crit_, max_:100, its_:100, l0_:{}] := 
  Module[{l = l0, i = 0, g},
    While[Length[l] < max && i < its,
      i++;
      If[Head[#] == Graph && crit[#] &[g = RandomGraph[n, .5]],
        l = Union[l, {g}, SameTest -> (isomorphicQ[#1, #2] &)]
        ]
      ];
    l
]

(** Graphs **)

(* Brute-force compute all possible edge combinations. *)

graphs[n_]:=Module[{v=CircularVertices[n]//N},
    Union[FromUnorderedPairs[#,v]&/@UnorderedPairs[n],
      SameTest->(isomorphicQ[#1,#2]&)]
]

(* Use graphs of previously smallest order to exclude _many_ cases which are \
already known to be isomorphic for n=5,this gives a speedup from 400 s to \
40 s. In particular, the number of cases which need to be checked for graphs \
of order n is subsets(n-1)=2^(n-1)*[number of graphs of order n-1] \
Flatten[#,1]&/@Outer[List,Subsets[n-1],{n}] gives all combinations of edges \
with a new edge.  Outer[List,ToUnorderedPairs/@AllGraphs[n-1],%] makes all \
combinations of edges including the new edge n with graphs of order n-1 \
already known to be nonisomorphic.  FromUnorderedPairs creates the graphs \
from the lists of edges.  Union keeps only nonisomorphic graphs.
*)

Graphs[n_Integer /; 1<=n<=9]:=Graphs[n]=ImportGraphs["Graphs",n]

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
      Flatten[Map[Union[#,SameTest->isomorphicQ]&,l,{4}]]
]

(** Extend GraphUnion to accept any number of graphs **)

Unprotect[GraphUnion]
GraphUnion[g__Graph]:=Fold[GraphUnion,First[{g}],Rest[{g}]]
Protect[GraphUnion]

UnorderedFactorizations[m_, 1] := {{}}
UnorderedFactorizations[1, n_] := {{}}
UnorderedFactorizations[m_, n_?PrimeQ] := If[m < n, {}, {{n}}]
UnorderedFactorizations[m_, n_] := UnorderedFactorizations[m, n] = Module[{d},
      Flatten[Function[d, 
    Append[#, d] & /@ UnorderedFactorizations[d, n/d]] /@ Select[Divisors[n], 1 < # <= m &], 1]
      ]
UnorderedFactorizations[1] := {{1}}
UnorderedFactorizations[n_] := UnorderedFactorizations[n, n]

GridIndices[g_Graph] := Module[{i=Select[UnorderedFactorizations[V[g]], isomorphicQ[g, GridGraph@@#] &, 1]},
	If[i==={},i,First[i]]
]

(** Hamilton Connected **)

HamiltonConnectedQ[edges_,hp_]:=Complement[edges, #[[{1, -1}]] & /@ hp]=={}

HamiltonConnectedQ::notdef = "GraphData[`1`,\"HamiltonianPaths\"] is not defined; computing paths on subgraphs instead."
HamiltonConnectedQ[g_Graph]:=
	If[BipartiteQ[g](*||!HamiltonianQ[g]*),
		False,
	(* Else *)
		Complement[Edges[g], #[[{1, -1}]] & /@ HamiltonianPath[g,All]]==={}
	]

HamiltonConnectedQ[s_]:=Module[{hp=GraphData[s, "HamiltonianPaths"]},
	If[ListQ[hp],
		Complement[GraphData[s, "EdgeIndices"], #[[{1, -1}]] & /@ hp]==={},
	(* Else *)
		Message[HamiltonConnectedQ::notdef,s];
		HamiltonConnectedQ[CombinatoricaGraph[s]]
	]
] /; Head[GraphData[s,"Name"]] =!= GraphData

(** HamiltonianCycle **)

(* modify HamiltonianCycle to find n cycles and to abort after a predetermined time *)

Unprotect[HamiltonianCycle];

HamiltonianCycle::"time"="Exiting at TimeConstraint `1` before finding all cycles.";
HamiltonianCycle::"notall"="Exiting after finding `1` cycle(s).";
HamiltonianCycle::"notenough"="Requested `1` cycle(s), but returning the only `2` that exist.";

Options[HamiltonianCycle]={TimeConstraint->Infinity};
HamiltonianCycle[g_Graph, flag_: One]:=HamiltonianCycle[g, flag, Sequence@@Options[HamiltonianCycle]]
HamiltonianCycle[g_Graph, flag_: One, opts___?OptionQ]:=HamiltonianCycle[g, flag,TimeConstraint/.{opts}]
HamiltonianCycle[g_Graph, flag_: One, t_] := 
 Module[{s = {1}, all = {}, done, adj = Edges[g], res,
   e = ToAdjacencyLists[g], x, v, ind, n = V[g]
   },
   (* by definition, a graph must have three or more vertices to have a Hamiltonian cycle*)
  If[n < 3, Return[{}]];
  ind = Table[1, {n}];
  res=TimeConstrained[
  While[Length[s] > 0, v = Last[s];
   done = False;
   While[ind[[v]] <= Length[e[[v]]] && ! done, 
    x = e[[v, ind[[v]]++]];
    done = !MemberQ[s, x] && (Length[s] == 1 || 
        BiconnectedQ[
         DeleteVertices[AddEdges[g, {{1, x}}], Rest[s]]])];
   If[done, AppendTo[s, x], s = Drop[s, -1]; ind[[v]] = 1];
   If[(Length[s] == n), 
    If[MemberQ[adj, Sort[{x, 1}]], 
     AppendTo[all, Append[s, First[s]]];
     If[IntegerQ[flag] && Length[all] == flag, Message[HamiltonianCycle::"notall",Length[all]]; Return[all]];
     If[SameQ[flag, All] || IntegerQ[flag], s = Drop[s, -1], 
      all = Flatten[all]; s = {}], s = Drop[s, -1]]]],t];
      If[res===$Aborted,Message[HamiltonianCycle::"time",t]];
      If[IntegerQ[flag]&&Length[all]<flag, Message[HamiltonianCycle::"notenough",flag,Length[all]]];
  all]

(** HamiltonianCycles **)

GraphNameToFileName[g_,suff_String:".m"]:=StringReplace[ToString[g, InputForm], {"\", {" -> "-", "\", "->"-", ", {" -> "-", ", " -> ",", "{\"" -> "","}" -> "", "\""->""}]<>suff

GetHamiltonianCycles[g0_,"External"] := Module[
	{
		s, 
		dir = "/Volumes/Users/Data/Development/DataPaclets/GraphData/Source/HamiltonianCycles/"
	},
	s = Import[dir <> GraphNameToFileName[g0], "String"];
	If[s===$Failed, $Failed, Developer`ToPackedArray[ToExpression[StringDrop[s, StringPosition[s, "=", 1][[1, 1]]]]]]
]

GetHamiltonianCycles[g0_,"External",Method->"LowMemory"]:=Module[
	{
		dir = "/Volumes/Users/Data/Development/DataPaclets/GraphData/Source/HamiltonianCycles/",
		i=0,
		a, n,
		v = GraphData[g0, "V"],
		ncyc = GraphData[g0, "HamiltonianCycleCount"]
	},
	n = StringLength[StringReplace[ToString[Range[v]], " " -> ""]];
	Print["Initializing array..."];
	a = ConstantArray[0, {ncyc, v}];
	Print["Opening stream..."];
	stream = OpenRead[dir <> GraphNameToFileName[g0]];
	While[Read[stream, Character] =!= "="];
	While[Read[stream, Character] =!= "}",
		If[Mod[i, 10^5] == 0, Print["read: ",i,"/",ncyc," = ",N[100i/ncyc,3],"%"]];
 		chars = Read[stream, Table[Character, {n}]];
		i++;
		a[[i]] = Developer`ToPackedArray[ToExpression[StringJoin @@ chars]];
	];
	Close[stream];
	a
]

GetHamiltonianCycles[g_,d0_:None,opts___?OptionQ] := Module[
	{
	s,
	dir = "/Volumes/Users/Data/Development/DataPaclets/GraphData/Source/",
	str = "RawGraphData[" <> StringReplace[ToString[g, InputForm], " " -> ""] <> ",\"HamiltonianCycles\"*",
	h,d
	},
	If[ListQ[h=GraphData[g,"HamiltonianCycles"]],
		Developer`ToPackedArray[h],
	(* Else *)
		d = If[d0 === None, First[Flatten[{g}]], d0];
		s = Cases[Import[dir <> d <> ".m", "Lines"], _?(StringMatchQ[#, str] &),1, 1];
		If[s === {}, GetHamiltonianCycles[g,"External",opts], Developer`ToPackedArray[ToExpression[StringDrop[s[[1]], StringPosition[s[[1]], "=", 1][[1, 1]]]]]]
	]
]

Graph[{8,n_Integer}]:=Graphs[8][[n]]

(** HelmGraph **)

HelmGraph[n_] := Module[{g = PrismGraph[n, 2]},
  AddEdges[AddVertices[
    DeleteEdges[g, 
     Partition[Range[n + 1, 2 n], 2, 1, 1]], {Mean[
      Vertices[g]]}], {2 n + 1, #} & /@ Range[n]]
  ]

(** Hypohamiltonian **)

HypohamiltonianQ[g_Graph]:=If[V[g]<10,False,
	!HamiltonianQ[g]&&HamiltonianQ/@And@@(DeleteVertex[g,#]&/@Range[V[g]])
]

(** Hypotraceable **)

HypotraceableQ[g_Graph]:=False /; TraceableQ[g]
HypotraceableQ[g_Graph]:=If[V[g]<10,False,
	TraceableQ/@And@@(DeleteVertex[g,#]&/@Range[V[g]])
]
  
(** Identity Graph **)

IdentityGraphQ[g_Graph]:=IdentityGraphQ[Automorphisms[g]]
IdentityGraphQ[a_List?MatrixQ]:=Length[a]==1

(** Import Graphs **)

ImportGraphs[s_String,n_Integer,opts___]:=Module[
	{dir=Directory/.{opts}/.Options[Graphs],gopts},
	gopts=Select[{opts},First[#]=!=Directory&];
	Get[s<>ToString[n]<>".m",Path->dir] /.
	  Graph[e_]:>Graph[If[e=={{}},{},List/@e],CircularEmbedding[n],Sequence@@gopts]
]

(** ImportRegularGraphs **)

ImportRegularGraphs[d_, n_] := 
 Module[{g = 
    StringSplit[
     Import["http://www.mathe2.uni-bayreuth.de/markus/REGGRAPHS/ASC/" <> If[n < 10, "0", ""] <> ToString[n] <> "_" <> ToString[d] <> "_3.asc"], "\n\n"]},
  FromAdjacencyLists /@ 
   ToExpression[
    Map[Drop[#, 2] &, 
     StringSplit /@ 
      Most /@ (StringSplit[#, "\n"] & /@ Take[g, {2, -1, 3}]), {2}]]
  ]

ImportRegularGraphs2[d_, n_, opts___] := Module[
	{
	g,
	dir=Directory/.{opts}/.Options[Graphs]
	},
	g = StringSplit[Import[dir[[1]] <> "/" <> If[n < 10, "0", ""] <> ToString[n] <> "_" <> ToString[d] <> "_3.asc"], "\n\n"];
	FromAdjacencyLists /@ ToExpression[Map[Drop[#, 2] &, StringSplit /@ (StringSplit[#, "\n"] & /@ Take[g, {2, -1, 2}]), {2}]]
]

(** Independence Number **)

IndependenceNumber[g_Graph]:=Length[MaximumIndependentSet[g]]

(** InducedSubgraph **)

InducedSubgraphQ[g_Graph, h_Graph] := Module[{v = V[g], w = V[h], s},
	Which[
		v < w, False,
		v == w, isomorphicQ[g, h],
 		True, If[Head[s = Subsets[Range[v], {w}]] === Subsets, $Failed, isomorphicQ[h, #] & /@ Or @@ (InduceSubgraph[g, #] & /@ s)]
 	]
]

(** Integral Graph **)

IntegralGraphQ[g_Graph]:=
  Switch[V[g],
  	0,False,
  	1,IntegerQ@@Spectrum[g],
  	_,IntegerQ/@(And@@Spectrum[g])
]

inversePermutation[p_]:=Ordering[p]

(** IsomorphicQ **)

Unprotect[IsomorphicQ];
IsomorphicQ[g__Graph]:=IsomorphicQ@@@And@@Partition[{g},2,1] /; Length[{g}]>2
Protect[IsomorphicQ];

isomorphicQ[g__Graph]:=$IsomorphicQ[g]

(** K-Connected **)

KConnectedQ[k_Integer?Positive,g_Graph]:=VertexConnectivity[g]>=k

(** KingsGraph **)

KingsGraph[n_Integer?Positive]:=KingsGraph[n,n]

KingsGraph[m_Integer?Positive,n_Integer?Positive]:=Module[
	{i,j},
    AddEdges[GridGraph[m,n],
      Flatten[{
          Table[{m j+i,m+m j+i+1},{j,0,n-2},{i,m-1}],
          Table[{m j+i,-m+m j+i+1},{j,n-1},{i,m-1}]
          },2]
      ]
    ]

(** KnightsTourGraph **)

Unprotect[KnightsTourGraph];
KnightsTourGraph[n_Integer?Positive]:=KnightsTourGraph[n,n]
Protect[KnightsTourGraph];

(** Labeled Graphs **)

LabeledGraphs[n_Integer?Positive]:=LabeledGraphs[n]=
Module[{v=CircularEmbedding[n]//N},
    FromUnorderedPairs[#,v]&/@UnorderedPairs[n]
]

(** Labeled Trees **)

LabeledTrees[n_Integer?Positive]:=LabeledTrees[n]=
	RootedEmbedding[#,1]&/@Select[LabeledGraphs[n],TreeQ]

(*
LabeledTrees[1]:={Graph[{{0}},{{0.,0.}}]}

LabeledTrees[2]:={Graph[{{0,1},{1,0}},{{0.,0.},{0.,-1.}}]}
*)

LabeledTrees[n_Integer?(#>savedgraphs&)]:=
  CodeToLabeledTree/@Flatten[Outer[List,Sequence@@Table[Range[n],{n-2}]],n-3]

(** Ladder Graph **)

LadderGraph[n_Integer?Positive]:=GraphProduct[CompleteGraph[2],Path[n]]

LadderRungGraph[n_Integer?Positive]:=
  GraphUnion[n,ChangeVertices[CompleteGraph[2],{{0,0},{0,1}}]]

(** LaplacianMatrix **)

LaplacianMatrix[g_] := DiagonalMatrix[Degrees[g]] - AdjacencyMatrix[g]

NormalizedLaplacianMatrix[g_]:=Module[{d=Degrees[g],a=AdjacencyMatrix[g],i,j},
	Table[Which[i==j&&d[[i]]!=0,1,a[[i,j]]==1,-1/Sqrt[d[[i]]d[[j]]],True,0],{i,Length[d]},{j,Length[d]}]
]

(** LCF Notation **)

LCF::"notdef" = "GraphData[`1`,\"HamiltonianCycles\"] is not defined; computing the first one instead.";
LCF::"notall" = "GraphData[`1`,\"HamiltonianCycles\"] is not fully known; using partial cycles instead.";
LCF::"badcycles" = "Specified or computed Hamiltonian cycles are inconsistent with the specified or computed edges.  Perhaps the graph under consideration is not regular?";

(*
LCF[s_,hc_List?VectorQ]:=LCF[GraphData[s,"EdgeIndices"],hc] /; Quiet[Head[GraphData[s,"StandardName"]]=!=GraphData]
LCF[s_,hc_List,All]:=LCF[GraphData[s,"EdgeIndices"],DirectedCycles[hc],All] /; Quiet[Head[GraphData[s,"StandardName"]]=!=GraphData]
*)
LCF[e_List, hc_List] := Module[{n=Length[hc], min, l, adj, c, d},
	c = Graph[List /@ (e /. Thread[Range[n] -> inversePermutation[hc]]), CircularEmbedding[n]];
	adj = ToAdjacencyMatrix[c];
	d = Count[First[adj],1];
	l = Sort /@ Partition[
		Which[# >= n/2, # - n, # < -n/2, # + n, True, #] & /@
			(-Subtract @@@ Sort[Select[Position[adj, 1], Unequal[Subtract @@ #, -1, 1, (n - 1), (1 - n)] &]]),
		d-2];
	min = Select[Table[Take[l, #], {n/#}] & /@ Divisors[n], Join@@# == l &, 1];
	If[min==={},
		Message[LCF::"badcycles"];$Failed,
	(* Else *)
		LCFMinimal[If[d==3,Flatten,Identity][min[[1,1]]], n/Length[min[[1,1]]]]
	]
]

LCF[e_List,hc_List,All]:=First/@Split[Sort[LCF[e, #] & /@ DirectedCycles[hc]],First[#1]==First[#2]&]
LCF[g_Graph] := LCF[Edges[g], Most[HamiltonianCycle[g]]]
LCF[s_] := Module[{h=GraphData[s, "HamiltonianCycles"]},
	LCF[GraphData[s, "EdgeIndices"],
		Switch[h,
			_List,h[[1]],
			Missing["NotAvailable",_List?MatrixQ],Message[LCF::notall,s];h[[2,1]],
			_,Message[LCF::notdef,s];Most[HamiltonianCycle[Graph[s]]]
		]
	]
]
LCF[g_Graph,All] := LCF[Edges[g],Most/@HamiltonianCycle[g, All],All]
LCF[s_,All] := Module[{h=GraphData[s, "HamiltonianCycles"]},
	First/@Split[Sort[
		LCF[GraphData[s, "EdgeIndices"], #] & /@ Switch[h,
			_List,DirectedCycles[h],
			Missing["NotAvailable",_List?MatrixQ],Message[LCF::notall,s];DirectedCycles[h[[2]]],
			_,Message[LCF::notdef,s];{Most@HamiltonianCycle[Graph[s]]}]
	],First[#1]==First[#2]&]
]

DirectedCycles[hc_]:=Union[First[Sort[{#, Reverse[RotateLeft[#]]}]] & /@ hc]

LCFMinimal[l_, n_] := {Sort[Join @@ ({#, -Reverse[#]} & /@ NestList[RotateRight, l, Length[l] - 1])][[1]], n}

LCFNotation[l_List?VectorQ, n_:1 ] :=LCFNotation[List/@l, n]
LCFNotation[l_List?MatrixQ, n_: 1] := Module[{vv = Length[l] n}, 
	FromUnorderedPairs[Union[Sort /@ Mod[(# - 1) & /@ Join[Flatten[MapIndexed[Function[v, {#2[[1]], #2[[1]] + v}] /@ # &, Join @@ Table[l, {n}]], 1], Partition[Range[vv], 2, 1, 1]], vv] + 1]]
]

(*
LCFNotation2[l_, n_: 1] := Module[{v = Length[l] n},
  Union[Sort /@ 
    Join[Partition[Range[v], 2, 1, 1], 
     Mod[Flatten[
         MapIndexed[Function[f, {0, f} + #2[[1]]] /@ # &, 
          Flatten[Table[l, {n}], 1]], 1] - 1, v] + 1
     ]]
  ]

LCFNotation[l_List,n_:1]:=Module[{v=Length[l]n},
    FromUnorderedPairs[
      Union[Sort/@
          Join[Partition[Range[v],2,1,1],
            MapIndexed[{#2[[1]],Mod[#1+#2[[1]]-1,v]+1}&,
              Flatten[Table[l,{n}]]]]]]
]
*)
(*
LCFNotationMultiple[l_List, n_:1] := Module[{v = Length[l[[1]]] n},
	FromUnorderedPairs[Union[Sort /@ Flatten[Table[
		MapIndexed[{#2[[1]], Mod[#1 + #2[[1]] - 1, v] + 1} &,
			Flatten[Table[l[[k]], {n}]]], {k, 1, Length[l]}], 1]]]
]
*)

(*
LCF[e_List, hc_List] := Module[{n = Length[hc], c, l, min},
    c = Graph[List /@ (e /. Thread[Range[n] -> InversePermutation[hc]]), CircularEmbedding[n]];
    l = Mod[DeleteCases[-Subtract @@@ Position[ToAdjacencyMatrix[c], 1], -1 | 1 | (n - 1) | (1 - n)] - 1, n, -n/2] + 1;
    min = Select[Table[Take[l, #], {n/#}] & /@ Divisors[n], Flatten[#] == l &, 1][[1]];
    {LCFMinimal[First[min], n/Length[First[min]]], hc}
]
*)

(*
LCF[e_List,hc_List,All]:=Union[LCF[e, #] & /@ hc, SameTest->(First[#1]==First[#2]&)]
*)

(** Leaves **)

Leaves[g_Graph]:=Count[Degrees[g],1]

(** LineGraphQ **)

LineGraphQ[g_Graph] := Module[{n=V[g]},
	Which[
		(* slight optimizatinon for |V(g)|<5 *)
		n<4, True,
		n==4, !isomorphicQ[g,CompleteGraph[3, 1]],
		True, Not[InducedSubgraphQ[g, Graph[#]] & /@ (Or @@ GraphData["NonLineSubgraph"])]
	]
]

(** Lines to Graph **)

LinesToGraph[g_, fuzz_:10., scale_:10.^4] := Module[{elist, v, vfuzz, fuzzlist},
	elist = DeleteCases[Cases[Flatten[g[[1]]], _Line] /. Line[{{x__List}}] :> Line[{x}] /. Line[l_List] :> Sequence @@ (Partition[l, 2, 1]), _?(Norm[Subtract @@ #] < fuzz &)];
    v = Union[Flatten[elist, 1], SameTest -> ((#1 - #2).(#1 - #2) <= fuzz^2 &)];
    vfuzz = Complement[Union[Flatten[elist, 1]], v];
    fuzzlist = Flatten[Function[f, Position[v, _?((# - f).(# - f) <= fuzz^2 &), 1, 1]] /@ vfuzz];
    Graph[List /@ Sort[Sort /@ (elist /. Thread[v -> Range[Length[v]]] /. Thread[vfuzz -> fuzzlist])], List /@ (v/scale)]
]

(** LobsterQ **)

LobsterQ[g_Graph,treeq_,deg_]:=If[treeq,
	CaterpillarQ[DeleteVertices[g,Flatten[Position[deg,1]]],treeq],
	False
]
LobsterQ[g_Graph]:=If[TreeQ[g],LobsterQ[g,True,Degrees[g]],False]

(** LollipopGraph **)

LollipopGraph[n_, k_] := Module[{c = CompleteGraph[n], p = Path[k]},
    AddEdges[ChangeVertices[GraphUnion[c, p], Join[Vertices[c], ({If[k == 1, 2, 1], 0} + #) & /@ Vertices[p]]], {{n, n + 1}}]
]

(** Minimal Graph Coloring **)

MinimalColoring[g_Graph,opts___]:=Module[
    {
      coloring=VertexColoring[g,Algorithm->Optimum],
      colors=Colors/.{opts}/.Options[MinimalColoring]
      },
    SetGraphOptions[g,
      {Sequence@@Flatten[Position[coloring,#]],
            VertexColor->colors[[#]]}&/@Union[coloring]
      ]
    ]

(** MoebiusLadder **)

MoebiusLadder[n_Integer]:=AddEdges[DeleteEdges[PrismGraph[n],{{1,n},{n+1,2n}}],{{1,2n},{n,n+1}}] /; n>2

(** MyIsomorphicQ **)

MyIsomorphicQ[g_Graph,h_Graph]:=Module[{x},
    Apply[#1[#2]&,
      Equal@@@(
      	And@@Outer[List,
    		{
    			V,
    			M,
    			Girth,
    			Diameter,
    			DegreeSequence,
    			Function[e,Sort[Eccentricity[e]]]
    		},
 			{
 				g,
 				h
 			}
 		]
 		),
    {2}]&&
    SameQ[Subtract@@(CharacteristicPolynomial[ToAdjacencyMatrix[#],x]&/@{g,h}),0]
]

(*
MyIsomorphicQ[g1_,g2_]:=isomorphicQ@@(ToAdjacencyMatrix/@{g1,g2})
*)

(** Nearest Neighbors **)

NearestNeighbors[a_List,{}]:={{}}
NearestNeighbors[a_List,e_List]:= 
  Intersection@@(Flatten/@(Position[a[[#]],1]&/@#))&/@e

(** Nonadjacent Vertex Lists **)

NonadjacentVertexLists[g_Graph]:=Module[{h,f,n=V[g],s},
	s=Subsets[Range[n]];
	If[Head[s]===Subsets,$Failed,
    Fold[Function[{h,f},Select[h,Length[Intersection[f,#]]<2&]],
      s,ToUnorderedPairs[g]]
    ]]

NonadjacentVertexPairs[g_Graph]:=Module[{n=V[g]},
    Complement[Subsets[Range[n],{2}],ToUnorderedPairs[g]]
    ]

NonadjacentVertexPairsDegreeSums[g_Graph]:=
  Plus@@@(Degrees[g][[#]]&/@NonadjacentVertexPairs[g])

(** Nullgraph **)

NullGraph:=EmptyGraph[0]

(** NumberOfGraphCycles **)

NumberOfGraphCycles[g_Graph]:=2Count[Subsets[Edges[g],{3,Infinity}],
	_?(
		(* cycles use each vertex in the cycle exactly twice *)
		Union[Length/@Split[Sort[Flatten[#]]]]=={2}&&
		
		(* disjoint cycles must be disallowed, so there may only be
		a single connected component that is a cycle, i.e., of length >2 *)
		Count[Length/@ConnectedComponents[FromUnorderedPairs[#]],_?(#>2&)]==1&
	)
]

(** Odd Graph **)

OddGraphConstruction[n_]:=MakeGraph[Subsets[Range[2n-1],{n-1}],
	(SameQ[Intersection[#1,#2],{}])&]

(** Ore Graph **)

OreGraphQ[g_Graph]:=Module[{s=NonadjacentVertexPairsDegreeSums[g]},
	(* And[] returns True, but s={} means there are _no_ nonadjacent vertices *)
	s=!={}&&And@@Thread[s>V[g]]
]

(** OrientedGraphQ **)

OrientedGraphQ[g_Graph]:=DirectedQ[g]&&Max[Length/@Split[Sort[Sort/@Edges[g]]]]<2

(** PadVertices **)

PadVertices[g_List,l_:{5,4}] := Map[NumberForm[Chop[N[#],10^-5], l, NumberPadding -> {"", "0"}] &, g, {2}]

(** PerfectMatchingQ **)

PerfectMatchingQ[g_] := Module[{n = V[g]},
  If[OddQ[n],
    False,
  (* Else *)
    Not[(Count[Length /@ ConnectedComponents[DeleteVertices[g, #]], _?OddQ] > Length[#]) & /@ Or @@ Subsets[Range[n]]]]
]

(** Planar Connected Graphs **)

PlanarConnectedGraphs[n_Integer /; 1<=n<=9]:=PlanarConnectedGraphs[n]=
	ImportGraphs["PlanarConnectedGraphs",n]

(** Planar Graphs **)

PlanarGraphs[n_Integer /; 1<=n<=9]:=PlanarGraphs[n]=ImportGraphs["PlanarGraphs",n]

(** Planted Trees *)

PlantedTrees[n_Integer /; 1<=n<=12]:=PlantedTrees[n]=Select[RootedTrees[n],Degrees[#][[1]]==1&]

(** PlatonicQ **)

PlatonicQ[g_Graph]:=isomorphicQ[g,Graph[#]]&/@Or@@GraphData["Platonic"]

(** PolyhedralGraphs **)

PolyhedralGraphs[n_Integer /; 1<=n<=9]:=PolyhedralGraphs[n]=
	ImportGraphs["PolyhedralGraphs",n]

PolyhedralQ[g_Graph]:=V[g]>3&&PlanarQ[g]&&KConnectedQ[3,g]

(** Prism Graph **)

PrismGraph[n_Integer]:=PrismGraph[n,2] /; n>=3

PrismGraph[n_Integer,r_Integer?NonNegative]:=Module[{i,k,g},
      g=AddEdges[ChangeVertices[GraphUnion[r,Cycle[n]], Flatten[CircularEmbedding[n]#&/@Range[r],2]],
        Flatten[Table[{(k-1)n+i,i+k n},{i,n},{k,r-1}],1]];
    ChangeVertices[g, RotationMatrix[3Pi(n - 2)/(2 n)].# & /@ Vertices[g]]
] /; n>=3

(** QuarticQ **)

QuarticQ[g_Graph]:=Equal[4,Sequence@@DegreeSequence[g]]

(** QueensGraph **)
(* this is the graph of straight lines + diagonals, not all edges corresponding to moves... *)
(*
QueensGraph[n_Integer?Positive]:=QueensGraph[n,n]

QueensGraph[m_Integer?Positive,n_Integer?Positive]:=Module[
	{i,j},
    AddEdges[GridGraph[m,n],
      Flatten[{
          Table[{m j+i,m+m j+i+1},{j,0,n-2},{i,m-1}],
          Table[{m j+i,-m+m j+i+1},{j,n-1},{i,m-1}]
          },2]
      ]
    ]
*)

(** QuinticQ **)

QuinticQ[g_Graph]:=Equal[5,Sequence@@DegreeSequence[g]]

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

RecognizeGraph::"slow" = "Precomputing CanonicalForm data.  Please upgrade to Mathematica Version 6.1 to take advantage of pre-cached data";
RecognizeGraph::"can8" = "Precomputing CanonicalForm data for 8-node graphs.  Some day, these may be built into Mathematica...";
RecognizeGraph[g_Graph] := RecognizeGraph[CanonicalForm[g],V[g]]
RecognizeGraph[cg_List,n_] := Module[{p},
	If[$VersionNumber<6,Return[$Failed]];
	If[!ListQ[gs],
		If[$VersionNumber<6.1,
			Message[RecognizeGraph::"slow"];
			can = CanonicalForm/@Graph/@(gs = GraphData[-500]),
		(* Else *)
			can = GraphData[#,"CanonicalForm"]& /@ (gs = GraphData[All])
		];
	];
	If[n==8&&!ListQ[can8],Message[RecognizeGraph::"can8"];can8=CanonicalForm/@Graphs[8];(*can9=CanonicalForm/@Graphs[9]*)];
	p = Position[can, cg, 1, 1];
	If[p == {},
		If[n == 8, p = Position[can8, cg, 1, 1]; If[p == {}, {}, {8,p[[1,1]]}], {}],
	(* Else *)
		gs[[p[[1, 1]]]]
	]
]

(** Regular Paremeters **)

RegularParameters[g_Graph]:=RegularParameters[AdjacencyMatrix[g],g]
RegularParameters[adj:(_List?MatrixQ|_SparseArray),g_Graph]:=Module[
	{
	  a=Normal[adj],
      e=Edges[g],
      ne,
      n
	},
	n=Length[a];
    ne=Complement[Subsets[Range[n],{2}],Sort/@e];
	{
		n,
		Union[DegreeSequence[g]],Union[Length/@NearestNeighbors[a,e]],
		Union[Length/@NearestNeighbors[a,ne]]
	}
]

(** Rooted Graphs **)

AddLoops[g_]:=
  FromUnorderedPairs[#,List/@Vertices[g]]&/@
    Table[Join[Edges[g],{{n,n}}],{n,V[g]}]

HighlightRoot[g_Graph]:=SetGraphOptions[g,{1,VertexColor->Black}]

RootGraph[g_]:=Module[{e=Edges[g],r},
    r=Select[e,Equal@@#&,1][[1,1]];
    HighlightRoot[FromUnorderedPairs[Complement[e,{{r,r}}]/.{r->1,1->r},
      List/@Vertices[g]]]
]

RootedGraphs[n_Integer /; 1<=n<=7]:=RootedGraphs[n]=
	HighlightRoot/@ImportGraphs["RootedGraphs",n]

RootedGraphs[n_]:=RootedGraphs[n]=
	RootGraph/@Union[Flatten[AddLoops/@Graphs[n]],SameTest->isomorphicQ]
   
(** Rooted Trees **)

(* about half the computation time is in Union[...,SameTest->IsomorphicQ] *)

AddLoop[g_]:=FromUnorderedPairs[Join[Edges[g],{{1,1}}]]

AddRootedBranches[{g__Graph}]:=Module[{i,n=V[{g}[[1]]]},
    Flatten[Table[Join[#,{{1,1},{i,n+1}}],{i,n}]&/@Edges/@{g},1]
]

RootedTrees[n_Integer /; 1<=n<=12]:=RootedTrees[n]=
	RootedEmbedding[#,1]&/@ImportGraphs["RootedTrees",n]

RootedTrees[n_]:=RootedTrees[n]=RootedEmbedding[#,1]&/@
  RemoveSelfLoops/@Union[
  	FromUnorderedPairs/@AddRootedBranches[RootedTrees[n-1]],
  	SameTest->isomorphicQ
  ]

(* SemisymmetricQ *)

SemisymmetricQ[g_Graph]:=RegularQ[g]&&BipartiteQ[g]&&
	!VertexTransitiveQ[g]&&EdgeTransitiveQ[g]

(* show Labeled graph *)

showLabeledGraph[g_Graph,l0_List:{},r_:1,graphopts___]:=
	Module[
	{
	i,l,
	adj=ToAdjacencyMatrix[g],
	v=Vertices[g]
	},
	l=If[l0=={},Range[Length[v]],l0];
    Graphics[{
    	graphopts,
        Point /@ v,
        Line[v[[#]]] & /@ Position[adj, 1],
        Table[Text[ToString[l[[i]]],(1+r)v[[i]]],{i,Length[v]}]
    },AspectRatio->Automatic,PlotRange->All]
]

(** SkeletonGraph **)

SkeletonGraph[l_List]:=Module[{v=PolyhedronVertices[l]},
    FromUnorderedPairs[
    	PolyhedronEdges[l]/.Thread[v->Range[Length[v]]]
    ]
]

SkeletonGraph[l_List,r_:1]:=Module[{v=PolyhedronVertices[l],vp},
    vp={#[[1]],#[[2]]}r/(r-#[[3]])&/@v;
    Graph[
      FromUnorderedPairs[
          PolyhedronEdges[l]/.Thread[v->Range[Length[v]]]][[1]],List/@vp]
]

ListEdges[l_List]:=Sort/@(l[[#]]&/@Partition[Range[Length[l]],2,1,1])

PolyhedronVertices[poly_List]:=
	Union[Flatten[(Flatten[poly]) /. Polygon:>Identity,1],SameTest->SameQ]

(* Union will catch only explicitly identical expressions *)
PolyhedronEdges[poly_]:=
	Union[Flatten[Flatten[poly] /. Polygon:>ListEdges,1],SameTest->SameQ]

PolyhedronEdgeLengths[poly_]:=
	SymbolicUnion[norm@@@(PolyhedronEdges[Flatten[poly]])]

(* Pick out symbolic expression with smallest byte count (minByteCount), then
   discards numerical values (take First part only).
*)

minByteCount[l_List]:=Module[{b=ByteCount/@l},
	l[[Position[b,Min[b],1][[1,1]]]]
]

SymbolicUnion[l_List]:=Module[{p={#,N[#,200]}&/@l},
    Map[First,
      minByteCount/@Split[Sort[p,#1[[2]]<#2[[2]]&],
          Abs[#1[[2]]-#2[[2]]]<10^(-200)&],{1}]
]

(** SnarkQ **)

SnarkQ[g_Graph]:=CubicQ[g]&&Bridges[g]=={}&&EdgeChromaticNumber[g]>3

(** SpectrumForm **)

SpectrumForm[s_]:=Module[{l={First[#],Length[#]}&/@Split[Sort[s,Less]]},
	HoldForm[Evaluate[Apply[Power,HoldForm/@l,{2}]]]/.List:>Times
]

(** SpiderQ **)

SpiderQ[g_Graph, treeq_] := Module[{d},
  If[treeq =!= True, False,
   d = DegreeSequence[g];
   First[d] >= 3 && d[[2]] <= 2]
]

SpiderQ[g_Graph] := SpiderQ[g, TreeQ[g]]

(** SquareFreeGraphQ **)

(*
SquareFreeGraphQ[g_Graph]:=Module[{s=Subsets[Edges[g],{4}]},
	If[Head[s]===Subsets,
		$Failed,
	(* Else *)
		Position[s,_?(Union[Length/@Split[Sort[Flatten[#]]]]=={2}&),1,1,Heads->False]==={}
  	]
]
*)

SquareFreeGraphQ[g_Graph] := SquareFreeGraphQ[ToAdjacencyMatrix[g],Girth[g]]

SquareFreeGraphQ[a:(_List?MatrixQ|_SparseArray),girth_] := 
	Switch[girth,
		_?(# < 4 &), Max[MapIndexed[Delete[#1, #2[[1]]] &, MatrixPower[SparseArray[a],2]]] < 2,
		4, False,
		_?(# > 4 &), True,
		_, $Failed
	]

(** Square Graph **)

SquareGraph:=Cycle[4]

(** Standard Embedding **)

(*StandardEmbedding[l_List]:=Graph[l, CircularVertices[Length[l]]]*)

StandardEmbedding[l_List]:=FromAdjacencyMatrix[l]

StandardDirectedEmbedding[l_List]:=FromAdjacencyMatrix[l,Type->Directed]

(** StarQ **)

StarQ[g_Graph]=V[g]>0&&isomorphicQ[g,Star[V[g]]]

(** StronglyBinaryTreeQ **)

StronglyBinaryTreeQ[g_Graph]:=Module[{d=Degrees[g]},
    (d[[1]]==0||d[[1]]==2)&&Complement[Rest[d],{1,3}]==={}
]

(** Strongly Regular **)

StronglyRegularQ[g_Graph]:=StronglyRegularQ[ToAdjacencyMatrix[g],g]
StronglyRegularQ[a_List?MatrixQ,g_Graph]:=Module[{e=Edges[g],s=Subsets[Range[Length[a]],{2}]},
	If[Head[s]===Subsets,$Failed,
	RegularQ[g]&&
	  Equal@@(Length/@NearestNeighbors[a,e])&&
      Equal@@(Length/@NearestNeighbors[a,Complement[s,Sort/@e]])
    ]]

(** SymmetricGraphQ **)

SymmetricGraphQ[g_Graph]:=RegularQ[g]&&VertexTransitiveQ[g]&&EdgeTransitiveQ[g]

(** TadpoleGraph **)

TadpoleGraph[n_, k_] := Module[{c = Cycle[n], p = Path[k]},
    AddEdges[ChangeVertices[GraphUnion[c, p], Join[Vertices[c], ({If[k == 1, 2, 1], 0} + #) & /@ Vertices[p]]], {{n, n + 1}}]
]
    
(** ToCommonEdges **)

ToCommonEdges[g1_Graph, p_List] := Vertices[g1][[inversePermutation[p]]]
ToCommonEdges[g1_, p_List] := ToCommonEdges[CombinatoricaGraph[g1],p] /; Head[GraphData[g1,"Name"]] =!= GraphData
ToCommonEdges[g1_Graph, g2_Graph] := Vertices[g1][[$Isomorphism[g2, g1]]]
ToCommonEdges[g1_Graph, g2_] := ToCommonEdges[g1,CombinatoricaGraph[g2]] /; Head[GraphData[g2,"Name"]] =!= GraphData
ToCommonEdges[g1_, g2_] := ToCommonEdges@@(CombinatoricaGraph/@{g1,g2}) /; And@@(Head[GraphData[#,"Name"]] =!= GraphData)&/@{g1,g2}

(** Topological Graphs **)

TopologicalReduce[g_Graph]:=Module[
    {
      removableedge,d=Degrees[g],pairs=ToUnorderedPairs[g]
    },
    If[(removableedge=
            Flatten[Position[
                pairs/.Thread[
                    Range[Length[d]]->d],_?(#=={2,2}||#=={1,2}||#=={2,1}&)],
              1])=={},Return[g]];

    (* exclude triangles in which {a,b} both share c *)
    
    pairs=Select[pairs[[removableedge]],(!TriangleGraphQ[pairs,#]&)];
    If[pairs=={},g,Contract[g,pairs[[1]]]]
]

TopologicalGraphList[g_Graph]:=FixedPointList[TopologicalReduce,g]

TopologicalGraph[g_Graph]:=FixedPoint[TopologicalReduce,g]

TopologicalGraphs[n_]:=TopologicalGraphs[n]=Union[ConnectedGraphs[n],
      SameTest->(isomorphicQ[TopologicalGraph[#1],
              TopologicalGraph[#2]]&)]

(** Tournament **)

Tournaments[n_]:=
  Select[ListGraphs[n,Binomial[n,2],Directed],CompleteQ[MakeUndirected[#]]&]

TournamentQ[g_Graph]:=OrientedGraphQ[g]&&CompleteQ[MakeUndirected[g]]
           
(** Traceable **)

TraceableQ[g_Graph] := False /; !ConnectedQ[g]

TraceableQ[g_Graph]:=HamiltonianPath[g]!={}

TraceableQ::notdef = "GraphData[`1`,\"HamiltonianPaths\"] is not defined; computing the first one instead."
TraceableQ[s_]:=Module[{hp=GraphData[s,"HamiltonianPaths"]},
	If[ListQ[hp],
		hp=!={},
	(* Else *)
		Message[TraceableQ::notdef,s];
		TraceableQ[CombinatoricaGraph[s]]
	]
] /; Head[GraphData[s,"Name"]] =!= GraphData

(** TransitiveDigraphQ **)

TransitiveDigraphQ[g_Graph]:=(RemoveSelfLoops[TransitiveClosure[g]]==g)

(** Trees **)

TreeEmbedding[g_Graph]:=RootedEmbedding[g,1]

Trees[n_Integer /; 1<=n<=14]:=Trees[n]=(TreeEmbedding/@ImportGraphs["Trees",n])
         
Trees[n_Integer?Positive]:=Trees[n]=Module[{g},
  Union[Flatten[
      Function[g,AddEdge[GraphUnion[g,EmptyGraph[1]],{n,#}]&/@Range[n-1]]/@
        Trees[n-1],1],SameTest->(isomorphicQ[#1,#2]&)]
]

(** Weighted Trees **)

(* actually want edges+1, not nodes, but the two are the same for trees *)

TreeWeights[g_Graph?TreeQ]:=Module[{i},
  Max/@Table[Length/@ConnectedComponents[DeleteVertex[g,i]],{i,V[g]}]
]

TreeMinimumWeight[g_Graph?TreeQ]:=Min[TreeWeights[g]]

(** TriangleFreeQ **)

(*
TriangleFreeGraphQ[g_Graph]:=Position[
	Subsets[Edges[g]],
  	_?(
  		Length[#]==3&&
  		Union[Length/@Split[Sort[Flatten[#]]]]=={2}&
  	),1,1]=={}
*)

TriangleFreeGraphQ[g_Graph] := TriangleFreeGraphQ[ToAdjacencyMatrix[g]]
TriangleFreeGraphQ[a:(_List?MatrixQ|_SparseArray)] := Tr[MatrixPower[SparseArray[a],3]]==0

(** TriangleGraphQ **)

TriangleGraphQ[l_List,p_List]:=
  And@@Table[Select[Complement[l,{p}],MemberQ[#,p[[i]]]&]!={},{i,2}]

(** TriangularGraph **)

TriangularGraph[n_]:=LineGraph[CompleteGraph[n]]

(** Unordered Pairs **)

UnorderedPairs[n_]:=Subsets[Range[n],{2}][[#]]&/@Subsets[Binomial[n,2]]

(** VertexTransitiveQ **)

VertexTransitiveQ[g_Graph]:=VertexTransitiveQ[FastAutomorphisms[g]]
VertexTransitiveQ[a_List?MatrixQ]:=TransitiveGroupQ[a]
VertexTransitiveQ[s_]:=VertexTransitiveQ[GraphData[s,"Automorphisms"]] /; ListQ[GraphData[s,"Automorphisms"]]

(** Weakly Binary **)

WeaklyBinaryTreeQ[g_Graph]:=Module[{d=Degrees[g]},
    First[d]<=1&&Max[Rest[d]]<=3
]

(** Weakly Regular **)

WeaklyRegularQ[g_Graph]:=Module[{a,e,s=Subsets[Range[V[g]],{2}]},
	If[Head[s]===Subsets,$Failed,
    RegularQ[g]&&(
        !Equal@@(Length/@NearestNeighbors[a=ToAdjacencyMatrix[g],e=Edges[g]])||
          !Equal@@(Length/@NearestNeighbors[a,Complement[s,Sort/@e]]))
    ]]

(** WebGraph **)

WebGraph[n_] := DeleteEdges[PrismGraph[n, 3], Partition[2 n + 1 Range[n], 2, 1, 1]]

(** WheelQ **)

WheelQ[g_Graph]=V[g]>2&&isomorphicQ[g,Wheel[V[g]]]

(** WriteNautyGraph **)

WriteNautyGraph[g_]:=WriteNautyGraph[g, $TemporaryPrefix<>"-nauty"<>ToString[Random[Integer,{0,10^10}]]<>".dre"]
WriteNautyGraph[g_Graph, file_String] := 
 Export[file,
  Join[
   {"", "!Graph 1.", "n=" <> ToString[V[g]] <> " $=0 g"}, 
   MapIndexed["  " <> ToString[#2[[1]] - 1] <> " : " <> StringJoin @@ Riffle[ToString /@ #1, " "] <> ";" &, ToAdjacencyLists[g] - 1],
   {"$$"}],
 "Lines"]

WriteNautyGraph[g_, file_] := WriteNautyGraph[Graph[g], file] /; Head[GraphData[g, "Name"]] =!= GraphData

End[]

(* Protect[  ] *)

EndPackage[]