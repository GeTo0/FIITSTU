(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.27 *)

(*:Name: MathWorld`Divisors` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Divisors.m
 
*)

(*:Summary:  
*)

(*:History:
	Written March-July 1996 by Eric W. Weisstein
	
	v1.01 (2000-01-01): URL updated
	v1.02 (2000-01-23): Changed syntax of AmicablePair to AmicablePairQ.
	                    Added AmicablePairQ to work directly on 
	                    factors lists of m and n.
	v1.03 (2000-01-30): AmicableQuadrupleQ
	v1.04 (2000-02-27): AliquotSequence.  Ripped out some very old garbage code.
	                    Added mSociable stuff.
	v1.05 (2000-05-08): Added additional 4-cycles from Moews.
	v1.06 (2000-06-01): Fixed AmicablePairQ.
	v1.07 (2002-03-23): Corrupted file recovered from backup, documentation
	                    prettied up, syntax slightly modified
	v1.08 (2003-10-19): added context
	v1.09 (2003-12-06): updated to include all 120 known order-4 sociable numbers
	                    Added AliquotSequence[n] without a 2nd argument
	v1.10 (2004-02-01): UnitaryDivisorSigma, rewrote UnitaryDivisors
	v1.11 (2004-02-23): Renamed to Divisors.m and defined ListDivisorSigma[k,n]
	v1.23 (2005-02-08): Removed SumOfDivisors and related functions since they seem to be wrong
	v1.24 (2005-03-10): Fixed AmicablePairQ
	v1.25 (2005-05-20): Added AbundantQ, SemiperfectQ, WeirdQ
	v1.26 (2006-04-07): AmicablePairQ now supports Gaussian integers
	v1.27 (2006-05-22): Added C6 Needham 2006 13D and updated C4s

	(c) 1995-2007 Eric W. Weisstein
*)

(*:Keywords:
	number theory, sociable numbers, perfect numbers
*)

(*:Requirements: None. *)

(*:Discussion:
  See Weisstein.  http://mathworld.wolfram.com/DivisorFunction.html
      Mowes.      http://xraysgi.ims.uconn.edu/sociable.txt
*)

BeginPackage["MathWorld`Divisors`"]

AbundantQ::usage =
"AbundantQ[n] returns True if the some of proper divisors of n exceeds \
n itself."

AliquotSequence::usage =
"AliquotSequence[x] gives the sequence of n numbers obtained by \
applying the restricted sum of divisors function to x until \
a value is repeated.  \
AliquotSequence[x,n] gives the sequence of n numbers obtained by \
applying the restricted sum of divisors function to x.  \
AliquotSequence[x,n,m] gives the 1/m-aliquot sequence."

AmicablePairQ::usage =
"AmicablePairQ[m,n] returns True if {m,n} is an amicable pair.  \
AmicablePairQ[{{p1,a1},{p2,a1},...},{{q1,b1},{q2,b2},...}] returns true if the numbers \
m and n with given prime factorizations (which are *not* explicitly verified to be \
prime) are amicable."

AmicableQuadrupleQ::usage =
"AmicableQuadrupleQ[{a,b,c,d}] returns True if the numbers are an \
amicable quadruple."

AmicableTriple::usage =
"AmicableTriple[{l,m,n}] gives the pair sums and returns True if {l,m,n} is \
an amicable triple."

divisorSigma::usage=
"divisorSigma[k,{p1,p2,...}] uses the given prime factors.  \
divisorSigma[k,{{p1,a1},{p2,a2},...] uses the given factors and \
multiplicities."

InfinitaryDivisors::usage =
"InfinitaryDivisors[n] gives a list of the infinitary divisors of n."

ListDivisors::usage =
"ListDivisors[{{p1,a1},{p2,a2},...}] finds the divisors of the list directly \
assuming that the p_is are distinct primes."

ListDivisorSigma::usage =
"ListDivisorSigma[k,{{p1,a1},{p2,a2},...}] finds DivisorSigma[k,n] directly from the \
factors without attempting to factor the expanded expression."

RestrictedDivisorSigma::usage =
"RestrictedDivisorSigma[n] gives the restricted sum-of-divisors \
function.  The restricted sum excludes n itself."

SemiperfectQ::usage =
"SemiperfectQ[n] gives True if n is the sum of some (or all) of its \
proper divisors."

Sociable::usage =
"Sociable[n] gives a list of the smallest members of known sequences \
of order-n social numbers.  Sociable numbers are the \
generalization of perfect numbers.  Sociable[m,n] gives a list of the \
smallest members of known 1/m-sociable numbers of order n."

SociableIndices::usage =
"SociableIndices lives the list of indices for which sociable numbers are \
known."

