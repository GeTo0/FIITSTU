(* ::Package:: *)

BeginPackage["GeneratorSquareGraph`"]
Equation::usage = "Equation[difficulty,directed] generates a Square graph problem with solution steps and final result.";
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
messageText = Grid[{
   {"\[Bullet] Pre\[SHacek]li sme v\[SHacek]etky vrcholy okrem koncov\[EAcute]ho a ohodnotili ich susedov."},
   {"\[Bullet] T\[YAcute]m p\[AAcute]dom sme dostali pre ka\[ZHacek]d\[YAcute] vrchol najlacnej\[SHacek]ie ohodnotenie, ak\[YAcute]m sa k nemu vieme dosta\[THacek] zo za\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu."},
   {"\[Bullet] Vieme tak spravi\[THacek] ak\[UAcute]si kostru grafu, ktor\[AAcute] obsahuje iba tie hrany, cez ktor\[EAcute] sa vieme najlacnej\[SHacek]ie dosta\[THacek] k nejak\[EAcute]mu vrcholu."},
   {"\[Bullet] Tento krok u\:013eah\[CHacek]uje vidite\:013enos\[THacek] pre kontrolu."},
   {"\[Bullet] Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" je ozna\[CHacek]en\[AAcute] \[CHacek]ervenou farbou."}
   }, Alignment -> Left, Spacings -> {2, 1}
   ];
,
finalGraph=displayVertexWeights[newGraph,vertexWeights];
messageText = Grid[{
   {"\[Bullet] Pre\[SHacek]li sme v\[SHacek]etky vrcholy okrem koncov\[EAcute]ho a ohodnotili ich susedov."},
   {"\[Bullet] T\[YAcute]m p\[AAcute]dom sme dostali pre ka\[ZHacek]d\[YAcute] vrchol najlacnej\[SHacek]ie ohodnotenie, ak\[YAcute]m sa k nemu vieme dosta\[THacek] zo za\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu."},
   {"\[Bullet] Vieme tak spravi\[THacek] ak\[UAcute]si kostru grafu, ktor\[AAcute] obsahuje iba tie hrany, cez ktor\[EAcute] sa vieme najlacnej\[SHacek]ie dosta\[THacek] k nejak\[EAcute]mu vrcholu."},
   {"\[Bullet] Tento krok u\:013eah\[CHacek]uje vidite\:013enos\[THacek] pre kontrolu."},
   {"\[Bullet] Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" neexistuje."}
   }, Alignment -> Left, Spacings -> {2, 1}
   ];
];
];

