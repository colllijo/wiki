---
weight: 8201
title: "RSA - Verschlüsselung"
description: |
  Dokumentation zur assymetrischen RSA Verschlüsselung
icon: "article"
date: "2025-04-09T08:56:14+02:00"
lastmod: "2025-04-09T08:56:14+02:00"
draft: false
toc: true
katex: true
---

## Einleitung

RSA (Rivest-Shamir-Adelman) von den Namen der drei Mathematiker, welche das
Verfahren entwickelt haben. [Ronald L. **R**ivest][rivest-wiki],
[Adi **S**hamir][shamir-wiki] und [Leonard **A**dleman][adleman-wiki]. RSA ist
ein asymmetrisches kryptographisches Verfahren, welches zum Verschlüsseln, als
auch zum digitalen Signieren verwendet werden kann. Als asymmetrisches Verfahren
verwendet RSA ein Schlüsselpaar bestehend aus einem öffentlichen und einem
privaten Schlüssel, wobei der öffentliche Schlüssel die Verschlüsselung durch
den privaten Entschlüsselt und umgekehrt. Die Sicherheit des Verfahrens beruht
darauf, dass der private Schlüssel geheim bleibt und es nicht möglich ist diesen
aus dem öffentlichen Schlüssel zu berechnen, dies ist mit heutigen Mitteln noch
nicht in einem realistischen Zeitrahmen möglich.  
Siehe auch [Shor's Algorithmus][shor-wiki]

## Verfahren

Um eine Nachricht zu verschlüsseln verwendet RSA eine Einwegpermutation mit
Falltür. Eine [Einwegfunktion][einwegfunktion-wiki] ist dabei eine Funktion,
welche selber einfach, die Umkehrfunktion jedoch nur sehr schwer zu berechnen
ist. RSA verwendet als Einwegfunktion die Multiplikation grosser Primzahlen.
Da die Primfaktorzerlegung (Umkehrfunktion der Primzahl Multiplikation) grosser
Zahlen nach heutigem Wissensstand sehr aufwändig ist. Eine Einwegfunktion hat
dann eine [Falltür][falltürfunktion-wiki], wenn es eine geheime Information
gibt, die es erlaubt die Funktion einfach rückwärts zu berechnen. Bei RSA ist
dies der private Schlüssel.

### Schlüsselerzeugung

Die Schlüssel für das RSA Verfahren bestehen aus den drei Zahlen $e$ $d$ und
$N$. Dabei ist $N$ der RSA-Modul, $e$ der Verschlüsselungsexponenten und $d$ der
Entschlüsselungsexponenten. Dabei bildet das Zahlenpaar $(e, N)$ den
öffentlichen Schlüssel und $(d, N)$ den privaten Schlüssel. Diese Zahlen
werden mit folgendem Verfahren erzeugt:

1. Zwei stochastisch unabhängige Primzahlen $p$ und $q$ werden gewählt Für die
   gilt $p \neq q$, zusätzliche sollen diese Zahlen die gleiche Grössenordnung
   haben, so dass die Bedingung $0.1 < \lvert \log_2(p) - \log_2(q) \rvert < 30$
   erfüllt ist.
2. Berechnen des RSA-Modul $N = p \cdot q$.
3. Berechnen der Eulerschen φ-Funktion $\varphi(N) = (p-1)(q-1)$.
4. Wählen einer Zahle $e$, welche zu $\varphi(N)$ teilerfremd ist und für die
   gilt $1 < e < \varphi(N)$.
5. Berechnen des Entschlüsselungsexponenten $d$ als multiplikativ Inverses von
   $e$ bezüglich $\varphi(N)$, es soll also Kongruenz $d \cdot e \equiv 1 \mod
   \varphi(N)$.

Die Zahlen $p$, $q$ und $\varphi(N)$ werden nach der Schlüsselerzeugung nicht
mehr benötigt und können gelöscht werden. Die Zahlen $p$, $q$, $\varphi(N)$ und
$d$ müssen jedoch unbedingt geheim gehalten werden, da sie es sonst ermöglichen
den privaten Schlüssel wiederherzustellen.

Das generieren zwei stochastisch unabhängiger Primzahlen bedeutet, dass die Wahl
der ersten Primzahl $p$ keinen statistischen Einfluss auf die Wahl der zweiten
Primzahl $q$ haben darf.

Heutzutage sind Primzahltests ausreichend schnell, dass man die Reihenfolge für
die Schlüsselerzeugung leicht abgeändert anwendet. Zuerst wird der Exponent $e$
mit der Bedingung $2^{16} < e < 2^{64}$ gewählt und die Primzahlen $p$ und $q$
werden solange verworfen, bis $p - 1$ und $q - 1$ teilerfremd zu $e$ sind.
Dabei ist es wichtig, dass $e$ grösser als die [Fermat-Zahl][fermat-zahl-wiki]
$F_4 = 2^{2^4} + 1 = 65537$ ist um mögliche Angriffsmöglichkeiten zu verhindern.
Falls $d$ weniger als ein Viertel der Bits des RSA-Moduls $N$ hat ist es möglich
$d$ effizient zu ermitteln, weshalb die Obergrenze $2^{64}$ für $e$ gewählt
wurde, welche diese Möglichkeit ausschliesst.

#### Beispiel

Dieses Beispiel verwendet die abgeänderte Method bei der zuerst der
Entschlüsselungsexponent $e$ gewählt wird.

1. Wahl des Exponent $e = 27$.
2. Wahl von $p = 17$ und $q = 29$, die Zahlen $p - 1 = 16$ und $q - 1 = 28$ sind
   teilerfremd zu $e$
3. Berechnung des RSA-Moduls $N = 17 \cdot 29 = 493$.
4. Berechnung der Eulerschen φ-Funktion $\varphi(N) = (p-1)(q-1) = 16 \cdot 28
   = 448$.
5. Berechnung des Entschlüsselungsexponenten $d$ als multiplikativ Inverses von
   $e$ zu $\mod \varphi(N)$, also $d \cdot e \equiv 1 \mod 448$. Das kann mit dem
   [erweiterten euklidischen Algorithmus][eea-wiki] berechnet werden.  
   Es gilt: $e \cdot d + k \cdot \varphi(N) = 1 = \text{ggT}(e, \varphi(N)$  
   Im Beispiel: $27 \cdot d + k \cdot 448 = 1 = \text{ggT}(27, 448)$  
   Mit dem erweiterten euklidischen erhält man die Faktoren $d = 83$ und $k =
   -5$ Dabei ist $d = 83$ der private Schlüssel und $k$ kann verworfen werden.

### Verschlüsselung

Für die Verschlüsselung einer Nachricht $m$ mit RSA wird die folgende Formel
verwendet.

$c \equiv m^e \mod N$

So erhält man aus der Nachricht $m$ den Chiffretext $c$. Dabei muss die Zahl $m$
kleiner als der RSA-Modul $N$ sein.

#### Beispiel

Soll nun mit dem oben erzeugten öffentlichen Schlüssel die Nachricht $42$
verschlüsselt werden kann der Ciffretext $c$ mit folgender Formel berechnet
werden.

$c \equiv 42^{27} \mod 448$

So erhält man $c = 444$

### Entschlüsselung

Der Geheimtext $c$ kann dann durch die modulare exponentiation wieder zum
Klartext $m$ entschlüsselt werden. Dafür wird die folgende Formel verwendet.

$m \equiv c^d \mod N$

#### Beispiel

So kann zum Beispiel unsere zuvor verschlüsselte Nachricht $c = 444$ mit dem
geheimen Schlüssel $d = 83$ entschlüsselt werden.

$m \equiv 444^{83} \mod 493$

So erhält man wieder die Ursprüngliche Nachricht $m = 42$ zurück.

### Signieren von Nachrichten

Dieser Verschlüsselungsprozess kann auch umgekehrt angewandt werden indem die
Nachricht mit dem privaten Schlüssel $d$ verschlüsselt wird und dann mit dem
öffentlichen Schlüssel $e$ entschlüsselt wird. Da der öffentliche Schlüssel
jedoch bekannt ist, kann jeder die Nachricht wieder entschlüsseln, weshalb diese
Methode nicht zur Geheimhaltung der Nachricht dient, sonder der Verifikation der
Authentizität und Integrität der Nachricht, denn nur der Besitzer des privaten
Schlüssels kann eine Nachricht so verschlüsseln, dass diese wieder mit dem
öffentlichen Schlüssel entschlüsselt werden kann, deshalb wird dieser Prozess
signieren genannt.

Das direkte signieren einer Nachricht ist jedoch aus sicherheitsgründen nicht
empfehlenswert, da es einem Angreifer ermöglicht die Signaturen für weitere
Nachrichten zu berechnen. Eine einfache Lösung für dieses Problem wäre es die
Nachricht vor dem signieren durch eine Hashfunktion laufen zu lassen, doch auch
dies ist heute nicht mehr als sicher genug anzusehen, weshalb andere Verfahren
wie zum Beispiel [RSA-PSS][rsa-pss-wiki] verwendet werden sollten.

## Ressourcen

[Einwegfunktion - Wikipedia][einwegfunktion-wiki]  
[Falltürfunktion - Wikipedia][falltürfunktion-wiki]  
[Erweiterter euklidischer Algorithmus - Wikipedia][eea-wiki]  
[RSA-PSS - Wikipedia][rsa-pss-wiki]  

[Ronald L. Rivest - Wikipedia][rivest-wiki]  
[Adi Shamir - Wikipedia][shamir-wiki]  
[Leonard Adleman - Wikipedia][adleman-wiki]  

[Shor-Algorithmus - Wikipedia][shor-wiki]  

[rivest-wiki]: https://de.wikipedia.org/wiki/Ronald_L._Rivest
[shamir-wiki]: https://de.wikipedia.org/wiki/Adi_Shamir
[adleman-wiki]: https://de.wikipedia.org/wiki/Leonard_Adleman
[shor-wiki]: https://de.wikipedia.org/wiki/Shor-Algorithmus
[einwegfunktion-wiki]: https://de.wikipedia.org/wiki/Einwegfunktion
[falltürfunktion-wiki]: https://de.wikipedia.org/wiki/Einwegfunktion#Einwegfunktionen_mit_Fallt%C3%BCr_(Trapdoor-Einwegfunktionen)
[fermat-zahl-wiki]: https://de.wikipedia.org/wiki/Fermat-Zahl
[eea-wiki]: https://de.wikipedia.org/wiki/Erweiterter_euklidischer_Algorithmus
[rsa-pss-wiki]: https://de.wikipedia.org/wiki/Probabilistic_Signature_Scheme
