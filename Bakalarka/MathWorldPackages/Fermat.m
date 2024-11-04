(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.54 *)

(*:Name: MathWorld`Fermat` *)

(*:Author: Eric Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/Fermat.m
*)

(*:Summary:
  This package generates Fermat numbers and contains factorization information
  for them.
*)

(*:History:
  v1.00 (1997-04-20): Written by Eric W. Weisstein
  v1.50 (1998-05-06): Updated factor tables using Keller's web page,
                      changed FermatFactors to be a list of {n,k}
  v1.51 (2000-01-01): Updated URL
  v1.52 (2002-02-05): Documentation updated
  v1.53 (2003-10-18): Updated context
  v1.54 (2005-09-30): FermatPrimes
   
  (c) 1997-2007 Eric W. Weisstein
*)

(*:Keywords:
	Fermat number, Fermat prime
*)

(*:Requirements: None. *)

(*:References:
  Keller, W.
    http://ballingerr.xray.ufl.edu/proths/fermat.html
  Weisstein, E.W.
    http://mathworld.wolfram.com/FermatNumber.html
*)


BeginPackage["MathWorld`Fermat`"]

Fermat::usage =
"Fermat[n] gives the nth Fermat number."

FermatFactors::usage =
"FermatFactors[n] gives a list of factors of the nth Fermat number Fermat[n] \
in the form (k 2^n)+1, written {n,k}."

FermatList::usage =
"FermatList[i,j] lists properties of known factors of F[n] for i=1 to j."

FermatPrimes::usage =
"FermatPrimes gives a list of known Fermat primes."

knFn::usage =
"knFn[n,k] gives 2^n k+1, the form a factor of a Fermat number must have."

kn::usage =
"kn[N] gives a list {k,n} such that N=2^n k+1."

knlist::usage =
"knlist[F] gives a list of the {k,n} pairs of the factors of a number F."


Begin["`Private`"]

Fermat[n_]:=2^(2^n)+1

knFn[k_,n_]:=k 2^n+1

knlist[k_]:=Table[kn[FermatFactors[k][[i]]],{i,Length[FermatFactors[k]]}]

kn[N_]:=Module[{x=N-1,n=0},
  While[IntegerQ[x/2],x/=2;n++];
  k=(N-1)/2^n;
  {k,n}
]

(* 
digits[0]:=0
digits[n_]:=Length[IntegerDigits[n]]
*)

digits[n_]:=Floor[Log[10,n]+1]

FermatList[i_,j_]:=Module[{n,f},
  Do[
    f=Times@@Apply[knFn,FermatFactors[n],1];
    If[FermatFactors[n]=={},Print[n,". No data"],
       If[f==Fermat[n],Print[n,". Factored"],
        If[IntegerQ[Fermat[n]/f],
          If[n<=20,
            Print[n,". ",Length[FermatFactors[n]],
              " factors known; C",digits[Fermat[n]/f]," remains"],
            Print[n,". ",Length[FermatFactors[n]],
              " factors known; a large C remains"]],
          Print[n,". Error"]
        ]
      ]
    ],
    {n,i,j}
  ]
]

(* Factors (k 2^n)+1 are written {n,k} *)

FermatFactors[n_Integer?Positive]:={}
FermatFactors[0]:={{1,1}}
FermatFactors[1]:={{1,2}}
FermatFactors[2]:={{1,4}}
FermatFactors[3]:={{1,8}}
FermatFactors[4]:={{1,16}}
FermatFactors[5]:={{5,7},{52347,7}}
FermatFactors[6]:={{1071,8},{262814145745,8}}
FermatFactors[7]:={{116503103764643,9},{11141971095088142685,9}}
FermatFactors[8]:={{604944512477,11},
  {45635566267264637582599393652151804972681268330878021767715,11}}