If[directed===True,
If[Length[path]>1,
currentEdge=Table[path[[i]]->path[[i+1]],{i,1,Length[path]-1}];highlightedGraph=HighlightGraph[newGraph,Style[currentEdge,Thick,Red]];finalGraph=displayVertexWeights[highlightedGraph,vertexWeights];
messageText = Grid[{
   {"\[Bullet] Pre\[SHacek]li sme v\[SHacek]etky vrcholy okrem koncov\[EAcute]ho a ohodnotili ich susedov."},
   {"\[Bullet] T\[YAcute]m p\[AAcute]dom sme dostali pre ka\[ZHacek]d\[YAcute] vrchol najlacnej\[SHacek]ie ohodnotenie, ak\[YAcute]m sa k nemu vieme dosta\[THacek] zo za\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu."},
   {"\[Bullet] Vieme tak spravi\[THacek] ak\[UAcute]si kostru grafu, ktor\[AAcute] obsahuje iba tie hrany, cez ktor\[EAcute] sa vieme najlacnej\[SHacek]ie dosta\[THacek] k nejak\[EAcute]mu vrcholu."},
   {"\[Bullet] Tento krok u\:013eah\[CHacek]uje vidite\:013enos\[THacek] pre kontrolu."},
   {"\[Bullet] Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" je ozna\[CHacek]en\[AAcute] \[CHacek]ervenou farbou."}
   }, Alignment -> Left, Spacings -> {2, 1}
   ];
,
finalGraph=displayVertexWeights[newGraph,vertexWeights];
messageText = Grid[{
   {"\[Bullet] Pre\[SHacek]li sme v\[SHacek]etky vrcholy okrem koncov\[EAcute]ho a ohodnotili ich susedov."},
   {"\[Bullet] T\[YAcute]m p\[AAcute]dom sme dostali pre ka\[ZHacek]d\[YAcute] vrchol najlacnej\[SHacek]ie ohodnotenie, ak\[YAcute]m sa k nemu vieme dosta\[THacek] zo za\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu."},
   {"\[Bullet] Vieme tak spravi\[THacek] ak\[UAcute]si kostru grafu, ktor\[AAcute] obsahuje iba tie hrany, cez ktor\[EAcute] sa vieme najlacnej\[SHacek]ie dosta\[THacek] k nejak\[EAcute]mu vrcholu."},
   {"\[Bullet] Tento krok u\:013eah\[CHacek]uje vidite\:013enos\[THacek] pre kontrolu."},
   {"\[Bullet] Toto je finalna kostra celeho grafu, na ktorej s\[UAcute] uk\[AAcute]zan\[EAcute] v\[SHacek]etky cesty z po\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu "<>ToString[numberToLetter[startVertex]]<>" do v\[SHacek]etk\[YAcute]ch ostatn\[YAcute]ch vrcholov, pri\[CHacek]om cesta do vrcholu "<>ToString[numberToLetter[endVertex]]<>" neexistuje."}
   }, Alignment -> Left, Spacings -> {2, 1}
   ];
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


numberedText=Table[Row[{ToString[j]<>") ",vypis[[i,j]]}],{j,Length[vypis[[i]]]}];
visitedText="nav\[SHacek]t\[IAcute]ven\[EAcute] vrcholy: "<>StringJoin[Riffle[ToString/@(numberToLetter/@visited),", "]];
graphCell=Print[Grid[{{finalGraph,Column[{Style[visitedText,FontSize->12],Style["POSTUP",FontSize->16,Bold,Red],Column[numberedText]}]}},Spacings->{2,1}]];

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


numberedText=Table[Row[{ToString[j]<>") ",vypis[[i,j]]}],{j,Length[vypis[[i]]]}];
visitedText="nav\[SHacek]t\[IAcute]ven\[EAcute] vrcholy: "<>StringJoin[Riffle[ToString/@(numberToLetter/@visited),", "]];
graphCell=Print[Grid[{{finalGraph,Column[{Style[visitedText,FontSize->12],Style["POSTUP",FontSize->16,Bold,Red],Column[numberedText]}]}},Spacings->{2,1}]];

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
makeSquareGraph[diff_,directed_]:=Module[{mygraph,edges,weights,edgeLabels,vertexABC,n1,n2,part1Edges,part2Edges,n,edgesNumber,vertexCoordinates={},edgeList,adjacencyMatrix,edgeProb=0.3,horizontalRow,verticalRow,totalSideVertices,xRange,yRange,randomConnections1,randomConnections2},

If[diff===EASY,
n=Input["Enter number of vertexes (10 recommended)"];
];
If[diff===MEDIUM,
n=Input["Enter number of vertexes (16 recommended)"];
];
If[diff===HARD,
n=Input["Enter number of vertexes (20 recommended)"];
];
adjacencyMatrix=ConstantArray[0,{n,n}];

totalSideVertices=(n-2)/2;
If[EvenQ[totalSideVertices],
horizontalRow=verticalRow=(totalSideVertices/2)+1,
horizontalRow=Ceiling[totalSideVertices/2]+1;
verticalRow=Floor[totalSideVertices/2]+1;
];

If[OddQ[horizontalRow],xRange=Range[-(horizontalRow-1)/2,(horizontalRow-1)/2,1],(*Odd case:centered at 0*)xRange=Join[Range[-horizontalRow/2,-1],Range[1,horizontalRow/2]]; (*Even case:symmetric around 0*)];

If[OddQ[verticalRow],
yRange=Range[(verticalRow-1)/2,-(verticalRow-1)/2,-1],
yRange=Join[Range[-verticalRow/2,-1],Range[1,verticalRow/2]];
];

Do[AppendTo[vertexCoordinates,{xRange[[i]],yRange[[-1]]}],{i,1,Length[xRange]}];
Do[AppendTo[vertexCoordinates,{xRange[[-1]],Reverse[yRange][[i]]}],{i,2,Length[yRange]-1}];
Do[AppendTo[vertexCoordinates,{xRange[[i]],yRange[[1]]}],{i,Length[xRange],1,-1}];
Do[AppendTo[vertexCoordinates,{xRange[[1]],Reverse[yRange][[i]]}],{i,Length[yRange]-1,2,-1}];

AppendTo[vertexCoordinates,{-0.5,0}];
AppendTo[vertexCoordinates,{0.5,0}];



If[directed===False,
For[i=1,i<=(n-3),i++,
adjacencyMatrix[[i,i+1]]=RandomInteger[{1,10}];
adjacencyMatrix[[i+1,i]]=adjacencyMatrix[[i,i+1]];
];
adjacencyMatrix[[1,n-2]]=RandomInteger[{1,10}];
adjacencyMatrix[[n-2,1]]=adjacencyMatrix[[1,n-2]];
adjacencyMatrix[[n,n-1]]=RandomInteger[{1,10}];
adjacencyMatrix[[n-1,n]]=adjacencyMatrix[[n,n-1]];

randomConnections1=RandomSample[Range[n-2],3];
Do[adjacencyMatrix[[n-1,randomConnections1[[i]]]]=RandomInteger[{1,10}];
adjacencyMatrix[[randomConnections1[[i]],n-1]]=adjacencyMatrix[[n-1,randomConnections1[[i]]]]; ,{i,1,3}];

randomConnections2=RandomSample[Range[n-2],3];
Do[adjacencyMatrix[[n,randomConnections2[[i]]]]=RandomInteger[{1,10}];
adjacencyMatrix[[randomConnections2[[i]],n]]=adjacencyMatrix[[n,randomConnections2[[i]]]]; ,{i,1,3}];


edges=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{i\[UndirectedEdge]j},Nothing],{i,1,n},{j,i+1,n}]];weights=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{adjacencyMatrix[[i,j]]},Nothing],{i,1,n},{j,i+1,n}]];edgeLabels=MapThread[#1->Placed[#2,1/3]&,{edges,weights}];
];

