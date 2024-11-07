(**NAVOD NA POUŽÍVANIE**)

Obsahom tohto priečinku je Bakalárska práca študenta Dominik Zaťovič (všetky práva vyhradené).
Nachádzajú sa tu generátory pre okruh Úvod do teórie grafov, pre 9 typov grafu + vlastný, pričom je možné zadať rôzne špecifikácie (pri väčšine z nich)

(**BASIC_GENERATORY_MIMO_MATHIO**)
V tomto priečinku sa nachádzajú knižnice, ktoré sa dajú importovať do Mathematicy a využívať.
Obsahuju viac používateľskej interakcie, pri väčšine grafov možno zadať počet vrcholov, hrán, orientáciu (šípky)
Taktiež je tu "OwnGraph" do ktorého zadáte maticu susednosti s ohodnoteniami hrán a vytvorím vám z nej graf.

(*Návod na použitie*)
-Otvorte si notebook, v ktorom chcete použiť knižnicu
-Vľavo hore kliknite na FILE -> INSTALL -> SOURCE (FROM FILE) -> Vyberte knižnicu/package -> OK
-Následne napište tento príkaz na začiatok notebooku: Needs["<názov_knižnice>`"]
Príklad: Ak je názov package GeneratorSquareGraph.wl tak zadáta Needs["GeneratorSquareGraph`"]

-Nakoniec napíšete príkaz na zavolanie knižnice: Equation[<difficulty>,<directed>]
Príklad: Equation[EASY,False]

difficulty: EASY | MEDIUM | HARD (Viacmenej to iba zmení nápovedu v kontextovom okne, koľko vrcholov/hrán by ste si mali zvoliť)
directed: False | True (Orientácia, má byť graf orientovaný alebo nie? Neorientované grafy majú hrany obojstranné s 1 ohodnotením,
			Orientované majú jednostranné hrany s ohodnotením)

POZOR!!!! Predtým, ako spustíte program, treba otvoriť samotnú knižnicu (.wl súbor, ktorý chcete importovať) a stlačiť RUN PACKAGE, aby sa načítal

- Ak budete chcieť importovať inú knižnicu, bohužial, treba vypnúť kernel (Evaluation -> Quit Kernel) a opakovať tento návod od FILE->INSTALL

-> TestPackagov.nb <-
V tomto notebooku je príklad commandov, ako zavolať knižnicu. 
Niektoré knižnice/grafy žiadajú užívateľské inputy, ako napr. počet vrcholov, počet hrán, začiatočný vrchol, koncový vrchol...
Riaďte sa pokynmi v kontextových oknách, ktoré vyskakujú. Treba dávať pozor na písmenka aj CAPS, všetko je citlivé.

Príklad inputov: (Enter number of vertexes: 10, Enter number of edges: 16, Enter starting vertex: A, Enter ending vertex: C, vysledok or postup?: postup)



(**DIRECTED_MATHIO a UNDIRECTED_MATHIO**)
V tomto priečinku sa nachádzajú knižnice, prispôsobené na stránku MATHIO (http://147.175.150.251/)
Je tu upravený text, ako aj exportovanie grafov cez base64. 
->Neodporúčam na bežné používanie v notebookoch<-
Nachádza sa tu veľa knižníc, pre jednotlivé grafy, ich orientáciu a ich obtiažnosť
Dôvodom je komplexita môjho programu, príliš zaťažovala stránku, ak bol pre 1 graf jeden súbor so všetkým (áno, zabralo veľa času to triediť)
Málo užívateľských inputov (stránka to nedovoľuje, preto som ich musel rozdeliť a zvyšok hardcodovať)