FermatFactors[9]:={{37,16}, 
{3640431067210880961102244011816628378312190597,11},
  {36212893682984902418202497163180540725583045952027296089151431452364050757065\
6742232821636569307,11}}
FermatFactors[10]:={{11131,12}, {395937,14}, 
{1137640572563481089664199400165229051,12},
  {159228362311386950350933555659802128841074866750014516829706171602578633119472\
489714526645480435919062376445225638334771522398721818601964219484396906853173\
155530512581433264809455775168889760265648430068955735004981338256435940925558\
86322403200003,13}}
FermatFactors[11]:={{39,13}, {119,13}, {10253207784531279,14}, {434673084282938711,13},
  {21174615134173285574982784529334689743337627529744150958172243537764108788193\
250592967656046192485007078101912652776662834559689734635521223667093019353364\
100169585433799507320937371688159076970887037493581569352118776521064958422163\
933812649044026502558555356775560067461648993426750049061580191794744396103493\
131476781686200989377719638682976424873973574085951980316371376859104992795318\
729984801869785145588809492038969317284320651500418425949345494944448110057412\
733268967446592534704415768023768439849177511907048426136846561848711377379319\
145718177075053,13}}
FermatFactors[12]:={{7,14},{397,16},{973,16},{11613415,14},{76668221077,14}}
FermatFactors[13]:={{41365885,16},{20323554055421,17},
  {6872386635861,19},{609485665932753836099,19}}