If[directed===True,
For[i=1,i<=(n-3),i++,
adjacencyMatrix[[i,i+1]]=RandomInteger[{1,10}];
If[RandomReal[]<0.5,
adjacencyMatrix[[i+1,i]]=RandomInteger[{1,10}];
];
];
adjacencyMatrix[[1,n-2]]=RandomInteger[{1,10}];
If[RandomReal[]<0.5,
adjacencyMatrix[[n-2,1]]=RandomInteger[{1,10}];
];
adjacencyMatrix[[n,n-1]]=RandomInteger[{1,10}];
adjacencyMatrix[[n-1,n]]=RandomInteger[{1,10}];

randomConnections1=RandomSample[Range[n-2],3];
Do[
adjacencyMatrix[[n-1,randomConnections1[[i]]]]=RandomInteger[{1,10}];
If[RandomReal[]<0.5,
adjacencyMatrix[[randomConnections1[[i]],n-1]]=RandomInteger[{1,10}];
];
,{i,1,3}
];

randomConnections2=RandomSample[Range[n-2],3];
Do[
adjacencyMatrix[[n,randomConnections2[[i]]]]=RandomInteger[{1,10}];
If[RandomReal[]<0.5,
adjacencyMatrix[[randomConnections2[[i]],n]]=RandomInteger[{1,10}];
];
,{i,1,3}
];

edges=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{i->j},Nothing],{i,1,n},{j,1,n}]];
weights=Flatten[Table[If[adjacencyMatrix[[i,j]]>0,{adjacencyMatrix[[i,j]]},Nothing],{i,1,n},{j,1,n}]];
edgeLabels=MapThread[#1->Placed[#2,1/3]&,{edges,weights}];];

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
VertexLabelStyle->Directive[FontSize->14,Bold],
VertexCoordinates->vertexCoordinates
];
{mygraph,edges,weights,edgeLabels,vertexABC,n}
]

