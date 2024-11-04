(*:Mathematica Version: 6.0 *)

(*:Package Version: 1.17 *)

(*:Name: MathWorld`RSANumbers` *)

(*:Author: Eric W. Weisstein *)

(*:URL:
  http://mathworld.wolfram.com/packages/RSANumbers.m
*)

(*:Summary:  
  send e-mail to challenge-rsa-honor-roll@rsa.com for a current list.
  
  http://www.rsasecurity.com/rsalabs/challenges/factoring/numbers.html
*)

(*:History:
  Written by Eric Weisstein 1995
  
  v1.00 (1997-05-06): RSA-129 factorization
  v1.10 (1999-02-04): RSA-130, 140 factorizations, added RSA-155, 232, 309, 617
  v1.11 (1999-09-10): RSA-155 factorization
  v1.12 (2000-01-01): URL updated
  v1.13 (2002-01-16): URL updated
  v1.14 (2003-10-19): updated context
  v1.15 (2003-12-04): Fixed corrupted package, added factorization of RSA-576 and 
                      an updated list of challenge numbers
                      
  v1.16 (2004-08-24): Added RSA-150 factorization
  v1.17 (2005-05-10): Added RSA-200 factorization
  v1.18 (2005-11-08): Added RSA-640 factorization
  
  (c) 1995-2007 Eric W. Weisstein
*)

(* Limitations:
*)

(*:Keywords:
  RSA number, public-key cryptography, factoring large numbers
*)

(*:Requirements: None. *)

(*:Discussion:
  See http://mathworld.wolfram.com/packages/RSANumber.m
  
  RSA-576 factored 2003-12-03 by 
  From: Jens Franke [mailto:franke@math.uni-bonn.de]                                                       
  Sent: 03 December 2003 13:32                                                                             
  To: webmaster@rsasecurity.com; pr@rsasecurity.com; BKaliski@rsasecurity.com;                             

*)

BeginPackage["MathWorld`RSANumbers`"]

RSA::usage=
"RSA[n] gives the RSA number of n digits."

RSAFactors::usage=
"RSAFactors[n] gives the factors of the RSA[n] number."

RSAFactorsCheck::usage=
"RSAFactorsCheck[n] gives the difference between RSA[n] and the product of
RSAFactors[n], which should be 0."


Begin["`Private`"]

RSAFactorsCheck[n_Integer]:=(Times@@RSAFactors[n]-RSA[n])==0 /; ListQ[RSAFactors[n]]

