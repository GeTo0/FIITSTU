(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.23 *)

(*:Name: MathWorld`Mersenne` *)

(*:Author: Eric Weisstein *)
(*         Generic MersenneFactor by raulnunes@hotmail.com *)

(*:URL:
  http://mathworld.wolfram.com/packages/Mersenne.m
*)

(*:Summary:
  This package generates Mersenne numbers and contains factorization
  information for them.
*)

(*:History:
  v1.00 (1998-05-10): Written by Eric W. Weisstein
  v1.10 (1999-06-02): Included generic factorization by R. Nunes
  v1.11 (1999-07-01): newest prime added
  v1.12 (2000-01-01): URL updated
  v1.13 (2000-03-22): PerfectNumber
  v1.14 (2001-12-06): M39 added and URL updated
  v1.15 (2003-10-19): Context updated
  v1.16 (2003-12-02): M40, MersenneDigits, renamed MersennePrimes
                      to MersennePrimeIndices
  v1.17 (2004-03-27): added factors for primes
  v1.18 (2004-06-01): Added M41
  v1.19 (2004-11-28): DoubleMersenne
  v1.20 (2005-01-21): PerfectNumberQ
  v1.21 (2005-02-26): Added M42
  v1.22 (2005-12-25): Added M43
  v1.23 (2006-09-11): Added M44
  
  (c) 1998-2007 Eric W. Weisstein
*)

(*:Keywords:
	Mersenne number, Mersenne prime
*)

(*:Requirements: None. *)

(*:References:
  Weisstein, E. W.
    http://mathworld.wolfram.com/packages/MersenneNumber.html
    
  A more complete list of factors can be found at
  http://www.garlic.com/~wedgingt/factoredM.txt
*)


BeginPackage["MathWorld`Mersenne`"]

DoubleMersenne::usage =
"DoubleMersenne[n] gives Mersenne[Mersenne[n]]."

Mersenne::usage =
"Mersenne[n] gives the nth Mersenne number."

MersenneDigits::usage =
"MersenneDigits[n] gives the number of digits in the \
nth Mersenne number."

MersenneFactors::usage =
"MersenneFactors[n] gives a list of factors of the nth Mersenne number \
Mersenne[n].  MersenneFactors[n,d] attempts to give a factor of Mersenne[n] \
having d or fewer digits."

MersennePrimeIndices::usage =
"MersennePrimeIndices gives the indices of known Mersenne primes."

PerfectNumber::usage =
"PerfectNumber[n] gives the nth perfect number."

PerfectNumberQ::usage =
"PerfectNumberQ[n] returns True if n is a perfect number."

Begin["`Private`"]

DoubleMersenne[n_]:=2^(2^n-1)-1

Mersenne[n_]:=2^n-1

MersenneDigits[n_]:=Floor[n Log[10,2]+1]

MersennePrimeIndices:={
	2,3,5,7,13,17,19,31,61,89,
	107,127,521,607,1279,2203,2281,3217,4253,4423,
	9689,9941,11213,19937,21701,23209,44497,86243,110503,132049,
	216091,756839,859433,1257787,1398269,2976221,3021377,6972593,13466917,
	20996011,24036583,25964951,30402457,32582657
}

MersenneFactors[n_Integer?Positive]:={}

