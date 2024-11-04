(*:Mathematica Version: 6.0 *)

(*:Package Version: 4.10 *)

(*:Name: MathWorld`PlaneGeometry` *)

(*:Author: Eric Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/PlaneGeometry.m
*)

(*:Summary:

This package contains many routines for doing calculations and making 
figures in triangle geometry using trilinear coordinates.

Thanks to Peter Moses for code for general trilinear centers X[1]-X[6]
*)

(*:References:

Kimberling, C.  "Central Points and Central Lines in the Plane of a 
  Triangle."  _Math. Mag._ *67*, 163-187, 1994. 
Kimberling, C.  "Triangle Centers and Central Triangles."
  _Congr. Numer._ *129*, 1-295, 1998.

Eric's MathWorld pages at http://mathworld.wolfram.com/

For triangle centers:
	Kimberling, C.
	"Encyclopedia of Triangle Centers."
	http://faculty.evansville.edu/ck6/encyclopedia/ETC.html

For machine-readable triangle centers:
	Brisse, E.
	http://pages.infinit.net/spqrsncf/fx3053.htm

For trilinears of useful operations:
	Brisse, E.
	http://pages.infinit.net/spqrsncf/utf.htm

For named geometric objects:
	Brisse, E.
	http://pages.infinit.net/spqrsncf/ngorecent.htm

For trigonometric formulas:
	Brisse, E.
	http://pages.infinit.net/spqrsncf/trigo.htm

For triangle cubics:
	Gibert, B.
	"Cubics in the Triangle Plane."
	http://perso.wanadoo.fr/bernard.gibert/
  
*)

(*:Keywords:
  triangles, etc.
*)

(*:Requirements:
  Mathematica 5.1
*)

(*:Warning:
  Overloads built-in Center, Circle, Line, Graphics functions
*)

(*:Discussion:

  See Kimberling (1994, 1998).

  Kimberling's centers may be optionally loaded *after* this package using
  
    <<MathWorld`KimberlingCenters`
    
  That package was parsed by Eric Weisstein from Clark Kimberling's
  ETC.html file and from independent computations by Edward Brisse
  and Peter Moses.
*)

(*:ToDo:
  Fix:
    AngleBisectors
    Cevians
  Add:
  	*BCICircle
   	*EulerGergonneSoddyCircle
   	 InscribedSquaresCircle[1|2]
  	 JohnsonYff(Triangle|Circle)[1|2]
	*LucasCentralCircle
  	 CircleTriple[MalfattiCircles]
  	*MorleysAdjunctCircle
  	*ReflectionCircle
	 YffCentralCircle
	 CircleTriple[YffCentralTriangleCircles]
	 YffCirclesTriangleCircle[1|2]
	 YffTriangle[1|2]
	 
  *find nicer form

  Add more transformations to ToAngles from
    http://pages.infinit.net/spqrsncf/trigo.htm
  *)

(*:Limitations:

  A small number of routines were written long ago before Eric was a very good
  Mathematica programmer.  These should be rewritten to be more 
  efficient, concise, and elegant.
  
  Due to a limitation in Mathematica, assigning center[_Triangle]
  is extremely slow after loading KimberlingCenters.
*)

(*:History:
  v1.00 (Mar 24, 1995): Written
  v1.01 (Apr 10, 1998): CircumcircleDat and CircumcirclePts3 added which
                        calculate the circumcircle directly using
                        determinants without any triangle transformation
  v1.50 (May 31, 1998): Apollonius*, CollinearQ, HomotheticCenter, 
                        HomotheticCenterPlot, HomotheticLinesPlot, Inverse*,
                        Steiner*, Radical*,
                        Triangle.m renamed PlaneGeometry.m
  v1.51 (Jun  3, 1998): ApolloniusCirclesSolve	
  v1.52 (Jun 28, 1998): CircumcircleDet usage spelling corrected
  v1.53 (Jul  7, 1998): NapoleonTriangle fixed
  v1.54 (Aug  1, 1998): CircleTangent, CircleTangentPoint,
                        FuhrmannCircle, FuhrmannTriangle,
                        MidArcPoint1, MidArcPoint2, MidArcPoints, etc.,
                        MongesTangentCircle
  v1.55 (Aug 24, 1998): ApollonianGasket, CyclicQuadrilateral, 
                        CyclicQuadrilateralArcMidpoints,
                        CyclicQuadrilateralArcMidpointDiagonals, CyclicQuadrilateralFn,
                        DiagonalTriangle, HexagonTriangles, LineLineIntersection, 
                        polygon, SoddyRadii fixed
  v1.56 (Sep  8, 1998): FiveCircles, FregiersTheoremEllipse, 
                        FregiersTheoremParabola, GoldenRectangle
  v1.57 (Sep 15, 1998): JapaneseTheorem, Maltitudes, MaltitudesGraphic,
                        MaltitudeCyclicGraphics, MaltitudePoints,
                        MascheroniConstruction, MorleysTriangle,
                        MorleysTriangles
  v1.58 (Sep 16, 1998): Fixed spelling of Napoleon, extended NapoleonTriangle
                        to scalene triangles, NapoleonRatios,
                        NephroidEnvelope, ScaleneTriangularize
  v1.59 (Sep 18, 1998): Configuration[9,3,2], Configuration[9,3,3]
  v1.60 (Sep 20, 1998): CyclicOrder, PascalDiagram, PascalHexagon,
                        PascalHexagonIndices,
                        PascalLine, PascalLines, PascalPoints, PascalV,
                        PivotTheorem,
                        SideParallels, SteinerPointIndices, SteinerPoints
  v1.61 (Sep 27, 1998): Renamed BrocardPoint1[tri] to BrocardPoint[1,tri],
                        BrocardCircle, BrocardTriangle,
                        CircleCircleIntersection, CircleCircleIntersections,
                        CircleLineIntersection, CircleLineIntersectionPlot,
                        CoaxalCircles, Perpendicular, PerpendicularFeet,
                        Perpendiculars, PonceletTransverse, PonceletTransversePlot,
                        SymmedianPoint, TaylorCenter, TaylorCircle
  v1.62 (Sep 28, 1998): Isoscelizers, YffCenterAngleAlpha, YffCenter, YffCenterLengths,
                        YffCentralTriangle, YffCentralTriangleLengths
  v1.63 (Sep 29, 1998): PoincareArc, PoincareDisk, PonceletClosed,
                        PonceletClosedTransversePlot
  v1.64 (Oct  5, 1998): QuadrilateralTiling, TriangleTiling
  v1.65 (Oct  7, 1998): LemoineCircle, LemoineHexagon,
                        PonceletTangent, PonceletTransverseLines, 
                        TriangleInscribedSquare, TriangleInscribedSquares, Weill
  v1.66 (Oct  8, 1998): CeviansPoint, CleavancePoint, Cleavances,
                        ContactTraingle, EvansPoint, FletcherPoint,
                        GriffithsPoints, OldknowPoints, 
                        RigbyPoints, ShortestLine, Splitters
  v1.67 (Oct 11, 1998): OrthocenterVertexMidpoints renamed to EulerPoints,
                        BrocardAnglesn[tri] renamed to BrocardAngles[n,tri],
                        AdamsCircle, AdamsCirclePoints,
                        AngleBisectorIntersections, Anticenter, CartesianToTrilinear,
                        CyclicQuadrilateralPerp, ExcentralNestedTriangles,
                        FuhrmannPoints, MidpointDiagonals, PointLabels, Quadrilateral,
                        SymmedialTriangle, Symmedians
  v1.68 (Oct 12, 1998): DrozFarny et al, MedialCircle, Miquel Circles, MiquelPoint,
                        MiquelPoints, MiquelTriangle
  v1.69 (Oct 13, 1998): renamed SideParallels to Parallels,
                        Antiparallel, Antiparallels, AntiparallelCircle,
                        CosineCircle, CosineHexagon, Parallel, Parallels,
                        PerimeterPoint, TuckerCircle, TuckerHexagon
  v1.70 (Oct 14, 1998): Kite, IsoscelesTrapezoid, TangentialQuadrilateral,
                        TangentialQuadrilateralNormals
  v1.71 (Oct 18, 1998): Fixed AdamsCircle, ContactTriangle,
                        AdamsTriangle, BrocardCircumtriangle
  v1.72 (Oct 20, 1998): Fixed BrocardTriangle,
                        BrocardTrianglePerpendiculars
  v1.73 (Oct 21, 1998): Orthopole, OrthopoleLines, OrthopolePoints
  v1.74 (Oct 22, 1998): AngleBisectorsLine, CevianCircle, CevianCircleLines, CevianCircleTriangle,
                        CevianCircleTrianglePoint, CeviansReflected, 
                        CevianTriangleReflected, CevianTriangleReflectedPoint,
                        OrthicAxis, OrthicAxisLines
  v1.75 (Oct 24, 1998): TangentialTriangleLines, TangentialTrianglePoints
  v1.76 (Oct 29, 1998): Implemented general formula for PonceletClosed
  v1.77 (Nov  2, 1998): SimsonLineVertexPoint changed to SimsonLinePole
  v1.78 (Nov  6, 1998): SimsonLinePole changed to CircumcirclePoint,
                        Ang, Chord, PerpSquare, RigbyPoint, SimsonLinePoleAngle
  v1.79 (Nov 14, 1998): Reuleaux, ReuleauxCenter, ReuleauxCenterPath, etc.,
                        RollingPolygon
  v1.80 (Nov 15, 1998): Extended PointLabels, CircleCircleIntersection, and
                        CircleCircleIntersections, added NinePointCircles
  v1.81 (Dec  7, 1998): KochanskyConstruction, TentProblem
  v1.83 (Dec 13, 1998): EllipticalBilliards
  v1.84 (Dec 15, 1998): ReuleauxPolygon
  v1.85 (Jan 28, 1999): Rotor
  v1.86 (Jan 30, 1999): CornerCircle, CornerCircles, CornerExcircles,
                        SevenCircles, SevenCirclesPoint, SevenCirclesTriangle,
                        SevenCirclesTrianglePoint, SixCircles, TriangleInteriorQ
  v1.87 (Feb  4, 1999): SteinerChainLinesPlot, SteinerChainPoints,
                        SteinerCircles, SteinerIntersectionPoint, SteinLines
  v1.88 (Feb 15, 1999): CongruentIsoscelizers, CongruentIsoscelizersPoint
  v1.89 (Mar 28, 1999): PolygonalFilledSpiral, PolygonalSpiral
  v1.90 (Apr 17, 1999): GriffithsDiagram, GriffithsPoint
  v1.91 (May 21, 1999): HarmonicConjugatePoints
  v1.92 (Jun 20, 1999): AltitudeTriangle
  v1.93 (Aug 15, 1999): Order of Soddy circles changed to {inner, outer}.
                        TangentCirclesOnALine, TwoTangentCircles
  v1.94 (Aug 17, 1999): RightTriangleSquares
  v1.95 (Aug 17, 1999): CircleCircleTriangle, CircleCircleTangent,
                        CircleCircleTangentDiagram
  v1.96 (Aug 18, 1999): Circumcircle interface changed to Method-> (Determinant|Trilinear)
  v1.97 (Sep 20, 1999): Moved IsogoncCenter to FermatPoint
  v1.98 (Sep 28, 1999): ConvexPolygon
  v1.99 (Jan  1, 2000): AngleBisectorLabel, McCayCircles, Neuberg*.
                        Happy New Millennium, ya'll!
  v2.00 (Jan 10, 2000): PonceletClosed fixed
  v2.01 (Jan 15, 2000): Added start angle argument to SteinerChain.
                        Cleaned up some Poncelet-related routines.  Added
                        LimitingPoints, PonceletDiagonalsPlot.
  v2.02 (Mar  7, 2000): AuxiliaryCircle
  v2.03 (Mar 21, 2000): DoubleBubble, TriquetraTheorem
  v2.04 (Apr 16, 2000): Area renamed TriangleArea and merged with TriangleAreaSigned.
  v2.05 (Jun  1, 2000): Escaped usage newlines.  Conic.
  v2.06 (Jun  3, 2000): Parallelogram.  ErectPolygon, ErectPolygons,
                        ErectedPolygonCenters.  Spelling for NapoleonPoint
                        etc. fixed.
  v2.07 (Jun 12, 2000): PascalLine removed (it's really LongestLine)
  v2.08 (Jul  4, 2000): Added ReuleauxEnvelope
  v2.09 (Aug 20, 2000): Deleted ScaleneTriangularize and rewrote from scratch
                        as ErectScaleneTriangles.  PerspectiveQ,
                        PerspectiveAxisPoints, KiepertParabolaFocus.
                        Disabled Triangle evaluation.
                        Now leave it unevaluated, but teach Show[Graphics[Triangle]]
                        how to display it.  Same for Quadrilateral.
  v2.10 (Aug 28, 2000): ExactTrilinears, Hexagon
  v2.11 (Sep 13, 2000): AcuteQ, ObtuseQ, SidesToTriangle
  v2.12 (Oct 15, 2000): ArealCoordinates
  v2.13 (Jan  2, 2001): Changed Side to Sides.  Angles now recognizes Triangle 
                        objects.  Added TriangleQ.
  v2.90 (Dec  3, 2001): Changed center and other commands to take Triangle[list] and
                        Quadrilateral[list] instead of just list as an argument.  
                        Fixed up usage messages accordingly.  Added many new
                        commands and completely rewrote center function syntax
                        to use CenterFunction[ctr].  This is a huge improvement
                        in elegance and maintainability.  Renamed Sides to SideLengths
                        and added Sides.  Removed a number of functions that don't
                        belong in this package.  There may still be some functions that 
                        didn't get updated properly from these major changes, so 
                        beware of bugs.
  v2.91 (Dec  6, 2001): Now includes centers up through X[110] thanks to Ed Pegg.
                        Added Names for X-centers
  v2.92 (Dec 11, 2001): Combined CircleCircleIntersection, CircleLineIntersection, and
                        LineLineIntersection into Intersections.  Added Names for
                        all other centers
  v2.93 (Jul  3, 2002): Fixed Orthopole; added OrthopolarLine
  v2.94 (Jul 22, 2002): Added PerpendicularBisector[line]
  v2.95 (Jul 28, 2002): PointLineDistanceEndpoints merged into
                        PointLineDistance, added Reflection
  v2.96 (Sep 24, 2002): CircleCircleIntersection now returns {} if the circles
                        do not intersect
  v2.97 (Dec 20, 2002): ClawsonPoint, ExcircleEnclosingTriangle, broke off PointLabels options,
                        Fixed TangentLines, PedalTriangle, AntipedalTriangle,
                        FarOutPoint
  v2.98 (Dec 29, 2002): Overhauled PointLabels
  v2.99 (Jan 30, 2003): ApolloniusPoint, UnitVector combined, many cleanups and fixes,
                        ExtouchTriangle, IncentralTriangle, ToSidelengths, rewrote
                        CollinearQ, IsogonalMidpoint, Midpoint[trilinears]
  v3.00 (Feb  4, 2003): SoddyLine
  v3.01 (Feb 13, 2003): Changed syntax to PerpendicularLine.  Added ParryCircle,
                        ParryPoint, Exmedians
  v3.02 (Feb 16, 2003): Anticevians, added ZeroQ to CollinearQ, Intersctions, added message
                        to LongestLine, ExmedianPoint, OrthocentroidalCircle,
                        made ToSidelengths work on arbitrary input, removed 
                        KiepertHyperbola, reversed 1st and 2nd Brocard points to conform
                        to Kimberling's convention
  v3.03 (Feb 17, 2003): Moved Kimberling centers to an external file and wrote
                        parser to extract them
  v3.04 (Feb 22, 2003): BicentricQ, OrthicAxisPoints, CyclicTrilinears, SimilarQ, added shortcuts
                        without [{a,b,c}]
  v3.10 (Feb 24, 2003): Now represent derived triangles as trilinears and handle their
                        areas using DownValues.  Completely rewrote Area, SideLengths, etc.
                        syntaxes
  v3.11 (Mar  2, 2003): Fixed option passing and parsing in PointLabels,
                        EqualAngleDivisionTicks
  v3.12 (Mar  5, 2003): Lots of new triangles, CircumcevianTriangle, etc.
  v3.13 (Mar  9, 2003): Cleanup, esp. of Soddy-related
  v3.14 (Mar 19, 2003): Distance now returns *signed* distances.  This fixes
                        CartesianToTrilinear for points in the exterior of a
                        triangle.
  v3.15 (Mar 20, 2003): Fixed up MidpointPolygon for quadrilaterals,
                        added BevanPoint
  v3.16 (Mar 27, 2003): WeillPoint
  v3.17 (Mar 28, 2003): BarycentricToCartesian, HomogeneousBarycentrics, removed
                        Oldknow points (which are the same as the Eppstein points),
                        FiveCircles and FregiersTheorem* moved out, reimplemented
                        Inner and Outer Griffiths and Rigby points
  v3.18 (Apr  3, 2003): KenmotuPoint
  v3.19 (Apr 18, 2003): KosnitaPoint, IsogonalConjugate[ctr], IncidentCenters,
                        KimberlingCenters, TrilinearCircle, Circles, Cubics,
                        switched Trilinears[triangle] to TrilinearVertexMatrix,
                        Lines
  v3.20 (Apr 23, 2003): added Cubics
  v3.21 (May  3, 2003): CosineCircle
  v3.22 (Jul  2, 2003): Removed AltitudeTriangle, rewrote Altitudes.  Added
                        ReferenceTriangle
  v3.23 (Jul 23, 2003): Rewrote Invert, removed DoubleBubble
  v3.24 (Aug 11, 2003): SidesToTriangle renamed Triangle
  v3.25 (Sep  4, 2003): Area[Quadrilateral[]]
  v3.26 (Oct  4, 2003): Implemented Angles for Polygons and Quadrilateral
  v3.27 (Oct 19, 2003): updated contexts
  v3.28 (Nov 15, 2003): defined Area for Polygon
  v3.29 (Nov 29, 2003): PerpendicularQ
  v3.30 (Dec  3, 2003): EulerGergonneSoddyTriangle
  v3.31 (Dec  7, 2003): Make RegularPolygon now actually give a Polygon object,
                        Rhombus
  v3.32 (Feb 22, 2004): Modified CornerCircle and CornerCircles
  v3.33 (Feb 29, 2004): MorleysAdjunctTriangle, KSection
  v3.34 (Mar  5, 2004): Add VertexArc option to EqualAngleTicks
  v3.35 (Mar 10, 2004): Fixed Altitudes
  v3.36 (Mar 16, 2004): Inequalities, Rewrote and renamed InteriorQ
  v3.37 (Mar 19, 2004): Treat heads of Triangle|Quadrilateral|Polygon more cleanly.
                        Do inequalities for arbitrary polygons
  v3.38 (Apr  2, 2004): Disable custom FullSimplify ComplexityFunction
  v3.39 (Apr 18, 2004): ExteriorAngleBisectors, ExteriorAngleBisectorTriangles,
                        VertexPoints now supports Triangle, Quadrilateral, and Polygon
  v3.40 (Jun 14, 2004): VertexArc now correctly sorts numerically
  v3.41 (Aug 12, 2004): Area[RegularPolygon[n,R]]
  v3.42 (Oct  5, 2004): Fixed PerspectiveQ, added Perspector
  v3.43 (Oct 16, 2004): Added IsotomicConjugate of points and trilinears,
                        ConicCenter
  v3.44 (Oct 18, 2004): DiagonalPoints
  v3.45 (Oct 19, 2004): Perspectrix, PolarCircle
  v3.46 (Oct 25, 2004): Added LineEquation[{ctr1,ctr2}], fixed BisymmetricQ for centers
  v3.47 (Nov 11, 2004): CyclocevianConjugate, CevaConjugate
  v3.48 (Nov 12, 2004): ExtouchTriangleCircumcircle
  v3.49 (Nov 14, 2004): TrilinearPole, VanLamoenCircle, AnticomplementPoint,
                        ComplementPoint, Reflection
  v3.50 (Nov 17, 2004): Orthopole, TrilinearPolar
  v3.51 (Nov 20, 2004): HalfAngleFormulas, LawOfHalfCosines, Symmetrize,
                        BevanCircle, Conics, Inconic, Circumconic,
                        FermatAxis, fixed CircumtangentialTriangle
  v3.52 (Nov 22, 2004): added many additional central circles
  v3.53 (Nov 23, 2004): OrthogonalQ
  v3.54 (Nov 27, 2004): CrossDifference, DouCircle, ExternalSimilitudeCenter, 
                        InternalSimilitudeCenter, NKTransform, PKTransform
  v3.55 (Nov 28, 2004): More rules for LawOfCosines, renamed it to ToAngles
  v3.56 (Nov 29, 2004): Renamed DistanceTrilinears to ToSidelengths and AngleTrilinears to ToAngles,
                        RandomTriangle, PowerCircles, CircleTriplet,
                        Implemented Line[line], line[t], Circle[circle], circle[t],
                        DeLongchampsCircle, 
  v3.57 (Dec  2, 2004): TriquetraTheorem pulled out, added TangentQ, added Name, corrected 
                        FirstLemoineCircle, RadicalLine[trilinears], reimplemented FuhrmannTriangle,
                        added CircumcircleMidArcTriangle
  v3.58 (Dec  6, 2004): Name, ExcirclesRadicalCircle, NeubergCircles[1|2] are now done in
                        trilinears.  Renamed Circles to TriangelCircles, added CircleTriplets,
                        changed syntax to Circles[triplet]
  v3.59 (Dec  9, 2004): trilinear lines are now represented as Line[{l,m,n}].  Renamed
                        TrilinearComplement and Anticomplement and extended them to include lines 
                        AlephConjugate, BethConjugate
  v3.60 (Dec 12, 2004): TrilinearLine[{l,m,n}] now used to distinguish from Line[tri1,tri2].
                        Added SteinerTriangle etc.  Combined *Equations to TrilinearEquation and
                        *Center to Center.  Added StammlerCircles
  v3.61 (Dec 15, 2004): Corrected MandartCircle and removed ExtouchTriangleCircumcircle.
                        Modified Polygram to use ClosedLine.  Fixed Intersections to work for
                        exact 0s.
  v3.62 (Dec 18, 2004): CyclocevianTriangle.  Removed MedialCircle since it's the NinePointCircle.
                        SymmedialCircle, MacBeathCircumconic, CircumOrthicTriangle, 
                        CircumMedialTriangle, AnticomplementaryCircle, IncentralCircle, 
                        HalfAltitudeCircle
  v3.63 (Dec 20, 2004): MixtilinearIncircles, Triangle, etc.  Removed lots of old code and comments
  v3.64 (Dec 24, 2004): McCayTriangle, etc., ApolloniusCircle.  Changed syntax from Inradius[] to
                        Inradius etc.  Now use ToSidelengths[] to express in terms of side lengths.
                        Added typesetting rules for r, R, omega, and Delta.  Moved more code out.
  v3.65 (Jan  1, 2005): YiuTriangle, YiuCircle, added to PerpendicularLine and Reflection
  v3.66 (Jan  4, 2005): LucasCircles etc.  CDPoint, DCPoint, PivotPoint.
                        Split out pivotal isogonal and isotomic cubics, corrected
                        LucasCubic.
  v3.67 (Jan 12, 2005): Better LucasCircles centers and SpiekerCircle radius from Peter Moses.
                        Added EvansConic, LucasInnerTriangle, StammlerHyperbola.
  v3.68 (Jan 15, 2005): Nicer forms of DouCircle and ExtangentsCircle from Peter Moses.
                        Nicer form of LucasCentralTriangle from me :).  Added YffHyperbola,
                        LucasCentralCircle, radii for Inner and OuterNapoleonTriangles
  v3.69 (Jan 17, 2005): Fixed CircleFunction[DouCircle] and LucasInnerCircle
                        added CyclicProduct, YffContactCircle, YffPoint[1|2], YffTriangle[1|2],
                        YffCircles[1|2], JohnsonYffCircle[1|2], Name,
                        YffCirclesTriangle[1|2], nice(r) tangential mid-arc circle radius from 
                        Peter Moses, InnerVectenTriangle, OuterVectenTriangle.  Added trilinear
                        forms of the in- and exsimilicenters from P. Moses
  v3.70 (Jan 21, 2005): StammlerCircle.  Fixed Midpoint to take "raw" trilinears.
                        MacBeathCircle, EulerGergonneSoddyCircle, BCICircle, MorleysAdjunctCircle,
                        InscribedSquaresTriangle[1|2], EhrmannCongruentSquaresPoint,
                        Crosspoint, Crosssum
  v3.71 (Jan 24, 2005): ReflectedCircle, ReflectedTriangle, better radius for StammlerCircles
                        (from P. Moses), StammlerCirclesRadicalCircle
  v3.72 (Jan 26, 2005): CirclePowers, CircleFunction (from P. Moses)
  v3.73 (Jan 28, 2005): added nice radius and circle function for StammlerCirclesRadicalCircle (from P.
                        Moses and J.-P. Ehrmann)
  v3.74 (Jan 29, 2005): ExcentralHexylEllipse, TrilinearCurve, and Graphics[conic[t]]!!!
                        Merged PerpendicularQ[lines] with OrthogonalQ[circles].  Fixed 
                        CircleFunction[StammlerCircle].  Extended Symmetrize, Medians, Centroid, Perspector.
                        Added PolarTriangle.  Changed *Name to Name.  Added BickartPoint[1|2].
  v3.75 (Feb  7, 2005): OH, NapoleonFeuerbachCubic, VanAubelLine, CyclicSum
  v3.76 (Feb 20, 2005): redid ConcyclicQ
  v3.77 (Mar 15, 2005): NobbsPoints now returns the trilinears
  v3.78 (Mar 20, 2005): MorleysTriange[1|2|3]
  v3.79 (Jul 19, 2005): TrilinearProduct, TrilinearQuotient
  v3.80 (Aug  1, 2005): Minor typo fixes and extensions
  v3.81 (Aug 16, 2005): ParallelQ
  v3.82 (Sep 14, 2005): Reimplemented ParallelLine, added ThomsenEllipse[k]
  v3.83 (Oct  8, 2005): Removed Foot
  v3.84 (Oct 13, 2005): Rewrote CircleRadius the obvious way, PerpendicularQ
  v3.85 (Oct 14, 2005): GEOSCircle
  v3.86 (Oct 20, 2005): OrthopticCircleOfTheSteinerInellipse
  v3.87 (Oct 25, 2005): Fixed TrilinearPolar, TrilinearPole, removed Shortest 
                        which now shadows, added sa, sb, sc
  v3.88 (Nov  1, 2005): ThirdBrocardPointCircle
  v3.89 (Nov  3, 2005): Added, fixed, or made explicit X[1-6][trilinear-triangle],
                        Symmetrize now cancels minus signs if doing so reduces the leaf count
  v3.90 (Nov  7, 2005): TrilinearCenter (from Peter Moses), KimberlingLookup (finally)
  v3.91 (Nov  8, 2005): EquilateralQ, IsoscelesQ
  v3.92 (Nov  9, 2005): Parallelians
  v3.93 (Nov 11, 2005): Fixed KimberlingLookup for points at infinity.
                        Added BrocardTriangle[3]
  v3.94 (Nov 13, 2005): Fixed Symmetrize.  Added AnticomplementaryConjugate, Cevapoint, ConcurrentQ,
                        JohnsonCircles, MorleyAdjunctTriangle[2|3]
  v3.95 (Nov 16, 2005): Greatly sped up RadicalCircle and made CircleFunction return trilinears.
                        JohnsonTriangle, KenmotuCircle, KenmotuSquares, LonguetHigginsCircle, 
                        MosesLonguetHigginsCircle, Orthocorrespondent
  v3.96 (Nov 18, 2005): Fixed JohnsonCircle, JohnsonTriangle.  Make TrilinearPlot work with cubics.
                        DroussentCubic, LemoineCubic, MorleyCubic[1|2|3], SimsonCubic, 
                        TuckerBrocardCubic, TuckerCubic
  v3.97 (Nov 25, 2005): Eigencenter, UnaryCofactorTriangle
  v3.98 (Dec  4, 2005): Defined Area for circumconics and inconics
  v3.99 (Dec  5, 2005): AngleBisectors, fixed MixtilinearCircle
  v4.00 (Dec 14, 2005): Rewrote MiquelCircles, MiquelPoint, MiquelTriangle, added SideRatioPoints,
                        removed MiquelPoints
  v4.01 (Feb 13, 2006): JohnsonTriangleCircumcircle
  v4.02 (Feb 15, 2006): Fixed CircleFunction[(Inner|Outer)NapoleonCircle]
  v4.03 (Mar 20, 2006): JohnsonCircumconic
  v4.04 (Apr  4, 2006): AnglePlot
  v4.05 (May  1, 2006): ConcylicQ now takes arrays of 4 pts
  v4.06 (Jun 21, 2006): Changed the sign of RotationMatrix
  v4.10 (Aug  2, 2007): Made (more) compatible with shipping V6

  (c) 1995-2007 Eric W. Weisstein
*)


BeginPackage["MathWorld`PlaneGeometry`",
	{
		"MathWorld`KimberlingCoordinates`",
		"Utilities`FilterOptions`"
	}
]

\[Alpha]::usage =
"The symbol \[Alpha] is used to represent the first trilinear."

\[Beta]::usage =
"The symbol \[Beta] is used to represent the second trilinear."

\[Gamma]::usage =
"The symbol \[Gamma] is used to represent the third trilinear."

a::usage =
"The symbol a is used to represent the first side length of a triangle."

b::usage =
"The symbol b is used to represent the second side length of a triangle."

c::usage =
"The symbol c is used to represent the third side length of a triangle."

A::usage =
"The symbol A is used to represent the angle of a triangle adjacent to sides b and c."

B::usage =
"The symbol B is used to represent the angle of a triangle adjacent to sides a and c."

C::usage =
"The symbol C is used to represent the angle of a triangle adjacent to sides a and b."

AcuteQ::usage =
"AcuteQ[triangle] returns True if the specified triangle is acute."

AdamsCircle::usage =
"AdamsCircle gives the Adams circle."

AdamsTriangle::usage =
"AdamsTriangle gives the triangle obtained by the \
intersections of the extensions of the corner points determining \
Adams' circle."

AlephConjugate::usage =
"AlephConjugate[{p,q,r},{u,v,w}] gives the p-aleph conjugate of u."

Altitudes::usage =
"Altitudes gives the altitudes (the lines perpendicular to the sides)."

Angle::usage =
"Angle[TrilinearLine[{l,m,n}],TrilinearLine[{ll,mm,nn}]] gives the \
angle between the two specified trilinear lines.  \
Angle[{v1,v2},{w1,w2}] gives the angle between the two vectors.  \
Angle[{v1,v2,v3}] gives the angle v1-v2-v3.  \
Angle[Line[{v1,v2}],Line[{w1,w2}]] does the same for the two lines."

AngleBisector::usage =
"AngleBisector[{v1,v2,...vn},length] gives the line segments bisecting the n vertices."

AngleBisectors::usage =
"AngleBisectors[] gives the angle bisectors of a triangle as a set of Lines.  \
AngleBisesctors[triangle] gives the angle bisectors of the specified triangle."

AngleBisectorsLine::usage =
"AngleBisectorLine gives the line on which the 3 exterior \
angle bisectors lie.  AngleBisectorsLine[i,triangle] gives the \
line on which the exterior angle bisector i and other two interior \
angle bisectors lie."

AngleCevians::usage =
"AngleCevians[triangle,{a1,a2,a3}] returns a set of three Lines which are \
the Cevians from the vertices making angles ai \
with the sides."

AnglePlot::usage =
"AnglePlot[angle] gives a graphic illustrating the given angle."

Angles::usage =
"Angles[poly] gives the angles, quadrilateral, or polygon."

AntiorthicAxis::usage =
"AntiorthicAxis gives the antiorthic axis."

Anticenter::usage =
"Anticenter[quadrilateral] gives the anticenter of the specified quadrilateral."

Anticevians::usage =
"Anticevians[triangle,{t1,t2,t2}] returns a set of three Lines which are \
the Anticevians from the vertices through a point with \
trilinear coordinates t1:t2:t3.  Anticevians[triangle,point] gives the \
three anticevians through the specified Cartesian point."

AnticevianTriangle::usage =
"AnticevianTriangle gives the anticevian triangle of the specified \
trilinear point."

Anticomplement::usage =
"Anticomplement[ctr] gives the trilinears of the anticomplement of the specified \
named center.  Anticomplement[{alpha,beta,gamma}] uses the specified trilinears.  \
Anticomplement[TrilinearLine[{l,m,n}]] gives the anticomplement of the specified line."

AnticomplementaryCircle::usage =
"AnticomplementaryCircle gives the circumcircle of the anticomplementary triangle."

AnticomplementaryConjugate::usage =
"AnticomplementaryConjugate[{p,q,r},{u,v,w}] gives the P-anticomplementary conjugate of U.  \
AnticomplementaryConjugate[{u,v,w}] gives the {1,1,1}-anticomplementary conjugate of U."

AnticomplementaryTriangle::usage =
"AnticomplementaryTriangle gives the anticomplementary triangle."

Antiparallel::usage =
"Antiparallel[triangle,r] gives a line antiparallel to side v1-v3 of the \
specified triangle starting a fractional distance r along one of its sides."

Antiparallels::usage =
"Antiparallels[triangle,point] gives a line antiparallel to one side of a \
triangle starting at a point along one of its sides."

AntiparallelCircle::usage =
"AntiarallelCircle[triangle,r] gives circle through the line antiparallel \
to one side of a triangle starting a fractional distance r along one of \
its sides."

AntipedalLines::usage =
"AntipedalLines[triangle,point] gives the antipedal lines of the specified \
triangle for the specified point."

AntipedalTriangle::usage =
"AntipedalTriangle[{alpha,beta,gamma}] gives the antipedal triangle of the specified \
triangle for the specified point."

ApolloniusCircle::usage =
"ApolloniusCircle[t] gives the circle tangent to the excircles of the specified \
triangle."

ApolloniusCircles::usage =
"ApolloniusCircles gives the Apollonius circles passing through the isodynamic points."

ApolloniusInnerCircle::usage =
"ApolloniusInnerCircle[{circle1,circle2,circle3}] gives the inner Apollonius \
circle with respect to the specified three circles by directly solving the \
three coupled quadratic equations."

ApolloniusIntersectionPoints::usage =
"ApolloniusIntersectionPoints[{circle1,circle2,circle3}] gives the points of \
intersection of the line connecting the radical center and polars \
(inverse points) of the circles with the circles."

ApolloniusInversePoints::usage =
"ApolloniusInversePoints[{circle1,circle2,circle3}] gives the poles of \
the homothetic centers of the circles with respect to the lines connecting \
the six homothetic centers."

ApolloniusOuterCircle::usage =
"ApolloniusOuterCircle[{circle1,circle2,circle3}] gives the outer Apollonius \
circle with respect to the specified three circles by directly solving the \
three coupled quadratic equations."

ApolloniusPoint::usage =
"ApolloniusPoint gives the Apollonius point of the specified \
triangle."

ApolloniusTangentCircles::usage =
"ApolloniusTangentCircles[{cirlce1,circle2,circle3}] gives a list of the eight Apollonius \
circles with respect to the specified three circles by directly solving the \
three coupled quadratic equations."

Area::usage =
"Area represents the area of a triangle \[CapitalDelta].  ToSidelengths[Area] represents Area in terms \
of the side lengths of a reference triangle.  Area[triangle] gives the area of the specicied triangle.  \
Area[{{alpha1,beta1,gamma1},..}] gives the symbolic area of the triangle \
with specified trilinear vertex matrix.  Area[triangle,{{alpha1,beta1,gamma1},..}] \
gives the actual area relative to the specified reference triangle.  \
Area[{a,b,c}] gives the area of the triangle with side lengths \
a, b, and c.  Area[Triangle[]] gives the symbolc area of a triangle in terms of \
side lengths a, b, and c.  \
Area[AnticevianTriangle[center]] gives the symbolic area of the Cevian triangle \
determined by the specified center.  Area[CevianTriangle[center]] does the \
same for the Cevian triangle.  Area[named-triangle] gives the sybolic area of the \
named triangle.  Area[quadrilateral] gives the area of a triangle using \
Bretschneider's formula.  Area[polygon] gives the area of the specified \
polygon.  Area[RegularPolygon[n,R]] gives the area of the regular n-gon \
with circumradius R."

ArealCoordinates::usage =
"ArealCoordinates[triangle,point] gives the areal \
coordinates of the point with respect to the specified triangle."

AuxiliaryCircle::usage =
"AuxiliaryCircle[ellipse] gives the auxiliary circle of the specified \
ellipse, given in the form Circle[{x,y},{a,b}]."

Barycentrics::usage =
"Barycenterics[named-center] gives the barycentric coordinates of the given \
named center.  Cf. HomogeneousBarycentrics."

BarycentricToCartesian::usage =
"BarycentricToCartesian[triangle,{t1,t2,t3}] gives the Cartesian coordinates {x,y} \
corresponding to the specified barycentric coordinates relative to the given \
reference triangle." 

BCICircle::usage =
"BCICircle gives the BCI circle."

BCITriangle::usage =
"BCITriangle gives the BCI triangle."

BeginPoint::usage =
"BeginPoint[line] gives the Point corresponding to the first point of the \
specified line."

BethConjugate::usage =
"BethConjugate[{p,q,r},{u,v,w}] gives the p-beth conjugate of u."

BevanCircle::usage =
"BevanCircle gives the Bevan circle."

BevanPoint::usage =
"BevanPoint gives the Bevan point."

BicentricPair::usage =
"BicentricPair[f] gives {f[a,b,c], f[a,c,b]}."

BickartPoint::usage =
"BickartPoint[1|2] give the foci of the Steiner circumellipse."

BisymmetricQ::usage =
"BisymmetricQ[center] returns True if the center is bisymmetric.  BisymmetricQ[alpha] \
returns true if the center function alpha is bisymmetric.  BisymmetricQ[center,Signed->True] \
requires that the center be explicitly bisymmetric (i.e., not change sign upon exchange \
of b and c)."

Bimedians::usage =
"Bimedians[quadrilateral] is a synonym of MidpointDiagonals."

BrianchonPoint::usage =
"BrianchonPoint[named-inconic] gives the Brianchon point of the specified \
named inconic."

BrocardAngle::usage =
"BrocardAngle represents the Brocard angle. ToSidelengths[BrocardAngle] gives the Brocard angle \
in terms of the side lengths.  ToAngles[BrocardAngle] expresses it in terms of triangle angles."

BrocardAngles::usage =
"BrocardAngles[n,triangle] gives the line segments forming the nth (n=1,2) Brocard angle."

BrocardAxis::usage =
"BrocardAxis gives the Brocard axis."

BrocardCircle::usage =
"BrocardCircle gives the Brocard circle."

BrocardCircumtriangle::usage =
"BrocardCircumtriangle[n,triangle] gives the triangle obtained by \
extending the lines from the vertices through the nth Brocard point \
(n=1,2) until they touch the circumcircle."

BrocardInellipse::usage =
"BrocardInellipse gives the equation of the Brocard ellipse."

BrocardLines::usage =
"BrocardLines[n] gives the line segments from the vertices \
through the nth Brocard point (for n=1,2)."

BrocardMidpoint::usage =
"BrocardMidpoint gives the Brocard midpoint."

BrocardPoint::usage =
"BrocardPoint[n] gives the nth Brocard point.  BrocardPoint[1] gives \
the first Brocard point Omega, BrocardPoint[2] gives \
the second Brocard point Omega', and BrocardPoint[3] gives \
the third Brocard point Omega''.  Note that BrocardPoint[1] and [2] are \
*not* triangle centers, since they fail to obey bisymmetry.  However, the \
do still obey cyclicity of trilinears, and so are defined similarly to \
other centers in this package."

BrocardTriangle::usage =
"BrocardTriangle[n] gives the first (n=1), second (n=2), or third (n=3) \
Brocard triangle.  The n=4 case is DTriangle."

Cartesian::usage =
"Cartesian[{alpha,beta,gamma}[triangle]] gives a Point corresponding to the given
trilinear coordinates for the specified triangle."

CartesianToTrilinear::usage =
"CartesianToTrilinear[triangle,pt] gives the (exact) trilinear \
coordinates {alpha,beta,gamma} of the point pt specified in \
Cartesian coordinates with respect to the specified triangle."

CDPoint::usage =
"CDPoint[{alpha,beta,gamma}] gives the CD-point of the specified trilinear point."

Center::usage =
"Center[Circle[{x,y},r]] gives Point[{x,y}].  Center[Circle[{alpha,beta,gamma},r] \
gives {alpha,beta,gamma}.  Center[named-circle] gives the trilinear \
coordinates of center of the named circle.  Center[named-conic] gives the center of \
the specified named central conic.  Center[equation] gives the center of the \
central conic with specified quadratic trilinear equation in \[Alpha], \[Beta], \
and \[Gamma]."

CenterFunction::usage =
"CenterFunction[center] gives the triangle center function for the \
specified named center in terms of the side lengths a, b, and c \
and the angles A, B, and C.  CenterFunction[X[n]] corresponds to \
center n in Kimberlings's enumeration."

CenterLine::usage =
"CenterLine[center] gives the line corresponding to a given center."

Centers::usage =
"Centers gives a list of defined triangle center functions.  See also Triangles."

CentralCircles::usage =
"CentralCircles gives a list of defined circles.  Circle[circle] gives a trilinear representation of \
the circle as Circle[{alpha,beta,gamma},r].  circle[triangle] gives the circle corresponding \
to the specified reference triangle."

Centroid::usage =
"Centroid[triangle] gives the incenter of the specified triangle, which may be given \
using Cartesian coordinates, a trilinear vertex matrix, or a named triangle.  \
Centroid[{v1,v2,...}] gives the centroid of an arbitrary number of points."

CentroidHexagon::usage =
"CentroidHexagon[{v1,...v6}] gives the hexagon obtained by taking the centroid \
of each three consecutive sides."

CevaConjugate::usage =
"CevaConjugate[P,Q] gives the P-Ceva conjugate of the point Q, where P and Q are \
either trilinears or triangle centers."

Cevapoint::usage =
"Cevapoint[{p,q,r}p,{u,v,w}] gives the cevapoint of P and U."

CevianCircle::usage =
"CevianCircle[triangle,pt] gives circumcircle of the Cevian triangle \
of the point pt."

CevianCircleTriangle::usage =
"CevianCircleTriangle[triangle,point] gives the triangle obtained \
by taking the intersections of the Cevian triangle with the sides \
of the triangle."

CevianCircleLines::usage =
"CevianCircleLines[triangle,point] gives the Cevians obtained \
by taking the intersections of the Cevian triangle with the sides \
of the triangle."

CevianCircleTrianglePoint::usage =
"CevianCircleTrianglePoint[triangle,point] gives point of concurrence \
of the Cevians obtained by taking the intersections of the Cevian triangle \
with the sides of the triangle."

Cevians::usage =
"Cevians[triangle,{t1,t2,t2}] returns a set of three Lines which are \
the Cevians from the vertices through a point with \
trilinear coordinates t1:t2:t3.  Cevians[triangle,point] gives the \
three Cevians through the specified Cartesian point."

CeviansSideRatios::usage =
"CeviansSideRatios[triangle,r] gives the Cevians \
which are a fraction r and 1-r along the sides opposite the vertices."

CevianTriangle::usage =
"CevianTriangle[{alpha,beta,gamma}] uses the point with specified \
trilinears."

Chord::usage =
"Chord[Circle[{x,y},r],{a1,a2}] gives the chord of the specified circle \
with endpoints at specified angles."

CircleCenterFunction::usage =
"CircleCenterFunction[circle] gives the center function corresponding to the center of 
the specified circle."

CircleFunction::usage =
"CircleFunction[named-circle] gives the component l of the vector {l,m,n} \
obtainable by cyclic permutation such that (l\[Alpha]+m\[Beta]+n\[Gamma])(a\[Alpha]+b\[Beta]+c\[Gamma])\
+(a\[Alpha]\[Gamma]+b\[Gamma]\[Alpha]+c\[Alpha]\[Beta])=0.  \
CircleFunction[Circle[{p, q, r},radius] gives the circle function of the specified \
circle.  CircleFunction[eqn] gives the CircleFunction components {l,m,n} (taking k=1) \
of the circle with specified trilinear equation."

CirclePowers::usage =
"CirclePowers[circle] gives the powers of the gives circle with respect to the \
A-, B-, and C-vertex, respectively."

CircleRadius::usage =
"CircleRadius[named-circle] gives the radius of the specified named circle.  \
CircleRadius[Circle[{x,y},r]] returns r.  CircleRadius[triangle] gives the \
circumradius of triangle, whose vertices may be specified in either Cartesian \
or trilinear coordinates."

Circles::usage =
"Circles[named-circle-triplet] gives the trilinear circles with the given name.  \
named-circle-triplet[triangle] gives the Circle objects in the Cartesian plane for the \
specified triangle.  named-circle-triplet[triangle,permutation] uses the radii in the \
order permutation in cases such as the Stammler circles where the root ordering \
cannot be determined."

CircleTriplet::usage =
"CircleTriplet[{alpha,beta,gamma},r][triangle] gives a triplet of circles centered \
at cyclic permutations of the given trilinears and radius for the specified \
reference triangle."

CircleTriplets::usage =
"CircleTriplets gives a list of circle triplets."

Circumcenter::usage =
"Circumcenter gives the circumcenter of the specified triangle.  \
Circumcenter[triangle] gives the circumcenter of the specified triangle, which may be given \
using Cartesian coordinates, a trilinear vertex matrix, or a named triangle.  \
Circumcenter[quadrilateral] gives the circumcenter of the specified cyclic quadrilateral."

CircumcevianTriangle::usage =
"CircumcevianTriangle[{alpha,beta,gamma}] gives the circumcevian \
triangle with respect to the given trilinear point."

Circumcircle::usage =
"Circumcircle[triangle] gives the circumcircle of the triangle, whose vertices may be \
specified either in Cartesian or trilinear coordinates.  Circumcircle[named-circle] \
gives the circumcircle of the named triangle in the form Circle[{alpha0,beta0,gamma0},r]."

CircumcircleMidArcTriangle::usage =
"CircumcircleMidArcTriangle gives the triangle with vertices and the \
mid-arc points along the circumcircle.  (Note: Johnson's definition of the mid-arc \
points, not Kimberling's.)"

CircumcirclePoint::usage =
"CircumcirclePoint[triangle,ang] gives the point located at an \
angle ang around the circumcircle."

Circumconic::usage =
"TrilinearEquation[Circumconic[{x,y,z}]] gives the trilinear equation of the circumconic \
with specified parameters."

CircumMedialTriangle::usage =
"CircumMedialTriangle gives the circum-medial triangle."

CircumnormalTriangle::usage =
"CircumnormalTriangle gives the circumnormal triangle."

CircumOrthicTriangle::usage =
"CircumOrthicTriangle gives the circum-orthic triangle."

Circumradius::usage =
"Circumradius gives the circumradius R.  ToSidelengths[Circumradius] expresses it terms of \
side lengths."

CircumtangentialTriangle::usage =
"CircumtangentialTriangle gives the circumtangential triangle."

ClawsonPoint::usage =
"ClawsonPoint gives the Clawson (also known as the crucial) point."

Cleavers::usage =
"Cleavers gives the three cleavers."

ClosedLine::usage =
"ClosedLine[{v1,v2,v3,...}] gives a closed line (unfilled polygon) \
with vertices v1,v2,...,v1."

CoaxalCircle::usage =
"CoaxalCircle[r1,d1,d] gives a coaxal circle."

CoaxalCircles::usage =
"CoaxalCircles[r1,d1,{d,a,b}] gives a series coaxal circles."

CollinearQ::usage =
"CollinearQ[{point1,...}] returns True if the three or \
more specified points are collinear.  CollinearQ[{center1,...} \
returns True if the three or more specified triange centers are collinear in general \
position.  Centers may be specified either symbolically (e.g., Incenter) or \
using symbolic trilinear coordinates (e.g., Midpoint[{Centroid,Orthocenter}], \
{1/a,a/b,/c}, etc.).  Needs tobe expanded to include ZeroQ, \
Simplify[Together[TrigExpand[#]],a>0&&b>0&&c>0]==0&, etc . as possible tests."

CompleteQuadrilateral::usage =
"CompleteQuadrilateral[quadrilateral] gives the quadrilateral \
together with its diagonals."

ConcurrentQ::usage =
"ConcurrentQ[{TrilinearLine[{l1,m1,n1}],TrilinearLine[{l2,m2,n2}],TrilinearLine[{l3,m3,n3}]}] returns \
True if the specified lines are concurrent."

ConcyclicQ::usage =
"ConcyclicQ[quadrilateral] returns True if quadrilateral is cyclic.  ConcyclicQ[{p1,p2,p3,p4}] uses the four \
specified points."

CongruentIsoscelizersPoint::usage =
"CongruentIsoscelizersPoint gives the congruent isoscelizers point."

Conic::usage =
"Conic[{p1,p2,p3,p4,p5},{x,y}] gives the equation x^2+bxy+cy^2+dx+ey+f of the \
conic section in the variables x and y determined by the specified five points.  \
Similarly, Conic[{tri1,...tri5}] gives the trilinear equation."

Conics::usage =
"Conics gives a list of named triangle conics."

ContactTriangle::usage =
"ContactTriangle gives the contact triangle."

ConvexPolygon::usage =
"ConvexPolygon[{v1,...,vn}] returns a convex polygon having the same \
vertices as those specified."

ConwayCircle::usage =
"ConwayCircle gives the Conway circle."

Coordinates::usage =
"Coordinates[point] gives the coordinates of the specified point.  \
Coordinates[line] gives the coordinates of the points on the specified line.  \
Coordinates[circle] gives the coordinates of the center of the specified circle."

CornerCircle::usage =
"CornerCircle[{{x0,y0},r},triangle,i] returns the circle which is \
tangent to the sides intersecting at vertex i \
and the incircle of the specified circle.  CornerCircle[r,triangle] \
gives the circle of radius r tangent to the sides intersecting in vertex v2."

CornerCircles::usage =
"CornerCircles[{{x0,y0},r},triangle] gives all corner circles."

CornerExcircles::usage =
"CornerExcircles[{{x0,y0},r},triangle] gives the excircles \
which are equidistant from the sides with vertex v2 and incircle, \
together with the corner incircle."

CosineCircle::usage =
"CosineCircle gives the cosine circle."

CosineHexagon::usage =
"CosineHexagon returns the cosine hexagon."

Crossdifference::usage =
"Crossdifference[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}] gives the crossdifference \
of the the specified points.  Crossdifference[ctr1,ctr2] does the same for the specified \
named centers."

Crosspoint::usage =
"Crosspoint[{p,q,r},{u,v,w}] gives the crosspoint of points P and U."

Crosssum::usage =
"Crosssum[{p,q,r},{u,v,w}] gives the crosssum of points P and U."

CyclicProduct::usage =
"CyclicProduct[expr] gives the product obtained by cyclicly permutating the variables \
of expr in {a,b,c}, {A,B,C}, and {\[Alpha],\[Beta],\[Gamma]}."

CyclicQuadrilateral::usage =
"CyclicQuadrilateral[{angle1,angle2,angle3,angle4},r] gives the \
Quadrilateral object having vertices at angles ainglei around a \
circle with radius r."

CyclicQuadrilateralArcMidpoints::usage =
"CyclicQuadrilateralArcMidpoints[{a1,a2,a3,a4}] gives the mid-arc points \
for the cyclic quadrilateral specified by the gives angles."

CyclicQuadrilateralArcMidpointDiagonals::usage =
"CyclicQuadrilateralArcMidpointDiagonals[{a1,a2,a3,a4}] gives the \
diagonals connecting opposite mid-arc points."

CyclicQuadrilateralFn::usage =
"CyclicQuadrilateralFn[{a1,a2,a3,a4},fn] gives a list of four elements \
composed of fn applied to each triplet of vertices formed by consecutive ai."

CyclicQuadrilateralWithPerpendicularDiagonals::usage =
"CyclicQuadrilateralWithPerpendicularDiagonals[{angle1,angle2,angle3},r] \
returns the cyclic quadrilateral with vertices given by the first three \
angles on a circle of radius r and the fourth contructed on the circle \
such that the quadrilateral has perpendicular diagonal."

CyclicSum::usage =
"CyclicSum[expr] gives the sum obtained by cyclicly permutating the variables \
of expr in {a,b,c}, {A,B,C}, and {\[Alpha],\[Beta],\[Gamma]}."

CyclicTrilinears::usage =
"CyclicTrilinears[f(a,b,c,A,B,C)] gives {f(a,b,c),f(b,c,a),f(c,a,b)}."

CyclocevianConjugate::usage=
"CyclocevianConjugate[named-center] gives the cyclotomic conjugate of the named center.  \
CyclocevianConjugate[{alpha,beta,gamma}] gives the cyclotomic conjugate of the trilinear \
coordinates."

CyclocevianTriangle::usage=
"CyclocevianTriangle[named-center] gives the Cevian triangle of the cyclotomic conjugate \
of the named center.  CyclocevianTriangle[{alpha,beta,gamma}] gives the Cevian triangle of \
cyclotomic conjugate of the trilinear coordinates."

DarbouxCubic::usage =
"DarbouxCubic gives the equation for the Darboux cubic."

DCPoint::usage =
"DCPoint[{alpha,beta,gamma}] gives the DC-point of the specified trilinear point."

DeLongchampsCircle::usage =
"DeLongchampsCircle gives the de Longchamps circle."

DeLongchampsEllipse::usage =
"DeLongchampsEllipse gives the de Longchamps ellipse."

DeLongchampsLine::usage =
"DeLongchampsLine gives the de Longchamps line."

DeLongchampsPoint::usage =
"DeLongchampsPoint gives the de Longchamps point."

DiagonalPoints::usage =
"DiagonalPoints[quadrilateral] gives the diagonal points of the \
specified quadrilateral."

Diagonals::usage =
"Diagonals[quadrilateral] gives the diagonals of the specified \
quadrilateral, represented as a list of lines."

DiagonalMidpoints::usage =
"DiagonalMidpoints[quadrilateral] gives the line connecting the \
midpoints of the diagonals of the specified quadrilateral."

DiagonalTriangle::usage =
"DiagonalTriangle gives the diagonal triangle."

Distance::usage =
"Distance[point1,point2] or Distance[v1,v2] gives the distance between the \
two specified points or vectors.  \
Distance[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}] gives the \
distance between the points with specified trilinears.  \
Distance[triangle,{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}] gives the distance \
for the specified triangle.  Distance[point,{a,b,c}] gives the *signed* \
distance between the line a x+b y+c=0 and the specified point.  \
Distance[point,line] gives the *signed* distance between the specified line \
and point."

Divisions::usage =
"Divisions->n is an option for Invert."

DouCircle::usage =
"DouCircle gives the Dou circle."

DroussentCubic::usage =
"DroussentCubic gives the Droussent cubic."

DrozFarnyCircle::usage =
"DrozFarnyCircle[1|2][t] gives the first or second Droz-Farny circle of the \
specified triangle."

DrozFarnyCircumcircle::usage =
"DrozFarnyCircumcircle gives the Droz-Farny circle with \
center at the circumcircle."

DrozFarnyCircumpoints::usage =
"DrozFarnyCircumpoints gives the points on the Droz-Farny circle \
with center at the circumcenter."

DrozFarnyLines::usage =
"DrozFarnyLines[triangle,r] gives the equal lines of the (generalized) \
Droz-Farny circle with center at the orthocenter."

DrozFarnyOrthocircle::usage =
"DrozFarnyOrthocircle gives the Droz-Farny circle with \
center at the orthocenter."

DrozFarnyOrthopoints::usage =
"DrozFarnyOrthopoints gives the points on the Droz-Farny circle \
with center at the orthocenter."

DrozFarnyPoints::usage =
"DrozFarnyPoints[triangle,r] gives the points on the (generalized) \
Droz-Farny circle with center at the orthocenter and radius from the vertices of r."

DrozFarnyVertexCircle::usage =
"DrozFarnyVertexCircle[triangle,r] gives the (generalized) Droz-Farny \
circle with center at the orthocenter and radius \
from the vertices of r."

DTriangle::usage =
"DTriangle gives the D-triangle."

EhrmannCongruentSquaresPoint::usage =
"EhrmannCongruentSquaresPoint gives the Ehrmann congruent squares point."

Eigencenter::usage =
"Eigencenter[triangle] gives the eigencenter of the specified triangle."

EndPoint::usage =
"EndPoint[line] gives the Point corresponding to the last point of the \
specified line."

EppsteinPoint::usage =
"EppsteinPoint[(1|2)][t] gives the nth Eppstein point of the specified triangle."

EqualAngleDivisionTicks::usage =
"EqualAngleDivisionTicks[{v1,v2,v3},k,n,r,dr,da] \
gives ticks with n strokes along either side of the angle k-sector of
the arc of radius r centered around vertex v2.  The ticks \
are of length 2dr and have angular separation da.  \
EqualAngleDivisionTicks[triangle,k,r,dr,da] gives ticks with \
n=1,2, and 3 strokes for each vertex.  \
Use this function in conjunction with VertexArc and VertexArcs or specify \
VertexArc->True as the last argument for nice results."

EqualAngleTicks::usage =
"EqualAngleTicks[{v1,v2,v3},n,r,dr,da] gives ticks with n strokes along \
the center of the arc of radius r centered around vertex v2.  The ticks \
are of length 2dr and have angular separation da.  \
EqualAngleTicks[triangle,n,r,dr,da] gives ticks with n strokes for each \
vertex.  Use this function in conjunction with \
VertexArc and VertexArcs or specify VertexArc->True as the last argument \
for nice results."

Exmedians::usage =
"Exmedians gives the exmedians."

EqualDetourPoint::usage =
"EqualDetourPoint gives the equal detour point."

EqualSideTicks::usage =
"EqualSideTicks[{v1,v2},n,<len>,<offset>] gives Graphics objects corresponding \
to n perpendicular ticks centered on the midpoint of {v1,v2}.  \
EqualSideTicks[triangle,n,<len>,<offset>] gives side ticks for each side of the \
specified triangle using n ticks."

EqualSideTicksAboutMidpoint::usage =
"EqualSideTicksAboutMidpoint[line,n,<len>,<offset>] gives n ticks about the \
midpoint of the specified line."

EqualSideTicksAboutMidpoints::usage =
"EqualSideTicksAboutMidpoints[triangle,<len>,<offset>] gives side ticks for each \
side about the midpoints of the sides, using 1, 2, and 3 \
ticks for the first, second, and third sides, respectively.  \
EqualSideTicksAboutMidpoints[quadrilateral,<len>,<offset>] does the analogous \
operation for a quadrilateral."

EquilateralQ::usage =
"EquilateralQ[triangle] returns True if the specified triangle is equilateral."

EquilateralTriangle::usage =
"EquilateralTriangle gives the ???."

EquilateralTriangularize::usage =
"EquilateralTriangularize equilateral triangularizes."

ErectPolygon::usage =
"ErectPolygon[{v1,v2},n,side] returns a regular n-gon on the right (side = 1) or \
left (side = -1) side of the specified line segment."

ErectPolygons::usage =
"ErectPolygon[{v1,...,vk},n,side] returns the vertices of k regular n-gons erected \
on the right (side = 1) or left (side = -1) sides of each of the sides of the specified \
set of vertices.  ErectPolygon[triangle,n,side] and ErectPolygon[quadrilateral,n,side] \
do the same thing on a triangle or quadrilateral."

ErectScaleneTriangles::usage =
"ErectScaleneTriangles[polygon,{a1,a2}] return the n Triangle objects constructed on \
the sides of the polygon {v1,...,vn} with \base angles {a1,a2}."

ErectedPolygonCenters::usage =
"ErectPolygonCenters[{v1,...,vk},n,<s>] gives a list of the centers \
of n-gons erected on the 1=right or 2=left sides of each of the sides of \
the specified closed line."

EulerGergonneSoddyCircle::usage =
"EulerGergonneSoddyCircle gives the Euler-Gergonne-Soddy circle."

EulerGergonneSoddyTriangle::usage =
"EulerGergonneSoddyTriangle gives the Euler-Gergonne-Soddy triangle."

EulerLine::usage =
"EulerLine gives a segment of the Euler line."

EulerPoints::usage =
"EulerPoints gives the midpoints of the orthocenter-vertex line segments."

EulerTriangle::usage =
"EulerTriangle gives the Euler triangle."

EvansConic::usage =
"EvansConic gives the Evans conic."

EvansPoint::usage =
"EvansPoint gives the Evans point."

ExactDistance::usage =
"ExactDistance[tri1,tri2] is the same as Distance[tri1,tri2], but uses a \
simplified formula that is valid when tri1 and tri2 are known to be in \
exact trilinears."

ExactTrilinears::usage =
"ExactTrilinears[center] gives the exact trilinear coordinates for the specified \
triangle center.  \
ExactTrilinears[{alpha,beta,gamma}] returns the exact trilinear coordinates for \
the inexact trilinears {alpha,beta,gamma}.  ExactTrilinears[triangle,{alpha,beta,gamma}] \
gives the exact trilinears for the specified triangle."

Excenters::usage =
"Excenters gives the three excenters."

ExcentralHexylEllipse::usage =
"ExcentralHexylEllipse gives the ellipse that passes through the vertices of the excentral and \
hexyl triangles."

ExcentralTriangle::usage =
"ExcentralTriangle gives the excentral triangle."

Excircles::usage =
"Excircles gives the three excircles."

ExcirclesRadicalCircle::usage =
"ExcirclesRadicalCircle gives the radical circle of the excircles."

ExeterPoint::usage =
"ExeterPoint gives the Exeter point."

ExmedianPoints::usage =
"ExmedianPoints[t] gives the intersections of the exmedians of the specified \
triangle."

Exmedians::usage =
"Exmedians[t] gives the exmedians."

Exradii::usage =
"Exradii gives a list of the exradii of the three excircles."

ExtangentsCircle::usage =
"ExtangentsCircle gives the circumcircle of the extangents triangle."

ExtangentsTriangle::usage =
"ExtangentsTriangle gives the extangents triangle."

ExteriorAngleBisectors::usage =
"ExteriorAngleBisectors[triangle,d] gives the exterior angle bisectors \
of the specified triangle as line segments extending a distance d from \
each vertex in each direction."

ExteriorAngleBisectorTriangles::usage =
"ExteriorAngleBisectorTriangles gives the three triangles \
determined by the extension of the sides and the exterior angle bisectors."

ExternalSimilitudeCenter::usage =
"ExternalSimilitudeCenter[named-circle1,named-circle2] gives the external similitude center \
of the two named circles.  ExternalSimilitudeCenter[circle1,circle2] gives the external similitude center \
of the two explicit circles."

ExtouchTriangle::usage =
"ExtouchTriangle gives the extouch triangle."

FarOutPoint::usage =
"FarOutPoint gives the far out point."

Feet::usage =
"Feet[{line1,line2,...}] gives the points that are the feet (first points) \
of the specified lines."

FermatAxis::usage =
"FermatAxis gives the Fermat axis."

FermatPoint::usage =
"FermatPoint[(1|2),triangle] gives the first or second Fermat point of the \
specified triangle.  The first and second Fermat points are called isogonic \
centers."

FermatPointConstruction::usage =
"FermatPointConstruction gives the construction for the Fermat point."

FeuerbachHyperbola::usage =
"FeuerbachHyperbola gives the Feuerbach hyperbola."

FeuerbachPoint::usage =
"FeuerbachPoint gives the Feuerbach point."

FeuerbachTriangle::usage =
"FeuerbachTriangle gives the Feuerbach trianglee."

FirstLemoineCircle::usage =
"FirstLemoineCircle gives the first Lemoine circle."

FletcherPoint::usage =
"FletcherPoint gives the Fletcher point."

FuhrmannCenter::usage =
"FuhrmannCenter gives the Fuhrmann center."

FuhrmannCircle::usage =
"FuhrmannCircle gives the Fuhrmann circle."

FuhrmannPoints::usage =
"FuhrmannPoints gives the Fuhrmann points."

FuhrmannTriangle::usage =
"FuhrmannTriangle gives the Fuhrmann triangle."

GallatlyCircle::usage =
"GallatlyCircle gives the Gallatly circle of the specified triangle."

GEOSCircle::usage =
"GEOSCircle gives the circle passing through Kimberling centers 20, 468, 650, and 1323."

GergonneLine::usage =
"GergonneLine gives the Gergonne line."

GergonnePoint::usage =
"GergonnePoint gives the Gergonne point."

GK::usage =
"GK is the distance between the centroid and symmedian point."

GriffithsPoint::usage =
"GriffithsPoint[triangle,v] gives the Griffiths point for the specified triangle \
with vector v from the circumcenter."

HalfAltitudeCircle::usage =
"HalfAltitudeCircle gives circumcircle of the half-altitude triangle."

HalfAltitudeTriangle::usage =
"HalfAltitudeTriangle gives the half-altitude triangle."

HalfAngleFormulas::usage =
"HalfAngleFormulas[expr] applies the half-angle formulas to expr."

HalfMosesCircle::usage =
"HalfMosesCircle gives the half-Moses circle."

HarmonicConjugatePoints::usage =
"HarmonicConjugatePoints[r] gives a diagram of a harmonic segement \
with distance between the middle points r, where 0<r<1."

HarmonicConjugates::usage =
"HarmonicConjugates gives the harmonic conjugates."

HexylCircle::usage =
"HexylCircle gives the hexyl circle."

HexylTriangle::usage =
"HexylTriangle gives the hexyl triangle."

HexylHexagon::usage =
"HexylHexagon gives the hexyl hexagon."

HK::usage =
"HK is the distance between the orthocenter and symmedian point."

HomogeneousBarycentrics::usage =
"HomogeneousBarycentrics[center] gives the symbolic homogeneous barycentric coordinates \
the the specified center.  HomogeneousBarycentrics[triangle,center] gives the \
homogeneous barycentric coordinates of the specified center with repsect to the \
given triangle.  Cf. Barycentrics."

HomotheticCenter::usage =
"HomotheticCenter[{circle1,circle2},sign,theta] gives the homothetic \
center of the two circles, calculated using an angle theta.  \
sign=-1 gives the internal homothetic center, sign=1 gives the external \
homothetic center."

HomotheticCenterPlot::usage =
"HomotheticCenterPlot[{circle1,circle2}},sign,theta] returns a \
Graphics object showing the homothetic center of the two circles, \
calculated using an angle theta sign=-1 gives the internal homothetic center, \
sign=1 gives the external homothetic center."

HomotheticLines::usage =
"HomotheticLines[{circle1,circle2,circle3}] gives the four homothetic lines of the \
three circles."

HomotheticLinesPlot::usage =
"HomotheticLinesPlot[{circle1,circle2,circle3}] plots the three circles and the \
four lines connecting the homothetic centers 3 by 3."

HomotheticPoints::usage =
"HomotheticPoints[{circle1,circle2,circle3}] gives the six homothetic points of \
the three circles."

IG::usage =
"IG is the distance between the incenter and the centroid."

IK::usage =
"IK is the distance between the incenter and the symmedian point."

IL::usage =
"IL is the distance between the incenter and the de Longchamps point."

Incenter::usage =
"Incenter[triangle] gives the incenter of the specified triangle, which may be given \
using Cartesian coordinates, a trilinear vertex matrix, or a named triangle."

IncentralCircle::usage =
"IncentralCircle gives the circumcircle of the incentral triangle."

IncentralTriangle::usage =
"IncentralTriangle gives the incentral triangle."

IncidentCenters::usage =
"IncidentCenters[centerlist,eqn,opts] gives those triangle centers from the specified \
list such that eqn==0 for a set of random triangles.  Each member of centerlist should \
be a center for which CenterFunction[center] is defined.  The number of random triangles \
to try can be specified as MaxIterations->n."

Incircle::usage =
"Incircle gives the incircle."

Inconic::usage =
"TrilinearEquation[Inconic[{x,y,z}]] gives the trilinear equation of the inconic \
with specified parameters."

Inequalities::usage =
"Inequalities[(triangle|quadrilateral|polygon),{x,y}] gives the inequalities for \
the interior in the variables x and y."

InnerGriffithsPoint::usage =
"InnerGriffithsInner gives the inner Griffiths point."

InnerNapoleonCircle::usage =
"InnerNapoleonCircle gives the outer Napoleon circle."

InnerNapoleonTriangle::usage =
"InnerNapoleonTriangle gives the inner Napoleon triangle."

InnerRigbyPoint::usage =
"InnerRigbyPoint gives the inner Rigby point."

InnerSoddyCircle::usage =
"InnerSoddyCircle gives the inner Soddy circle."

InnerSoddyCenter::usage =
"InnerSoddyCenter gives the inner Soddy center."

InnerSoddyTriangle::usage =
"InnerSoddyTriangle gives the triangle of contact points of the inner Soddy \
triangle with the three surrounding circles."

InnerVectenCircle::usage =
"InnerVectenCircle gives the inner Vecten circle."

InnerVectenTriangle::usage =
"InnerVectenTriangle gives the inner Vecten triangle."

Inradius::usage =
"Inradius represents the inradius r.  ToSidelengths[Inradius] expresses it terms of \
side lengths."

InscribedSquaresTriangle::usage =
"InscribedSquaresTriangle gives the triangle of centers of inscribed squares."

IntangentsCircle::usage =
"IntangentsCircle gives the circumcircle of the intangents triangle."

IntangentsTriangle::usage =
"IntangentsTriangle gives the intangents triangle."

InteriorQ::usage =
"InteriorQ[triangle,{x,y}] returns True if {x,y} in is the interior."

InternalSimilitudeCenter::usage =
"InternalSimilitudeCenter[named-circle1,named-circle2] gives the internal similitude center \
of the two named circles.  InternalSimilitudeCenter[circle1,circle2] gives the internal similitude center \
of the two explicit circles."

Intersections::usage =
"Intersections[circle1,circle2] gives the points of intersection \
of two circles.  If the result is imaginary, two imaginary points are returned.  \
If the intersection is in a single point, the point is returned twice.  \
Intersections[circle,line] gives the points of intersection of the specified line \
with the specified circle.  Intersections[line1,line2] gives \
the point of interection of the two specified lines.  If they do not intersect, \
PointAtInfinity is returned.  Intersections[Line[tri1,tri2],Line[tri3,tri4]] gives the \
intersection of the two lines determined by specified pairs of trilinear coordinates."

InversePoint::usage =
"InversePoint[{alpha,beta,gamma},Circle[{alpha0,beta0,gamma0},radius]] gives the inverse of the \
specified point in the specified circle.  InversePoint[{alpha,beta,gamma},named-circle] uses \
the given named circle."

Invert::usage =
"Invert[obj,circle] gives the inversion of the given geometric objects, which \
may be a Line, Circle, Point, Polygon, or list containing any of these.  Invert \
takes the option Divisions->n."

Isoconjugate::usage =
"Isoconjugate[{p,q,r},{u,v,w}] gives the P-isoconjugate of the point U."

IsodynamicPoint::usage =
"IsodynamicPoint[(1|2)] gives the nth isodynamic point."

IsodynamicPoints::usage =
"IsodynamicPoints gives the two isodynamic points."

IsogonalConjugate::usage =
"IsogonalConjugate[ctr] gives the trilinears of the isogonal conjugate \
of the specified named center.  \
IsogonalConjugate[{alpha,beta,gamma}] gives the trilinears of the isogonal point.  \
IsogonalConjugate[triangle,{alpha,beta,gamma}] gives the isogonal \
conjugate point of the point with trilinear coordinates \
alpha:beta:gamma.  \
IsogonalConjugate[triangle,{x,y}] gives the isogonal \
conjugate point of the point with Cartesian coordinates {x,y}."

IsogonalMittenpunkt::usage =
"IsogonalMittenpunkt gives the isogonal conjugate of the mittenpunkt."

IsoperimetricPoint::usage =
"IsoperimetricPoint gives the isoperimetric point."

IsoscelesQ::usage =
"IsoscelesQ[triangle] returns True if the specified triangle is equilateral."

Isoscelizers::usage =
"Isoscelizers[triangle,{l1,l2,l3}] gives the three isoscelizers at \
distances {l1,l2,l3} from the corresponding vertices.  \
Isoscelizers[triangle,{p1,p2}] gives the isoscelizers through the point \
{p1,p2}."

IsotomicConjugate::usage=
"IsotomicConjugate[triangle,{alpha,beta,gamma}] gives the isotomic \
conjugate point of the specified trilinear point for the specified triangle.  \
IsotomicConjugate[named-center] gives the isotomic conjugate of the named center.  \
IsotomicConjugate[{alpha,beta,gamma}] gives the isotomic conjugate of the trilinear \
coordinates."

IsotomicLines::usage=
"IsotomicLines gives the isotomic lines."

IsotomicPoints::usage=
"IsotomicPoints gives the isotomic points."

JerabekHyperbola::usage =
"JerabekHyperbola gives the Jerabek hyperbola."

JohnsonCircles::usage =
"JohnsonCircles gives the Johnson circle triplet."

JohnsonCircumconic::usage =
"JohnsonCircumconic gives the mutual circumconic of the reference triangle and Johnson triangle."

JohnsonTriangle::usage =
"JohnsonTriangle gives the triangle of centers of the Johnson circles."

JohnsonTriangleCircumcircle::usage =
"JohnsonTriangleCircumcircle gives the circumcircle of the Johnson triangle."

JohnsonYffCircle::usage =
"JohnsonYffCircle[1|2] gives the nth Johnson-Yff circle for n = 1 or 2."

KenmotuCircle::usage =
"KenmotuCircle gives the Kenmotu circle."

KenmotuPoint::usage =
"KenmotuPoint gives the Kenmotu point."

KenmotuSquares::usage =
"KenmotuSquares gives the square used in the construction of the Kenmotu point."

KiepertHyperbola::usage =
"KiepertHyperbola gives the equation of the Kiepert hyperbola."

KiepertParabola::usage =
"KiepertParabola gives the equation of the Kiepert parabola."

KiepertParabolaFocus::usage =
"KiepertParabolaFocus gives the focus of the Kiepert parabola."

KimberlingCenters::usage =
"KimberlingCenters gives the centers X[n] such that CenterFunction[X[n]] is defined.  \
<<KimberlingCenters` must be loaded before issuing this command."

KimberlingLookup::usage =
"KimberlingLookup[{alpha,beta,gamma}] gives the number of the Kimberling center a point \
corresponds to, or else {}.  <<MathWorld`KimberlingCoordinates` must be loaded first 
for this to work."

KosnitaPoint::usage =
"KosnitaPoint gives the Kosnita point."

KSection::usage =
"Ksection[{{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}},n] gives the trilinear \
coordinates of the point (1/n)th of the way from the first point gives to the \
second."

LabelOffset::usage =
"LabelOffset->{x,y} is an option for PointLabels giving the offset of the \
text from the point."

LemoineAxis::usage =
"LemoineAxis gives the Lemoine axis."

LemoineCubic::usage =
"LemoineCubic gives the Lemoine cubic."

LemoineInellipse::usage =
"LemoineInellipse gives the Lemoine ellipse."

LemoineTriangle::usage =
"LemoineTriangle gives the triangle formed from the contact points of the Lemoine \
inellipse with the sides of the reference triangle."

LesterCircle::usage =
"LesterCircle gives the Lester circle."

LimitingPoints::usage =
"LimitingPoints[d,r,R] gives the limiting points of the circles \
Circle[{0,0},R] and Circle[{d,0},r]."

LineAtInfinity::usage =
"LineAtInfinity represents a line at infinity."

Lines::usage =
"Lines gives a list of defined central lines.  \
Line[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}] represents the line passing through \
the given trilinear points.  To obtain the trilinear represenation of a line of the latter \
form, use TrilinearLine[Line[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}]]."

LineFunction::usage =
"LineFunction[named-line] gives the function l of the specified named central line \
TrilienarLine[{l,m,n}] such that the line's equation is \
l \[Alpha]+m \[Beta]+n \[Gamma]==0 and m and n are cyclic permutations of l."

LongestLine::usage =
"LongestLine[{v1,...,vn},<ds>] returns a Line containing the n specified collinear \
points, and extended in length by ds."

LonguetHigginsCircle::usage =
"LonguetHigginsCircle gives the Longuet-Higgins circle."

LucasCentralCircle::usage =
"LucasCentralCircle gives the circumcircle passing through the centers of the \
LucasCircles."

LucasCentralTriangle::usage =
"LucasCentralTriangle gives the triangle formed by the centers of the Lucas circles."

LucasCircle::usage =
"LucasCircle gives the circumcircle of the LucasCentralTriangle."

LucasCircles::usage =
"Lucas circles gives the Lucas circles."

LucasCirclesRadicalCircle::usage =
"LucasCirclesRadicalCircle gives the radical circle of the Lucas circles."

LucasCubic::usage =
"LucasCubic gives the Lucas cubic."

LucasInnerCircle::usage =
"LucasInnerCircle gives the circle internally tangent to the Lucas circles."

LucasInnerTriangle::usage =
"LucasInnerTriangle gives the Lucas inner triangle."

LucasTangentsTriangle::usage =
"LucasTangentsTriangle gives the triangle formed by the intersections of the Lucas circles."

MacBeathCircle::usage =
"MacBeathCircle gives the MacBeath circle."

MacBeathCircumconic::usage =
"MacBeathCircumconic gives the MacBeath circumconic."

MacBeathInconic::usage =
"MacBeathInconic gives the MacBeath inconic."

MacBeathTriangle::usage =
"MacBeathTriangle gives the triangle formed by the points of contact of the MacBeath \
inconic with the reference triangle."

Maltitudes::usage =
"MaltitudePoints[quadrilateral] gives the maltitudes."

MandartCircle::usage =
"MandartCircle gives the Mandart circle."

MandartInellipse::usage =
"MandartInellipse gives the equation of the Mandart inellipse."

MCayCubic::usage =
"MCayCubic gives the equation for the MCay cubic."

McCayCircles::usage =
"McCayCircles gives the McCay circles."

McCayCirclesRadicalCircle::usage =
"McCayCirclesRadicalCircle gives the radical circle of the McCay circles."

MedialTriangle::usage =
"MedialTriangle returns the medial triangle."

Medians::usage =
"Medians gives the medians (the lines from vertices to the midpoints \
of the opposite side)."

MidArcAntiPoints::usage =
"MidArcAntiPoints[verts] gives the points which arge reflections of the \
mid-arc points in the triangle sides."

MidArcLines::usage =
"MidArcLines[vert] gives the line segments connecting the mid-arc points \
and their reflections."

MidArcPoint::usage =
"MidArcPoint[n] returns the nth (n=1,2) mid-arc point."

(*
MidArcPoints::usage =
"MidArcPoints[triangle] gives the points which lie in the middle of the \
arcs of the circumcircle determined by the triangle's vertices."

MidArcSidePoints::usage =
"MidArcSidePoints[triangle] gives the points of intersection of the line \
segments connecting the circumcenter and the mid-arc points with the 
triangle specified by verts."
*)

MidArcTriangle::usage =
"MidArcTriangle gives the mid-arc triangle."

Midpoint::usage =
"Midpoint[{v1,v2}] gives the midpoint of the two vectors, returned in the form \
{x,y}.  Midpoint[{point1,point2}] returns the midpoint of the lines joining the \
specified two points as a Point.  Midpoint[line] gives the midpoint of the \
specified line segment returned as Point[{x,y}]. Midpoint[{{alpha1,beta1,gamma1},\
{alpha2,beta2,gamma2}}] gives the midpoints of the two points in trilinear \
coordinates.  Midpoint[{ctr1,ctr2}] gives the midpoint of the two centers \
in trilinears."

MidpointDiagonals::usage =
"MidpointPolygon[quadrilateral] gives the line segments \
connecting the midpoints of adjacent sides of the specified quadrilateral."

MidpointPolygon::usage =
"MidpointPolygon[{v1,v2,...,vn}] gives the polygon obtained by \
connecting the midpoints of adjacent sides of the specified polygon."

Midpoints::usage =
"Midpoints[{v1,v2,...,vn}] gives the Point graph objects that are the midpoints \
of adjacent sides of the given list of vertices.  Midpoints[triangle] gives the \
Point graph objects that are the midpoints of adjacent sides of the given \
triangle."

MiquelCircles::usage =
"MiquelCircles[{ka,kb,kc}] gives the three Miquel circles of \
the specified triangle with specified fractional distances along the sides."

MiquelPoint::usage =
"MiquelPoint[{ka,kb,kc}] gives the point of concurrence \
of the three Miquel circles with specified fractional distances along the sides."

MiquelTriangle::usage =
"MiquelTriangle[{ka,kb,kc}] gives the Miquel triangle with specified fractional \
distances along the sides."

Mittenpunkt::usage =
"Mittenpunkt gives the Mittenpunkts."

MixtilinearCircle::usage =
"MixtilinearCircle gives the circumcircle of the triangle formed by the centers of \
the mixtilinear circles."

MixtilinearIncirclesRadicalCircle::usage =
"MixtilinearIncirclesRadicalCircle gives the radical center of the mixtilinear circles."

MixtilinearIncircles::usage =
"MixtilinearIncircles gives the mixtilinear circles."

MixtilinearTriangle::usage =
"MixtilinearTriangle gives the triangle formed by the centers of the mixtilinear circles."

MorleysAdjunctCircle::usage =
"MorleysAdjunctCircle gives the adjunct Morley circle."

MorleyAdjunctTriangle::usage =
"MorleyAdjunctTriangle[1|2|3] gives the nth Morley adjunct triangle."

MorleysCircle::usage =
"MorleysCircle gives Morley's circle."

MorleyCubic::usage =
"MorleyCubic[1|2|3] gives the nth Morley cubic."

MorleyTriangle::usage =
"MorleyTriangle[1|2|3] gives the nth Morley triangle."

MosesCircle::usage =
"MosesCircle gives the Moses circle."

MosesLonguetHigginsCircle::usage =
"MosesLonguetHigginsCircle gives the Moses generalization of the LonguetHigginsCircle."

NagelLine::usage =
"NagelLine gives the Nagel line."

NagelPoint::usage =
"NagelPoint gives the Nagel point."

Name::usage =
"Name[center|circle|conic|cubic|line|triangle] gives a string corresponding to the name of the \
specified geometric object."

NapoleonFeuerbachCubic::usage =
"NapoleonFeuerbachCubic gives the Napoleon-Feuerbach conic."

NapoleonPoint::usage =
"NapoleonPoint[(1|2)] gives the nth Napoleon point."

NeubergCircle::usage =
"NeubergCircle[n] gives the Neuberg circle for n = 1 or 2.  \
NeubergCircle[Line[{v1,v2}],\[Omega]] gives the Neuberg circle for Brocard \
angle \[Omega] on the base {v1,v2}."

NeubergCircles::usage =
"NeubergCircles[1|2] gives the three Neuberg circles."

NeubergCirclesRadicalCircle::usage =
"NeubergCirclesRadicalCircle[1] gives the radical circle of the first Neuberg circles."

NeubergCubic::usage =
"NeubergCubic gives the equation of the Neuberg cubic."

NeubergTriangle::usage =
"NeubergTriangle[n] gives the triangle whose vertices are the centers \
of the three Neuberg circles on the three sides for n = 1 or 2."

NinePointCenter::usage =
"NinePointCenter gives the nine-point center."

NinePointCircle::usage =
"NinePointCircle gives the nine-point circle."

NinePointCircles::usage =
"NinePointCircles[{v1,...,vn}] gives the nine-point circles of the \
points taken three at a time."

NKTransform::usage =
"NKTransform[{alpha,beta,gamma}] gives the NK-transform of the specified trilinears.  \
NKTransform[center] goes the same for the given named center."

NobbsPoints::usage =
"NobbsPoints gives the three Nobbs points."

ObtuseOnly::usage =
"ObtuseOnly->(True|False) is an option to IncidentCenters which specifies that only obtuse triangles \
are permitted."

ObtuseQ::usage =
"ObtuseQ[triangle] returns True if the specified triangle is obtuse."

OH::usage =
"OH is the distance between the circumcenter and orthocenter."

OI::usage =
"OI is the distance between the circumcenter and incenter."

OK::usage =
"OK is the distance between the circumcenter and symmedian point."

Orientation::usage =
"Orientation[triangle] gives the orientation; -1 for clockwise, 1 for counterclockwise."

OrthicAxis::usage =
"OrthicAxis gives the orthic axis."

OrthicInconic::usage =
"OrthicInconic gives the equation of the orthic inconic."

OrthicTriangle::usage =
"OrthicTriangle gives the orthic triangle."

Orthocenter::usage =
"Orthocenter[triangle] gives the orthocenter of the specified triangle, which may be given \
using Cartesian coordinates, a trilinear vertex matrix, or a named triangle."

OrthocentroidalCircle::usage =
"OrthocentroidalCircle returns the orthocentroidal circlee."

Orthocorrespondent::usage =
"Orthocorrespondent[{p,q,r}] gives the orthocorrespondent."

Orthocubic::usage =
"Orthocubic gives the equation of the orthocubic."

OrthogonalQ::usage =
"OrthogonalQ[named-circle1,named-circle2] returns True if the two named circles \
are orthogonal.  OrthogonalQ[circle1,circle2] does the same for two explicit circles.
OrthogonalQ[line1,line2] returns true if the two lines are perpendicular."

Orthojoin::usage =
"Orthojoin[center] gives the orthojoin of the specied center.  Orthojoin[{alpha,beta,gamma}] \
gives the orthojoin of the specified trilinears."

OrthopolarLine::usage
"OrthopolarLine[quadrilateral,line] gives the orthopolar line of the \
specified line with respect to the specified quadrilateral."

Orthopole::usage =
"Orthopole[triangle,line] gives the orthopole of the specified \
triangle and line  Orthopole[{l,m,n}] gives the trilinears of the orthopole \
of the specified trilinear line.  Orthopole[named-line] gives the trilinears \
of the orthopoloe of the specied line."

OrthopoleLines::usage =
"OrthopoleLines[triangle,line] gives the lines used in the construction \
of the orthopole and line."

OrthopolePoints::usage =
"OrthopolePoints[triangle,line] gives the points used in the construction \
of the orthopole and line."

OrthopticCircleOfTheSteinerInellipse::usage =
"OrthopticCircleOfTheSteinerInellipse gives this circle."

OuterGriffithsPoint::usage =
"OuterGriffithsPoint gives the outer Griffiths point."

OuterNapoleonCircle::usage =
"OuterNapoleonCircle gives the outer Napoleon circle."

OuterNapoleonTriangle::usage =
"OuterNapoleonTriangle gives the outer Napoleon triangle."

OuterRigbyPoint::usage =
"OuterRigbyPoint gives the outer Rigby point."

OuterSoddyCircle::usage =
"OuterSoddyCircle gives the outer Soddy circle."

OuterSoddyCenter::usage =
"OuterSoddyCenter gives the outer Soddy center."

OuterSoddyTriangle::usage =
"OuterSoddyTriangle gives the triangle of contact points of the outer Soddy \
triangle with the three surrounding circles."

OuterVectenCircle::usage =
"OuterVectenCircle gives the outer Vecten circle."

OuterVectenTriangle::usage =
"OuterVectenTriangle gives the outer Vecten triangle."

Parallel::usage =
"Parallel[triangle,r] gives a line parallel to one side of a triangle \
starting a fractional distance r along one of its sides."

Parallelians::usage =
"Parallelians[{alpha,beta,gamma}] gives the three parallelians through \
a given trilinear point."

ParallelLine::usage =
"ParallelLine[{\[Alpha],\[Beta],\[Gamma]}, TrilinearLine[{l,m,n}] \
gives a trilinear line through the specied point and parallel to the given line.  \
Named triangle centers and central lines can also be given."

Parallelogram::usage =
"Parallelogram[v1,v2] gives a parallelogram with lower left-hand vertex \
at (0,0) and edges given by the sepcified two vector."

ParallelQ::usage =
"ParallelQ[TrilinearLine[{l,m,n}],TrilinearLine[{ll,mm,nn}]] returns True \
if the specified lines are parallel."

Parallels::usage =
"Parallels[triangle,r] returns the three lines obtained by dividing \
the sides the specified triangle in the ratio r:1 and then drawing the \
lines parallel to the adjacent side.  Parallels[triangle,point] returns  \
the three lines parallel to the sides and through the specified point.  \
Parallels[triangle,{alpha,beta,gamma}] does the same for the point specified \
using trilinears."

ParryCenter::usage =
"ParryCenter gives the center of the Parry circle."

ParryCircle::usage =
"ParryCircle gives the Parry circle."

ParryPoint::usage =
"ParryPoint gives the Parry point."

PedalCircle::usage =
"PedalCircle[triangle,point] gives the pedal circle with \
respect to the specified point."

PedalLines::usage =
"PedalLines[ctr] gives the pedal lines corresponding to the given center in trilinear form.  \
PedalLines[{alpha,beta,gamma}] does the same for the specified trilinear point.  \
PedalLines[triangle,point] gives the pedal lines with respect to the specified point."

PedalTriangle::usage =
"PedalTriangle[{alpha,beta,gamma}] gives the pedal triangle of the specified \
trilinear point."

PerimeterPoint::usage =
"PerimeterPoint gives the point a fractional distance \
0<=r<=1 around the triangle's perimeter starting at v1."

PerpendicularBisector::usage =
"PerpendicularBisector[line] gives the perpendicular \
bisector of unit length of the specified line."

PerpendicularBisectors::usage =
"PerpendicularBisectors gives the perpendicular bisectors."

PerpendicularLine::usage =
"PerpendicularLine[point,line] gives the line segment perpendicular to the \
specified line through the specified point.  An optional third argument \
d or {d1,d2} can be used to specify the length to extend the perpendicular \
on either side of the line.  PerpendicularLine[TrilinearLine[{l,m,n}],\
{\[Alpha],\[Beta],\[Gamma]}] gives the perpendicular TrilinearLine."

PerpendicularQ::usage =
"PerpendicularQ[line1,line2] returns true if the two specified trilinear lines \
are perpendicular."

Perpendiculars::usage =
"Perpendiculars[triangle,{l1,l2,l3}] gives the six perpendicular line segments \
through the vertices to the adjacent lines."

PerpendicularUnitVector::usage =
"PerpendicularUnitVector[{v1,v2}] gives a unit vector {ux,uy} that is perpendicular \
to {v1,v2}."

PerpSquare::usage =
"PerpSquare[{line1,line2},size,quad] gives a square of size \
indicating that the lines line1 and line2 are perpendicular.  The square is \
placed in quadrant i (i=1,4)."

PerspectiveAxisPoints::usage =
"PerspectiveAxisPoints[t1,t2] gives the points along the perspective axis \
at which the corresponding edges in perspective figures t1 and t2 intersect."

PerspectiveQ::usage =
"PerspectiveQ[polygon1,polygon2] returns True if the lines connecting \
corresponding vertices of the specified polygons, where polygons may also \
be triangles or quadrilaterals.  PerspectiveQ[m1,m2] returns True if the triangles \
with specified trilinear vertex matrices are in perspective.  \
PerspectiveQ[named-triangle1,named-triangle2] does the same for named triangles.  \
PerspectiveQ[triangle1,triangle2] returns True even if the lines connecting corresponding \
vertices are parallel so that the perspectrix lies at infinity."

Perspector::usage =
"Perspector[t1,t2,..] gives the perspector of the specified polygons, triangles, etc. \
Perspector[m1,m2] returns the perspector the triangles with specified trilinear vertex matrices \
(which are assumed to be in perspective).  Perspector[named-triangle1,named-triangle2] does the \
same for named triangles.  If a nice explicit form is known for two named triangles, \
Perspector returns that."

Perspectrix::usage =
"Perspectrix[triangle1,triangle2] returns the perspectrix of the two triangles \
that are in perspective."

PivotPoint::usage =
"PivotPoint[named-cubic] gives the pivot point of the specified names cubic."

PKTransform::usage =
"PKTransform[{alpha,beta,gamma}] gives the PK-transform of the specified trilinears.  \
PKTransform[center] goes the same for the given named center."

PointAtInfinity::usage =
"PointAtInfinity is the point of intersection of parallel lines."

PointPoints::usage =
"PointPoints[triangle,{f1,l1,f2,l2,...}] gives the points."

PointingAway::usage =
"PointingAway[{perp,c1},c2] changes the direction of perp if necessary so that \
it points away from c1 and towards c2."

PointLabels::usage =
"PointLabels[{{point1,label1,<opts1>},{point2,label2,<opts2>...},<globalopts>] \
plots the specified points using the specified graphics directives and draws \
corresponding labels next to them.  Directives and options for individual points \
may be specified using an optional optsi argument, which may be either a single \
element or a list.  A set of global options to use for points having no opsi \
can be specified as an optional second argument.  If neither are specified, the \
defaults from Options[PointLabels] are used.  Useful parameters to set include \
Color, PointSize[], LabelOffset->{}, Background->{}, TextStyle->{}, etc."

PolarCircle::usage =
"PolarCircle gives the polar circle."

PolarTriangle::usage =
"PolarTriangle[named-conic] gives the polar triangle of the specified conic."

Polygram::usage =
"Polygram[n,m] gives the polygram on n vertices regularly spaced about the \
unit circle, advancing by m steps each side.  Polygram[n,m,R,angle] gives the \
polygram on a circle of radius R with angle offset from the x-axis."

PowerCircles::usage =
"PowerCircles[t] gives the power circles."

Quadrilateral::usage =
"Quadrilateral[{v1,v2,v3,v4}] represents a 4-sided polygon."

RadicalCenter::usage =
"RadicalCenter[{circle1,circle2,circle3}] gives the point of concurrence of \
the three radical lines of the three circles.  \
RadicalCenter[{{l1,m1,n1},{l2,m2,n2},{l3,m3,n3}},{k1,k2,k2}] gives the \
radical center of the circles with specified parameters.  \
RadicalCenter[{{l1,m1,n1},{l2,m2,n2},{l3,m3,n3}}] assumes {k1,k2,k3}={1,1,1}."

RadicalCircle::usage =
"RadicalCircle[{circ1,circ2,circ3}] gives the radical circle of the \
three specified circles."

RadicalLine::usage =
"RadicalLine[circle1,circle2] gives the radical line of the two circles.  \
RadicalLine[named-circle1,named-circle2] gives the trilinear equation of the radical line."

RadicalLines::usage =
"RadicalLines[c] gives the radical lines of two or more circles."

RadicalVector::usage =
"RadicalVector[{circle1,circle2}] gives a list of vectors {u,v} giving \
the radical line of the two circles as u+tv for t a parameter."

RandomTriangle::usage =
"RandomTriangle[prec] gives a random triangle generated with precision prec, \
taken by default to be MachinePrecision.  Type->(Automatic|\"Acute\"|\"Obtuse\") \
may also be specified."

RandomTriangleRules::usage =
"RandomTriangleRules[prec] gives replacement rules for sidelengths and angles of a random \
triangle generated with precision prec, taken by default to be MachinePrecision.  \
Type->(Automatic|\"Acute\"|\"Obtuse\") may also be specified."

ReferenceTriangle::usage =
"ReferenceTriangle gives the triangle with unit trilinear coordinates."

ReflectedCevians::usage =
"ReflectedCevians[triangle,pt] gives Cevians of the Cevian triangle obtained \
by reflecting the vertices of the usual Cevian triangle with repsect to the \
point pt about the midpoints of the sides."

ReflectedCevianTriangle::usage =
"ReflectedCevianTriangle[triangle,point] gives the Cevian triangle obtained \
by reflecting the vertices of the usual Cevian triangle with repsect to the \
point pt about the midpoints of the sides."

ReflectedCevianTrianglePoint::usage =
"ReflectedCevianTrianglePoint[triangle,point] gives Cevian point of \
the Cevian triangle obtained by reflecting the vertices of the usual \
Cevian triangle with repsect to the point pt about the midpoints of the \
sides."

ReflectionCircle::usage =
"ReflectionCircle gives the circumcircle of the reflection triangle."

ReflectionTriangle::usage =
"ReflectionTriangle gives the triangle obtained by reflecting the vertices of \
a triangle about the opposite sides."

Reflection::usage =
"Reflection[point,line] gives the reflection of the point in the specified line.  \
Reflection[center1,center2] gives the reflection of center1 in center 2.  \
Reflection[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}] gives the reflection of the \
specified point P1 in the point P2.  Reflection[triangle,point] gives the reflection \
of the specified triangle in the specified line."

RegularPolygon::usage =
"RegularPolygon[n] gives a regular n-gon of unit circumradius.  \
RegularPolygon[n,R] gives a regular n-gon with circumradius R.  \
RegularPolygon[n,R,angle] gives a regular n-gon of circumradius R and initial \
vertex offset from the x-axis by the specified angle."

RegularPolygonArea::usage =
"RegularPolygonArea[n] gives the area of the regular n-gon with unit edge lengths."

RegularPolygonInformation::usage =
"RegularPolygonInformation[n] gives a list of geometric properties of the \
regular n-gon."

RigbyPoint::usage =
"RigbyPoint[triangle,{a1,a2}] gives the Rigby point of the triangle \
with respect to the chord on the circumcircle with endpoints at angles \
a1 and a2."

RightTriangleQ::usage =
"RightTriangleQ[triangle] returns True if the specified triangle is a right triangle."

S::usage =
"S is Conway notation for 2Area."

s::usage =
"s is the same as Semiperimeter."

SA::usage =
"SA is Conway notation for (-a^2+b^2+c^2)/2."

sa::usage =
"sa = (b+c-a)/2."

sb::usage =
"sb = (c+a-b)/2."

sc::usage =
"sc = (a+b-c)/2."

SB::usage =
"SB is Conway notation for (a^2-b^2+c^2)/2."

SC::usage =
"SC is Conway notation for (a^2+b^2-c^2)/2."

SchifflerPoint::usage =
"SchifflerPoint gives the Schiffler point."

SchifflerPointConstruction::usage =
"SchifflerPointConstruction[triangle] gives the construction of the Schiffler \
point."

SecondBrocardCircle::usage =
"SecondBrocardCircle gives the second Brocard circle."

SecondSteinerCircle::usage =
"SecondSteinerCircle gives the circumcircle of the Steiner triangle."

Semiperimeter::usage =
"Semiperimeter represents the semiperimeter s.  ToSidelengths[Semiperimeter] represents it \
in terms of side lengths."

ShortestLine::usage =
"ShortestLine[{{v11,v12},...}] gives the line of shortest length in the \
specified list."

SideLengths::usage =
"SideLengths[poly] gives the side lengths, quadrilateral, \
or polygon.  SideLengths[vertexmatrix] gives the side lengths of the \
triangle with specified trilinear vertex matrix.  SideLengths[ctr] gives the symbolic \
side lengths of the Cevian triangle with respect to the given Cevian point."

SideRatioPoints::usage =
"SideRatioPoints[{ka,kb,kc}] gives the three points that are specifed fractional \
distances along the sides BC, CA, and AB, respectively."

Sides::usage =
"Sides[triangle] gives a list of lines forming the sides of \
the specified triangle.  Sides[triangle,dx] gives the side lines \
extended by a length dx on each end.  Sides[quadrilateral] gives a list of lines \
forming the sides of the specified quadrilateral."

SideUnitVectors::usage =
"SideUnitVectors[triangle] gives the unit vectors connecting the sides of the \
specified triangle."

SideVectors::usage =
"SideVectors[triangle] gives the vectors connecting the sides of the \
specified triangle."

Signed::usage =
"Signed -> (True|False) is an option for BisymmetricQ."

SimilarQ::usage =
"SimilarQ[triangle1,triangle2] returns True if the specified triangles are (directly \
or indeirectly) similar."

SimsonCubic::usage =
"SimsonCubic gives the Simson cubic."

SimsonLine::usage =
"SimsonLine[{alpha,beta,gamma}] gives the Simson line with respect to the given \
trilinear point with is *assumed* to lie on the circumcircle."

(*
SimsonLinePoints::usage =
"SimsonLinePoints[triangle,a] gives the points on the Simson \
line that are perpendicular to the sides."

SimsonLinePoleAngle::usage =
"SimsonLinePoleAngle[triangle,{c1,c2}] gives the angle around the \
circumcircle of the pole of the triangle whose Simson line is \
perpendicular to the specifed line (which may be a chord)."
*)

SineTripleAngleCircle::usage =
"SineTripleAngleCircle gives the sine-triple-angle circle."

SoddyCenters::usage =
"SoddyCenters gives the Soddy centers.  The centers are computed using trilinear coordinates."

SoddyCircles::usage =
"SoddyCircles gives a list of two elements consisting of \
the inner and outer Soddy circles determined by the specified triangle.  \
The circles are computed using trilinear coordinates."

SoddyCircleContactPoints::usage =
"SoddyCircleContactPoints gives the contact points of the Soddy circles."

SoddyLine::usage =
"SoddyLine gives a segment of the Soddy line."

SoddyRadii::usage =
"SoddyRadii gives the radii of the Soddy circles computed using trilinear coordinates."

SpiekerCenter::usage =
"SpiekerCenter gives the Spieker center."

SpiekerCircle::usage =
"SpiekerCircle gives the Spieker circle."

Splitters::usage =
"Splitters gives the lines from the vertices which bisect the perimeter."

StammlerCircle::usage =
"StammlerCircle gives the circumcircle of the Stammler triangle."

StammlerCircles::usage =
"Circles[StammlerCircles] gives the Stammler circles.  The radii correspond to the three \
roots of a cubic that cannot be easily associated automatically with the proper circle, \
so the radius is given as a list of all radii and the user should use StammlerCircles[t,permutation] \
to do the association for a given triangle."

StammlerCirclesRadicalCircle::usage =
"StammlerCirclesRadicalCircle gives the radical circle of the Stammler circles."

StammlerHyperbola::usage =
"StammlerHyperbola gives the Stammler hyperbola."

StammlerTriangle::usage =
"StammlerTriangle gives the triangle with vertices given by the centers of the Stammler \
circles."

SteinerCircle::usage =
"SteinerCircle gives the Steiner circle."

SteinerCircles::usage =
"SteinerCircles[n] plots n mutually tangent circles with common incircle and excircle."

SteinerCircumellipse::usage =
"SteinerCircumellipse gives the equation of the Steiner circumellipse."

SteinerInellipse::usage =
"SteinerInellipse gives the equation of the Steiner inellipse."

SteinerPoint::usage =
"SteinerPoint gives the Steiner point."

SteinerTriangle::usage =
"SteinerTriangle gives the triangle whose vertices are the points of \
coontact of the sidelines of the reference triangle with the Cevians through \
the Steiner point."

StevanovicCircle::usage =
"StevanovicCircle] gives the Stevanovic circle."

SW::usage =
"SW gives S_omega = (a^2+b^2+c^2)/2 in Conway triangle notation."

SymmedialCircle::usage =
"SymmedialCircle gives the circumcircle of the symmedial triangle."

SymmedialTriangle::usage =
"SymmedialTriangle] gives the symmedial triangle."

Symmedians::usage =
"Symmedians gives the three symmedians."

SymmedianPoint::usage =
"SymmedianPoint[triangle] gives the symmedian point of the specified triangle, which may be given \
using Cartesian coordinates, a trilinear vertex matrix, or a named triangle."

Symmetrize::usage =
"Symmetrize[expr] returns the smallest expression equivalent to the original \
with symmetric terms removed and pairs reduced to the complemtary terms.  \
Symmetrize[{alpha,beta,gamma}] removes any factor common to all three terms.  Warning: never \
use Symmetrize/@{alpha,beta,gamma}, as different signs may be introduced in different terms \
as a result of canonicalization."

TangentCircles::usage=
"TangentCircles gives the three mutually tangent circles with centers at the vertices \
of the reference triangle."

TangentialCircle::usage =
"TangentialCircle gives the tangential circle."

TangentialMidArcCircle::usage =
"TangentialMidArcCircle gives the tangential mid-arc circle."

TangentialMidArcTriangle::usage =
"TangentialMidArcTriangle gives the tangential mid-arc triangle."

TangentialQuadrilateral::usage =
"TangentialQuadrilateral[{a1,a2,a3,a4}] gives the tangential quadrilateral \
with tangents at specified angles around a unit circle."

TangentialQuadrilateralNormals::usage =
"TangentialQuadrilateralNormals[{a1,a2,a3,a4}] gives the normals \
of the tangential quadrilateral with tangents at specified angles \
around a unit circle."

TangentialTriangle::usage =
"TangentialTriangle gives the trangential triangle."

TangentialTriangleCircumcenter::usage =
"TangentialTriangleCircumcenter gives the circumcenter of the tangential triangle."

TangentQ::usage =
"TangentQ[named-circle1,named-circle2] returns True if the two named circles \
are tangent.  TangentQ[circle1,circle2] does the same for two explicit circles."

TarryPoint::usage =
"TarryPoint gives the Tarry point."

TaylorCenter::usage =
"TaylorCenter gives the center of the Taylor circle."

TaylorCircle::usage =
"TaylorCircle gives the Taylor circle."

TaylorHexagon::usage =
"TaylorHexagon gives the hexagon of the Taylor circle."

ThirdBrocardPointCircle::usage =
"ThirdBrocardPointCircle gives the circle centered at the third Brocard point \
passing through Kimberling center X99."

ThirdLemoineCircle::usage =
"ThirdLemoineCircle gives the circumcircle of the Lemoine triangle."

(*
ThomsenEllipse::usage =
"ThomsenEllipse[k] gives the ellipse in Thomsen's figure for parameter 0 < k < 1."
*)

ThomsonCubic::usage =
"ThomsonCubic gives the equation of the Thomson cubic."

ToAngles::usage =
"ToAngles[expr] applies various transformations to attempt to replace \
expressions in terms of the sidelengths a, b, and c with simpler combinations of \
trig functions of angles A, B, and C."

ToSidelengths::usage =
"ToSidelengths[expr] returns an equivalent trilinear expression in which \
angles A, B, and C are expressed in terms of sides lengths a, b, and c using \
the law of cosines."

Triangle::usage =
"Triangle is the head of a list of three numbers {v1,v2,v3} representing \
a triangle.  Triangle[{tri1,tri2,tri3}] gives a triangle with vertices represented \
using trilinear coordinates.  Triangle[a,b,c] gives a triangle with specified side lengths."

TriangleCubics::usage =
"TriangleCubics gives a list of defined cubics."

TriangleQ::usage =
"TriangleQ[{a,b,c}] returns True if the specified sides represent a triangle.  \
TriangleQ[triangle] returns True if the object represented by the \
given three vertices is a triangle."

TriangleRules::usage =
"TriangleRules is a list of replacement rules for r, R, etc. in terms of side lengths."

Triangles::usage =
"Triangles gives a list of defined triangles.  Operations that can be performed \
on each triangle include Show[Graphics[triangle[Triangle[]]]], Area[triangle], \
SideLengths[triangle], Trilinears[triangle], etc.  See also Centers."

TriangulationTriangles::usage =
"TriangulationTriangles[triangle,pt] gives the three triangle determined \
by the given triangulation point.  \
TriangulationTriangles[triangle,{alpha,beta,gamma}] and \
TriangulationTriangles[triangle,center] do the equivalent for \
the triangulation point specified in trilinear coordinates or as \
a triangle center, respectively."

TrilinearCenter::usage =
"TrilinearCenter[{alpha,beta,gamma},Triangle[{{p1,p2,p3},...,{r1,r2,r3}]] gives the \
trilinears of the center with trilinears {alpha,beta,gamma} with respect to the given \
triangle."

TrilinearComplement::usage =
"TrilinearComplement[ctr] gives the trilinears of the complement of the specified \
named center.  TrilinearComplement[{alpha,beta,gamma}] uses the specified trilinears.  \
TrilinearComplement[line] gives the complement of the specified line."

TrilinearCurve::usage =
"TrilinearCurve[triangle,eqn] gives a Graphics objects corresponding to a plot of the \
given trilinear equation with respect to the given triangle."

TrilinearEquation::usage =
"TrilinearEquation[object] gives a trilinear equation eqn in variables \[Alpha], \[Beta], and \[Gamma] \
such that eqn==0.  TrilinearEquation[tri1,tri2,tri3] gives the trilinear equation eof the circle passing \
through the three specified trilinear points.  TrilinearEquation[ctr1,ctr2,ctr2] does \
the same for the named centers.  TrilinearEquation[named-circle] gives the trilinear equation eqn such \
that eqn==0 described the named circle.  TrilinearEquation[Circle[ctr,r]] gives the circle \
equation for the circle with trilinear center ctr and of radius r.  TrilinearEquation[{{l,m,n},k}] \
gives the circle equation for a circle with parameters {l,m,n} and k.  TrilinearEquation[{l,m,n}] \
takes k=1.  TrilinearEquation[tri1,tri2] gives the trilinear equation of the line \
joining the specified trilinear points.  TrilinearEquation[ctr1,ctr2] gives the trilinear of the \
equation passing through the specified named centers.  TrilinearEquation[named-line] gives \
the trilinear equation of the named line.  TrilinearEquation[named-conic] gives the trilinear equation \
of the specified named conic.  TrilinearEquation[named-cubic] gives the trilinear equation for the specified \
named (self-isogonal) cubic."

TrilinearLine::usage =
"TrilinearLine[{l,m,n}] represents a trilinear line l \[Alpha]+m \[Beta]+n \[Gamma] == 0.  \
TrilinearLine[named-line] gives a trilinear representation of the line as TrilinearLine[{l,m,n}].  \
TrilinearLine[Line[{alpha1,beta1,gamma1},{alpha2,beta2,gamma2}]] gives the trilinear representation.  \
TrilinearLine[Line[ctr1,ctr2]] gives the TrilinearLine[{l,m,n}] for the line passing through the \
specified centers."

TrilinearPolar::usage =
"TrilinearPolar[{alpha,beta,gamma}] gives the trilinear polar of the \
specified points.  TrilinearPolar[center] gives the trilinear polar of \
the specified center."

TrilinearPole::usage =
"TrilinearPole[TrilinearLine[{l,m,n}]] gives the trilinear pole of the specified trilinear line.  \
TrilinearPole[named-line] gives the trilinear pole of the specified named line."

TrilinearProduct::usage =
"TrilinearProduct[{p,q,r},{u,v,w}] gives the trilinear product {p u, q v, r w}."

TrilinearQuotient::usage =
"TrilinearQuotient[{p,q,r},{u,v,w}] gives the trilinear quotient {p/u, q/v, r/w}."

Trilinears::usage =
"Trilinears[center] gives the symbolic trilinear coordinates of the named triangle \
center.  Trilinears[triangle,center] gives the trilinears for the specified \
triangle.  Trilinears[{alpha,beta,gamma}][triangle] or \
Trilinears[triangle,{alpha,beta,gamma}] gives the trilinears \
for the specified triangle."

TrilinearVertexMatrix::usage =
"TrilinearVertexMatrix[named-triangle] gives the sybolic trilinears of the named triangle."

TrilinearToCartesian::usage =
"TrilinearToCartesian[triangle,{alpha,beta,gamma}] gives the \
Cartesian coordinates of the point with trilinear coordinates \
alpha:beta:gamma with respect to the specified triangle."

TuckerBrocardCubic::usage =
"TuckerBrocardCubic gives the Tucker-Brocard cubic."

TuckerCircle::usage =
"TuckerCircle[phi] gives the Tucker circle corresponding to parameter phi."

TuckerCubic::usage =
"TuckerCubic gives the Tucker cubic."

TuckerHexagon::usage =
"TuckerHexagon[triangle,r] gives the Tucker hexagon of the specified \
triangle starting a fractional distance r from the initial vertex to \
the second."

Type::usage =
"Type is an option to RandomTriangle."

UnaryCofactorTriangle::usage =
"UnaryCofactorTriangle[triangle] gives the unary cofactor triangle of the \
specified triangle."

VanAubelLine::usage =
"VanAubelLine gives the van Aubel line."

VanLamoenCircle::usage =
"VanLamoenCircle gives the van Lamoen circle."

VertexArc::usage =
"VertexArc[{v1,v2,v3},r] gives a Graphics object correspinding to an \
arc at the vertex v2 with radius r.  Use this in conjunction with
EqualAngleTicks or EqualAngleDivisionTicks if you want ticks as well."

VertexArcs::usage =
"VertexArcs[triangle,r] gives Graphics objects corresponding to arcs \
of radius r at the vertices.  Use this in \
conjunction with EqualAngleTicks or EqualAngleDivisionTicks if you \
want ticks as well."

VertexPoints::usage =
"VertexPoints[triangle] returns Points representing the vertices of the \
specified triangle."

Vertices::usage =
"Vertices[triangle], Vertices[quadrilateral], Vertices[polygon], etc. \
can be used to give the coordinates of the vertices of a plane geometric object."

X::usage =
"X[n] is the nth triangle center in Kimberlings's enumeration."

WeillPoint::usage =
"WeillPoint gives the Weill point of a triangle."

YffCenter::usage =
"YffCenter gives the Yff center of congruence."

YffCenterLengths::usage =
"YffCenterLengths[tri] gives the lengths {{l1,l2,l3},{t1,t2,t3}} \
of the isoscelizers (measured from each vertex) and the lengths of the four \
interior triangles giving the Yff center of congruence."

YffCentralTriangle::usage =
"YffCentralTriangle gives the Yff central triangle."

YffCentralTriangleLengths::usage =
"YffCentralTriangleLengths gives the lengths {{l1,l2,l3},{t1,t2,t3}} \
of the isoscelizers (measured from each vertex) and the lengths of the four \
interior triangles giving the Yff central triangle."

YffCircles::usage =
"YffCircles[1|2] gives the internal and extranl Yff circle triplets."

YffCirclesTriangle::usage =
"YffCirclesTriangle[1|2] gives the triangle formed by the centers of the nth \
Yff circles for n = 1 or 2."

YffContactCircle::usage =
"YffContactCircle gives the circumcircle of the Yff contact triangle."

YffContactTriangle::usage =
"YffContactTriangle gives the triangle formed by the contact points of the Yff parabola \
with the reference triangle."

YffParabola::usage =
"YffParabola gives the equation of the Yff parabola."

YiuCircle::usage =
"YiuCircle gives the circumcircle of the Yiu triangle."

YiuCircles::usage =
"YiuCircles gives the Yiu circles."

YffHyperbola::usage =
"YffHyperbola gives the Yff hyperbola."

YffPoint::usage =
"YffPoint[1|2] gives the nth Yff point for n = 1 or 2."

YffTriangle::usage =
"YffTriangle[1|2] gives the nth Yff triangle for n = 1 or 2."

YiuTriangle::usage =
"YiuTriangle gives the triangle formed by the centers of the Yiu circles."

(* System Parameters *)

(*
Internal`ComparePatterns["None"|"Default"|"Legacy"]; 
*)

(* Attributes *)

SetAttributes[Area,HoldFirst];
SetAttributes[SideLengths,HoldFirst];

(* Options *)

Options[PointLabels]={
	Background->White,
	TextStyle->{FontFamily->"Times",FontSlant->"Italic"},
	PointSize[.02],
	LabelOffset->{.05,.12}
};

Options[IncidentCenters]={
	MaxIterations->2,
	WorkingPrecision->100,
	AccuracyGoal->20,
	ObtuseOnly->False
};

Options[Invert]={
	Divisions->50
};

Options[EqualAngleTicks]={
	VertexArc->True
};

(* Typesetting *)

MakeBoxes[Area,TraditionalForm]:="\[CapitalDelta]"
MakeBoxes[BrocardAngle,TraditionalForm]:="\[Omega]"
MakeBoxes[Circumradius,TraditionalForm]:="R"
MakeBoxes[Inradius,TraditionalForm]:="r"
MakeBoxes[Semiperimeter,TraditionalForm]:="s"

MakeBoxes[SA,TraditionalForm]:=SubscriptBox["S", "A"]
MakeBoxes[SB,TraditionalForm]:=SubscriptBox["S", "B"]
MakeBoxes[SC,TraditionalForm]:=SubscriptBox["S", "C"]
MakeBoxes[SW,TraditionalForm]:=SubscriptBox["S", "\[Omega]"]

Begin["`Private`"]

(* Add primitive for Triangle, etc. *)

Unprotect[Circle,Vertices]

Circle[tri_List?VectorQ,r_][t_Triangle]:=(Circle[TrilinearToCartesian[t,tri],r] /.
	TriangleRules /.
	Thread[{a,b,c}->SideLengths[Evaluate[t]]] /.
	Thread[{A,B,C}->Angles[t]]
) /; Dimensions[tri]=={3}

Circle[ctr_,r_]:=Circle[Trilinears[ctr],r] /; MemberQ[Centers,ctr]

TrilinearLine[{l_,m_,n_}][t_Triangle]:=
  LongestLine[TrilinearToCartesian[t,#]&/@(If[Chop[m]===0,
                {{0,n,-m},{n,n,-(m+l)}},
                {{0,n,-m},{m,-(n+l),m}}
                ]/.TriangleRules)/.Thread[{a,b,c}->SideLengths[Evaluate[t]]]/.Thread[{A,B,C}->Angles[t]],10^3]

(* extract vertices from an object with a head, e.g., Triangle or Quadrilateral *)

Vertices[(Triangle|Quadrilateral|Polygon)[v_List]]:=v
Vertices[t_]:=TrilinearVertexMatrix[t] /; MemberQ[Triangles,t]

Protect[Circle,Vertices]

(* *)

AcuteQ[]:=AcuteQ[{a,b,c}]&&And@@Thread[0<{A,B,C}<Pi/2]
AcuteQ[s_List?VectorQ]:=And@@(#1^2+#2^2>#3^2&@@@Partition[s,3,1,1]) /; Length[s]==3
AcuteQ[t_Triangle]:=AcuteQ[{a,b,c}]/.Thread[{a,b,c}->SideLengths[t]]

Name[AdamsCircle]="Adams' circle"
CircleFunction[AdamsCircle]:=(a*(a - b - c)^3*(a*b - b^2 + a*c + 2*b*c - c^2))/(b*c*(a^2 - 2*a*b + b^2 - 2*a*c - 2*b*c + c^2)^2)
CircleRadius[AdamsCircle]:=Inradius (-2*Sqrt[-(a^3*b) + 2*a^2*b^2 - a*b^3 - a^3*c + a^2*b*c + a*b^2*c - b^3*c + 2*a^2*c^2 + a*b*c^2 + 2*b^2*c^2 - a*c^3 - b*c^3])/(a^2 - 2*a*b + b^2 - 2*a*c - 2*b*c + c^2)
CircleCenterFunction[AdamsCircle]:=1

Add1[i_Integer]:=If[i==3,1,i+1]

addn[n_,k_,m_]:=Mod[n+k-1,m]+1

h[p_,q_,r_,u_,v_,w_]:=-q^2r^2u^2+r^2p^2v^2+p^2q^2w^2+(v w+w u+u v)(-q^2r^2+r^2p^2+p^2q^2)
AlephConjugate[{p_,q_,r},{u_,v_,w_}]:=
	{h[p,q,r,u,v,w],h[q,r,p,v,w,u],h[r,p,q,w,u,v]}
AlephConjugate[ctr1_,ctr2_]:=AlephConjugate@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

Altitudes[t_Triangle]:=Line/@Transpose[Vertices/@{OrthicTriangle[t],t}]

Angle[TrilinearLine[{l_,m_,n_}],TrilinearLine[{ll_,mm_,nn_}]]:=Module[
	{
		x=l ll+m mm+n nn-(m nn+mm n)Cos[A]-(n ll+nn l)Cos[B]-(l mm+ll m)Cos[C],
		y=(m nn-mm n)Sin[A]+(n ll-nn l)Sin[B]+(l mm-ll m)Sin[C]
	},
	ArcTan[y/x]
]

Angle[l1_,l2_]:=Angle[TrilinearLine[l1],TrilinearLine[l2]] /;
	MemberQ[Lines,l1]&&MemberQ[Lines,l2]

Angle[x_List?MatrixQ,y_List?MatrixQ]:=Module[{dx1=x[[2]]-x[[1]],dx2=y[[2]]-y[[1]]},
	ArcCos[dx1.dx2/Sqrt[dx1.dx1]/Sqrt[dx2.dx2]]
]

Angle[v_List?MatrixQ]:=Angle[{v[[1]],v[[2]]},{v[[3]],v[[2]]}] /; Dimensions[v]=={3,2}

Angle[Line[x_List?MatrixQ],Line[y_List?MatrixQ]]:=Angle[x,y]

Angle[alpha_List?MatrixQ]:=Module[{a,b,c},
	{a,b,c}=SideLengths[alpha];
	ArcCos[(a^2 - b^2 + c^2)/(2*a*c)]
] /; Dimensions[alpha]=={3,3}

AngleBisectors[]:=Cevians[Incenter]
AngleBisectors[t_Triangle]:=Cartesian[#[t]]&/@Cevians[Incenter]

(*
AngleBisectors[Quadrilateral[v_List]]:=AngleBisectors[v] /; Length[v]==4
*)

AngleBisector[v_List?MatrixQ,d_:1]:=
	Line[{v[[2]],v[[2]]+unitVector[unitVector[v[[3]]-v[[2]]]+unitVector[v[[1]]-v[[2]]]]}]

(*
AngleBisectors[v_List]:=Module[{i,len=Length[v]},
	Table[{v[[i]],
		v[[i]]+unitVector[
			unitVector[v[[addn[i,1,len]]]-v[[i]]]+
			unitVector[v[[addn[i,len-1,len]]]-v[[i]]]
		]},
	{i,Length[v]}]
] /; Length[v]>=3

AngleBisectorsLine[t_Triangle]:=Module[{i},
	Line[LongestLine[Table[AngleBisectorsExterior[t][[i,1,2]],{i,3}]]]
]

AngleBisectorsLine[i_Integer,t_Triangle]:=Module[{j},
	Line[LongestLine[
		Join[{AngleBisectorsExterior[t][[i,1,2]]},
		Table[AngleBisectors[t][[addn[i,j,2],1,2]],{j,2}] ]
	]]
]
*)

(* needs to be fixed *)
(* rewrite *)

AngleCevians[t_Triangle,cevang_List]:=
  Module[{angle=Angles[t],side=SideLengths[t],vert=Vertices@t,unitvec},
    half[b_,alpha_,gamma_]:=b Sin[alpha]/Sin[gamma+alpha];
    ang[i_Integer]:=If[i==3,angle[[1]],angle[[3]]];
    unitvec=Unit/@SideVectors[vert];
    Table[
      Line[{vert[[i]],
          vert[[Sub1[i]]]-
            unitvec[[i]] half[side[[Add1[i]]],cevang[[i]],ang[i]]}],{i,3}]]

AnglePlot[ang_, opts___] := Show[Graphics[{
				{GrayLevel[.5], Disk[{0, 0}, 1, {0, ang}]},
				Line[{{-1.1, 0}, {1.1, 0}}],
				Line[{{0, -1.1}, {0, 1.1}}],
				Circle[{0, 0}, 1]
			}], AspectRatio -> Automatic, opts]

Angles[v_List?MatrixQ]:=ArcCos[Dot@@(Unit/@{#1-#2,#3-#2})]&@@@Partition[RotateRight[v],3,1,1] /;
    Last[Dimensions[v]]==2

Angles[(Triangle|Quadrilateral|Polygon)[v_List?MatrixQ]]:=Angles[v] /;
	Dimensions[v][[2]]==2

Angles[triangle_]:=Angles[Evaluate[Triangle[triangle]]] /; MemberQ[Triangles,triangle]

Angles[t:Triangle[alpha_List?MatrixQ]]:=Module[{a,b,c},
	{a,b,c}=SideLengths[Evaluate[t]];
	{ArcCos[(-a^2 + b^2 + c^2)/(2*b*c)], 
	ArcCos[(a^2 - b^2 + c^2)/(2*a*c)], 
	ArcCos[(a^2 + b^2 - c^2)/(2*a*b)]}
] /; Dimensions[alpha]=={3,3}

Name[AntiorthicAxis]:="antiorthic axis"
LineFunction[AntiorthicAxis]:=1
CenterLine[X[1]]:=AntiorthicAxis

Anticenter[q_Quadrilateral]:=Intersections@@Take[Maltitudes[q],2]

Anticevians[t_Triangle,p_Point]:=Line/@Transpose[Vertices/@{t,AnticevianTriangle[t,p]}]
Anticevians[t_Triangle,alpha_List]:=Anticevians[t,Point[TrilinearToCartesian[t,alpha]]]

AnticevianTriangle[alpha_List?VectorQ]:=Triangle[Table[#,{3}]-2DiagonalMatrix[#]&[alpha]] /;
	Length[alpha]==3
AnticevianTriangle[ctr_]:=AnticevianTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]
AnticevianTriangle[t_Triangle,ctr_]:=Cartesian[AnticevianTriangle[ctr][t]]

Anticomplement[ctr_]:=Anticomplement[Trilinears[ctr]] /; MemberQ[Centers,ctr]
Anticomplement[tri_List?VectorQ]:={tri.{-a,b,c}/a,tri.{a,-b,c}/b,tri.{a,b,-c}/c}
Anticomplement[TrilinearLine[{l_,m_,n_}]]:=Line[{a^2*(c*m+b*n), b^2*(c*l+a*n), c^2*(b*l+a*m)}]
Anticomplement[line_]:=Anticomplement[Line[line]] /; MemberQ[Lines,line]

Name[AnticomplementaryCircle]:="anticomplementary circle"
CircleFunction[AnticomplementaryCircle]:=a^2/(b c)
CircleCenterFunction[AnticomplementaryCircle]:=Sec[A]
CircleRadius[AnticomplementaryCircle]:=2Circumradius

h[a_,b_,c_,p_,q_,r_,u_,v_,w_]:=(b^2/(q(a u + c w)) + c^2/(r(a u + b v)) - a^2/(p(b v + c w)))/a
AnticomplementaryConjugate[{p_,q_,r_},{u_,v_,w_}]:=
	{h[a,b,c,p,q,r,u,v,w],h[b,c,a,q,r,p,v,w,u],h[c,a,b,r,p,q,w,u,v]}

AnticomplementaryConjugate[{u_,v_,w_}]:=AnticomplementaryConjugate[{1,1,1},{u,v,w}]

Name[AnticomplementaryTriangle]:="anticomplementary triangle"
TrilinearVertexMatrix[AnticomplementaryTriangle]:=
{{-a^(-1), b^(-1), c^(-1)}, {a^(-1), -b^(-1), c^(-1)}, {a^(-1), b^(-1), -c^(-1)}}

Antiparallel[t_Triangle,x_]:=Module[{v=Vertices@t,u=SideUnitVectors[t],c,pts,i,j,k},
    k=v[[1]]+x u[[3]];
    c=Circumcircle[Triangle[{k,v[[1]],v[[3]]}]];
    Line[Coordinates/@
        Flatten[(Complement[Intersections[Line[v[[{2,#}]]],c],{Point[v[[#]]]},
                  SameTest->(Equal@@Coordinates/@Chop[{#1,#2}]&)])&/@{1,3}]]
]
    
AntiparallelCircle[t_Triangle,x_]:=Module[{v=Vertices@t,u},
	u=SideUnitVectors[v];
	Circumcircle[{v[[1]]+x u[[3]],v[[1]],v[[3]]}][[{1,2}]]
]

Antiparallels[t_Triangle,p_Point]:=Module[
    {
    i,
    u,
    k=Coordinates@SymmedianPoint[t],
    v=Vertices@t,
    pt=Coordinates@p
	},
    u=Antiparallel[Triangle[#],.1][[1]]&/@NestList[RotateLeft,RotateLeft@v,2];
    Line/@Table[{
    	Coordinates@Intersections[
    		Line@{pt,pt+u[[i,2]]-u[[i,1]]},
    		Line@v[[{addn[i,0,3],addn[i,2,3]}]]
    	],
        Coordinates@Intersections[
        	Line@{pt,pt+u[[i,2]]-u[[i,1]]},
        	Line@v[[{addn[i,1,3],addn[i,2,3]}]]
        ]},{i,3}]
]

AntipedalLines[t_Triangle,p_Point]:=Line[{Coordinates[p],#}]&/@Vertices[t]

AntipedalTriangle[{\[Alpha]_,\[Beta]_, \[Gamma]_}]:=Triangle[{
  {-(\[Beta]+\[Alpha] Cos[C])(\[Gamma]+\[Alpha] Cos[B]),
  (\[Gamma]+\[Alpha] Cos[B])(\[Alpha]+\[Beta] Cos[C]),
  (\[Beta]+\[Alpha] Cos[C])(\[Alpha]+\[Gamma] Cos[B])
  },
  {
  (\[Gamma]+\[Beta] Cos[A])(\[Beta]+\[Alpha] Cos[ C]),
  -(\[Gamma]+\[Beta] Cos[A])(\[Alpha]+\[Beta] Cos[C]),
  (\[Alpha]+\[Beta] Cos[C])(\[Beta]+\[Gamma] Cos[A])
  },
  {
  (\[Beta]+\[Gamma] Cos[A])(\[Gamma]+\[Alpha] Cos[B]),
  (\[Alpha]+\[Gamma] Cos[B])(\[Gamma]+\[Beta] Cos[A]),
  -(\[Alpha]+\[Gamma] Cos[B])(\[Beta]+\[Gamma] Cos[A])
  }
}
]
AntipedalTriangle[ctr_]:=AntipedalTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]
AntipedalTriangle[t_Triangle,ctr_]:=Cartesian[AntipedalTriangle[ctr][t]]

Name[ApolloniusCircle]:="Apollonius circle"
CircleFunction[ApolloniusCircle]:=(a+b+c)(a^2+a*b+a*c+2*b*c)/(4*a*b*c)
CircleCenterFunction[ApolloniusCircle]:=a*(a^3*b^2+a^2*b^3-a*b^4-b^5+2*a^3*b*c+a^2*b^2*c-2*a*b^3*c-b^4*c+a^3*c^2+a^2*b*c^2+a^2*c^3-2*a*b*c^3-a*c^4-b*c^4-c^5)
CircleRadius[ApolloniusCircle]:=(Inradius^2+Semiperimeter^2)/(4Inradius)

CircleTripletFunction[ApolloniusCircles]:={{0,-b,c},
	(a^2*b^2*c^2)/((b + c)*Sqrt[-a^4 + 2*a^2*b^2 - b^4 + 2*a^2*c^2 + 2*b^2*c^2 - c^4]*Circumradius*Abs[b - c])}

ApolloniusInnerOuterCircles[circ:{_Circle,_Circle,_Circle}]:=Module[
	{x,y,r,i},
	{{{x[1],y[1]},r[1]},{{x[2],y[2]},r[2]},{{x[3],y[3]},r[3]}}=List@@@circ;
	{x,y,Abs[r]}/.Solve[
		Table[(x-x[i])^2+(y-y[i])^2==(r-r[i])^2,{i,3}],
	{x,y,r}]
]

ApolloniusInnerCircle[circ:{_Circle,_Circle,_Circle}]:=Module[
	{soln=ApolloniusInnerOuterCircles[circ]},
	Circle[{#[[1]],#[[2]]},#[[3]]]&[Select[soln,(Last[#]==Min[Last/@soln]&)][[1]]]
]

ApolloniusOuterCircle[circ:{_Circle,_Circle,_Circle}]:=Module[
	{soln=ApolloniusInnerOuterCircles[circ]},
	Circle[{#[[1]],#[[2]]},#[[3]]]&[Select[soln,(Last[#]==Max[Last/@soln]&)][[1]]]
]

(* Apollonius Inverse Points *)

perp[l_List]:=Module[{h=l[[2]]-l[[1]],hv},
	hv={-h[[2]],h[[1]]};
	hv/Sqrt[hv.hv]
]

ApolloniusInversePoints[c:{_Circle,_Circle,_Circle}]:=Module[
	{hl,h=HomotheticLines[c],i},
	hl=Table[Take[h[[i,1]],2],{i,4}];
	hv=Table[perp[hl[[i]]],{i,4}];
	Table[InversePoint[c[[i]],
      Point[c[[i,1]]+PointingAway[{hv[[j]],c[[i,1]]},hl[[j,1]]] *
		Distance[c[[i,1]],hl[[j]]]]
	],
	{i,3},{j,4}]
]

ApolloniusIntersectionPoints[c:{_Circle,_Circle,_Circle}]:=Module[
	{
	ainv=Coordinates/@#&/@ApolloniusInversePoints[c],
	rc=Coordinates@RadicalCenter[c],
	i,j},
	Table[Point[{x,y}] /.Solve[{(x-c[[i,1,1]])^2+(y-c[[i,1,2]])^2==c[[i,2]]^2,
		y-ainv[[i,j,2]]==(ainv[[i,j,2]]-rc[[2]])/(ainv[[i,j,1]]-rc[[1]])(x-ainv[[i,j,1]])},
	{x,y}],{j,4},{i,3}]
]

(* Apollonius Point *)

CenterFunction[ApolloniusPoint]:=Sin[A]^2 Cos[(B-C)/2]^2
Name[ApolloniusPoint]:="Apollonius point"

ApolloniusTangentCircles[circ:{_Circle,_Circle,_Circle}]:=Module[
	{x,y,r,soln,i,j,k},
	{{{x[1],y[1]},r[1]},{{x[2],y[2]},r[2]},{{x[3],y[3]},r[3]}}=List@@@circ;
	soln=Flatten[Table[Solve[{
		(x-x[1])^2+(y-y[1])^2-(r+(-1)^i r[1])^2==0,
		(x-x[2])^2+(y-y[2])^2-(r+(-1)^j r[2])^2==0,
		(x-x[3])^2+(y-y[3])^2-(r+(-1)^k r[3])^2==0},
	{x,y,r}],
	{i,2},
	{j,2},
	{k,2}],2];
	(* NCircle rounds; Circle doesn't *)
	Union[Table[
		{
		Circle[{x,y} /. soln[[i,1]],Abs[r] /. soln[[i,1]]],
		Circle[{x,y} /. soln[[i,2]],Abs[r] /. soln[[i,2]]]
		},
	{i,8}]//Flatten]
]

(* Area *)

(*
Area[]:=Area[Triangle[]]
Area[Triangle[]]:=Area[{a,b,c}]
Area[t_Triangle,alpha_List?MatrixQ]:=Module[{s=SideLengths[t]},
	Times@@s/(8Area[s]^2)Det[ExactTrilinears/@alpha] 
]/; Dimensions[alpha]=={3,3}
*)

Area[abc_List?VectorQ]:=
	Sqrt[Plus@@abc Times@@(abc.#&/@Permutations[{1,1,-1}])]/4 /; Length[abc]==3

Area[Triangle[alpha_List?MatrixQ]]:=
	a b c/(8Area^2) (*Abs*)Det[ExactTrilinears/@alpha] /; Dimensions[alpha]=={3,3}
	
Area[triangle_]:=Area[Evaluate[Triangle[triangle]]] /; MemberQ[Triangles,triangle]

Area[Triangle[v_List?MatrixQ]]:=Abs[Det[Append[#,1]&/@v]]/2 /; Dimensions[v]=={3,2}

Area[Polygon[l_List?MatrixQ]]:=Plus@@(Det/@Partition[l,2,1,1])/2 /; Dimensions[l][[2]]==2

Area[RegularPolygon[n_Integer,R_:1]]:=n R^2Sin[2Pi/n]/2 /; n>=3

Area[AntipedealTriangl[ctr_]]:=
	-((Circumradius*(c*\[Alpha]*\[Beta] + b*\[Alpha]*\[Gamma] + a*\[Beta]*\[Gamma])^2)/
	(\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma]))) /. 
    Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
Area[AnticevianTriangl[ctr_]]:=
	(4*a*b*c*Area*Abs[\[Alpha]*\[Beta]*\[Gamma]])/
	Abs[(a*\[Alpha] + b*\[Beta] - c*\[Gamma])*(a*\[Alpha] - b*\[Beta] + c*\[Gamma])*
	((-a)*\[Alpha] + b*\[Beta] + c*\[Gamma])] /. 
	Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
Area[CevianTriangle[ctr_]]:=
	(2*a*b*c*Area*Abs[\[Alpha]*\[Beta]*\[Gamma]])/
	Abs[(a*\[Alpha] + b*\[Beta])*(a*\[Alpha] + c*\[Gamma])*(b*\[Beta] + c*\[Gamma])] /.
	Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
Area[CircumcevianTriangle[ctr_]]:=
	((c*\[Alpha]*\[Beta] + b*\[Alpha]*\[Gamma] + a*\[Beta]*\[Gamma])^3*Area)/
	(a*b*c*(\[Beta]^2 + \[Gamma]^2 + 2*\[Beta]*\[Gamma]*Cos[A])*(\[Alpha]^2 + \[Gamma]^2 + 
	2*\[Alpha]*\[Gamma]*Cos[B])*(\[Alpha]^2 + \[Beta]^2 + 2*\[Alpha]*\[Beta]*Cos[C])) /.
	Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
Area[PedalTriangle[ctr_]]:=
	(4*(c*\[Alpha]*\[Beta] + b*\[Alpha]*\[Gamma] + a*\[Beta]*\[Gamma])*Area^3)/
	(a*b*c*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])^2)/.
	Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]

Area[Quadrilateral[v_]]:=Module[{a,b,c,d,p,q},
	{a,b,c,d}=Norm/@Subtract@@@Partition[v,2,1,1];
	{p,q}=Norm/@Subtract@@@Transpose[Partition[v,2]];
	Sqrt[4p^2q^2-(b^2+d^2-a^2-c^2)^2]/4
]

Area[circumellipse_]:=Module[{x,y,z},
	{x,y,z}=CircumconicParameters[circumellipse];
	((4*a*b*c*Pi*x*y*z)/(2*(a*b*x*y + a*c*x*z + b*c*y*z) - (a^2*x^2 + b^2*y^2 + c^2*z^2))^(3/2))*Area
] /; MemberQ[Circumconics,circumellipse]

Area[inellipse_]:=Module[{x,y,z},
	{x,y,z}=InconicParameters[inellipse];
	Area Pi a b c Sqrt[x y z/(b c x+a c y+a b z)^3]
] /; MemberQ[Inconics,inellipse]

(* Areal Coordinates *)

ArealCoordinates[t_Triangle,p_Point]:=Module[{v=Vertices@t},
  RotateLeft[
  (Area[Triangle[Append[#,Coordinates@p]]]&/@RotateLeft@Partition[v,2,1,1])/Area[t]
  ]
]

ArealCoordinates[ctr_]:=HomogeneousBarycentrics[ctr]/Area

AuxiliaryCircle[Circle[c_List?VectorQ,semi_List?VectorQ]]:=Circle[c,Max[semi]]

Barycentrics[ctr_]:=Trilinears[ctr]{a,b,c} /; MemberQ[Centers,ctr]

BarycentricToCartesian[t_Triangle,bary_List?VectorQ]:=
	TrilinearToCartesian[t,bary/SideLengths[Evaluate[t]]] /; Length[bary]==3

Name[BCICircle]:="BCI circle"
CircleFunction[BCICircle]:=Null
CircleRadius[BCICircle]:=Null
CircleCenterFunction[BCICircle]:=
-(((6*a^4 + 16*a^3*b + 14*a^2*b^2 + 4*a*b^3 + a^3*c + 6*a^2*b*c + a*b^2*c - 6*a^2*c^2 - 4*a*b*c^2 - a*c^3 + 
    10*a^2*b*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 8*a*b^2*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 
    2*b^3*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 8*a*b*c*Sqrt[(a*(a + b - c)*(a + b + c))/b] - 
    4*b^2*c*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 2*b*c^2*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 
    2*a^4*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 7*a^3*b*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    6*a^2*b^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 3*a*b^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    7*a^3*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 12*a^2*b*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    3*a*b^2*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 4*b^3*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    6*a^2*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 3*a*b*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    8*b^2*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 3*a*c^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    4*b*c^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 7*a^3*b*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    4*a^2*b^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 3*a*b^3*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    6*a^2*b*c*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 4*a^2*c^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    a*b*c^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 4*a*c^3*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    2*a^3*b*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 2*a^2*b^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 
    2*a*b^3*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 2*b^4*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    2*a^3*c*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 4*a^2*b*c*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    2*a*b^2*c*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 2*a^2*c^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    2*a*b*c^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 4*b^2*c^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 
    2*a*c^3*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 2*c^4*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    a^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 5*a^3*b*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 
    2*a^2*b^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 5*a*b^3*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    b^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 5*a^3*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    11*a*b^2*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 2*a^2*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    11*a*b*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 2*b^2*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    5*a*c^3*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + c^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    4*a^2*b^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 4*a*b^3*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 
    7*a^3*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 6*a^2*b*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    a*b^2*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 4*a^2*c^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    3*a*c^3*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 6*a^4*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    a^3*b*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 6*a^2*b^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 
    a*b^3*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 16*a^3*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    6*a^2*b*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 4*a*b^2*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    14*a^2*c^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + a*b*c^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    4*a*c^3*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)])*(7*a^4 + 20*a^3*b + 26*a^2*b^2 + 20*a*b^3 + 7*b^4 + 6*a^3*c + 
    18*a^2*b*c + 18*a*b^2*c + 6*b^3*c - 8*a^2*c^2 - 8*a*b*c^2 - 8*b^2*c^2 - 6*a*c^3 - 6*b*c^3 + c^4 + 
    14*a^2*b*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 12*a*b^2*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 
    14*b^3*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 12*a*b*c*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 
    12*b^2*c*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 14*b*c^2*Sqrt[(a*(a + b - c)*(a + b + c))/b] + 
    2*a^4*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 10*a^3*b*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    2*a^2*b^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 10*a*b^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    10*a^3*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 12*a^2*b*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    10*a*b^2*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 8*b^3*c*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    2*a^2*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 10*a*b*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] + 
    16*b^2*c^2*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 10*a*c^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 
    8*b*c^3*Sqrt[(a*(a + b + c))/(c*(a - b + c))] - 10*a^3*b*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 
    2*a^2*b^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 10*a*b^3*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    2*b^4*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 8*a^3*c*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    10*a^2*b*c*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 12*a*b^2*c*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    10*b^3*c*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 16*a^2*c^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] + 
    10*a*b*c^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 2*b^2*c^2*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 
    8*a*c^3*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 10*b*c^3*Sqrt[(b*(a + b + c))/(c*(-a + b + c))] - 
    4*a^4*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 8*a^2*b^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 
    4*b^4*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 8*a^2*c^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    8*b^2*c^2*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] - 4*c^4*Sqrt[-((a*b)/(a^2 - 2*a*b + b^2 - c^2))] + 
    a^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 6*a^3*b*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 
    8*a^2*b^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 6*a*b^3*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    7*b^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 6*a^3*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 
    8*a^2*b*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 18*a*b^2*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    20*b^3*c*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 8*a^2*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    18*a*b*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 26*b^2*c^2*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    6*a*c^3*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 20*b*c^3*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] + 
    7*c^4*Sqrt[(-a^2 - a*b + a*c)/(a*c - b*c - c^2)] - 8*a^3*b*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    16*a^2*b^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 8*a*b^3*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 
    10*a^3*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 10*a^2*b*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    10*a*b^2*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 10*b^3*c*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 
    2*a^2*c^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 12*a*b*c^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] - 
    2*b^2*c^2*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 10*a*c^3*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    10*b*c^3*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 2*c^4*Sqrt[(-(a + b)^2 + c^2)/((a - b)^2 - c^2)] + 
    7*a^4*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 6*a^3*b*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 
    8*a^2*b^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 6*a*b^3*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    b^4*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 20*a^3*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    18*a^2*b*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 8*a*b^2*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 
    6*b^3*c*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 26*a^2*c^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    18*a*b*c^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] - 8*b^2*c^2*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    20*a*c^3*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 6*b*c^3*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)] + 
    7*c^4*Sqrt[(a*b + b^2 - b*c)/(a*c - b*c + c^2)]))/a)

Name[BCITriangle]:="BCI triangle"
TrilinearVertexMatrix[BCITriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{1,1+2Cos[#3/2],1+2Cos[#2/2]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

BeginPoint[Line[l_List]]:=Point[First[l]]
BeginPoint[Line[l__List]]:=First[{l}]

h[a_,b_,c_,p_,q_,r_,u_,v_,w_]:=With[
	{aa=-a+b+c,bb=a-b+c,cc=a+b-c},
	2 a b c p(Cos[B]+Cos[C])(u aa/p+v bb/q+w cc/r)-(a+b+c)aa bb cc u
]
BethConjugate[{p_,q_,r_},{u_,v_,w_}]:=
	{h[a,b,c,p,q,r,u,v,w],h[b,c,a,q,r,p,v,w,u],h[c,a,b,r,p,q,w,u,v]}
BethConjugate[ctr1_,ctr2_]:=BethConjugate@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

Name[BevanCircle]="Bevan circle"
CircleFunction[BevanCircle]:=1
CircleCenterFunction[BevanCircle]:=-1-Cos[A]+Cos[B]+Cos[C]
CircleRadius[BevanCircle]:=2Circumradius

CenterFunction[BevanPoint]:=-1-Cos[A]+Cos[B]+Cos[C]
Name[BevanPoint]:="Bevan point"

BicentricPair[f_]:={f,f/.{b->c,B->C,c->b,C->B}}

Trilinears[BickartPoint[1]]:=With[{Z=Sqrt[a^4 - a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2 + c^4]},
  (Sqrt[2 (a^2 b^2 c^2 Z^3) - 2 (b^4 c^4 (2 S^2 - a^2 SW) + c^4 a^4 (2 S^2 - b^2 SW) + a^4 b^4 (2 S^2 - c^2 SW))]-
  2(b^2 - c^2) (a^4 - b^2 c^2 - a^2 Z))/a
]

Trilinears[BickartPoint[2]]:=With[{Z=Sqrt[a^4 - a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2 + c^4]},
  (Sqrt[2 (a^2 b^2 c^2 Z^3) - 2 (b^4 c^4 (2 S^2 - a^2 SW) + c^4 a^4 (2 S^2 - b^2 SW) + a^4 b^4 (2 S^2 - c^2 SW))]+
  2(b^2 - c^2) (a^4 - b^2 c^2 - a^2 Z))/a
]

BisymmetricQ[ctr_,opts___]:=BisymmetricQ[CenterFunction[ctr],opts] /; MemberQ[Centers,ctr]
BisymmetricQ[alpha_]:=
	(Subtract@@{alpha,alpha/.{b->c,c->b,B->C,C->B}}/.a->1)==0

BisymmetricQ[ctr_,Signed->True]:=BisymmetricQ[CenterFunction[ctr],Signed->True] /; 
  MemberQ[Centers,ctr]
BisymmetricQ[alpha_,Signed->True]:=Module[{alpha1=alpha/.a->1,alpha2},
	alpha2=alpha1/.{b->c,c->b,B->C,C->B};
	alpha1-alpha2==0 || alpha1+alpha2==0
]

Bimedians[q_Quadrilateral]:=MidpointDiagonals[q]

BrianchonPoint[conic_]:=1/InconicParameters[conic]

(*
BrocardAngle[]:=BrocardAngle[{a,b,c}]
BrocardAngle[abc_List?VectorQ]:=ArcCot[abc.abc/4/Area[abc]] /; Length[abc]==3
BrocardAngle[t_Triangle]:=ArcCot[Plus@@Cot[Angles@t]]
*)

BrocardAngles[n_][t_Triangle]:=Module[{bp=Coordinates@BrocardPoint[n][t]},
	Line[{bp,#}]&/@Vertices[t]
]

Name[BrocardAxis]:="Brocard axis"
LineFunction[BrocardAxis]:=Sin[B-C]
CenterLine[X[523]]:=BrocardAxis

Name[BrocardCircle]:="Brocard circle"
CircleFunction[BrocardCircle]:=-b*c/(a^2 + b^2 + c^2)
CircleCenterFunction[BrocardCircle]:=Cos[A-BrocardAngle]
CircleRadius[BrocardCircle]:=Circumradius Sqrt[1-4Sin[BrocardAngle]^2]/(2Cos[BrocardAngle])

BrocardCircumtriangle[n_,t_Triangle]:=Module[{i,c,tri=Vertices@t},
	c=Flatten[Table[Intersections[Line[{tri[[i]],BrocardPoint[n][t][[1]]}],
		Circumcenter[tri]],{i,3}],1];
	Triangle[Select[c,And@@Table[(#-tri[[i]]).(#-tri[[i]])>.01,{i,3}]&]]
]

Name[BrocardInellipse]:="Brocard inellipse"
InconicParameters[BrocardInellipse]:=1/{a,b,c}

BrocardLines[n_][t_Triangle]:=Cevians[t,BrocardPoint[n][t]]

CenterFunction[BrocardMidpoint]:=a(b^2+c^2)
Name[BrocardMidpoint]:="Brocard midpoint"

CenterFunction[BrocardPoint[1]]:=c/b
Name[BrocardPoint[1]]:="first Brocard point"

CenterFunction[BrocardPoint[2]]:=b/c
Name[BrocardPoint[2]]:="second Brocard point"

CenterFunction[BrocardPoint[3]]:=1/a^3
Name[BrocardPoint[3]]:="third Brocard point"

d[x_,y_]:=(x-y).(x-y)

Name[BrocardTriangle[1]]:="first Brocard triangle"
TrilinearVertexMatrix[BrocardTriangle[1]]:={{a*b*c, c^3, b^3}, {c^3, a*b*c, a^3}, {b^3, a^3, a*b*c}}

Name[BrocardTriangle[2]]:="second Brocard triangle"
TrilinearVertexMatrix[BrocardTriangle[2]]:={{2 b c Cos[A],a b,a c},{a b,2 a c Cos[B],b c},{a c, b c, 2 a b Cos[C]}}

Name[BrocardTriangle[3]]:="third Brocard triangle"
TrilinearVertexMatrix[BrocardTriangle[3]]:={{b^2*c^2, a*b^3, a*c^3}, {a^3*b, a^2*c^2, b*c^3}, {a^3*c, b^3*c, a^2*b^2}}

BrokenLine[x_List?MatrixQ,n_:20]:=
  Line[BrokenSegment[x,n]]/;ArrayDepth[x]\[Equal]2&&Length[x]\[Equal]2
  
BrokenLine[x_List?MatrixQ,n_:20]:= 
  Module[{segs=BrokenSegment[#,n]&/@Partition[x,2,1]},
      Line[Flatten[Join[{First[segs]},Rest/@Rest[segs]],1]]
      ]/; ArrayDepth[x]\[Equal]2&&Length[x]>2

BrokenPolygon[x_List?MatrixQ,n_:20]:= 
  Module[{segs=BrokenSegment[#,n]&/@Partition[x,2,1,1]},
      Polygon[Most[Flatten[Join[{First[segs]},Rest/@Rest[segs]],1]]]
      ]/; ArrayDepth[x]\[Equal]2&&Length[x]>2

BrokenSegment[x_List?MatrixQ,n_:20]:=
  x[[1]]-Subtract@@x#&/@Range[0,1,1/n]/;
    ArrayDepth[x]\[Equal]2&&Length[x]\[Equal]2

brokenline[{x1_List,x2_List},n_:20]:=
  Module[{i},Table[x1+(x2-x1)i,{i,0,1,1/n}]]

cartesian[tri_List?VectorQ[t_Triangle]]:=TrilinearToCartesian[t,tri] /.
	TriangleRules /.
	Thread[{a,b,c}->SideLengths[Evaluate[t]]] /.
	Thread[{A,B,C}->Angles[t]]
Cartesian[tri_List?VectorQ[t_Triangle]]:=Point[cartesian[tri[t]]] /; Length[tri]==3
Cartesian[t_Triangle[rt_Triangle]]:=Triangle[cartesian[#[rt]]&/@Vertices[t]]
Cartesian[Line[tri__List?VectorQ][t_Triangle]]:=Line[cartesian[#[t]]&/@{tri}] /;
	Union[Length/@{tri}]=={3}

CartesianToTrilinear[t_Triangle,p_Point]:=Distance[p,#]&/@Sides[t]

CDPoint[{p_,q_,r_}]:={b c/(-a/p + b/q + c/r), c a/(a/p - b/q + c/r), a b/(a/p + b/q - c/r)}

(*** Center ***)
(* circle *)

Unprotect[Center];
Center[Circle[{x_,y_},r_]]:=Point[{x,y}]
Center[Circle[{alpha_,beta_,gamma_},r_]]:={alpha,beta,gamma}

Center[circ_]:=CyclicTrilinears[CircleCenterFunction[circ]] /; MemberQ[CentralCircles,circ]

Center[Circle[{l_,m_,n_,k_:1}]]:=#.Cos/@{0,A,B,C}&/@{{l,k,-n,-m},{m,-n,k,-l},{n,-m,-l,k}}

(* conic *)

Center[conic_]:=Center[TrilinearEquation[conic]] /; MemberQ[Conics,conic]

Center[eqn_]:=Module[{u,v,w,f,g,h,U,VV,W,F,G,H},
    {u,v,w,f,g,h}=Coefficient[Numerator[Together[eqn]],
    	{\[Alpha]^2,\[Beta]^2,\[Gamma]^2,\[Beta] \[Gamma],\[Gamma] \[Alpha],\[Alpha] \[Beta]}]{1,1,1,1/2,1/2,1/2};
	(*
	Print[Expand[
		eqn-Plus@@({u,v,w,f,g,h}{\[Alpha]^2,\[Beta]^2,\[Gamma]^2,\[Beta] \[Gamma],\[Gamma] \[Alpha],\[Alpha] \[Beta]}*
		{1,1,1,2,2,2})]];
	*)
    U=v w-f^2;
    VV=w u-g^2;
    W=u v-h^2;
    F=g h-u f;
    G=h f-v g;
    H=f g-w h;
    {a U+b H+c G,a H+b VV+c F,a G+b F+c W}
]

Protect[Center];

(*** end Center ***)

CenterFunction[Centroid]:=1/a
Name[Centroid]:="centroid"

Centroid[q_Quadrilateral]:=Centroid[Vertices@q]
Centroid[vert_List?VectorQ]:=Point[Plus@@vert/Length[vert]]
Centroid[t_]:=Centroid[Triangle[t]] /; MemberQ[Triangles,t]
CentroidBarycentric[Triangle[{{p1_, q1_, r1_}, {p2_, q2_, r2_}, {p3_, q3_, r3_}}]] := 
  ({p1, q1, r1}/(p1 + q1 + r1) + {p2, q2, r2}/(p2 + q2 + r2) + 
   {p3, q3, r3}/(p3 + q3 + r3))

Centroid[Triangle[{{p1t_, p2t_, p3t_}, {q1t_, q2t_, q3t_}, {r1t_, r2t_, r3t_}}]] := 
  Module[{p1, p2, p3, q1, q2, q3, r1, r2, r3}, 
   {{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}} = ({a, b, c}# & ) /@ 
      {{p1t, p2t, p3t}, {q1t, q2t, q3t}, {r1t, r2t, r3t}}; 
    CentroidBarycentric[Triangle[{{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}}]]/{a, b, c}
]

CentroidHexagon[a_List /; Length[a]==6]:=Module[{l=Join[a,Take[a,3]],i},
	polygon[Table[Plus@@Take[l,{i,i+2}]/3,{i,6}]]
]

CevaConjugate[ctrp_?VectorQ,ctrq_]:=CevaConjugate[ctrp,Trilinears[ctrq]] /; MemberQ[Centers,ctrq]
CevaConjugate[ctrp_,ctrq_?VectorQ]:=CevaConjugate[Trilinears[ctrp],ctrq] /; MemberQ[Centers,ctrp]

CevaConjugate[ctrp_,ctrq_]:=CevaConjugate[Trilinears[ctrp],Trilinears[ctrq]] /;
	MemberQ[Centers,ctrp] && MemberQ[Centers,ctrq]

CevaConjugate[p_?VectorQ,q_?VectorQ]:=CyclicTrilinears[q[[1]]Plus@@(q/p{-1,1,1})]

Cevapoint[{p_,q_,r_},{u_,v_,w_}]:={(p v + q u)(p w + r u), (q w + r v)(q u + p v), (r u + p w)(r v + q w)}

CevianCircle[t_Triangle,p_Point]:=Circumcircle[CevianTriangle[t,p]]

CevianCircleTriangle[v_List,pt_List]:=Module[
	{i,c=CevianCircle[v,pt],ct=CevianTriangle[v,pt][[1]]},
	Triangle[Flatten[Table[Select[
	Intersections[Line[v[[{i,addn[i,1,3]}]]],c],
		(ct[[addn[i,2,3]]]-#).(ct[[addn[i,2,3]]]-#)>.000001&],
	{i,3}],1]]
]

CevianCircleLines[v_List,pt_List]:=Module[
	{ct=CevianCircleTriangle[v,pt][[1]]},
	Table[Line[{v[[i]],ct[[addn[i,1,3]]]}],{i,3}]
]

CevianCircleTrianglePoint[v_List,pt_List]:=Module[
	{cl=CevianCircleLines[v,pt]},
	Intersections[cl[[1]],cl[[2]]]
]

Cevians[ctr_]:=Line@@@Transpose[Vertices/@{Triangle[ReferenceTriangle],CevianTriangle[ctr]}] /;
	MemberQ[Centers,ctr]
Cevians[ctr:{alpha_,beta_,gamma_}]:=
	Line@@@Transpose[Vertices/@{Triangle[ReferenceTriangle],CevianTriangle[ctr]}]
Cevians[t:Triangle[m_List?MatrixQ],p_Point]:=
	Line/@Transpose[Vertices/@{t,CevianTriangle[t,p]}] /; Dimensions[m]=={3,2}
Cevians[t:Triangle[m_List?MatrixQ],tri_List?VectorQ]:=
	Line/@Transpose[Vertices/@{t,CevianTriangle[t,tri]}] /; Length[tri]==3&& Dimensions[m]=={3,2}

CeviansSideRatios[v_List,r_]:=Module[{s=SideLengths[v],u=SideUnitVectors[v],i},
	{Line/@Table[{v[[i]],v[[addn[i,1,3]]]+r u[[i]]s[[i]]},{i,3}],
	Line/@Table[{v[[i]],v[[addn[i,1,3]]]+(1-r) u[[i]]s[[i]]},{i,3}]}
]

CevianTriangle[alpha_List?VectorQ]:=Triangle[Table[#,{3}]-DiagonalMatrix[#]&[alpha]] /;
	Length[alpha]==3
CevianTriangle[ctr_]:=CevianTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]
CevianTriangle[t_Triangle,ctr_]:=Cartesian[CevianTriangle[ctr][t]]

Chord[Circle[{x_,y_},r_],{a1_,a2_}]:=
	Line[{{x,y},{x,y}}+r{{Cos[a1],Sin[a1]},{Cos[a2],Sin[a2]}}]

(* CircleFunction *)

CircleFunction[circ:Circle[{p_, q_, r_},radius_]] := -CirclePowers[circ]/{b c,c a,a b}
CircleFunction[circ_]:=CircleFunction[Circle[circ]] /; MemberQ[CentralCircles,circ]

CircleFunction[eqn_]:=Module[{k,l,m,n,soln},
	soln=Solve[{
        c k+b l+a m==Coefficient[eqn,\[Alpha] \[Beta]],
        b k+c l+a n==Coefficient[eqn,\[Alpha] \[Gamma]],
        a k+c m+b n==Coefficient[eqn,\[Beta] \[Gamma]],
        a l==Coefficient[eqn,\[Alpha]^2]
        },
        {l,m,n,k}
    ];
    If[soln=!={},
		{l,m,n}/k/.soln[[1]],
	(* Else *)
		soln=Solve[{
        c k+b l+a m==Coefficient[eqn,\[Alpha] \[Beta]],
        b k+c l+a n==Coefficient[eqn,\[Alpha] \[Gamma]],
        a k+c m+b n==Coefficient[eqn,\[Beta] \[Gamma]],
        a l==Coefficient[eqn,\[Alpha]^2],
        b m==Coefficient[eqn,\[Beta]^2],
        c n==Coefficient[eqn,\[Gamma]^2]
        },
        {l,m,n,k}
    	];
    	If[soln=!={},{l,m,n}/k/.soln[[1]],{}]
    ]
]

(* Circle Power *)

CirclePowers[Circle[{p_, q_, r_},radius_]]:={
b^2 c^2 r^2 + b^2 c^2 q^2 + 2 b c q r SA,
c^2 a^2 p^2 + c^2 a^2 r^2 + 2 c a r p SB,
a^2 b^2 q^2 + a^2 b^2 p^2 + 2 a b p q SC} / (a p + b q + c r)^2 - radius^2
CirclePowers[circ_]:=CirclePowers[Circle[circ]] /; MemberQ[CentralCircles,circ]

CircleRadius[Circle[x_List?VectorQ,r_]]:=r
CircleRadius[t_Triangle]:=Module[{sides=SideLengths[t],a,b,c},{a,b,c}=sides;
    a b c/Sqrt[(a+b+c)(b+c-a)(c+a-b)(a+b-c)]]
(*
CircleRadius[tri_List?MatrixQ]:=CircleRadius[TrilinearEquation[tri]] /;
	Dimensions[tri]=={3,3}
CircleRadius[ctr_]:=CircleRadius[TrilinearEquation[ctr]] /; MemberQ[CentralCircles,ctr]
CircleRadius[eqn_]:=Distance[
	Center[eqn],
	{1,Solve[eqn==0/.{\[Gamma]->1,\[Alpha]->1},\[Beta]][[1,1,2]],1}
]
CircleRadius[l_List,k_:1]:=Distance[
	Center[l,k],
	{1,Solve[TrilinearEquation[{l,k}]==0/.{\[Gamma]->1,\[Alpha]->1},\[Beta]][[1,1,2]],1}
]
*)

CircleTriplet[tri_List?VectorQ,r_]:=(Circle@@@Transpose[{
	MapIndexed[RotateRight[#1,#2[[1]]-1]&,CyclicTrilinears[tri]],
	CyclicTrilinears[r]
}]/.root[x_,l_]:>Root[x,Position[l,a][[1,1]]]) /; Dimensions[tri]=={3}

Circumcenter[q_Quadrilateral]:=Circumcenter[Triangle[Drop[Vertices[q],-1]]]

Circumcenter[t_]:=Circumcenter[Triangle[t]] /; MemberQ[Triangles,t]
CircumcenterBarycentric[Triangle[{{\[Alpha]1_, \[Beta]1_, \[Gamma]1_}, {\[Alpha]2_, \[Beta]2_, \[Gamma]2_}, 
     {\[Alpha]3_, \[Beta]3_, \[Gamma]3_}}]] := Module[{f1, f2, f3, d, l, m, n, \[Alpha]0, 
     \[Beta]0, \[Gamma]0}, f1 = -((c^2*\[Alpha]1*\[Beta]1 + b^2*\[Alpha]1*\[Gamma]1 + a^2*\[Beta]1*\[Gamma]1)/
        (a*b*c*(\[Alpha]1 + \[Beta]1 + \[Gamma]1))); 
     f2 = -((c^2*\[Alpha]2*\[Beta]2 + b^2*\[Alpha]2*\[Gamma]2 + a^2*\[Beta]2*\[Gamma]2)/
        (a*b*c*(\[Alpha]2 + \[Beta]2 + \[Gamma]2))); 
     f3 = -((c^2*\[Alpha]3*\[Beta]3 + b^2*\[Alpha]3*\[Gamma]3 + a^2*\[Beta]3*\[Gamma]3)/
        (a*b*c*(\[Alpha]3 + \[Beta]3 + \[Gamma]3))); 
     d = -((1/(a*b*c))*(\[Alpha]3*\[Beta]2*\[Gamma]1 - \[Alpha]2*\[Beta]3*\[Gamma]1 - 
         \[Alpha]3*\[Beta]1*\[Gamma]2 + \[Alpha]1*\[Beta]3*\[Gamma]2 + \[Alpha]2*\[Beta]1*\[Gamma]3 - 
         \[Alpha]1*\[Beta]2*\[Gamma]3)); 
     l = -((1/(b*c*d))*(f3*\[Beta]2*\[Gamma]1 - f2*\[Beta]3*\[Gamma]1 - f3*\[Beta]1*\[Gamma]2 + 
         f1*\[Beta]3*\[Gamma]2 + f2*\[Beta]1*\[Gamma]3 - f1*\[Beta]2*\[Gamma]3)); 
     m = (1/(a*c*d))*(f3*\[Alpha]2*\[Gamma]1 - f2*\[Alpha]3*\[Gamma]1 - f3*\[Alpha]1*\[Gamma]2 + 
        f1*\[Alpha]3*\[Gamma]2 + f2*\[Alpha]1*\[Gamma]3 - f1*\[Alpha]2*\[Gamma]3); 
     n = -((1/(a*b*d))*(f3*\[Alpha]2*\[Beta]1 - f2*\[Alpha]3*\[Beta]1 - f3*\[Alpha]1*\[Beta]2 + 
         f1*\[Alpha]3*\[Beta]2 + f2*\[Alpha]1*\[Beta]3 - f1*\[Alpha]2*\[Beta]3)); 
     \[Alpha]0 = a*b*c*l + a*SA - b*n*SB - c*m*SC; 
     \[Beta]0 = a*b*c*m - a*n*SA + b*SB - c*l*SC; 
     \[Gamma]0 = a*b*c*n - a*m*SA - b*l*SB + c*SC; 
     Flatten[{a*\[Alpha]0, b*\[Beta]0, c*\[Gamma]0}]]
Circumcenter[Triangle[{{p1t_, p2t_, p3t_}, {q1t_, q2t_, q3t_}, {r1t_, r2t_, r3t_}}]] := 
  Module[{p1, p2, p3, q1, q2, q3, r1, r2, r3}, 
   {{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}} = ({a, b, c}# & ) /@ 
      {{p1t, p2t, p3t}, {q1t, q2t, q3t}, {r1t, r2t, r3t}}; 
    CircumcenterBarycentric[Triangle[{{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}}]]/{a, b, c}
]

(*
Circumcenter[Triangle[t_?MatrixQ]]:=Center[TrilinearEquation@@Vertices[Triangle[t]]]
*)

CenterFunction[Circumcenter]:=Cos[A]
Name[Circumcenter]:="circumcenter"

CircumcevianTriangle[{\[Alpha]_,\[Beta]_, \[Gamma]_}]:=Triangle[
{{-a \[Beta] \[Gamma],(b \[Gamma]+c \[Beta])\[Beta],(b \[Gamma]+c \[Beta])\[Gamma]},
  {(c \[Alpha]+a \[Gamma])\[Alpha],-b \[Gamma] \[Alpha],(c \[Alpha]+a \[Gamma])\[Gamma]},
  {(a \[Beta]+b \[Alpha])\[Alpha],(a \[Beta]+b \[Alpha])\[Beta],-c \[Alpha] \[Beta]}}
]
(*
CircumcevianTriangle[t_Triangle,tri_List?VectorQ]:=
	Triangle[TrilinearToCartesian[t,#]&/@CircumcevianTriangle[SideLengths[t],tri]]
CircumcevianTriangle[t_Triangle,p_Point]:=CircumcevianTriangle[t,CartesianToTrilinear[t,p]]
CircumcevianTriangle[t_Triangle,ctr_]:=CircumcevianTriangle[SideLengths[t],Trilinears[ctr]]
CircumcevianTriangle[tri_List?VectorQ]:=CircumcevianTriangle[{a,b,c},tri]
*)
CircumcevianTriangle[ctr_]:=CircumcevianTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]

(*
Circumcircle[t_Triangle]:=Circumcircle@@(Vertices[t]) /; Dimensions[t[[1]]]=={3,2}
*)
Circumcircle[t_]:=Circumcircle[Triangle[TrilinearVertexMatrix[t]]] /; MemberQ[Triangles,t]
Circumcircle[Triangle[m_List?MatrixQ]]:=Circle[Center[TrilinearEquation@@m],CircleRadius[Triangle[m]]] /; Dimensions[m]=={3,3}
(*
Circumcircle[eqn_]:=Circle[Center[eqn],CircleRadius[eqn]]
*)

Name[Circumcircle]="circumcircle"
CircleCenterFunction[Circumcircle]:=CenterFunction[Circumcenter]
CircleFunction[Circumcircle]:=0
CircleRadius[Circumcircle]:=Circumradius

Circumcircle[Triangle[{{x1_,y1_},{x2_,y2_},{x3_,y3_}}]]:=Module[
	{
	a=Det[{{x1,y1,1},{x2,y2,1},{x3,y3,1}}],
	d=-1/2 Det[{{x1^2+y1^2,y1,1},{x2^2+y2^2,y2,1},{x3^2+y3^2,y3,1}}],
	f=1/2 Det[{{x1^2+y1^2,x1,1},{x2^2+y2^2,x2,1},{x3^2+y3^2,x3,1}}],
	g=-Det[{{x1^2+y1^2,x1,y1},{x2^2+y2^2,x2,y2},{x3^2+y3^2,x3,y3}}]
	},
	Circle[{-d/a,-f/a},Sqrt[(f^2+d^2)/a^2-g/a]]
]

Name[CircumcircleMidArcTriangle]:="circumcircle mid-arc triangle"
TrilinearVertexMatrix[CircumcircleMidArcTriangle]:={{-a ,b+c,b+c},{a+c,-b,a+c},{a+b,a+b,-c}}

CircumcirclePoint[v_List,a_]:=Point[Circumradius[v]{Cos[a],Sin[a]}+
	Circumcenter[v][[1]]]

Name[CircumMedialTriangle]:="circum-medial triangle"
TrilinearVertexMatrix[CircumMedialTriangle]:={
	{-a*b*c, c*(b^2 + c^2), b*(b^2 + c^2)},
	{c*(a^2 + c^2), -a*b*c, a*(a^2 + c^2)},
	{b*(a^2 + b^2), a*(a^2 + b^2), -a*b*c}
}

Name[CircumnormalTriangle]:="circumnormal triangle"
TrilinearVertexMatrix[CircumnormalTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{Sec[(#3-#2)/3],-Sec[(#2+2#3)/3],-Sec[(#3+2#2)/3]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

Name[CircumOrthicTriangle]:="circum-orthic triangle"
TrilinearVertexMatrix[CircumOrthicTriangle]:={
	{-a Cos[B]Cos[C],(b Cos[B]+c Cos[C])Cos[C],(b Cos[B]+c Cos[C])Cos[B]},
	{(c Cos[C]+a Cos[A])Cos[C],-b Cos[A]Cos[C],(c Cos[C]+a Cos[A])Cos[A]},
	{(a Cos[A]+b Cos[B])Cos[B],(a Cos[A]+b Cos[B])Cos[A],-c Cos[A]Cos[B]}
}

(*
Circumradius[]:=Circumradius[{a,b,c}]
Circumradius[t_Triangle]:=Module[{sides=SideLengths[t],a,b,c},
	{a,b,c}=sides;
 	a b c/Sqrt[(a+b+c)(b+c-a)(c+a-b)(a+b-c)]
]
Circumradius[tri_List?MatrixQ]:=CircleRadius[tri]
Circumradius[{a_,b_,c_}]:=a b c/Sqrt[(a+b+c)(b+c-a)(c+a-b)(a+b-c)]
*)

Name[CircumtangentialTriangle]:="circumtangential triangle"
TrilinearVertexMatrix[CircumtangentialTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{Csc[(#3-#2)/3],Csc[(#2+2#3)/3],-Csc[(#3+2#2)/3]}&@@@
      NestList[RotateLeft,{A,B,C},2]]
(*
CircumtangentialTriangle[t_Triangle]:=
  Triangle[TrilinearToCartesian[t,#]&/@
        Trilinears[CircumtangentialTriangle]/.Thread[{A,B,C}->Angles[t]]]
*)

CenterFunction[ClawsonPoint]:=Tan[A]
Name[ClawsonPoint]:="Clawson point"

(*
Cleavers[t_Triangle]:=Module[
	{i,tri=Vertices@t,c=Coordinates@CleavanceCenter[t],m},
	m=Table[(tri[[i]]+tri[[addn[i,1,3]]])/2,{i,3}];
	Table[
		Line[ShortestLine[{
		{m[[i]],Intersections[Line@{m[[i]],c},Line@{tri[[i]],tri[[addn[i,2,3]]]}]},
		{m[[i]],Intersections[Line@{m[[i]],c},Line@{tri[[addn[i,1,3]]],tri[[addn[i,2,3]]]}]}
		}]],
		{i,3}
	]
]
*)

Cleavers[t_Triangle]:=Module[
	{
      tri=Vertices@t,
      c=Coordinates@CleavanceCenter[t],
      m=Coordinates/@Midpoints[t]
	},
    ShortestLine[{
      {m[[#1]],Coordinates@Intersections[Line@{m[[#1]],c},Line@{tri[[#1]],tri[[#2]]}]},
      {m[[#1]],Coordinates@Intersections[Line@{m[[#1]],c},Line@{tri[[#1]],tri[[#3]]}]}
    }]&@@@NestList[RotateRight,{1,2,3},2]
]

ClosedLine[l_List]:=Line[Append[l,l[[1]]]]

CoaxalCircle[r1_,d1_,d_]:=Circle[{d,0},Sqrt[d^2-2d d1+r1^2]]

CoaxalCircles[r1_,d1_,{a_,b_,step_}]:=
	Table[CoaxalCircle[r1,d1,d],{d,a,b,step}]

(* Collinear *)

CollinearQ[pts_List]:=True /; Length[pts]==2

CollinearQ[{points__Point}]:=Tr[Cross@@Transpose[Coordinates/@{points}]]==0 /;
	Dimensions[Coordinates/@{points}]=={3,2}

CollinearQ[{points__Point}]:=
  CollinearQ[Flatten[{Take[{points},2],#}]]&/@And@@Drop[{points},2]/;
    Length[{points}]>3

CollinearQ[tri_List?MatrixQ]:=Det[tri]==0. /; Dimensions[tri]=={3,3}

CollinearQ[ctr_List?VectorQ]:=CollinearQ[Trilinears/@ctr] /;
	And@@(MemberQ[Centers,#]&/@ctr)

CollinearQ[tri_List?MatrixQ]:=CollinearQ[Append[Take[tri,2],#]]&/@And@@Drop[tri,2]/;
    Length[tri]>3

CollinearQ[tri_List?MatrixQ]:=CollinearQ[Append[Take[tri,2],#]]&/@
	And@@Drop[tri,2] /; Length[tri]>3

TrilinearComplement[{a1_,b1_,g1_}]:={(b b1+c g1)/a,(a a1+c g1)/b,(a a1+b b1)/c}
TrilinearComplement[ctr_]:=TrilinearComplement[Trilinears[ctr]] /; MemberQ[Centers,ctr]
TrilinearComplement[Line[{l_,m_,n_}]]:=Line[
	{a*(-b*c*l + a*c*m + a*b*n), b*(b*c*l - a*c*m + a*b*n), c*(b*c*l + a*c*m - a*b*n)}]
TrilinearComplement[line_]:=TrilinearComplement[Line[line]] /; MemberQ[Lines,line]

(* Complete Quadrilateral *)

CompleteQuadrilateral[q_Quadrilateral]:=Module[{v=Vertices[q]},
	Join[Sides[q],Line/@{v[[{1,3}]],v[[{2,4}]]}]
]

(* ConcurrentQ *)

ConcurrentQ[lines:{TrilinearLine__}]:= Det[First/@lines]==0 /; Length[lines]==3

(* ConcyclicQ *)

Distance2[p__]:=Distance[p]^2
ConcyclicQ[q_Quadrilateral]:=ConcyclicQ[Vertices[q]]
ConcyclicQ[v_List?MatrixQ]:=
	4Distance2@@v[[{1,2}]]Distance2@@v[[{3,4}]]Distance2@@v[[{2,3}]]Distance2@@v[[{4,1}]]-
	(Distance2@@v[[{1,3}]]Distance2@@v[[{2,4}]]-Distance2@@v[[{1,2}]]Distance2@@v[[{3,4}]]+-Distance2@@v[[{2,3}]]Distance2@@v[[{4,1}]])^2==0 /;
	Dimensions[v] == {4, 2}

CenterFunction[CongruentIsoscelizersPoint]:=Cos[B/2]+Cos[C/2]-Cos[A/2]
Name[CongruentIsoscelizersPoint]:="congruent isoscelizers point"

(* Conic *)

cf[{x_,y_},{b_,c_,d_,f_,g_}]:=x^2+2b x y+c y^2+d x+f y+g

Conic[pts_List?MatrixQ,{x_,y_}]:=cf[{x,y},ConicCoefs[pts,{x,y}]] /;
  Dimensions[pts]=={5,2}

Conic[v_List?MatrixQ]:=Module[{aa,bb,gg},
    Evaluate[{aa[#],bb[#],gg[#]}&/@Range[5]]=v;
    {aa[0],bb[0],gg[0]}={\[Alpha],\[Beta],\[Gamma]};
    Det[{aa[#]^2,bb[#]^2,gg[#]^2,bb[#]gg[#],gg[#]aa[#],aa[#]bb[#]}&/@
        Range[0,5]] /; Dimensions[v]=={5,3}
]

ConicCoefs[pts_,{x_,y_}]:=Module[{b,c,d,e,f,g},
	Off[Solve::svars];
	{b,c,d,f,g}/.Solve[cf[#,{b,c,d,f,g}]==0&/@pts,{b,c,d,e,f,g}][[1]]
]

Name[ContactTriangle]:="contact triangle"
TrilinearVertexMatrix[ContactTriangle]:={
{0, 1/(b*(a - b + c)), 1/((a + b - c)*c)},
{1/(a*(-a + b + c)), 0, 1/((a + b - c)*c)}, 
{1/(a*(-a + b + c)), 1/(b*(a - b + c)), 0}}

ConvexPolygon[v_List]:=Polygon[v[[ConvexHull[v]]]]

Name[ConwayCircle]:="Conway circle"
CircleFunction[ConwayCircle]:=a(b+c)/(b c)
CircleCenterFunction[ConwayCircle]:=1
CircleRadius[ConwayCircle]:=Sqrt[Inradius^2+Semiperimeter^2]

Coordinates[point_Point]:=First@point
Coordinates[line_Line]:=First@line
Coordinates[circle_Circle]:=First@circle

CornerCircle[r_?NumberQ,Triangle[{{x1_,y1_},{x2_,y2_},{x3_,y3_}}]]:=Module[
	{x,y},
		Select[Circle[{x,y},r] /.Solve[{
			((y2-y1)(x-x1)-(x2-x1)(y-y1))^2/((x2-x1)^2+(y2-y1)^2)==r^2,
			((y2-y3)(x-x3)-(x2-x3)(y-y3))^2/((x2-x3)^2+(y2-y3)^2)==r^2},
		{x,y}],InteriorQ[Triangle[{{x1,y1},{x2,y2},{x3,y3}}],#[[1]]]&][[1]]
]

CornerCircle[c_Circle,Triangle[v_List],i_:1]:=Module[
	{ex=CornerExcircles[c,Triangle[v[[{i,addn[i,1,3],addn[i,2,3]}]]]]},
	Select[ex,InteriorQ[Triangle[v],#[[1]]]&][[1]]
]

CornerCircles[c_Circle,t_Triangle]:=CornerCircle[c,t,#]&/@Range[3]

internalQ[Circle[{x_,y_},r_],v_]:=Module[{c=Incircle[v]},
	(r<c[[2]])
]

CornerExcircles[Circle[{x0_,y0_},r0_],Triangle[{{x1_,y1_},{x2_,y2_},{x3_,y3_}}]]:=Module[
	{x,y,r},
	Select[Union[
		Circle[Floor[10^5{x,y}]/10.^5,Floor[10^5 Re[r]]/10.^5] /. 
		Solve[{(x-x0)^2+(y-y0)^2==(r0+r)^2,
			((y2-y1)(x-x1)-(x2-x1)(y-y1))^2/((x2-x1)^2+(y2-y1)^2)==r^2,
			((y2-y3)(x-x3)-(x2-x3)(y-y3))^2/((x2-x3)^2+(y2-y3)^2)==r^2},
		{x,y,r}]],
	#[[2]]>0&
	]
]

Name[CosineCircle]:="cosine circle"
CircleFunction[CosineCircle]:=-4b^2c^2Cos[A]/(a^2+b^2+c^2)^2
CircleCenterFunction[CosineCircle]:=a
CircleRadius[CosineCircle]:=a b c/(a^2+b^2+c^2)

CosineHexagon[tri_List]:=Module[{k=SymmedianPoint[tri][[1]]},
	ClosedLine[Flatten[Antiparallels[tri,k] /. Line->Identity,1]]
]

Crossdifference[tri1_?VectorQ,tri2_?VectorQ]:=Cross[tri1,tri2] /;
	Dimensions[{tri1,tri2}]=={2,3}
Crossdifference[ctr1_,ctr2_]:=Crossdifference@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

Crosspoint[{p_,q_,r_},{u_,v_,w_}]:={p u(r v + q w), q v(p w + r u), r w(q u + p v)}
Crosspoint[ctr1_,ctr2_]:=Crosspointe@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

Crosssum[{p_,q_,r_},{u_,v_,w_}]:={q w + r v, r u + p w, p v + q u}
Crosssum[ctr1_,ctr2_]:=Crosspointe@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

CyclicOrder[l_List]:=Module[{c=RotateLeft[l,Position[l,1][[1,1]]-1]},
	If[c[[2]]<c[[6]],
		c,
		RotateRight[Reverse[c],1]
	]
]

CyclicProduct[expr_]:=Times@@CyclicTrilinears[expr]

(* Cyclic Quadrilateral *)

cs[a_]:={Cos[a],Sin[a]}

CyclicQuadrilateral[a_List?VectorQ,r_:1]:=
	Quadrilateral[r{Cos[#],Sin[#]}&/@a] /; Length[a]==4

CyclicQuadrilateralFn[a_List,fn_]:=Module[{i,l=Join[a,a]},
	Table[fn[cs/@Take[l,{i,i+2}]],{i,4}]
]

CyclicQuadrilateralArcMidpoints[a_List]:=Module[{i,l=Append[a,2Pi+a[[1]]]},
	Table[Point[cs[(l[[i]]+l[[i+1]])/2]],{i,4}]
]

CyclicQuadrilateralArcMidpointDiagonals[a_List]:=
	Module[{i,m=Flatten[CyclicQuadrilateralArcMidpoints[a],1,Point]},
	Table[Line[{m[[i]],m[[i+2]]}],{i,2}]
]

CyclicQuadrilateralWithPerpendicularDiagonals[a_List,r_:1]:=
  Module[{v={Cos[#],Sin[#]}&/@a,line},
      line=PerpendicularLine[Point[v[[2]]],Line[Drop[v,{2}]]];
      Quadrilateral@Join[v,Coordinates/@
        Complement[Intersections[Circle[{0,0},r],line],Point/@v,
          SameTest->(Equal@@Coordinates/@Chop[{#1,#2}]&)]
      ]
  ] /; Length[a]==3

ClosedLineDrop[{l_List,r_}]:=ClosedLine[l]

CyclicSum[expr_]:=Plus@@CyclicTrilinears[expr]

CyclicTrilinears[ctr_]:=(ctr/.{a->#1,b->#2,c->#3,A->#4,B->#5,C->#6,
    \[Alpha]->#7,\[Beta]->#8,\[Gamma]->#9,SA->#10,SB->#11,SC->#12,sa->#13,sb->#14,sc->#15})&@@@
    Flatten/@NestList[RotateLeft/@#&,{{a,b,c},{A,B,C},{\[Alpha],\[Beta],\[Gamma]},{SA,SB,SC},{sa,sb,sc}},2]

CyclocevianConjugate[ctr_]:=CyclocevianConjugate[Trilinears[ctr]] /; MemberQ[Centers,ctr]
CyclocevianConjugate[tri:{\[Alpha]_,\[Beta]_,\[Gamma]_}]:=
	CyclicTrilinears[1/(a(\[Gamma]^2\[Alpha]^2+\[Alpha]^2\[Beta]^2-\[Beta]^2\[Gamma]^2)+2\[Alpha] \[Beta] \[Gamma] tri.{a,b,c}Cos[A])]

CyclocevianTriangle[tri:{\[Alpha]_,\[Beta]_,\[Gamma]_}]:=Triangle[{
	{0, (b*(\[Beta]^2*\[Gamma]^2 + \[Alpha]^2*(\[Beta]^2 - \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[B])^(-1), (c*(\[Beta]^2*\[Gamma]^2 + \[Alpha]^2*(-\[Beta]^2 + \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[C])^(-1)}, 
	{(a*(-(\[Beta]^2*\[Gamma]^2) + \[Alpha]^2*(\[Beta]^2 + \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[A])^(-1), 0, (c*(\[Beta]^2*\[Gamma]^2 + \[Alpha]^2*(-\[Beta]^2 + \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[C])^(-1)},
	{(a*(-(\[Beta]^2*\[Gamma]^2) + \[Alpha]^2*(\[Beta]^2 + \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[A])^(-1), (b*(\[Beta]^2*\[Gamma]^2 + \[Alpha]^2*(\[Beta]^2 - \[Gamma]^2)) + 2*\[Alpha]*\[Beta]*\[Gamma]*(a*\[Alpha] + b*\[Beta] + c*\[Gamma])*Cos[B])^(-1), 0}
}]

CyclocevianTriangle[ctr_]:=CyclocevianTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]

Name[DarbouxCubic]:="Darboux cubic"
PivotalIsogonalCubicFunction[DarbouxCubic]:=Cos[A]-Cos[B]Cos[C]

DCPoint[{u_,v_,w_}]:={v w/(b v + c w), w u/(c w + a u), u v/(a u + b v)}

Name[DeLongchampsCircle]:="de Longchamps circle"
CircleFunction[DeLongchampsCircle]:=-a^2/(b c)
CircleCenterFunction[DeLongchampsCircle]:=CenterFunction[DeLongchampsPoint]
CircleRadius[DeLongchampsCircle]:=4Circumradius Sqrt[-Cos[A]Cos[B]Cos[C]]

Name[DeLongchampsEllipse]:="de Longchamps ellipse"
ConicEquation[DeLongchampsEllipse]:=a (\[Alpha]+\[Beta]-\[Gamma]) (\[Alpha]-\[Beta]+\[Gamma])+
    b (\[Alpha]+\[Beta]-\[Gamma])(-\[Alpha]+\[Beta]+\[Gamma])+
    c (\[Alpha]-\[Beta]+\[Gamma])(-\[Alpha]+\[Beta]+\[Gamma])

Name[DeLongchampsLine]:="de Longchamps line"
LineFunction[DeLongchampsLine]:=a^3
CenterLine[X[32]]:=DeLongchampsLine

CenterFunction[DeLongchampsPoint]:=Cos[A]-Cos[B]Cos[C]
Name[DeLongchampsPoint]:="de Longchamps point"

DiagonalMidpoints[v_List /; Length[v]==4]:=Module[{m=Diagonals[v] /. Line->Identity},
	Point/@(Midpoint/@m)
]

DiagonalPoints[q_Quadrilateral]:=Module[{v=Vertices[q]},
    Intersections@@@(Map[
            Line,{#,Complement[Range[4],#]}&/@({1,#}&/@Range[2,4]),{2}]/.n_Integer:>v[[n]])
]

Diagonals[q_Quadrilateral]:=Module[{v=Vertices[q]},
	Line/@{v[[{1,3}]],v[[{2,4}]]}
]

DiagonalTriangle[a_List /; Length[a]==4]:=Module[{i,m,m1243,m3241,p},
	p[i_]:={Cos[a[[i]]],Sin[a[[i]]]};
	m=Intersections@@Table[{Line[p[i]],Line[p[i+2]]},{i,2}];
	m1243=Intersections@@Table[{Line[p[i]],Line[i+1]},{i,1,3,2}];
	m3241=Intersections[Line[{p[1],p[4]}],Line[{p[2],p[3]}]];
	Triangle[{m,m1243,m3241}]
]

(* Distance: line length *)

Distance[Line[l_]]:=Distance@@l /; Dimensions[l]=={2,2}

(* Distance vector-vector *)

Distance[v1_List?VectorQ,v2_List?VectorQ]:=Sqrt[#.#]&[v1-v2] /; Length/@{v1,v2}=={2,2}

(* Distance point-point *)

Distance[p1_Point,p2_Point]:=Distance@@(Coordinates/@{p1,p2})

(* Distance point-line *)

Distance[p_Point,a_List?VectorQ]:=a.Coordinates[p]/Sqrt[#.#&[Drop[a,-1]]] /;
  Length[a]==3

Distance[Point[p_],Line[l_]]:=Module[{x21=Subtract@@l},
	Det[{First[l]-p,x21}]/Sqrt[x21.x21]
]

Distance[l_Line,p_Point]:=Distance[p,l]
Distance[a_List,p_Point]:=Distance[p,a]

(* Distance trilinear-trilinear *)

Distance[v1_List?VectorQ,v2_List?VectorQ]:=Module[{},
	Sqrt[-a b c Times@@@Partition[
		Subtract@@@Transpose[ExactTrilinears/@{v1,v2}],2,1,1
	].RotateRight[{a,b,c}]]/2/Area
] /; Length/@{v1,v2}=={3,3}

Distance[ctr1_,ctr2_]:=Distance@@(Trilinears/@{ctr1,ctr2}) /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

(* Distance trilinear line-trilinear*)

Distance[Line[v1_List?VectorQ,v2_List?VectorQ],v3_List?VectorQ]:=Module[{l,m,n},
	{l,m,n}=Cross[v1,v2];
	{l,m,n}.ExactTrilinears[v3]/Sqrt[l^2+m^2+n^2-2m n Cos[A]-2n l Cos[B]-2l m Cos[C]]
] /; (Length/@{v1,v2})=={3,3}

Distance[v3_List?VectorQ,line:Line[v1_List?VectorQ,v2_List?VectorQ]]:=
	Distance[line,v3] /; (Length/@{v1,v2})=={3,3}

Distance[tri_List?VectorQ,line_TrilinearLine]:=Distance[line,tri] /; Length[tri]==3

Distance[TrilinearLine[{l_,m_,n_}],v3_List?VectorQ]:=
	{l,m,n}.ExactTrilinears[v3]/Sqrt[l^2+m^2+n^2-2m n Cos[A]-2n l Cos[B]-2l m Cos[C]] /;
	Length[v3]==3

Distance[line_,ctr_]:=Distance[TrilinearLine[line],Trilinears[ctr]] /;
	MemberQ[Lines,line] && MemberQ[Centers,ctr]

Distance[ctr_,line_]:=Distance[line,ctr] /;
	MemberQ[Lines,line] && MemberQ[Centers,ctr]

Name[DouCircle]:="Dou circle"
CircleFunction[DouCircle]:=-(a^2 (SA^2 - SB SC) - SA (SB^2 + SC^2)) / (2b c SB SC)
CircleCenterFunction[DouCircle]:=Cos[A]*(-Cos[A]^2 + Cos[B]^2 + Cos[C]^2)
CircleRadius[DouCircle]:=Sqrt[-(c^2*SA^4*SB^4) + SA^3*SB^3*(SA^3 + SB^3) + 32*SA^3*SB^3*SC^3 - 
   b^2*SA^4*SC^4 - a^2*SB^4*SC^4 + SA^3*SC^3*(SA^3 + SC^3) + SB^3*SC^3*(SB^3 + SC^3) +
   SA*SB*SC*(2*(SA^3*SB^3 + SA^3*SC^3 + SB^3*SC^3) - 4*(SA^2*SB^2*(SA^2 + SB^2) +
   SA^2*SC^2*(SA^2 + SC^2) + SB^2*SC^2*(SB^2 + SC^2)) + SA*SB*SC*(11*(c^2*SA*SB +
   b^2*SA*SC + a^2*SB*SC) - 6*(SA^3 + SB^3 + SC^3)) + 3*(SA*SB*(SA^4 + SB^4) +
   SA*SC*(SA^4 + SC^4) + SB*SC*(SB^4 + SC^4)))]/(4*S*SA*SB*SC)

Name[DroussentCubic]:="Droussent cubic"
CubicEquation[DroussentCubic]:=CyclicSum[(b^4+c^4-a^4-b^2c^2)a \[Alpha](b^2 \[Beta]^2-c^2 \[Gamma]^2)]

Name[DrozFarnyCircle[1]]:="first Droz-Farny circle"
CircleFunction[DrozFarnyCircle[1]]:=(a^6 - 3*a^4*b^2 + 3*a^2*b^4 - b^6 - 3*a^4*c^2 + b^4*c^2 + 3*a^2*c^4 + b^2*c^4 - c^6)/(2*b*(a - b - c)*(a + b - c)*c*(a - b + c)*(a + b + c))
CircleCenterFunction[DrozFarnyCircle[1]]:=CenterFunction[Orthocenter]
CircleRadius[DrozFarnyCircle[1]]:=Sqrt[5Circumradius^2-(a^2+b^2+c^2)/2]

Name[DrozFarnyCircle[2]]:="second Droz-Farny circle"
CircleFunction[DrozFarnyCircle[2]]:=((a^2 + b^2 - c^2)*(a^2 - b^2 + c^2)*(-a^2 + b^2 + c^2))/(2*b*(a - b - c)*(a + b - c)*c*(a - b + c)*(a + b + c))
CircleCenterFunction[DrozFarnyCircle[2]]:=CenterFunction[Circumcenter]
CircleRadius[DrozFarnyCircle[2]]:=CircleRadius[DrozFarnyCircle[1]]

DrozFarnyCircumcircle[v_]:=Module[{s=SideLengths[v],R=Circumradius[v]},
	Circle[Circumcenter[v][[1]],Sqrt[5R^2-s.s/2]]
]

DrozFarnyOrthocircle[v_]:=Module[{s=SideLengths[v],R=Circumradius[v]},
	Circle[Orthocenter[v][[1]],Sqrt[5R^2-s.s/2]]
]
	
DrozFarnyVertexCircle[v_,r_]:=Circumcircle[Take[Flatten[DrozFarnyPoints[v,r],1],3]]

DrozFarnyCircumpoints[v_]:=Module[
	{o=Orthocenter[v][[1]],m=MidpointTriangle[v][[1]],r,i},
	r=Table[Sqrt[(m[[i]]-o).(m[[i]]-o)],{i,3}];
	 Table[Intersections[Line[v[[{addn[i,1,3],i}]]],Circle[m[[i]],r[[i]]]],{i,3}]
]

DrozFarnyOrthopoints[v_]:=Module[
	{c=Circumcenter[v][[1]],a=OrthicTriangle[v][[1]],r,i},
	r=Table[Sqrt[(a[[i]]-c).(a[[i]]-c)],{i,3}];
	Table[Intersections[
		Line[v[[{addn[i,2,3],addn[i,1,3]}]]],Circle[a[[i]],r[[i]]]],
	{i,3}]
]

DrozFarnyPoints[v_]:=Module[
	{o=Orthocenter[v][[1]],m=MidpointTriangle[v][[1]],i,s=SideLengths[v],R=Circumradius[v],r},
	r=Sqrt[5R^2-s.s/2];
	Table[Intersections[Line[m[[{i,addn[i,2,3]}]]],Circle[o,r]],{i,3}]
]

DrozFarnyPoints[v_,r_]:=Module[
	{m=MidpointTriangle[v][[1]],i},
	Table[Intersections[Line[m[[{i,addn[i,2,3]}]]],Circle[v[[i]],r]],{i,3}]
]

DrozFarnyLines[v_,r_]:=Module[{p,i,j},
	p=DrozFarnyPoints[v,r];
	Table[Line[{v[[i]],p[[i,j]]}],{i,3},{j,2}]
]

Name[DTriangle]:="D-triangle"
TrilinearVertexMatrix[DTriangle]:={
	{a*Sec[A], 2*c, 2*b},
	{2*c, b*Sec[B], 2*a}, 
	{2*b, 2*a, c*Sec[C]}
}

Name[EhrmannCongruentSquaresPoint]:="Ehrmann congruent squares point"
CenterFunction[EhrmannCongruentSquaresPoint]:=
a/(a-Root[-2*a*Area*b*c + 2*a*Area*b*#1 + 2*a*Area*c*#1 + a^2*b*c*#1 + 2*Area*b*c*#1 + a*b^2*c*#1 + a*b*c^2*#1 - 2*a*Area*#1^2 - a^2*b*#1^2 - 2*Area*b*#1^2 - a*b^2*#1^2 - a^2*c*#1^2 - 2*Area*c*#1^2 - b^2*c*#1^2 - a*c^2*#1^2 - b*c^2*#1^2 + a^2*#1^3 + 2*Area*#1^3 + b^2*#1^3 + c^2*#1^3 &, 1])

Eigencenter[Triangle[{{x1_,y1_,z1_},{x2_,y2_,z2_},{x3_,y3_,z3_}}]]:=Module[{
      s=y3(x1 x2+z1 z2)-y1(x2 x3+z2 z3),
      t=z1(x2 x3+y2 y3)-z2(x1 x3+y1 y3),
      u=z3(x1 x2+y1 y2)-z1(x2 x3+y2 y3),v=y1(x2 x3+z2 z3)-y2(x1 x3+z1 z3)
      },
    CyclicTrilinears[s t-u v]
]

Eigencenter[t_]:=Eigencenter[Triangle[t]]/;MemberQ[Triangles,t]

EllipsePt[{a_,b_},{p_,t_}]:=Module[{tp},
	tp /. FindRoot[
        a^2(Cos[t]-Cos[p])(Cos[tp]-Cos[p])+
		b^2(Sin[t]-Sin[p])(Sin[tp]-Sin[p])==0,{tp,p+Pi}]
]

Ellipse[{a_,b_},t_]:={a Cos[t],b Sin[t]}

EndPoint[Line[l_List]]:=Point[Last[l]]
EndPoint[Line[l__List]]:=Last[{l}]

Name[EppsteinPoint[1]]:="first Eppstein point"
CenterFunction[EppsteinPoint[1]]:=1-2Cos[B/2]Cos[C/2]Sec[A/2]

Name[EppsteinPoint[2]]:="second Eppstein point"
CenterFunction[EppsteinPoint[2]]:=1+2Cos[B/2]Cos[C/2]Sec[A/2]

EqualAngleTicks[t_Triangle,n_:1,r_:.1,dr_:.1,da_:.08,opts___]:=
  EqualAngleTicks[#,n,r,dr,da,opts]&/@NestList[RotateRight,Vertices@t,2]

EqualAngleTicks[l_List,n_:1,r_,dr_,da_,opts___]:=Module[
	{
		i,
		ang=ArcTan@@((unitVector[l[[1]]-l[[2]]]+unitVector[l[[3]]-l[[2]]])/2),
		arc=VertexArc/.{opts}/.Options[EqualAngleTicks]
	},
    {
    	Table[Line[{l[[2]]+(r-dr){Cos[#],Sin[#]},
              l[[2]]+(r+dr){Cos[#],Sin[#]}}]&[ang+i da],{i,-(n-1)/2,(n-1)/2,1}],
		If[arc,VertexArc[l,r],Sequence@@{}]
	}
]

EqualAngleDivisionTicks[l_List,k_,n_,r_,dr_,da_,opts___]:=Module[
	{
		i,
		x1=Unit[l[[1]]-l[[2]]],
		x2=Unit[l[[3]]-l[[2]]],
		x0,dx,
		arc=VertexArc/.{opts}/.Options[EqualAngleTicks]
	},
	x0=l[[2]]+x1;
	dx=(x2-x1)/k;
	{
		EqualAngleTicks[#,n,r,dr,da]&/@Table[{x0+i dx,l[[2]],x0+(i+1)dx},{i,0,k-1}],
		If[arc,VertexArc[l,r],Sequence@@{}]
	}
]

EqualAngleDivisionTicks[p:(_Triangle|_Quadrilateral|_Polygon),k_,r_,dr_,da_,opts___]:=
	Module[
	{
		pairs=Partition[RotateRight[Vertices[p]],3,1,1],
		i,
		arc=VertexArc/.{opts}/.Options[EqualAngleTicks]
	},
    Table[EqualAngleDivisionTicks[pairs[[i]],k,i,r,dr,da,VertexArc->arc],{i,Length[p[[1]]]}]
]

    
CenterFunction[EqualDetourPoint]:=Sec[A/2]Cos[B/2]Cos[C/2]+1
Name[EqualDetourPoint]:="equal detour point"

EqualSideTicks[t_Triangle,n_,len_:.08,off_:.03]:=
	EqualSideTicks[Coordinates[#],n,len,off]&/@Sides[t]

EqualSideTicks[l_List,n_,len_:.08,off_:.03]:=
  Module[{p=PerpendicularUnitVector[l],i,u=Subtract@@l},
    Table[Line[{off i u+#+p len,off i u+#-p len}]&@
        Midpoint[l],{i,-(n-1)/2,(n-1)/2,1}]
]

EqualSideTicksAboutMidpoints[f:(_Triangle|_Quadrilateral),len_:.08,off_:.03]:=
  Module[{sides=Sides[f],i},
    Table[EqualSideTicksAboutMidpoint[sides[[i]],i,len,off],{i,Length[sides]}]
]

EqualSideTicksAboutMidpoint[Line[l_List],n_,len_:.08,off_:.03]:=
  Module[{p=PerpendicularUnitVector[l],i,u=Subtract@@l},
    Table[
      Line[{off i u+#+p len,off i u+#-p len}]&/@(Midpoint[{#,Midpoint[l]}]&/@
            l),{i,-(n-1)/2,(n-1)/2,1}]
]

EquilateralQ[t_Triangle]:=Equal@@SideLengths[t]
EquilateralQ[t_]:=EquilateralQ[Triangle[t]] /; MemberQ[Triangles,t]

EquilateralTriangle[pt_List]:=Module[{vec=pt[[2]]-pt[[1]]},
	pt3={{Cos[Pi/3],Sin[Pi/3]},{-Sin[Pi/3],Cos[Pi/3]}}.vec;
	Triangle[{pt[[1]],pt[[2]],pt[[1]]+pt3}]
]

EquilateralTriangularize[inout_:1,pts_List]:=
  (* +1 = outside, 2 = inside *)
  Module[{orientation=Sign[cross[pts[[2]]-pts[[1]],pts[[3]]-pts[[2]]]],lines},
    lines=Partition[If[orientation==1,pts,Reverse[pts]],2,1,1];
    ({#[[1]],#[[1]]+eqrot[inout].(#[[2]]-#[[1]]),#[[2]]}&/@lines)[[{1,3,2}]]
]

eqrot[s0_]:=Module[{s=(-1)^(s0+1)},
	{{Cos[s Pi/3],Sin[s Pi/3]},{-Sin[s Pi/3],Cos[s Pi/3]}}
]

cross[x1_,x2_]:=x1[[1]]x2[[2]]-x2[[1]]x1[[2]]

ErectPolygon[l_List,n_,sgn_:1]:=Module[{s=Sqrt[#.#]&[l[[2]]-l[[1]]],c,R,r},
    r=s Cot[Pi/n]/2;
    R=s Csc[Pi/n]/2;
    c=(#[[1]]+#[[2]])/2+r sgn unitVector[{{0,-1},{1,0}}.(#[[2]]-#[[1]])]&[l];
    t=ArcTan@@(c-l[[1]]);
    ClosedLine[Table[c+R{Cos[#],Sin[#]}&[2Pi(i+n/2)/n+t],{i,n}]]
]
ErectPolygon[Quadrilateral[l_List],n_,sgn_:1]:=ErectPolygon[l,n,sgn]

ErectPolygons[l_List,n_:3,sgn_:1]:=ErectPolygon[#,n,sgn]&/@Partition[l,2,1,1]
ErectPolygons[Quadrilateral[l_],n_,sgn_:1]:=ErectPolygons[l,n,sgn]
ErectPolygons[t_Triangle,n_:3,sgn_:1]:=
	ClosedLine@@#&/@ErectPolygons[RotateLeft[Vertices[t]],n,-sgn Orientation[t]]

ErectedPolygonCenter[l_,n_,sgn_:1]:=Module[
	{s=Sqrt[#.#]&[l[[2]]-l[[1]]],r},
    r=s Cot[Pi/n]/2;
	(#[[1]]+#[[2]])/2+r sgn unitVector[{{0,-1},{1,0}}.(#[[2]]-#[[1]])]&[l]
]

ErectedPolygonCenters[l_List,n_,sgn_:1]:=ErectedPolygonCenter[#,n,sgn]&/@Partition[l,2,1,1]
ErectedPolygonCenters[Quadrilateral[l_List],n_,sgn_:1]:=ErectedPolygonCenters[l,n,sgn]

ErectScaleneTriangles[v_List,a_List]:=Module[{e=Partition[v,2,1,1]},
    RotateLeft[Triangle/@Append@@@Transpose[
          {e,Intersections@@@Transpose[{
             Line[{First[#],First[#]-RotationMatrix[-First[a]].Subtract@@#}]&/@e,
             Line[{Last[#],Last[#]+RotationMatrix[Last[a]].Subtract@@#}]&/@e
           }]
    }]]
]

ErectScaleneTriangles[v_List,a_?NumericQ]:=ErectScaleneTriangles[v,{a,a}]

Name[EulerGergonneSoddyCircle]:="Euler-Gergonne-Soddy circle"
CircleCenterFunction[EulerGergonneSoddyCircle]:=
(-14*a^9 + 6*a^8*b + 19*a^7*b^2 + 3*a^6*b^3 + 
  3*a^5*b^4 - 21*a^4*b^5 - 7*a^3*b^6 + 9*a^2*b^7 - 
  a*b^8 + 3*b^9 + 6*a^8*c - 17*a^6*b^2*c + 
  15*a^4*b^4*c - 3*a^2*b^6*c - b^8*c + 19*a^7*c^2 - 
  17*a^6*b*c^2 - 30*a^5*b^2*c^2 + 14*a^4*b^3*c^2 + 
  7*a^3*b^4*c^2 + 11*a^2*b^5*c^2 + 4*a*b^6*c^2 - 
  8*b^7*c^2 + 3*a^6*c^3 + 14*a^4*b^2*c^3 - 
  17*a^2*b^4*c^3 + 3*a^5*c^4 + 15*a^4*b*c^4 + 
  7*a^3*b^2*c^4 - 17*a^2*b^3*c^4 - 6*a*b^4*c^4 + 
  6*b^5*c^4 - 21*a^4*c^5 + 11*a^2*b^2*c^5 + 6*b^4*c^5 - 
  7*a^3*c^6 - 3*a^2*b*c^6 + 4*a*b^2*c^6 + 9*a^2*c^7 - 
  8*b^2*c^7 - a*c^8 - b*c^8 + 3*c^9)/a
CircleFunction[EulerGergonneSoddyCircle]:=
-((a - b - c)*(2*a^6 - a^4*b^2 - 2*a^3*b^3 - 
    2*a^2*b^4 + 2*a*b^5 + b^6 + 2*a^3*b^2*c - 
    2*a*b^4*c - a^4*c^2 + 2*a^3*b*c^2 + 4*a^2*b^2*c^2 - 
    b^4*c^2 - 2*a^3*c^3 - 2*a^2*c^4 - 2*a*b*c^4 - 
    b^2*c^4 + 2*a*c^5 + c^6))/
 (4*b*c*(2*a^5 - a^4*b - a^3*b^2 - a^2*b^3 - a*b^4 + 
   2*b^5 - a^4*c + 2*a^2*b^2*c - b^4*c - a^3*c^2 + 
   2*a^2*b*c^2 + 2*a*b^2*c^2 - b^3*c^2 - a^2*c^3 - 
   b^2*c^3 - a*c^4 - b*c^4 + 2*c^5))
CircleRadius[EulerGergonneSoddyCircle]:=
((5*a^5 - 3*a^4*b - 2*a^3*b^2 - 2*a^2*b^3 - 3*a*b^4 + 5*b^5 - 3*a^4*c + 
   6*a^2*b^2*c - 3*b^4*c - 2*a^3*c^2 + 6*a^2*b*c^2 + 6*a*b^2*c^2 - 2*b^3*c^2 - 
   2*a^2*c^3 - 2*b^2*c^3 - 3*a*c^4 - 3*b*c^4 + 5*c^5)*
  Sqrt[a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 + 3*a^2*b^2*c^2 - b^4*c^2 - 
    a^2*c^4 - b^2*c^4 + c^6])/(16*Area*(2*a^5 - a^4*b - a^3*b^2 - a^2*b^3 - 
   a*b^4 + 2*b^5 - a^4*c + 2*a^2*b^2*c - b^4*c - a^3*c^2 + 2*a^2*b*c^2 + 
   2*a*b^2*c^2 - b^3*c^2 - a^2*c^3 - b^2*c^3 - a*c^4 - b*c^4 + 2*c^5))

Name[EulerGergonneSoddyTriangle]:="Euler-Gergonne-Soddy triangle"
TrilinearVertexMatrix[EulerGergonneSoddyTriangle]:=
{{(2*Cos[A/2]^2 - Cos[B/2]^2 - Cos[C/2]^2)*Sec[A/2]^2, 
  (-Cos[A/2]^2 + 2*Cos[B/2]^2 - Cos[C/2]^2)*Sec[B/2]^2, 
  (-Cos[A/2]^2 - Cos[B/2]^2 + 2*Cos[C/2]^2)*Sec[C/2]^2}, 
 {(-2*a^2*Cos[A] + b*(a - b + c)*Cos[B] + (a + b - c)*c*Cos[C])/(2*a), 
  (a*(-a + b + c)*Cos[A] - 2*b^2*Cos[B] + (a + b - c)*c*Cos[C])/(2*b), 
  (a*(-a + b + c)*Cos[A] + b*(a - b + c)*Cos[B] - 2*c^2*Cos[C])/(2*c)}, 
 {Cos[A] - Cos[B]*Cos[C], Cos[B] - Cos[A]*Cos[C], 
  -(Cos[A]*Cos[B]) + Cos[C]}}

(*
EulerLine[t_Triangle,dx1_:1,dx2_:1]:=Module[
	{
	centroid=Coordinates@Centroid[t],
	circumcenter=Coordinates@Circumcenter[t],
	u
	},
	u=unitVector[centroid,circumcenter];
	Line[{circumcenter-dx1 u,circumcenter+dx2 u}]
]
*)

Name[EulerLine]:="Euler line"
LineFunction[EulerLine]:=Cos[A](Cos[B]^2-Cos[C]^2)
CenterLine[X[647]]:=EulerLine

EulerPoints[t_Triangle]:=VertexPoints[EulerTriangle[t]]

Name[EulerTriangle]:="Euler triangle"
TrilinearVertexMatrix[EulerTriangle]:=MapIndexed[
  RotateRight[#1,#2-1]&,{2Tan[#1]+Tan[#2]+Tan[#3],Sin[#1]Sec[#2],
        Sin[#1]Sec[#3]}&@@@NestList[RotateLeft,{A,B,C},2]]

Name[EvansConic]:="Evans conic"
ConicEquation[EvansConic]:=With[
	{
	SA = (1/2)*(-a^2 + b^2 + c^2),
	SB = (1/2)*(a^2 - b^2 + c^2), 
	SC = (1/2)*(a^2 + b^2 - c^2),
	S = 2*Area
	},
	Plus @@ CyclicTrilinears[(SB - SC)^2*(SA^2 - 3*S^2)*(3*SA^2 - S^2)*\[Alpha]^2*a^2 + 
          2*(SA - SB)*(SC - SA)*(3*a^4*SA^2 + (a^2*SA + SB*SC)*(SB^2 + SC^2 - 6*SB*SC))*\[Beta]*\[Gamma]*b*c]
]

Name[EvansPoint]:="Evans point"
CenterFunction[EvansPoint]:=(-2a^2Cos[A]+b(a-b+c)Cos[B]+c(a+b-c)Cos[C])/(2a)

ExactDistance[{aa_,bb_,gg_},{aaa_,bbb_,ggg_}]:=
	Sqrt[a b c(a Cos[A](aa-aaa)^2+b Cos[B](bb-bbb)^2+c Cos[C](gg-ggg)^2)]/(2Area)

ExactTrilinears[]:=ExactTrilinears[{\[Alpha],\[Beta],\[Gamma]}]

ExactTrilinears::ptatinfty = "Expression lies on the line at infinity and so has no exact trilinears."

ExactTrilinears[tri_List?VectorQ]:=Module[{d=tri.{a,b,c}},
	2tri Area/d
] /; Length[tri]==3

ExactTrilinears[t_Triangle,tri_List?VectorQ]:=
	Trilinears[t,2#Area[t]/(#.SideLengths[t])&[tri]] /; Length[tri]==3

ExactTrilinears[ctr_]:=ExactTrilinears[Trilinears[ctr]] /; MemberQ[Centers,ctr]

ExactTrilinears[t_Triangle,ctr_]:=ExactTrilinears[t,Trilinears[ctr]] /; MemberQ[Centers,ctr]

Excenters[t_Triangle]:=Module[
  {
    center1=TrilinearToCartesian[t,{-1,1,1}],
    center2=TrilinearToCartesian[t,{1,-1,1}],
    center3=TrilinearToCartesian[t,{1,1,-1}]
  },
  Point/@{center1,center2,center3}
]

Name[ExcentralHexylEllipse]:="excentral hexyl ellipse"
ConicEquation[ExcentralHexylEllipse]:=
	a*(a + b - c)*(a - b + c)*(b + c)*\[Alpha]^2 + 2*a*b*c*(a + b + c)*\[Alpha]*\[Beta] - 
	b*(a - b - c)*(a + b - c)*(a + c)*\[Beta]^2 + 2*a*b*c*(a + b + c)*\[Alpha]*\[Gamma] +
	2*a*b*c*(a + b + c)*\[Beta]*\[Gamma] - (a + b)*(a - b - c)*c*(a - b + c)*\[Gamma]^2

Name[ExcentralTriangle]:="excentral triangle"
TrilinearVertexMatrix[ExcentralTriangle]:={{-1, 1, 1}, {1, -1, 1}, {1, 1, -1}}

CircleTripletFunction[Excircles]:={{-1,1,1},Sqrt[(a+b-c)(a-b+c)(a+b+c)/(-a+b+c)]/2}

Name[ExcirclesRadicalCircle]:="excircles radical circle"
CircleCenterFunction[ExcirclesRadicalCircle]:=(b+c)/a
CircleFunction[ExcirclesRadicalCircle]:=(a^3-a b^2+2 a b c-a c^2)/(4 a b c)
CircleRadius[ExcirclesRadicalCircle]:= 
  Sqrt[(a^2 b+a b^2+a^2 c+a b c+b^2 c+a c^2+b c^2)/(a+b+c)]/2

CenterFunction[ExeterPoint]:=a(b^4+c^4-a^4)
Name[ExeterPoint]:="Exeter point"

ExmedianPoints[t_Triangle]:=VertexPoints[AnticomplementaryTriangle[t]]
Exmedians[t_Triangle]:=Sides[AnticomplementaryTriangle[t]]

Exradii[t_Triangle]:=Area[t]/(Semiperimeter[t]-#)&/@SideLengths[t]
Exradii[]:=Area/(Semiperimeter-#)&/@{a,b,c}

Name[ExtangentsCircle]:="extangents circle"
CircleCenterFunction[ExtangentsCircle]:=
a^9 + a^8*b - 2*a^7*b^2 - 2*a^6*b^3 + 2*a^3*b^6 + 
 2*a^2*b^7 - a*b^8 - b^9 + a^8*c - 2*a^6*b^2*c - 
 a^5*b^3*c + a^4*b^4*c + 2*a^3*b^5*c - a*b^7*c - 
 2*a^7*c^2 - 2*a^6*b*c^2 + a^4*b^3*c^2 - 2*a^2*b^5*c^2 + 
 2*a*b^6*c^2 + 3*b^7*c^2 - 2*a^6*c^3 - a^5*b*c^3 + 
 a^4*b^2*c^3 + a*b^5*c^3 + b^6*c^3 + a^4*b*c^4 - 
 2*a*b^4*c^4 - 3*b^5*c^4 + 2*a^3*b*c^5 - 2*a^2*b^2*c^5 + 
 a*b^3*c^5 - 3*b^4*c^5 + 2*a^3*c^6 + 2*a*b^2*c^6 + 
 b^3*c^6 + 2*a^2*c^7 - a*b*c^7 + 3*b^2*c^7 - a*c^8 - c^9
CircleRadius[ExtangentsCircle]:=a^2b^2c^2(a b c (a + b + c) + S^2)/(4 (a + b + c) S SA SB SC)
CircleFunction[ExtangentsCircle]:=
(a^6 + a^5*b - a^4*b^2 - 2*a^3*b^3 - a^2*b^4 + a*b^5 + b^6 + a^5*c + a^4*b*c - a^3*b^2*c - 
   a^2*b^3*c - a^4*c^2 - a^3*b*c^2 - a*b^3*c^2 - b^4*c^2 - 2*a^3*c^3 - a^2*b*c^3 - a*b^2*c^3 - 
   a^2*c^4 - b^2*c^4 + a*c^5 + c^6)/((-a^2 + b^2 - c^2)*(a^2 + b^2 - c^2)*(-a^2 + b^2 + c^2))

Name[ExtangentsTriangle]:="extangents triangle"
TrilinearVertexMatrix[ExtangentsTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{-1-Cos[#1],Cos[#1]+Cos[#3],Cos[#1]+Cos[#2]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

ExteriorAngleBisectors[t_Triangle,l_:1]:=Module[
	{
		v=Vertices[t],
		d=l Unit/@RotateLeft[Subtract@@@Partition[Coordinates/@Excenters[t],2,1,1]]
	},
	Line/@Transpose[v+# d&/@{-1,1}]
]

ExteriorAngleBisectorTriangles[t_Triangle]:=Triangle/@Map[
    TrilinearToCartesian[t,#]&,(Join@@@
        Transpose[{List/@NestList[RotateRight,{0,-1,1},2],
            Partition[IdentityMatrix[3],2,1,1]}]),{2}]

ExternalSimilitudeCenter[c__]:=ExternalSimilitudeCenter@@(Circle/@{c}) /;
	And@@(MemberQ[CentralCircles,#]&/@{c})
ExternalSimilitudeCenter[Circle[{p_,q_,r_},rp_],Circle[{x_,y_,z_},rx_]]:=
	((x a + y b + z c) rx {p a, q b, r c} - (p a + q b + r c) rp {x a, y b, z c}) / {a, b, c}
ExternalSimilitudeCenter[c1:Circle[{x1_,y1_},r1_],c2:Circle[alpha2:{x2_,y2_},r2_]]:=Module[
	{rs={r1,r2},ctrs={{x1,y1},{x2,y2}}},
	Point[-Subtract@@(Reverse[rs]ctrs)/Subtract@@rs]]

Name[ExtouchTriangle]:="extouch triangle"
TrilinearVertexMatrix[ExtouchTriangle]:=
	{{0, (a - b + c)/b, (a + b - c)/c},
	{(-a + b + c)/a, 0, (a + b - c)/c},
	{(-a + b + c)/a, (a - b + c)/b, 0}}

CenterFunction[FarOutPoint]:=a(b^4+c^4-a^4-b^2c^2)
Name[FarOutPoint]:="far-out point"

Feet[l_List]:=BeginPoint/@l

Name[FermatAxis]:="Fermat axis"
LineFunction[FermatAxis]:=a(b-c)(b+c)(a^2-b^2-b c-c^2)(a^2-b^2+b c-c^2)
CenterLine[X[526]]:=FermatAxis

CenterFunction[FermatPoint[1]]:=Csc[A+Pi/3]
Name[FermatPoint[1]]:="first Fermat point"

CenterFunction[FermatPoint[2]]:=Csc[A-Pi/3]
Name[FermatPoint[2]]:="second Fermat point"

FermatPointConstruction[n_,Triangle[v_List]]:=
  Module[{t=ErectScaleneTriangles[v,(-1)^(n+1)Pi/3],i,f=FermatPoint[n,v]},
    {RGBColor[0,0,1],t,
      RGBColor[1,0,0],PointSize[.03],f,
      Line/@Map[LongestLine,Transpose[{Last@@@t,v,Table[First@f,{3}]}],{1}],
      GrayLevel[0],Triangle[v]
      }
    ]

Name[FeuerbachHyperbola]:="Feuerbach hyperbola"
CircumconicParameters[FeuerbachHyperbola]:={Cos[B]-Cos[C],Cos[C]-Cos[A],Cos[A]-Cos[B]}

CenterFunction[FeuerbachPoint]:=1-Cos[B-C]
Name[FeuerbachPoint]:="Feuerbach point"

Name[FeuerbachTriangle]:="Feuerbach triangle"
TrilinearVertexMatrix[FeuerbachTriangle]:=MapIndexed[
  RotateRight[#1,#2-1]&,{-Sin[(#2-#3)/2]^2,Cos[(#3-#1)/2]^2,
        Cos[(#1-#2)/2]^2}&@@@NestList[RotateLeft,{A,B,C},2]]

Name[FirstLemoineCircle]:="first Lemoine circle"
CircleFunction[FirstLemoineCircle]:=-b c (b^2+c^2)/(a^2+b^2+c^2)^2
CircleCenterFunction[FirstLemoineCircle]:=a*(a^4 - a^2*b^2 - a^2*c^2 - 2*b^2*c^2)
CircleRadius[FirstLemoineCircle]:=Circumradius Sec[BrocardAngle]/2

Name[FletcherPoint]:="Fletcher point"
CenterFunction[FletcherPoint]:=Sec[A/2]^2(2Cos[A/2]^2-Cos[B/2]^2-Cos[C/2]^2)

CenterFunction[FuhrmannCenter]:=a Cos[A]-(b+c)Cos[B-C]

Name[FuhrmannCircle]:="Fuhrmann circle"
CircleFunction[FuhrmannCircle]:=-2*a*Cos[A]/(a + b + c)
CircleCenterFunction[FuhrmannCircle]:=a Cos[A]-(b+c) Cos[B-C]
CircleRadius[FuhrmannCircle]:=Sqrt[(a^3-a^2*b-a*b^2+b^3-a^2*c+3*a*b*c-b^2*c-a*c^2-b*c^2+c^3)/(a*b*c)]*Circumradius

FuhrmannPoints[v_List]:=Module[
	{a=Altitudes[v] /. Line->Identity,r=Inradius[tri],i},
	Point/@Table[v[[i]]+2r unitVector[a[[i,1]]-a[[i,2]]],{i,3}]
]

Name[FuhrmannTriangle]:="Fuhrmann triangle"
TrilinearVertexMatrix[FuhrmannTriangle] := 
  {{a, (-a^2 + b*c + c^2)/b, (-a^2 + b^2 + b*c)/c}, 
   {(-b^2 + a*c + c^2)/a, b, (a^2 - b^2 + a*c)/c}, 
   {(a*b + b^2 - c^2)/a, (a^2 + a*b - c^2)/b, c}}

Name[GallatlyCircle]:="Gallatly circle"
CircleFunction[GallatlyCircle]:=(b*c*(a^2 + b^2 + c^2)*(a^4 - a^2*b^2 - a^2*c^2 - 2*b^2*c^2))/(4*(a^2*b^2 + a^2*c^2 + b^2*c^2)^2)
CircleCenterFunction[GallatlyCircle]:=a*(b^2 + c^2)
CircleRadius[GallatlyCircle]:=a b c/2/Sqrt[a^2b^2+a^2c^2+b^2c^2]

Name[GEOSCircle]:="GEOS circle"
CircleCenterFunction[GEOSCircle]:=sa/((a-b)(c-a))+(a SA - SB SC)/S^2
CircleFunction[GEOSCircle]:=(a*(a - b - c)*Cos[A])/(2*(a - b)*(a - c))
CircleRadius[GEOSCircle]:=Sqrt[-((6*a^10*b^2 - 12*a^9*b^3 + 12*a^7*b^5 - 12*a^6*b^6 + 12*a^5*b^7 - 12*a^3*b^9 + 6*a^2*b^10 - 
     13*a^10*b*c + 13*a^9*b^2*c + 26*a^8*b^3*c - 26*a^7*b^4*c - 26*a^4*b^7*c + 26*a^3*b^8*c + 
     13*a^2*b^9*c - 13*a*b^10*c + 6*a^10*c^2 + 13*a^9*b*c^2 - 49*a^8*b^2*c^2 + 10*a^7*b^3*c^2 + 
     59*a^6*b^4*c^2 - 78*a^5*b^5*c^2 + 59*a^4*b^6*c^2 + 10*a^3*b^7*c^2 - 49*a^2*b^8*c^2 + 13*a*b^9*c^2 + 
     6*b^10*c^2 - 12*a^9*c^3 + 26*a^8*b*c^3 + 10*a^7*b^2*c^3 - 90*a^6*b^3*c^3 + 66*a^5*b^4*c^3 + 
     66*a^4*b^5*c^3 - 90*a^3*b^6*c^3 + 10*a^2*b^7*c^3 + 26*a*b^8*c^3 - 12*b^9*c^3 - 26*a^7*b*c^4 + 
     59*a^6*b^2*c^4 + 66*a^5*b^3*c^4 - 198*a^4*b^4*c^4 + 66*a^3*b^5*c^4 + 59*a^2*b^6*c^4 - 26*a*b^7*c^4 + 
     12*a^7*c^5 - 78*a^5*b^2*c^5 + 66*a^4*b^3*c^5 + 66*a^3*b^4*c^5 - 78*a^2*b^5*c^5 + 12*b^7*c^5 - 
     12*a^6*c^6 + 59*a^4*b^2*c^6 - 90*a^3*b^3*c^6 + 59*a^2*b^4*c^6 - 12*b^6*c^6 + 12*a^5*c^7 - 
     26*a^4*b*c^7 + 10*a^3*b^2*c^7 + 10*a^2*b^3*c^7 - 26*a*b^4*c^7 + 12*b^5*c^7 + 26*a^3*b*c^8 - 
     49*a^2*b^2*c^8 + 26*a*b^3*c^8 - 12*a^3*c^9 + 13*a^2*b*c^9 + 13*a*b^2*c^9 - 12*b^3*c^9 + 6*a^2*c^10 - 
     13*a*b*c^10 + 6*b^2*c^10)/((a - b)^2*(a - c)^2*(a - b - c)*(b - c)^2*(a + b - c)*(a - b + c)*
     (a + b + c)))]/4


Name[GergonneLine]:="Gergonne line"
LineFunction[GergonneLine]:=a(-a+b+c)
CenterLine[X[55]]:=GergonneLine

CenterFunction[GergonnePoint]:=1/a/(b+c-a)
Name[GergonnePoint]:="Gergonne point"

(* Griffiths Point *)

GriffithsPoint[t_Triangle,v_List,eps_:10^-8]:=Module[
    {i,o=Coordinates@Circumcenter[t],c,n=NinePointCircle[t]},
    c=Table[Circumcircle[PedalTriangle[t,Point[o+(-1)^i v]]],{i,2}];
    Intersection[Sequence@@(Intersections[n,#]&/@c),
        SameTest->(#.#&[Subtract@@(Coordinates/@{#1,#2})]<eps&)
    ][[1]]
]

Name[HalfAltitudeCircle]:="half-altitude circle"
CircleFunction[HalfAltitudeCircle]:=
-((5*a^8 - 8*a^6*b^2 - 6*a^4*b^4 + 16*a^2*b^6 - 7*b^8 - 8*a^6*c^2 + 28*a^4*b^2*c^2 - 16*a^2*b^4*c^2 - 
    4*b^6*c^2 - 6*a^4*c^4 - 16*a^2*b^2*c^4 + 22*b^4*c^4 + 16*a^2*c^6 - 4*b^2*c^6 - 7*c^8)*Sec[A]*
   Sec[B]*Sec[C])/(128*a^2*b^3*c^3)
CircleCenterFunction[HalfAltitudeCircle]:=
(-2*a^10 - a^8*b^2 + 12*a^6*b^4 - 10*a^4*b^6 - 2*a^2*b^8 + 3*b^10 - a^8*c^2 - 16*a^6*b^2*c^2 + 
  10*a^4*b^4*c^2 + 16*a^2*b^6*c^2 - 9*b^8*c^2 + 12*a^6*c^4 + 10*a^4*b^2*c^4 - 28*a^2*b^4*c^4 + 
  6*b^6*c^4 - 10*a^4*c^6 + 16*a^2*b^2*c^6 + 6*b^4*c^6 - 2*a^2*c^8 - 9*b^2*c^8 + 3*c^10)/a
CircleRadius[HalfAltitudeCircle]:=
Sqrt[-(((2*a^6 - 2*a^4*b^2 - 2*a^2*b^4 + 2*b^6 - 3*a^4*c^2 + 6*a^2*b^2*c^2 - 3*b^4*c^2 + c^6)*
     (2*a^6 - 3*a^4*b^2 + b^6 - 2*a^4*c^2 + 6*a^2*b^2*c^2 - 2*a^2*c^4 - 3*b^2*c^4 + 2*c^6)*
     (a^6 - 3*a^2*b^4 + 2*b^6 + 6*a^2*b^2*c^2 - 2*b^4*c^2 - 3*a^2*c^4 - 2*b^2*c^4 + 2*c^6))/
    ((a - b - c)*(a + b - c)*(a - b + c)*(a + b + c)))]/(32*a^2*b^2*c^2*Abs[Cos[A]Cos[B]Cos[C]])

Name[HalfAltitudeTriangle]:="half-altitude triangle"
TrilinearVertexMatrix[HalfAltitudeTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{1,Cos[#3],Cos[#2]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

HalfAngleFormulas[expr_]:=expr/.{
      Csc[x_/2]^n_.:>(2/(1-Cos[x]))^(n/2),
      Cos[x_/2]^n_.:>((1+Cos[x])/2)^(n/2),
      Sec[x_/2]^n_.:>(2/(1+Cos[x]))^(n/2),
      Sin[x_/2]^n_.:>((1-Cos[x])/2)^(n/2),
      Tan[x_/2]:>(1-Cos[x])/Sin[x],
      Cot[x_/2]:>(1+Cos[x])/Sin[x]}

Name[HalfMosesCircle]:="half-Moses circle"
CircleFunction[HalfMosesCircle]:=b c(a^2+b^2+c^2)(3a^4-5a^2b^2-5a^2c^2-8b^2c^2)/16/(a^2b^2+a^2c^2+b^2c^2)^2
CircleCenterFunction[HalfMosesCircle]:=a(b^2+c^2)
CircleRadius[HalfMosesCircle]:=CircleRadius[MosesCircle]/2

HarmonicConjugatePoints[y_ /; 0<y<1]:=Module[{h=.07,x=2y/(y+1)},
	{Line[{{0,0},{1,0}}],
	{PointSize[.05],Point[{0,0}],Point[{y,0}],Point[{x,0}],Point[{1,0}]},
	Text["W",{0,h}],Text["Y",{y,h}],Text["X",{x,h}],Text["Z",{1,h}]
	}
]

HarmonicConjugates[vert_List,tri1_List,tri2_List]:=
  {Point[TrilinearToCartesian[vert,{tri1[[1]]+tri2[[i]],tri1[[2]]+tri2[[2]],tri1[[3]]+tri2[[3]]}]],
   Point[TrilinearToCartesian[vert,{tri1[[1]]-tri2[[i]],tri1[[2]]-tri2[[2]],tri1[[3]]-tri2[[3]]}]]}

Name[HexylCircle]:="hexyl circle"
CircleCenterFunction[HexylCircle]:=1
CircleFunction[HexylCircle]:=-(a^4 - 2*a^3*b + 2*a*b^3 - b^4 - 2*a^3*c - 2*a*b^2*c - 2*a*b*c^2 + 
   2*b^2*c^2 + 2*a*c^3 - c^4)/(4*Area^2)
CircleRadius[HexylCircle]:=2Circumradius

HexylHexagon[t_Triangle]:=ClosedLine[
  Flatten[Transpose[{Vertices[ExcentralTriangle[t]],
        RotateRight[Vertices[HexylTriangle[t]]]}],1]]

Name[HexylTriangle]:="hexyl triangle"
TrilinearVertexMatrix[HexylTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{1+Cos[#1]+Cos[#2]+Cos[#3],-1+Cos[#1]+Cos[#2]-
            Cos[#3],-1+Cos[#1]-Cos[#2]+Cos[#3]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

HomogeneousBarycentrics[ctr_]:={a,b,c}ExactTrilinears[ctr]/2

HomogeneousBarycentrics[t_Triangle,ctr_]:={a,b,c}ExactTrilinears[ctr]/2/.
  Thread[{a,b,c}->SideLengths[Evaluate[t]]]/.Thread[{A,B,C}->Angles[t]]

HomotheticCenter[c:{_Circle,_Circle},sign_:1,t_:0]:=Module[{i},
	x[i_]:=c[[i,1,1]];
	y[i_]:=c[[i,1,2]];
	r[i_]:=c[[i,2]];
	xp[i_]:=x[i]+sign^i r[i]Cos[t];
	yp[i_]:=y[i]+sign^i r[i]Sin[t];

	First[Point[{x,y}] /.
		Solve[{
			y-y[2]==(y[2]-y[1])/(x[2]-x[1])(x-x[2]),
			y-yp[2]==(yp[2]-yp[1])/(xp[2]-xp[1])(x-xp[2])
		},{x,y}]
	]
]

HomotheticCenterPlot[c:{_Circle,_Circle},sign_:1,t_:0,opts___]:=Module[
	{hc=HomotheticCenter[c,sign,t],i,pad=.1},
	
	x[i_]:=c[[i,1,1]];
	y[i_]:=c[[i,1,2]];
	r[i_]:=c[[i,2]];
	xp[i_]:=x[i]+sign^i r[i]Cos[t];
	yp[i_]:=y[i]+sign^i r[i]Sin[t];

	Show[Graphics[{
		Table[Circle@@c[[i]],{i,2}],
(*		Table[Line[{{x[i],y[i]},hc}],{i,2}],
		Table[Line[{{xp[i],yp[i]},hc}],{i,2}], *)
		Table[Line[{{xp[i],yp[i]},{x[i],y[i]}}],{i,2}],
		Line[LongestLine[{{x[1],y[1]},{x[2],y[2]},hc}]],
		Line[LongestLine[{{xp[1],yp[1]},{xp[2],yp[2]},hc}]],
		{PointSize[.04],
		{GrayLevel[.5],Point[hc],Table[Point[{x[i],y[i]}],{i,2}]},
		Table[Point[{xp[i],yp[i]}],{i,2}]}
		}],
		opts,AspectRatio->Automatic,
		PlotRange->{
			{Min[x[1]-r[1],x[2]-r[2],hc[[1]]]-pad,
			Max[x[1]+r[1],x[2]+r[2],hc[[1]]]+pad},
			{Min[y[1]-r[1],y[2]-r[2],hc[[2]]]-pad,
			Max[y[1]+r[1],y[2]+r[2],hc[[2]]]+pad}
		}
	]
]

HomotheticLines[c:{_Circle,_Circle,_Circle},len_:0]:=Module[{i,j,hc,l},
	hc=Coordinates/@Flatten[HomotheticPoints[c]];
	l={longest[hc[[{1,4,5}]]],longest[hc[[{1,3,6}]]],
		longest[hc[[{2,4,6}]]],longest[hc[[{2,3,5}]]]};
	Table[Line[{
		l[[i,1]]+len(l[[i,1]]-l[[i,2]])/Sqrt[(l[[i,1]]-l[[i,2]]).(l[[i,1]]-l[[i,2]])],
		l[[i,2]]-len(l[[i,1]]-l[[i,2]])/Sqrt[(l[[i,1]]-l[[i,2]]).(l[[i,1]]-l[[i,2]])]}],
	{i,4}]
]

HomotheticLinesPlot[c:{_Circle,_Circle,_Circle},opts___]:=Module[{i,j,hc},
	hc=HomotheticPoints[c];
	Show[Graphics[{
		Table[Circle@@c[[i]],{i,3}],
		{PointSize[.02],Point/@hc},
		Line[hc[[{1,4,5}]]],Line[hc[[{1,3,6}]]],
		Line[hc[[{2,4,6}]]],Line[hc[[{2,3,5}]]]
		}],opts,AspectRatio->Automatic,PlotRange->All
	]
]

HomotheticPoints[c:{_Circle,_Circle,_Circle}]:=Module[{i,j,hc,pairs},
	pairs=Flatten[Table[{c[[i]],c[[j]]},{i,3},{j,i+1,3}],1];
	Table[HomotheticCenter[pairs[[i]],(-1)^j,0],{i,3},{j,2}]
]

CenterFunction[Incenter]:=1
Name[Incenter]:="incenter"

IncenterBarycentric[Triangle[{{p1_, p2_, p3_}, {q1_, q2_, q3_}, {r1_, r2_, r3_}}]] := Module[
	{
		SumP = p1 + p2 + p3,
		SumQ = q1 + q2 + q3,
		SumR = r1 + r2 + r3
	},
    ({(p1*#1[[1]])/SumP + (q1*#1[[2]])/SumQ + 
        (r1*#1[[3]])/SumR, (p2*#1[[1]])/SumP + (q2*#1[[2]])/SumQ + 
        (r2*#1[[3]])/SumR, (p3*#1[[1]])/SumP + (q3*#1[[2]])/SumQ + 
        (r3*#1[[3]])/SumR} & )[
     {Sqrt[(((-q2 - q3)*r1 + q1*(r2 + r3))^2*SA + 
         ((-q1 - q3)*r2 + q2*(r1 + r3))^2*SB + (q3*(r1 + r2) - (q1 + q2)*r3)^
           2*SC)/(SumQ*SumR)^2], Sqrt[(((p2 + p3)*r1 - p1*(r2 + r3))^2*SA + 
         ((p1 + p3)*r2 - p2*(r1 + r3))^2*SB + 
         ((-p3)*(r1 + r2) + (p1 + p2)*r3)^2*SC)/(SumP*SumR)^2], 
      Sqrt[(((-p2 - p3)*q1 + p1*(q2 + q3))^2*SA + 
         ((-p1 - p3)*q2 + p2*(q1 + q3))^2*SB + (p3*(q1 + q2) - (p1 + p2)*q3)^2*SC)/(SumP*SumQ)^2]}]
]

Incenter[Triangle[{{p1t_, p2t_, p3t_}, {q1t_, q2t_, q3t_}, {r1t_, r2t_, r3t_}}]] := 
  Module[{p1, p2, p3, q1, q2, q3, r1, r2, r3}, 
   {{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}} = ({a, b, c}# & ) /@ 
      {{p1t, p2t, p3t}, {q1t, q2t, q3t}, {r1t, r2t, r3t}}; 
    IncenterBarycentric[Triangle[{{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}}]]/{a, b, c}
]

Incenter[tri_]:=Incenter[Triangle[tri]] /; MemberQ[Triangles,tri]

Name[IncentralCircle]:="incentral circle"
CircleCenterFunction[IncentralCircle]:=a^5*b + a^4*b^2 - 2*a^3*b^3 - 2*a^2*b^4 + a*b^5 + b^6 + a^5*c - 3*a^3*b^2*c - 2*a^2*b^3*c + 
 2*a*b^4*c + 2*b^5*c + a^4*c^2 - 3*a^3*b*c^2 - 2*a^2*b^2*c^2 - 3*a*b^3*c^2 - b^4*c^2 - 2*a^3*c^3 - 
 2*a^2*b*c^3 - 3*a*b^2*c^3 - 4*b^3*c^3 - 2*a^2*c^4 + 2*a*b*c^4 - b^2*c^4 + a*c^5 + 2*b*c^5 + c^6
CircleFunction[IncentralCircle]:=-(-a^3 - a^2*b + a*b^2 + b^3 - a^2*c + a*b*c + b^2*c + a*c^2 + b*c^2 + c^3)/
 (2*(a^2*b + a*b^2 + a^2*c + 2*a*b*c + b^2*c + a*c^2 + b*c^2))
CircleRadius[IncentralCircle]:=Sqrt[-((a*b*c*(a^3 - a^2*b - a*b^2 + b^3 + a^2*c - 3*a*b*c + b^2*c - a*c^2 - b*c^2 - c^3)*
     (a^3 + a^2*b - a*b^2 - b^3 + a^2*c + 3*a*b*c + b^2*c - a*c^2 + b*c^2 - c^3)*
     (a^3 + a^2*b - a*b^2 - b^3 - a^2*c - 3*a*b*c - b^2*c - a*c^2 + b*c^2 + c^3))/
    ((a - b - c)*(a + b - c)*(a - b + c)*(a + b + c)))]/(2*(a + b)*(a + c)*(b + c))

Name[IncentralTriangle]:="incentral triangle"
TrilinearVertexMatrix[IncentralTriangle]:={{0,1,1},{1,0,1},{1,1,0}}

(* point *)

IncidentCenters[l_List?VectorQ,tri_List?VectorQ,opts___?OptionQ]:=
	IncidentCenters[l,#.#&[Subtract@@@Partition[Divide@@{{\[Alpha],\[Beta],\[Gamma]},tri},2,1,1]]] /;
	Length[tri]===3

(* circle *)

IncidentCenters[l_List?VectorQ,c_,opts___?OptionQ]:=IncidentCenters[l,TrilinearEquation[c],opts] /;
	MemberQ[CentralCircles,c]

(* conics *)

IncidentCenters[l_List?VectorQ,c_,opts___?OptionQ]:=IncidentCenters[l,TrilinearEquation[c],opts] /;
	MemberQ[Conics,c]

(* cubic *)

IncidentCenters[l_List?VectorQ,c_,opts___?OptionQ]:=IncidentCenters[l,TrilinearEquation[c],opts] /;
	MemberQ[TriangleCubics,c]

(* line *)

IncidentCenters[l_List?VectorQ,line_,opts___?OptionQ]:=IncidentCenters[l,TrilinearEquation[line],opts] /;
	MemberQ[Lines,line]

IncidentCenters[l_List?VectorQ,line:Line[{l_,m_,n_}],opts___?OptionQ]:=
	IncidentCenters[l,TrilinearEquation[line],opts]

IncidentCenters[l_List?VectorQ,eqn_,opts___?OptionQ]:=Module[
	{
		t,
		n=MaxIterations/.{opts}/.Options[IncidentCenters],
		(*prec=Tolerance/.{opts}/.Options[IncidentCenters],*)
		dig=WorkingPrecision/.{opts}/.Options[IncidentCenters],
		acc=AccuracyGoal/.{opts}/.Options[IncidentCenters],
		obtuse=ObtuseOnly/.{opts}/.Options[IncidentCenters],
		neqn
	},
	If[obtuse,
		t=Table[RandomTriangle[dig,Type->"Obtuse"],{n}],
	    t=Triangle/@Table[Random[Real,{0,1},dig],{n},{3},{2}]
	];
    l[[Flatten[Position[Function[x,
    	(
    	neqn=eqn /.
			Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[x]] /.
			TriangleRules /.
			Thread[{a,b,c}->SideLengths[Evaluate[#]]] /.
			Thread[{A,B,C}->Angles[#]];
		(*Print[{neqn,Precision[neqn],Accuracy[neqn]}];*)
		(* need neqn===0 case to cover IncidentCenters[{X[1]},{1,1,1}] *)
		(Precision[neqn]==0.||neqn===0) && Accuracy[neqn]>acc
		)&/@(And@@t)]/@l,True]]
	]]
]

Name[Incircle]:="incircle"
CircleFunction[Incircle]:=-((-a+b+c)^2/(4*b*c))
CircleCenterFunction[Incircle]:=1
CircleRadius[Incircle]:=Inradius

Inequalities[p:(_Triangle|_Quadrilateral|_Polygon),{x_,y_}]:=Module[{v=Vertices[p]},
	And@@(#>0&/@Det/@Transpose[{-Orientation[p]Subtract@@@
		Partition[v,2,1,1],{x,y}-#&/@v}])
]

Name[InnerGriffithsPoint]:="inner Griffiths point"
CenterFunction[InnerGriffithsPoint]:=1+8Area/a/(-a+b+c)

Name[InnerNapoleonCircle]:="inner Napoleon circle"
CircleCenterFunction[InnerNapoleonCircle]:=1/a
CircleFunction[OuterNapoleonCircle]:=-(Sqrt[3]S+3SA)/(9b c)
CircleRadius[InnerNapoleonCircle]:=Sqrt[a^2 + b^2 + c^2 - 4*Sqrt[3]Area]/(3*Sqrt[2])

Name[InnerNapoleonTriangle]:="inner Napoleon triangle"
TrilinearVertexMatrix[InnerNapoleonTriangle]:=MapIndexed[
  RotateRight[#1,#2-1]&,{1,2Sin[#3-Pi/6],2Sin[#2-Pi/6]}&@@@
    NestList[RotateLeft,{A,B,C},2]]

Name[InnerRigbyPoint]:="inner Rigby point"
CenterFunction[InnerRigbyPoint]:=1+8/3Area/a/(-a+b+c)

Name[InnerSoddyCenter]:="inner Soddy center (equal detour point)"
CenterFunction[InnerSoddyCenter]:=Sec[A/2]Cos[B/2]Cos[C/2]+1

Name[InnerSoddyCircle]:="inner Soddy circle"
CircleFunction[InnerSoddyCircle]:=With[{
	rA=4Circumradius Sin[A/2]Cos[B/2]Cos[C/2],
	rB=4Circumradius Cos[A/2]Sin[B/2]Cos[C/2],
	rC=4Circumradius Cos[A/2]Cos[B/2]Sin[C/2]
	},
	-((c^2 (b + rB)^2 + b^2 (c + rC)^2 + 2 (b + rB) (c + rC) SA)/
		(rA + rB + rC + 2 Semiperimeter)^2 - (S^2/(4 Semiperimeter (S (Cot[BrocardAngle] - 1) - Semiperimeter^2)))^2)/(b c)
]
(*
(-a+b+c)^2*
	((-15*a^8 - 52*a^7*b + 208*a^6*b^2 - 20*a^5*b^3 - 406*a^4*b^4 + 324*a^3*b^5 + 
      56*a^2*b^6 - 124*a*b^7 + 29*b^8 - 52*a^7*c + 96*a^6*b*c + 276*a^5*b^2*c - 424*a^4*b^3*c - 
      396*a^3*b^4*c + 624*a^2*b^5*c + 44*a*b^6*c - 168*b^7*c + 208*a^6*c^2 + 276*a^5*b*c^2 - 
      388*a^4*b^2*c^2 + 72*a^3*b^3*c^2 - 952*a^2*b^4*c^2 + 612*a*b^5*c^2 + 172*b^6*c^2 - 20*a^5*c^3 - 
      424*a^4*b*c^3 + 72*a^3*b^2*c^3 + 544*a^2*b^3*c^3 - 532*a*b^4*c^3 + 360*b^5*c^3 - 406*a^4*c^4 - 
      396*a^3*b*c^4 - 952*a^2*b^2*c^4 - 532*a*b^3*c^4 - 786*b^4*c^4 + 324*a^3*c^5 + 624*a^2*b*c^5 + 
      612*a*b^2*c^5 + 360*b^3*c^5 + 56*a^2*c^6 + 44*a*b*c^6 + 172*b^2*c^6 - 124*a*c^7 - 168*b*c^7 + 
      29*c^8) - 16*r*s*(5*a^6 - 16*a^5*b - 11*a^4*b^2 + 72*a^3*b^3 - 65*a^2*b^4 + 8*a*b^5 + 7*b^6 - 
       16*a^5*c - 42*a^4*b*c + 56*a^3*b^2*c + 84*a^2*b^3*c - 88*a*b^4*c + 6*b^5*c - 11*a^4*c^2 + 
       56*a^3*b*c^2 - 38*a^2*b^2*c^2 + 80*a*b^3*c^2 - 87*b^4*c^2 + 72*a^3*c^3 + 84*a^2*b*c^3 + 
       80*a*b^2*c^3 + 148*b^3*c^3 - 65*a^2*c^4 - 88*a*b*c^4 - 87*b^2*c^4 + 8*a*c^5 + 6*b*c^5 + 7*c^6))/
    (4*b*c*(a^2 - 2*a*b + b^2 - 2*a*c - 2*b*c + c^2 - 8*r*s)^4)/.{s->Semiperimeter,r->Inradius}
*)
CircleRadius[InnerSoddyCircle]:=4Inradius^2Semiperimeter/(8Inradius Semiperimeter+(2(a b+b c+c a)-(a^2+b^2+c^2)))
CircleCenterFunction[InnerSoddyCircle]:=1+Area/(Semiperimeter-a)/a

InnerSoddyTriangle[t_Triangle]:=
  Triangle[Coordinates[First[Intersections[InnerSoddyCircle[t],#]]]&/@
      TangentCircles[t]]

Name[InnerVectenCircle]:="inner Vecten circle"
CircleCenterFunction[InnerVectenCircle]:=
	(-2*Area*(b^2 + c^2) + 3*a^2*b*c*Cos[A] + 2*a^2*b*c*Cos[B]*Cos[C])/a
CircleFunction[InnerVectenCircle]:=-4*a^3*Area*(Area - 2*b*c*Cos[B - C])
CircleRadius[InnerVectenCircle]:=
Sqrt[-2*a^6 + 3*a^4*b^2 + 3*a^2*b^4 - 2*b^6 + 3*a^4*c^2 + 14*a^2*b^2*c^2 + 3*b^4*c^2 + 3*a^2*c^4 + 
   3*b^2*c^4 - 2*c^6 - 20*Area*(a^2*b^2 + a^2*c^2 + b^2*c^2)]/(Sqrt[2]*Abs[a^2 - 8*Area + b^2 + c^2])

Name[InnerVectenTriangle]:="inner Vecten triangle"
TrilinearVertexMatrix[InnerVectenTriangle]:=
{{a/2, (1/2)*a*(-Cos[C] + Sin[C]), (1/2)*a*(-Cos[B] + Sin[B])}, 
  {(1/2)*b*(-Cos[C] + Sin[C]), b/2, (1/2)*b*(-Cos[A] + Sin[A])}, 
  {(1/2)*c*(-Cos[B] + Sin[B]), (1/2)*c*(-Cos[A] + Sin[A]), c/2}}

(*
Inradius[]:=Inradius[{a,b,c}]
Inradius[t_Triangle]:=Module[{side=SideLengths[t],a,b,c},
	a=side[[1]]; b=side[[2]]; c=side[[3]];
	Sqrt[(b+c-a)(c+a-b)(a+b-c)/(a+b+c)]/2
]
Inradius[abc_List?VectorQ]:=Sqrt[Times@@(abc.#&/@Permutations[{1,1,-1}])/Plus@@abc]/2 /;
	Length[abc]==3
*)

(*
Name[InscribedSquaresCircle[1]]:="inner inscribed squares circle"
CircleCenterFunction[InscribedSquaresCircle[1]]:=
-6*a^10 + 17*a^8*b^2 - 16*a^6*b^4 + 6*a^4*b^6 - 2*a^2*b^8 + b^10 + 17*a^8*c^2 - 16*a^6*b^2*c^2 - 
 22*a^4*b^4*c^2 + 24*a^2*b^6*c^2 - 3*b^8*c^2 - 16*a^6*c^4 - 22*a^4*b^2*c^4 - 44*a^2*b^4*c^4 + 
 2*b^6*c^4 + 6*a^4*c^6 + 24*a^2*b^2*c^6 + 2*b^4*c^6 - 2*a^2*c^8 - 3*b^2*c^8 + c^10 - 
 64*Area^3*(5*a^2*b^2 - b^4 + 5*a^2*c^2 + 2*b^2*c^2 - c^4)
CircleFunction[InscribedSquaresCircle[1]]:=
-(a^8 - 3*a^6*b^2 + 4*a^4*Area*b^2 + 3*a^4*b^4 - 8*a^2*Area*b^4 - a^2*b^6 + 4*Area*b^6 - 
   3*a^6*c^2 + 4*a^4*Area*c^2 + 14*a^4*b^2*c^2 - 15*a^2*b^4*c^2 - 20*Area*b^4*c^2 + 4*b^6*c^2 + 
   3*a^4*c^4 - 8*a^2*Area*c^4 - 15*a^2*b^2*c^4 - 20*Area*b^2*c^4 - 8*b^4*c^4 - a^2*c^6 + 
   4*Area*c^6 + 4*b^2*c^6)/(4*b*c*(a^6 + 2*a^4*Area - a^4*b^2 - 12*a^2*Area*b^2 - a^2*b^4 + 
   2*Area*b^4 + b^6 - a^4*c^2 - 12*a^2*Area*c^2 - 10*a^2*b^2*c^2 - 12*Area*b^2*c^2 - b^4*c^2 - 
   a^2*c^4 + 2*Area*c^4 - b^2*c^4 + c^6))

Name[InscribedSquaresCircle[2]]:="outer inscribed squares circle"
*)

Name[InscribedSquaresTriangle[1]]:="inner inscribed squares triangle"
TrilinearVertexMatrix[InscribedSquaresTriangle[1]]:=
{{a,(SC+S)/b,(SB+S)/c},{(SC+S)/a,b,(SA+S)/c},{(SB+S)/a,(SA+S)/b,c}}

Name[InscribedSquaresTriangle[2]]:="outer inscribed squares triangle"
TrilinearVertexMatrix[InscribedSquaresTriangle[2]]:=
{{a,(SC-S)/b,(SB-S)/c},{(SC-S)/a,b,(SA-S)/c},{(SB-S)/a,(SA-S)/b,c}}

Name[IntangentsCircle]:="intangents circle"
CircleCenterFunction[IntangentsCircle]:=-a^6 + a^4*b^2 + a^2*b^4 - b^6 + 2*a^4*b*c - a^2*b^3*c - b^5*c + a^4*c^2 - 2*a^2*b^2*c^2 + b^4*c^2 - a^2*b*c^3 + 
 2*b^3*c^3 + a^2*c^4 + b^2*c^4 - b*c^5 - c^6
CircleRadius[IntangentsCircle]:=Sqrt[(-a + b + c)(a + b - c)(a - b + c)/(a + b + c)]/(8Abs[Cos[A]Cos[B]Cos[C]])
CircleFunction[IntangentsCircle]:=
((a - b - c)*(a^5 - a^3*b^2 - a^2*b^3 + b^5 + a^3*b*c + a^2*b^2*c - a*b^3*c - b^4*c - a^3*c^2 + a^2*b*c^2 + 2*a*b^2*c^2 - 
   a^2*c^3 - a*b*c^3 - b*c^4 + c^5))/((a^2 - b^2 - c^2)*(a^2 + b^2 - c^2)*(a^2 - b^2 + c^2))

Name[IntangentsTriangle]:="intangents triangle"
TrilinearVertexMatrix[IntangentsTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{1+Cos[#1],Cos[#1]-Cos[#3],Cos[#1]-Cos[#2]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

(* InteriorQ *)

InteriorQ[t_Triangle,p_List]:=Inequalities[t,p]

InternalSimilitudeCenter[c__]:=InternalSimilitudeCenter@@(Circle/@{c}) /;
	And@@(MemberQ[CentralCircles,#]&/@{c})
InternalSimilitudeCenter[Circle[{p_,q_,r_},rp_],Circle[{x_,y_,z_},rx_]]:=
	((x a + y b + z c) rx {p a, q b, r c} + (p a + q b + r c) rp {x a, y b, z c}) / {a, b, c}

InternalSimilitudeCenter[c1:Circle[{x1_,y1_},r1_],c2:Circle[alpha2:{x2_,y2_},r2_]]:=Module[
	{rs={r1,r2},ctrs={{x1,y1},{x2,y2}}},
	Point[Plus@@(Reverse[rs]ctrs)/Plus@@rs]
]

(* Intersections *)

(* circle-circle *)

Intersections[Circle[{x1_,y1_},r1_],Circle[{x2_,y2_},r2_]]:=
  Module[{x,y,soln},
    soln=Solve[{
    	(x-x1)^2+(y-y1)^2==r1^2,
    	(x-x2)^2+(y-y2)^2==r2^2
    },{x,y}];
    If[soln=={},{},Point/@(Chop[#,10^-5]&/@({x,y}/.soln))]
]

(* circle-line *)

Intersections[l:_Line,c:_Circle]:=Intersections[c,l]

Intersections[Circle[{x_,y_},r_],Line[{{x1_,y1_},{x2_,y2_}}]]:=Module[
	{int=Intersections[r,Line[{{x1,y1}-{x,y},{x2,y2}-{x,y}}]]},
	If[int===PointAtInfinity,PointAtInfinity,Point/@({{x,y},{x,y}}+int)]
]

(* what is this? *)

Intersections[r_?NumericQ,Line[{{x1_,y1_},{x2_,y2_}}]]:=Module[
	{
	d=x1 y2-x2 y1,
	dy=y2-y1,
	dx=x2-x1,
	dr,delta,s,
	i
	},
	dr=Sqrt[dx^2+dy^2];
	delta=r^2 dr^2-d^2;
	s=Which[dy>0 || (delta>0 && dy==0),1,dy==0,0,dy<0,-1];
(*	Print[Which[delta>0,"Intersection",delta==0,"Tangent",delta<0,"No Intersection"]]; *)
	If[delta<0,
		PointAtInfinity,
		Table[{
			(d dy+(-1)^i s dx Sqrt[delta])/dr^2,
			(-d dx+(-1)^i Abs[dy] Sqrt[delta])/dr^2
		},{i,0,1}]
	]
]

(* line-line *)

Intersections[Line[{{x1_,y1_},{x2_,y2_}}],Line[{{x3_,y3_},{x4_,y4_}}]]:=Module[
	{
	d=(x1-x2)(y3-y4)-(x3-x4)(y1-y2),
	d12=Det[{{x1,y1},{x2,y2}}],
	d34=Det[{{x3,y3},{x4,y4}}]
	},
	If[NumericQ[d] && d==0.,
		PointAtInfinity,
		Point[{Det[{{d12,x1-x2},{d34,x3-x4}}]/d,Det[{{d12,y1-y2},{d34,y3-y4}}]/d}]
	]
]

Intersections[l1:Line[tri1_List?VectorQ,tri2_List?VectorQ],l2:Line[tri3_List?VectorQ,tri4_List?VectorQ]]:=
	Intersections@@(TrilinearLine/@{l1,l2}) /;
	Equal@@Append[Length/@{tri1,tri2,tri3,tri4},3]

Intersections[TrilinearLine[{l1_,m1_,n1_}],TrilinearLine[{l2_,m2_,n2_}]]:=
	{m1 n2-n1 m2,l2 n1-l1 n2,l1 m2-l2 m1}

Intersections[line1_,line2_]:=Intersections@@(TrilinearLine/@{line1,line2}) /;
	And@@(MemberQ[Lines,#]&/@{line1,line2})

(* line-line-line *)

Intersections[TrilinearLine[{l1_,m1_,n1_}],TrilinearLine[{l2_,m2_,n2_}],TrilinearLine[{l3_,m3_,n3_}]]:=
	Det/@Partition[RotateLeft[Transpose[Cross@@@{{l1,m1,n1},{l2,m2,n2},{l3,m3,n3}}]],2,1,1]

(* what is this? *)

Intersections[eqn_,{{a1_,b1_,c1_},{a2_,b2_,c2_}}]:=Module[{l,m,n},
	{l,m,n}=Coefficient[eqn,#]&/@{\[Alpha],\[Beta],\[Gamma]};
	{(a2 b1+a1 b2) m+(-a2 c1+a1 c2) n,(a2 b1-a1 b2) l+(-b2 c1+b1 c2) n,(a2 c1-
          a1 c2) l+(b2 c1-b1 c2) m}
]

(* inverse circles *)

InverseCircles[k_,{{x_,y_},a_},steps_:1,da_:0.1,opts___]:=Module[
	{i,
	pts=InverseCirclePts[k,{{x,y},a},steps,0],
	ptsoff=InverseCirclePts[k,{{x,y},a},steps,da]},
	Graphics[{
		Circle[{x,y},a],
		InverseCircle[k,{{x,y},a}],
		{RGBColor[1,0,0],PointSize[.03],Point[{0,0}]},
		{PointSize[.04],Table[{Point[pts[[i,1]]],Point[pts[[i,2]]]},{i,steps}]},
		{Dashing[{.02,.02}],RGBColor[1,0,0],Circle[{0,0},k]},
		Table[{Text[ToString[i],ptsoff[[i,1]]],Text[ToString[i],ptsoff[[i,2]]]},
			{i,steps}]
	}]
]

InverseCirclePts[k_,Circle[{x_,y_},a_],steps_:10,da_:0.1]:=Module[{i},
	Table[{{x+(a+da)Cos[2Pi i/steps],y+(a+da)Sin[2Pi i/steps]},
		InversePoint[Circle[{0,0},k],Line@{x+(a+da)Cos[2Pi i/steps],
    y+(a+da)Sin[2Pi i/steps]}]},{i,steps}]
]

Invert[Circle[{x_,y_},a_],Circle[{x0_,y0_},k_]]:=Module[
	{s=k^2/((x-x0)^2+(y-y0)^2-a^2)},
	Circle[{x0,y0}+s{(x-x0),(y-y0)},Abs[s a]]
]

(*
InverseCircle[k_,Circle[{x_,y_},a_]]:=Module[
	{s=k^2/(x^2+y^2-a^2)},
	Circle[s{x,y},Abs[s a]]
]

InverseCircle[k_,{{x_,y_},a_}]:=Module[
	{s=k^2/(x^2+y^2-a^2)},
	Circle[s{x,y},Abs[s a]]
]
*)

Invert[l_Line,c_Circle,opts___]:=Module[
	{steps=Divisions/.{opts}/.Divisions->50},
	Map[Invert[#,c]&,BrokenLine[First[l],steps],{2}]
]

Invert[Point[x_List],Circle[x0_List,k_]]:=
	Point[x0+k^2(x-x0)/(x-x0).(x-x0)]

Invert[p_Polygon,c_Circle,opts___]:=Module[
	{steps=Divisions/.{opts}/.Divisions->50},
	Map[Invert[#,c]&,BrokenPolygon[First[p],steps],{2}]
]

Invert[x_List,Circle[x0_List,k_]]:=x0+k^2(x-x0)/(x-x0).(x-x0) /;
	Dimensions[x]=={2}

InversePoint[t_Triangle,p_Point]:=InversePoint[Circumcircle[t],p]

InversePoint[{x0_,y0_,z0_},Circle[ctr:{xc_,yc_,zc_},radius_]]:=Module[{pa,pb,pc},
	{pa,pb,pc}=(Distance[#,ctr]^2-radius^2)&/@IdentityMatrix[3];
	{
	xc/(a*xc+b*yc+c*zc)+radius^2*x0*(a*x0+b*y0+c*z0)/((a*x0+b*y0+c*z0)*(pa*a*x0+pb*b*y0+pc*c*z0)-a*b*c*(a*y0*z0+b*z0*x0+c*x0*y0)),
	yc/(a*xc+b*yc+c*zc)+radius^2*y0*(a*x0+b*y0+c*z0)/((a*x0+b*y0+c*z0)*(pa*a*x0+pb*b*y0+pc*c*z0)-a*b*c*(a*y0*z0+b*z0*x0+c*x0*y0)),
	zc/(a*xc+b*yc+c*zc)+radius^2*z0*(a*x0+b*y0+c*z0)/((a*x0+b*y0+c*z0)*(pa*a*x0+pb*b*y0+pc*c*z0)-a*b*c*(a*y0*z0+b*z0*x0+c*x0*y0))
	}
]

InversePoint[{x0_,y0_,z0_},circ_]:=InversePoint[{x0,y0,z0},Circle[circ]] /; MemberQ[CentralCircles,circ]
InversePoint[ctr_,circ_]:=InversePoint[Trilinears[ctr],Circle[circ]] /; MemberQ[CentralCircles,circ] && MemberQ[Centers,ctr]
InversePoint[ctr_,c:Circle[{xc_,yc_,zc_},radius_]]:=InversePoint[Trilinears[ctr],c] /; MemberQ[Centers,ctr]

Invert[l_,c:_Circle,opts___]:=DeleteCases[
	l/.{
      Point[p_List]:>Invert[Point[p],c],
      Line[p_List]:>Invert[Line[p],c,opts],
      Polygon[p_List]:>Invert[Polygon[p],c,opts],
      Circle[v_List,r_]:>Invert[Circle[v,r],c,opts]
	},
	{Indeterminate,Indeterminate},{1,Infinity}
	]

Isoconjugate[{p_,q_,r_},{u_,v_,w_}]:={q r v w, r p w u, p q u v}

CenterFunction[IsodynamicPoint[1]]:=Sin[A+Pi/3]
Name[IsodynamicPoint[1]]:="first isodynamic point"

CenterFunction[IsodynamicPoint[2]]:=Sin[A-Pi/3]
Name[IsodynamicPoint[2]]:="second isodynamic point"

IsodynamicPoints[t_Triangle]:=IsodynamicPoint[#][t]&/@Range[2]

IsogonalConjugate[tri_List?VectorQ]:=1/tri /; Length[tri]==3
IsogonalConjugate[ctr_]:=1/Trilinears[ctr] /; MemberQ[Centers,ctr]

(*
IsogonalConjugate[t_Triangle,tri_List]:=
	Point[TrilinearToCartesian[t,1/tri]] /; Length[tri]==3
IsogonalConjugate[t_Triangle,pt_Point]:=
	IsogonalConjugate[t,CartesianToTrilinear[t,pt]]
*)

CenterFunction[IsogonalMittenpunkt]:=1/(-a+b+c)
Name[IsogonalMittenpunkt]:="isogonal mittenpunkt"

CenterFunction[IsoperimetricPoint]:=Sec[A/2]Cos[B/2]Cos[C/2]-1
Name[IsoperimetricPoint]:="isoperimetric point"

IsoscelesQ[t_Triangle]:=Or@@(Equal@@@Partition[SideLengths[t],2,1,1])
IsoscelesQ[t_]:=IsoscelesQ[Triangle[t]] /; MemberQ[Triangles,t]

(* rewrite *)
Isoscelizers[v_List,x_List /; Length[x]==2]:=Module[{i,j,s,u,l},
	s=Table[{v[[addn[i,1,3]]]-v[[i]],v[[addn[i,2,3]]]-v[[i]]},{i,3}];
	u=Table[s[[i,j]]/Sqrt[s[[i,j]].s[[i,j]]],{i,3},{j,2}];
	l=Table[((x[[1]]-v[[i,1]])(u[[i,2,2]]-u[[i,1,2]])-(x[[2]]-v[[i,2]])(u[[i,2,1]]-u[[i,1,1]]))/
		(u[[i,1,1]]u[[i,2,2]]-u[[i,2,1]]u[[i,1,2]]),
	{i,3}];
	(* Print[Table[Sqrt[((v[[i]]+l[[i]] u[[i,1]])-(v[[i]]+l[[i]]u[[i,2]])).
		((v[[i]]+l[[i]] u[[i,1]])-(v[[i]]+l[[i]]u[[i,2]]))],{i,3}]]; *)
	Table[Line[{v[[i]]+l[[i]] u[[i,1]],v[[i]]+l[[i]]u[[i,2]]}],{i,3}]
]

Isoscelizers[t_Triangle,l_List]:=Module[{u=Unit/@SideVectors[t],vert=Vertices[t],i},
	Table[Line[{vert[[i]]+l[[i]]u[[addn[i,2,3]]],vert[[i]]-l[[i]]u[[addn[i,1,3]]]}],{i,3}]
]

IsotomicConjugate[ctr_]:=1/({a^2,b^2,c^2}Trilinears[ctr]) /; MemberQ[Centers,ctr]
IsotomicConjugate[tri_?VectorQ]:=1/({a^2,b^2,c^2}tri) /; Length[tri]==3

(*
IsotomicConjugate[t_Triangle,tri_List]:=Module[{side=SideLengths[t]},
	Point[TrilinearToCartesian[t,Table[1/(side[[i]]^2 tri[[i]]),{i,3}]]]
]
IsotomicConjugate[t_Triangle,p_Point]:=
	IsotomicConjugate[t,CartesianToTrilinear[t,Coordinates@p]]
*)

(* rewrite *)
IsotomicPoints[tri_List,ctr_List]:=Module[{cev={},d={},unitvec=SideUnitVectors[tri],i},
	cev=Take[CevianTriangle[tri,ctr][[1]],3];
	d=Table[Distance[cev[[i]],tri[[Sub1[i]]]],{i,1,3}];
	Map[Point,Table[tri[[Add1[i]]]+d[[i]]unitvec[[i]],{i,1,3}]]
]

IsotomicLines[tri_List,ctr_List]:=Module[{isopt=IsotomicPoints[tri,ctr]},
	Table[Line[{tri[[i]],isopt[[i,1]]}],{i,1,3}]
]

Name[JerabekHyperbola]:="Jerabek hyperbola"
CircumconicParameters[JerabekHyperbola]:={a(Sin[2B]-Sin[2C]),b(Sin[2C]-Sin[2A]),c(Sin[2A]-Sin[2B])}

CircleTripletFunction[JohnsonCircles]:={{-a b c SA,c(S^2+SC SA),b(S^2+SA SB)},Circumradius}

Name[JohnsonCircumconic]:="Johnson circumconic"
CircumconicParameters[JohnsonCircumconic]:={a Cos[A]Cos[B-C],b Cos[B]Cos[A-C],c Cos[C]Cos[A-B]}

Name[JohnsonTriangle]:="Johnson triangle"
TrilinearVertexMatrix[JohnsonTriangle]:=
{{-(a*b*c*SA), c*(S^2 + SA*SC), b*(S^2 + SA*SB)}, {c*(S^2 + SB*SC), -(a*b*c*SB), 
  a*(S^2 + SA*SB)}, {b*(S^2 + SB*SC), a*(S^2 + SA*SC), -(a*b*c*SC)}}

Name[JohnsonTriangleCircumcircle]:="Johnson triangle circumcircle"
CircleFunction[JohnsonTriangleCircumcircle]:=-(a^2*(-a^2 + b^2 - b*c + c^2)*(-a^2 + b^2 + b*c + c^2))/(16*Area^2*b*c)
CircleCenterFunction[JohnsonTriangleCircumcircle]:=Sec[A]
CircleRadius[JohnsonTriangleCircumcircle]:=Circumradius

Name[JohnsonYffCircle[1]]:="first Johnson-Yff circle"
CircleCenterFunction[JohnsonYffCircle[1]]:=1+2Cos[B]Cos[C]
CircleRadius[JohnsonYffCircle[1]]:=Circumradius Inradius/(Circumradius+Inradius)
CircleFunction[JohnsonYffCircle[1]]:=
(a*(a - b - c)^2*(a^6 + a^5*b - 2*a^4*b^2 - 2*a^3*b^3 + a^2*b^4 + a*b^5 + a^5*c + 4*a^4*b*c - 
   6*a^2*b^3*c - a*b^4*c + 2*b^5*c - 2*a^4*c^2 + 5*a^2*b^2*c^2 - a*b^3*c^2 - 4*b^4*c^2 - 
   2*a^3*c^3 - 6*a^2*b*c^3 - a*b^2*c^3 + 4*b^3*c^3 + a^2*c^4 - a*b*c^4 - 4*b^2*c^4 + a*c^5 + 
   2*b*c^5))/(b*c*(a + b + c)*(a^3 - a^2*b - a*b^2 + b^3 - a^2*c - b^2*c - a*c^2 - b*c^2 + c^3)^2)

Name[JohnsonYffCircle[2]]:="second Johnson-Yff circle"
CircleCenterFunction[JohnsonYffCircle[2]]:=1-2Cos[B]Cos[C]
CircleRadius[JohnsonYffCircle[2]]:=Circumradius Inradius/(Circumradius-Inradius)
CircleFunction[JohnsonYffCircle[2]]:=
(a*(a - b - c)*(a^6 - a^5*b - 2*a^4*b^2 + 2*a^3*b^3 + a^2*b^4 - a*b^5 - a^5*c + 4*a^4*b*c - 
   6*a^2*b^3*c + a*b^4*c + 2*b^5*c - 2*a^4*c^2 + 5*a^2*b^2*c^2 + a*b^3*c^2 - 4*b^4*c^2 + 
   2*a^3*c^3 - 6*a^2*b*c^3 + a*b^2*c^3 + 4*b^3*c^3 + a^2*c^4 + a*b*c^4 - 4*b^2*c^4 - a*c^5 + 
   2*b*c^5))/(b*c*(a^3 - a^2*b - a*b^2 + b^3 - a^2*c + 4*a*b*c - b^2*c - a*c^2 - b*c^2 + c^3)^2)

Name[KenmotuCircle]:="Kenmotu circle"
CircleFunction[KenmotuCircle]:=-((b*c*(a^6 - 3*a^4*b^2 + a^2*b^4 + b^6 - 3*a^4*c^2 - 4*a^2*b^2*c^2 + b^4*c^2 + a^2*c^4 + 
    b^2*c^4 + c^6 + 4*Area*(a^4 + 2*a^2*b^2 - b^4 + 2*a^2*c^2 - c^4)))/(a^4 + b^4 + c^4)^2)
CircleRadius[KenmotuCircle]:=Circumradius Sin[BrocardAngle]/Sin[BrocardAngle+Pi/4]
CircleCenterFunction[KenmotuCircle]:=Cos[A]+Sin[A]

Name[KenmotuPoint]:="Kenmotu point"
CenterFunction[KenmotuPoint]:=Cos[A]+Sin[A]

KenmotuSquares[t_Triangle]:=Module[{i,k=KenmotuPoint[t],pos,pairs},
    i=Flatten[Intersections[KenmotuCircle[t],#]&/@Sides[t]];
    pos=Flatten[
        Position[
          Chop[Dot@@@
              Map[#-Coordinates[k]&,pairs=Subsets[Coordinates/@i,{2}],{2}]],
          0]];
    Polygon/@({Coordinates[k],#[[1]],
              Coordinates[Reflection[k,Line[#]]],#[[2]]}&/@pairs[[pos]])
]

Name[KiepertHyperbola]:="Kiepert hyperbola"
CircumconicParameters[KiepertHyperbola]:={Sin[B-C],Sin[C-A],Sin[A-B]}

Name[KiepertParabola]:="Kiepert parabola"
InconicParameters[KiepertParabola]:={a(b^2-c^2),b(c^2-a^2),c(a^2-b^2)}

CenterFunction[KiepertParabolaFocus]:=Csc[B-C]
Name[KiepertParabolaFocus]:="focus of the Kiepert parabola"

kdata=SetPrecision[KimberlingCoordinates,12];
KimberlingLookup[tri_List?VectorQ]:=
  Module[{x=ToSidelengths[tri]/.{a->6`20,b->9`20,c->13`20},kx,denom},
  	denom=x.{6`20,9`20,13`20};
  	(*
  	note: this test can fail for hidden zeros such as 
  	(ToSidelengths[X[511][AnticomplementaryTriangle]]/.{a->6,b->9,c->13}).{6,9,13}
    *)
  	kx=If[denom==0.,Plus@@(1/x),8Sqrt[35]/denom]x[[1]];
    Flatten[Position[kdata,_?(#==kx&)]]
] /; Length[tri]==3

(*
KimberlingCenters=Select[Centers,Head[#]===X&&!StringQ[CenterFunction[#]]&]
*)

Name[KosnitaPoint]:="Kosnita point"
CenterFunction[KosnitaPoint]:=Sec[B-C]

KSection[{{a1_,b1_,g1_},{a2_,b2_,g2_}},n_]:={
    n a a1 a2+b(a2 b1+a1 b2(n-1))+c(a2 g1+a1 g2(n-1)),
    a(a2 b1(n-1)+a1 b2)+n b b1 b2+c(b2 g1+b1 g2(n-1)),
    a(a2 g1(n-1)+a1 g2)+b(b2 g1(n-1)+b1 g2)+n c g1 g2
}

Name[LemoineCubic]:="Lemoine cubic"
CubicEquation[LemoineCubic]:=CyclicSum[a^4(b^2+c^2-a^2)b \[Beta] c \[Gamma](b \[Beta]-c \[Gamma])]+
	2(a^2-b^2)(b^2-c^2)(c^2-a^2)a \[Alpha] b \[Beta] c \[Gamma]

Name[LemoineInellipse]:="Lemoine inellipse"
InconicParameters[LemoineInellipse]:={(-a^2 + 2*(b^2 + c^2))/(b*c), (2*a^2 - b^2 + 2*c^2)/
   (a*c), (2*(a^2 + b^2) - c^2)/(a*b)}

Name[LemoineAxis]:="Lemoine axis"
LineFunction[LemoineAxis]:=b c
CenterLine[X[2]]:=LemoineAxis

Name[LemoineTriangle]:="Lemoine triangle"
TrilinearVertexMatrix[LemoineTriangle]:=
{{0, (a*c)/(-2*a^2 + b^2 - 2*c^2), (a*b)/(-2*a^2 - 2*b^2 + c^2)}, 
 {(b*c)/(a^2 - 2*b^2 - 2*c^2), 0, (a*b)/(-2*a^2 - 2*b^2 + c^2)}, 
 {(b*c)/(a^2 - 2*b^2 - 2*c^2), (a*c)/(-2*a^2 + b^2 - 2*c^2), 0}}

Name[LesterCircle]:="Lester circle"
CircleFunction[LesterCircle]:=
	-((a^6-3a^4b^2+3a^2b^4-b^6-3a^4c^2-a^2b^2c^2+b^4c^2+3a^2c^4+b^2c^4-c^6)*
	Circumradius^2(1+2Cos[2A]))/(6a^2*(a-b)b(a+b)(a-c)c(a+c))
CircleRadius[LesterCircle]:=Sqrt[a^16 - 5*a^14*b^2 + 10*a^12*b^4 - 11*a^10*b^6 + 10*a^8*b^8 - 11*a^6*b^10 + 10*a^4*b^12 - 
   5*a^2*b^14 + b^16 - 5*a^14*c^2 + 19*a^12*b^2*c^2 - 27*a^10*b^4*c^2 + 13*a^8*b^6*c^2 + 
   13*a^6*b^8*c^2 - 27*a^4*b^10*c^2 + 19*a^2*b^12*c^2 - 5*b^14*c^2 + 10*a^12*c^4 - 27*a^10*b^2*c^4 + 
   33*a^8*b^4*c^4 - 23*a^6*b^6*c^4 + 33*a^4*b^8*c^4 - 27*a^2*b^10*c^4 + 10*b^12*c^4 - 11*a^10*c^6 + 
   13*a^8*b^2*c^6 - 23*a^6*b^4*c^6 - 23*a^4*b^6*c^6 + 13*a^2*b^8*c^6 - 11*b^10*c^6 + 10*a^8*c^8 + 
   13*a^6*b^2*c^8 + 33*a^4*b^4*c^8 + 13*a^2*b^6*c^8 + 10*b^8*c^8 - 11*a^6*c^10 - 27*a^4*b^2*c^10 - 
   27*a^2*b^4*c^10 - 11*b^6*c^10 + 10*a^4*c^12 + 19*a^2*b^2*c^12 + 10*b^4*c^12 - 5*a^2*c^14 - 
   5*b^2*c^14 + c^16]*Circumradius^2*Sqrt[1 - 8*Cos[A]*Cos[B]*Cos[C]]/
 (6*a*b*(a + b)*c*(a + c)*(b + c)*Abs[(a - b)*(a - c)*(b - c)])
CircleCenterFunction[LesterCircle]:=b*c*(b^2-c^2)*(a^4+b^4+c^4+(3*a^2*b^2*c^2*(2*a^2-b^2-c^2))/((a+b-c)*(a-b+c)*(-a+b+c)*(a+b+c))+2*(a^2-b^2)*(-a^2+c^2)-a^2*(a^2+b^2+c^2))

LimitingPoints[d_,r_,R_]:=(d^2-r^2+R^2+{1,-1}Sqrt[(d^2-r^2+R^2)^2-4d^2 R^2])/(2d)

Name[LineAtInfinity]:="line at infinity"
LineFunction[LineAtInfinity]:=a
CenterLine[X[6]]:=LineAtInfinity

longest[l_List]:=Module[{len=Length[l],d,i,j},
	d=Flatten[Table[(l[[i]]-l[[j]]).(l[[i]]-l[[j]]),{i,len},{j,i+1,len}],1];
	Sort[Switch[Position[d,Max[d]][[1,1]],
		1,{l[[1]],l[[2]]},
		2,{l[[1]],l[[3]]},
		3,{l[[2]],l[[3]]}]
	]
]

LongestLine::noncol = "Specified points are not collinear.";

LongestLine[allp_List,dr_:0,opts___?OptionQ]:=
	Message[LongestLine::noncol] /; !CollinearQ[Point/@allp,opts]

LongestLine[allp_List,dr_:0,opts___?OptionQ]:=Module[
	{len,m,i,j,p=Select[allp,Im[#]=={0,0}&],v},
	If[p=={},
		LineAtInfinity,
	(* Else *)
		len=Flatten[
			Table[(p[[i]]-p[[j]]).(p[[i]]-p[[j]]),{i,Length[p]},{j,i+1,Length[p]}]];
		m=Position[len,Max[len]][[1,1]];
(*		Print[len,m]; *)
		v=Part[Flatten[Table[{p[[i]],p[[j]]},{i,Length[p]},{j,i+1,Length[p]}],1],m];
		Line[{v[[1]]-#,v[[2]]+#}]&[dr unitVector@@v]
	]
]

Name[LonguetHigginsCircle]:="Longuet-Higgins circle"
CircleFunction[LonguetHigginsCircle]:=-(b+c)^2/(b c)
CircleCenterFunction[LonguetHigginsCircle]:=(a^4 + 2*a^3*b - 2*a*b^3 - b^4 + 2*a^3*c - 4*a^2*b*c + 
  2*a*b^2*c + 2*a*b*c^2 + 2*b^2*c^2 - 2*a*c^3 - c^4)/a
CircleRadius[LonguetHigginsCircle]:=Sqrt[16 Circumradius^2 - (a + b + c)^2 ]

Name[LucasCentralCircle]:="Lucas central circle"
CircleCenterFunction[LucasCentralCircle]:=
-(a*(5*a^8 - 14*a^6*b^2 + 4*a^4*b^4 + 10*a^2*b^6 - 5*b^8 - 14*a^6*c^2 - 24*a^4*b^2*c^2 + 54*a^2*b^4*c^2 - 4*b^6*c^2 + 4*a^4*c^4 + 
   54*a^2*b^2*c^4 + 26*b^4*c^4 + 10*a^2*c^6 - 4*b^2*c^6 - 5*c^8 - 
   8*Area*(7*a^4*b^2 - 8*a^2*b^4 + b^6 + 7*a^4*c^2 - 12*a^2*b^2*c^2 - 8*b^4*c^2 - 8*a^2*c^4 - 8*b^2*c^4 + c^6)))
CircleRadius[LucasCentralCircle]:=
(a*b*c*Sqrt[12*a^16 + 52*a^14*b^2 - 392*a^12*b^4 + 384*a^10*b^6 + 296*a^8*b^8 - 448*a^6*b^10 + 96*a^4*b^12 + 
    20*a^2*b^14 - 4*b^16 + 52*a^14*c^2 - 784*a^12*b^2*c^2 + 6*a^10*b^4*c^2 + 2894*a^8*b^6*c^2 - 298*a^6*b^8*c^2 - 
    962*a^4*b^10*c^2 + 128*a^2*b^12*c^2 + 20*b^14*c^2 - 392*a^12*c^4 + 6*a^10*b^2*c^4 + 4545*a^8*b^4*c^4 + 
    4494*a^6*b^6*c^4 - 267*a^4*b^8*c^4 - 714*a^2*b^10*c^4 + 384*a^10*c^6 + 2894*a^8*b^2*c^6 + 4494*a^6*b^4*c^6 + 
    3318*a^4*b^6*c^6 + 574*a^2*b^8*c^6 - 120*b^10*c^6 + 296*a^8*c^8 - 298*a^6*b^2*c^8 - 267*a^4*b^4*c^8 + 
    574*a^2*b^6*c^8 + 208*b^8*c^8 - 448*a^6*c^10 - 962*a^4*b^2*c^10 - 714*a^2*b^4*c^10 - 120*b^6*c^10 + 96*a^4*c^12 + 
    128*a^2*b^2*c^12 + 20*a^2*c^14 + 20*b^2*c^14 - 4*c^16 + 8*Area*(2*a^2 + b^2 + c^2)*
     (a^4 - 7*a^2*b^2 + 2*b^4 - 7*a^2*c^2 - 5*b^2*c^2 + 2*c^4)*(4*a^8 - a^6*b^2 - 16*a^4*b^4 + 9*a^2*b^6 - a^6*c^2 - 
      43*a^4*b^2*c^2 - 21*a^2*b^4*c^2 + 5*b^6*c^2 - 16*a^4*c^4 - 21*a^2*b^2*c^4 - 10*b^4*c^4 + 9*a^2*c^6 + 
      5*b^2*c^6)])/(4*(a^2 + 2*Area)*
  (-(Area*(5*a^6 - 9*a^4*b^2 - 9*a^2*b^4 + 5*b^6 - 9*a^4*c^2 - 58*a^2*b^2*c^2 - 9*b^4*c^2 - 9*a^2*c^4 - 9*b^2*c^4 + 
      5*c^6)) - 2*(2*a^6*b^2 - 4*a^4*b^4 + 2*a^2*b^6 + 2*a^6*c^2 - 7*a^4*b^2*c^2 - 7*a^2*b^4*c^2 + 2*b^6*c^2 - 
     4*a^4*c^4 - 7*a^2*b^2*c^4 - 4*b^4*c^4 + 2*a^2*c^6 + 2*b^2*c^6)))
CircleFunction[LucasCentralCircle]:=
(b*c*(2*a^6 - 4*a^4*b^2 - a^2*b^4 + b^6 - 4*a^4*c^2 - 12*a^2*b^2*c^2 - b^4*c^2 - a^2*c^4 - b^2*c^4 + c^6 - 
   2*Area*(a^4 + 9*a^2*b^2 + 9*a^2*c^2 + 4*b^2*c^2)))/
 (-2*Area*(5*a^6 - 9*a^4*b^2 - 9*a^2*b^4 + 5*b^6 - 9*a^4*c^2 - 58*a^2*b^2*c^2 - 9*b^4*c^2 - 9*a^2*c^4 - 9*b^2*c^4 + 
    5*c^6) - 4*(2*a^6*b^2 - 4*a^4*b^4 + 2*a^2*b^6 + 2*a^6*c^2 - 7*a^4*b^2*c^2 - 7*a^2*b^4*c^2 + 2*b^6*c^2 - 
    4*a^4*c^4 - 7*a^2*b^2*c^4 - 4*b^4*c^4 + 2*a^2*c^6 + 2*b^2*c^6))

CircleTripletFunction[LucasCircles]:={
{2Sin[A]+Cos[A],Cos[B],Cos[C]},Circumradius/(1+2a Circumradius/(b c))
}

Name[LucasCirclesRadicalCircle]:="Lucas circles radical circle"
CircleFunction[LucasCirclesRadicalCircle]:=-2b c/(a^2+b^2+c^2+8Area)
CircleCenterFunction[LucasCirclesRadicalCircle]:=2Cos[A]+Sin[A]
CircleRadius[LucasCirclesRadicalCircle]:=Circumradius/(Cot[BrocardAngle]+2)

Name[LucasCubic]:="Lucas cubic"
PivotalIsotomicCubicFunction[LucasCubic]:=Cos[A]/a^2

Name[LucasCentralTriangle]:="Lucas central triangle"
TrilinearVertexMatrix[LucasCentralTriangle]:=
{{a(2 S+SA),b SB,c SC},{a SA,b(2 S+SB),c SC},{a SA,b SB,c(2 S+SC)}}

Name[LucasInnerCircle]:="Lucas inner circle"
CircleFunction[LucasInnerCircle]:=(-2 b c) / (a^2 + b^2 + c^2 + 7 Area)
CircleCenterFunction[LucasInnerCircle]:=7Cos[A]+4Sin[A]
CircleRadius[LucasInnerCircle]:=Circumradius/(4Cot[BrocardAngle]+7)

Name[LucasInnerTriangle]:="Lucas inner triangle"
TrilinearVertexMatrix[LucasInnerTriangle]:={
{a (4 Cos[A]+3 Sin[A]),2 (2 a Cos[B]+b Sin[A]),2 (2 a Cos[C]+c Sin[A])},
{2 (2 b Cos[A]+a Sin[B]),b (4 Cos[B]+3 Sin[B]),2 (2 b Cos[C]+c Sin[B])},
{2 (2 c Cos[A]+a Sin[C]),2 (2 c Cos[B]+b Sin[C]),c (4 Cos[C]+3 Sin[C])}
}

Name[LucasTangentsTriangle]:="Lucas tangents triangle"
TrilinearVertexMatrix[LucasTangentsTriangle]:={
{a b c Cos[A],       b(2 Area+a c Cos[B]),c(2 Area+a b Cos[C])},
{a(b c Cos[A]+2Area),a b c Cos[B],        c(2 Area+a b Cos[C])},
{a(b c Cos[A]+2Area),b(2 Area+a c Cos[B]),a b c Cos[C]}
}

Name[MacBeathCircle]:="MacBeath circle"
CircleFunction[MacBeathCircle]:=
((a^10 - 3*a^8*b^2 + 4*a^6*b^4 - 4*a^4*b^6 + 3*a^2*b^8 - b^10 - 3*a^8*c^2 + 5*a^6*b^2*c^2 - 
   2*a^4*b^4*c^2 - 3*a^2*b^6*c^2 + 3*b^8*c^2 + 4*a^6*c^4 - 2*a^4*b^2*c^4 - 2*b^6*c^4 - 4*a^4*c^6 - 
   3*a^2*b^2*c^6 - 2*b^4*c^6 + 3*a^2*c^8 + 3*b^2*c^8 - c^10)*Cos[A]*Sec[A - B]*Sec[A - C]*Sec[B - C])/
 (8*a^2*b^4*c^4)
CircleRadius[MacBeathCircle]:=
Sqrt[(a^10 - a^8*b^2 - a^2*b^8 + b^10 - 3*a^8*c^2 + a^6*b^2*c^2 + 4*a^4*b^4*c^2 + a^2*b^6*c^2 - 
    3*b^8*c^2 + 2*a^6*c^4 - 2*a^4*b^2*c^4 - 2*a^2*b^4*c^4 + 2*b^6*c^4 + 2*a^4*c^6 + 5*a^2*b^2*c^6 + 
    2*b^4*c^6 - 3*a^2*c^8 - 3*b^2*c^8 + c^10)*(a^10 - 3*a^8*b^2 + 2*a^6*b^4 + 2*a^4*b^6 - 3*a^2*b^8 + 
    b^10 - a^8*c^2 + a^6*b^2*c^2 - 2*a^4*b^4*c^2 + 5*a^2*b^6*c^2 - 3*b^8*c^2 + 4*a^4*b^2*c^4 - 
    2*a^2*b^4*c^4 + 2*b^6*c^4 + a^2*b^2*c^6 + 2*b^4*c^6 - a^2*c^8 - 3*b^2*c^8 + c^10)*
   (a^10 - 3*a^8*b^2 + 2*a^6*b^4 + 2*a^4*b^6 - 3*a^2*b^8 + b^10 - 3*a^8*c^2 + 5*a^6*b^2*c^2 - 
    2*a^4*b^4*c^2 + a^2*b^6*c^2 - b^8*c^2 + 2*a^6*c^4 - 2*a^4*b^2*c^4 + 4*a^2*b^4*c^4 + 2*a^4*c^6 + 
    a^2*b^2*c^6 - 3*a^2*c^8 - b^2*c^8 + c^10)]/(64*a^4*Area*b^4*c^4*Abs[Cos[A - B]]*Abs[Cos[A - C]]*
  Abs[Cos[B - C]])
CircleCenterFunction[MacBeathCircle]:=
(-2*a^16 + 7*a^14*b^2 - 7*a^12*b^4 - a^10*b^6 + 5*a^8*b^8 - 
  3*a^6*b^10 + 3*a^4*b^12 - 3*a^2*b^14 + b^16 + 7*a^14*c^2 - 
  16*a^12*b^2*c^2 + 6*a^10*b^4*c^2 + 10*a^8*b^6*c^2 - 
  5*a^6*b^8*c^2 - 12*a^4*b^10*c^2 + 16*a^2*b^12*c^2 - 6*b^14*c^2 - 
  7*a^12*c^4 + 6*a^10*b^2*c^4 - 6*a^8*b^4*c^4 + 8*a^6*b^6*c^4 + 
  13*a^4*b^8*c^4 - 30*a^2*b^10*c^4 + 16*b^12*c^4 - a^10*c^6 + 
  10*a^8*b^2*c^6 + 8*a^6*b^4*c^6 - 8*a^4*b^6*c^6 + 
  17*a^2*b^8*c^6 - 26*b^10*c^6 + 5*a^8*c^8 - 5*a^6*b^2*c^8 + 
  13*a^4*b^4*c^8 + 17*a^2*b^6*c^8 + 30*b^8*c^8 - 3*a^6*c^10 - 
  12*a^4*b^2*c^10 - 30*a^2*b^4*c^10 - 26*b^6*c^10 + 3*a^4*c^12 + 
  16*a^2*b^2*c^12 + 16*b^4*c^12 - 3*a^2*c^14 - 6*b^2*c^14 + c^16)/a

Name[MacBeathCircumconic]:="MacBeath circumconic"
CircumconicParameters[MacBeathCircumconic]:={Cos[A],Cos[B],Cos[C]}

Name[MacBeathInconic]:="MacBeath inconic"
InconicParameters[MacBeathInconic]:={a^2Cos[A],b^2Cos[B],c^2Cos[C]}

Name[MacBeathTriangle]:="MacBeath triangle"
TrilinearVertexMatrix[MacBeathTriangle]:=
{{0,c^2 Cos[C] Sec[B],b^2},{c^2,0,a^2 Cos[A] Sec[C]},{b^2 Cos[B] Sec[A],a^2,0}}

Maltitudes[q_Quadrilateral]:=Module[{v=Vertices@q,i},
	RotateLeft[(Line/@Reverse/@Table[{
		Midpoint[{v[[i]],v[[addn[i,1,4]]]}],
		Coordinates@Intersections[
			Line@{v[[addn[i,2,4]]],v[[addn[i,3,4]]]},
			Line@{Midpoint[{v[[i]],v[[addn[i,1,4]]]}],
				Midpoint[{v[[i]],v[[addn[i,1,4]]]}]+{v[[addn[i,3,4],2]]-v[[addn[i,2,4],2]],-v[[addn[i,3,4],1]]+v[[addn[i,2,4],1]]}}]
	},{i,4}]),2]
]

Name[MandartCircle]:="Mandart circle"
CircleFunction[MandartCircle]:=-(-a^3 - a^2*b + a*b^2 + b^3 - a^2*c + 2*a*b*c - b^2*c + a*c^2 - b*c^2 + c^3)/(4*b*c*(-a + b + c))
CircleRadius[MandartCircle]:=Sqrt[((a^4 - 2*a^2*b^2 + b^4 + 4*a^2*b*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)*(a^4 - 2*a^2*b^2 + b^4 + 4*a*b^2*c - 
     2*a^2*c^2 - 2*b^2*c^2 + c^4)*(a^4 - 2*a^2*b^2 + b^4 - 2*a^2*c^2 + 4*a*b*c^2 - 2*b^2*c^2 + c^4))/
   ((- a + b + c)^3*(a + b - c)^3*(a - b + c)^3*(a + b + c))]/2
CircleCenterFunction[MandartCircle]:=a^6-b^6-c^6+b^2*c^2*(b^2+c^2)+3*a^2*(-(a^2*b^2)+b^4-a^2*c^2+c^4)+2*a*b*c*(a^3-a*b^2-b^3-a*b*c-a*c^2-c^3+(b+c)*(a^2+b*c))

Name[MandartInellipse]:="Mandart inellipse"
InconicParameters[MandartInellipse]:={a/(b + c - a), b/(a + c - b), c/(a + b - c)}

Name[MCayCubic]:="M'Cay cubic"
PivotalIsogonalCubicFunction[MCayCubic]:=Cos[A]

CircleTripletFunction[McCayCircles]:={{2 b c Cos[A],a b,a c},a Sqrt[Cot[BrocardAngle]^2-3]/6}

Name[McCayCirclesRadicalCircle]:="McCay circles radical circle"
CircleCenterFunction[McCayCirclesRadicalCircle]:=
-((5*a^6 - 6*a^4*b^2 + 2*b^6 - 6*a^4*c^2 - 18*a^2*b^2*c^2 - 3*b^4*c^2 - 3*b^2*c^4 + 2*c^6)/a)
CircleRadius[McCayCirclesRadicalCircle]:=
-((a^4 - a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2 + c^4)*Sqrt[5*a^6 - 3*a^4*b^2 - 3*a^2*b^4 + 5*b^6 - 3*a^4*c^2 - 
     51*a^2*b^2*c^2 - 3*b^4*c^2 - 3*a^2*c^4 - 3*b^2*c^4 + 5*c^6])/(9*(a - b - c)*(a + b - c)*(a - b + c)*(a + b + c)*
  (a^2 + b^2 + c^2))
CircleFunction[McCayCirclesRadicalCircle]:=
(a^8 - 2*a^6*b^2 + a^4*b^4 + 3*a^2*b^6 - b^8 - 2*a^6*c^2 - 8*a^4*b^2*c^2 + 16*a^2*b^4*c^2 - 5*b^6*c^2 + a^4*c^4 + 16*a^2*b^2*c^4 + 10*b^4*c^4 + 
  3*a^2*c^6 - 5*b^2*c^6 - c^8)/(9*b*(a - b - c)*(a + b - c)*c*(a - b + c)*(a + b + c)*(a^2 + b^2 + c^2))

Name[MedialTriangle]:="medial triangle"
TrilinearVertexMatrix[MedialTriangle]:=
{{0, b^(-1), c^(-1)}, {a^(-1), 0, c^(-1)}, {a^(-1), b^(-1), 0}}

Medians[t_Triangle]:=Line[Coordinates/@#]&/@Transpose[{Midpoints[t],VertexPoints[t]}] /;
	Dimensions[t[[1]]]=={3,2}
Medians[t_]:=Line@@@Transpose[{Midpoints[t],TrilinearVertexMatrix[t]}] /;
	MemberQ[Triangles,t]

(* rewrite *)
MidArcAntiPoints[vert_List]:=Module[
	{ctr=Circumcenter[vert][[1]],r=Circumradius[vert],pt={},i,m={}},
	pt=Table[(vert[[i]]+vert[[Add1[i]]])/2-ctr,{i,3}];
	m=Table[ ctr+r pt[[i]]/norm[pt[[i]]],{i,3}];
	Table[Point[2ctr-m[[i]]+2pt[[i]]],{i,3}]
]

MidArcLines[vert_List]:=
	Module[{i,m=MidArcPoints[vert],a=MidArcAntiPoints[vert]},
	Table[Line[{m[[i,1]],a[[i,1]]}],{i,3}]
]

CenterFunction[MidArcPoint[1]]:=(Cos[B/2]+Cos[C/2])Sec[A/2]
Name[MidArcPoint[1]]:="first mid-arc point"

CenterFunction[MidArcPoint[2]]:=(Cos[B/2]+Cos[C/2])Csc[A/2]
Name[MidArcPoint[2]]:="second mid-arc point"

(*
MidArcPoints[vert_List]:=Module[
	{ctr=Circumcenter[vert][[1]],r=Circumradius[vert],pt={},i},
	pt=Table[(vert[[i]]+vert[[Add1[i]]])/2-ctr,{i,3}];
	Table[ Point[ctr+r pt[[i]]/norm[pt[[i]]]],{i,3}]
]

MidArcSidePoints[vert_List]:=Module[{i},
	Table[Point[(vert[[i]]+vert[[Add1[i]]])/2],{i,3}]
]
*)

Name[MidArcTriangle]:="mid-arc triangle"
TrilinearVertexMatrix[MidArcTriangle]:=MapIndexed[
  RotateRight[#1,#2-1]&,
  {(Cos[#2/2]+Cos[#3/2])^2,Cos[#1/2]^2,Cos[#1/2]^2}&@@@NestList[RotateLeft,{A,B,C},2]]

Midpoint[Line[{v1_,v2_}]]:=Point[Midpoint[{v1,v2}]]

Midpoint[{Point[p1_],Point[p2_]}]:=Midpoint[Line[{p1,p2}]]

Midpoint[v_List?MatrixQ]:=Plus@@v/2 /; Dimensions[v]=={2,2}

Midpoint[{{a1_,b1_,g1_},{a2_,b2_,g2_}}]:={
    2a a1 a2+b(a2 b1+a1 b2)+c(a2 g1+a1 g2),
    a(a2 b1+a1 b2)+2b b1 b2+c(b2 g1+b1 g2),
    a(a2 g1+a1 g2)+b(b2 g1+b1 g2)+2c g1 g2
}

Midpoint[ctr1_,ctr2_]:=Midpoint[{ctr1,ctr2}] /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})
Midpoint[{ctr1_,ctr2_}]:=Midpoint[Trilinears/@{ctr1,ctr2}] /;
	And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

Midpoint[t_Triangle,{ctr1_,ctr2_}]:=Point[TrilinearToCartesian[t,
	Midpoint[{ctr1,ctr2}]/.Thread[{a,b,c}->SideLengths[t]]/.Thread[{A,B,C}->Angles[t]]
]]

MidpointDiagonals[v_List /; Length[v]==4]:=Module[
	{m=Midpoints[v] /. Point->Identity},
	{Line[m[[{1,3}]]],Line[m[[{2,4}]]]}
]

MidpointPolygon[vert_List?MatrixQ]:=Polygon[Coordinates/@Midpoints[vert]]
MidpointPolygon[f_Polygon]:=MidpointPolygon[Vertices[f]]
MidpointPolygon[t_Triangle]:=Triangle[Coordinates/@Midpoints[t]]
MidpointPolygon[q_Quadrilateral]:=Quadrilateral[Coordinates/@Midpoints[q]]

Midpoints[Triangle[v_List?MatrixQ]]:=Midpoint/@Partition[RotateLeft@v,2,1,1] /; Dimensions[v]=={3,3}
Midpoints[t_]:=Midpoints[Triangle[t]] /; MemberQ[Triangles,t]
Midpoints[f:(_Triangle|_Quadrilateral|_Polygon)]:=Midpoints[Vertices@f]
Midpoints[v_List]:=Point/@Midpoint/@Partition[RotateLeft@v,2,1,1]

(* Miquel circles, point, triangle *)

MiquelCircles[{ka_, kb_, kc_}] := 
  {Circle[{a^4 - a^2*b^2 - 2*a^2*c^2 - b^2*c^2 + c^4 - a^2*b^2*kb + b^4*kb - b^2*c^2*kb + 
      a^2*c^2*kc + b^2*c^2*kc - c^4*kc, a*b*(-a^2 + b^2 + c^2 + a^2*kb - b^2*kb - c^2*kb - 
       2*c^2*kc), (-a)*c*(2*b^2 - 2*b^2*kb + a^2*kc - b^2*kc - c^2*kc)}, 
    (1/(4*Area))*(b*c*Sqrt[b^2*(-1 + kb)*(-1 + kb + kc) + 
        kc*((-a^2)*(-1 + kb) + c^2*(-1 + kb + kc))])], 
   Circle[{(2*c^2 - a^2*ka + b^2*ka - c^2*ka - 2*c^2*kc)/c, 
     (1/(a*b*c))*(-a^4 + 2*a^2*b^2 - b^4 + a^2*c^2 + b^2*c^2 + a^4*ka - a^2*b^2*ka - 
       a^2*c^2*ka + a^2*c^2*kc + b^2*c^2*kc - c^4*kc), 
     (-a^2 + b^2 - c^2 + 2*a^2*ka + a^2*kc - b^2*kc + c^2*kc)/a}, 
    (1/(4*Area))*(a*c*Sqrt[c^2*(-1 + kc)*(-1 + ka + kc) + 
        ka*((-b^2)*(-1 + kc) + a^2*(-1 + ka + kc))])], 
   Circle[{(-a^2 - b^2 + c^2 + a^2*ka + b^2*ka - c^2*ka + 2*b^2*kb)/b, 
     (2*a^2 - 2*a^2*ka - a^2*kb - b^2*kb + c^2*kb)/a, 
     (1/(a*b*c))*(a^2*b^2 - b^4 + a^2*c^2 + 2*b^2*c^2 - c^4 - a^4*ka + a^2*b^2*ka + 
       a^2*c^2*ka - a^2*b^2*kb + b^4*kb - b^2*c^2*kb)}, 
    (1/(4*Area))*(a*b*Sqrt[a^2*(-1 + ka)*(-1 + ka + kb) + 
        kb*((-c^2)*(-1 + ka) + b^2*(-1 + ka + kb))])]}

MiquelPoint[{ka_,kb_,kc_}]:={a*(a^2*(-1+ka)*ka+b^2*ka*kb+c^2*(-1+ka)*(-1+kc)),
    b*(a^2*(-1+ka)*(-1+kb)+b^2*(-1+kb)*kb+c^2*kb*kc),
    c*(b^2*(-1+kb)*(-1+kc)+a^2*ka*kc+c^2*(-1+kc)*kc)}

MiquelTriangle[{ka_,kb_,kc_}]:=Triangle[SideRatioPoints[{ka,kb,kc}]]

(* Mittenpunkt *)

CenterFunction[Mittenpunkt]:=b+c-a
Name[Mittenpunkt]:="Mittenpunkt"

Name[MixtilinearCircle]:="mixtilinear circle"
CircleCenterFunction[MixtilinearCircle]:=
a*(a^6 - 7*a^4*b^2 + 8*a^3*b^3 + 3*a^2*b^4 - 8*a*b^5 + 3*b^6 + 
  4*a^4*b*c + 8*a^3*b^2*c - 32*a^2*b^3*c + 24*a*b^4*c - 4*b^5*c - 
  7*a^4*c^2 + 8*a^3*b*c^2 + 26*a^2*b^2*c^2 - 16*a*b^3*c^2 - 
  11*b^4*c^2 + 8*a^3*c^3 - 32*a^2*b*c^3 - 16*a*b^2*c^3 + 
  24*b^3*c^3 + 3*a^2*c^4 + 24*a*b*c^4 - 11*b^2*c^4 - 8*a*c^5 - 
  4*b*c^5 + 3*c^6)
CircleFunction[MixtilinearCircle]:=
(-4*b*c*(3*a^3*b - 5*a^2*b^2 + a*b^3 + b^4 + 3*a^3*c + 2*a^2*b*c + 
   3*a*b^2*c - 5*a^2*c^2 + 3*a*b*c^2 - 2*b^2*c^2 + a*c^3 + c^4))/
 ((a + b + c)^3*(a^3 - a^2*b - a*b^2 + b^3 - a^2*c + 6*a*b*c - 
   b^2*c - a*c^2 - b*c^2 + c^3))
CircleRadius[MixtilinearCircle]:=
(a*b*c*Sqrt[-(((3*a^3 - 3*a^2*b - 3*a*b^2 + 3*b^3 - 5*a^2*c + 
       10*a*b*c - 5*b^2*c + a*c^2 + b*c^2 + c^3)*
      (3*a^3 - 5*a^2*b + a*b^2 + b^3 - 3*a^2*c + 10*a*b*c + b^2*c - 
       3*a*c^2 - 5*b*c^2 + 3*c^3)*(a^3 + a^2*b - 5*a*b^2 + 3*b^3 + 
       a^2*c + 10*a*b*c - 3*b^2*c - 5*a*c^2 - 3*b*c^2 + 3*c^3))/
     ((a - b - c)*(a + b - c)*(a - b + c)*(a + b + c)))])/
 ((a + b + c)^(3/2)*(a^3 - a^2*b - a*b^2 + b^3 - a^2*c + 6*a*b*c - 
   b^2*c - a*c^2 - b*c^2 + c^3))

CircleTripletFunction[MixtilinearIncircles]:=
	{{(1+Cos[A]-Cos[B]-Cos[C])/2,1,1},Inradius Sec[A/2]^2}

Name[MixtilinearIncirclesRadicalCircle]:="mixtilinear incircles radical circle"
CircleFunction[MixtilinearIncirclesRadicalCircle]:=
(4*a*b*(a - b - c)*c)/((a + b + c)*(a^3 - a^2*b - a*b^2 + 
   b^3 - a^2*c + 6*a*b*c - b^2*c - a*c^2 - b*c^2 + c^3))
CircleCenterFunction[MixtilinearIncirclesRadicalCircle]:=-2+Cos[A]
CircleRadius[MixtilinearIncirclesRadicalCircle]:=
	Sqrt[-3((-a + b + c)*(a^4*b^2*c^2 - a^2*b^4*c^2 + 
      2*a^2*b^3*c^3 - a^2*b^2*c^4))/(a + b + c)]/
 (a^3 - a^2*b - a*b^2 + b^3 - a^2*c + 6*a*b*c - b^2*c - a*c^2 - b*c^2 + c^3)

Name[MixtilinearTriangle]:="mixtilinear triangle"
TrilinearVertexMatrix[MixtilinearTriangle]:=
{{(1 + Cos[A] - Cos[B] - Cos[C])/2, 1, 1}, 
 {1, (1 - Cos[A] + Cos[B] - Cos[C])/2, 1}, 
 {1, 1, (1 - Cos[A] - Cos[B] + Cos[C])/2}}

Name[MorleysAdjunctCircle]:="Morley's adjunct circle"
CircleCenterFunction[MorleysAdjunctCircle]:=
c*(-((-32*a^2*b*c*Sec[A/3] + 8*a^2*b*c*Sec[A/3]^3 - 16*a^3*b*Sec[A/3]*Sec[B/3] + 
       16*a*b^3*Sec[A/3]*Sec[B/3] - 16*a*b*c^2*Sec[A/3]*Sec[B/3] + 16*a*b^2*c*Sec[A/3]^2*Sec[B/3] + 
       8*a*b*c^2*Sec[A/3]^3*Sec[B/3] + 4*a^2*b^2*Sec[A/3]^2*Sec[B/3]^2 - 
       4*b^4*Sec[A/3]^2*Sec[B/3]^2 + 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2 - 
       2*b^3*c*Sec[A/3]^3*Sec[B/3]^2 + 2*b*c^3*Sec[A/3]^3*Sec[B/3]^2 + 4*a^3*b*Sec[A/3]*Sec[B/3]^3 - 
       4*a*b^3*Sec[A/3]*Sec[B/3]^3 + 4*a*b*c^2*Sec[A/3]*Sec[B/3]^3 + 2*a^2*b*c*Sec[A/3]*Sec[B/3]^4 - 
       32*a*b*c^2*Sec[C/3] - 48*a*b^2*c*Sec[A/3]*Sec[C/3] + 8*a^3*b*Sec[A/3]^2*Sec[C/3] - 
       8*a*b^3*Sec[A/3]^2*Sec[C/3] + 4*a*b^2*c*Sec[A/3]^3*Sec[C/3] - 16*a^2*b*c*Sec[B/3]*Sec[C/3] + 
       16*b^3*c*Sec[B/3]*Sec[C/3] - 16*b*c^3*Sec[B/3]*Sec[C/3] - 16*a^2*b^2*Sec[A/3]*Sec[B/3]*
        Sec[C/3] + 16*b^4*Sec[A/3]*Sec[B/3]*Sec[C/3] - 16*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] + 
       4*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 4*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
       4*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 8*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 
       6*a*b*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - a*b^2*c*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + 
       4*a^2*b*c*Sec[B/3]^3*Sec[C/3] - 4*b^3*c*Sec[B/3]^3*Sec[C/3] + 4*b*c^3*Sec[B/3]^3*Sec[C/3] - 
       a^2*b*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + b^3*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
       b*c^3*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 2*a*b*c^2*Sec[B/3]^4*Sec[C/3] + 
       a*b^2*c*Sec[A/3]*Sec[B/3]^4*Sec[C/3] - 8*b^3*c*Sec[A/3]*Sec[C/3]^2 + 
       8*b*c^3*Sec[A/3]*Sec[C/3]^2 + 4*a^2*b^2*Sec[A/3]^2*Sec[C/3]^2 - 4*b^4*Sec[A/3]^2*Sec[C/3]^2 + 
       4*b^2*c^2*Sec[A/3]^2*Sec[C/3]^2 + 16*a*b^2*c*Sec[B/3]*Sec[C/3]^2 - 
       4*a^3*b*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 4*a*b^3*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
       4*a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 4*a^2*b^2*Sec[B/3]^2*Sec[C/3]^2 - 
       4*b^4*Sec[B/3]^2*Sec[C/3]^2 + 4*b^2*c^2*Sec[B/3]^2*Sec[C/3]^2 - 
       6*a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - a^2*b^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
       b^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
       a^3*b*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + a*b^3*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
       a*b*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 8*a*b*c^2*Sec[C/3]^3 + 
       4*a*b^2*c*Sec[A/3]*Sec[C/3]^3 + 8*a^2*b*c*Sec[B/3]*Sec[C/3]^3 + 
       2*a^3*b*Sec[B/3]^2*Sec[C/3]^3 - 2*a*b^3*Sec[B/3]^2*Sec[C/3]^3 - 
       a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3)*(64*a*b^2*c - 32*a^3*b*Sec[A/3] + 32*a*b^3*Sec[A/3] + 
       32*a*b*c^2*Sec[A/3] + 8*a^3*b*Sec[A/3]^3 - 8*a*b^3*Sec[A/3]^3 - 8*a*b*c^2*Sec[A/3]^3 - 
       4*a*b^2*c*Sec[A/3]^4 - 16*a^2*b*c*Sec[A/3]*Sec[B/3] + 8*a^4*Sec[A/3]^2*Sec[B/3] - 
       8*a^2*b^2*Sec[A/3]^2*Sec[B/3] - 8*a^2*c^2*Sec[A/3]^2*Sec[B/3] - 
       4*a^2*b*c*Sec[A/3]^3*Sec[B/3] + 8*a*b*c^2*Sec[A/3]*Sec[B/3]^2 - 
       2*a*b*c^2*Sec[A/3]^3*Sec[B/3]^2 - 4*b^3*c*Sec[A/3]*Sec[B/3]^3 + 4*b*c^3*Sec[A/3]*Sec[B/3]^3 - 
       2*a^2*c^2*Sec[A/3]^2*Sec[B/3]^3 - 2*b^2*c^2*Sec[A/3]^2*Sec[B/3]^3 + 
       2*c^4*Sec[A/3]^2*Sec[B/3]^3 - 4*a*b^2*c*Sec[B/3]^4 - 2*a*b*c^2*Sec[A/3]*Sec[B/3]^4 + 
       32*a^2*b*c*Sec[C/3] + 32*b^3*c*Sec[C/3] - 32*b*c^3*Sec[C/3] - 16*a^4*Sec[A/3]*Sec[C/3] + 
       16*b^4*Sec[A/3]*Sec[C/3] + 32*a^2*c^2*Sec[A/3]*Sec[C/3] - 16*c^4*Sec[A/3]*Sec[C/3] + 
       8*a^2*b*c*Sec[A/3]^2*Sec[C/3] + 4*a^2*b^2*Sec[A/3]^3*Sec[C/3] - 4*b^4*Sec[A/3]^3*Sec[C/3] - 
       4*a^2*c^2*Sec[A/3]^3*Sec[C/3] + 4*c^4*Sec[A/3]^3*Sec[C/3] - 2*b^3*c*Sec[A/3]^4*Sec[C/3] + 
       2*b*c^3*Sec[A/3]^4*Sec[C/3] - 16*a*b*c^2*Sec[B/3]*Sec[C/3] + a*b*c^2*Sec[A/3]^4*Sec[B/3]*
        Sec[C/3] + 8*a^2*b*c*Sec[B/3]^2*Sec[C/3] - 4*a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
       8*a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 4*b^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
       8*a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 8*b^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 
       4*c^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 
       2*b^3*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 2*b*c^3*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 
       a^2*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + b^2*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 
       c^4*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + 4*a^3*b*Sec[B/3]^3*Sec[C/3] - 
       4*a*b^3*Sec[B/3]^3*Sec[C/3] + a*b*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
       2*a^2*b*c*Sec[B/3]^4*Sec[C/3] + 8*a*b*c^2*Sec[A/3]*Sec[C/3]^2 - 
       2*a*b*c^2*Sec[A/3]^3*Sec[C/3]^2 - 8*a^2*c^2*Sec[B/3]*Sec[C/3]^2 - 
       8*b^2*c^2*Sec[B/3]*Sec[C/3]^2 + 8*c^4*Sec[B/3]*Sec[C/3]^2 - 4*a^2*b^2*Sec[A/3]^2*Sec[B/3]*
        Sec[C/3]^2 + 4*b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]*
        Sec[C/3]^2 + b^3*c*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - b*c^3*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - 
       2*a^3*b*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*b^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
       2*a*b*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*b^2*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
       2*a^4*Sec[B/3]^3*Sec[C/3]^2 - 2*a^2*b^2*Sec[B/3]^3*Sec[C/3]^2 - 
       2*a^2*c^2*Sec[B/3]^3*Sec[C/3]^2 + a^2*b*c*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
       8*a^2*b*c*Sec[C/3]^3 - 8*b^3*c*Sec[C/3]^3 + 8*b*c^3*Sec[C/3]^3 + 4*a^4*Sec[A/3]*Sec[C/3]^3 - 
       4*b^4*Sec[A/3]*Sec[C/3]^3 - 4*a^2*c^2*Sec[A/3]*Sec[C/3]^3 + 4*b^2*c^2*Sec[A/3]*Sec[C/3]^3 - 
       2*a^2*b*c*Sec[A/3]^2*Sec[C/3]^3 - 4*a*b*c^2*Sec[B/3]*Sec[C/3]^3 - 
       a^3*b*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + a*b^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
       2*a^2*b*c*Sec[B/3]^2*Sec[C/3]^3 - a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + 
       a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
       4*a*b^2*c*Sec[C/3]^4 + 2*a^3*b*Sec[A/3]*Sec[C/3]^4 - 2*a*b^3*Sec[A/3]*Sec[C/3]^4 + 
       a^2*b*c*Sec[A/3]*Sec[B/3]*Sec[C/3]^4))/2 + 
   ((64*a*b*c^2 - 32*a^3*c*Sec[A/3] + 32*a*b^2*c*Sec[A/3] + 32*a*c^3*Sec[A/3] + 8*a^3*c*Sec[A/3]^3 - 
      8*a*b^2*c*Sec[A/3]^3 - 8*a*c^3*Sec[A/3]^3 - 4*a*b*c^2*Sec[A/3]^4 + 32*a^2*b*c*Sec[B/3] - 
      32*b^3*c*Sec[B/3] + 32*b*c^3*Sec[B/3] - 16*a^4*Sec[A/3]*Sec[B/3] + 
      32*a^2*b^2*Sec[A/3]*Sec[B/3] - 16*b^4*Sec[A/3]*Sec[B/3] + 16*c^4*Sec[A/3]*Sec[B/3] + 
      8*a^2*b*c*Sec[A/3]^2*Sec[B/3] - 4*a^2*b^2*Sec[A/3]^3*Sec[B/3] + 4*b^4*Sec[A/3]^3*Sec[B/3] + 
      4*a^2*c^2*Sec[A/3]^3*Sec[B/3] - 4*c^4*Sec[A/3]^3*Sec[B/3] + 2*b^3*c*Sec[A/3]^4*Sec[B/3] - 
      2*b*c^3*Sec[A/3]^4*Sec[B/3] + 8*a*b^2*c*Sec[A/3]*Sec[B/3]^2 - 
      2*a*b^2*c*Sec[A/3]^3*Sec[B/3]^2 - 8*a^2*b*c*Sec[B/3]^3 + 8*b^3*c*Sec[B/3]^3 - 
      8*b*c^3*Sec[B/3]^3 + 4*a^4*Sec[A/3]*Sec[B/3]^3 - 4*a^2*b^2*Sec[A/3]*Sec[B/3]^3 + 
      4*b^2*c^2*Sec[A/3]*Sec[B/3]^3 - 4*c^4*Sec[A/3]*Sec[B/3]^3 - 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^3 - 
      4*a*b*c^2*Sec[B/3]^4 + 2*a^3*c*Sec[A/3]*Sec[B/3]^4 - 2*a*c^3*Sec[A/3]*Sec[B/3]^4 - 
      16*a^2*b*c*Sec[A/3]*Sec[C/3] + 8*a^4*Sec[A/3]^2*Sec[C/3] - 8*a^2*b^2*Sec[A/3]^2*Sec[C/3] - 
      8*a^2*c^2*Sec[A/3]^2*Sec[C/3] - 4*a^2*b*c*Sec[A/3]^3*Sec[C/3] - 16*a*b^2*c*Sec[B/3]*Sec[C/3] + 
      a*b^2*c*Sec[A/3]^4*Sec[B/3]*Sec[C/3] - 8*a^2*b^2*Sec[B/3]^2*Sec[C/3] + 
      8*b^4*Sec[B/3]^2*Sec[C/3] - 8*b^2*c^2*Sec[B/3]^2*Sec[C/3] - 4*a^2*c^2*Sec[A/3]^2*Sec[B/3]^2*
       Sec[C/3] - 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 4*c^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 
      b^3*c*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + b*c^3*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 
      4*a*b^2*c*Sec[B/3]^3*Sec[C/3] - a^3*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 
      a*c^3*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + a^2*b*c*Sec[A/3]*Sec[B/3]^4*Sec[C/3] + 
      8*a*b^2*c*Sec[A/3]*Sec[C/3]^2 - 2*a*b^2*c*Sec[A/3]^3*Sec[C/3]^2 + 
      8*a^2*b*c*Sec[B/3]*Sec[C/3]^2 - 4*a^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
      8*a^2*b^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 4*b^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
      8*a^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 8*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 
      4*c^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 
      2*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 2*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 
      a^2*b^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - b^4*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
      b^2*c^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - 2*a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a*b*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 2*a^2*b*c*Sec[B/3]^3*Sec[C/3]^2 - 
      a^4*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + a^2*b^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 
      a^2*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 4*b^3*c*Sec[A/3]*Sec[C/3]^3 - 
      4*b*c^3*Sec[A/3]*Sec[C/3]^3 - 2*a^2*b^2*Sec[A/3]^2*Sec[C/3]^3 + 2*b^4*Sec[A/3]^2*Sec[C/3]^3 - 
      2*b^2*c^2*Sec[A/3]^2*Sec[C/3]^3 + 4*a^3*c*Sec[B/3]*Sec[C/3]^3 - 4*a*c^3*Sec[B/3]*Sec[C/3]^3 + 
      a*b^2*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + 2*a^4*Sec[B/3]^2*Sec[C/3]^3 - 
      2*a^2*b^2*Sec[B/3]^2*Sec[C/3]^3 - 2*a^2*c^2*Sec[B/3]^2*Sec[C/3]^3 + 
      a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 4*a*b*c^2*Sec[C/3]^4 - 
      2*a*b^2*c*Sec[A/3]*Sec[C/3]^4 - 2*a^2*b*c*Sec[B/3]*Sec[C/3]^4)*
     (64*a^2*b*c - 4*a^2*b*c*Sec[A/3]^4 + 32*a^3*b*Sec[B/3] - 32*a*b^3*Sec[B/3] + 
      32*a*b*c^2*Sec[B/3] - 16*a*b^2*c*Sec[A/3]*Sec[B/3] + 8*a*b*c^2*Sec[A/3]^2*Sec[B/3] - 
      4*a^3*c*Sec[A/3]^3*Sec[B/3] + 4*a*c^3*Sec[A/3]^3*Sec[B/3] - 2*a*b*c^2*Sec[A/3]^4*Sec[B/3] - 
      8*a^2*b^2*Sec[A/3]*Sec[B/3]^2 + 8*b^4*Sec[A/3]*Sec[B/3]^2 - 8*b^2*c^2*Sec[A/3]*Sec[B/3]^2 - 
      2*a^2*c^2*Sec[A/3]^3*Sec[B/3]^2 - 2*b^2*c^2*Sec[A/3]^3*Sec[B/3]^2 + 
      2*c^4*Sec[A/3]^3*Sec[B/3]^2 - 8*a^3*b*Sec[B/3]^3 + 8*a*b^3*Sec[B/3]^3 - 8*a*b*c^2*Sec[B/3]^3 - 
      4*a*b^2*c*Sec[A/3]*Sec[B/3]^3 - 2*a*b*c^2*Sec[A/3]^2*Sec[B/3]^3 - 4*a^2*b*c*Sec[B/3]^4 + 
      32*a^3*c*Sec[C/3] + 32*a*b^2*c*Sec[C/3] - 32*a*c^3*Sec[C/3] - 16*a*b*c^2*Sec[A/3]*Sec[C/3] + 
      8*a*b^2*c*Sec[A/3]^2*Sec[C/3] - 4*a^3*b*Sec[A/3]^3*Sec[C/3] + 4*a*b^3*Sec[A/3]^3*Sec[C/3] - 
      2*a*b^2*c*Sec[A/3]^4*Sec[C/3] + 16*a^4*Sec[B/3]*Sec[C/3] - 16*b^4*Sec[B/3]*Sec[C/3] + 
      32*b^2*c^2*Sec[B/3]*Sec[C/3] - 16*c^4*Sec[B/3]*Sec[C/3] - 4*a^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
      8*a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 4*b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
      8*a^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
      4*c^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*a*b^2*c*Sec[B/3]^2*Sec[C/3] + 
      2*a^3*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 2*a*b^2*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 
      2*a*c^3*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + a*b*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 
      4*a^4*Sec[B/3]^3*Sec[C/3] + 4*a^2*b^2*Sec[B/3]^3*Sec[C/3] - 4*b^2*c^2*Sec[B/3]^3*Sec[C/3] + 
      4*c^4*Sec[B/3]^3*Sec[C/3] + a^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 
      b^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - c^4*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
      2*a^3*c*Sec[B/3]^4*Sec[C/3] + 2*a*c^3*Sec[B/3]^4*Sec[C/3] + a*b*c^2*Sec[A/3]*Sec[B/3]^4*
       Sec[C/3] - 8*a^2*c^2*Sec[A/3]*Sec[C/3]^2 - 8*b^2*c^2*Sec[A/3]*Sec[C/3]^2 + 
      8*c^4*Sec[A/3]*Sec[C/3]^2 - 2*a^2*b^2*Sec[A/3]^3*Sec[C/3]^2 + 2*b^4*Sec[A/3]^3*Sec[C/3]^2 - 
      2*b^2*c^2*Sec[A/3]^3*Sec[C/3]^2 + 8*a*b*c^2*Sec[B/3]*Sec[C/3]^2 + 
      2*a^3*b*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 2*a*b^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 
      2*a*b*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + a*b^2*c*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
      4*a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 4*a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 
      4*a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
      2*a*b*c^2*Sec[B/3]^3*Sec[C/3]^2 + a^3*c*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
      a*c^3*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 8*a^3*c*Sec[C/3]^3 - 8*a*b^2*c*Sec[C/3]^3 + 
      8*a*c^3*Sec[C/3]^3 - 4*a*b*c^2*Sec[A/3]*Sec[C/3]^3 - 2*a*b^2*c*Sec[A/3]^2*Sec[C/3]^3 - 
      4*a^4*Sec[B/3]*Sec[C/3]^3 + 4*b^4*Sec[B/3]*Sec[C/3]^3 + 4*a^2*c^2*Sec[B/3]*Sec[C/3]^3 - 
      4*b^2*c^2*Sec[B/3]*Sec[C/3]^3 + a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      2*a*b^2*c*Sec[B/3]^2*Sec[C/3]^3 + a^3*b*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
      a*b^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 4*a^2*b*c*Sec[C/3]^4 - 2*a^3*b*Sec[B/3]*Sec[C/3]^4 + 
      2*a*b^3*Sec[B/3]*Sec[C/3]^4 + a*b^2*c*Sec[A/3]*Sec[B/3]*Sec[C/3]^4))/4) + 
 a*(-(64*a^2*b*c - 4*a^2*b*c*Sec[A/3]^4 + 32*a^3*b*Sec[B/3] - 32*a*b^3*Sec[B/3] + 
       32*a*b*c^2*Sec[B/3] - 16*a*b^2*c*Sec[A/3]*Sec[B/3] + 8*a*b*c^2*Sec[A/3]^2*Sec[B/3] - 
       4*a^3*c*Sec[A/3]^3*Sec[B/3] + 4*a*c^3*Sec[A/3]^3*Sec[B/3] - 2*a*b*c^2*Sec[A/3]^4*Sec[B/3] - 
       8*a^2*b^2*Sec[A/3]*Sec[B/3]^2 + 8*b^4*Sec[A/3]*Sec[B/3]^2 - 8*b^2*c^2*Sec[A/3]*Sec[B/3]^2 - 
       2*a^2*c^2*Sec[A/3]^3*Sec[B/3]^2 - 2*b^2*c^2*Sec[A/3]^3*Sec[B/3]^2 + 
       2*c^4*Sec[A/3]^3*Sec[B/3]^2 - 8*a^3*b*Sec[B/3]^3 + 8*a*b^3*Sec[B/3]^3 - 
       8*a*b*c^2*Sec[B/3]^3 - 4*a*b^2*c*Sec[A/3]*Sec[B/3]^3 - 2*a*b*c^2*Sec[A/3]^2*Sec[B/3]^3 - 
       4*a^2*b*c*Sec[B/3]^4 + 32*a^3*c*Sec[C/3] + 32*a*b^2*c*Sec[C/3] - 32*a*c^3*Sec[C/3] - 
       16*a*b*c^2*Sec[A/3]*Sec[C/3] + 8*a*b^2*c*Sec[A/3]^2*Sec[C/3] - 4*a^3*b*Sec[A/3]^3*Sec[C/3] + 
       4*a*b^3*Sec[A/3]^3*Sec[C/3] - 2*a*b^2*c*Sec[A/3]^4*Sec[C/3] + 16*a^4*Sec[B/3]*Sec[C/3] - 
       16*b^4*Sec[B/3]*Sec[C/3] + 32*b^2*c^2*Sec[B/3]*Sec[C/3] - 16*c^4*Sec[B/3]*Sec[C/3] - 
       4*a^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
       4*b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*a^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
       8*b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 4*c^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
       8*a*b^2*c*Sec[B/3]^2*Sec[C/3] + 2*a^3*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 
       2*a*b^2*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 2*a*c^3*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 
       a*b*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 4*a^4*Sec[B/3]^3*Sec[C/3] + 
       4*a^2*b^2*Sec[B/3]^3*Sec[C/3] - 4*b^2*c^2*Sec[B/3]^3*Sec[C/3] + 4*c^4*Sec[B/3]^3*Sec[C/3] + 
       a^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + b^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
       c^4*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 2*a^3*c*Sec[B/3]^4*Sec[C/3] + 
       2*a*c^3*Sec[B/3]^4*Sec[C/3] + a*b*c^2*Sec[A/3]*Sec[B/3]^4*Sec[C/3] - 
       8*a^2*c^2*Sec[A/3]*Sec[C/3]^2 - 8*b^2*c^2*Sec[A/3]*Sec[C/3]^2 + 8*c^4*Sec[A/3]*Sec[C/3]^2 - 
       2*a^2*b^2*Sec[A/3]^3*Sec[C/3]^2 + 2*b^4*Sec[A/3]^3*Sec[C/3]^2 - 
       2*b^2*c^2*Sec[A/3]^3*Sec[C/3]^2 + 8*a*b*c^2*Sec[B/3]*Sec[C/3]^2 + 
       2*a^3*b*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 2*a*b^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 
       2*a*b*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + a*b^2*c*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
       4*a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 4*a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 
       4*a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
       2*a*b*c^2*Sec[B/3]^3*Sec[C/3]^2 + a^3*c*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
       a*c^3*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 8*a^3*c*Sec[C/3]^3 - 8*a*b^2*c*Sec[C/3]^3 + 
       8*a*c^3*Sec[C/3]^3 - 4*a*b*c^2*Sec[A/3]*Sec[C/3]^3 - 2*a*b^2*c*Sec[A/3]^2*Sec[C/3]^3 - 
       4*a^4*Sec[B/3]*Sec[C/3]^3 + 4*b^4*Sec[B/3]*Sec[C/3]^3 + 4*a^2*c^2*Sec[B/3]*Sec[C/3]^3 - 
       4*b^2*c^2*Sec[B/3]*Sec[C/3]^3 + a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
       b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
       2*a*b^2*c*Sec[B/3]^2*Sec[C/3]^3 + a^3*b*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
       a*b^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 4*a^2*b*c*Sec[C/3]^4 - 2*a^3*b*Sec[B/3]*Sec[C/3]^4 + 
       2*a*b^3*Sec[B/3]*Sec[C/3]^4 + a*b^2*c*Sec[A/3]*Sec[B/3]*Sec[C/3]^4)^2/4 + 
   (-32*a^2*b*c*Sec[A/3] + 8*a^2*b*c*Sec[A/3]^3 - 16*a^3*b*Sec[A/3]*Sec[B/3] + 
     16*a*b^3*Sec[A/3]*Sec[B/3] - 16*a*b*c^2*Sec[A/3]*Sec[B/3] + 16*a*b^2*c*Sec[A/3]^2*Sec[B/3] + 
     8*a*b*c^2*Sec[A/3]^3*Sec[B/3] + 4*a^2*b^2*Sec[A/3]^2*Sec[B/3]^2 - 4*b^4*Sec[A/3]^2*Sec[B/3]^2 + 
     4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2 - 2*b^3*c*Sec[A/3]^3*Sec[B/3]^2 + 
     2*b*c^3*Sec[A/3]^3*Sec[B/3]^2 + 4*a^3*b*Sec[A/3]*Sec[B/3]^3 - 4*a*b^3*Sec[A/3]*Sec[B/3]^3 + 
     4*a*b*c^2*Sec[A/3]*Sec[B/3]^3 + 2*a^2*b*c*Sec[A/3]*Sec[B/3]^4 - 32*a*b*c^2*Sec[C/3] - 
     48*a*b^2*c*Sec[A/3]*Sec[C/3] + 8*a^3*b*Sec[A/3]^2*Sec[C/3] - 8*a*b^3*Sec[A/3]^2*Sec[C/3] + 
     4*a*b^2*c*Sec[A/3]^3*Sec[C/3] - 16*a^2*b*c*Sec[B/3]*Sec[C/3] + 16*b^3*c*Sec[B/3]*Sec[C/3] - 
     16*b*c^3*Sec[B/3]*Sec[C/3] - 16*a^2*b^2*Sec[A/3]*Sec[B/3]*Sec[C/3] + 
     16*b^4*Sec[A/3]*Sec[B/3]*Sec[C/3] - 16*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] + 
     4*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 4*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
     4*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 8*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 
     6*a*b*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - a*b^2*c*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + 
     4*a^2*b*c*Sec[B/3]^3*Sec[C/3] - 4*b^3*c*Sec[B/3]^3*Sec[C/3] + 4*b*c^3*Sec[B/3]^3*Sec[C/3] - 
     a^2*b*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + b^3*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
     b*c^3*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 2*a*b*c^2*Sec[B/3]^4*Sec[C/3] + 
     a*b^2*c*Sec[A/3]*Sec[B/3]^4*Sec[C/3] - 8*b^3*c*Sec[A/3]*Sec[C/3]^2 + 
     8*b*c^3*Sec[A/3]*Sec[C/3]^2 + 4*a^2*b^2*Sec[A/3]^2*Sec[C/3]^2 - 4*b^4*Sec[A/3]^2*Sec[C/3]^2 + 
     4*b^2*c^2*Sec[A/3]^2*Sec[C/3]^2 + 16*a*b^2*c*Sec[B/3]*Sec[C/3]^2 - 
     4*a^3*b*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 4*a*b^3*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
     4*a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 4*a^2*b^2*Sec[B/3]^2*Sec[C/3]^2 - 
     4*b^4*Sec[B/3]^2*Sec[C/3]^2 + 4*b^2*c^2*Sec[B/3]^2*Sec[C/3]^2 - 
     6*a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - a^2*b^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
     b^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
     a^3*b*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + a*b^3*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
     a*b*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 8*a*b*c^2*Sec[C/3]^3 + 4*a*b^2*c*Sec[A/3]*Sec[C/3]^3 + 
     8*a^2*b*c*Sec[B/3]*Sec[C/3]^3 + 2*a^3*b*Sec[B/3]^2*Sec[C/3]^3 - 2*a*b^3*Sec[B/3]^2*Sec[C/3]^3 - 
     a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3)*(-32*a^2*b*c*Sec[A/3] + 8*a^2*b*c*Sec[A/3]^3 - 
     32*a*b^2*c*Sec[B/3] - 48*a*b*c^2*Sec[A/3]*Sec[B/3] + 8*a^3*c*Sec[A/3]^2*Sec[B/3] - 
     8*a*c^3*Sec[A/3]^2*Sec[B/3] + 4*a*b*c^2*Sec[A/3]^3*Sec[B/3] + 8*b^3*c*Sec[A/3]*Sec[B/3]^2 - 
     8*b*c^3*Sec[A/3]*Sec[B/3]^2 + 4*a^2*c^2*Sec[A/3]^2*Sec[B/3]^2 + 
     4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2 - 4*c^4*Sec[A/3]^2*Sec[B/3]^2 + 8*a*b^2*c*Sec[B/3]^3 + 
     4*a*b*c^2*Sec[A/3]*Sec[B/3]^3 - 16*a^3*c*Sec[A/3]*Sec[C/3] - 16*a*b^2*c*Sec[A/3]*Sec[C/3] + 
     16*a*c^3*Sec[A/3]*Sec[C/3] + 16*a*b*c^2*Sec[A/3]^2*Sec[C/3] + 8*a*b^2*c*Sec[A/3]^3*Sec[C/3] - 
     16*a^2*b*c*Sec[B/3]*Sec[C/3] - 16*b^3*c*Sec[B/3]*Sec[C/3] + 16*b*c^3*Sec[B/3]*Sec[C/3] - 
     16*a^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] - 16*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] + 
     16*c^4*Sec[A/3]*Sec[B/3]*Sec[C/3] + 4*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
     4*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 4*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
     16*a*b*c^2*Sec[B/3]^2*Sec[C/3] - 4*a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
     4*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 4*a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
     8*a^2*b*c*Sec[B/3]^3*Sec[C/3] + 4*a^2*c^2*Sec[A/3]^2*Sec[C/3]^2 + 
     4*b^2*c^2*Sec[A/3]^2*Sec[C/3]^2 - 4*c^4*Sec[A/3]^2*Sec[C/3]^2 + 2*b^3*c*Sec[A/3]^3*Sec[C/3]^2 - 
     2*b*c^3*Sec[A/3]^3*Sec[C/3]^2 - 8*a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 
     6*a*b^2*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - a*b*c^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
     4*a^2*c^2*Sec[B/3]^2*Sec[C/3]^2 + 4*b^2*c^2*Sec[B/3]^2*Sec[C/3]^2 - 
     4*c^4*Sec[B/3]^2*Sec[C/3]^2 - 6*a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 
     a^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
     c^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 2*a^3*c*Sec[B/3]^3*Sec[C/3]^2 - 
     2*a*c^3*Sec[B/3]^3*Sec[C/3]^2 - a*b*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 
     4*a^3*c*Sec[A/3]*Sec[C/3]^3 + 4*a*b^2*c*Sec[A/3]*Sec[C/3]^3 - 4*a*c^3*Sec[A/3]*Sec[C/3]^3 + 
     4*a^2*b*c*Sec[B/3]*Sec[C/3]^3 + 4*b^3*c*Sec[B/3]*Sec[C/3]^3 - 4*b*c^3*Sec[B/3]*Sec[C/3]^3 - 
     a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + 
     b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
     a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + 
     2*a^2*b*c*Sec[A/3]*Sec[C/3]^4 + 2*a*b^2*c*Sec[B/3]*Sec[C/3]^4 + 
     a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^4)) + 
 b*(((64*a*b^2*c - 32*a^3*b*Sec[A/3] + 32*a*b^3*Sec[A/3] + 32*a*b*c^2*Sec[A/3] + 
      8*a^3*b*Sec[A/3]^3 - 8*a*b^3*Sec[A/3]^3 - 8*a*b*c^2*Sec[A/3]^3 - 4*a*b^2*c*Sec[A/3]^4 - 
      16*a^2*b*c*Sec[A/3]*Sec[B/3] + 8*a^4*Sec[A/3]^2*Sec[B/3] - 8*a^2*b^2*Sec[A/3]^2*Sec[B/3] - 
      8*a^2*c^2*Sec[A/3]^2*Sec[B/3] - 4*a^2*b*c*Sec[A/3]^3*Sec[B/3] + 
      8*a*b*c^2*Sec[A/3]*Sec[B/3]^2 - 2*a*b*c^2*Sec[A/3]^3*Sec[B/3]^2 - 
      4*b^3*c*Sec[A/3]*Sec[B/3]^3 + 4*b*c^3*Sec[A/3]*Sec[B/3]^3 - 2*a^2*c^2*Sec[A/3]^2*Sec[B/3]^3 - 
      2*b^2*c^2*Sec[A/3]^2*Sec[B/3]^3 + 2*c^4*Sec[A/3]^2*Sec[B/3]^3 - 4*a*b^2*c*Sec[B/3]^4 - 
      2*a*b*c^2*Sec[A/3]*Sec[B/3]^4 + 32*a^2*b*c*Sec[C/3] + 32*b^3*c*Sec[C/3] - 32*b*c^3*Sec[C/3] - 
      16*a^4*Sec[A/3]*Sec[C/3] + 16*b^4*Sec[A/3]*Sec[C/3] + 32*a^2*c^2*Sec[A/3]*Sec[C/3] - 
      16*c^4*Sec[A/3]*Sec[C/3] + 8*a^2*b*c*Sec[A/3]^2*Sec[C/3] + 4*a^2*b^2*Sec[A/3]^3*Sec[C/3] - 
      4*b^4*Sec[A/3]^3*Sec[C/3] - 4*a^2*c^2*Sec[A/3]^3*Sec[C/3] + 4*c^4*Sec[A/3]^3*Sec[C/3] - 
      2*b^3*c*Sec[A/3]^4*Sec[C/3] + 2*b*c^3*Sec[A/3]^4*Sec[C/3] - 16*a*b*c^2*Sec[B/3]*Sec[C/3] + 
      a*b*c^2*Sec[A/3]^4*Sec[B/3]*Sec[C/3] + 8*a^2*b*c*Sec[B/3]^2*Sec[C/3] - 
      4*a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 8*a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 
      4*b^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 8*a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
      8*b^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3] - 4*c^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
      2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 2*b^3*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 
      2*b*c^3*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + a^2*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + 
      b^2*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - c^4*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + 
      4*a^3*b*Sec[B/3]^3*Sec[C/3] - 4*a*b^3*Sec[B/3]^3*Sec[C/3] + a*b*c^2*Sec[A/3]^2*Sec[B/3]^3*
       Sec[C/3] - 2*a^2*b*c*Sec[B/3]^4*Sec[C/3] + 8*a*b*c^2*Sec[A/3]*Sec[C/3]^2 - 
      2*a*b*c^2*Sec[A/3]^3*Sec[C/3]^2 - 8*a^2*c^2*Sec[B/3]*Sec[C/3]^2 - 
      8*b^2*c^2*Sec[B/3]*Sec[C/3]^2 + 8*c^4*Sec[B/3]*Sec[C/3]^2 - 4*a^2*b^2*Sec[A/3]^2*Sec[B/3]*
       Sec[C/3]^2 + 4*b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]*
       Sec[C/3]^2 + b^3*c*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - b*c^3*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - 
      2*a^3*b*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*b^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a*b*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*b^2*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a^4*Sec[B/3]^3*Sec[C/3]^2 - 2*a^2*b^2*Sec[B/3]^3*Sec[C/3]^2 - 
      2*a^2*c^2*Sec[B/3]^3*Sec[C/3]^2 + a^2*b*c*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
      8*a^2*b*c*Sec[C/3]^3 - 8*b^3*c*Sec[C/3]^3 + 8*b*c^3*Sec[C/3]^3 + 4*a^4*Sec[A/3]*Sec[C/3]^3 - 
      4*b^4*Sec[A/3]*Sec[C/3]^3 - 4*a^2*c^2*Sec[A/3]*Sec[C/3]^3 + 4*b^2*c^2*Sec[A/3]*Sec[C/3]^3 - 
      2*a^2*b*c*Sec[A/3]^2*Sec[C/3]^3 - 4*a*b*c^2*Sec[B/3]*Sec[C/3]^3 - 
      a^3*b*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + a*b^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      2*a^2*b*c*Sec[B/3]^2*Sec[C/3]^3 - a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + 
      a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
      4*a*b^2*c*Sec[C/3]^4 + 2*a^3*b*Sec[A/3]*Sec[C/3]^4 - 2*a*b^3*Sec[A/3]*Sec[C/3]^4 + 
      a^2*b*c*Sec[A/3]*Sec[B/3]*Sec[C/3]^4)*(64*a^2*b*c - 4*a^2*b*c*Sec[A/3]^4 + 32*a^3*b*Sec[B/3] - 
      32*a*b^3*Sec[B/3] + 32*a*b*c^2*Sec[B/3] - 16*a*b^2*c*Sec[A/3]*Sec[B/3] + 
      8*a*b*c^2*Sec[A/3]^2*Sec[B/3] - 4*a^3*c*Sec[A/3]^3*Sec[B/3] + 4*a*c^3*Sec[A/3]^3*Sec[B/3] - 
      2*a*b*c^2*Sec[A/3]^4*Sec[B/3] - 8*a^2*b^2*Sec[A/3]*Sec[B/3]^2 + 8*b^4*Sec[A/3]*Sec[B/3]^2 - 
      8*b^2*c^2*Sec[A/3]*Sec[B/3]^2 - 2*a^2*c^2*Sec[A/3]^3*Sec[B/3]^2 - 
      2*b^2*c^2*Sec[A/3]^3*Sec[B/3]^2 + 2*c^4*Sec[A/3]^3*Sec[B/3]^2 - 8*a^3*b*Sec[B/3]^3 + 
      8*a*b^3*Sec[B/3]^3 - 8*a*b*c^2*Sec[B/3]^3 - 4*a*b^2*c*Sec[A/3]*Sec[B/3]^3 - 
      2*a*b*c^2*Sec[A/3]^2*Sec[B/3]^3 - 4*a^2*b*c*Sec[B/3]^4 + 32*a^3*c*Sec[C/3] + 
      32*a*b^2*c*Sec[C/3] - 32*a*c^3*Sec[C/3] - 16*a*b*c^2*Sec[A/3]*Sec[C/3] + 
      8*a*b^2*c*Sec[A/3]^2*Sec[C/3] - 4*a^3*b*Sec[A/3]^3*Sec[C/3] + 4*a*b^3*Sec[A/3]^3*Sec[C/3] - 
      2*a*b^2*c*Sec[A/3]^4*Sec[C/3] + 16*a^4*Sec[B/3]*Sec[C/3] - 16*b^4*Sec[B/3]*Sec[C/3] + 
      32*b^2*c^2*Sec[B/3]*Sec[C/3] - 16*c^4*Sec[B/3]*Sec[C/3] - 4*a^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
      8*a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 4*b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
      8*a^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
      4*c^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 8*a*b^2*c*Sec[B/3]^2*Sec[C/3] + 
      2*a^3*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 2*a*b^2*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 
      2*a*c^3*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + a*b*c^2*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 
      4*a^4*Sec[B/3]^3*Sec[C/3] + 4*a^2*b^2*Sec[B/3]^3*Sec[C/3] - 4*b^2*c^2*Sec[B/3]^3*Sec[C/3] + 
      4*c^4*Sec[B/3]^3*Sec[C/3] + a^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 
      b^2*c^2*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - c^4*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] - 
      2*a^3*c*Sec[B/3]^4*Sec[C/3] + 2*a*c^3*Sec[B/3]^4*Sec[C/3] + a*b*c^2*Sec[A/3]*Sec[B/3]^4*
       Sec[C/3] - 8*a^2*c^2*Sec[A/3]*Sec[C/3]^2 - 8*b^2*c^2*Sec[A/3]*Sec[C/3]^2 + 
      8*c^4*Sec[A/3]*Sec[C/3]^2 - 2*a^2*b^2*Sec[A/3]^3*Sec[C/3]^2 + 2*b^4*Sec[A/3]^3*Sec[C/3]^2 - 
      2*b^2*c^2*Sec[A/3]^3*Sec[C/3]^2 + 8*a*b*c^2*Sec[B/3]*Sec[C/3]^2 + 
      2*a^3*b*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 2*a*b^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 
      2*a*b*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + a*b^2*c*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
      4*a^4*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 4*a^2*b^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - 
      4*a^2*c^2*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
      2*a*b*c^2*Sec[B/3]^3*Sec[C/3]^2 + a^3*c*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 
      a*c^3*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 - 8*a^3*c*Sec[C/3]^3 - 8*a*b^2*c*Sec[C/3]^3 + 
      8*a*c^3*Sec[C/3]^3 - 4*a*b*c^2*Sec[A/3]*Sec[C/3]^3 - 2*a*b^2*c*Sec[A/3]^2*Sec[C/3]^3 - 
      4*a^4*Sec[B/3]*Sec[C/3]^3 + 4*b^4*Sec[B/3]*Sec[C/3]^3 + 4*a^2*c^2*Sec[B/3]*Sec[C/3]^3 - 
      4*b^2*c^2*Sec[B/3]*Sec[C/3]^3 + a^2*b^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      b^4*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + b^2*c^2*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      2*a*b^2*c*Sec[B/3]^2*Sec[C/3]^3 + a^3*b*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 
      a*b^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 4*a^2*b*c*Sec[C/3]^4 - 2*a^3*b*Sec[B/3]*Sec[C/3]^4 + 
      2*a*b^3*Sec[B/3]*Sec[C/3]^4 + a*b^2*c*Sec[A/3]*Sec[B/3]*Sec[C/3]^4))/4 - 
   ((64*a*b*c^2 - 32*a^3*c*Sec[A/3] + 32*a*b^2*c*Sec[A/3] + 32*a*c^3*Sec[A/3] + 8*a^3*c*Sec[A/3]^3 - 
      8*a*b^2*c*Sec[A/3]^3 - 8*a*c^3*Sec[A/3]^3 - 4*a*b*c^2*Sec[A/3]^4 + 32*a^2*b*c*Sec[B/3] - 
      32*b^3*c*Sec[B/3] + 32*b*c^3*Sec[B/3] - 16*a^4*Sec[A/3]*Sec[B/3] + 
      32*a^2*b^2*Sec[A/3]*Sec[B/3] - 16*b^4*Sec[A/3]*Sec[B/3] + 16*c^4*Sec[A/3]*Sec[B/3] + 
      8*a^2*b*c*Sec[A/3]^2*Sec[B/3] - 4*a^2*b^2*Sec[A/3]^3*Sec[B/3] + 4*b^4*Sec[A/3]^3*Sec[B/3] + 
      4*a^2*c^2*Sec[A/3]^3*Sec[B/3] - 4*c^4*Sec[A/3]^3*Sec[B/3] + 2*b^3*c*Sec[A/3]^4*Sec[B/3] - 
      2*b*c^3*Sec[A/3]^4*Sec[B/3] + 8*a*b^2*c*Sec[A/3]*Sec[B/3]^2 - 
      2*a*b^2*c*Sec[A/3]^3*Sec[B/3]^2 - 8*a^2*b*c*Sec[B/3]^3 + 8*b^3*c*Sec[B/3]^3 - 
      8*b*c^3*Sec[B/3]^3 + 4*a^4*Sec[A/3]*Sec[B/3]^3 - 4*a^2*b^2*Sec[A/3]*Sec[B/3]^3 + 
      4*b^2*c^2*Sec[A/3]*Sec[B/3]^3 - 4*c^4*Sec[A/3]*Sec[B/3]^3 - 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]^3 - 
      4*a*b*c^2*Sec[B/3]^4 + 2*a^3*c*Sec[A/3]*Sec[B/3]^4 - 2*a*c^3*Sec[A/3]*Sec[B/3]^4 - 
      16*a^2*b*c*Sec[A/3]*Sec[C/3] + 8*a^4*Sec[A/3]^2*Sec[C/3] - 8*a^2*b^2*Sec[A/3]^2*Sec[C/3] - 
      8*a^2*c^2*Sec[A/3]^2*Sec[C/3] - 4*a^2*b*c*Sec[A/3]^3*Sec[C/3] - 16*a*b^2*c*Sec[B/3]*Sec[C/3] + 
      a*b^2*c*Sec[A/3]^4*Sec[B/3]*Sec[C/3] - 8*a^2*b^2*Sec[B/3]^2*Sec[C/3] + 
      8*b^4*Sec[B/3]^2*Sec[C/3] - 8*b^2*c^2*Sec[B/3]^2*Sec[C/3] - 4*a^2*c^2*Sec[A/3]^2*Sec[B/3]^2*
       Sec[C/3] - 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] + 4*c^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3] - 
      b^3*c*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] + b*c^3*Sec[A/3]^3*Sec[B/3]^2*Sec[C/3] - 
      4*a*b^2*c*Sec[B/3]^3*Sec[C/3] - a^3*c*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + 
      a*c^3*Sec[A/3]^2*Sec[B/3]^3*Sec[C/3] + a^2*b*c*Sec[A/3]*Sec[B/3]^4*Sec[C/3] + 
      8*a*b^2*c*Sec[A/3]*Sec[C/3]^2 - 2*a*b^2*c*Sec[A/3]^3*Sec[C/3]^2 + 
      8*a^2*b*c*Sec[B/3]*Sec[C/3]^2 - 4*a^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
      8*a^2*b^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 4*b^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 
      8*a^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 8*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 
      4*c^4*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 + 2*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 
      2*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 2*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 + 
      a^2*b^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - b^4*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 
      b^2*c^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 - 2*a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 2*a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a*b*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 2*a^2*b*c*Sec[B/3]^3*Sec[C/3]^2 - 
      a^4*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + a^2*b^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 
      a^2*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 4*b^3*c*Sec[A/3]*Sec[C/3]^3 - 
      4*b*c^3*Sec[A/3]*Sec[C/3]^3 - 2*a^2*b^2*Sec[A/3]^2*Sec[C/3]^3 + 2*b^4*Sec[A/3]^2*Sec[C/3]^3 - 
      2*b^2*c^2*Sec[A/3]^2*Sec[C/3]^3 + 4*a^3*c*Sec[B/3]*Sec[C/3]^3 - 4*a*c^3*Sec[B/3]*Sec[C/3]^3 + 
      a*b^2*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + 2*a^4*Sec[B/3]^2*Sec[C/3]^3 - 
      2*a^2*b^2*Sec[B/3]^2*Sec[C/3]^3 - 2*a^2*c^2*Sec[B/3]^2*Sec[C/3]^3 + 
      a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - 4*a*b*c^2*Sec[C/3]^4 - 
      2*a*b^2*c*Sec[A/3]*Sec[C/3]^4 - 2*a^2*b*c*Sec[B/3]*Sec[C/3]^4)*
     (-32*a^2*b*c*Sec[A/3] + 8*a^2*b*c*Sec[A/3]^3 - 32*a*b^2*c*Sec[B/3] - 
      48*a*b*c^2*Sec[A/3]*Sec[B/3] + 8*a^3*c*Sec[A/3]^2*Sec[B/3] - 8*a*c^3*Sec[A/3]^2*Sec[B/3] + 
      4*a*b*c^2*Sec[A/3]^3*Sec[B/3] + 8*b^3*c*Sec[A/3]*Sec[B/3]^2 - 8*b*c^3*Sec[A/3]*Sec[B/3]^2 + 
      4*a^2*c^2*Sec[A/3]^2*Sec[B/3]^2 + 4*b^2*c^2*Sec[A/3]^2*Sec[B/3]^2 - 
      4*c^4*Sec[A/3]^2*Sec[B/3]^2 + 8*a*b^2*c*Sec[B/3]^3 + 4*a*b*c^2*Sec[A/3]*Sec[B/3]^3 - 
      16*a^3*c*Sec[A/3]*Sec[C/3] - 16*a*b^2*c*Sec[A/3]*Sec[C/3] + 16*a*c^3*Sec[A/3]*Sec[C/3] + 
      16*a*b*c^2*Sec[A/3]^2*Sec[C/3] + 8*a*b^2*c*Sec[A/3]^3*Sec[C/3] - 
      16*a^2*b*c*Sec[B/3]*Sec[C/3] - 16*b^3*c*Sec[B/3]*Sec[C/3] + 16*b*c^3*Sec[B/3]*Sec[C/3] - 
      16*a^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] - 16*b^2*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3] + 
      16*c^4*Sec[A/3]*Sec[B/3]*Sec[C/3] + 4*a^2*b*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] - 
      4*b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 4*b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3] + 
      16*a*b*c^2*Sec[B/3]^2*Sec[C/3] - 4*a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
      4*a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 4*a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3] + 
      8*a^2*b*c*Sec[B/3]^3*Sec[C/3] + 4*a^2*c^2*Sec[A/3]^2*Sec[C/3]^2 + 
      4*b^2*c^2*Sec[A/3]^2*Sec[C/3]^2 - 4*c^4*Sec[A/3]^2*Sec[C/3]^2 + 
      2*b^3*c*Sec[A/3]^3*Sec[C/3]^2 - 2*b*c^3*Sec[A/3]^3*Sec[C/3]^2 - 
      8*a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^2 - 6*a*b^2*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^2 - 
      a*b*c^2*Sec[A/3]^3*Sec[B/3]*Sec[C/3]^2 + 4*a^2*c^2*Sec[B/3]^2*Sec[C/3]^2 + 
      4*b^2*c^2*Sec[B/3]^2*Sec[C/3]^2 - 4*c^4*Sec[B/3]^2*Sec[C/3]^2 - 
      6*a^2*b*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^2 - a^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 - 
      b^2*c^2*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + c^4*Sec[A/3]^2*Sec[B/3]^2*Sec[C/3]^2 + 
      2*a^3*c*Sec[B/3]^3*Sec[C/3]^2 - 2*a*c^3*Sec[B/3]^3*Sec[C/3]^2 - 
      a*b*c^2*Sec[A/3]*Sec[B/3]^3*Sec[C/3]^2 + 4*a^3*c*Sec[A/3]*Sec[C/3]^3 + 
      4*a*b^2*c*Sec[A/3]*Sec[C/3]^3 - 4*a*c^3*Sec[A/3]*Sec[C/3]^3 + 4*a^2*b*c*Sec[B/3]*Sec[C/3]^3 + 
      4*b^3*c*Sec[B/3]*Sec[C/3]^3 - 4*b*c^3*Sec[B/3]*Sec[C/3]^3 - a^2*b*c*Sec[A/3]^2*Sec[B/3]*
       Sec[C/3]^3 - b^3*c*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 + b*c^3*Sec[A/3]^2*Sec[B/3]*Sec[C/3]^3 - 
      a^3*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 - a*b^2*c*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + 
      a*c^3*Sec[A/3]*Sec[B/3]^2*Sec[C/3]^3 + 2*a^2*b*c*Sec[A/3]*Sec[C/3]^4 + 
      2*a*b^2*c*Sec[B/3]*Sec[C/3]^4 + a*b*c^2*Sec[A/3]*Sec[B/3]*Sec[C/3]^4))/2)
CircleFunction[MorleysAdjunctCircle]:=Null
CircleRadius[MorleysAdjunctCircle]:=Null

Name[MorleyAdjunctTriangle[1]]:="first Morley adjunct triangle"
TrilinearVertexMatrix[MorleyAdjunctTriangle[1]]:={
{2,Sec[C/3],Sec[B/3]},
{Sec[C/3],2,Sec[A/3]},
{Sec[B/3],Sec[A/3],2}
}

Name[MorleyAdjunctTriangle[2]]:="second Morley adjunct triangle"
TrilinearVertexMatrix[MorleyAdjunctTriangle[2]]:={
{2,Sec[(C-2Pi)/3],Sec[(2Pi-B)/3]},
{Sec[(2Pi-C)/3],2,Sec[(2Pi-A)/3]},
{Sec[(2Pi-B)/3],Sec[(2Pi-A)/3],2}
}

Name[MorleyAdjunctTriangle[3]]:="third Morley adjunct triangle"
TrilinearVertexMatrix[MorleyAdjunctTriangle[3]]:={
{2,Sec[(C-4Pi)/3],Sec[(4Pi-B)/3]},
{Sec[(4Pi-C)/3],2,Sec[(4Pi-A)/3]},
{Sec[(4Pi-B)/3],Sec[(4Pi-A)/3],2}
}

Name[MorleyCubic[1]]:="first Morley cubic"
CubicEquation[MorleyCubic[1]]:=CyclicSum[(Cos[A/3]+2Cos[B/3]Cos[C/3])\[Alpha](\[Beta]^2-\[Gamma]^2)]

Name[MorleyCubic[2]]:="second Morley cubic"
CubicEquation[MorleyCubic[2]]:=CyclicSum[(Cos[(A+2Pi)/3]+2Cos[(B+2Pi)/3]Cos[(C+2Pi)/3])\[Alpha](\[Beta]^2-\[Gamma]^2)]

Name[MorleyCubic[3]]:="third Morley cubic"
CubicEquation[MorleyCubic[3]]:=CyclicSum[(Cos[(A-2Pi)/3]+2Cos[(B-2Pi)/3]Cos[(C-2Pi)/3])\[Alpha](\[Beta]^2-\[Gamma]^2)]

Name[MorleysCircle]:="Morley's circle"
CircleCenterFunction[MorleysCircle]:=Cos[A/3] + 2*Cos[B/3]*Cos[C/3]
CircleFunction[MorleysCircle]:=
(-2*(4*c*Cos[B/3]^3*(b^2 + 4*Cos[A/3]*(b*c + (-a^2 + c^2)*Cos[A/3]) - 
     2*a*b*(1 + 2*Cos[(2*A)/3])*Cos[C/3]) + 
   4*Cos[B/3]^2*(2*a*b*c*Cos[A/3] + a*(a^2 - b^2 - c^2)*Cos[(2*A)/3] - 
     (4*c*(-2*a^2 + b^2 + 2*c^2)*Cos[A/3] + b*(a^2 - b^2 + 6*c^2 + 6*c^2*Cos[(2*A)/3]) + 
       2*c*(-a^2 + b^2 + c^2)*Cos[A])*Cos[C/3] + a*(a^2 - b^2 - c^2)*(1 + 2*Cos[(2*A)/3])*
      Cos[(2*C)/3]) + Cos[C/3]*(8*c*(-a^2 + b^2 + c^2)*Cos[A/3]^3 + 16*b*c^2*Cos[A/3]^4 + 
     8*Cos[A/3]^2*Cos[C/3]*(a*(-a^2 + b^2 + c^2) + 2*b*(-a^2 + b^2)*Cos[C/3]) + 
     b*c^2*(1 + 2*Cos[(2*C)/3]) + 2*c*Cos[A/3]*(a^2 + 3*b^2 - c^2 + 
       4*b*(a*Cos[C/3] + b*Cos[(2*C)/3]))) - 
   Cos[B/3]*(-16*b*c*Cos[A/3]^4*(b + 2*a*Cos[C/3]) + 8*b*(-a^2 + b^2 + c^2)*Cos[A/3]^3*
      (1 + 2*Cos[(2*C)/3]) + 16*b*c*Cos[A/3]^2*Cos[C/3]*(3*b*Cos[C/3] + 
       a*(2 + Cos[(2*C)/3])) + 2*Cos[A/3]*(4*a*(-a^2 + b^2 + c^2)*Cos[C/3] + 
       b*(-3*a^2 + 3*b^2 - c^2 - 2*(a^2 - b^2 + c^2)*Cos[(2*C)/3])) + 
     c*(2*a^2 + b^2 - 2*c^2 + 2*(a - c)*(a + c)*Cos[(2*C)/3] - 2*a*b*Cos[C]))))/
 ((c + 2*b*Cos[A/3] + 2*a*Cos[B/3])*(b + 2*c*Cos[A/3] + 2*a*Cos[C/3])*
  (a + 2*c*Cos[B/3] + 2*b*Cos[C/3])*(5 + 2*Cos[(2*A)/3] + 2*Cos[(2*B)/3] - 
   16*Cos[A/3]*Cos[B/3]*Cos[C/3] + 2*Cos[(2*C)/3]))
CircleRadius[MorleysCircle]:=
(a*b*c*Sqrt[(1 + 2*Cos[(2*B)/3])*(1 + 2*Cos[(2*C)/3])*(Cos[(2*B)/3] - Cos[(4*B)/3] + 
     2*Cos[(2*(B - C))/3] + Cos[A + B/3 - C/3] + Cos[A - B/3 + C/3] + Cos[(2*C)/3] - 
     Cos[(4*C)/3] + 2*Cos[(2*(B + C))/3] - Cos[(4*(B + C))/3] + Cos[(3*A + B + C)/3])])/
 (Sqrt[2]*(a + 2*c*Cos[B/3] + 2*b*Cos[C/3])*(c*Cos[C/3] + Cos[B/3]*(b + 2*a*Cos[C/3]) + 
   Cos[A/3]*(a + 2*c*Cos[B/3] + 2*b*Cos[C/3])))

Name[MorleyTriangle[1]]:="first Morley triangle"
TrilinearVertexMatrix[MorleyTriangle[1]]:={
{1,2Cos[C/3],2Cos[B/3]},
{2Cos[C/3],1,2Cos[A/3]},
{2Cos[B/3],2Cos[A/3],1}
}

Name[MorleyTriangle[2]]:="second Morley triangle"
TrilinearVertexMatrix[MorleyTriangle[2]]:={
{1,2Cos[(C-2Pi)/3],2Cos[(B-2Pi)/3]},
{2Cos[(C-2Pi)/3],1,2Cos[(A-2Pi)/3]},
{2Cos[(B-2Pi)/3],2Cos[(A-2Pi)/3],1}
}

Name[MorleyTriangle[3]]:="third Morley triangle"
TrilinearVertexMatrix[MorleyTriangle[3]]:={
{1,2Cos[(C-4Pi)/3],2Cos[(B-4Pi)/3]},
{2Cos[(C-4Pi)/3],1,2Cos[(A-4Pi)/3]},
{2Cos[(B-4Pi)/3],2Cos[(A-4Pi)/3],1}
}

Name[MosesCircle]:="Moses circle"
CircleFunction[MosesCircle]:=(a^2*b*c - 2*b^3*c - 2*b*c^3)/(4*(a^2*b^2 + a^2*c^2 + b^2*c^2))
CircleCenterFunction[MosesCircle]:=a*(b^2 + c^2)
CircleRadius[MosesCircle]:=(a*b*c*Sqrt[(a+b-c)*(a-b+c)*(-a+b+c)*(a+b+c)])/(2*(a^2*b^2+a^2*c^2+b^2*c^2))

Name[MosesLonguetHigginsCircle]:="Moses-Longuet-Higgins circle"
CircleFunction[MosesLonguetHigginsCircle]:=-(b+c)^2/(b c)
CircleCenterFunction[MosesLonguetHigginsCircle]:=(a^2 (SA-4 sa^2)+4 (sc^2 SB+sb^2 SC))/a
CircleRadius[MosesLonguetHigginsCircle]:=Sqrt[9 Circumradius^2 + 
    4 Inradius^2 (1 - (12 (a + b + c) Circumradius^2) / (a b c))]

mPQn[{p1_,p2_,p3_},{q1_,q2_,q3_},m_,n_]:=(n-m) {p1,p2,p3} (q1+q2+q3)+ m {q1,q2,q3} (p1+p2+p3)

Name[NagelLine]:="Nagel line"
LineFunction[NagelLine]:=a(b-c)
CenterLine[X[649]]:=NagelLine

Name[NagelPoint]:="Nagel point"
CenterFunction[NagelPoint]:=(-a+b+c)/a

Name[NapoleonFeuerbachCubic]:="Napoleon-Feuerbach cubic"
PivotalIsogonalCubicFunction[NapoleonFeuerbachCubic]:=Cos[B-C]

CenterFunction[NapoleonPoint[1]]:=Csc[A+Pi/6]
Name[NapoleonPoint[1]]:="first Napoleon point"

CenterFunction[NapoleonPoint[2]]:=Csc[A-Pi/6]
Name[NapoleonPoint[2]]:="second Napoleon point"

(*
NapoleonTriangle[s_][t_Triangle]:=Triangle[
	ErectedPolygonCenters[Vertices[t],3,-(3-2s)Orientation[t]]
]/; s==1||s==2

NapoleonTriangle[v_List,a_List,tri_List]:=Module[
	{sc=ErectScaleneTriangles[v,a],i,s=SideLengths[v],n,ntri,ns},
	n=Table[TrilinearToCartesian[Take[sc[[i,1]],3],RotateRight[tri,i-1]],{i,3}];
(*
	ns=SideLengths[n];
  	ntri=N[Sides/@Table[Take[np[[i,1]],3],{i,3}]];
*)
	Triangle[n]
]		
*)

NapoleonTriangleRatios[v_List,a_List,tri_List]:=Module[
	{sc=ErectScaleneTriangles[v,a],i,s=SideLengths[v],n,ntri,ns},
	n=Table[TrilinearToCartesian[Take[sc[[i,1]],3],RotateRight[tri,i-1]],{i,3}];
	ns=SideLengths[n];
  	ntri=N[Sides/@Table[Take[np[[i,1]],3],{i,3}]];
	{Sort[ns]/Min[ns],Table[Sort[ntri[[i]]]/Min[ntri[[i]]],{i,3}]}
]

NeubergCircle[Line[{v2_,v3_}],w_,1]:=Module[
	{
	a1=Sqrt[#.#]&[v3-v2],
	rot={{Cos[#],-Sin[#]},{Sin[#],Cos[#]}}&[ArcTan@@(v3-v2)]
	},
    Circle[v2+rot.{1,Cot[w]}a1/2,Sqrt[Cot[w]^2-3]a1/2]
]

NeubergCircle[line:Line[{v2_,v3_}],w_,-1]:=NeubergCircle[line,w,1]/.
	Circle[x_,r_]:>Circle[Coordinates[Reflection[Point[x],line]],r]

CircleTripletFunction[NeubergCircles[1]]:={
	{a b c(a^2+b^2+c^2),c(-a^4-b^4+a^2c^2+b^2c^2),b(-a^4+a^2b^2+b^2c^2-c^4)},
	Sqrt[Cot[BrocardAngle]^2-3]a/2
}

CircleTripletFunction[NeubergCircles[2]]:={
	{a b c(a^2+b^2+c^2),c(-2a^2b^2-a^2c^2-b^2c^2+c^4),b(-a^2b^2+b^4-2a^2c^2-b^2c^2)},
	Sqrt[Cot[BrocardAngle]^2-3]a/2
}

Name[NeubergCirclesRadicalCircle[1]]:="Neuberg circles radical circle"
CircleFunction[NeubergCirclesRadicalCircle[1]]:=-(-a^2*b^4 + b^4*c^2 - a^2*c^4 + b^2*c^4)/(b*c*(a^2*b^2 + a^2*c^2 + b^2*c^2))
CircleCenterFunction[NeubergCirclesRadicalCircle[1]]:=(a^2b^2+a^2c^2-b^2c^2)/a
CircleRadius[NeubergCirclesRadicalCircle[1]]:=Sqrt[a^6*b^4 + a^4*b^6 - 2*a^6*b^2*c^2 + a^4*b^4*c^2 - 2*a^2*b^6*c^2 + a^6*c^4 + 
   a^4*b^2*c^4 + a^2*b^4*c^4 + b^6*c^4 + a^4*c^6 - 2*a^2*b^2*c^6 + b^4*c^6]/
 (a^2*b^2 + a^2*c^2 + b^2*c^2)

Name[NeubergCubic]:="Neuberg cubic"
PivotalIsogonalCubicFunction[NeubergCubic]:=Cos[A]-2Cos[B]Cos[C]

Name[NeubergCircle[1]]:="first Neuberg circle"
CircleCenterFunction[NeubergCircle[1]]:=
	(a^4*b^4 + a^4*b^2*c^2 + a^2*b^4*c^2 - b^6*c^2 + a^4*c^4 + a^2*b^2*c^4 - b^2*c^6)/a
CircleFunction[NeubergCircle[1]]:=
	-((a^6*b^4 + a^2*b^8 + a^6*b^2*c^2 - a^4*b^4*c^2 + a^6*c^4 - a^4*b^2*c^4 - a^2*b^4*c^4 - 
   b^6*c^4 - b^4*c^6 + a^2*c^8)/(b*(a - b - c)*(a + b - c)*c*(a - b + c)*(a + b + c)*
   (a^2*b^2 + a^2*c^2 + b^2*c^2)))
CircleRadius[NeubergCircle[1]]:=
	Sqrt[(a^6 + a^4*b^2 + a^2*b^4 + b^6 - a^2*b^2*c^2)*(a^6 + a^4*c^2 - a^2*b^2*c^2 + 
    a^2*c^4 + c^6)*(b^6 - a^2*b^2*c^2 + b^4*c^2 + b^2*c^4 + c^6)]/
 (16*Area^2*(a^2*b^2 + a^2*c^2 + b^2*c^2))

Name[NeubergCircle[2]]:="second Neuberg circle"
CircleCenterFunction[NeubergCircle[2]]:=
(-a^8 - a^6*b^2 + a^4*b^4 - a^6*c^2 + 3*a^4*b^2*c^2 + 4*a^2*b^4*c^2 + a^4*c^4 + 4*a^2*b^2*c^4 + 
  2*b^4*c^4)/a
CircleFunction[NeubergCircle[2]]:=
-((2*a^6*b^4 + 5*a^6*b^2*c^2 + 6*a^4*b^4*c^2 + 2*a^2*b^6*c^2 + b^8*c^2 + 2*a^6*c^4 + 6*a^4*b^2*c^4 + 
   5*a^2*b^4*c^4 + 2*b^6*c^4 + 2*a^2*b^2*c^6 + 2*b^4*c^6 + b^2*c^8)/
  (b*(a - b - c)*(a + b - c)*c*(a - b + c)*(a + b + c)*(a^4 + 3*a^2*b^2 + b^4 + 3*a^2*c^2 + 
    3*b^2*c^2 + c^4)))
CircleRadius[NeubergCircle[2]]:=
Sqrt[(a^4*b^2 + a^2*b^4 - b^6 + 2*a^4*c^2 + 5*a^2*b^2*c^2 + b^4*c^2 + 2*a^2*c^4 + b^2*c^4)*
   (-a^6 + a^4*b^2 + a^2*b^4 + a^4*c^2 + 5*a^2*b^2*c^2 + 2*b^4*c^2 + a^2*c^4 + 2*b^2*c^4)*
   (2*a^4*b^2 + 2*a^2*b^4 + a^4*c^2 + 5*a^2*b^2*c^2 + b^4*c^2 + a^2*c^4 + b^2*c^4 - c^6)]/
 (16*Area^2*(a^4 + 3*a^2*b^2 + b^4 + 3*a^2*c^2 + 3*b^2*c^2 + c^4))

Name[NeubergTriangle[1]]:="first Neuberg triangle"
TrilinearVertexMatrix[NeubergTriangle[1]]:=
{{a*b*c*(a^2 + b^2 + c^2), c*(-a^4 - b^4 + a^2*c^2 + b^2*c^2), 
  b*(-a^4 + a^2*b^2 + b^2*c^2 - c^4)}, {c*(-a^4 - b^4 + a^2*c^2 + b^2*c^2), 
  a*b*c*(a^2 + b^2 + c^2), a*(a^2*b^2 - b^4 + a^2*c^2 - c^4)}, 
 {b*(-a^4 + a^2*b^2 + b^2*c^2 - c^4), a*(a^2*b^2 - b^4 + a^2*c^2 - c^4), 
  a*b*c*(a^2 + b^2 + c^2)}}

Name[NeubergTriangle[2]]:="second Neuberg triangle"
TrilinearVertexMatrix[NeubergTriangle[2]]:=
{{a*b*c*(a^2 + b^2 + c^2), c*(-2*a^2*b^2 - a^2*c^2 - b^2*c^2 + c^4), 
  b*(-(a^2*b^2) + b^4 - 2*a^2*c^2 - b^2*c^2)}, 
 {c*(-2*a^2*b^2 - a^2*c^2 - b^2*c^2 + c^4), a*b*c*(a^2 + b^2 + c^2), 
  a*(a^4 - a^2*b^2 - a^2*c^2 - 2*b^2*c^2)}, 
 {b*(-(a^2*b^2) + b^4 - 2*a^2*c^2 - b^2*c^2), 
  a*(a^4 - a^2*b^2 - a^2*c^2 - 2*b^2*c^2), a*b*c*(a^2 + b^2 + c^2)}}

NinePointCenterBarycentric[Triangle[{{p1_,q1_,r1_},{p2_,q2_,r2_},{p3_,q3_,r3_}}]]:=
  mPQn[CentroidBarycentric[Triangle[{{p1,q1,r1},{p2,q2,r2},{p3,q3,r3}}]],
    CircumcenterBarycentric[Triangle[{{p1,q1,r1},{p2,q2,r2},{p3,q3,r3}}]],1,-2]
NinePointCenter[Triangle[{{p1t_,p2t_,p3t_},{q1t_,q2t_,q3t_},{r1t_,r2t_,r3t_}}]]:=
  Module[{p1,p2,p3,q1,q2,q3,r1,r2,
      r3},{{p1,p2,p3},{q1,q2,q3},{r1,r2,
          r3}}=({a,b,c}#&)/@{{p1t,p2t,p3t},{q1t,q2t,q3t},{r1t,r2t,r3t}};
    NinePointCenterBarycentric[Triangle[{{p1,p2,p3},{q1,q2,q3},{r1,r2,r3}}]]/{a,b,c}]
NinePointCenter[t_]:=NinePointCenter[Triangle[t]] /; MemberQ[Triangles,t]

CenterFunction[NinePointCenter]:=Cos[B-C]
Name[NinePointCenter]:="nine-point center"

Name[NinePointCircle]:="nine-point circle"
CircleFunction[NinePointCircle]:=-Cos[A]/2
CircleCenterFunction[NinePointCircle]:=CenterFunction[NinePointCenter]
CircleRadius[NinePointCircle]:=Circumradius/2

NinePointCircles[tri_List]:=Module[{i,s,n=Length[tri]},
	s=Subsets[Range[n],{3}];
	NinePointCircle/@Table[tri[[s[[i]]]],{i,Length[s]}]
]

NKTransform[{x_,y_,z_}]:={(y^2 + z^2)x, (z^2 + x^2)y, (x^2 + y^2)z}
NKTransform[ctr_]:=NKTransform[Trilinears[ctr]] /; MemberQ[Centers,ctr]

NobbsPoints:={{-b(a-b+c),a(-a+b+c),0},{0,-(a+b-c)c,b(a-b+c)},{(a+b-c)c,0,-a(-a+b+c)}}

Normsq[pt_List]:=pt.pt

norm[pt_List]:=Sqrt[Normsq[pt]]

(*
ObtuseQ[t_Triangle]:=Module[{a,b,c},
    {a,b,c}=SideLengths[t];
    a^2+b^2-c^2<0||b^2+c^2-a^2<0||c^2+a^2-b^2<0
]
*)

ObtuseQ[]:=
	(a^2+b^2>c^2&&a^2+c^2>c^2&&b^2+c^2<a^2&&Pi/2<A<Pi&&0<Pi/2<B&&0<Pi/2<C)||
	(a^2+b^2>c^2&&a^2+c^2<c^2&&b^2+c^2>a^2&&Pi/2<B<Pi&&0<Pi/2<A&&0<Pi/2<C)||
	(a^2+b^2<c^2&&a^2+c^2>c^2&&b^2+c^2>a^2&&Pi/2<C<Pi&&0<Pi/2<A&&0<Pi/2<C)

ObtuseQ[t_Triangle]:=Max[Angles[t]]>Pi/2

cross[x1_,x2_]:=x1[[1]]x2[[2]]-x2[[1]]x1[[2]]

Orientation[t:(_Triangle|_Quadrilateral|_Polygon)]:=Module[{v=Vertices[t]},
	Sign[cross[v[[2]]-v[[1]],v[[3]]-v[[2]]]]
]

Name[OrthicAxis]:="orthic axis"
LineFunction[OrthicAxis]:=Cos[A]
CenterLine[X[3]]:=OrthicAxis

Name[OrthicInconic]:="orthic inconic"
InconicParameters[OrthicInconic]:={Cos[A],Cos[B],Cos[C]}

Name[OrthicTriangle]:="orthic triangle"
TrilinearVertexMatrix[OrthicTriangle]:=
{{0,Sec[B],Sec[C]},{Sec[A],0,Sec[C]},{Sec[A],Sec[B],0}}

CenterFunction[Orthocenter]:=Sec[A]
Name[Orthocenter]:="orthocenter"

(*
Orthocenter[Triangle[t_?MatrixQ]]:=
  Intersections@@
    Take[PerpendicularLine@@@
        Transpose[{TrilinearLine/@Sides[Triangle[t]],Vertices[Triangle[t]]}],2]
*)

(*
OrthocenterBarycentric[Triangle[{{p1_,q1_,r1_},{p2_,q2_,r2_},{p3_,q3_,r3_}}]]:=
  mPQn[CentroidBarycentric[Triangle[{{p1,q1,r1},{p2,q2,r2},{p3,q3,r3}}]],
    CircumcenterBarycentric[Triangle[{{p1,q1,r1},{p2,q2,r2},{p3,q3,r3}}]],-2,1]
Orthocenter[Triangle[{{p1t_, p2t_, p3t_}, {q1t_, q2t_, q3t_}, {r1t_, r2t_, r3t_}}]] := 
  Module[{p1, p2, p3, q1, q2, q3, r1, r2, r3}, 
   {{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}} = ({a, b, c}# & ) /@ 
      {{p1t, p2t, p3t}, {q1t, q2t, q3t}, {r1t, r2t, r3t}}; 
    OrthocenterBarycentric[Triangle[{{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}}]]/{a, b, c}
]
*)

Orthocenter[Triangle[{{p1_,q1_,r1_},{p2_,q2_,r2_},{p3_,q3_,r3_}}]] := 
{((-p1)*((-p3)*q2 + p2*q3) + r1*((-q3)*r2 + q2*r3) + 
     p1*(p3*r2 - p2*r3)*Cos[A] - ((-p3)*q2 + p2*q3)*r1*Cos[B] + 
     p1*((-q3)*r2 + q2*r3)*Cos[B] - r1*(p3*r2 - p2*r3)*Cos[C])*
    (p2*((-p3)*r1 + p1*r3) - q2*(q3*r1 - q1*r3) - 
     p2*(p3*q1 - p1*q3)*Cos[A] + q2*(p3*q1 - p1*q3)*Cos[B] + 
     q2*((-p3)*r1 + p1*r3)*Cos[C] - p2*(q3*r1 - q1*r3)*Cos[C]) - 
   ((-p2)*(p3*q1 - p1*q3) + r2*(q3*r1 - q1*r3) + 
     p2*((-p3)*r1 + p1*r3)*Cos[A] - (p3*q1 - p1*q3)*r2*Cos[B] + 
     p2*(q3*r1 - q1*r3)*Cos[B] - r2*((-p3)*r1 + p1*r3)*Cos[C])*
    (p1*(p3*r2 - p2*r3) - q1*((-q3)*r2 + q2*r3) - 
     p1*((-p3)*q2 + p2*q3)*Cos[A] + q1*((-p3)*q2 + p2*q3)*
      Cos[B] + q1*(p3*r2 - p2*r3)*Cos[C] - p1*((-q3)*r2 + q2*r3)*
      Cos[C]), (q2*(p3*q1 - p1*q3) - r2*((-p3)*r1 + p1*r3) + 
     (p3*q1 - p1*q3)*r2*Cos[A] - q2*((-p3)*r1 + p1*r3)*Cos[A] - 
     q2*(q3*r1 - q1*r3)*Cos[B] + r2*(q3*r1 - q1*r3)*Cos[C])*
    (p1*(p3*r2 - p2*r3) - q1*((-q3)*r2 + q2*r3) - 
     p1*((-p3)*q2 + p2*q3)*Cos[A] + q1*((-p3)*q2 + p2*q3)*
      Cos[B] + q1*(p3*r2 - p2*r3)*Cos[C] - p1*((-q3)*r2 + q2*r3)*
      Cos[C]) - (p2*((-p3)*r1 + p1*r3) - q2*(q3*r1 - q1*r3) - 
     p2*(p3*q1 - p1*q3)*Cos[A] + q2*(p3*q1 - p1*q3)*Cos[B] + 
     q2*((-p3)*r1 + p1*r3)*Cos[C] - p2*(q3*r1 - q1*r3)*Cos[C])*
    (q1*((-p3)*q2 + p2*q3) - r1*(p3*r2 - p2*r3) + 
     ((-p3)*q2 + p2*q3)*r1*Cos[A] - q1*(p3*r2 - p2*r3)*Cos[A] - 
     q1*((-q3)*r2 + q2*r3)*Cos[B] + r1*((-q3)*r2 + q2*r3)*
      Cos[C]), 
  (-((-p1)*((-p3)*q2 + p2*q3) + r1*((-q3)*r2 + q2*r3) + 
      p1*(p3*r2 - p2*r3)*Cos[A] - ((-p3)*q2 + p2*q3)*r1*Cos[B] + 
      p1*((-q3)*r2 + q2*r3)*Cos[B] - r1*(p3*r2 - p2*r3)*Cos[C]))*
    (q2*(p3*q1 - p1*q3) - r2*((-p3)*r1 + p1*r3) + 
     (p3*q1 - p1*q3)*r2*Cos[A] - q2*((-p3)*r1 + p1*r3)*Cos[A] - 
     q2*(q3*r1 - q1*r3)*Cos[B] + r2*(q3*r1 - q1*r3)*Cos[C]) + 
   ((-p2)*(p3*q1 - p1*q3) + r2*(q3*r1 - q1*r3) + 
     p2*((-p3)*r1 + p1*r3)*Cos[A] - (p3*q1 - p1*q3)*r2*Cos[B] + 
     p2*(q3*r1 - q1*r3)*Cos[B] - r2*((-p3)*r1 + p1*r3)*Cos[C])*
    (q1*((-p3)*q2 + p2*q3) - r1*(p3*r2 - p2*r3) + 
     ((-p3)*q2 + p2*q3)*r1*Cos[A] - q1*(p3*r2 - p2*r3)*Cos[A] - 
     q1*((-q3)*r2 + q2*r3)*Cos[B] + r1*((-q3)*r2 + q2*r3)*Cos[C])}

Orthocenter[t_]:=Orthocenter[Triangle[t]] /; MemberQ[Triangles,t]

Name[OrthocentroidalCircle]:="orthocentroidal circle"
CircleFunction[OrthocentroidalCircle]:=-2Cos[A]/3
CircleCenterFunction[OrthocentroidalCircle]:=2Cos[B-C]-Cos[A]
CircleRadius[OrthocentroidalCircle]:=1/(12Area)Sqrt[(a^2-b^2)^2*(a^2+b^2)-(a^4-3*a^2*b^2+b^4)*c^2-(a^2+b^2)*c^4+c^6]

Orthocorrespondent[{p_, q_, r_}] := {a*b*c*q*r - a*p^2*SA + b*p*q*SB + c*p*r*SC, 
   a*b*c*p*r + a*p*q*SA - b*q^2*SB + c*q*r*SC,
   a*b*c*p*q + a*p*r*SA + b*q*r*SB - c*r^2*SC}

Orthocorrespondent[ctr_]:=Orthocorrespondent[Trilinears[ctr]] /; MemberQ[Centers,ctr]

Name[Orthocubic]:="orthocubic"
PivotalIsogonalCubicFunction[Orthocubic]:=Cos[B]Cos[C]

orthogonalQ[c__]:=Plus@@((CircleRadius/@{c})^2)-(Distance@@(Center/@{c}))^2==0
OrthogonalQ[c__]:=orthogonalQ[c]/; And@@(MemberQ[CentralCircles,#]&/@{c})
OrthogonalQ[c__Circle]:=orthogonalQ[c] /; Length[{c}]==2

OrthogonalQ[Line[l1_],Line[l2_]]:=
	Dot@@Subtract@@@{l1,l2}==0. /; Dimensions[{l1,l2}]=={2,2,2}
OrthogonalQ[TrilinearLine[{l_,m_,n_}],TrilinearLine[{ll_,mm_,nn_}]]:=
	l ll+m mm+n nn-(m nn+mm n)Cos[A]-(n ll+nn l)Cos[B]-(l mm+ll m)Cos[C]==0
OrthogonalQ[line1_TrilinearLine,line2_]:=OrthogonalQ[line1,TrilinearLine[line2]] /;
	MemberQ[Lines,line2]
OrthogonalQ[line2_,line1_TrilinearLine]:=OrthogonalQ[line1,TrilinearLine[line2]] /;
	MemberQ[Lines,line2]
OrthogonalQ[line1_,line2_]:=OrthogonalQ[TrilinearLine[line1],TrilinearLine[line2]] /;
	And@@(MemberQ[Lines,#]&/@{line1,line2})

(*Orthopole[TrilinearPolar[IsogonalConjugate[ctr]]]*)
Orthojoin[ctr_]:=Orthopole[Trilinears[ctr]] /; MemberQ[Centers,ctr]
Orthojoin[tri_?VectorQ]:=Orthopole[tri] /; Length[tri]==3

OrthopolarLine[q_Quadrilateral,l_Line,dr_:0]:=
  LongestLine[Coordinates[Orthopole[#,l]]&/@(Triangle/@Subsets[Vertices[q],{3}]),dr]
  
Orthopole[{l_,m_,n_}]:=
{  ((l - n*Cos[B] - m*Cos[C])*((a^4 - (b^2 - c^2)^2)* l - 4*a^2*b*c*(m*Cos[B] + n*Cos[C])))/a, 
 -(((m - n*Cos[A] - l*Cos[C])*((-b^4 + (a^2 - c^2)^2)*m + 4*a*b^2*c*(l*Cos[A] + n*Cos[C])))/b), 
 -(((n - m*Cos[A] - l*Cos[B])*(((a^2 - b^2)^2 - c^4)* n + 4*a*b*c^2*(l*Cos[A] + m*Cos[B])))/c)}

Orthopole[line_]:=Orthopole[Trilinears[line]] /; MemberQ[Lines,line]
Orthopole[eqn_]:=Orthopole[Coefficient[eqn,#]&/@{\[Alpha],\[Beta],\[Gamma]}]

Orthopole[t_Triangle,line_Line]:=Module[
	{l1,l2,i,v=Vertices@t},
	l1=PerpendicularLine[Point[#],line]&/@v;
	l2=Table[PerpendicularLine[BeginPoint@l1[[i]],
		Line@v[[{addn[i,1,3],addn[i,2,3]}]]],{i,3}];
	Intersections[l2[[1]],l2[[2]]]
]

OrthopoleLines[t_Triangle,line_Line]:=Module[
	{l1,l2,p,i,v=Vertices@t,l=First@Line},
	l1=Table[PerpendicularLine[Point[v[[i]]],line],{i,3}];
	l2=Table[PerpendicularLine[Point[l1[[i,1]]],Line@v[[{addn[i,1,3],addn[i,2,3]}]]],{i,3}];
	p=Intersections[Line@l2[[1]],Line@l2[[2]]];
	{
	Line/@l1,
	Table[LongestLine[{p,l2[[i,1]],l2[[i,2]]}],{i,3}],
	{Dashing[{.02,.02}],Table[Line[{l2[[i,1]],v[[addn[i,1,3]]]}],{i,3}]}
	}
]

OrthopolePoints[t_Triangle,line_Line]:=Module[
	{l1,l2,p,i,v=Vertices@t,l=First@Line},
	l1=Table[PerpendicularLine[Point[v[[i]]],line],{i,3}];
	l2=Table[PerpendicularLine[Poine[l1[[i,1]]],Line@v[[{addn[i,1,3],addn[i,2,3]}]]][[1]],{i,3}];
	{Point/@Table[l1[[i,1]],{i,3}],Point/@l2}
]

Name[OrthopticCircleOfTheSteinerInellipse]:="orthoptic circle of the Steiner inellipse"
CircleFunction[OrthopticCircleOfTheSteinerInellipse]:=-Cos[A]/3
CircleCenterFunction[OrthopticCircleOfTheSteinerInellipse]:=1/a
CircleRadius[OrthopticCircleOfTheSteinerInellipse]:=Sqrt[(a^2 + b^2 + c^2) / 18]

Name[OuterGriffithsPoint]:="outer Griffiths point"
CenterFunction[OuterGriffithsPoint]:=1-8Area/a/(-a+b+c)

Name[OuterNapoleonCircle]:="outer Napoleon circle"
CircleCenterFunction[OuterNapoleonCircle]:=1/a
CircleFunction[OuterNapoleonCircle]:=-(Sqrt[3]S+3SA)/(9b c)
CircleRadius[OuterNapoleonCircle]:=Sqrt[a^2 + b^2 + c^2 + 4*Sqrt[3]Area]/(3*Sqrt[2])

Name[OuterNapoleonTriangle]:="outer Napoleon triangle"
TrilinearVertexMatrix[OuterNapoleonTriangle]:=
  MapIndexed[
    RotateRight[#1,#2-1]&,{-1,2Sin[#3+Pi/6],2Sin[#2+Pi/6]}&@@@
      NestList[RotateLeft,{A,B,C},2]]

Name[OuterRigbyPoint]:="outer Rigby point"
CenterFunction[OuterRigbyPoint]:=1-8/3Area/a/(-a+b+c)

CenterFunction[OuterSoddyCenter]:=Sec[A/2]Cos[B/2]Cos[C/2]-1
Name[OuterSoddyCenter]:="outer Soddy center (isoperimetric point)"

Name[OuterSoddyCircle]:="outer Soddy circle"
CircleFunction[OuterSoddyCircle]:=With[{
	rA=4Circumradius Sin[A/2]Cos[B/2]Cos[C/2],
	rB=4Circumradius Cos[A/2]Sin[B/2]Cos[C/2],
	rC=4Circumradius Cos[A/2]Cos[B/2]Sin[C/2]
	},
	-((c^2 (b-rB)^2+b^2 (c-rC)^2+2 (b-rB) (c-rC) SA)/(rA+rB+rC-2 Semiperimeter)^2-(S^2/
		(4 Semiperimeter (S (Cot[BrocardAngle]-1)-Semiperimeter^2)))^2)/(b c)]
(*
(-a+b+c)^2*
	((-15*a^8 - 52*a^7*b + 208*a^6*b^2 - 20*a^5*b^3 - 406*a^4*b^4 + 324*a^3*b^5 + 
      56*a^2*b^6 - 124*a*b^7 + 29*b^8 - 52*a^7*c + 96*a^6*b*c + 276*a^5*b^2*c - 424*a^4*b^3*c - 
      396*a^3*b^4*c + 624*a^2*b^5*c + 44*a*b^6*c - 168*b^7*c + 208*a^6*c^2 + 276*a^5*b*c^2 - 
      388*a^4*b^2*c^2 + 72*a^3*b^3*c^2 - 952*a^2*b^4*c^2 + 612*a*b^5*c^2 + 172*b^6*c^2 - 20*a^5*c^3 - 
      424*a^4*b*c^3 + 72*a^3*b^2*c^3 + 544*a^2*b^3*c^3 - 532*a*b^4*c^3 + 360*b^5*c^3 - 406*a^4*c^4 - 
      396*a^3*b*c^4 - 952*a^2*b^2*c^4 - 532*a*b^3*c^4 - 786*b^4*c^4 + 324*a^3*c^5 + 624*a^2*b*c^5 + 
      612*a*b^2*c^5 + 360*b^3*c^5 + 56*a^2*c^6 + 44*a*b*c^6 + 172*b^2*c^6 - 124*a*c^7 - 168*b*c^7 + 
      29*c^8) + 16*r*s*(5*a^6 - 16*a^5*b - 11*a^4*b^2 + 72*a^3*b^3 - 65*a^2*b^4 + 8*a*b^5 + 7*b^6 - 
       16*a^5*c - 42*a^4*b*c + 56*a^3*b^2*c + 84*a^2*b^3*c - 88*a*b^4*c + 6*b^5*c - 11*a^4*c^2 + 
       56*a^3*b*c^2 - 38*a^2*b^2*c^2 + 80*a*b^3*c^2 - 87*b^4*c^2 + 72*a^3*c^3 + 84*a^2*b*c^3 + 
       80*a*b^2*c^3 + 148*b^3*c^3 - 65*a^2*c^4 - 88*a*b*c^4 - 87*b^2*c^4 + 8*a*c^5 + 6*b*c^5 + 7*c^6))/
    (4*b*c*(a^2 - 2*a*b + b^2 - 2*a*c - 2*b*c + c^2 + 8*r*s)^4)/.{s->Semiperimeter,r->Inradius}
*)
CircleRadius[OuterSoddyCircle]:=4Inradius^2Semiperimeter/(8Inradius Semiperimeter-(2(a b+b c+c a)-(a^2+b^2+c^2)))
CircleCenterFunction[OuterSoddyCircle]:=-1+Area/(Semiperimeter-a)/a

OuterSoddyTriangle[t_Triangle]:=
  Chop[Triangle[Coordinates[First[Intersections[OuterSoddyCircle[t],#]]]&/@
      TangentCircles[t]],10^-6]

Name[OuterVectenCircle]:="outer Vecten circle"
CircleCenterFunction[OuterVectenCircle]:=
	(2*Area*(b^2 + c^2) + 3*a^2*b*c*Cos[A] + 2*a^2*b*c*Cos[B]*Cos[C])/a
CircleFunction[OuterVectenCircle]:=-4*a^3*Area*(Area + 2*b*c*Cos[B - C])
CircleRadius[OuterVectenCircle]:=
Sqrt[-2*a^6 + 3*a^4*b^2 + 3*a^2*b^4 - 2*b^6 + 3*a^4*c^2 + 14*a^2*b^2*c^2 + 3*b^4*c^2 + 
   3*a^2*c^4 + 3*b^2*c^4 - 2*c^6 + 20*(a^2*b^2 + a^2*c^2 + b^2*c^2)*Area]/
 (Sqrt[2]*Abs[a^2 + b^2 + c^2 + 8*Area])

Name[OuterVectenTriangle]:="outer Vecten triangle"
TrilinearVertexMatrix[OuterVectenTriangle]:=
{{-(a/2), (1/2)*a*(Sin[C] + Cos[C]), (1/2)*a*(Sin[B] + Cos[B])}, 
  {(1/2)*b*(Sin[C] + Cos[C]), -(b/2), (1/2)*b*(Sin[A] + Cos[A])}, 
  {(1/2)*c*(Sin[B] + Cos[B]), (1/2)*c*(Sin[A] + Cos[A]), -(c/2)}}

Parabola[a_,t_]:={t,a t^2};

ParabolaPt[a_,{p_,t_}]:=-(1/a^2/(t+p)+p);

Parallel[v_List,x_]:=Module[{i,u=SideUnitVectors[v],k},
	k=v[[1]]+x u[[3]];
	Line[{k,Intersections[Line@{k,k+u[[2]]},Line@v[[{2,3}]]]}]
]

Parallelians[{\[Alpha]_,\[Beta]_,\[Gamma]_}]:={
	Line[{c \[Alpha],0,b \[Beta]+c \[Gamma]},{-b \[Alpha],-b \[Beta]-c \[Gamma],0}],
    Line[{a \[Alpha]+c \[Gamma],a \[Beta], 0},{0,-c \[Beta],-a \[Alpha]-c \[Gamma]}],
    Line[{0,a \[Alpha]+b \[Beta],b \[Gamma]},{-a \[Alpha]-b \[Beta],0,-a \[Gamma]}]}

ParallelLine[{alpha_,beta_,gamma_},TrilinearLine[{l_,m_,n_}]]:=
  Module[{x=b n-c m,y=c l-a n,z=a m-b l},
    TrilinearLine[{beta z-gamma y, gamma x-alpha z, alpha y-beta x}]
]
ParallelLine[TrilinearLine[{l_,m_,n_}],{alpha_,beta_,gamma_}]:=
	ParallelLine[{alpha,beta,gamma},TrilinearLine[{l,m,n}]]

ParallelLine[ctr_,TrilinearLine[{l_,m_,n_}]]:=
	ParallelLine[Trilinears[ctr],TrilinearLine[{l,m,n}]] /; MemberQ[Centers,ctr]
ParallelLine[TrilinearLine[{l_,m_,n_}],ctr_]:=
	ParallelLine[Trilinears[ctr],TrilinearLine[{l,m,n}]] /; MemberQ[Centers,ctr]

ParallelLine[{alpha_,beta_,gamma_},line_]:=
	ParallelLine[{alpha,beta,gamma},TrilinearLine[line]] /; MemberQ[Lines,line]
ParallelLine[line,{alpha_,beta_,gamma_}]:=
	ParallelLine[{alpha,beta,gamma},TrilinearLine[line]] /; MemberQ[Lines,line]

ParallelLine[ctr_,line_]:=ParallelLine[Trilinears[ctr],TrilinearLine[line]] /;
	MemberQ[Centers,ctr]&&MemberQ[Lines,line]
ParallelLine[line_,ctr_]:=ParallelLine[Trilinears[ctr],TrilinearLine[line]] /;
	MemberQ[Centers,ctr]&&MemberQ[Lines,line]

Parallelogram[a_,b_]:=Quadrilateral[{{0,0},b,b+a,a}]

(*
Parallels[v_List,point_Point]:=Module[{i,u=SideUnitVectors[v],pt=Coordinates[point]},
	Line/@Table[{
		Intersections[Line@{pt,pt+u[[i]]},Line@v[[{addn[i,1,3],addn[i,3,3]}]]],
		Intersections[Line@{pt,pt+u[[i]]},Line@v[[{addn[i,0,3],addn[i,2,3]}]]]},
	{i,3}]
]
*)
(* rewrite; see FirstLemoinCircle.nb *)

ParallelQ[TrilinearLine[l_List],TrilinearLine[ll_List]]:=
	Det[{{a,b,c},l,ll}]==0 /; (Dimensions/@{l,ll}=={{3},{3}})

Parallels[t_Triangle,p_Point]:=Module[
	{
	v=Coordinates[p],
	lines
	},
	lines=Line/@({v+#,v}&/@SideUnitVectors[t]);
	Line/@Map[Coordinates,
		DeleteCases[
			Outer[Intersections,lines,Sides[t]],
			_?(#==PointAtInfinity&),{2}
	],{2}]
]

Parallels[t_List,r_List]:=Module[{v=SideVectors[t],i},
	Line/@Table[{t[[i]]+r v[[addn[i,2,3]]],
		Intersections[
			Line@{t[[i]]+r v[[addn[i,2,3]]],t[[i]]+r v[[addn[i,2,3]]]+v[[addn[i,1,3]]]},
			Line@{t[[addn[i,1,3]]],t[[addn[i,1,3]]]+v[[addn[i,0,3]]]}
		]},
	{i,3}]
] /; Length[r]==3

CenterFunction[ParryCenter]:=(a*(2*a^2-b^2-c^2))/((a^2-b^2)*(a^2-c^2))
Name[ParryCenter]:="Parry center"

Name[ParryCircle]:="Parry circle"
CircleFunction[ParryCircle]:=-((b*c*(-2*a^2+b^2+c^2))/(3*(a^2-b^2)*(a^2-c^2)))
CircleCenterFunction[ParryCircle]:=a*(b - c)*(b + c)*(2*a^2 - b^2 - c^2)
CircleRadius[ParryCircle]:=(a*b*c*(a^4-a^2*b^2+b^4-a^2*c^2-b^2*c^2+c^4))/(3*Abs[(a-b)*(a+b)*(a-c)*(b-c)*(a+c)*(b+c)])

Name[ParryPoint]:="Parry point"
CenterFunction[ParryPoint]:=a/(2a^2-b^2-c^2)

PedalCircle[t_Triangle,pt_Point]:=Circumcircle[PedalTriangle[t,pt]]

PedalTriangle[{\[Alpha]_,\[Beta]_,\[Gamma]_}]:=Triangle[{
	{0,\[Beta]+\[Alpha] Cos[C],\[Gamma]+\[Alpha] Cos[B]},
	{\[Alpha]+\[Beta] Cos[C],0,\[Gamma]+\[Beta] Cos[A]},
	{\[Alpha]+\[Gamma] Cos[B],\[Beta]+\[Gamma] Cos[A],0}
}]
PedalTriangle[ctr_]:=PedalTriangle[Trilinears[ctr]] /; MemberQ[Centers,ctr]
PedalTriangle[t_Triangle,ctr_]:=Cartesian[PedalTriangle[ctr][t]] /; MemberQ[Centers,ctr]

PedalLines[t_Triangle,p_Point]:=Line[{Coordinates[p],#}]&/@Vertices[PedalTriangle[t,p]]
PedalLines[tri_List?VectorQ]:=Line[tri,#]&/@Vertices[PedalTriangle[tri]]
PedalLines[ctr_]:=PedalLines[Trilinears[ctr]] /; MemberQ[Centers,ctr]

PerimeterPoint[t_Triangle,r_]:=Module[{s=SideLengths[t],v=Vertices@t,p,u},
	u=SideUnitVectors[v];
	p=Plus@@s;
	Point[Which[
		r<=s[[3]]/p,v[[1]]+u[[3]]r p,
		r<=(s[[3]]+s[[1]])/p,v[[2]]+u[[1]](r p-s[[3]]),
		r<=p,v[[3]]+u[[2]](r p-s[[3]]-s[[1]])
	]]
]

PerpendicularBisector[l_Line,h_:1]:=PerpendicularLine[Midpoint[l],l,h]

PerpendicularBisectors[t_Triangle]:=
	PerpendicularLine[Circumcenter[t],#]&/@Sides[t]

PerpendicularLine[p_Point,line_Line]:=
	Line[Coordinates/@{p,Intersections[PerpendicularLine[p,line,1],line]}]

PerpendicularLine[p_Point,line_Line,{d1_,d2_}]:=Module[
	{pt=Coordinates@p,l=First@line,lp},
	lp=unitVector[{0,0},{-(l[[2,2]]-l[[1,2]]),l[[2,1]]-l[[1,1]]}];
	Line[{pt+lp d1,pt-lp d2}]
]

PerpendicularLine[p_Point,line_Line,d_]:=PerpendicularLine[p,line,{d,d}]

PerpendicularLine[line_Line,p_Point,ext___]:=PerpendicularLine[p,line,ext]

PerpendicularLine[tri_List?VectorQ,eqn_]:=Module[{alpha,beta,gamma},
	{l,m,n}=Coefficient[eqn,#]&/@{\[Alpha],\[Beta],\[Gamma]};
	Det[{
		{\[Alpha],\[Beta],\[Gamma]},
		tri,
		{l-m Cos[C]-n Cos[B],m-n Cos[A]-l Cos[C],n-l Cos[B]-m Cos[A]}
	}]
]

PerpendicularLine[TrilinearLine[{l_,m_,n_}],{\[Alpha]_,\[Beta]_,\[Gamma]_}]:=
TrilinearLine[{
	n \[Beta]-m \[Gamma]-m \[Beta] Cos[A]+n \[Gamma] Cos[A]-l \[Beta] Cos[B]+l \[Gamma] Cos[C],
	-n \[Alpha]+l \[Gamma]+m \[Alpha] Cos[A]+l \[Alpha] Cos[B]-n \[Gamma] Cos[B]-m \[Gamma] Cos[C],
	m \[Alpha]-l \[Beta]-n \[Alpha] Cos[A]+n \[Beta] Cos[B]-l \[Alpha] Cos[C]+m \[Beta] Cos[C]
}]

PerpendicularQ[TrilinearLine[{l_,m_,n_}],TrilinearLine[{ll_,mm_,nn_}]]:=
	l ll+m mm+n nn-(m nn+mm n)Cos[A]-(n ll+nn l)Cos[B]-(l mm+ll m)Cos[C]==0
PerpendicularQ[line1_,line2_]:=PerpendicularQ[TrilinearLine[line1],TrilinearLine[line2]] /;
	MemberQ[Lines,line1]&&MemberQ[Lines,line2]

Perpendiculars[t_Triangle,l_]:=Module[{i,tri=Vertices[t]},
	Flatten[Table[{
		PerpendicularLine[Point[tri[[i]]],Line@{l[[i]],l[[addn[i,1,3]]]}],
		PerpendicularLine[Point[tri[[i]]],Line@{l[[i]],l[[addn[i,2,3]]]}]
		},
	{i,3}],1]
]

PerpendicularUnitVector[l_List]:=Module[{v=Subtract@@l},
    unitVector[{v[[2]],-v[[1]]}]
]

PerpSquare::notperp="`1` and `2` are not perpendicular; dot product is `3`.";

PerpSquare[{line1_Line,line2_Line},l_,q_:1]:=Module[
	{
	p=Coordinates@Intersections[line1,line2],
	l1=Coordinates[line1],l2=Coordinates[line2],
	v1,v2,dot,
	x=If[q==1 || q==4,-1,1],
	y=If[q==1 || q==2,-1,1]
	},
	v1=unitVector@@l1;
	v2=unitVector@@l2;
	If[(dot=Abs[(l1[[2]]-l1[[1]]).(l2[[2]]-l2[[1]])])<.001,
		Line[{p+l x v1,p+l(x v1+y v2),p+l y v2}],
		Message[PerpSquare::notperp,line1,line2,dot]
	]
]

PerspectiveAxisPoints[p:(_Triangle|_Quadrilateral|_Polygon)..]:=
  Intersections@@@(Map[Line,Transpose[Partition[#,2,1,1]&/@(Vertices/@{p})],{2}])

(* this will fail if alpha==0 *)

PerspectiveQ[t1_Triangle,t2_Triangle]:=Module[{pts=Intersections@@@
	Map[TrilinearLine,Map[Line@@#&,Partition[Transpose[Vertices/@{t1,t2}],2,1,1],{2}],{2}]},
	Equal@@(Rest[#]/First[#]&/@pts)
] /; Dimensions[t1[[1]]]==Dimensions[t2[[1]]]=={3,3}


PerspectiveQ[Triangle[v1_List],Triangle[v2_List]]:=
	Equal@@Intersections@@@Partition[Line/@Transpose[{v1,v2}],2,1,1] /;
	Dimensions[v1]==Dimensions[v2]=={3,2}

(*
PerspectiveQ[p:(_Triangle|_Quadrilateral|_Polygon)..]:=
  Equal@@Intersections@@@Map[Line,Partition[Transpose[Vertices/@{p}],2,1,1],{2}]
*)

PerspectiveQ[t1_,t2_]:=PerspectiveQ@@(Triangle/@{t1,t2}) /;
	And@@(MemberQ[Triangles,#]&/@{t1,t2})
(*
PerspectiveQ[tri1_?MatrixQ,tri2_?MatrixQ]:=Equal@@(ExactTrilinears/@(Intersections@@@
	Partition[Transpose[{tri1,tri2}],2,1,1]))
*)
Perspector[p:(_Triangle|_Quadrilateral|_Polygon)..]:=
	Intersections@@Line/@Transpose[Take[#,2]&/@Vertices/@Take[{p},2]]

Perspector[l__TrilinearLine]:=Intersections@@Take[{l},2]

Perspector[t1_,t2_]:=CyclicTrilinears[PerspectorFunction[t1,t2]] /;
	Head[PerspectorFunction[t1,t2]]=!=PerspectorFunction&&And@@(MemberQ[Triangles,#]&/@{t1,t2})
Perspector[t2_,t1_]:=CyclicTrilinears[PerspectorFunction[t1,t2]] /;
	Head[PerspectorFunction[t1,t2]]=!=PerspectorFunction&&And@@(MemberQ[Triangles,#]&/@{t1,t2})

Perspector[t1_,t2_]:=Perspector@@(TrilinearLine/@(Line@@@Transpose[TrilinearVertexMatrix/@{t1,t2}])) /;
	And@@(MemberQ[Triangles,#]&/@{t1,t2})
Perspector[t1_,Triangle[v_List?MatrixQ]]:=
	Perspector@@(TrilinearLine/@(Line@@@Transpose[{TrilinearVertexMatrix[t1],v}])) /;
	MemberQ[Triangles,t1]&&Dimensions[v]=={3,3}
Perspector[t2:Triangle[v_List?MatrixQ],t1_]:=Perspector[t1,t2] /;
	MemberQ[Triangles,t1]&&Dimensions[v]=={3,3}
Perspector[Triangle[v1_List?MatrixQ],Triangle[v2_List?MatrixQ]]:=
	Perspector@@(TrilinearLine/@(Line@@@Transpose[{v1,v2}])) /;
	Dimensions[v1]==Dimensions[v2]=={3,3}

Perspector[conic_]:=Perspector[PolarTriangle[conic],ReferenceTriangle] /;
	MemberQ[Join[Conics,CentralCircles],conic]

PerspectorFunction[LucasCentralTriangle,LucasInnerTriangle]:=7 Cos[A] + 4 Sin[A]
PerspectorFunction[LucasCentralTriangle,LucasTangentsTriangle]:=3 Cos[A] + 2 Sin[A]
PerspectorFunction[LucasCentralTriangle,SymmedialTriangle]:=2 Cos[A] + Sin[A]
PerspectorFunction[LucasInnerTriangle,LucasTangentsTriangle]:=5 Cos[A] + 3 Sin[A]
PerspectorFunction[LucasInnerTriangle,SymmedialTriangle]:=4 Cos[A] + 3 Sin[A]

Perspectrix[t__Triangle,d_:0]:=
	LongestLine[Coordinates/@Intersections@@@Transpose[Sides/@{t}],d] /; Length[{t}]==2

Perspectrix[t__]:=TrilinearLine[
	Line@@(Intersections@@@Map[Line@@#&,Transpose[Partition[#,2,1]&/@Vertices/@Triangle/@{t}],{2}])] /;
	And@@(MemberQ[Triangles,#]&/@{t})

PivotPoint[cubic_]:=Trilinears[PivotalIsogonalCubicFunction[cubic]] /;
	MemberQ[PivotalIsogonalCubics,cubic]
PivotPoint[cubic_]:=Trilinears[PivotalIsotomicCubicFunction[cubic]] /;
	MemberQ[PivotalIsotomicCubics,cubic]

PKTransform[{x_,y_,z_}]:={(y^2 - z^2)x, (z^2 - x^2)y, (x^2 - y^2)z}
PKTransform[ctr_]:=PKTransform[Trilinears[ctr]] /; MemberQ[Centers,ctr]

(* let c1 be a point from which it is desired that perp point away
	and towards c2.  This routine changes the direction of perp if 
    necessary *)

PointingAway[{perp_,c1_},c2_]:=Module[{d=c1+.01 perp},
	If[(d-c2).(d-c2)<(c1-c2).(c1-c2),perp,-perp]
]

PointLabels[f:(_Triangle|_Quadrilateral),l_List,psize_:.02,offset_:{.05,.12},opts___]:=
	PointLabelsCompute[f,l,psize,offset,opts]

PointLabels[p_List,opts___]:=Module[{
      ldirs,
      ddirs=Select[Options[PointLabels],!OptionQ[#]&],
      dopts=Select[Options[PointLabels],OptionQ]
      },
     Flatten[{
            ldirs=Flatten[{
                  ddirs,
                  Select[Flatten[{opts}],!OptionQ[#]&],
                  If[Length[#]<3,{},Select[Flatten[Drop[#,2]],!OptionQ[#]&]]
                  }],
            Text[
              TraditionalForm[#[[2]]],
              Coordinates[#[[1]]]+
              	(LabelOffset/.
              	  If[Length[#]>2,Select[Flatten[{#[[3]]}],OptionQ],{}]/.
              	  Select[Flatten[{opts}],OptionQ]/.
              	  dopts
              	),
              FilterOptions[Text,Select[Flatten[{opts}],OptionQ],dopts],
              (* V6 *)
              TextStyle->(TextStyle/.{dopts})
              ],
            #[[1]]
            }]&/@p
]

PointLabelsCompute[o_,l_List,psize_:.02,offset_:{.05,.12},opts___]:=Module[
	{pts,str,split=Transpose[Partition[l,2]],
	i,len=Length[l]/2},
	str=split[[2]];
	pts=Table[
		Switch[split[[1,i]],
			_Point,split[[1,i]] /. Point->Identity,
			_List,split[[1,i]],
			_,split[[1,i]][o] /. Point->Identity
		],{i,len}
	];
	{
		Table[Text[TraditionalForm[str[[i]]],pts[[i]]+offset,opts,Options[PointLabels]],{i,len}],
		{PointSize[psize],Point/@pts}
	}
]

(* breaks in V6 *)
(*
PointLabels[l_List,psize_:.02,offset_:{.05,.12},opts___]:=Module[
	{pts,str,split=Transpose[Partition[l,2]],
	i,len=Length[l]/2
	},
	str=split[[2]];
	pts=Table[
		Switch[split[[1,i]],
			_Point,split[[1,i]] /. Point->Identity,
			_List,split[[1,i]]
			],{i,len}
	];
	{
		Table[Text[TraditionalForm[str[[i]]],pts[[i]]+offset,
			opts,Options[PointLabels]],{i,len}],
		{PointSize[psize],Point/@pts}
	}
]
*)

PointPoints[tri_,l_List,psize_:.02,offset_:{.05,.12}]:=Module[
	{split=Transpose[Partition[l,2]],i,len=Length[l]/2},
	Table[split[[1,i]][tri],{i,len}]
]

Name[PolarCircle]:="polar circle"
CircleFunction[PolarCircle]:=-Cos[A]
CircleCenterFunction[PolarCircle]:=CenterFunction[Orthocenter]
CircleRadius[PolarCircle]:=Sqrt[4Circumradius^2-(a^2+b^2+c^2)/2]

matrix[eqn_]:=
  Module[{m=Coefficient[eqn,#]&/@{\[Alpha]^2,\[Beta]^2,\[Gamma]^2},
      n=Coefficient[eqn,#]&/@{\[Alpha] \[Beta],\[Beta] \[Gamma],\[Gamma] \[Alpha]}/2},
    {{m[[1]],n[[1]],n[[3]]},{n[[1]],m[[2]],n[[2]]},{n[[3]],n[[2]],m[[3]]}}
]

polarTriangle[eqn_]:=
  Triangle[RotateLeft[Intersections@@@Partition[TrilinearLine/@matrix[eqn],2,1,1]]]

PolarTriangle[conic_]:=polarTriangle[Numerator[Together[TrilinearEquation[conic]]]] /;
	MemberQ[Join[Conics,CentralCircles],conic]
PolarTriangle[eqn_]:=polarTriangle[eqn]

Polygram[n_,m_,R_:1,ang_:0]:=Module[{steps=n/GCD[n,m],npoly,i,j},
	npoly=n/steps;
	Table[
      ClosedLine[Table[{R Cos[#],R Sin[#]}&[2 Pi(i+j)/n+ang],{i,1,m(steps),m}]],
      {j,0,npoly-1}
    ]
]

CircleTripletFunction[PowerCircles]:={{0,c,b},Sqrt[2c^2+2b^2-a^2]/2}

RadicalCenter[c:{_Circle,_Circle,_Circle}]:=Module[{i,l,a,b,g},
	l1=RadicalVector[{c[[1]],c[[2]]}];
	l2=RadicalVector[{c[[1]],c[[3]]}];
	g=a /. Flatten[Solve[{l1[[1]]+a l1[[2]]==l2[[1]]+b l2[[2]]},{a,b}]];
	Point[l1[[1]]+g l1[[2]]]
] /; Dimensions[First/@c]=={3,2}

RadicalCenter[c:{_Circle,_Circle,_Circle}]:=
	RadicalCenter[CircleFunction/@c,{1,1,1}] /;
	Dimensions[First/@c]=={3,3}

RadicalCenter[c:{circ1_,circ2_,circ3_}]:=RadicalCenter[CyclicTrilinears/@CircleFunction/@c,{1,1,1}] /;
	And@@(MemberQ[CentralCircles,#]&/@c)

RadicalCenter[c_]:=RadicalCenter[Circles[c]] /; MemberQ[CircleTriplets,c]

RadicalCenter[{{l_,m_,n_},{ll_,mm_,nn_},{lll_,mmm_,nnn_}},{k_,kk_,kkk_}]:=
	{
	Det[{{k,kk,kkk},{m,mm,mmm},{n,nn,nnn}}],
	Det[{{k,kk,kkk},{n,nn,nnn},{l,ll,lll}}],
	Det[{{k,kk,kkk},{l,ll,lll},{m,mm,mmm}}]
	}

RadicalCenter[{{l_,m_,n_},{ll_,mm_,nn_},{lll_,mmm_,nnn_}}]:=
	RadicalCenter[{{l,m,n},{ll,mm,nn},{lll,mmm,nnn}},{1,1,1}]

RadicalCircle[c:{_Circle,_Circle,_Circle}]:=Module[{ctr=RadicalCenter[c]},
    Circle[ctr,Sqrt[Distance[ctr,Center[c[[1]]]]^2-CircleRadius[c[[1]]]^2]]]

RadicalCircle[c_]:=RadicalCircle[Circles[c]] /; MemberQ[CircleTriplets,c]

RadicalCircle[c:{_Circle,_Circle,_Circle}]:=Module[{ctr=Coordinates[RadicalCenter[c]]},
	Circle[ctr,Sqrt[Distance[ctr,Coordinates[Center[c[[1]]]]]^2-CircleRadius[c[[1]]]^2]]
] /; Dimensions[First/@c]=={3,2}

RadicalLine[c1:Circle[{x1_,y1_},r1_],c2:Circle[{x2_,y2_},r2_],len_:1]:=Module[
	{rv=RadicalVector[{c1,c2}],pt,perp},
	{pt,perp}=rv;
	Line[{pt-len perp,pt+len perp}]
]

RadicalLine[circ1:Circle[{a1_,b1_,g1_},r1_],circ2:Circle[{a2_,b2_,g2_},r2_]]:=
	Module[{k=1,kk=1,l,ll,m,mm,n,nn},
		{{l,m,n},{ll,mm,nn}}=CircleFunction/@{circ1,circ2};
		TrilinearLine[{kk l-k ll,kk m-k mm,kk n-k nn}]
]

RadicalLine[circ1_,circ2_]:=Module[{k=1,kk=1,l,ll,m,mm,n,nn},
		{{l,m,n},{ll,mm,nn}}=CircleFunction/@{circ1,circ2};
		TrilinearLine[{kk l-k ll,kk m-k mm,kk n-k nn}]
] /; And@@(MemberQ[CentralCircles,#]&/@{circ1,circ2})

RadicalLine[c:{ctr1_,ctr2_}]:=Module[{k=1,kk=1,l,ll,m,mm,n,nn},
	{{l,m,n},{ll,mm,nn}}=CyclicTrilinears[CircleFunction[#]]&/@c;
	TrilinearLine[{kk l-k ll,kk m-k mm,kk n-k nn}]
] /; And@@(MemberQ[CentralCircles,#]&/@c)

RadicalLines[c__Circle,len_:1]:=RadicalLine[#,len]&@@@Subsets[{c},2] /; Length[c]==3

RadicalVector[{Circle[{x1_,y1_},r1_],Circle[{x2_,y2_},r2_]}]:=Module[
	{d=Sqrt[{x1-x2,y1-y2}.{x1-x2,y1-y2}],d1,pt,perp},
	d1=(d^2+r1^2-r2^2)/(2d);
	lc={x2-x1,y2-y1}/Sqrt[{x2-x1,y2-y1}.{x2-x1,y2-y1}];
	perp={lc[[2]],-lc[[1]]};
	pt={x1,y1}+d1 lc;
	{pt,perp}
]

RandomTriangle[prec_:MachinePrecision,opts___?OptionQ]:=Module[
	{
		type=Type/.{opts}/.Type->Automatic,
		t=Triangle[Table[Random[Real,{0,1},prec],{3},{2}]]
	},
    Switch[type,
    	"Acute",While[ObtuseQ[t],t=Triangle[Table[Random[Real,{0,1},10],{3},{2}]]],
		"Obtuse",While[AcuteQ[t],t=Triangle[Table[Random[Real,{0,1},10],{3},{2}]]]];
	t
]

RandomTriangleRules[prec_:MachinePrecision,opts___?OptionQ]:=
	Module[{t=RandomTriangle[prec,opts]},
	Join[Thread[{a,b,c}->SideLengths[Evaluate[t]]],
        Thread[{A,B,C}->Angles[Evaluate[t]]]]
]

Name[ReferenceTriangle]:="reference triangle"
TrilinearVertexMatrix[ReferenceTriangle]:=IdentityMatrix[3]

ReflectedCevianTriangle[t_Triangle,p_Point]:=Module[
	{
	i,
	ct=Vertices@CevianTriangle[t,p],
	m=Coordinates/@Midpoints[t]
	},
	Triangle[Table[2m[[i]]-ct[[i]],{i,3}]]
]

ReflectedCevianTrianglePoint[t_Triangle,p_Point]:=Module[
	{tri=Vertices[t],ct2=Vertices@ReflectedCevianTriangle[t,p]},
    Intersections[Line@{tri[[1]],ct2[[1]]},Line@{tri[[2]],ct2[[2]]}]
]

ReflectedCevians[t_Triangle,p_Point]:=Module[
	{
	ct2=Vertices@ReflectedCevianTriangle[t,p],
	tri=Vertices[t],
	i
	},
    Table[Line[{tri[[i]],ct2[[i]]}],{i,3}]
]    

Name[ReflectionCircle]:="reflection circle"
CircleCenterFunction[ReflectionCircle]:=
a*(a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 4*a^6*c^2 + 
  5*a^4*b^2*c^2 + a^2*b^4*c^2 - 2*b^6*c^2 + 6*a^4*c^4 + a^2*b^2*c^4 + 
  2*b^4*c^4 - 4*a^2*c^6 - 2*b^2*c^6 + c^8)
CircleFunction[ReflectionCircle]:=
-((a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 4*a^6*c^2 + 
   5*a^4*b^2*c^2 + a^2*b^4*c^2 - 2*b^6*c^2 + 6*a^4*c^4 + a^2*b^2*c^4 + 
   2*b^4*c^4 - 4*a^2*c^6 - 2*b^2*c^6 + c^8)/
  (b*c*(a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 - a^2*b^2*c^2 - b^4*c^2 - 
    a^2*c^4 - b^2*c^4 + c^6)))
CircleRadius[ReflectionCircle]:=
Sqrt[(a^6 - 3*a^4*b^2 + 3*a^2*b^4 - b^6 - 3*a^4*c^2 + 3*a^2*b^2*c^2 + 
    b^4*c^2 + 3*a^2*c^4 + b^2*c^4 - c^6)*(-a^6 + 3*a^4*b^2 - 3*a^2*b^4 + 
    b^6 + a^4*c^2 + 3*a^2*b^2*c^2 - 3*b^4*c^2 + a^2*c^4 + 3*b^2*c^4 - c^6)*
   (-a^6 + a^4*b^2 + a^2*b^4 - b^6 + 3*a^4*c^2 + 3*a^2*b^2*c^2 + 
    3*b^4*c^2 - 3*a^2*c^4 - 3*b^2*c^4 + c^6)]/
 (4*Area*Abs[a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 - a^2*b^2*c^2 - 
    b^4*c^2 - a^2*c^4 - b^2*c^4 + c^6])

Name[ReflectionTriangle]:="reflection triangle"
TrilinearVertexMatrix[ReflectionTriangle]:=
{{-1,2 Cos[C],2 Cos[B]},{2 Cos[C],-1,2 Cos[A]},{2 Cos[B],2 Cos[A],-1}}

(* Reflection *)

(* point in point *)

Reflection[{x0_,y0_,z0_},{u_,v_,w_}]:=
	{(a u-b v-c w)x0+2u(b y0+c z0),
	 (b v-c w-a u)y0+2v(c z0+a x0),
	 (c w-a u-b v)z0+2w(a x0+b y0)}

Reflection[ctr1_,ctr2_]:=Module[{a1,a2,b1,b2,g1,g2},
    Reflection[Sequence@@(Trilinears/@{ctr1,ctr2})]
] /; And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})

(* triangle in point *)

Reflection[Triangle[v_List?MatrixQ],pt_List?VectorQ]:= 
  Triangle[Reflection[#,pt]&/@v]/;
    Dimensions[v]\[Equal]{3,3}&&Dimensions[pt]\[Equal]{3}
Reflection[t_,pt_List?VectorQ]:= 
  Reflection[Triangle[t],pt]/;MemberQ[Triangles,t]&&Dimensions[pt]\[Equal]{3}
Reflection[t_,ctr_]:= 
  Reflection[Triangle[t],Trilinears[ctr]]/;
    MemberQ[Triangles,t]&&MemberQ[Centers,ctr]
Reflection[Triangle[v_List?MatrixQ],ctr_]:= 
  Triangle[Reflection[#,Trilinears[ctr]]&/@v]/;
    Dimensions[v]\[Equal]{3,3}&&MemberQ[Centers,ctr]

(* point in line *)

Reflection[p_Point,l_Line]:=Module[{d=Distance[p,l],
      p1=Coordinates[p],
      p2=Coordinates[Intersections[l,PerpendicularLine[p,l]]]},
    Point[2p2-p1]
]

Reflection[pt:{\[Alpha]_,\[Beta]_,\[Gamma]_},line:TrilinearLine[{l_,m_,n_}]]:=
	Reflection[pt,Intersections[PerpendicularLine[line,pt],line]]

Reflection[pt:{\[Alpha]_,\[Beta]_,\[Gamma]_},line:Line[v__]]:=
	Reflection[pt,TrilinearLine[line]] /; Dimensions[{v}]=={2,3}

Reflection[ctr_,l_]:=Reflection[Trilinears[ctr],TrilinearLine[l]] /; MemberQ[Centers,ctr]&&MemberQ[Lines,l]
Reflection[ctr_List?VectorQ,l_]:=Reflection[Trilinears[ctr],Triangle[t]] /; Length[ctr]==3&&MemberQ[Lines,l]
Reflection[ctr_,l_TrilinearLine]:=Reflection[Trilinears[ctr],l] /. MemberQ[Centers,ctr]

(* line in line *)

Reflection[TrilinearLine[{ll_, mm_, nn_}], TrilinearLine[{l_, m_, n_}]] := 
TrilinearLine[{((-ll - mm)*n + (l + m)*nn)*((ll + mm)*(c*(l^2*ll - ll*m^2 + 2*l*m*mm) + ll*(a*l + b*m)*n) - 
     (b*l*(ll*(l + m) + 2*m*mm) + c*(ll*m - l*(ll + 2*mm))*n - b*ll*n^2 + a*(2*l^2*ll + l*m*(ll + 2*mm) - ll*(m^2 + n^2)))*nn - 
     2*(a + b)*l*n*nn^2 + ((ll + mm)*n*(c*ll*m - 2*c*l*mm - b*ll*n) + (c*m*(ll*m - l*(ll + 2*mm)) + (b*l*ll - (2*a + b)*ll*m + 2*(a + b)*l*mm)*n)*
        nn + 2*(a + b)*l*m*nn^2)*Cos[A] - (ll*(ll + mm)*n*(c*l + a*n) + (c*l*((-ll)*m + l*(ll + 2*mm)) - a*ll*(l + m)*n)*nn - 2*(a + b)*l^2*nn^2)*
      Cos[B] + ((-ll - mm)*(2*c*l^2*mm + ll*(b*l + a*m)*n) + (ll*(l + m)*(b*l + a*m) + 2*(a + b)*l^2*mm)*nn)*Cos[C]), 
   ((ll + mm)*n - (l + m)*nn)*((-ll - mm)*(c*(2*l*ll*m - l^2*mm + m^2*mm) + (a*l + b*m)*mm*n) + 
     (a*m*(2*l*ll + (l + m)*mm) + c*(l*mm - m*(2*ll + mm))*n - a*mm*n^2 + b*(2*l*ll*m - l^2*mm + l*m*mm + 2*m^2*mm - mm*n^2))*nn + 
     2*(a + b)*m*n*nn^2 + (mm*(ll + mm)*n*(c*m + b*n) + (c*m*(2*ll*m + (-l + m)*mm) - b*(l + m)*mm*n)*nn - 2*(a + b)*m^2*nn^2)*Cos[A] + 
     ((ll + mm)*n*(2*c*ll*m - c*l*mm + a*mm*n) + (c*l*(2*ll*m + (-l + m)*mm) + (-2*(a + b)*ll*m + (2*b*l + a*(l - m))*mm)*n)*nn - 
       2*(a + b)*l*m*nn^2)*Cos[B] + ((ll + mm)*(2*c*ll*m^2 + (b*l + a*m)*mm*n) - (2*(a + b)*ll*m^2 + (l + m)*(b*l + a*m)*mm)*nn)*Cos[C]), 
   ((ll + mm)*n - (l + m)*nn)*(-2*c*(ll + mm)*(l*ll + m*mm)*n + ((a*l*ll + 2*b*l*ll - b*ll*m - a*l*mm + 2*a*m*mm + b*m*mm)*n + 
       c*(ll + mm)*(l^2 + m^2 - 2*n^2))*nn + ((-l + m)*(b*l - a*m) + c*(l + m)*n + (a + b)*n^2)*nn^2 + 
     (2*c*mm*(ll + mm)*n^2 + n*(c*m*(ll + mm) + (b*ll - (2*a + b)*mm)*n)*nn - (l + m)*(c*m + b*n)*nn^2)*Cos[A] + 
     (2*c*ll*(ll + mm)*n^2 + n*(c*l*(ll + mm) + ((-a - 2*b)*ll + a*mm)*n)*nn - (l + m)*(c*l + a*n)*nn^2)*Cos[B] + 
     (2*c*(ll + mm)*(ll*m*n + l*mm*n - l*m*nn) + nn*((b*l*ll - a*ll*m - 2*b*ll*m - 2*a*l*mm - b*l*mm + a*m*mm)*n - (l - m)*(b*l - a*m)*nn))*
      Cos[C])}]

(* regular polygon *)

RegularPolygon[n_,R_:1,ang_:0]:=Module[{i},
	Polygon[Table[{R Cos[#],R Sin[#]}&[ang+2Pi i/n],{i,0,n-1}]]
]

RegularPolygonArea[n_]:=n/4 Cot[Pi/n]

RegularPolygonInformation[n_]:={
	{"sides n",n},
	{"vertex angle \[Alpha] {rad, degrees}",{Pi(1-2/n),180(1-2/n)Degree}},
	{"central angle \[Beta] {rad, degrees}",{2Pi/n,360/n Degree}},
	{"inradius r",1/2 Cot[Pi/n]},
	{"circumradius R",1/2 Csc[Pi/n]},
	{"area A",1/4 n Cot[Pi/n]}
}

RigbyPoint[v_List,l_List]:=Module[
	{
	a=l,c,pqr,i,
	circ={Circumcenter[v][[1]],Circumradius[v]}
	},
	c=Chord[circ,a];
	AppendTo[a,SimsonLinePoleAngle[v,c[[1]]]];
	pqr=Table[CircumcirclePoint[v,a[[addn[i,2,3]]]],{i,3}] /. Point->Identity;
	Point[Midpoint[(Orthocenter/@{v,pqr}) /. Point->Identity]]
]

RightTriangleQ[t_Triangle]:=Module[{a,b,c},
    {a,b,c}=SideLengths[t];
    a^2+b^2==c^2||b^2+c^2==a^2||c^2+a^2==0
]

If[$VersionNumber<6,
RotationMatrix[a_]:={{Cos[#],-Sin[#]},{Sin[#],Cos[#]}}&@a
]

Name[SchifflerPoint]:="Schiffler point"
CenterFunction[SchifflerPoint]:=Sec[A]/(Cos[B]+Cos[C])

SchifflerPointConstruction[vert_List,e1_:5,e2_:5]:=Module[
  {x=Incenter[vert][[1]],a=vert[[1]],b=vert[[2]],c=vert[[3]]},
  f[a_]:=EulerLine[a,e1,e2];
  Map[f,{{x,b,c},{x,c,a},{x,a,b},{a,b,c}}]
]

Name[SecondBrocardCircle]:="second Brocard circle"
CircleFunction[SecondBrocardCircle]:=-((a^2*b*c)/(a^2*b^2 + a^2*c^2 + b^2*c^2))
CircleCenterFunction[SecondBrocardCircle]:=Cos[A]
CircleRadius[SecondBrocardCircle]:=Sqrt[1-4Sin[BrocardAngle]^2]Circumradius

Name[SecondSteinerCircle]:="second Steiner circle"
CircleCenterFunction[SecondSteinerCircle]:=
	-(((b - c)*(b + c)*(a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 4*a^6*c^2 + a^4*b^2*c^2 + a^2*b^4*c^2 - 2*b^6*c^2 + 
    6*a^4*c^4 + a^2*b^2*c^4 + 2*b^4*c^4 - 4*a^2*c^6 - 2*b^2*c^6 + c^8))/a)
CircleFunction[SecondSteinerCircle]:=-(a^6 - a^4*b^2 + a^2*b^4 - b^6 - a^4*c^2 - a^2*b^2*c^2 + b^4*c^2 + a^2*c^4 + b^2*c^4 - c^6)/
 (2*(a - b)*b*(a + b)*(a - c)*c*(a + c))
CircleRadius[SecondSteinerCircle]:=
	Sqrt[-((a^6 - 3*a^4*b^2 + 3*a^2*b^4 - b^6 - 3*a^4*c^2 + 3*a^2*b^2*c^2 - b^4*c^2 + 3*a^2*c^4 - b^2*c^4 - c^6)*
     (a^6 + a^4*b^2 + a^2*b^4 + b^6 - 3*a^4*c^2 - 3*a^2*b^2*c^2 - 3*b^4*c^2 + 3*a^2*c^4 + 3*b^2*c^4 - c^6)*
     (a^6 - 3*a^4*b^2 + 3*a^2*b^4 - b^6 + a^4*c^2 - 3*a^2*b^2*c^2 + 3*b^4*c^2 + a^2*c^4 - 3*b^2*c^4 + c^6))]*
  Circumradius/(2*a*b*c*Abs[(a^2 - b^2)*(a^2 - c^2)*(b^2 - c^2)])

(*
Semiperimeter[]:=(a+b+c)/2
Semiperimeter[l_List]:=Plus@@l/2
Semiperimeter[t_Triangle]:=Semiperimeter[SideLengths[t]]
*)

ShortestLine[l_List]:=Module[{i,d,len=Length[l]},
	d=Table[(l[[i,1]]-l[[i,2]]).(l[[i,1]]-l[[i,2]]),{i,len}];
	Line[l[[Position[d,Min[d]][[1,1]]]]]
]

Sides[t_Triangle]:=Line/@(RotateLeft@Partition[Vertices@t,2,1,1]) /;
	Dimensions[First[t]]=={3,2}
Sides[t_Triangle]:=Line@@@(RotateLeft@Partition[Vertices@t,2,1,1]) /;
	Dimensions[First[t]]=={3,3}
Sides[t_Triangle,x_]:=Sides[t]/.Line[l_]:>LongestLine[l,x]
Sides[q_Quadrilateral]:=Line/@Partition[Vertices@q,2,1,1]
Sides[q_Quadrilateral,x_]:=Sides[q]/.Line[l_]:>LongestLine[l,x]
Sides[t_]:=Sides[Triangle[t]] /; MemberQ[Triangles,t]

(* here, v may be a list of Cartesian points or a trilinear vertex matrix; 
Distance can accept either *)

SideLengths[v_List]:=Distance@@@Partition[RotateLeft[v],2,1,1] 

SideLengths[t:(_Triangle|_Quadrilateral|_Polygon)]:=SideLengths[Evaluate[Vertices[t]]]

SideLengths[triangle_]:= SideLengths[Triangle[triangle]] /; MemberQ[Triangles,triangle]

SideLengths[CevianTriangle[ctr_]]:=Abs[CyclicTrilinears[(a*b*c*Sqrt[\[Beta]^2*\[Gamma]^2 + \[Alpha]^2*\[Beta]^2 + \[Alpha]^2*\[Gamma]^2 + 
     2*\[Alpha]*\[Beta]*\[Gamma]*((-\[Alpha])*Cos[A] + \[Beta]*Cos[B] + 
       \[Gamma]*Cos[C])])/((a*\[Alpha] + b*\[Beta])*(a*\[Alpha] + c*\[Gamma]))] /.
       Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
]

SideLengths[AnticevianTriangle[ctr_]]:=Abs[CyclicTrilinears[
	(2a b c \[Alpha] Sqrt[
		\[Beta]^2+\[Gamma]^2-2\[Beta] \[Gamma] Cos[A]])/Abs[(b \[Beta]-c \[Gamma])^2-(a \[Alpha])^2]
	] /. Thread[{\[Alpha],\[Beta],\[Gamma]}->Trilinears[ctr]]
]

SideRatioPoints[{ka_,kb_,kc_}]:={{0,(1-ka)c,ka b},{kb c,0,(1-kb)a},{(1-kc)b,kc a,0}}

SideUnitVectors[t_Triangle]:=unitVector/@SideVectors[t]

SideVectors[t_Triangle]:=-Subtract@@@Coordinates/@Sides[t]

SimilarQ[t__Triangle]:=
  Equal[And@@Transpose[Sort/@Angles/@{t}]] /; Length[{t}]==2

SimilarQ[t1_,t2_]:=SimilarQ[Triangle[t1],Triangle[t2]] /;
	And@@(MemberQ[Triangles,#]&/@{t1,t2})

Name[SimsonCubic]:="Simson cubic"
CubicEquation[SimsonCubic]:=CyclicSum[SA a \[Alpha](b^2 \[Beta]^2+c^2 \[Gamma]^2)]-(a^2+b^2+c^2)a \[Alpha] b \[Beta] c \[Gamma]

SimsonLine[{p_,q_,r_}]:=TrilinearLine[{
	a p(b c r + q SA)(b c q + r SA),
	b q(c a p + r SB)(c a r + p SB),
	c r(a b q + p SC)(a b p + q SC)
}]

(*
SimsonLine[vert_List,angle_,dv_:0]:=Module[
  {pts=LongestLine[SimsonLinePoints[vert,angle] /. Point->Identity],v},
  v=pts[[2]]-pts[[1]];
  v=v/norm[v];
  Line[{pts[[1]]-dv v,pts[[2]]+dv v}]
]

(* rewrite *)
SimsonLinePoints[vert_List,angle_]:=Module[
  {
    pt=CircumcirclePoint[vert,angle],
    unitvec=SideUnitVectors[vert],v,vec={},
    a,b,c,i
  },
  Do[
    a=(vert[[Add1[i],2]]-vert[[i,2]])/(vert[[Add1[i],1]]-vert[[i,1]]);
    b=-1;
    c=vert[[i,2]]-vert[[i,1]] a;
    v=Distance[pt,{a,b,c}] {unitvec[[Sub1[i],2]],-unitvec[[Sub1[i],1]]};
      (* Make sure line goes it the right direction *)
    AppendTo[vec,If[Distance[pt-v,{a,b,c}]>.001,pt+v,pt-v]],
    {i,3}
  ];
  Point/@vec
]

SimsonLinePoleAngle[v_List,l_List]:=Module[{},
	2.Angle[SimsonLine[v,0.][[1]],l]-Pi
]
*)

Name[SineTripleAngleCircle]:="sine-triple-angle circle"
CircleFunction[SineTripleAngleCircle]:=
	-2(c^2+a b-b^2)(b^2+a b-c^2)(c^2+a c-b^2)(b^2+a c-c^2)Cos[A]/
		(a^4b^2c^2(1+8Cos[A]Cos[B]Cos[C])^2)
CircleRadius[SineTripleAngleCircle]:=Circumradius/Abs[1+8Cos[A]Cos[B]Cos[C]]
CircleCenterFunction[SineTripleAngleCircle]:=Cos[3A]

SoddyCenters[t_Triangle]:={InnerSoddyCenter[t],OuterSoddyCenter[t]}

SoddyCircleContactPoints[t_Triangle]:=Module[
	{u=Unit/@SideVectors[t],r=TangentCircleRadii[t]},
	#1+#2#3&@@@Transpose[{RotateLeft[Vertices[t]],u,RotateLeft[r]}]
]

SoddyCircles[t_Triangle]:=
	Circle@@@Transpose[{Coordinates/@SoddyCenters[t],SoddyRadii[t]}]

Name[SoddyLine]:="Soddy line"
LineFunction[SoddyLine]:=a(b-c)(-a+b+c)^2
CenterLine[X[657]]:=SoddyLine

SoddyRadii[t_Triangle]:=Module[{r=TangentCircleRadii[t]},
	Abs[Times@@r/(Plus@@Times@@@Partition[r,2,1,1]+2# Sqrt[Times@@r Plus@@r])&/@{1,-1}]
]

Name[SpiekerCenter]:="Spieker center"
CenterFunction[SpiekerCenter]:=(b+c)/a

Name[SpiekerCircle]:="Spieker circle"
CircleFunction[SpiekerCircle]:=-(-3*a^2 + 5*b^2 - 6*b*c + 5*c^2 + 2*a*(b + c))/(16*b*c)
CircleCenterFunction[SpiekerCircle]:=CenterFunction[SpiekerCenter]
CircleRadius[SpiekerCircle]:=Inradius/2

Splitters[t_Triangle]:=Module[{i,v=Vertices@t,c=Coordinates@NagelPoint[t]},
	Table[
		Line[{v[[i]],
		  Intersections[Line@{v[[i]],c},Line@{v[[addn[i,1,3]]],v[[addn[i,2,3]]]}]}],
		{i,3}
	]
]

Name[StammlerCircle]:="Stammler circle"
CircleCenterFunction[StammlerCircle]:=Cos[A]
CircleFunction[StammlerCircle]:=3*a^2*b*c/(16Area^2)
CircleRadius[StammlerCircle]:=2Circumradius

CircleTripletFunction[StammlerCircles]:={
	{Cos[A]-2Cos[(B-C)/3],Cos[B]+2Cos[(B+2C)/3],Cos[C]+2Cos[(2B+C)/3]},
	Sqrt[(1+8 Cos[(B-C)/3] Cos[(B+2 C)/3] Cos[(2 B+C)/3])] Circumradius
}

Name[StammlerCirclesRadicalCircle]:="Stammler circles radical circle"
CircleCenterFunction[StammlerCirclesRadicalCircle]:=Cos[B-C]
CircleFunction[StammlerCirclesRadicalCircle]:=
	(a^4*b^2 - 2*a^2*b^4 + b^6 + a^4*c^2 + 2*a^2*b^2*c^2 - b^4*c^2 - 2*a^2*c^4 - b^2*c^4 + c^6)/(32*Area^2*b*c)
CircleRadius[StammlerCirclesRadicalCircle]:=
	Sqrt[a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 + 7*a^2*b^2*c^2 - b^4*c^2 - a^2*c^4 - b^2*c^4 + c^6]/(8*Area)

Name[StammlerHyperbola]:="Stammler hyperbola"
ConicEquation[StammlerHyperbola]:=c^2(\[Alpha]^2-\[Beta]^2)+a^2(\[Beta]^2-\[Gamma]^2)+b^2(-\[Alpha]^2+\[Gamma]^2)

Name[StammlerTriangle]:="Stammler triangle"
TrilinearVertexMatrix[StammlerTriangle]:=
{{Cos[A] - 2*Cos[(B - C)/3], Cos[B] + 2*Cos[(B + 2*C)/3], Cos[C] + 2*Cos[(2*B + C)/3]}, 
 {Cos[A] + 2*Cos[(A + 2*C)/3], Cos[B] - 2*Cos[(-A + C)/3], Cos[C] + 2*Cos[(2*A + C)/3]}, 
 {Cos[A] + 2*Cos[(A + 2*B)/3], Cos[B] + 2*Cos[(2*A + B)/3], -2*Cos[(A - B)/3] + Cos[C]}}

Name[SteinerCircle]:="Steiner circle"
CircleFunction[SteinerCircle]:=-(-a^6 + 3*a^4*b^2 - 3*a^2*b^4 + b^6 + 3*a^4*c^2 + 6*a^2*b^2*c^2 - b^4*c^2 - 3*a^2*c^4 - b^2*c^4 + c^6)/(4*b*(-a + b - c)*(a + b - c)*c*(-a + b + c)*(a + b + c))
CircleCenterFunction[SteinerCircle]:=CenterFunction[NinePointCenter]
CircleRadius[SteinerCircle]:=3Circumradius/2

SteinerCircles[n_]:=Module[{b=(1-Sin[Pi/n])/(1+Sin[Pi/n]),r,c,i},
	c=(1-b)/2;
	r=b+c;
	{Table[Circle[r{Cos[2Pi i/n],Sin[2Pi i/n]},c],{i,n}],
	Circle[{0,0},b],
	Circle[{0,0},1]
	}
]

Name[SteinerCircumellipse]:="Steiner circumellipse"
CircumconicParameters[SteinerCircumellipse]:=1/{a,b,c}

Name[SteinerInellipse]:="Steiner inellipse"
InconicParameters[SteinerInellipse]:={a,b,c}

CenterFunction[SteinerPoint]:=b c(a^2-b^2)(a^2-c^2)
Name[SteinerPoint]:="Steiner point"

Name[SteinerTriangle]:="Steiner triangle"
TrilinearVertexMatrix[SteinerTriangle]:=
{{0,(b-a)(a+b)c,b (a-c)(a+c)},{(b-a)(a+b)c,0,a(c-b)(b+c)},{b(c-a)(a+c),a(b-c)(b+c),0}}

Name[StevanovicCircle]:="Stevanovic circle"
CircleFunction[StevanovicCircle]:=(a^2 - b^2 - c^2)/(2*(a - b)*(a - c))
CircleCenterFunction[StevanovicCircle]:=Cos[B]-Cos[C]
CircleRadius[StevanovicCircle]:=Sqrt[a*b*c*(a^5+a^3*b*c-a^4*(b+c)+(b-c)^2*(b+c)*(b^2+c^2)-a*(b-c)^2*(b^2+b*c+c^2))]/(2*Abs[(a-b)*(a-c)*(b-c)])

Sub1[i_Integer]:=If[i==1,3,i-1]

Symmedians[t_Triangle]:=
	Line/@Transpose[{Vertices@t,Vertices@SymmedialTriangle[t]}]

Name[SymmedialCircle]:="symmedial circle"
CircleFunction[SymmedialCircle]:=(b*c*(a^4 - a^2*b^2 - b^4 - a^2*c^2 - b^2*c^2 - c^4))/
 (2*(a^2 + b^2)*(a^2 + c^2)*(b^2 + c^2))
CircleCenterFunction[SymmedialCircle]:=-(a*(a^6*b^2 - 2*a^2*b^6 + b^8 + a^6*c^2 - 6*a^4*b^2*c^2 - 
   3*a^2*b^4*c^2 + b^6*c^2 - 3*a^2*b^2*c^4 - 6*b^4*c^4 - 
   2*a^2*c^6 + b^2*c^6 + c^8))
CircleRadius[SymmedialCircle]:=(a*b*c*Sqrt[(a^4 - 3*a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2 - c^4)*(a^4 + a^2*b^2 - b^4 + a^2*c^2 + 3*b^2*c^2 - c^4)*
    (a^4 - a^2*b^2 - b^4 - 3*a^2*c^2 - b^2*c^2 + c^4)])/(2*(a^2 + b^2)*Sqrt[(a + b - c)*(a - b + c)*(-a + b + c)*(a + b + c)]*
  (a^2 + c^2)*(b^2 + c^2))

Name[SymmedialTriangle]:="symmedial triangle"
TrilinearVertexMatrix[SymmedialTriangle]:={{0,b,c},{a,0,c},{a,b,0}}

SymmedianPointBarycentric[Triangle[{{p1_, p2_, p3_}, {q1_, q2_, q3_}, {r1_, r2_, r3_}}]] := 
  Module[{SumP = p1 + p2 + p3, SumQ = q1 + q2 + q3, SumR = r1 + r2 + r3},
    ({p1*SumP*#1[[1]] + q1*SumQ*#1[[2]] + r1*SumR*#1[[3]], 
       p2*SumP*#1[[1]] + q2*SumQ*#1[[2]] + r2*SumR*#1[[3]], 
       p3*SumP*#1[[1]] + q3*SumQ*#1[[2]] + r3*SumR*#1[[3]]} & )[
     {((-q2 - q3)*r1 + q1*(r2 + r3))^2*SA + ((-q1 - q3)*r2 + q2*(r1 + r3))^2*
        SB + (q3*(r1 + r2) - (q1 + q2)*r3)^2*SC, 
      ((p2 + p3)*r1 - p1*(r2 + r3))^2*SA + ((p1 + p3)*r2 - p2*(r1 + r3))^2*
        SB + ((-p3)*(r1 + r2) + (p1 + p2)*r3)^2*SC, 
      ((-p2 - p3)*q1 + p1*(q2 + q3))^2*SA + ((-p1 - p3)*q2 + p2*(q1 + q3))^2*
        SB + (p3*(q1 + q2) - (p1 + p2)*q3)^2*SC}]
]

SymmedianPoint[Triangle[{{p1t_, p2t_, p3t_}, {q1t_, q2t_, q3t_}, {r1t_, r2t_, r3t_}}]] := 
  Module[{p1, p2, p3, q1, q2, q3, r1, r2, r3}, 
   {{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}} = ({a, b, c}*#1 & ) /@ 
      {{p1t, p2t, p3t}, {q1t, q2t, q3t}, {r1t, r2t, r3t}}; 
    SymmedianPointBarycentric[Triangle[{{p1, p2, p3}, {q1, q2, q3}, {r1, r2, r3}}]]/{a, b, c}
]

SymmedianPoint[tri_]:=SymmedianPoint[Triangle[tri]] /; MemberQ[Triangles,tri]

CenterFunction[SymmedianPoint]:=a
Name[SymmedianPoint]:="symmedian point, also known as the Lemoine point"

(* Symmetrize *)

CyclicTriplet[expr_]:={expr,
    expr/.{a->b,b->c,c->a,A->B,B->C,C->A},
    expr/.{a->c,b->a,c->b,A->C,B->A,C->B}}
PlusMinusQ[expr__]:=(SameQ@@#||SameQ@@({1,-1}#))&/@Or@@Partition[{expr},2,1,1]
PlusMinus2Q[l_,expr_]:=expr===l[[1]]||expr===-l[[1]]||expr===l[[2]]||expr===-l[[2]]
ReducedTerm[expr_]:=Module[{e=Split[Sort[Last/@expr]]},
    (Times@@CyclicTriplet[expr[[1,1]]])^(-First[Switch[e,{{_},{_,_}},e[[-1]],_,e[[1]]]])
]

Symmetrize[0]:=0
Symmetrize[l0_List?VectorQ]:=Module[{l=Factor[l0],expr,gcd,result,zeros,nonz},
	gcd=PolynomialGCD@@l;
	zeros=Flatten[Position[l,0]];
	nonz=Complement[Range[3],zeros];
	result=Switch[Length[zeros],
		3,{0,0,0},
		2,ReplacePart[{0,0,0},1,nonz],
		0|1,expr=Symmetrize[Cancel[l[[nonz[[1]]]]/gcd]];Cancel[l expr/l[[nonz[[1]]]]]
	];
	If[LeafCount[-result]<LeafCount[result],-1,1]result
] /; Length[l0]==3

Symmetrize[expr_]:=Module[
	{
		(* delete positive constant terms *)
		(* need Simplify here because of bug(57065) *)
		f=DeleteCases[
          FactorList[expr],{_?Positive,_}|_?(!FreeQ[#,(a|b|c|A|B|C)]&&
                    Simplify[Equal@@CyclicTriplet[#]]&)],
		triples,triplefree,doubles,result
	},
	If[f==={},1,
		triples=Subsets[f,{3}];
		triplefree=Cancel[Times@@
            Power@@@f Times@@(If[
                    PlusMinusQ@@
                      Expand[Times@@@Map[First,CyclicTriplet[#],{2}]],
                    ReducedTerm[#],1]&/@triples)];
		doubles=Subsets[FactorList[triplefree],{2}];
		result=Cancel[triplefree Times@@(If[
			PlusMinus2Q[Rest[CyclicTriplet[#[[1,1]]]],#[[2,1]]],
			ReducedTerm[#],1]&/@doubles)
		];
		If[LeafCount[-result]<LeafCount[result],-1,1]result
	]
]

CircleTripletFunction[TangentCircles]:={{1,0,0},(-a+b+c)/2}

Name[TangentialMidArcCircle]:="tangential mid-arc circle"
CircleCenterFunction[TangentialMidArcCircle]:=
-((a - b - c)*(a + b - c)*(a - b + c)*(a^3 + a^2*b - a*b^2 - b^3 + a^2*c - 10*a*b*c + b^2*c - 
    a*c^2 + b*c^2 - c^3)) - 4*b*(a - b - c)*c*(2*a^3 - 3*a^2*b + 2*a*b^2 - b^3 - 3*a^2*c - 
   4*a*b*c + b^2*c + 2*a*c^2 + b*c^2 - c^3)*Sin[A/2] + 
 2*c*(a - b + c)*(a^4 + 10*a^3*b - 6*a^2*b^2 - 2*a*b^3 - 3*b^4 - 8*a^2*b*c + 4*b^3*c - 
   2*a^2*c^2 + 2*a*b*c^2 + 2*b^2*c^2 - 4*b*c^3 + c^4)*Sin[B/2] + 
 2*b*(a + b - c)*(a^4 - 2*a^2*b^2 + b^4 + 10*a^3*c - 8*a^2*b*c + 2*a*b^2*c - 4*b^3*c - 
   6*a^2*c^2 + 2*b^2*c^2 - 2*a*c^3 + 4*b*c^3 - 3*c^4)*Sin[C/2]
CircleFunction[TangentialMidArcCircle]:=
-((-a + b + c)*((a - b - c)*(a + b - c)*(a - b + c) + 2*b*c*(-a + b + c)*Sin[A/2] - 
    2*(a - c)*c*(a - b + c)*Sin[B/2] - 2*(a - b)*b*(a + b - c)*Sin[C/2]))/
 (2*b*c*(a + b + c)*((-a + b + c)*Sin[A/2] + (a - b + c)*Sin[B/2] + (a + b - c)*Sin[C/2]))
CircleRadius[TangentialMidArcCircle]:=Module[{sa=(b+c-a)/2,sb=(a+c-b)/2,sc=(a+b-c)/2,Z,s=Semiperimeter},
	Z=sa Sin[A/2] + sb Sin[B/2] + sc Sin[C/2];
Sqrt[(a^2 b^2 c^2 + (SA (sb (-2 sa sb sc + c (-b + c) sa Sin[A/2] + a c sb Sin[B/2] + a (a - b) sc Sin[C/2]) -
 sc (-2 sa sb sc + b (b - c) sa Sin[A/2] + a (a - c) sb Sin[B/2] + a b sc Sin[C/2]))^2)/(s^2 Z^2) +
 (SB (sc (-2 sa sb sc + b (b - c) sa Sin[A/2] + a (a - c) sb Sin[B/2] + a b sc Sin[C/2]) -
 sa (-2 sa sb sc + b c sa Sin[A/2] + c (-a + c) sb Sin[B/2] + b (-a + b) sc Sin[C/2]))^2)/(s^2 Z^2) +
 (SC (-(sb (-2 sa sb sc + c (-b + c) sa Sin[A/2] + a c sb Sin[B/2] + a (a - b) sc Sin[C/2])) +
 sa (-2 sa sb sc + b c sa Sin[A/2] + c (-a + c) sb Sin[B/2] + b (-a + b) sc Sin[C/2]))^2)/(s^2 Z^2) -
 (2 (b^2 sb SB (-2 sa sb sc + c (-b + c) sa Sin[A/2] + a c sb Sin[B/2] + a (a - b) sc Sin[C/2]) +
 c^2 sc SC (-2 sa sb sc + b (b - c) sa Sin[A/2] + a (a - c) sb Sin[B/2] + a b sc Sin[C/2]) +
 a^2 sa SA (-2 sa sb sc + b c sa Sin[A/2] + c (-a + c) sb Sin[B/2] + b (-a + b) sc Sin[C/2])))/(s Z))/(4 S^2)]
]

tangentQ[c__]:=Module[{d=Distance@@(Center/@{c}),rs=CircleRadius/@{c}},
	Abs[Subtract@@rs]-d == 0 || Plus@@rs-d == 0
]
TangentQ[c__]:=tangentQ[c]/; And@@(MemberQ[CentralCircles,#]&/@{c})
TangentQ[c__Circle]:=tangentQ[c] /; Length[{c}]==2

Name[TangentialMidArcTriangle]:="tangential mid-arc triangle"
TrilinearVertexMatrix[TangentialMidArcTriangle]:=
  With[{x=Cos[#1/2],y=Cos[#2/2],z=Cos[#3/2]},
    MapIndexed[
      RotateRight[#1,#2-1]&,{-y z,z(z+x),y(y+x)}&@@@
        NestList[RotateLeft,{A,B,C},2]]
]

TangentialQuadrilateral[a_List]:=Module[
	{v,pv,i},
	v=Table[{Cos[a[[i]]],Sin[a[[i]]]},{i,4}];
	pv=Table[{v[[i,2]],-v[[i,1]]},{i,4}];
	Quadrilateral[Table[Intersections[Line@{v[[i]],v[[i]]+pv[[i]]},
		Line@{v[[addn[i,1,4]]],v[[addn[i,1,4]]]+pv[[addn[i,1,4]]]}],
	{i,4}]]
]

TangentialQuadrilateralNormals[a_List]:=Module[{i},
	Table[Line[{{0,0},{Cos[a[[i]]],Sin[a[[i]]]}}],{i,4}]
]

Name[TangentialCircle]:="tangential circle"
CircleFunction[TangentialCircle]:=(a^2*b*c)/((a^2 + b^2 - c^2)*(a^2 - b^2 + c^2))
CircleCenterFunction[TangentialCircle]:=a*(-(a^2*Cos[2*A]) + b^2*Cos[2*B] + c^2*Cos[2*C])
CircleRadius[TangentialCircle]:=Circumradius/(4Abs[Cos[A]Cos[B]Cos[C]])

Name[TangentialTriangle]:="tangential triangle"
TrilinearVertexMatrix[TangentialTriangle]:={{-a,b,c},{a,-b,c},{a,b,-c}}

CenterFunction[TangentialTriangleCircumcenter]:=
	a(b^2Cos[2B]+c^2Cos[2C]-a^2Cos[2A])
Name[TangentialTriangleCircumcenter]:="tangential triangle circumcenter"

CenterFunction[TarryPoint]:=b c/(b^4+c^4-a^2b^2-a^2c^2)
Name[TarryPoint]:="Tarry point"

Name[TaylorCenter]:="Taylor center"
CenterFunction[TaylorCenter]:=Cos[A]-Cos[2A]Cos[B-C]

Name[TaylorCircle]:="Taylor circle"
CircleFunction[TaylorCircle]:=-b*c*Cos[A]^2/(4Circumradius^2)
CircleCenterFunction[TaylorCircle]:=Cos[A]-Cos[2A]Cos[B-C]
CircleRadius[TaylorCircle]:=Circumradius Sqrt[(Sin[A]Sin[B]Sin[C])^2+(Cos[A]Cos[B]Cos[C])^2]

TaylorHexagon[t_Triangle]:=Map[TrilinearToCartesian[t,#]&,
{
{{-Cos[B] Sec[C],-Sec[B]-Cos[A] Sec[C],0},{-Cos[C] Sec[B],0,-Cos[A] Sec[B]-Sec[C]}},
{{-Sec[A]-Cos[B] Sec[C],-Cos[A] Sec[C],0},{0,-Cos[C] Sec[A],-Cos[B] Sec[A]-Sec[C]}},
{{-Sec[A]-Cos[C] Sec[B],0,-Cos[A] Sec[B]},{0,-Cos[C] Sec[A]-Sec[B],-Cos[B] Sec[A]}}
}/.Thread[{A,B,C}->Angles[t]],
{2}
]

Name[ThirdBrocardPointCircle]:="third Brocard point circle"
CircleFunction[ThirdBrocardPointCircle]:=-a^3(b^2-c^2)^2
CircleCenterFunction[ThirdBrocardPointCircle]:=1/a^3
CircleRadius[ThirdBrocardPointCircle]:=4Area a b c/(b^2c^2+c^2a^2+a^2b^2)

Name[ThirdLemoineCircle]:="third Lemoine circle"
CircleFunction[ThirdLemoineCircle]:=
-((a^2 - 2*b^2 - 2*c^2)*(a^6 + a^4*b^2 - a^2*b^4 - b^6 + a^4*c^2 - 17*a^2*b^2*c^2 - 9*b^4*c^2 - a^2*c^4 - 9*b^2*c^4 - c^6))/
 (2*b*c*(4*a^2 + b^2 + c^2)*(a^2 + 4*b^2 + c^2)*(a^2 + b^2 + 4*c^2))
CircleCenterFunction[ThirdLemoineCircle]:=
(-6*a^10 - 11*a^8*b^2 + 20*a^6*b^4 + 12*a^4*b^6 - 14*a^2*b^8 - b^10 - 11*a^8*c^2 + 62*a^6*b^2*c^2 + 147*a^4*b^4*c^2 - 
  17*a^2*b^6*c^2 - b^8*c^2 + 20*a^6*c^4 + 147*a^4*b^2*c^4 + 102*a^2*b^4*c^4 + 2*b^6*c^4 + 12*a^4*c^6 - 17*a^2*b^2*c^6 + 
  2*b^4*c^6 - 14*a^2*c^8 - b^2*c^8 - c^10)/a
CircleRadius[ThirdLemoineCircle]:=
Sqrt[-(((-3*a^6 + a^4*b^2 + 5*a^2*b^4 + b^6 + 3*a^4*c^2 + 23*a^2*b^2*c^2 + 5*b^4*c^2 + 3*a^2*c^4 + b^2*c^4 - 3*c^6)*
     (a^6 + 5*a^4*b^2 + a^2*b^4 - 3*b^6 + 5*a^4*c^2 + 23*a^2*b^2*c^2 + 3*b^4*c^2 + a^2*c^4 + 3*b^2*c^4 - 3*c^6)*
     (-3*a^6 + 3*a^4*b^2 + 3*a^2*b^4 - 3*b^6 + a^4*c^2 + 23*a^2*b^2*c^2 + b^4*c^2 + 5*a^2*c^4 + 5*b^2*c^4 + c^6))/
    ((a - b - c)*(a + b - c)*(a - b + c)*(a + b + c)))]/(2*(4*a^2 + b^2 + c^2)*(a^2 + 4*b^2 + c^2)*(a^2 + b^2 + 4*c^2))

(*
Name[ThomsenEllipse[k_]]:="Thomsen ellipse"
ConicEquation[ThomsenEllipse[k_]]:=(-a^2)*k*\[Alpha]^2 + a^2*k^2*\[Alpha]^2 + a*b*\[Alpha]*\[Beta] - 
  2*a*b*k*\[Alpha]*\[Beta] + 2*a*b*k^2*\[Alpha]*\[Beta] - b^2*k*\[Beta]^2 + 
  b^2*k^2*\[Beta]^2 + a*c*\[Alpha]*\[Gamma] - 2*a*c*k*\[Alpha]*\[Gamma] + 
  2*a*c*k^2*\[Alpha]*\[Gamma] + b*c*\[Beta]*\[Gamma] - 2*b*c*k*\[Beta]*\[Gamma] + 
  2*b*c*k^2*\[Beta]*\[Gamma] - c^2*k*\[Gamma]^2 + c^2*k^2*\[Gamma]^2
*)

Name[ThomsonCubic]:="Thomson cubic"
PivotalIsogonalCubicFunction[ThomsonCubic]:=b c

ToAngles[expr_]:=expr //. Rule@@@Flatten[Map[CyclicTrilinears,{
	{ a^2+b^2-c^2, 2a b Cos[C]},
	{-a^2-b^2+c^2,-2a b Cos[C]},
	{(a + b - c) (a - b + c) (-a + b + c) (a + b + c),16Area^2},
	{1/((a + b - c) (a - b + c) (-a + b + c) (a + b + c)),1/Area^2/16},
	{1/(a + b - c) 1/(a - b + c) 1/(-a + b + c) 1/(a + b + c),1/Area^2/16},
	{1/(a + b - c) 1/(a - b + c) 1/(a - b - c) 1/(a + b + c),-1/Area^2/16},
	{a^4+b^4+c^4-2b^2a^2-2c^2a^2-2b^2c^2,-4Area^2},
	{-a^4 + 2*a^2*b^2 - b^4 + 2*a^2*c^2 + 2*b^2*c^2 - c^4,4Area^2},
	{(a-b-c) (a+b-c) (a-b+c) (a+b+c),-16Area^2},
	{((a-b-c) (a+b-c) (a-b+c) (a+b+c)),-16Area^2},
	{(-a+b+c) (a+b-c) (a-b+c) (a+b+c),16Area^2},
	{(a + b - c)*(a - b + c)*(-a + b + c)*(a + b + c),16Area^2},
	{((a + b - c)*(a - b + c)*(-a + b + c)*(a + b + c)),16Area^2},
	{((-a+b+c) (a+b-c) (a-b+c) (a+b+c)),16Area^2},
	{1/((a-b-c) (a+b-c) (a-b+c) (a+b+c)),-1/(16Area^2)},
	{1/((-a+b+c) (a+b-c) (a-b+c) (a+b+c)),1/(16Area^2)},
	{(a + b - c) (a - b + c) (-a + b + c),4(a+b+c)Inradius^2},
	{-(a - b - c) (a + b - c) (a - b + c),4(a+b+c)Inradius^2},
	{-((a - b - c)*(a + b - c)*(a - b + c)),4(a+b+c)Inradius^2},
	{((a - b - c)*(a + b - c)*(a - b + c)),-4(a+b+c)Inradius^2},
	{1/((a - b - c)*(a + b - c)*(a - b + c)),-1/(4(a+b+c)Inradius^2)},
	{Inradius^2/Area^2,4/(a+b+c)^2},
	{-a^2 + b^2 + 2*b*c + c^2, 4b c Cos[A/2]^2},
	{ a^2 - b^2 + 2*b*c - c^2, 4b c Sin[A/2]^2},
	{ a^3 + a^2*b - a*b^2 - b^3 + a^2*c - 2*a*b*c + b^2*c - a*c^2 + b*c^2 - c^3, 2a b c(-1 - Cos[A] + Cos[B] + Cos[C])},
	{-a^3 - a^2*b + a*b^2 + b^3 + a^2*c - 2*a*b*c + b^2*c + a*c^2 - b*c^2 - c^3, 2a b c(-1 + Cos[A] - Cos[B] + Cos[C])},
	{-a^3 + a^2*b + a*b^2 - b^3 - a^2*c - 2*a*b*c - b^2*c + a*c^2 + b*c^2 + c^3, 2a b c(-1 + Cos[A] + Cos[B] - Cos[C])},
	{ a^3 + a^2*b - a*b^2 - b^3 + a^2*c - 2*a*b*c + b^2*c - a*c^2 + b*c^2 - c^3, -2*a*b*c*(-1 - Cos[A] + Cos[B] + Cos[C])}, 
	{-a^3 - a^2*b + a*b^2 + b^3 + a^2*c - 2*a*b*c + b^2*c + a*c^2 - b*c^2 - c^3, -2*a*b*c*(-1 + Cos[A] - Cos[B] + Cos[C])}, 
	{-a^3 + a^2*b + a*b^2 - b^3 - a^2*c - 2*a*b*c - b^2*c + a*c^2 + b*c^2 + c^3, -2*a*b*c*(-1 + Cos[A] + Cos[B] - Cos[C])},
	{a^3 - 2*a^2*b - 2*a*b^2 + b^3 - 2*a^2*c + 9*a*b*c - 2*b^2*c - 2*a*c^2 - 2*b*c^2 + c^3,-9(a+b+c)IG^2},
	{-a^3 + 2*a^2*b + 2*a*b^2 - b^3 + 2*a^2*c - 9*a*b*c + 2*b^2*c + 2*a*c^2 + 2*b*c^2 - c^3,9(a+b+c)IG^2},
	{a^3 - a^2*b - a*b^2 + b^3 - a^2*c + 3*a*b*c - b^2*c - a*c^2 - b*c^2 + c^3,16Area^2OI^2/(a b c)},
	{-a^3 + a^2*b + a*b^2 - b^3 + a^2*c - 3*a*b*c + b^2*c + a*c^2 + b*c^2 - c^3,-16Area^2OI^2/(a b c)},
	{a^4 - a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2 + c^4,4 OK^2 Area^2(a^2+b^2+c^2)^2/(a^2 b^2 c^2)},
	{-a^4 + a^2*b^2 - b^4 + a^2*c^2 + b^2*c^2 - c^4,-4 OK^2 Area^2(a^2+b^2+c^2)^2/(a^2 b^2 c^2)},
	{ a^4 - 2*a^2*b^2 + b^4 - a^2*c^2 - b^2*c^2,-(2*a*b*c^2)Cos[A-B]},
	{-a^4 + 2*a^2*b^2 - b^4 + a^2*c^2 + b^2*c^2, (2*a*b*c^2)Cos[A-B]},
	{ a^4 + a^2*b^2 - 2*b^4 + a^2*c^2 + 4*b^2*c^2 - 2*c^4, 2a^2b c(2Cos[B-C]-Cos[A])},
	{-a^4 - a^2*b^2 + 2*b^4 - a^2*c^2 - 4*b^2*c^2 + 2*c^4,-2a^2b c(2Cos[B-C]-Cos[A])},
	{-a^4+b a^3+c a^3-b c a^2+b^3 a+c^3 a-b c^2 a-b^2 c a-b^4-c^4+b c^3+b^3 c, -4Inradius^2 IL^2},
	{a^4-b a^3-c a^3+b c a^2-b^3 a-c^3 a+b c^2 a+b^2 c a+b^4+c^4-b c^3-b^3 c, 4Inradius^2 IL^2},
	{-2*a^4 + a^2*b^2 + b^4 + a^2*c^2 - 2*b^2*c^2 + c^4, 2 a^2 b c(Cos[A]-2 Cos[B] Cos[C])},
	{2*a^4 - a^2*b^2 - b^4 - a^2*c^2 + 2*b^2*c^2 - c^4, -2 a^2 b c(Cos[A]-2 Cos[B] Cos[C])},
	{a^4 - 2*a^2*b^2 + b^4 - 2*a^2*c^2 + c^4, 2*b^2*c^2*Cos[2*A]}, 
	{-a^4 + 2*a^2*b^2 - b^4 + 2*a^2*c^2 - c^4, -2*b^2*c^2*Cos[2*A]},
	{a^6-3 b^2 a^4-3 c^2 a^4-3 b^4 a^2-3 c^4 a^2+15 b^2 c^2 a^2+b^6+c^6-3 b^2 c^4-3 b^4 c^2, -9(a^2+b^2+c^2)^2GK^2},
	{-a^6+3 b^2 a^4+3 c^2 a^4+3 b^4 a^2+3 c^4 a^2-15 b^2 c^2 a^2-b^6-c^6+3 b^2 c^4+3 b^4 c^2, 9(a^2+b^2+c^2)^2GK^2},
	{a^4-b^4+2*a^2*b*c+2*b^2*c^2-c^4,2a^2b c(1+2Cos[B]Cos[C])},
	{-a^4 + b^4 - 2*a^2*b*c - 2*b^2*c^2 + c^4,-2a^2b c(1+2Cos[B]Cos[C])},
	{a^4 - 2*a^3*b + 2*a^2*b^2 - 2*a*b^3 + b^4 - 2*a^3*c + a^2*b*c + a*b^2*c - 2*b^3*c + 2*a^2*c^2 + a*b*c^2 + 2*b^2*c^2 - 2*a*c^3 - 2*b*c^3 + c^4, -(a+b+c)(a^2+b^2+c^2)^2IK^2/(a b c)},
	{-3*a^4 + 2*a^2*b^2 + b^4 + 2*a^2*c^2 - 2*b^2*c^2 + c^4, a*(Cos[A] - Cos[B]*Cos[C])}, 
	{ 3*a^4 - 2*a^2*b^2 - b^4 - 2*a^2*c^2 + 2*b^2*c^2 - c^4,  a*(-Cos[A] + Cos[B]*Cos[C])}, 
	{(a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 + 3*a^2*b^2*c^2 - b^4*c^2 - a^2*c^4 - b^2*c^4 + c^6),16Area^2OH^2},
	{-(a^6 - a^4*b^2 - a^2*b^4 + b^6 - a^4*c^2 + 3*a^2*b^2*c^2 - b^4*c^2 - a^2*c^4 - b^2*c^4 + c^6),-16Area^2OH^2},
	{ a^6-a^4*b^2-a^2*b^4+b^6-a^4*c^2+a^2*b^2*c^2-b^4*c^2-a^2*c^4-b^2*c^4+c^6, -a^2b^2c^2(1+8Cos[A]Cos[B]Cos[C])},
	{-a^6+a^4*b^2+a^2*b^4-b^6+a^4*c^2-a^2*b^2*c^2+b^4*c^2+a^2*c^4+b^2*c^4-c^6,  a^2b^2c^2(1+8Cos[A]Cos[B]Cos[C])},
	{-a^6+3*a^4*b^2-3*a^2*b^4+b^6+3*a^4*c^2+2*a^2*b^2*c^2-b^4*c^2-3*a^2*c^4-b^2*c^4+c^6, 4a^2b^2c^2(-Cos[A]^2+Cos[B]^2+Cos[C]^2)},
	{ a^6-3*a^4*b^2+3*a^2*b^4-b^6-3*a^4*c^2-2*a^2*b^2*c^2+b^4*c^2+3*a^2*c^4+b^2*c^4-c^6, 4a^2b^2c^2( Cos[A]^2-Cos[B]^2-Cos[C]^2)},
	{a^6 + 2*a^5*b - a^4*b^2 - 4*a^3*b^3 - a^2*b^4 + 2*a*b^5 + b^6 + 2*a^5*c + 2*a^4*b*c - 4*a^3*b^2*c - 4*a^2*b^3*c + 2*a*b^4*c + 2*b^5*c - a^4*c^2 - 4*a^3*b*c^2 + 10*a^2*b^2*c^2 - 4*a*b^3*c^2 - b^4*c^2 - 4*a^3*c^3 - 4*a^2*b*c^3 - 4*a*b^2*c^3 - 4*b^3*c^3 - a^2*c^4 + 2*a*b*c^4 - b^2*c^4 + 2*a*c^5 + 2*b*c^5 + c^6,16Area^2(16Circumradius^2-(a+b+c)^2)},
	{-(a^6 + 2*a^5*b - a^4*b^2 - 4*a^3*b^3 - a^2*b^4 + 2*a*b^5 + b^6 + 2*a^5*c + 2*a^4*b*c - 4*a^3*b^2*c - 4*a^2*b^3*c + 2*a*b^4*c + 2*b^5*c - a^4*c^2 - 4*a^3*b*c^2 + 10*a^2*b^2*c^2 - 4*a*b^3*c^2 - b^4*c^2 - 4*a^3*c^3 - 4*a^2*b*c^3 - 4*a*b^2*c^3 - 4*b^3*c^3 - a^2*c^4 + 2*a*b*c^4 - b^2*c^4 + 2*a*c^5 + 2*b*c^5 + c^6),-16Area^2(16Circumradius^2-(a+b+c)^2)},
	{-a^8+2*a^6*b^2-2*a^2*b^6+b^8+2*a^6*c^2-2*b^6*c^2+2*b^4*c^4-2*a^2*c^6-2*b^2*c^6+c^8,2*a^2*b^2*c^2*(-a^2*Cos[2*A]+b^2*Cos[2*B]+c^2*Cos[2*C])},
	{ a^8-2*a^6*b^2+2*a^2*b^6-b^8-2*a^6*c^2+2*b^6*c^2-2*b^4*c^4+2*a^2*c^6+2*b^2*c^6-c^8,2*a^2*b^2*c^2*( a^2*Cos[2*A]-b^2*Cos[2*B]-c^2*Cos[2*C])},
	{a^8-4*a^6*b^2+6*a^4*b^4-4*a^2*b^6+b^8-4*a^6*c^2+a^4*b^2*c^2+a^2*b^4*c^2+2*b^6*c^2+6*a^4*c^4+a^2*b^2*c^4-6*b^4*c^4-4*a^2*c^6+2*b^2*c^6+c^8,5*Cos[A]-4*Cos[B]*Cos[C]-8*Cos[A]^2*Sin[B]*Sin[C]},
	{a^10 - a^8*b^2 - a^2*b^8 + b^10 - a^8*c^2 + a^6*b^2*c^2 + a^2*b^6*c^2 - b^8*c^2 + a^2*b^2*c^6 - a^2*c^8 - b^2*c^8 + c^10,16Area^2(a^2+b^2+c^2)^2HK^2}
	},{1}],1] /. {
		BrocardAngle :> ArcCot[Cot[A]+Cot[B]+Cot[C]],
		S  :> 2Area,
		SA :> b c Cos[A],
		SB :> a c Cos[B],
		SC :> a b Cos[C],
		SW :> (a^2+b^2+c^2)/2,
		sa :> Inradius Cot[A/2],
		sb :> Inradius Cot[B/2],
		sc :> Inradius Cot[C/2]
	}

ToSidelengths[expr_]:=expr /.
	Thread[{A,B,C}->(ArcCos[(-#1^2+#2^2+#3^2)/(2#2#3)]&@@@NestList[RotateLeft,{a,b,c},2])] /.
	TriangleRules

TriangleRules:= {
	Area          :> Sqrt[(a+b-c)(a-b+c)(-a+b+c)(a+b+c)]/4,
	BrocardAngle  :> ArcCot[(a^2+b^2+c^2)/Sqrt[(a+b-c)(a-b+c)(-a+b+c)(a+b+c)]],
	Circumradius  :> a b c/Sqrt[(a+b-c)(a-b+c)(-a+b+c)(a+b+c)],
	Inradius      :> Sqrt[(a+b-c)(a-b+c)(-a+b+c)/(a+b+c)]/2,
	Semiperimeter :> (a+b+c)/2,
	SA            :> (-a^2+b^2+c^2)/2,
	SB            :> ( a^2-b^2+c^2)/2,
	SC            :> ( a^2+b^2-c^2)/2,
	SW            :> (a^2+b^2+c^2)/2,
	S             :> Sqrt[(a+b-c)(a-b+c)(-a+b+c)(a+b+c)]/2,
	sa            :> (b+c-a)/2,
	sb            :> (c+a-b)/2,
	sc            :> (a+b-c)/2,
	s             :> (a+b+c)/2,
	OG            :> Sqrt[9Circumradius^2 - (a^2 + b^2 + c^2)]/3,
	OH            :> Sqrt[9Circumradius^2 - (a^2 + b^2 + c^2)]
}

Triangle[a_,b_,c_]:=
  Triangle[{{0,0},{c,0},{(-a^2 + b^2 + c^2)/(2*c), (1/2)*Sqrt[-(((a - b - c)*(a + b - c)*(a - b + c)*(a + b + c))/c^2)]}}]

TriangleQ[]:=TriangleQ[{a,b,c}]&&A+B+C==Pi&&0<A<Pi&&0<B<Pi&&0<C<Pi
TriangleQ[Triangle[v_]]:=TriangleQ[SideLengths[v]]
TriangleQ[s_List?VectorQ]:=And@@Thread[s>0]&&And@@(#1+#2>#3&@@@Partition[s,3,1,1]) /; Length[s]==3

Triangulate[t0_List]:=Module[
	{i,max=Max[t0],l,t,v,share1st,tri,trilist={}},
	l=Union[Table[{i,i+1},{i,max-1}],{{1,max}}];
	v=Sort[Join[t0,t0,l]];
	While[v!={},
(*	Print[v]; *)
	share1st=Select[v,#!=v[[1]] && MemberQ[#,v[[1,1]]]&][[1]];
(*	Print[share1st]; *)
	tri=Union[{v[[1]]},{share1st},
		{Complement[Union[v[[1]],share1st],Intersection[v[[1]],share1st]]}];
(*	Print[tri]; *)
	AppendTo[trilist,Union[Flatten[tri]]];
	v=Part[v,Complement[Range[Length[v]],
		Flatten[Table[Position[v,tri[[i]]][[1]],{i,3}]]]]
	];
	trilist
]

TriangulationTriangles[t_Triangle,pt_Point]:=
  Triangle[FlattenAt[Coordinates/@{#,pt},1]]&/@Sides[t]

TriangulationTriangles[t_Triangle,tri_List?VectorQ]:=
	TriangulationTriangles[t,Point[TrilinearToCartesian[t,tri]]] /; Length[tri]==3

TriangulationTriangles[t_Triangle,ctr_]:=TriangulationTriangles[t,ctr[t]]

(* Trilinear Center *)

TrilinearCenter[{b1t_,b2t_, b3t_},Triangle[{{p1t_,p2t_,p3t_},{q1t_,q2t_,q3t_},{r1t_,r2t_,r3t_}}]]:=
	Module[{b1,b2,b3,p1,p2,p3,q1,q2,q3,r1,r2,r3},
		{{b1,b2,b3},{p1,p2,p3},{q1,q2,q3},{r1,r2,r3}}=({a,b,c}#&)/@{{b1t,b2t,b3t},{p1t,p2t,p3t},{q1t,q2t,q3t},{r1t,r2t,r3t}};
		BarycentricCenter[{b1,b2,b3},Triangle[{{p1,p2,p3},{q1,q2,q3},{r1,r2,r3}}]]/{a,b,c}
	]

BarycentricCenter[{b1_,b2_,b3_},Triangle[{{p1_,p2_,p3_},{q1_,q2_,q3_},{r1_,r2_,r3_}}]]:=
  Module[{siderules},
    siderules={
		a->Sqrt[(p1+p2+p3)^2*(((-q2-q3)*r1+q1*(r2+r3))^2* SA+((-q1-q3)*r2+q2*(r1+r3))^2*SB+(q3*(r1+r2)-(q1+q2)*r3)^2*SC)],
		b->Sqrt[(q1+q2+q3)^2*(((p2+p3)*r1-p1*(r2+r3))^2*SA+((p1+p3)*r2-p2*(r1+r3))^2*SB+((-p3)*(r1+r2)+(p1+p2)*r3)^2*SC)],
		c->Sqrt[(r1+r2+r3)^2*(((-p2-p3)*q1+p1*(q2+q3))^2* SA+((-p1-p3)*q2+p2*(q1+q3))^2*SB+(p3*(q1+q2)-(p1+p2)*q3)^2*SC)]
	};
	{{p1,q1,r1},{p2,q2,r2},{p3,q3,r3}}.{
	(ToSidelengths[b1]/.siderules)/(p1+p2+p3),
	(ToSidelengths[b2]/.siderules)/(q1+q2+q3),
	(ToSidelengths[b3]/.siderules)/(r1+r2+r3)}
]

TrilinearCurve[t_Triangle,eqn0_,opts___?OptionQ]:=Module[
	{
	xy=Thread[{x,y}==TrilinearToCartesian[t,{\[Alpha],\[Beta],\[Gamma]}]],
	eqn=ToSidelengths[eqn0]/.TriangleRules/.Thread[{a,b,c}->SideLengths[Evaluate[t]]],
 	impliciteqn
	},
	impliciteqn=Eliminate[Rationalize[And@@xy&&eqn==0,0],{\[Alpha],\[Beta],\[Gamma]}];
    ImplicitPlot[impliciteqn,{x,-20,20},opts,PlotPoints->100,DisplayFunction->Identity][[1]]
]

(** begin trilinear equations **)
(* circle *)

TrilinearEquation[p__List]:=
	Det[{{c,a,b}.Times@@@Partition[#,2,1,1],Sequence@@#}&/@{ExactTrilinears[{\[Alpha],\[Beta],\[Gamma]}],
		Sequence@@(ExactTrilinears/@{p})}]/;Dimensions[{p}]=={3,3}

TrilinearEquation[circ_]:=
	TrilinearEquation[{CyclicTrilinears[CircleFunction[circ]]}] /; MemberQ[CentralCircles,circ]

TrilinearEquation[Circle[tri_List?VectorQ,r_]]:=TrilinearEquation[tri,r] /; Length[tri]==3

TrilinearEquation[ctr_List?VectorQ]:=TrilinearEquation[Trilinears/@ctr] /;
	Length[ctr]==3&&And@@(MemberQ[Centers,#]&/@ctr)

TrilinearEquation[Circle[ctr_List?VectorQ,r_]]:=Module[{alpha,beta,gamma},
	{alpha,beta,gamma}=ExactTrilinears[ctr];
	\[Alpha]^2*(-beta^2-gamma^2-2*beta*gamma*Cos[A]+r^2*Sin[A]^2)+
	\[Beta]^2 *(-alpha^2-gamma^2-2*alpha*gamma*Cos[B]+r^2*Sin[B]^2)+
    \[Gamma]^2*(-alpha^2-beta^2-2*alpha*beta*Cos[C]+r^2*Sin[C]^2)+
    2*\[Alpha]*\[Beta] *(alpha*beta +alpha*gamma*Cos[A]+beta*gamma*Cos[B]-gamma^2*Cos[C]+r^2*Sin[A]*Sin[B])+
    2*\[Alpha]*\[Gamma]*(alpha*gamma+alpha*beta*Cos[A]-beta^2*Cos[B]+beta*gamma*Cos[C]+r^2*Sin[A]*Sin[C])+
    2*\[Beta] *\[Gamma]*(beta *gamma-alpha^2*Cos[A]+alpha*beta*Cos[B]+alpha*gamma*Cos[C]+r^2*Sin[B]*Sin[C])
] /; Length[ctr]==3

TrilinearEquation[ctr_,r_]:=TrilinearEquation[Trilinears[ctr],r]

TrilinearEquation[{l_List?VectorQ}]:=TrilinearEquation[{l,1}] /; Length[l]==3

TrilinearEquation[{l_List?VectorQ,k_}]:=
	{\[Alpha],\[Beta],\[Gamma]}.l*
	{\[Alpha],\[Beta],\[Gamma]}.{a,b,c}+
	k(a \[Beta] \[Gamma]+b \[Gamma] \[Alpha]+c \[Alpha] \[Beta]) /; Length[l]==3

(* conic *)

TrilinearEquation[Circumconic[{x_,y_,z_}]]:=x/\[Alpha] + y/\[Beta] + z/\[Gamma]

TrilinearEquation[Inconic[{x_,y_,z_}]]:=x^2 \[Alpha]^2+y^2\[Beta]^2+
  z^2\[Gamma]^2-2y z \[Beta] \[Gamma]-2z x \[Gamma] \[Alpha]-2x y \[Alpha] \[Beta]

TrilinearEquation[ConicParameters[l_List]]:=
	{\[Alpha]^2,\[Beta]^2,\[Gamma]^2,\[Beta] \[Gamma],\[Alpha] \[Gamma],\[Alpha] \[Beta]}.l

(*
TrilinearEquation[inconic_]:=Module[{x,y,z},
	{x,y,z}=InconicParameters[inconic];
	x^2 \[Alpha]^2+y^2\[Beta]^2+z^2\[Gamma]^2-2y z \[Beta] \[Gamma]-2z x \[Gamma] \[Alpha]-2x y \[Alpha] \[Beta]
] /; MemberQ[Inconics,inconic]

TrilinearEquation[circumconic_]:=Module[{l=CircumconicParameters[circumconic]},
	{\[Alpha]^2,\[Beta]^2,\[Gamma]^2,\[Beta] \[Gamma],\[Alpha] \[Gamma],\[Alpha] \[Beta]}.l
] /; MemberQ[Circumconics,circumconic]
*)

(* cubics *)

TrilinearEquation[cubic_]:=Plus@@CyclicTrilinears[
	PivotalIsogonalCubicFunction[cubic] \[Alpha](\[Beta]^2-\[Gamma]^2)] /;
	MemberQ[PivotalIsogonalCubics,cubic]
TrilinearEquation[cubic_]:=Plus@@CyclicTrilinears[
	PivotalIsotomicCubicFunction[cubic] a^2 \[Alpha](b^2\[Beta]^2-c^2\[Gamma]^2)] /;
	MemberQ[PivotalIsotomicCubics,cubic]

TrilinearEquation[cubic_]:=CubicEquation[cubic] /; MemberQ[TriangleCubics,cubic]

(* line *)
(*
TrilinearEquation[m_List?MatrixQ]:=Det[Prepend[m,{\[Alpha],\[Beta],\[Gamma]}]]
*)
TrilinearEquation[line:Line[tri1_List?VectorQ,tri2_List?VectorQ]]:=
	TrilinearEquation[TrilinearLine[line]] /; (Length/@{tri1,tri2})=={3,3}
TrilinearEquation[TrilinearLine[{l_,m_,n_}]]:={\[Alpha],\[Beta],\[Gamma]}.{l,m,n}
TrilinearEquation[l_]:={\[Alpha],\[Beta],\[Gamma]}.Trilinears[l] /; MemberQ[Lines,l]
TrilinearEquation[ctr1_,ctr2_]:=TrilinerEquation[Trilinears/@{ctr1,ctr2}] /;
	MemberQ[Centers,ctr1]&&MemberQ[Centers,ctr2]

(** end trilinear equations **)

TrilinearLine[Line[tri1_List?VectorQ,tri2_List?VectorQ]]:=TrilinearLine[Cross[tri1,tri2]] /; Length/@{tri1,tri2}=={3,3}
TrilinearLine[Line[ctr_,tri_List?VectorQ]]:=TrilinearLine[Trilinears[ctr],tri] /; Length[tri]==3 && MemberQ[Centers,ctr]
TrilinearLine[Line[tri_List?VectorQ,ctr_]]:=TrilinearLine[Trilinears[ctr],tri] /; Length[tri]==3 && MemberQ[Centers,ctr]
TrilinearLine[Line[ctr1_,ctr2_]]:=TrilinearLine[Line@@(Trilinears/@{ctr1,ctr2})] /; And@@(MemberQ[Centers,#]&/@{ctr1,ctr2})
TrilinearLine[ctr_]:=TrilinearLine[Trilinears[ctr]] /; MemberQ[Centers,ctr]

TrilinearPolar[{l_,m_,n_}]:=TrilinearLine[{m n,n l,l m}]
TrilinearPolar[ctr_]:=TrilinearPolar[Trilinears[ctr]] /; MemberQ[Centers,ctr]

TrilinearPole[line_]:=TrilinearPole[TrilinearLine[line]] /; MemberQ[Lines,line]
TrilinearPole[TrilinearLine[{l_,m_,n_}]]:={m n,n l,l m}

TrilinearProduct[p_?VectorQ,u_?VectorQ]:=p u
TrilinearProduct[p_,u_?VectorQ]:=TrilinearProduct[Trilinears[p],u] /; MemberQ[Centers,p]
TrilinearProduct[p_?VectorQ,u_]:=TrilinearProduct[p,Trilinears[u]] /; MemberQ[Centers,u]
TrilinearProduct[p_,u_]:=TrilinearProduct@@Trilinears/@{p,u} /; MemberQ[Centers,p]&&MemberQ[Centers,u]

TrilinearQuotient[p_?VectorQ,u_?VectorQ]:=p/u
TrilinearQuotient[p_,u_?VectorQ]:=TrilinearQuotient[Trilinears[p],u] /; MemberQ[Centers,p]
TrilinearQuotient[p_?VectorQ,u_]:=TrilinearQuotient[p,Trilinears[u]] /; MemberQ[Centers,u]
TrilinearQuotient[p_,u_]:=TrilinearQuotient@@Trilinears/@{p,u} /; MemberQ[Centers,p]&&MemberQ[Centers,u]

Trilinears[l_]:=CyclicTrilinears[LineFunction[l]] /; MemberQ[Lines,l]
Trilinears[t_Triangle,tri_List?VectorQ]:=Trilinears[tri][t] /; Dimensions[tri]=={3}
Trilinears[t_Triangle,ctr_]:=(Trilinears[ctr] /.
	Thread[{a,b,c}->SideLengths[t]]/.Thread[{A,B,C}->Angles[t]]) /; MemberQ[Centers,ctr]
Trilinears[tri_List?VectorQ][t_Triangle]:=(tri /.
	Thread[{a,b,c}->SideLengths[t]]/.Thread[{A,B,C}->Angles[t]]) /; Dimensions[tri]=={3}
Trilinears[ctr_]:=CyclicTrilinears[CenterFunction[ctr]] /; MemberQ[Centers,ctr]

TrilinearToCartesian::orient="Warning: `1` has negative orientation.";

(* clean this up for efficiency *)
TrilinearToCartesian[t_Triangle,tri0_List]:=Module[
  {
  a,b,c,
  k,veca,vecb,vecc,
  a1,a2,a3,c1,c2,c3,
  lc,
  vert,
  tri,
  area=Area[t]
  },
  
  If[Orientation[t]==-1,
 	Message[TrilinearToCartesian::orient,t]; vert=Reverse@@t; tri=Reverse[tri0],
 	vert=Vertices[t]; tri=tri0,
 	vert=Vertices[t]; tri=tri0
  ];
  
  a=Distance[vert[[2]],vert[[3]]];
  b=Distance[vert[[3]],vert[[1]]];
  c=Distance[vert[[1]],vert[[2]]];
  
  vecc=(vert[[2]]-vert[[1]])/c;
  vecb=(vert[[1]]-vert[[3]])/b;
  veca=(vert[[3]]-vert[[2]])/a;

  c1=vecc[[1]]; c2=vecc[[2]];
  (*
  b1=vecb[[1]]; b2=vecb[[2]];
  *)
  a1=veca[[1]]; a2=veca[[2]];
  
  k=-2 area/(a tri[[1]]+b tri[[2]]+c tri[[3]]);
   
  (*
  la=(-k tri[[1]](a1 c1+a2 c2)+
    k tri[[3]](c1^2+c2^2)+
    c2(vert[[1,1]]-vert[[2,1]])+c1(vert[[2,2]]-vert[[1,2]]))/(a1 c2-a2 c1);
  *)
   
  lc=(-k tri[[1]](a1^2+a2^2)+
    k tri[[3]](a1 c1+a2 c2)+
    a2(vert[[1,1]]-vert[[2,1]])+a1(vert[[2,2]]-vert[[1,2]]))/(a1 c2-a2 c1);
      
  vert[[1]]+lc vecc+k tri[[3]] {c2,-c1} 
]

Name[TuckerBrocardCubic]:="Tucker-Brocard cubic"
CubicEquation[TuckerBrocardCubic]:= a b c CyclicSum[a \[Alpha](b^2 \[Beta]^2+c^2\[Gamma]^2)]-
  \[Alpha] \[Beta] \[Gamma] CyclicSum[a^2(b^4+c^4)]

TuckerCircle[phi_]:=
  Circle[CyclicTrilinears[Cos[A-phi]],
    Circumradius Sin[BrocardAngle]/Sin[BrocardAngle+phi]]

Name[TuckerCubic]:="Tucker cubic"
CubicEquation[TuckerCubic]:=Sec[A]Sec[B]Sec[C] CyclicSum[a \[Alpha](b^2 \[Beta]^2+c^2\[Gamma]^2)]-
  \[Alpha] \[Beta] \[Gamma] CyclicSum[a Sec[A](b^2 Sec[B]^2+c^2 Sec[C]^2)]

Unit[{0,0}]:={0,0}
Unit[v_List?VectorQ]:=v/Sqrt[v.v]

UnaryCofactorTriangle[Triangle[{{x1_,y1_,z1_},{x2_,y2_,z2_},{x3_,y3_,z3_}}]]:=
  Triangle[MapIndexed[RotateRight[#1,#2[[1]]-1]&,
      CyclicTrilinears[{y2 z3-z2 y3,z2 x3-x2 z3,x2 y3-y2 x3}]]]

UnaryCofactorTriangle[t_]:=UnaryCofactorTriangle[Triangle[t]] /; MemberQ[Triangles,t]

unitVector[{0,0}]:={0,0}
unitVector[v_List?VectorQ]:=v/Sqrt[v.v]
unitVector[v1_List?VectorQ,v2_List?VectorQ]:=unitVector[v2-v1]

Name[VanAubelLine]:="van Aubel line"
LineFunction[VanAubelLine]:=Cos[A](Sin[2B]-Sin[2C])
CenterLine[X[520]]:=VanAubelLine

Name[VanLamoenCircle]:="van Lamoen circle"
CircleFunction[VanLamoenCircle]:=-((1/(108a^2b^3c^3))((a^2-2b^2-2c^2)*
	(8a^4-20a^2b^2+8b^4-20a^2c^2-11b^2c^2+8c^4)*Circumradius^2))
CircleCenterFunction[VanLamoenCircle]:=(10*a^4-13*a^2*b^2+4*b^4-13*a^2*c^2-10*b^2*c^2+4*c^4)/a
CircleRadius[VanLamoenCircle]:=(1/(18*a^2*b^2*c^2))*(Sqrt[(a^2-2*b^2-2*c^2)*(2*a^2+2*b^2-c^2)*(2*a^2-b^2+2*c^2)*(2*a^4-5*a^2*b^2+2*b^4-5*a^2*c^2-5*b^2*c^2+2*c^4)]*Circumradius^2)

(* Chop[] 
needed to avoid ArcTan@@{0.7966106687959811`,-2.7755575615628914`*^-17}
which gives a small negative part x and hence Mod[x,2Pi] is 2Pi-x instead of 0
*)

VertexArc[l_List,r_:.08]:=Module[
    {sides={{l[[1]],l[[2]]},{l[[3]],l[[2]]}},angs},
	angs=Sort[ArcTan@@@(Chop[Subtract@@@sides]),Less];
	angs=If[-Subtract@@angs<Pi,angs,Reverse[angs+{2Pi,0}]];
    Circle[l[[2]],r,angs]
]

VertexArcs[t_Triangle,r_:.08]:=VertexArc[#,r]&/@NestList[RotateLeft,Vertices@t,2]

VertexPoints[p:(_Triangle|_Quadrilateral|_Polygon)]:=Point/@Vertices[p]

Name[WeillPoint]:="Weill point"
CenterFunction[WeillPoint]:=(b-c)^2-a(b+c)

CenterFunction[YffCenter]:=Sec[A/2]
Name[YffCenter]:="Yff center of congruence"

YffCenterLengths[tri_List]:=Module[
	{
	s=SideLengths[tri],
	l1,l2,l3,t1,t2,t3,s1,s2,s3,
	soln,isos
	},
	{s1,s2,s3}=s;
	{{l1,l2,l3},{t1,t2,t3}} /.
		FindRoot[{
		l2+l3-t1==s1,
		l1+l3-t2==s2,
		l1+l2-t3==s3,
		((t2+t3)/l1)^2==2(1-(s2^2+s3^2-s1^2)/(2s2 s3)),
		((t1+t3)/l2)^2==2(1-(s1^2+s3^2-s2^2)/(2s1 s3)),
		((t1+t2)/l3)^2==2(1-(s1^2+s2^2-s3^2)/(2s1 s2))
		},
		{t1,.1},{t2,.1},{t3,.1},{l1,.5},{l2,.5},{l3,.5}
	]
]

Name[YffCentralTriangle]:="Yff central triangle"
TrilinearVertexMatrix[YffCentralTriangle]:=
  With[{x=Cos[#1/2],y=Cos[#2/2],z=Cos[#3/2]},
    MapIndexed[
      RotateRight[#1,#2-1]&,{y z,z(x+z),y(x+y)}&@@@
        NestList[RotateLeft,{A,B,C},2]]]

YffCentralTriangleLengths[tri_List]:=Module[
	{
	s=SideLengths[tri],
	l1,l2,l3,t1,t2,t3,s1,s2,s3,
	soln,isos
	},
	{s1,s2,s3}=s;
	{{l1,l2,l3},{t1,t2,t3}} /.
		FindRoot[
		{
		l2+l3-t1==s1,
		l1+l3-t2==s2,
		l1+l2-t3==s3,
		((t1+t2+t3)/l1)^2==2(1-(s2^2+s3^2-s1^2)/(2s2 s3)),
		((t1+t2+t3)/l2)^2==2(1-(s1^2+s3^2-s2^2)/(2s1 s3)),
		((t1+t2+t3)/l3)^2==2(1-(s1^2+s2^2-s3^2)/(2s1 s2))
		},
		{t1,.1},{t2,.1},{t3,.1},{l1,.5},{l2,.5},{l3,.5}
	]
]

CircleTripletFunction[YffCircles[1]]:={
{-(a^4 - 2*a^2*b^2 + b^4 - 2*a^2*b*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/(2*a^2*b*c),1,1},
Inradius Circumradius/(Circumradius+Inradius)}

CircleTripletFunction[YffCircles[2]]:={
{(a^4 - 2*a^2*b^2 + b^4 + 2*a^2*b*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/(2*a^2*b*c),1,1},
Inradius Circumradius/(Circumradius-Inradius)}

Name[YffCirclesTriangle[1]]:="first Yff circles triangle"
TrilinearVertexMatrix[YffCirclesTriangle[1]]:=
{{-(a^4 - 2*a^2*b^2 + b^4 - 2*a^2*b*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/(2*a^2*b*c), 1, 
  1}, {1, -(a^4 - 2*a^2*b^2 + b^4 - 2*a*b^2*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/
   (2*a*b^2*c), 1}, {1, 1, -(a^4 - 2*a^2*b^2 + b^4 - 2*a^2*c^2 - 2*a*b*c^2 - 
     2*b^2*c^2 + c^4)/(2*a*b*c^2)}}

Name[YffCirclesTriangle[2]]:="second Yff circles triangle"
TrilinearVertexMatrix[YffCirclesTriangle[2]]:=
{{(a^4 - 2*a^2*b^2 + b^4 + 2*a^2*b*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/(2*a^2*b*c), 1, 
  1}, {1, (a^4 - 2*a^2*b^2 + b^4 + 2*a*b^2*c - 2*a^2*c^2 - 2*b^2*c^2 + c^4)/
   (2*a*b^2*c), 1}, {1, 1, (a^4 - 2*a^2*b^2 + b^4 - 2*a^2*c^2 + 2*a*b*c^2 - 
    2*b^2*c^2 + c^4)/(2*a*b*c^2)}}

Name[YffContactCircle]:="Yff contact circle"
CircleCenterFunction[YffContactCircle]:=(b - c) (3 a^3 + b^3 + c^3 - 2 a^2 b - 2 a^2 c - a b c)/a
CircleFunction[YffContactCircle]:=-(a^4 - a^3 b + a b^3 - b^4 - a^3 c + a^2 b c - a b^2 c +
b^3 c - a b c^2 + a c^3 + b c^3 - c^4)/(2 (a - b) (a - c)b c)
CircleRadius[YffContactCircle]:=Sqrt[((a^3 + b^3 - 2*a^2*c + a*b*c - 2*b^2*c + c^3)*(a^3 - 2*a*b^2 + b^3 + a*b*c - 
   2*a*c^2 + c^3)*(a^3 - 2*a^2*b + b^3 + a*b*c - 2*b*c^2 + c^3))/(a + b + c)]/Abs[(a-b)(b-c)(c-a)]/2

Name[YffContactTriangle]:="Yff contact triangle"
TrilinearVertexMatrix[YffContactTriangle]:=
	{{0, (a*c)/(-a + c), (a*b)/(a - b)},
	{(b*c)/(b - c), 0, (a*b)/(a - b)}, 
	{(b*c)/(b - c), (a*c)/(-a + c), 0}}

Name[YffHyperbola]:="Yff hyperbola"
ConicEquation[YffHyperbola]:=
a^10*\[Alpha]^2 - 2*a^8*b^2*\[Alpha]^2 + a^6*b^4*\[Alpha]^2 - 2*a^8*c^2*\[Alpha]^2 + 3*a^6*b^2*c^2*\[Alpha]^2 - a^4*b^4*c^2*\[Alpha]^2 + a^6*c^4*\[Alpha]^2 - 
 a^4*b^2*c^4*\[Alpha]^2 + 2*a^7*b^3*\[Alpha]*\[Beta] - 4*a^5*b^5*\[Alpha]*\[Beta] + 2*a^3*b^7*\[Alpha]*\[Beta] - a^7*b*c^2*\[Alpha]*\[Beta] + a^5*b^3*c^2*\[Alpha]*\[Beta] + 
 a^3*b^5*c^2*\[Alpha]*\[Beta] - a*b^7*c^2*\[Alpha]*\[Beta] + a^5*b*c^4*\[Alpha]*\[Beta] - 3*a^3*b^3*c^4*\[Alpha]*\[Beta] + a*b^5*c^4*\[Alpha]*\[Beta] + a^3*b*c^6*\[Alpha]*\[Beta] + 
 a*b^3*c^6*\[Alpha]*\[Beta] - a*b*c^8*\[Alpha]*\[Beta] + a^4*b^6*\[Beta]^2 - 2*a^2*b^8*\[Beta]^2 + b^10*\[Beta]^2 - a^4*b^4*c^2*\[Beta]^2 + 3*a^2*b^6*c^2*\[Beta]^2 - 
 2*b^8*c^2*\[Beta]^2 - a^2*b^4*c^4*\[Beta]^2 + b^6*c^4*\[Beta]^2 - a^7*b^2*c*\[Alpha]*\[Gamma] + a^5*b^4*c*\[Alpha]*\[Gamma] + a^3*b^6*c*\[Alpha]*\[Gamma] - a*b^8*c*\[Alpha]*\[Gamma] + 
 2*a^7*c^3*\[Alpha]*\[Gamma] + a^5*b^2*c^3*\[Alpha]*\[Gamma] - 3*a^3*b^4*c^3*\[Alpha]*\[Gamma] + a*b^6*c^3*\[Alpha]*\[Gamma] - 4*a^5*c^5*\[Alpha]*\[Gamma] + a^3*b^2*c^5*\[Alpha]*\[Gamma] + 
 a*b^4*c^5*\[Alpha]*\[Gamma] + 2*a^3*c^7*\[Alpha]*\[Gamma] - a*b^2*c^7*\[Alpha]*\[Gamma] - a^8*b*c*\[Beta]*\[Gamma] + a^6*b^3*c*\[Beta]*\[Gamma] + a^4*b^5*c*\[Beta]*\[Gamma] - a^2*b^7*c*\[Beta]*\[Gamma] + 
 a^6*b*c^3*\[Beta]*\[Gamma] - 3*a^4*b^3*c^3*\[Beta]*\[Gamma] + a^2*b^5*c^3*\[Beta]*\[Gamma] + 2*b^7*c^3*\[Beta]*\[Gamma] + a^4*b*c^5*\[Beta]*\[Gamma] + a^2*b^3*c^5*\[Beta]*\[Gamma] - 
 4*b^5*c^5*\[Beta]*\[Gamma] - a^2*b*c^7*\[Beta]*\[Gamma] + 2*b^3*c^7*\[Beta]*\[Gamma] - a^4*b^2*c^4*\[Gamma]^2 - a^2*b^4*c^4*\[Gamma]^2 + a^4*c^6*\[Gamma]^2 + 3*a^2*b^2*c^6*\[Gamma]^2 + 
 b^4*c^6*\[Gamma]^2 - 2*a^2*c^8*\[Gamma]^2 - 2*b^2*c^8*\[Gamma]^2 + c^10*\[Gamma]^2

Name[YffParabola]:="Yff parabola"
InconicParameters[YffParabola]:={a(b-c),b(c-a),c(a-b)}

(*
Root[-(a*b*c) + a*b*#1 + a*c*#1 + b*c*#1 - a*#1^2 - b*#1^2 - c*#1^2 + 2*#1^3 &, 1] 
*)
YffU=Module[
	{pp = a + b + c,qq = a b + b c + c a,rr = a b c,W,Q,V},
	W=Sqrt[27 (8 qq^3 + 4 pp^3 rr - 36 pp qq rr + 108 rr^2 - pp^2 qq^2)];
	Q=pp^3 - 9 pp qq + 54 rr;
	V=(W + Q)^(1/3);
	pp/6 - (6 qq - pp^2)/(6 V) + V/6
];

CenterFunction[YffPoint[1]]:=Module[{u=YffU},
	((c - u)/(b - u))^(1/3)/a
]

CenterFunction[YffPoint[2]]:=Module[{u=YffU},
	((b - u)/(c - u))^(1/3)/a
]

Name[YffTriangle[1]]:="first Yff triangle"
TrilinearVertexMatrix[YffTriangle[1]]:=Module[{u=YffU},
	{{0, ((a - u)/(c - u))^(1/3)/b, ((b - u)/(a - u))^(1/3)/c},
	{((c - u)/(b - u))^(1/3)/a, 0, ((b - u)/(a - u))^(1/3)/c},
	{((c - u)/(b - u))^(1/3)/a, ((a - u)/(c - u))^(1/3)/b, 0}}
]
  
Name[YffTriangle[2]]:="second Yff triangle"
TrilinearVertexMatrix[YffTriangle[2]]:=Module[{u=YffU},
	{{0, ((c - u)/(a - u))^(1/3)/b, ((a - u)/(b - u))^(1/3)/c},
	{((b - u)/(c - u))^(1/3)/a, 0, ((a - u)/(b - u))^(1/3)/c},
	{((b - u)/(c - u))^(1/3)/a, ((c - u)/(a - u))^(1/3)/b, 0}}
]

Name[YiuCircle]:="Yiu circle"
CircleCenterFunction[YiuCircle]:=-(a*(a^14 - 5*a^12*b^2 + 10*a^10*b^4 - 10*a^8*b^6 + 5*a^6*b^8 - a^4*b^10 - 
   5*a^12*c^2 + 14*a^10*b^2*c^2 - 13*a^8*b^4*c^2 + 4*a^6*b^6*c^2 + a^4*b^8*c^2 - 
   2*a^2*b^10*c^2 + b^12*c^2 + 10*a^10*c^4 - 13*a^8*b^2*c^4 + 3*a^6*b^4*c^4 + 
   3*a^2*b^8*c^4 - 3*b^10*c^4 - 10*a^8*c^6 + 4*a^6*b^2*c^6 - 2*a^2*b^6*c^6 + 
   2*b^8*c^6 + 5*a^6*c^8 + a^4*b^2*c^8 + 3*a^2*b^4*c^8 + 2*b^6*c^8 - a^4*c^10 - 
   2*a^2*b^2*c^10 - 3*b^4*c^10 + b^2*c^12))
CircleFunction[YiuCircle]:=-((a^8*b^6 - 4*a^6*b^8 + 6*a^4*b^10 - 4*a^2*b^12 + b^14 - a^10*b^2*c^2 + 
   2*a^8*b^4*c^2 - 7*a^4*b^8*c^2 + 11*a^2*b^10*c^2 - 5*b^12*c^2 + 2*a^8*b^2*c^4 - 
   a^6*b^4*c^4 + a^4*b^6*c^4 - 8*a^2*b^8*c^4 + 9*b^10*c^4 + a^8*c^6 + 
   a^4*b^4*c^6 + 2*a^2*b^6*c^6 - 5*b^8*c^6 - 4*a^6*c^8 - 7*a^4*b^2*c^8 - 
   8*a^2*b^4*c^8 - 5*b^6*c^8 + 6*a^4*c^10 + 11*a^2*b^2*c^10 + 9*b^4*c^10 - 
   4*a^2*c^12 - 5*b^2*c^12 + c^14)/(a^4*b^3*(-a + b - c)*(a + b - c)*c^3*
   (-a + b + c)*(a + b + c)*(-1 + 2*Cos[A])*(1 + 2*Cos[A])*(-1 + 2*Cos[B])*
   (1 + 2*Cos[B])*(-1 + 2*Cos[C])*(1 + 2*Cos[C])))
CircleRadius[YiuCircle]:=
Sqrt[a^12 - 4*a^10*b^2 + 7*a^8*b^4 - 8*a^6*b^6 + 7*a^4*b^8 - 4*a^2*b^10 + b^12 - 4*a^10*c^2 + 8*a^8*b^2*c^2 - 
    4*a^6*b^4*c^2 - 4*a^4*b^6*c^2 + 8*a^2*b^8*c^2 - 4*b^10*c^2 + 7*a^8*c^4 - 4*a^6*b^2*c^4 + 3*a^4*b^4*c^4 - 
    4*a^2*b^6*c^4 + 7*b^8*c^4 - 8*a^6*c^6 - 4*a^4*b^2*c^6 - 4*a^2*b^4*c^6 - 8*b^6*c^6 + 7*a^4*c^8 + 8*a^2*b^2*c^8 + 
    7*b^4*c^8 - 4*a^2*c^10 - 4*b^2*c^10 + c^12]*Circumradius/
 (a^2*b^2*c^2*Abs[(-1 + 4*Cos[A]^2)*(-1 + 4*Cos[B]^2)*(-1 + 4*Cos[C]^2)])

CircleTripletFunction[YiuCircles]:={
	{
	-((a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 4*a^6*c^2 + 5*a^4*b^2*c^2 + a^2*b^4*c^2 - 2*b^6*c^2 + 6*a^4*c^4 + a^2*b^2*c^4 + 2*b^4*c^4 - 4*a^2*c^6 - 2*b^2*c^6 + c^8)),
	2*a^2*b^3*c^3*Cos[A - C],
	2*a^2*b^3*c^3*Cos[A - B]
	},
	Sqrt[a^6 - 3*a^4*b^2 + 3*a^2*b^4 - b^6 - 3*a^4*c^2 + 3*a^2*b^2*c^2 + b^4*c^2 + 3*a^2*c^4 + b^2*c^4 - c^6]/(4*Area*Abs[1 + 2*Cos[2*A]])
}

Name[YiuTriangle]:="Yiu triangle"
TrilinearVertexMatrix[YiuTriangle]:=
{{-((a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 4*a^6*c^2 + 5*a^4*b^2*c^2 + 
     a^2*b^4*c^2 - 2*b^6*c^2 + 6*a^4*c^4 + a^2*b^2*c^4 + 2*b^4*c^4 - 4*a^2*c^6 - 
     2*b^2*c^6 + c^8)*(-1 + 2*Cos[A])*(1 + 2*Cos[A])), 2*a^2*b^3*c^3*(-1 + 2*Cos[A])*
   (1 + 2*Cos[A])*Cos[A - C], 2*a^2*b^3*c^3*(-1 + 2*Cos[A])*(1 + 2*Cos[A])*Cos[A - B]}, 
 {2*a^3*b^2*c^3*(-1 + 2*Cos[B])*(1 + 2*Cos[B])*Cos[B - C], 
  -((a^8 - 4*a^6*b^2 + 6*a^4*b^4 - 4*a^2*b^6 + b^8 - 2*a^6*c^2 + a^4*b^2*c^2 + 
     5*a^2*b^4*c^2 - 4*b^6*c^2 + 2*a^4*c^4 + a^2*b^2*c^4 + 6*b^4*c^4 - 2*a^2*c^6 - 
     4*b^2*c^6 + c^8)*(-1 + 2*Cos[B])*(1 + 2*Cos[B])), 
  2*a^3*b^2*c^3*Cos[A - B]*(-1 + 2*Cos[B])*(1 + 2*Cos[B])}, 
 {2*a^3*b^3*c^2*Cos[B - C]*(-1 + 2*Cos[C])*(1 + 2*Cos[C]), 
  2*a^3*b^3*c^2*Cos[A - C]*(-1 + 2*Cos[C])*(1 + 2*Cos[C]), 
  -((a^8 - 2*a^6*b^2 + 2*a^4*b^4 - 2*a^2*b^6 + b^8 - 4*a^6*c^2 + a^4*b^2*c^2 + 
     a^2*b^4*c^2 - 4*b^6*c^2 + 6*a^4*c^4 + 5*a^2*b^2*c^4 + 6*b^4*c^4 - 4*a^2*c^6 - 
     4*b^2*c^6 + c^8)*(-1 + 2*Cos[C])*(1 + 2*Cos[C]))}}

(*** Mathemagic symbol assignment ***)

Print["Rehashing named triangle objects..."];

(* named circles *)

CentralCircles=#[[1,1,1]]&/@DownValues[CircleCenterFunction];

CircleTriplets=#[[1,1,1]]&/@DownValues[CircleTripletFunction];
(Circles[#]:=CircleTriplet@@(CircleTripletFunction[#]))&/@CircleTriplets;

(#[t_Triangle,l_List:{1,2,3}]:=MapIndexed[Circle[
		TrilinearToCartesian[t,Center[#]],
		If[ListQ[r=CircleRadius[#]],r[[l[[#2[[1]]]]]],r]
		]&,Circles[#]]  /.
			TriangleRules/.
			Thread[{a,b,c}->SideLengths[Evaluate[t]]]/.
			Thread[{A,B,C}->Angles[t]]
	)&/@CircleTriplets;

(#[t_Triangle]:=Circle[TrilinearToCartesian[t,Center[#]],CircleRadius[#]] /.
			TriangleRules /.
			Thread[{a,b,c}->SideLengths[Evaluate[t]]]/.
			Thread[{A,B,C}->Angles[t]]
	)&/@CentralCircles;

Unprotect[Circle];
(Circle[#]:=Circle[Center[#],CircleRadius[#]])&/@CentralCircles;
Protect[Circle];

(* named cubics *)

PivotalIsogonalCubics=#[[1,1,1]]&/@DownValues[PivotalIsogonalCubicFunction];
PivotalIsotomicCubics=#[[1,1,1]]&/@DownValues[PivotalIsotomicCubicFunction];

TriangleCubics:=Sort[Join[PivotalIsogonalCubics,PivotalIsotomicCubics,
	#[[1,1,1]]&/@DownValues[CubicEquation]]]

(* named conics *)

Circumconics=#[[1,1,1]]&/@DownValues[CircumconicParameters];
Inconics=#[[1,1,1]]&/@DownValues[InconicParameters];
Conics=Union[Join[Circumconics,Inconics,#[[1,1,1]]&/@DownValues[ConicEquation]]];

(TrilinearEquation[#]:=TrilinearEquation[Inconic[InconicParameters[#]]])&/@Inconics;
(TrilinearEquation[#]:=TrilinearEquation[Circumconic[CircumconicParameters[#]]])&/@Circumconics;
(TrilinearEquation[#]:=ConicEquation[#])&/@Complement[Conics,Inconics,Circumconics];

(* named lines *)

Lines=#[[1,1,1]]&/@DownValues[LineFunction];
Unprotect[Line];
(#[t_Triangle]:=TrilinearLine[CyclicTrilinears[LineFunction[#]]][t])&/@Lines;
(TrilinearLine[#]:=TrilinearLine[CyclicTrilinears[LineFunction[#]]])&/@Lines;
Protect[Line];

(* named triangles *)

Triangles=#[[1,1,1]]&/@DownValues[TrilinearVertexMatrix];

(Triangle[#]:=Triangle[TrilinearVertexMatrix[#]])&/@Triangles;

(#[t_Triangle]:=Triangle[
	TrilinearToCartesian[t,#]&/@TrilinearVertexMatrix[#] /.
		TriangleRules/.
		Thread[{a,b,c}->SideLengths[Evaluate[t]]]/.
		Thread[{A,B,C}->Angles[t]]
	])&/@Triangles;

(* named triangle centers *)

Centers=#[[1,1,1]]&/@DownValues[CenterFunction];

(* The fact that the following is very slow is a nasty Mathematica bug/limitation 
   (#[t_Blah]:=#)&/@Array[X,1000] is slow
   (#[t_Blah]:=#)&/@Symbol["X"<>ToString[#]]&/@Range[1000] is fast
*)

(#[t_Triangle]:=Module[{},
	Point@TrilinearToCartesian[t,Trilinears[#]] /.
		TriangleRules /.
		Thread[{a,b,c}->SideLengths[Evaluate[t]]] /.
		Thread[{A,B,C}->Angles[t]]
	] /; Dimensions[t[[1]]]=={3,2})&/@Centers;

(#[t_Triangle]:=TrilinearCenter[Trilinears[#],t] /; Dimensions[t[[1]]]=={3,3})&/@Centers;
(#[t_]:=TrilinearCenter[Trilinears[#],Triangle[t]] /; MemberQ[Triangles,t])&/@Centers;

(* Graphics *)

Unprotect[Graphics];

Function[obj,Graphics[expr_?(MemberQ[#,obj[_Triangle],{0,Infinity}]&),opts___?OptionQ]:=
	Graphics[expr/.obj[t_]:>
		TrilinearCurve[t,TrilinearEquation[obj]],opts]]/@Join[Conics,TriangleCubics]

Graphics[expr_?(MemberQ[#,_Quadrilateral,{0,Infinity}]&),opts___?OptionQ]:=
	Graphics[expr /. Quadrilateral:>ClosedLine,opts]

Graphics[expr_?(MemberQ[#,_Triangle,{0,Infinity}]&),opts___?OptionQ]:=
	Graphics[expr /. Triangle:>ClosedLine,opts]

Protect[Graphics];

End[];

Protect[a,b,c,A,B,C,\[Alpha],\[Beta],\[Gamma]];

EndPackage[]