Equation[difficulty_,directed_] := Module[{solution, mygraph, edges, weights, vertexABC, vertexCount,problemText,graphProblem,startVertex,
endVertex,vertexWeights,graphCell,vertexPositions,tempImage},

{mygraph,edges,weights,edgeLabels,vertexABC,n}=makeSquareGraph[difficulty,directed];
vertexPositions = GraphEmbedding[mygraph];
graphCell=PrintTemporary[Show[mygraph,Graphics[Table[Text[Style["\[Infinity]",FontSize->16,Bold],vertexPositions[[i]]],{i,1,Length[vertexPositions]}]]]];

startVertex=letterToNumber[Input["Enter the starting vertex (A, B, C, ...):"]];
endVertex=letterToNumber[Input["Enter the ending vertex (A, B, C, ...):"]];
mygraph=modifyVertexColor[mygraph,{startVertex},Green];
mygraph=modifyVertexColor[mygraph,{endVertex},Magenta];
vertexWeights=ConstantArray[\[Infinity],n];
vertexWeights[[startVertex]]=0;
NotebookDelete[graphCell];

problemText = Grid[{
   {"\[Bullet] Tu je zadan\[YAcute] graf. Va\[SHacek]ou \[UAcute]lohou je pomocou Dijkstrovho algoritmu n\[AAcute]js\[THacek] najkrat\[SHacek]iu cestu zo za\[CHacek]iato\[CHacek]n\[EAcute]ho vrcholu do koncov\[EAcute]ho."},
   {"\[Bullet] D\[OHat]le\[ZHacek]it\[EAcute] je dba\[THacek] na z\[AAcute]sady Dijkstrovho algoritmu. Funguje tak, \[ZHacek]e z vrcholu prech\[AAcute]dzate v\[SHacek]etk\[YAcute]ch NENAV\[CapitalSHacek]T\[CapitalIAcute]VEN\[CapitalYAcute]CH susedov a dop\:013a\[NHacek]ate ohodnotenia cesty do nich."},
   {"\[Bullet] Po prejden\[IAcute] v\[SHacek]etk\[YAcute]ch susedov vrcholu prejdete na \[DHacek]al\[SHacek]\[IAcute] vrchol, vyber\[AAcute]te iba z vrcholov, z ktor\[YAcute]ch ste neh\:013eadali susedov a zvy\[CHacek]ajne prech\[AAcute]dzate na ten, \[CHacek]o m\[AAcute] z nich najmen\[SHacek]ie ohodnotenie."},
   {"\[Bullet] NIKDY neh\:013ead\[AAcute]te susedov koncov\[EAcute]ho vrcholu. (Pr\[IAcute]klad: Majme vrcholy A, B, C, D, E. Za\[CHacek]\[IAcute]name v A kon\[CHacek]\[IAcute]me v E. Najprv n\[AAcute]jdete susedov pre A, tak\[ZHacek]e B, C, D, E."},
   {"\[Bullet] Povedzme, \[ZHacek]e vrchol C m\[AAcute] najlacnej\[SHacek]iu cestu, prejdete na\[NHacek]. Teraz n\[AAcute]jdete susedov pre C, to bud\[UAcute] B, D, E."},
   {"\[Bullet] Takto pokra\[CHacek]ujete, k\[YAcute]m neprejdete v\[SHacek]etky vrcholy okrem koncov\[EAcute]ho, teda E."},
   {"\[Bullet] V pr\[IAcute]pade \[ZHacek]e z bodu C bude cesta do nejak\[EAcute]ho vrcholu, napr. E, lacnej\[SHacek]ia ako bola z vrcholu A, tak cenu vrcholu E prep\[IAcute]\[SHacek]ete na lacnej\[SHacek]iu.)"}
   }, Alignment -> Left, Spacings -> {2, 1}
   ];
   
graphProblem=displayVertexWeights[mygraph,vertexWeights];
graphCell=Grid[{{graphProblem,Column[{Style["ZADANIE",FontSize->16,Bold,Red],Style[problemText,FontSize->14,LineSpacing->{1.5}]}]}},Spacings->{2,1}];
tempImage = Rasterize[graphCell];
PrintTemporary[tempImage];

DijkstraAlgorithm[mygraph,startVertex,endVertex,edges,weights,vertexWeights,directed]
]

EndPackage[];