RSA[100]:=1522605027922533360535618378132637429718068114961380688657908494580122963258952897654000350692006139
RSA[110]:=35794234179725868774991807832568455403003778024228226193532908190484670252364677411513516111204504060317568667
RSA[120]:=227010481295437363334259960947493668895875336466084780038173258247009162675779735389791151574049166747880487470296548479
RSA[129]:=114381625757888867669235779976146612010218296721242362562561842935706935245733897830597123563958705058989075147599290026879543541
RSA[130]:=1807082088687404805951656164405905566278102516769401349170127021450056662540244048387341127590812303371781887966563182013214880557
RSA[140]:=21290246318258757547497882016271517497806703963277216278233383215381949984056495911366573853021918316783107387995317230889569230873441936471
RSA[150]:=155089812478348440509606754370011861770654545830995430655466945774312632703463465954363335027577729025391453996787414027003501631772186840890795964683
RSA[155]:=10941738641570527421809707322040357612003732945449205990913842131476349984288934784717997257891267332497625752899781833797076537244027146743531593354333897
RSA[160]:=2152741102718889701896015201312825429257773588845675980170497676778133145218859135673011059773491059602497907111585214302079314665202840140619946994927570407753
RSA[170]:=26062623684139844921529879266674432197085925380486406416164785191859999628542069361450283931914514618683512198164805919882053057222974116478065095809832377336510711545759
RSA[180]:=191147927718986609689229466631454649812986246276667354864188503638807260703436799058776201365135161278134258296128109200046702912984568752800330221777752773957404540495707851421041
RSA[190]:=1907556405060696491061450432646028861081179759533184460647975622318915025587184175754054976155121593293492260464152630093238509246603207417124726121580858185985938946945490481721756401423481
RSA[200]:=27997833911221327870829467638722601621070446786955428537560009929326128400107609345671052955360856061822351910951365788637105954482006576775098580557613579098734950144178863178946295187237869221823983
RSA[210]:=245246644900278211976517663573088018467026787678332759743414451715061600830038587216952208399332071549103626827191679864079776723243005600592035631246561218465817904100131859299619933817012149335034875870551067
RSA[220]:=2260138526203405784941654048610197513508038915719776718321197768109445641817966676608593121306582577250631562886676970448070001811149711863002112487928199487482066070131066586646083327982803560379205391980139946496955261
RSA[230]:=17969491597941066732916128449573246156367561808012600070888918835531726460341490933493372247868650755230855864199929221814436684722874052065257937495694348389263171152522525654410980819170611742509702440718010364831638288518852689
RSA[232]:=1009881397871923546909564894309468582818233821955573955141120516205831021338528545374366109757154363664913380084917065169921701524733294389270280234380960909804976440540711201965410747553824948672771374075011577182305398340606162079
RSA[240]:=124620366781718784065835044608106590434820374651678805754818788883289666801188210855036039570272508747509864768438458621054865537970253930571891217684318286362846948405301614416430468066875699415246993185704183030512549594371372159029236099
RSA[250]:=2140324650240744961264423072839333563008614715144755017797754920881418023447140136643345519095804679610992851872470914587687396261921557363047454770520805119056493106687691590019759405693457452230589325976697471681738069364894699871578494975937497937
RSA[260]:=22112825529529666435281085255026230927612089502470015394413748319128822941402001986512729726569746599085900330031400051170742204560859276357953757185954298838958709229238491006703034124620545784566413664540684214361293017694020846391065875914794251435144458199
RSA[270]:=233108530344407544527637656910680524145619812480305449042948611968495918245135782867888369318577116418213919268572658314913060672626911354027609793166341626693946596196427744273886601876896313468704059066746903123910748277606548649151920812699309766587514735456594993207
RSA[280]:=1790707753365795418841729699379193276395981524363782327873718589639655966058578374254964039644910359346857311359948708984278578450069871685344678652553655035251602806563637363071753327728754995053415389279785107516999221971781597724733184279534477239566789173532366357270583106789
RSA[290]:=30502351862940031577691995198949664002982179597487683486715266186733160876943419156362946151249328917515864630224371171221716993844781534383325603218163254920110064990807393285889718524383600251199650576597076902947432221039432760575157628357292075495937664206199565578681309135044121854119
RSA[300]:=276931556780344213902868906164723309223760836398395325400503672280937582471494739461900602187562551243171865731050750745462388288171212746300721613469564396741836389979086904304472476001839015983033451909174663464663867829125664459895575157178816900228792711267471958357574416714366499722090015674047
RSA[309]:=133294399882575758380143779458803658621711224322668460285458826191727627667054255404674269333491950155273493343140718228407463573528003686665212740575911870128339157499072351179666739658503429931021985160714113146720277365006623692721807916355914275519065334791400296725853788916042959771420436564784273910949
RSA[310]:=1848210397825850670380148517702559371400899745254512521925707445580334710601412527675708297932857843901388104766898429433126419139462696524583464983724651631481888473364151368736236317783587518465017087145416734026424615690611620116380982484120857688483676576094865930188367141388795454378671343386258291687641
RSA[320]:=21368106964100717960120874145003772958637679383727933523150686203631965523578837094085435000951700943373838321997220564166302488321590128061531285010636857163897899811712284013921068534616772684717323224436400485097837112174432182703436548357540610175031371364893034379963672249152120447044722997996160892591129924218437
RSA[330]:=121870863310605869313817398014332524915771068622605522040866660001748138323813524568024259035558807228052611110790898823037176326388561409009333778630890634828167900405006112727432172179976427017137792606951424995281839383708354636468483926114931976844939654102090966520978986231260960498370992377930421701862444655244698696759267
RSA[340]:=2690987062294695111996484658008361875931308730357496490239672429933215694995275858877122326330883664971511275673199794677960841323240693443353204889858591766765807522315638843948076220761775866259739752361275228111366001104150630004691128152106812042872285697735145105026966830649540003659922618399694276990464815739966698956947129133275233
RSA[350]:=26507199951735394734498120973736811015297864642115831624674545482293445855043495841191504413349124560193160478146528433707807716865391982823061751419151606849655575049676468644737917071142487312863146816801954812702917123189212728868259282632393834443989482096498000219878377420094983472636679089765013603382322972552204068806061829535529820731640151
RSA[360]:=218682020234317263146640637228579265464915856482838406521712186637422774544877649638896808173342116436377521579949695169845394824866781413047516721975240052350576247238785129338002757406892629970748212734663781952170745916609168935837235996278783280225742175701130252626518426356562342682345652253987471761591019113926725623095606566457918240614767013806590649
RSA[370]:=1888287707234383972842703127997127272470910519387718062380985523004987076701721281993726195254903980001896112258671262466144228850274568145436317048469073794495250347974943216943521462713202965796237266310948224934556725414915442700993152879235272779266578292207161032746297546080025793864030543617862620878802244305286292772467355603044265985905970622730682658082529621
RSA[380]:=30135004431202116003565860241012769924921679977958392035283632366105785657918270750937407901898070219843622821090980641477056850056514799336625349678549218794180711634478735831265177285887805862071748980072533360656419736316535822377792634235019526468475796787118257207337327341698664061454252865816657556977260763553328252421574633011335112031733393397168350585519524478541747311
RSA[390]:=268040194118238845450103707934665606536694174908285267872982242439770917825046230024728489676042825623316763136454136724676849961188128997344512282129891630084759485063423604911639099585186833094019957687550377834977803400653628695534490436743728187025341405841406315236881249848600505622302828534189804007954474358650330462487514752974123986970880843210371763922883127855444022091083492089
RSA[400]:=2014096878945207511726700485783442547915321782072704356103039129009966793396141985086509455102260403208695558793091390340438867513766123418942845301603261911930567685648626153212566300102683464717478365971313989431406854640516317519403149294308737302321684840956395183222117468443578509847947119995373645360710979599471328761075043464682551112058642299370598078702810603300890715874500584758146849481
RSA[410]:=19653601479938761414239452741787457079262692944398807468279711209925174217701079138139324539033381077755540830342989643633394137538983355218902490897764441296847433275460853182355059915490590169155909870689251647778520385568812706350693720915645943335281565012939241331867051414851378568457417661501594376063244163040088180887087028771717321932252992567756075264441680858665410918431223215368025334985424358839
RSA[420]:=209136630247651073165255642316333073700965362660524505479852295994129273025818983735700761887526097496489535254849254663948005091692193449062731454136342427186266197097846022969248579454916155633686388106962365337549155747268356466658384680996435419155013602317010591744105651749369012554532024258150373034059528878269258139126839427564311148202923131937053527161657901326732705143817744164107601735413785886836578207979
RSA[430]:=3534635645620271361541209209607897224734887106182307093292005188843884213420695035531516325888970426873310130582000012467805106432116010499008974138677724241907444538851271730464985654882214412422106879451855659755824580313513382070785777831859308900851761495284515874808406228585310317964648830289141496328996622685469256041007506727884038380871660866837794704723632316890465023570092246473915442026549955865931709542468648109541
RSA[440]:=26014282119556025900707884873713205505398108045952352894235085896633912708374310252674800592426746319007978890065337573160541942868114065643853327229484502994233222617112392660635752325773689366745234119224790516838789368452481803077294973049597108473379738051456732631199164835297036074054327529666307812234597766390750441445314408171802070904072739275930410299359006059619305590701939627725296116299946059898442103959412221518213407370491
RSA[450]:=19846342371428366234972307218611314277894628692588620898785380098715986925690078791591684242367262529704652673686711493985446003494265587358393155378115803244706115514516077058092682436657321199398166261463573481264744836057385631322474917155269972781155149056189532534439574358815035934148423670960461827643434794849824315251510662855699269624207451365738384255497823390996283918328766741917298807222199653240330025890608321116074450819102\
          4837057033
