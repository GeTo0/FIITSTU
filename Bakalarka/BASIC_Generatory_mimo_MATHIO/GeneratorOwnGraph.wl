(* ::Package:: *)

BeginPackage["GeneratorOwnGraph`"]
Equation::usage = "Equation[directed] generates a your own graph problem based on matrix you input with solution steps and final result.";
Internal`$ContextMarks = False;

letterToNumber[letter_]:=ToCharacterCode[ToString[letter]][[1]]-64
numberToLetter[number_]:=FromCharacterCode[number+64]
modifyVertexColor[graph_,vertices_,color_]:=Module[{newGraph=graph},Do[newGraph=SetProperty[newGraph,{VertexStyle->{vertex->color}}],{vertex,vertices}];newGraph]

displayVertexWeights[graph_,vertexWeights_]:=Module[{newGraph,vertexPositions},vertexPositions = GraphEmbedding[graph];newGraph=Show[graph,Graphics[Table[Text[Style[If[vertexWeights[[i]]===\[Infinity],"\[Infinity]",ToString[vertexWeights[[i]]]],FontSize->16,Bold],vertexPositions[[i]]],{i,1,Length[vertexPositions]}]]];Return[newGraph]]

DijkstraUndirectedCore[mygraph_,startVertex_,endVertex_,edges_,weights_,vertexWeights_List]:=Module[{neighbors,edgeWeight2,edgeIndex,updatedvertexWeights,currentEdge,unvisited,currentVertex,smallestWeight,newWeight,visited,predecessors,paths,steps={},vypis={},text={}},

updatedvertexWeights=vertexWeights;
unvisited=DeleteCases[Range[Length[vertexWeights]],endVertex];
visited={};
predecessors=Table[None,{Length[vertexWeights]}];
currentVertex=startVertex;

While[Length[unvisited]>0,
neighbors=VertexList[NeighborhoodGraph[mygraph,{currentVertex},1]]/. currentVertex->Nothing;
neighbors=Complement[neighbors,visited];
For[i=1,i<=Length[neighbors],i++,
edgeIndex=FirstPosition[edges,currentVertex\[UndirectedEdge]neighbors[[i]]]/. Missing["NotFound"]:>FirstPosition[edges,neighbors[[i]]\[UndirectedEdge]currentVertex];

If[i===1,
If[currentVertex === startVertex,
text=AppendTo[text,"Zaciname v zvolenom vrchole " <>ToString[numberToLetter[currentVertex]]];
,
text=AppendTo[text,"Presli sme na vrchol " <>ToString[numberToLetter[currentVertex]]<>" ke\[DHacek]\[ZHacek]e mal najni\[ZHacek]\[SHacek]iu cenu zo susedov predch\[AAcute]dzaj\[UAcute]ceho vrcholu"];
];
];

If[edgeIndex=!=Missing["NotFound"],
AppendTo[text,"Teraz sme presli na hranu "<> ToString[numberToLetter[currentVertex]]<>"-"<>ToString[numberToLetter[neighbors[[i]]]]];
edgeWeight2=weights[[First[edgeIndex]]];
newWeight=updatedvertexWeights[[currentVertex]]+edgeWeight2;

If[newWeight<updatedvertexWeights[[neighbors[[i]]]],
updatedvertexWeights[[neighbors[[i]]]]=newWeight;
predecessors[[neighbors[[i]]]]=currentVertex;
AppendTo[text,"Vid\[IAcute]me, \[ZHacek]e cena cesty cez teraj\[SHacek]\[IAcute] vrchol "<>ToString[numberToLetter[currentVertex]]<>" do vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<>" je lacnej\[SHacek]ia ako teraj\[SHacek]ia, tak prep\[IAcute]\[SHacek]em cenu vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<> " na cenu "<>ToString[newWeight]];
,
AppendTo[text,"Vid\[IAcute]me, \[ZHacek]e cena cesty cez teraj\[SHacek]\[IAcute] vrchol "<>ToString[numberToLetter[currentVertex]]<>" do vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<>" nie je lacnej\[SHacek]ia, tak\[ZHacek]e neprep\[IAcute]\[SHacek]em cenu vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]];
];
AppendTo[steps,{currentVertex,neighbors[[i]],updatedvertexWeights}];
AppendTo[vypis,text];
text={};
];
];

visited=Append[visited,currentVertex];
unvisited=DeleteCases[unvisited,currentVertex];
smallestWeight=Min[updatedvertexWeights[[unvisited]]];

If[smallestWeight===\[Infinity],Break[]];
currentVertex=First[Select[unvisited,updatedvertexWeights[[#1]]==smallestWeight&]];
];

paths=Table[path={};
currentVertex=i;
While[currentVertex=!=None,
path=Prepend[path,currentVertex];
currentVertex=predecessors[[currentVertex]];
];
path,{i,1,Length[vertexWeights]}
];
{updatedvertexWeights,predecessors,paths,steps,vypis}]


DijkstraDirectedCore[mygraph_,startVertex_,endVertex_,edges_,weights_,vertexWeights_List]:=Module[{neighbors,edgeWeight2,edgeIndex,updatedvertexWeights,currentEdge,unvisited,currentVertex,smallestWeight,newWeight,visited,predecessors,paths,steps={},vypis={},text={}},

updatedvertexWeights=vertexWeights;
unvisited=DeleteCases[Range[Length[vertexWeights]],endVertex];
visited={};
predecessors=Table[None,{Length[vertexWeights]}];
currentVertex=startVertex;

While[Length[unvisited]>0,
neighbors=VertexList[NeighborhoodGraph[mygraph,{currentVertex},1]]/. currentVertex->Nothing;
neighbors=Complement[neighbors,visited];
For[i=1,i<=Length[neighbors],i++,
edgeIndex=FirstPosition[edges,currentVertex->neighbors[[i]]];

If[i===1,
If[currentVertex === startVertex,
text=AppendTo[text,"Zaciname v zvolenom vrchole " <>ToString[numberToLetter[currentVertex]]];
,
text=AppendTo[text,"Presli sme na vrchol " <>ToString[numberToLetter[currentVertex]]<>" ke\[DHacek]\[ZHacek]e mal najni\[ZHacek]\[SHacek]iu cenu zo susedov predch\[AAcute]dzaj\[UAcute]ceho vrcholu"];
];
];

If[edgeIndex=!=Missing["NotFound"],
AppendTo[text,"Teraz sme presli na hranu "<> ToString[numberToLetter[currentVertex]]<>"->"<>ToString[numberToLetter[neighbors[[i]]]]];
edgeWeight2=weights[[First[edgeIndex]]];
newWeight=updatedvertexWeights[[currentVertex]]+edgeWeight2;

If[newWeight<updatedvertexWeights[[neighbors[[i]]]],
updatedvertexWeights[[neighbors[[i]]]]=newWeight;
predecessors[[neighbors[[i]]]]=currentVertex;
AppendTo[text,"Vid\[IAcute]me, \[ZHacek]e cena cesty cez teraj\[SHacek]\[IAcute] vrchol "<>ToString[numberToLetter[currentVertex]]<>" do vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<>" je lacnej\[SHacek]ia ako teraj\[SHacek]ia, tak prep\[IAcute]\[SHacek]em cenu vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<> " na cenu "<>ToString[newWeight]];
,
AppendTo[text,"Vid\[IAcute]me, \[ZHacek]e cena cesty cez teraj\[SHacek]\[IAcute] vrchol "<>ToString[numberToLetter[currentVertex]]<>" do vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]<>" nie je lacnej\[SHacek]ia, tak\[ZHacek]e neprep\[IAcute]\[SHacek]em cenu vrcholu "<>ToString[numberToLetter[neighbors[[i]]]]];
];
AppendTo[steps,{currentVertex,neighbors[[i]],updatedvertexWeights}];
AppendTo[vypis,text];
text={};
];
];

visited=Append[visited,currentVertex];
unvisited=DeleteCases[unvisited,currentVertex];
smallestWeight=Min[updatedvertexWeights[[unvisited]]];

If[smallestWeight===\[Infinity],Break[]];
currentVertex=First[Select[unvisited,updatedvertexWeights[[#1]]==smallestWeight&]];
];

paths=Table[path={};
currentVertex=i;
While[currentVertex=!=None,
path=Prepend[path,currentVertex];
currentVertex=predecessors[[currentVertex]];
];
path,{i,1,Length[vertexWeights]}
];
{updatedvertexWeights,predecessors,paths,steps,vypis}]
(********************************************************************************************************************************)
showFinalResult[mygraph_,startVertex_,endVertex_,vertexWeights_,paths_,weights_,edges_,directed_]:=Module[{currentEdge,highlightedGraph,finalGraph,uniqueEdges,vertexPositions,edgeLabels,newGraph,vertexABC,uniqueWeights,path,messageText},

If[directed===False,
uniqueEdges=Union[Flatten[Table[Table[paths[[i,j]]\[UndirectedEdge]paths[[i,j+1]],{j,1,Length[paths[[i]]]-1}],{i,1,Length[paths]}]]];
uniqueWeights=Table[With[{pos=Position[edges,uniqueEdges[[i]]]~Join~Position[edges,Reverse[uniqueEdges[[i]]]]},If[pos==={},Null,weights[[pos[[1,1]]]]]],{i,Length[uniqueEdges]}];
,
uniqueEdges=Union[Flatten[Table[Table[paths[[i,j]]->paths[[i,j+1]],{j,1,Length[paths[[i]]]-1}],{i,1,Length[paths]}]]];
uniqueWeights=Table[With[{pos=Position[edges,uniqueEdges[[i]]]},If[pos==={},Null,weights[[pos[[1,1]]]]]],{i,Length[uniqueEdges]}];
];

vertexPositions = GraphEmbedding[mygraph];
edgeLabels=MapThread[#1->Placed[#2,1/6]&,{uniqueEdges,uniqueWeights}];
vertexABC=Table[ToString[FromCharacterCode[i+64]],{i,1,Length[vertexWeights]}];

newGraph=Graph[Range[Length[vertexWeights]],
uniqueEdges,
EdgeLabels->edgeLabels,
EdgeWeight->uniqueWeights,
EdgeLabelStyle->Directive[FontSize->12,Background->White,Blue],
EdgeStyle->Directive[Black,Arrowheads[0.02]],
VertexCoordinates->vertexPositions,
VertexStyle->Directive[LightBlue],
VertexLabels->Table[i->vertexABC[[i]],{i,Length[vertexWeights]}],
VertexLabelStyle->Directive[FontSize->14,Bold],
ImageSize->Large,GraphStyle->"NameLabeled"];

newGraph=modifyVertexColor[newGraph,{startVertex},Green];
newGraph=modifyVertexColor[newGraph,{endVertex},Magenta];

path=paths[[endVertex]];

If[directed===False,
If[Length[path]>1,
currentEdge=Table[path[[i]]\[UndirectedEdge]path[[i+1]],{i,1,Length[path]-1}];
highlightedGraph=HighlightGraph[newGraph,Style[currentEdge,Thick,Red]];
finalGraph=displayVertexWeights[highlightedGraph,vertexWeights];
messageText="Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" je ozna\[CHacek]en\[AAcute] \[CHacek]ervenou farbou.";
,
finalGraph=displayVertexWeights[newGraph,vertexWeights];
messageText="Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" neexistuje.";
];
];

If[directed===True,
If[Length[path]>1,
currentEdge=Table[path[[i]]->path[[i+1]],{i,1,Length[path]-1}];highlightedGraph=HighlightGraph[newGraph,Style[currentEdge,Thick,Red]];finalGraph=displayVertexWeights[highlightedGraph,vertexWeights];
messageText="Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" je ozna\[CHacek]en\[AAcute] \[CHacek]ervenou farbou.";
,
finalGraph=displayVertexWeights[newGraph,vertexWeights];
messageText="Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" neexistuje.";
];
];


graphCell=Print[Grid[{{finalGraph,Column[{Style["VYSLEDOK",FontSize->16,Bold,Red],Style[messageText,FontSize->14,LineSpacing->{1.5}]}]}},Spacings->{2,1}]];

]

replaySteps[mygraph_,steps_,directed_,vypis_]:=Module[{graphCell=None,currentEdge,highlightedGraph,finalGraph,updatedGraph,originalGraph,currentVertex,originalVertexColor,numberedText,visited={},visitedText},

originalGraph=mygraph;

If[directed===False,
For[i=1,i<=Length[steps],i++,
currentEdge={steps[[i,1]]\[UndirectedEdge]steps[[i,2]]};
currentVertex=steps[[i,1]];

If[!MemberQ[visited,currentVertex],AppendTo[visited,currentVertex]];

originalVertexColor=PropertyValue[{originalGraph,currentVertex},VertexStyle];
updatedGraph=modifyVertexColor[originalGraph,{currentVertex},Yellow];
highlightedGraph=HighlightGraph[updatedGraph,Style[currentEdge,Thick,Red]];
finalGraph=displayVertexWeights[highlightedGraph,steps[[i,3]]];

If[graphCell=!=None,
NotebookDelete[graphCell]
];
numberedText=Table[Row[{ToString[j]<>") ",vypis[[i,j]]}],{j,Length[vypis[[i]]]}];
visitedText="nav\[SHacek]t\[IAcute]ven\[EAcute] vrcholy: "<>StringJoin[Riffle[ToString/@(numberToLetter/@visited),", "]];
graphCell=PrintTemporary[Grid[{{finalGraph,Column[{Style[visitedText,FontSize->12],Style["POSTUP",FontSize->16,Bold,Red],Column[numberedText]}]}},Spacings->{2,1}]];

InputString["Press ENTER to continue..."];
originalGraph=modifyVertexColor[updatedGraph,{currentVertex},originalVertexColor];
];
];

If[directed===True,
For[i=1,i<=Length[steps],i++,
currentEdge={steps[[i,1]]->steps[[i,2]]};
currentVertex=steps[[i,1]];

If[!MemberQ[visited,currentVertex],AppendTo[visited,currentVertex]];

originalVertexColor=PropertyValue[{originalGraph,currentVertex},VertexStyle];
updatedGraph=modifyVertexColor[originalGraph,{currentVertex},Yellow];
highlightedGraph=HighlightGraph[updatedGraph,Style[currentEdge,Thick,Red]];
finalGraph=displayVertexWeights[highlightedGraph,steps[[i,3]]];

If[graphCell=!=None,
NotebookDelete[graphCell]
];
numberedText=Table[Row[{ToString[j]<>") ",vypis[[i,j]]}],{j,Length[vypis[[i]]]}];
visitedText="nav\[SHacek]t\[IAcute]ven\[EAcute] vrcholy: "<>StringJoin[Riffle[ToString/@(numberToLetter/@visited),", "]];
graphCell=PrintTemporary[Grid[{{finalGraph,Column[{Style[visitedText,FontSize->12],Style["POSTUP",FontSize->16,Bold,Red],Column[numberedText]}]}},Spacings->{2,1}]];

InputString["Press ENTER to continue..."];
originalGraph=modifyVertexColor[updatedGraph,{currentVertex},originalVertexColor];
];
];
]


DijkstraAlgorithm[mygraph_,startVertex_,endVertex_,edges_,weights_,vertexWeights_List,directed_]:=Module[{updatedvertexWeights,predecessors,paths,steps,input,vypis},
If[directed===False,
{updatedvertexWeights,predecessors,paths,steps,vypis}=DijkstraUndirectedCore[mygraph,startVertex,endVertex,edges,weights,vertexWeights];
input=InputString["Enter 'vysledok' for final result or 'postup' for step-by-step: "];
If[input==="vysledok",
NotebookDelete[graphCell];
showFinalResult[mygraph,startVertex,endVertex,updatedvertexWeights,paths,weights,edges,False],
If[input==="postup",
NotebookDelete[graphCell];
replaySteps[mygraph,steps,False,vypis];
showFinalResult[mygraph,startVertex,endVertex,updatedvertexWeights,paths,weights,edges,False];
];
];
,
{updatedvertexWeights,predecessors,paths,steps,vypis}=DijkstraDirectedCore[mygraph,startVertex,endVertex,edges,weights,vertexWeights];
input=InputString["Enter 'vysledok' for final result or 'postup' for step-by-step: "];
If[input==="vysledok",
NotebookDelete[graphCell];
showFinalResult[mygraph,startVertex,endVertex,updatedvertexWeights,paths,weights,edges,True],
If[input==="postup",
NotebookDelete[graphCell];
replaySteps[mygraph,steps,True,vypis];
showFinalResult[mygraph,startVertex,endVertex,updatedvertexWeights,paths,weights,edges,True]
];
]
];
]
(********************************************************************************************************************************)
makeOwnGraph[directed_]:=Module[{n,edges,weights,edgeLabels,mygraph,vertexABC,adjacencyMatrix},

adjacencyMatrix=Input["Insert adjacency matrix (example: '{{0,3,0},{3,0,5},{0,5,0}}' ):"];
n=Length[adjacencyMatrix];
If[directed===False,
edges=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{i\[UndirectedEdge]j},Nothing],{i,1,n},{j,i+1,n}]];weights=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{adjacencyMatrix[[i,j]]},Nothing],{i,1,n},{j,i+1,n}]];edgeLabels=MapThread[#1->Placed[#2,1/6]&,{edges,weights}];
];

If[directed===True,
edges=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{i->j},Nothing],{i,1,n},{j,1,n}]];weights=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{adjacencyMatrix[[i,j]]},Nothing],{i,1,n},{j,1,n}]];edgeLabels=MapThread[#1->Placed[#2,1/3]&,{edges,weights}];
];

vertexABC=Table[ToString[FromCharacterCode[i+64]],{i,1,n}];
mygraph=Graph[Range[n],
edges,
EdgeLabels->edgeLabels,
EdgeWeight->weights,
VertexLabels->Table[i->vertexABC[[i]],{i,n}],
VertexStyle->Directive[LightBlue],
GraphStyle->"NameLabeled",
ImageSize->Large,
EdgeLabelStyle->Directive[FontSize->12,Background->White,Blue],
EdgeStyle->Directive[Black,Arrowheads[0.02]],
VertexLabelStyle->Directive[FontSize->14,Bold]
];
{mygraph,edges,weights,edgeLabels,vertexABC,n}
]

Equation[difficulty_,directed_] := Module[{solution, mygraph, edges, weights, vertexABC, vertexCount},

{mygraph,edges,weights,edgeLabels,vertexABC,n}=makeOwnGraph[directed];
vertexPositions = GraphEmbedding[mygraph];
graphCell=PrintTemporary[Show[mygraph,Graphics[Table[Text[Style["\[Infinity]",FontSize->16,Bold],vertexPositions[[i]]],{i,1,Length[vertexPositions]}]]]];

startVertex=letterToNumber[Input["Enter the starting vertex (A, B, C, ...):"]];
endVertex=letterToNumber[Input["Enter the ending vertex (A, B, C, ...):"]];
mygraph=modifyVertexColor[mygraph,{startVertex},Green];
mygraph=modifyVertexColor[mygraph,{endVertex},Magenta];
NotebookDelete[graphCell];
graphCell=PrintTemporary[Show[mygraph,Graphics[Table[Text[Style["\[Infinity]",FontSize->16,Bold],vertexPositions[[i]]],{i,1,Length[vertexPositions]}]]]];

vertexWeights=ConstantArray[\[Infinity],n];
vertexWeights[[startVertex]]=0;

DijkstraAlgorithm[mygraph,startVertex,endVertex,edges,weights,vertexWeights,directed]
]

EndPackage[]