SociableOrder::usage =
"SociableOrder[n,max] returns the order of n if it is a sociable number.  \
Otherwise it returns Infinity."

UnitaryDivisors::usage =
"UnitaryDivisors[n] gives a list of the unitary divisiors of n, i.e., those divisors \
d such that GCD(d,n/d)=1."

UnitaryDivisorSigma::usage =
"UnitaryDivisorSigma[k,n] gives the sum of kth powers of the unitary divisors of n.  \
UnitaryDivisorSigma[k,{{p1,a1},{p2,a2},...}] gives the sum of kth powers of the untary \
divisors of the number with specified factorization."

WeirdQ::usage =
"WeirdQ[n] returns True if n is abundant without being semiperfect."


Begin["`Private`"]

AbundantQ[n_Integer?Positive]:=DivisorSigma[1,n]>2n

AliquotSequence[x_]:=NestWhileList[RestrictedDivisorSigma,x,Unequal,All]

AliquotSequence[x_,n_]:=NestList[RestrictedDivisorSigma,x,n]

AliquotSequence[x_,n_,m_]:=NestList[DivisorSigma[1,#]/m&,x,n]

AmicablePairQ[a_,b_,opts___?OptionQ]:=DivisorSigma[1,a,opts]==DivisorSigma[1,b,opts]==a+b

AmicablePairQ[l1_List,l2_List]:=Equal@@(Plus@@ListDivisors[#]&/@{l1,l2})

AmicableTriple[{a_,b_,c_}]:=Module[
  {x={{RestrictedDivisorSigma[a],b+c},{RestrictedDivisorSigma[b],a+c},{
RestrictedDivisorSigma[c],a+b}},
  trip},
  trip=If[x[[1,1]]==x[[1,2]]&&x[[2,1]]==x[[2,2]]&&x[[3,1]]==x[[3,2]],True,False];
  Print[x];
  trip
]

AmicableQuadrupleQ[l_List]:=Equal[Join[{Plus@@l},DivisorSigma[1,#]&/@l]]

ExponentList[n_Integer,factors_List]:={#,IntegerExponent[n,#]}&/@factors

InfinitaryDivisors[1]:={1}
InfinitaryDivisors[n_Integer?Positive]:=Module[
	{
	factors=First/@FactorInteger[n],
	d=Divisors[n]
	},
    d[[Flatten[Position[
        Transpose[
          Thread[Function[{f,g},BitOr[f,g]==g][#,Last[#]]]&/@
            Transpose[Last/@ExponentList[#,factors]&/@d]],_?(And@@#&),{1}]]
    ]]
]

ListDivisors[l_List?(Depth[#]==3&)]:=Sort[Flatten[Apply[Outer[Times, ##]&,
	Apply[#1^Range[0, #2]&, l, {1}]]]]

ListDivisorSigma[k_,l_List?MatrixQ]:=Times@@((#1^((#2+1)k)-1)/(#1^k-1)&@@@l)

RestrictedDivisorSigma[x_,opts___?OptionQ]:=DivisorSigma[1,x,opts]-x

RunLengthEncode[x_List]:=(Through[{First,Length}[#1]]&)/@Split[x]

SemiperfectQ[n_Integer?Positive]:=Module[{d=Most[Divisors[n]]},
    n==Plus@@#&/@(Or@@Rest[Subsets[d]])
]

SigmaFactored[list_List]:=Module[{a,p,i,prod=1},
  Do[
    p=SigmaTerm[list[[i]]];
    a=SigmaPower[list[[i]]];
    prod*=(p^(a+1)-1)/(p-1),
  {i,Length[list]}
  ];
  prod
]

SigmaTerm[term_List]:=term[[1]]
SigmaTerm[term_Integer]:=term
SigmaPower[term_List]:=term[[2]]
SigmaPower[term_Integer]:=1

SociableIndices:=
	Select[(#[[1]]/.Sociable[n_]:>n/.HoldPattern:>Identity&/@DownValues[Sociable]),IntegerQ]

SociableOrder[n_,max_:30]:=Module[
	{l=NestWhileList[RestrictedDivisorSigma,n,#!=n&,{2,1},max,-1]},
	If[Length[l]<max,Length[l],Infinity]
]

(* lists *)

Sociable[4]:=
{1264460, 2115324, 2784580, 4938136, 7169104, 18048976, 18656380, 28158165, \
46722700, 81128632, 174277820, 209524210, 330003580, 498215416, 1236402232, \
1799281330, 2387776550, 2717495235, 2879697304, 3705771825, 4424606020, \
4823923384, 5373457070, 8653956136, 15837081520, 17616303220, 21669628904, \
44379752648, 73636082872, 88585861815, 90568599176, 91411869465, \
111375706442, 518833084192, 661126361272, 741158497112, 1045805730255, \
1092162882824, 1138168194296, 1420500714850, 1933600909864, 4553100850815, \
39436853599990, 65747483238255, 92180272746590, 96642590616495, \
209709847893070, 223599822374385, 430324482433184, 535975018716375, \
1107681705347175, 1210691484867410, 1356505589071269, 1458738592308855, \
1710359040970125, 1755676229313195, 1820741168916950, 12150997136979896, \
37156338834393735, 52823029397187465, 79298571803687288, 79418066525588150, \
82961403658006995, 114588454336625295, 249189504986549655, \
1495588007152308375, 4955998163344503165, 6902169681516648370, \
6988288094023398525, 13958491272110818875, 27079421841380998089, \
34974511550868795230, 58463193565500538425, 129174865655679221301, \
149576079462330292850, 994150441555885882125, 1216327163895122388615, \
1273465975511396463764, 1760276329085877273472, 3172146245376008177277, \
3967259056160548045504, 6376068162693842700555, 12015582455500352695694, \
21110038786148899493907, 97438042959521002441065, 100805144361379855289068, \
117701642653548795575955, 127735111770308496156105, 169874479526337800201824, \
232964936043894604049824, 321234588076603157961808, 455449879323655623656384, \
1428079656460304185809170, 2176327913984093483654625, \
6233962777712827671818205, 7731456891618894366037365, \
9968058569577703135948875, 12688783403597870254995855, \
18861886276604139155063175, 22483058375008335490870275, \
37819374184791154542363777, 268738565378449889248099035, \
464360514928943259297173139, 749097220032020898810221835, \
1711297340943786116109511448, 2346727862974452098740419375, \
2869143276489624384814244672, 65545181656114464662087235250, \
475070174388961596043520880915, 636499778862883888689111652156, \
2317767947240920557262327179963, 2606787865657293984410204932875, \
3173046634295897903427859297335, 3698442471517989059294076889515, \
5387361589025074234447756861275, 38610270684012998111165357181849, \
65102017285805026437223511825781, 38965204833140025019125553789263105, \
39112970754741290655955199528114079, 57203500174033092718907524800361875, \
69985120407134435488697883417157527, 171747907447957966350174765739152537, \
226060980566069181080418624779155712, 346717974663150402925726294622837319, \
2640252556204588219068323587833154695, 2686186317312072168385276277806904055, \
149426098253321819849371648905334678899, \
956721529414102602539229749574228633609, \
1381523347081447404551358629572525186935, \
36803250848591150631010789561100689169385, \
227102582644576165814138794069867493287264, \
6035224922254092641981465838954300759425475, \
391150239292252590375909613374696200110421488, \
14297285407456393433046760120968525049181470311, \
90769015419218113854283914785667327395531483090, \
181017541347134401796562505110734885245314452710, \
5538448230054607532641022881236353541103976064744284, \
62758261876984852057057483693931511681163489828154612}

Sociable[5]:={12496}

Sociable[6]:={21548919483,90632826380,1771417411016}

Sociable[8]:={1095447416,1276254780}

Sociable[9]:={805984760}

Sociable[28]:={14316}

Sociable[3,2]:={14913024}

Sociable[4,2]:={2096640,422688000}
Sociable[4,12]:={3396556800}

(* UnitaryDivisors *)

UnitaryDivisors[l_List?MatrixQ]:=Flatten[Outer[Times,Sequence@@({1,#}&/@Power@@@l)]]
UnitaryDivisors[n_Integer]:=UnitaryDivisors[FactorInteger[n]]
UnitaryDivisors[1]:={1}

(*
UnitaryDivisorSigma[0,l_List?MatrixQ]:=2^Length[l]
UnitaryDivisorSigma[0,n_Integer]:=UnitaryDivisorSigma[0,FactorInteger[n]]

UnitaryDivisorSigma[1,l_List?MatrixQ]:=Times@@(1+Power@@@l)
UnitaryDivisorSigma[1,n_Integer]:=UnitaryDivisorSigma[1,FactorInteger[n]]

UnitaryDivisorSigma[k_,x_]:=Plus@@(UnitaryDivisors[x]^k)
*)

UnitaryDivisorSigma[k_,n_Integer]:=UnitaryDivisorSigma[k,FactorInteger[n]]
UnitaryDivisorSigma[k_,l_List?MatrixQ]:=Times@@(1+(Power@@@l)^k)
UnitaryDivisorSigma[k_,1]:=1

WeirdQ[n_Integer?Positive]:=DivisorSigma[1,n]>2n&&
	n!=Plus@@#&/@(And@@Rest[Subsets[Most[Divisors[n]]]])

End[]

(* Protect[ Sigma, Sociable ] *)

EndPackage[]