RSA[460]:=178685602040400443326210378921284458588640008699388295508105157850763480752414640788198121696813944457714763346084886877462543182928286033961495626230363564554675355258128655971003201417831521222464468666642766044146641933788836893245221732135486048435329613140382117586289099859865385837383562865435188048063622316430823868487310523501157767155211494537088684281083030169831333900416365515466857004900847501644808076825638918266848964153626\
          4864604484300734909
RSA[470]:=170514737846811852090815992388870280251832558521491596835889183698096753980368977114423836025263145191923666122705958155103119708861167631776699644118140957486602388713064698304619191359016382379244440741228665455229545368837485587445521289504452180962081887888763243950493623768065799410533053862175959840477096039543124476927252768875945906587929399246092612647885720322123347268553025718835659126454325220771380103576695555550710440908570\
          89539320564963576770285413369
RSA[480]:=302657075295090869739730250315591803589112283576939858395529632634305976144571441696598170401251852159138533455982172343712313383247732107268535247763784105186549246199888070331088462855743520880671299302895546822695492968577380706795842802200829411198422297326020823369315258921162990168697393348736236081296604185145690639952829781767901497605213955485328141965346769742597479306858645849268328985687423881853632604706175564461719396117318\
          298679820785491875674946700413680932103
RSA[490]:=186023912707684651719836935402607687526951593059283915020102835383703102597137385221647433279492064339990682255318550725546067821388008411628660373933246578171804201717222449954030315293547871401362961501065002486552688663415745975892579359416565102078922006731141692607694977776760490610706193787354060159427473161761937753741907130711549006585032694655164968285686543771831905869537640698044932638893492457914750855858980849190488385315076\
          9224537555274811376719096144119390052199027715691