MersenneFactors[1]:={1}
MersenneFactors[2]:={3}
MersenneFactors[3]:={7}
MersenneFactors[4]:={3,5}
MersenneFactors[5]:={31}
MersenneFactors[6]:={3,3,7}
MersenneFactors[7]:={127}
MersenneFactors[8]:={3,5,17}
MersenneFactors[9]:={7,73}
MersenneFactors[10]:={3,11,31}
MersenneFactors[11]:={23,89}
MersenneFactors[12]:={3,3,5,7,13}
MersenneFactors[13]:={8191}
MersenneFactors[14]:={3,43,127}
MersenneFactors[15]:={7,31,151}
MersenneFactors[16]:={3,5,17,257}
MersenneFactors[17]:={131071}
MersenneFactors[18]:={3,3,3,7,19,73}
MersenneFactors[19]:={524287}
MersenneFactors[20]:={3,5,5,11,31,41}
MersenneFactors[21]:={7,7,127,337}
MersenneFactors[22]:={3,23,89,683}
MersenneFactors[23]:={47,178481}
MersenneFactors[24]:={3,3,5,7,13,17,241}
MersenneFactors[25]:={31,601,1801}
MersenneFactors[26]:={3,2731,8191}
MersenneFactors[27]:={7,73,262657}
MersenneFactors[28]:={3,5,29,43,113,127}
MersenneFactors[29]:={233,1103,2089}
MersenneFactors[30]:={3,3,7,11,31,151,331}
MersenneFactors[31]:={2147483647}
MersenneFactors[32]:={3,5,17,257,65537}
MersenneFactors[33]:={7,23,89,599479}
MersenneFactors[34]:={3,43691,131071}
MersenneFactors[35]:={31,71,127,122921}
MersenneFactors[36]:={3,3,3,5,7,13,19,37,73,109}
MersenneFactors[37]:={223,616318177}
MersenneFactors[38]:={3,174763,524287}
MersenneFactors[39]:={7,79,8191,121369}
MersenneFactors[40]:={3,5,5,11,17,31,41,61681}
MersenneFactors[41]:={13367,164511353}
MersenneFactors[42]:={3,3,7,7,43,127,337,5419}
MersenneFactors[43]:={431,9719,2099863}
MersenneFactors[44]:={3,5,23,89,397,683,2113}
MersenneFactors[45]:={7,31,73,151,631,23311}
MersenneFactors[46]:={3,47,178481,2796203}
MersenneFactors[47]:={2351,4513,13264529}
MersenneFactors[48]:={3,3,5,7,13,17,97,241,257,673}
MersenneFactors[49]:={127,4432676798593}
MersenneFactors[50]:={3,11,31,251,601,1801,4051}
MersenneFactors[51]:={7,103,2143,11119,131071}
MersenneFactors[52]:={3,5,53,157,1613,2731,8191}
MersenneFactors[53]:={6361,69431,20394401}
MersenneFactors[54]:={3,3,3,3,7,19,73,87211,262657}
MersenneFactors[55]:={23,31,89,881,3191,201961}
MersenneFactors[56]:={3,5,17,29,43,113,127,15790321}
MersenneFactors[57]:={7,32377,524287,1212847}
MersenneFactors[58]:={3,59,233,1103,2089,3033169}
MersenneFactors[59]:={179951,3203431780337}
MersenneFactors[60]:={3,3,5,5,7,11,13,31,41,61,151,331,1321}
MersenneFactors[61]:={2305843009213693951}
MersenneFactors[62]:={3,715827883,2147483647}
MersenneFactors[63]:={7,7,73,127,337,92737,649657}
MersenneFactors[64]:={3,5,17,257,641,65537,6700417}
MersenneFactors[65]:={31,8191,145295143558111}
MersenneFactors[66]:={3,3,7,23,67,89,683,20857,599479}
MersenneFactors[67]:={193707721,761838257287}
MersenneFactors[68]:={3,5,137,953,26317,43691,131071}
MersenneFactors[69]:={7,47,178481,10052678938039}
MersenneFactors[70]:={3,11,31,43,71,127,281,86171,122921}
MersenneFactors[71]:={228479,48544121,212885833}
MersenneFactors[72]:={3,3,3,5,7,13,17,19,37,73,109,241,433,38737}
MersenneFactors[73]:={439,2298041,9361973132609}
MersenneFactors[74]:={3,223,1777,25781083,616318177}
MersenneFactors[75]:={7,31,151,601,1801,100801,10567201}
MersenneFactors[76]:={3,5,229,457,174763,524287,525313}
MersenneFactors[77]:={23,89,127,581283643249112959}
MersenneFactors[78]:={3,3,7,79,2731,8191,121369,22366891}
MersenneFactors[79]:={2687,202029703,1113491139767}
MersenneFactors[80]:={3,5,5,11,17,31,41,257,61681,4278255361}
MersenneFactors[81]:={7,73,2593,71119,262657,97685839}
MersenneFactors[82]:={3,83,13367,164511353,8831418697}
MersenneFactors[83]:={167,57912614113275649087721}
MersenneFactors[84]:={3,3,5,7,7,13,29,43,113,127,337,1429,5419,14449}
MersenneFactors[85]:={31,131071,9520972806333758431}
MersenneFactors[86]:={3,431,9719,2099863,2932031007403}
MersenneFactors[87]:={7,233,1103,2089,4177,9857737155463}
MersenneFactors[88]:={3,5,17,23,89,353,397,683,2113,2931542417}
MersenneFactors[89]:={618970019642690137449562111}
MersenneFactors[90]:={3,3,3,7,11,19,31,73,151,331,631,23311,18837001}
MersenneFactors[91]:={127,911,8191,112901153,23140471537}
MersenneFactors[92]:={3,5,47,277,1013,1657,30269,178481,2796203}
MersenneFactors[93]:={7,2147483647,658812288653553079}
MersenneFactors[94]:={3,283,2351,4513,13264529,165768537521}
MersenneFactors[95]:={31,191,524287,420778751,30327152671}
MersenneFactors[96]:={3,3,5,7,13,17,97,193,241,257,673,65537,22253377}
MersenneFactors[97]:={11447,13842607235828485645766393}
MersenneFactors[98]:={3,43,127,4363953127297,4432676798593}
MersenneFactors[99]:={7,23,73,89,199,153649,599479,33057806959}
MersenneFactors[100]:={3,5,5,5,11,31,41,101,251,601,1801,4051,8101,268501}

