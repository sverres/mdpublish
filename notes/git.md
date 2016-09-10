
# GIT - distribuert versjonskontroll

GIT er et verktøy for å holde styr på programkode etter hvert som en eller flere programutviklere gjør endringer i koden. Et sentralt begrep i GIT er repository, ofte omtalt som repo. Dette engelske ordet kan oversettes med **oppbevaringssted**.

Som emneansvarlig i GEO2311 administrerer jeg et to sentrale repos, der ett er for websidene som presenterer faginnholdet med ukeplaner, emneplan og oppgavetekster. Det andre er for kodeeksempler som skal brukes videre i øvinger.

Mine repos er

- [NTNU-GEO2311-dok](https://github.com/sverres/NTNU-GEO2311-dok) for dokumenter og websider.
- [NTNU-GEO2311](https://github.com/sverres/NTNU-GEO2311) for kodeeksempler

Begge disse repoene ligger lagret på [github](https://github.com/). Som studenter skal dere forholde dere til NTNU-GEO2311-dok gjennom Blackboard og til NTNU-GEO2311 gjennom kommandolinjeverktøy for GIT. Instruksjon for hvordan dette skal gjøres vil bli gitt i ukeplanene.

Denne uka skal vi laste ned filer fra NTNU-GEO2311-repoet ved å klone det.

## Kloning av NTNU-GEO2311-repoet på github

- GIT forutsettes installert på egen PC først.
- opprett en mappe under C:\ som kalles NTNU
- høyreklikk i mappen og velg GIT Bash here. Det vil da åpnes et kommandovindu i den aktuelle mappen.
- skriv inn denne kommandoen og trykk enter:

```ini
git clone https://github.com/sverres/NTNU-GEO2311.git
```
Det vil nå opprettes en undermappe under NTNU-mappen med en kopi av filene fra det sentrale repoet.

## Utforsking av innholdet i NTNU-GEO2311-repoet med kommandolinjeverktøy

Skriv kommandoene nedenfor etter tur og observer hva som skjer - hvilken informasjon du får fram. Trykk på enter mellom hver kommando. Les mer om disse kommandoene i Ryans Tutorials - se  link i ukeplanen.


```ini
pwd
ls
```

```ini
cd NTNU-GEO2311
ls
cd 2016
ls
cd uke-35
ls
pwd
```

```ini
atom . 
```

Hvis alt har gått bra, skal du nå ha atom editor åpen med kodeeksemplene fra forelesning i uke 34 tilgjengelig. Ta gjerne en kikk på de filene.
Du kan f.eks. forandre på zoom-nivå og tilpasse koordinatene i hello-script-initialize.htm-filen slik at kartet viser et sted du er interessert i.

## Bonus-oppgave

Hvis du har lyst til å lære litt mer om hva GIT er og kan brukes til, kan det være en god ide å gå igjennom live-demoen på [Try GIT](https://try.github.io/levels/1/challenges/1)