RSA[500]:=189719413374862665633053474331720252723718359195342830318458112306245045887076876059432123476257664274945547644195154275867432056593172546699466049824197301601038125215285400688031516401611623963128370629793265939405081077581694478604172141102464103804027870110980866421480002556045468762513774539341822154948212773356717351534726563284480011349409264424384401989109086032526788147850601132077287172819942445113232019492229554237898606631074\
          89107472242561739680319169243814676235712934292299974411361


RSA[576]:=188198812920607963838697239461650439807163563379417382700763356422988859715234665485319060606504743045317388011303396716199692321205734031879550656996221305168759307650257059
RSA[617]:=227018012937850141935804051202045867410612359627665839070940218792151714831191398948701330911110449016834009494838468182995180417635079489225907749254660881718792594659210265970467004498198990968620394600177430944738110569912941285428918808553627074076707225937377726669734409773612433363973080517630915068363107953126072395203652900321058488395079814523072994171857157962974549950235053160409198591937180233074148804462179228008317660409386\
          56344571034778553457121080530736394535923932651866030515041060966437313323672831539323500067937107541955437362433248361242525945868802353916766181532375855504886901432221349733
RSA[640]:=3107418240490043721350750035888567930037346022842727545720161948823206440518081504556346829671723286782437916272838033415471073108501919548529007337724822783525742386454014691736602477652346609
RSA[704]:=74037563479561712828046796097429573142593188889231289084936232638972765034028266276891996419625117843995894330502127585370118968098286733173273108930900552505116877063299072396380786710086096962537934650563796359
RSA[768]:=1230186684530117755130494958384962720772853569595334792197322452151726400507263657518745202199786469389956474942774063845925192557326303453731548268507917026122142913461670429214311602221240479274737794080665351419597459856902143413
RSA[896]:=412023436986659543855531365332575948179811699844327982845455626433876445565248426198098870423161841879261420247188869492560931776375033421130982397485150944909106910269861031862704114880866970564902903653658867433731720813104105190864254793282601391257624033946373269391
RSA[1024]:=135066410865995223349603216278805969938881475605667027524485143851526510604859533833940287150571909441798207282164471551373680419703964191743046496589274256239341020864383202110372958725762358509643110564073501508187510676594629205563685529475213500852879416377328533906109750544334999811150056977236890927563
RSA[1536]:=1847699703211741474306835620200164403018549338663410171471785774910651696711161249859337684305435744585616061544571794052229717732524660960646946071249623720442022269756756687378427562389508764678440933285157496578843415088475528298186726451339863364931908084671990431874381283363502795470282653297802934916155811881049844908319545009848393775227257052578591944993870073695755688436933812779613089230392569695253261620823676490316036551371447913932347169566988069
RSA[2048]:=25195908475657893494027183240048398571429282126204032027777137836043662020707595556264018525880784406918290641249515082189298559149176184502808489120072844992687392807287776735971418347270261896375014971824691165077613379859095700097330459748808428401797429100642458691817195118746121515172654632282216869987549182422433637259085141865462043576798423387184774447920739934236584823824281198163815010674810451660377306056201619676256133844143603833904414952634432190114657544454178424020924616515723350778707749817125772467962926386356373289912154831438167899885040445364023527381951378636564391212010397122822120720357

