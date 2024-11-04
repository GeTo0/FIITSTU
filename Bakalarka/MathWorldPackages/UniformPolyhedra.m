(* :Title: UniformPolyhedra *)

(* :Mathematica Version: 6.0 *)

(* :Author: Roman E. Maeder *)

(* :Summary:
This packages contains code to compute properties of all uniform polyhedra and to
produce graphic images of them.
*)

(* :Context: MathWorld`UniformPolyhedra` *)

(* :Package Version: 1.04 *)

(* :Copyright: Copyright 1993, Roman E. Maeder.

   Permission is granted to distribute verbatim copies of this package
   together with any of your packages that use it, provided the following
   acknowledgement is printed in a standard place:
 
	"UniformPolyhedra.m is distributed with permission by Roman E. Maeder."
  
   The newest release of UniformPolyhedra.m is available through MathSource.
*)

(* :History:
   v1.0  (1993-06   )    : for the Mathematica Journal
   v1.01 (1994-01   )    : for MathSource
   v1.02 (2002      ) eww: allow precision to be passed as a parameter
   v1.03 (2003-10-19) eww: added context
   v1.04 (2007-08-05) eww: Renamed VertexList to remove shadowing with GraphUtilities`
*)

(* :Keywords: semiregular polyhedra, uniform polyhedra, star polyhedra,
    solid modeling, Wythoff *)

(* :Source: 
    Zvi Har'El, Uniform solution for uniform polyhedra.
    	Geometriae Dedicata, 47, pp. 57-110, 1993.
    Zvi Har'El, program "kaleido.c".
    	Contact rl@gauss.technion.ac.il for information
    	about how to obtain this program.
    Maeder, Roman E., Uniform Polyhedra.
        The Mathematica Journal, 3(4), 1993.
*)


BeginPackage["MathWorld`UniformPolyhedra`"]

MakeUniform::usage = "MakeUniform[w] computes a polyhedron from its
	Wythoff symbol w."

Wythoff::usage = "Wythoff[poly] gives the Wythoff symbol
	of the polyhedron 'poly'."
OrderOfGroup::usage = "OrderOfGroup[poly] gives the order of the symmetry group of the polyhedron 'poly'."
SymmetryGroup::usage = "SymmetryGroup[poly] gives the name of the symmetry group of the polyhedron 'poly'."
Characteristic::usage = "Characteristic[poly] gives the Euler characteristic of the polyhedron 'poly'."
Density::usage = "Density[poly] gives the density (number of times sphere is covered) of the polyhedron 'poly'."
NumberOfFaceTypes::usage = "NumberOfFaceTypes[poly] gives number of different types of faces of the polyhedron 'poly'."
NumberOfFacesPerType::usage = "NumberOfFacesPerType[poly] gives number each type of face occurs in vertex configuration of the polyhedron 'poly'."
TypeOfFaces::usage = "TypeOfFaces[poly] gives the type of the faces of the polyhedron 'poly'."
ValenceOfVertices::usage = "ValenceOfVertices[poly] gives the number of faces around each vertex of the polyhedron 'poly'."
RawConfiguration::usage = "RawConfiguration[poly] gives the vertex configuration
(as index into TypeOfFaces) of the polyhedron 'poly'."
VertexConfiguration::usage = "VertexConfiguration[poly] gives the vertex configuration
	of the polyhedron 'poly'."
HemisphericalQ::usage = "HemisphericalQ[poly] is true if the polyhedron 'poly' has hemispherical faces."
OnesidedQ::usage = "OnesidedQ[poly] is true if the polyhedron 'poly' is non-orientable."
SnubQ::usage = "SnubQ[poly] is true if the 'poly' is a snub polyhedron."
CosA::usage = "CosA[poly] gives cosine of the angle subtended by the half-edges of the polyhedron 'poly'."
Gammas::usage = "Gammas[poly] gives the angles gamma_i of the polyhedron 'poly'."
NumberOfVertices::usage = "NumberOfVertices[poly] gives the total number of vertices of the polyhedron 'poly'."
NumberOfEdges::usage = "NumberOfEdges[poly] gives the total number of edges of the polyhedron 'poly'."
NumberOfFaces::usage = "NumberOfFaces[poly] gives the total number of faces of the polyhedron 'poly'."
TotalNumberOfFacesPerType::usage = "TotalNumberOfFacesPerType[poly] gives the total number of faces of each type of the polyhedron 'poly'."
VertexCoordinates::usage = "VertexCoordinates[poly] gives the coordinates of
	all vertices of the polyhedron 'poly'."
FaceList::usage = "FaceList[poly] gives a list of the vertices of each face of the polyhedron 'poly'."
UniformVertexList::usage = "UniformVertexList[poly] gives a list of the faces around
	each vertex of the polyhedron 'poly'."
FaceTypes::usage = "FaceTypes[poly] gives the index into TypeOfFaces for each
	face of the polyhedron 'poly'."
Adjacency::usage = "Adjacency[poly] gives the adjacency matrix of the
	polyhedron 'poly'."

w1::usage = "w1[p, q, r] is the Wythoff symbol p|q r."
w2::usage = "w2[p, q, r] is the Wythoff symbol p q|r."
w3::usage = "w3[p, q, r] is the Wythoff symbol p q r|."
w0::usage = "w0[p, q, r] is the Wythoff symbol |p q r.
	w0[3/2, 5/3, 3, 5/2] is the pseudo Wythoff symbol |3/2 5/3 3 5/2."

PolyhedronQ::usage = "PolyhedronQ[symbol] is true, if symbol is a uniform polyhedron."

PolyhedronProperties = {
OrderOfGroup,
SymmetryGroup,
Characteristic,
Density,
NumberOfFaceTypes,
NumberOfFacesPerType,
TypeOfFaces,
ValenceOfVertices,
VertexConfiguration,
Hemispherical,
Onesided,
Snub,
CosA,
Gammas,
NumberOfVertices,
NumberOfEdges,
NumberOfFaces,
TotalNumberOfFacesPerType,
PolyhedronQ
};

`uniform (* symbol used for polyhedra *)

`Private`k2name = {2->dihedral, 3->tetrahedral, 4->octahedral, 5->icosahedral}

UniformPolyhedra::err = "`1`: `2`"

Begin["`Private`"]

(* internal polyhedron attributes

g	order of group
k	type of group (2: dihedral, 3: tetrahedral, 4: octahedral, 5: icosahedral)
chi	characteristic
d	density
wythoff	Wythoff Symbol

n	number of face types
mi	number of faces of each type, Length[mi] == n (in configuration)
ni	type of i-th face, Length[ni] == n
m	valence of vertices (Sum@@Numerator[mi])
rot	vertex configuration, Length[rot] == m
snub*	True for snub triangles, Length[snub] == m

hemiQ	hemispherical?
onesidedQ non-orientable?
even*	number of even face to remove
snubQ	snub polyhedron?

gamma	angles gamma (Length[gamma] == n)
cosa	Cos[a]

v	number of vertices
e	number of edges
f	number of faces
fi	number of faces of type i (Length[fi] == n) (total)

adjacent	adjacency matrix
vcoord		vertex coordinates
incidence	faces incident at vertex i
faces		list of vertices of each face
ftype		type of i-th face in list faces (index into ni)

* temp attribute, removed after computation

*)

(* numerical tweak *)

(* eww: now pass as an argument to MakeUniform *)
(*
prec = 25;	(* numerical precision for vertex coords and angles *)
*)

(* consistency checks, returns {g, k, chi, d} *)
AnalyzeWythoff[w:(w1|w2|w3|w0)[_, _, _]|w0[_, _, _, _]] :=
    Module[{l = List @@ w, nums, g, k, chi, d},
        If[ Not[ And @@ (l > 1) ], Throw["Wythoff < 1"] ];
        nums = Numerator[l];
        k = Max[ nums ];
        If[ Count[l, 2] >= 2,
            (* dihedral *)
                {g, k} = {4k, 2},
            (* tetra, octa, icosa *)
                If[ k > 5, Throw["Wythoff symbol > 5"] ];
                If[ Length[Intersection[nums, {4, 5}]] > 1,
                    Throw["Wythoff symbol contains {4, 5}"] ];
                {g, k} = {24k/(6-k), k}
        ];
        If[ Length[w] === 3,
            chi = g/2 (Plus @@ (1/nums) - 1);
            d   = g/4 (Plus @@ (1/l) - 1);
            If[ d <= 0, Throw["d < 0"] ];
          , (* non-Wythoffian: special case, compute later *)
            If[ w =!= w0[3/2, 5/3, 3, 5/2], Throw["unknown Wythoff symbol"] ];
            {chi, d} = {0, 0};
        ];
        {g, k, chi, d}
    ]

makeUniform[poly_, w:(w1|w2|w3|w0)[p_, q_, r_]|w0[_, p_, q_, r_],prec_:25] :=
    Module[{ gt, kt, chit, dt, evenden, ca, nt },
	(* defaults *)
	hemiQ[poly] ^= False;
	onesidedQ[poly] ^= False;
	even[poly] ^= 0;
	snubQ[poly] ^= False;
	wythoff[poly] ^= w;

	{gt, kt, chit, dt} = AnalyzeWythoff[w];
	g[poly] ^= gt; k[poly] ^= kt;
	chi[poly] ^= chit; d[poly] ^= dt;
	Switch[ Head[w]
	  ,w1,	n[poly] ^= 2;
	  	m[poly] ^= 2*Numerator[p];
	  	v[poly] ^= g[poly]/m[poly];
		ni[poly] ^= {q,  r};
		mi[poly] ^= {p,  p};
		rot[poly] ^= Flatten[ Table[{1, 2}, {Numerator[p]}] ];
	  ,w2,	n[poly] ^= 3;
	  	m[poly] ^= 4;
	  	v[poly] ^= g[poly]/2;
		ni[poly] ^= {2r, p, q};
		mi[poly] ^= {2,  1, 1};
		rot[poly] ^= {1, 2, 1, 3};
		If[ p == compl[q], (* hemispherical *)
		    hemiQ[poly] ^= True;
		    d[poly] ^= 0;
		    If[ p != 2 && !(r == 3 && (p == 3 || q == 3)),
		        onesidedQ[poly] ^= True;
		        v[poly] ^= v[poly]/2;
		        chi[poly] ^= chi[poly]/2;
		    ]
		];
	  ,w3,	n[poly] ^= 3;
	  	m[poly] ^= 3;
	  	v[poly] ^= g[poly];
		ni[poly] ^= {2p, 2q, 2r};
		mi[poly] ^= {1,  1,  1};
		rot[poly] ^= {1, 2, 3};
		evenden = Position[ {p, q, r}, x_/; EvenQ[Denominator[x]] ];
		If[ Length[evenden] > 1, Throw["impossible"] ];
		If[ Length[evenden] == 1, (* onesided, special case *)
		    even[poly] ^= evenden[[1,1]];
		    onesidedQ[poly] ^= True;
		    d[poly] ^= 0;
		    v[poly] ^= v[poly]/2;
		    chi[poly] ^= chi[poly] -
		          g[poly] / Numerator[{p, q, r}[[even[poly]]]] / 2;
		];
	  ,w0,  n[poly] ^= 4;
	  	m[poly] ^= 6;
	  	v[poly] ^= g[poly] / 2;
		ni[poly] ^= {3, p, q, r};
		mi[poly] ^= {3, 1, 1, 1};
		rot[poly] ^= {1, 2, 1, 3, 1, 4};
		snubQ[poly] ^= True;
		snub[poly] ^= {True, False, True, False, True, False};
	];

	sortAndMerge[poly];
	
	(* solve fundamental equations *)

	{gt, ca} = SolveFundamental[mi[poly], ni[poly], 1, prec];
	gamma[poly] ^= gt;
	cosa[poly] ^= ca;
	
	(* postprocess special cases *)
	If[ even[poly] > 0,
	    nt = Drop[ni[poly], {even[poly]}];
	    gt = Drop[gamma[poly], {even[poly]}];
	    If[ Length[nt] == 1, (* were merged *)
	        n[poly] ^= 2;
	        m[poly] ^= 4;
	        nt = Join[nt, {compl[nt[[1]]]}];
	        gt = Join[gt, {-gt[[1]]}];
	        mi[poly] ^= {2, 2};
	        rot[poly] ^= {1, 1, 2, 2};
	    , (* else: normal case *)
	        n[poly] ^= 4;
	        m[poly] ^= 4;
	        nt = Join[nt, {compl[nt[[2]]], compl[nt[[1]]]}];
	        gt = Join[gt, {-gt[[2]], -gt[[1]]}];
	        mi[poly] ^= {1, 1, 1, 1};
	        rot[poly] ^= {1, 2, 4, 3};
	    ];
	    ni[poly] ^= nt;
	    gamma[poly] ^= gt;
	];
	If[ w === w0[3/2, 5/3, 3, 5/2], (* the last one *)
	    n[poly] ^= 5;
	    m[poly] ^= 8;
	    hemiQ[poly] ^= True;
	    d[poly] ^= 0;
	    mi[poly] ^= {4, 1, 1, 1, 1};
	    ni[poly] ^= {4, ni[poly][[1]], ni[poly][[2]],
	             ni[poly][[3]], compl[ni[poly][[1]]]};
	    gamma[poly] ^= {N[Pi/2, prec], gamma[poly][[1]], gamma[poly][[2]],
	                gamma[poly][[3]], -gamma[poly][[1]]};
	    rot[poly] ^= {rot[poly][[1]], rot[poly][[2]]+1, rot[poly][[3]],
	                  rot[poly][[4]]+1, rot[poly][[5]], rot[poly][[6]]+1,
	                  1, 5};
	    snub[poly] ^= Join[ snub[poly], {True, False} ];
	];

	(* count vertices  and faces *)
	count[poly];

	(* generate vertex coordinates and adjacency matrix *)
	vertices[poly];

	(* faces and incidence lists *)
	incidence[poly];

	(* clear temp attributes *)
	poly/: even[poly] =.;
	If[ snubQ[poly], poly/: snub[poly] =. ];

	PolyhedronQ[poly] ^= True; (* seal of approval *)
	poly
    ]

MakeUniform[w:(w1|w2|w3|w0)[_, _, _]|w0[_, _, _, _],prec_:25] :=
    Module[{uniform, res},
        res = Catch[makeUniform[uniform, w,prec]];
        If[res =!= uniform,
            Message[UniformPolyhedra::err, w, res]; $Failed,
            uniform ]
    ]

(* complement of a face *)
compl[r_] := r/(r-1)

(* permutation needed to sort l in reverse order *)

perm[l_List] :=
	#[[2]]& /@ Reverse[ Sort[ Transpose[{l, Range[Length[l]]}] ] ]

sortAndMerge[poly_] :=
    Module[{nt, mt, rt, i, tr, itr, sn, pi},

	(* sort vertices *)
	tr = perm[ ni[poly] ];
	itr = Position[tr, #][[1,1]]& /@ Range[Length[tr]]; (* inverse *)
	ni[poly] ^= ni[poly][[tr]];
	mi[poly] ^= mi[poly][[tr]];
	rot[poly] ^= itr[[ rot[poly] ]]; (* ! *)
	If[ even[poly] > 0, even[poly] ^= itr[[ even[poly] ]] ];

	nt = ni[poly]; mt = mi[poly]; rt = rot[poly];

	(* merge equal faces *)
	i = 1; 
	While[ i < n[poly],
	    If[ nt[[i]] == nt[[i+1]], (* equal *)
	        mt[[i]] += mt[[i+1]];
	        mt = Drop[mt, {i+1}]; nt = Drop[nt, {i+1}];
	        n[poly] ^= n[poly]-1;
	        If[ even[poly] > i, even[poly] ^= even[poly]-1 ];
	        rt = rt /. a_Integer /; a>i :> a-1;
	      ,
	        i++; (* different *)
	    ];
	];

	(* throw away digons *)
	i = Position[nt, 2];
	If[ Length[i] > 0,
	    If[ n[poly] == 1, Throw["degenerate (digons only)"] ];
	    i = i[[1, 1]];
	    m[poly] ^= m[poly] - Numerator[mt[[i]]];
	    nt = Drop[nt, {i}]; mt = Drop[mt, {i}];
	    If[ even[poly] > i, even[poly] ^= even[poly]-1 ];

	    pi = Flatten[ Position[rt, x_/;x != i, {1}] ];
	    rt = rt[[pi]];
	    rt = rt /. a_Integer /; a>i :> a-1;
	    If[ snubQ[poly],
	        sn = snub[poly][[pi]];
	        snub[poly] ^= sn;
	    ];
	    n[poly] ^= n[poly]-1;
	];
	ni[poly] ^= nt; mi[poly] ^= mt; rot[poly] ^= rt;
    ]

SolveFundamental[mi_List, ni_List, d_Integer?NonNegative, prec_] :=
    Module[{alphai, num, pi, cosa, ca1, calphai, delta, g1n, gammai},
    	num[x_] := N[x, prec+12]; (* numerical approx *)
    	pi = num[Pi];
    	(* alpha *)
    	alphai = pi/ni; calphai = Cos[alphai];
    	ca1 = calphai[[1]];
    	calphai = Drop[ calphai, 1 ];
    	
    	(* initial values *)
    	gammai = num[ pi/2 - alphai ];
        delta = pi d - Plus @@ (mi gammai);
    	
    	While[ Abs[delta] > 10^-prec,	(* iterative solution *)
    	    g1n = gammai[[1]] +
    	          delta Tan[gammai[[1]]]/Plus@@(mi Tan[gammai]);
    	    If[ g1n < 0 || g1n > pi, Throw["gamma out of range"]];
    	    cosa = ca1/Sin[g1n];
    	    gammai = Prepend[ ArcSin[ calphai/cosa ], g1n ];
    	    delta = pi d - Plus @@ (mi gammai);
    	];
    	N[{gammai, ca1/Sin[gammai[[1]]]}, prec]
    ]

count[poly_] :=
    Module[{},
	e[poly]  ^= m[poly] v[poly]/2;
	fi[poly] ^= v[poly] Numerator[mi[poly]]/Numerator[ni[poly]];
	f[poly]  ^= Plus @@ fi[poly];
	(* adjust d in a few cases *)
	If[ d[poly] > 0 && gamma[poly][[1]] > N[Pi/2],
		d[poly] ^= fi[poly][[1]] - d[poly]
	];
	If[ Length[wythoff[poly]] === 4, (* last one *)
		chi[poly] ^= v[poly] - e[poly] + f[poly]
	];
    ]

(* adj[[i, j]]: j-th vertex adjacent to vertex i, counterclockwise *)

(* coordinates are chosen to give a midradius of 1 *)

vertices[poly_] :=
    Module[{v1, v2, vlist, adj, frot, rev, nv, nvi, i,
            one, start, limit, k, lastk},
     With[{ca = cosa[poly], m = m[poly], v = v[poly], sn = snub[poly],
           gammas = Table[2*gamma[poly][[ rot[poly][[k]] ]], {k, m[poly]}] },
	adj   = Table[0, {v}, {m}];
	frot  = Table[0, {v}];
	vlist = Table[0, {v}];

	v1 = {0, 0, 1}/ca; (* first vertex *)
	frot[[1]] = 1; rev[1] = False;
	adj[[1, 1]] = 2;
	v2 = {2 ca Sqrt[1 - ca^2], 0, 2 ca^2 - 1}/ca; (* second vertex *)
	If[ snubQ[poly],
		frot[[2]] = If[ sn[[m]], 1, m ]; rev[2] = False;
		adj[[2, 1]] = 1;
	    , (* else reflexible *)
	    	frot[[2]] = 1; rev[2] = True;
	    	adj[[2, m]] = 1;
	];
	vlist[[1]] = v1; vlist[[2]] = v2; nv = 2;
	i = 1;
	While[ i <= nv, (* more work to do *)
	    If[ rev[i],
	             one = -1; start = m-1; limit = 1,
	             one =  1; start = 2; limit = m
	    ];
	    k = frot[[i]];   (* rotation to use first *)
	    v1 = vlist[[i]]; (* the center of rotation *)
	    v1 /= Sqrt[norm2[v1]]; (* unit vector *)
	    v2 = vlist[[ adj[[i, start - one]] ]];
	    Do[ (* rotate previous adjacent vertex *)
	        v2 = rotate[ v2, v1, one*gammas[[k]] ];
	        (* equality is good enough for comparison *)
	        (* searching backwards is faster *)
	        For[ nvi = nv, nvi > 0 && v2 != vlist[[nvi]], nvi-- ];
	        If[ nvi == 0, nvi = nv + 1 ]; (* new *)
	        adj[[i, j]] = nvi;
	        lastk = k;
	        k = next[k, m];
	        If[ nvi > nv, (* new vertex *)
	            If[ nvi > v, Throw["too many vertices"]];
	            vlist[[nvi]] = v2;
	            If[ snubQ[poly],
	                   frot[[nvi]] = If[ !sn[[lastk]], lastk,
	                   	If[ !sn[[k]], next[k, m], k ] ];
	                   rev[nvi] = False; adj[[nvi, 1]] = i;
	                ,
	                   frot[[nvi]] = k;
	                   If[ one > 0,
	                   	rev[nvi] = True; adj[[nvi, m]] = i,
	                   	rev[nvi] = False; adj[[nvi, 1]] = i
	                   ];
	            ];
	            nv = nvi;
	        ];
	      ,{j, start, limit, one}];
	    i++
	];
	If[ nv != v, Throw["not all vertices found"]];
	adjacent[poly] ^= adj;
	vcoord[poly] ^= vlist;
	firstrot[poly] ^= frot;
	Clear[rev];
    ]]

(* inc[[i, j]] j-th face at vertex i *)

incidence[poly_] :=
    Module[{ft, inc, fa, fl, newf = 1, i, j, ja, pap, tt, icurrent, oldi},
     With[{adj = adjacent[poly], m = m[poly], firstrot = firstrot[poly],
           rot = rot[poly], v = v[poly]},

	inc = Table[0, {v}, {m}];
	Do[
	    For[j = 1, j <= m, j++,
	        If[ inc[[i, j]] > 0, Continue[] ];
	        inc[[i, j]] = newf;
	        If[ newf > f[poly], Throw["too many faces"]];
	        tt = firstrot[[i]] + 
	        	If[ adj[[i, 1]] < adj[[i, m]], j - 1, - j - 1 ];
	        tt = Mod[tt - 1, m] + 1;
	        ft[newf] = rot[[tt]];
	        If[ onesidedQ[poly],
	            pap = Mod[ firstrot[[i]] + j, 2 ];
	        ];
	        fl = {i};
	        (* chase vertices of this face *)
	        icurrent = i;
	        ja = j;
	        While[ True,
	            oldi = icurrent;
	            icurrent = adj[[icurrent, ja]];
	            If[ icurrent == i, Break[] ];
	            (* search adj *)
	            For[ja = 1, ja <= m && adj[[icurrent, ja]] != oldi, ja++];
	            If[ ja > m, Throw["adj not found"]];
	            If[ onesidedQ[poly] &&
	                Mod[firstrot[[icurrent]] + ja, 2] == pap,
	                  inc[[icurrent, ja]] = newf;
	                  ja = next[ja, m];
	                ,
	                  ja = prev[ja, m];
	                  inc[[icurrent, ja]] = newf;
	            ];
	            fl = Append[fl, icurrent];
	        ];
	        fa[newf] = fl;
	        newf++;
	    ];
	  ,{i, 1, v}
	];
	incidence[poly] ^= inc;
	ftype[poly] ^= Array[ft, f[poly]];
	faces[poly] ^= Array[fa, f[poly]];
    ]]

(* properties *)

Wythoff[poly_?PolyhedronQ] := wythoff[poly]
OrderOfGroup[poly_?PolyhedronQ] := g[poly]
SymmetryGroup[poly_?PolyhedronQ] := k[poly] /. k2name
Characteristic[poly_?PolyhedronQ] := chi[poly]
Density[poly_?PolyhedronQ] := d[poly]
NumberOfFaceTypes[poly_?PolyhedronQ] := n[poly]
NumberOfFacesPerType[poly_?PolyhedronQ] := mi[poly]
TypeOfFaces[poly_?PolyhedronQ] := ni[poly]
ValenceOfVertices[poly_?PolyhedronQ] := m[poly]
RawConfiguration[poly_?PolyhedronQ] := rot[poly]
VertexConfiguration[poly_?PolyhedronQ] :=
    With[{d = Denominator[mi[poly][[1]]],
          l = TypeOfFaces[poly][[ RawConfiguration[poly] ]]},
        If[ d == 1, HoldForm[l], HoldForm[l/d] ]
    ]
HemisphericalQ[poly_?PolyhedronQ] := hemiQ[poly]
OnesidedQ[poly_?PolyhedronQ] := onesidedQ[poly]
SnubQ[poly_?PolyhedronQ] := snubQ[poly]
CosA[poly_?PolyhedronQ] := cosa[poly]
Gammas[poly_?PolyhedronQ] := gamma[poly]
NumberOfVertices[poly_?PolyhedronQ] := v[poly]
NumberOfEdges[poly_?PolyhedronQ] := e[poly]
NumberOfFaces[poly_?PolyhedronQ] := f[poly]
TotalNumberOfFacesPerType[poly_?PolyhedronQ] := fi[poly]
VertexCoordinates[poly_?PolyhedronQ] := vcoord[poly]
FaceList[poly_?PolyhedronQ] := faces[poly]
UniformVertexList[poly_?PolyhedronQ] := incidence[poly]
FaceTypes[poly_?PolyhedronQ] := ftype[poly]
Adjacency[poly_?PolyhedronQ] := adjacent[poly]


protected = Unprotect[Graphics3D]

Graphics3D[poly_Symbol?PolyhedronQ, opts___] :=
    With[{fcoord = vcoord[poly][[#]]& /@ faces[poly],
          ftypes = ni[poly][[ftype[poly]]]},
	Graphics3D[ Apply[ Convexify, Transpose[{fcoord, ftypes}], {1} ],
	            opts ]
    ]

(* how to render the edges of star-polygons. EdgeForm[] suppresses them.
   Default is to draw them *)

edges = {}

Convexify[vlist_List, p_] := Convexify[Reverse[vlist], compl[p]] /;
	Denominator[compl[p]] < Denominator[p]

Convexify[vlist_List, p_] :=
    Module[{m = Numerator[p], n = Denominator[p], k,
            v2list, tria, cent},
	k = 1 + Mod[n Ceiling[p], m] Floor[p];
	v2list = {vlist, RotateLeft[vlist, 1],
	          RotateLeft[vlist, -k], RotateLeft[vlist, k]};
	v2list = Apply[ inter, Transpose[v2list], {1} ];
	tria = Transpose[ {vlist, v2list, RotateLeft[v2list, -k]} ];
	cent = {v2list[[ Mod[k Range[0, m-1], m] + 1 ]]};
	Join[ edges, Polygon /@ Join[ tria, cent ] ]
    ]/; Denominator[p] == 2

Convexify[vlist_List, p_] :=
    Module[{m = Numerator[p], n = Denominator[p], k,
            quadra, v2list, tria, v3list, cent},
	k = 1 + Mod[n Ceiling[p], m] Floor[p];
	v2list = {vlist, RotateLeft[vlist, 1],
	          RotateLeft[vlist, -2k], RotateLeft[vlist, k]};
	v2list = Apply[ inter, Transpose[v2list], {1} ];
	v3list = {RotateLeft[vlist, -2k], RotateLeft[vlist, k],
	          RotateLeft[vlist, -k], RotateLeft[vlist, 2k]};
	v3list = Apply[ inter, Transpose[v3list], {1} ];
	quadra = Transpose[ {vlist, v2list, v3list, RotateLeft[v2list, -k]} ];
	tria = Transpose[ {v2list, RotateLeft[v3list, k], v3list} ];
	cent = {v3list[[ Mod[k Range[0, m-1], m] + 1 ]]};
	Join[ edges, Polygon /@ Join[ quadra, tria, cent ] ]
    ]/; Denominator[p] == 3

Convexify[vlist_List, p_] := Polygon[vlist] (* integer and catchall *)

(* intersection of two lines in 3D,
   after Andrew S. Glassner (Ed.), Graphics Gems *)

inter[a_, b_, c_, d_] :=
    With[{p1 = a, v1 = unit[b-a], p2 = c, v2 = unit[c-d]},
     Module[{v1v2, n2v1v2, s1, s2},
	v1v2 = cross[v1, v2];
	n2v1v2 = norm2[v1v2];
	s1 = Det[{p2-p1, v2, v1v2}]/n2v1v2;
	s2 = Det[{p2-p1, v1, v1v2}]/n2v1v2;
	(p1 + v1 s1 + p2 + v2 s2)/2
     ]
    ]

next[k_, p_] := Mod[k, p] + 1   (* offset one mod numbers *)
prev[k_, p_] := Mod[k-2, p] + 1

(* norms of vector, unit vectors *)

norm2[v_] := Plus@@(v^2)
norm[v_] := Sqrt[norm2[v]]
unit[v_] := v/norm[v]

(* rotation axis must be unit vector! *)

rotate[v_, axis_, a_] :=
    With[{p = axis(axis.v), q = cross[axis, v]},
	p + Cos[a] (v - p) + Sin[a] q
    ]

cross[ {ax_, ay_, az_}, {bx_, by_, bz_} ] :=
	{ay bz - az by, az bx - ax bz, ax by - ay bx}

Format[w1[p_, q_, r_]] :=
    StringForm["`1`|`2` `3`", InputForm[p], InputForm[q], InputForm[r]]
Format[w2[p_, q_, r_]] :=
    StringForm["`1` `2`|`3`", InputForm[p], InputForm[q], InputForm[r]]
Format[w3[p_, q_, r_]] :=
    StringForm["`1` `2` `3`|", InputForm[p], InputForm[q], InputForm[r]]
Format[w0[p_, q_, r_]] :=
    StringForm["|`1` `2` `3`", InputForm[p], InputForm[q], InputForm[r]]
Format[w0[o_, p_, q_, r_]] :=
    StringForm["|`1` `2` `3` `4`", InputForm[o], InputForm[p], InputForm[q], InputForm[r]]

Protect[ Evaluate[protected] ]

End[]

EndPackage[]