MersenneFactors[113]:={3391,23279,65993,1868569,1066818132868207}
MersenneFactors[193]:={13821503,61654440233248340616559,
	14732265321145317331353282383} 
MersenneFactors[211]:={15193,60272956433838849161,
	3593875704495823757388199894268773153439}
MersenneFactors[251]:={503,54217,178230287214063289511,61676882198695257501367,
	12070396178249893039969681}
MersenneFactors[257]:={535006138814359,1155685395246619182673033,
	374550598501810936581776630096313181393}

MersenneFactors[p_Integer?Positive]:=MersenneFactors[p,7]

MersenneFactors[p_Integer?Positive,l_Integer?Positive] := Block[{mp},
	mp=MersennePrimeIndices;
	If[MemberQ[mp,p],
		Print["2^",p,"-1 is a known Mersenne prime."],
		If[p<1398269 || !PrimeQ[p],
			Block[{},Print["2^",p,"-1 is certainly composite."];
               If[EvenQ[p],Print["2^",p,"-1 = 3 * ... "],
                    Block[{m=2^p-1,f,fmax},fmax=Min[m,10^l];f=1+p;
                         While[f<=fmax && Mod[m,f]!=0,f=f+p];
                          If[Mod[m,f]==0, Print["2^",p,"-1 = ",f," * ..."],
                               Print["Please, try again with more than 10^",l," digits."]
                          ]
                    ]
               ]
         ],
		Block[{m=2^p-1,r,f,fmax,d=2*p},r=Floor[N[Sqrt[m],0]];
		fmax=Min[r,10^l]; 
		f=1+d;
		While[f<=fmax && Mod[m,f]!=0,f=f+d];
			If[Mod[m,f]==0, Print["2^",p,"-1 = ",f," * ..."],
			If[Negative[f-r],Print["Please, try again with more than  10^",l," digits."],
            Print["2^",p,"-1 is a new Mersenne prime! Check it!"]
                 ]
             ]
         ]
      ]
   ]
]

PerfectNumber[n__Integer?Positive]:=(#+1)#/2&[Mersenne[MersennePrimeIndices[[n]]]]

PerfectNumberQ[n_Integer?Positive]:=DivisorSigma[1,n]==2n

End[]

Protect[(* *)]

EndPackage[]