RSAFactors[100]:=
  {40094690950920881030683735292761468389214899724061,
   37975227936943673922808872755445627854565536638199}
RSAFactors[110]:=
  {6122421090493547576937037317561418841225758554253106999,
   5846418214406154678836553182979162384198610505601062333}
RSAFactors[120]:=
  {327414555693498015751146303749141488063642403240171463406883,
   693342667110830181197325401899700641361965863127336680673013}
RSAFactors[129]:=
  {3490529510847650949147849619903898133417764638493387843990820577,
   32769132993266709549961988190834461413177642967992942539798288533}
RSAFactors[130]:=
  {39685999459597454290161126162883786067576449112810064832555157243,
   45534498646735972188403686897274408864356301263205069600999044599}
RSAFactors[140]:=
  {3398717423028438554530123627613875835633986495969597423490929302771479,
   6264200187401285096151654948264442219302037178623509019111660653946049}
RSAFactors[150]:=
  {348009867102283695483970451047593424831012817350385456889559637548278410717,
   445647744903640741533241125787086176005442536297766153493419724532460296199}
RSAFactors[155]:=
	{102639592829741105772054196573991675900716567808038066803341933521790711307779,
	106603488380168454820927220360012878679207958575989291522270608237193062808643}
RSAFactors[160]:=
	{45427892858481394071686190649738831656137145778469793250959984709250004157335359,
	47388090603832016196633832303788951973268922921040957944741354648812028493909367}
RSAFactors[200]:={
	3532461934402770121272604978198464368671197400197625023649303468776121253679423200058547956528088349,
	7925869954478333033347085841480059687737975857364219960734330341455767872818152135381409304740185467
}

RSAFactors[576]:={
	398075086424064937397125500550386491199064362342526708406385189575946388957261768583317,
	472772146107435302536223071973048224632914695302097116459852171130520711256363590397527
}
RSAFactors[640]:={
	1634733645809253848443133883865090859841783670033092312181110852389333100104508151212118167511579,
	1900871281664822113126851573935413975471896789968515493666638539088027103802104498957191261465571
}
	
End[]

(*
Protect[ ]
*)

EndPackage[]