FermatFactors[14]:={} 
FermatFactors[15]:={{579,21},{17753925353,17},{1287603889690528658928101555,17}}
FermatFactors[16]:={{1575,19},{180227048850079840107,20}}
FermatFactors[17]:={{59251857,19}}
FermatFactors[18]:={{13,20}}
FermatFactors[19]:={{33629,21},{308385,21}}
FermatFactors[20]:={}
FermatFactors[21]:={{534689,23}}
FermatFactors[22]:={}
FermatFactors[23]:={{5,25}}
FermatFactors[24]:={}
FermatFactors[25]:={{48413,29},{1522849979,27},{16168301139,27}}
FermatFactors[26]:={{143165,29}}
FermatFactors[27]:={{141015,30},{430816215,29}}
FermatFactors[28]:={{25709319373,36}}
FermatFactors[29]:={{1120049,31}}
FermatFactors[30]:={{149041,32},{127589,33}}
FermatFactors[32]:={{1479,34}}
FermatFactors[36]:={{5,39},{3759613,38}}
FermatFactors[37]:={{1275438465,39}}
FermatFactors[38]:={{3,41},{2653,40}}
FermatFactors[39]:={{21,41}}
FermatFactors[42]:={{43485,45}}
FermatFactors[52]:={{4119,54},{21626655,54}}
FermatFactors[55]:={{29,57}}
FermatFactors[58]:={{95,61}}
FermatFactors[61]:={{54985063,66}}
FermatFactors[62]:={{697,64}}
FermatFactors[63]:={{9,67}}
FermatFactors[64]:={{17853639,67}}
FermatFactors[66]:={{7551,69}}
FermatFactors[71]:={{683,73}}
FermatFactors[72]:={{76432329,74}}
FermatFactors[73]:={{5,75}}
FermatFactors[75]:={{3447431,77}}
FermatFactors[77]:={{425,79},{5940341195,79}}
FermatFactors[81]:={{271,84}}
FermatFactors[91]:={{1421,93}}
FermatFactors[93]:={{92341,96}}
FermatFactors[99]:={{16233,104}}
FermatFactors[107]:={{1289179925,111}}
FermatFactors[117]:={{7,120}}
FermatFactors[122]:={{5234775,124}}
FermatFactors[125]:={{5,127}}
FermatFactors[142]:={{8152599,145}}
FermatFactors[144]:={{17,147}}
FermatFactors[146]:={{37092477,148}}
FermatFactors[147]:={{3125,149},{124567335,149}}
FermatFactors[150]:={{1575,157},{5439,154}}
FermatFactors[164]:={{1835601567,167}}
FermatFactors[178]:={{313047661,180}}
FermatFactors[184]:={{117012935,187}}
FermatFactors[201]:={{4845,204}}
FermatFactors[205]:={{232905,207}}
FermatFactors[207]:={{3,209}}
FermatFactors[215]:={{32111,217}}
FermatFactors[226]:={{15,229}}
FermatFactors[228]:={{29,231}}
FermatFactors[232]:={{70899775,236}}
FermatFactors[250]:={{403,252}}
FermatFactors[251]:={{85801657,254}}
FermatFactors[255]:={{629,257}}
FermatFactors[256]:={{36986355,258}}
FermatFactors[259]:={{36654265,262}}
FermatFactors[267]:={{177,271}}
FermatFactors[268]:={{21,276}}
FermatFactors[275]:={{22347,279}}
FermatFactors[284]:={{7,290}}
FermatFactors[287]:={{5915,289}}
FermatFactors[298]:={{247,302}}
FermatFactors[301]:={{7183437,304}}
FermatFactors[316]:={{7,320}}
FermatFactors[329]:={{1211,333}}
FermatFactors[334]:={{27609,341}}
FermatFactors[338]:={{27654487,342}}
FermatFactors[353]:={{18908555,355}}
FermatFactors[375]:={{733251,377}}
FermatFactors[376]:={{810373,378}}
FermatFactors[398]:={{120845,401}}
FermatFactors[416]:={{8619,418},{38039,419}}
FermatFactors[417]:={{118086729,421}}
FermatFactors[431]:={{5769285,434}}
FermatFactors[452]:={{27,455}}
FermatFactors[468]:={{27114089,471}}
FermatFactors[544]:={{225,547}}
FermatFactors[547]:={{77377,550}}
FermatFactors[556]:={{127,558}}
FermatFactors[620]:={{10084141,624}}
FermatFactors[635]:={{4258979,645}}
FermatFactors[637]:={{11969,643}}
FermatFactors[692]:={{717,695}}
FermatFactors[723]:={{554815,730}}
FermatFactors[744]:={{17,747}}
FermatFactors[851]:={{497531,859}}
FermatFactors[885]:={{16578999,887}}
FermatFactors[906]:={{57063,908}}
FermatFactors[931]:={{1985,933}}
FermatFactors[1069]:={{137883,1073}}
FermatFactors[1082]:={{82165,1084}}
FermatFactors[1123]:={{25835,1125}}
FermatFactors[1225]:={{79707,1231}}
FermatFactors[1229]:={{29139,1233}}
FermatFactors[1451]:={{13143,1454}}
FermatFactors[1551]:={{291,1553}}
FermatFactors[1849]:={{98855,1851}}
FermatFactors[1945]:={{1957,1508631995}}
FermatFactors[2023]:={{29,2027}}
FermatFactors[2089]:={{431,2099}}
FermatFactors[2456]:={{85,2458}}
FermatFactors[3310]:={{5,3313}}
FermatFactors[3506]:={{501,3508}}
FermatFactors[4258]:={{1435,4262}}
FermatFactors[4724]:={{29,4727}}
FermatFactors[5320]:={{21341,5323}}
FermatFactors[6208]:={{763,6210}}
FermatFactors[6390]:={{303,6393}}
FermatFactors[6537]:={{17,6539}}
FermatFactors[6835]:={{19,6838}}
FermatFactors[6909]:={{6021,6912}}
FermatFactors[7309]:={{145,7312}}
FermatFactors[8555]:={{645,8557}}
FermatFactors[9428]:={{9,9431}}
FermatFactors[9448]:={{19,9450}}
FermatFactors[9549]:={{1211,9551}}
FermatFactors[12185]:={{81,12189}}
FermatFactors[13250]:={{351,13252}}
FermatFactors[14252]:={{1173,14254}}
FermatFactors[14276]:={{157,14280}}
FermatFactors[15161]:={{55,15164}}
FermatFactors[17906]:={{135,17909}}
FermatFactors[18749]:={{11,18759}}
FermatFactors[18757]:={{33,18766}}
FermatFactors[23069]:={{681,23071}}
FermatFactors[23288]:={{19,23290}}
FermatFactors[23471]:={{5,23473}}
FermatFactors[24651]:={{99,24653}}
FermatFactors[25006]:={{57,25010}}
FermatFactors[28281]:={{81,28285}}
FermatFactors[94798]:={{21,94801}}
FermatFactors[95328]:={{7,95330}}
FermatFactors[114293]:={{13,114296}}
FermatFactors[125410]:={{5,125413}}
FermatFactors[157167]:={{3,157169}}
FermatFactors[213319]:={{3,213321}}
FermatFactors[303088]:={{3,303093}}

(* FermatPrimes *)

FermatPrimes:={3,5,17,257,65537}
  
End[]

(* Protect[ [--] ] *)

EndPackage[]