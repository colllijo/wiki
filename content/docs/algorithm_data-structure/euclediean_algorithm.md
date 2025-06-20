---
weight: 3500
title: "Euklidischer Algorithmus"
description: |
  Dokumentation zum euklidischen und dem erweiterten euklidischen Algorithmus.
icon: "article"
date: "2025-05-14T09:11:15+02:00"
lastmod: "2025-05-14T09:11:15+02:00"
draft: false
toc: true
katex: true
---

## Einführung

Der euklidische Algorithmus ist ein Algorithmus zur Berechnung des grössten
gemeinsamen Teilers $\text{ggT}(a, b)$ zweier natürlicher Zahlen $a$ und $b$.
Der Algorithmus wurde nach dem griechischen Mathematiker [Euklid][euclid-wiki]
benannt, der ihn in seinem Werk "Die Elemente" beschrieb. Der Algorithmus ist
dabei das schnellste bekannte Verfahren zu Berechnung des grössten gemeinsamen
Teilers, insofern, die Primfaktorzerlegung der Zahlen nicht bekannt ist.

## Ursprüngliches Verfahren

> Wenn CD aber AB nicht misst, und man nimmt bei AB, CD abwechselnd immer das
> kleinere vom grösseren weg, dann muss eine Zahl übrig bleiben, die die
> vorangehende misst.  
> \- *Euklid, Die Elemente, Buch VII, Satz 2*

{{< split type="start" size="1fr auto" >}}

[Euklid][euclid-wiki] berechnet den grössten gemeinsamen Teiler, indem er nach
einem "Mass" für die Länge zweier Strecken sucht. Dazu wird wiederholt die
kürzere Strecke von der längeren Strecke abgezogen, bis die beiden Strecken
gleich lang sind. Diese Länge ist dann der grösste gemeinsame Teiler der beiden
ursprünglichen Strecken.

Dieser Algorithmus funktioniert sehr gut für kleinere Zahlen, sobald die
Differenz der beiden Strecken jedoch grösser wird, benötigt der klassische
Algorithmus sehr viele Schritte, um den grössten gemeinsamen Teiler zu
ermitteln.  
Aus diesem Grund wird heute eine abgewandelte Form des Algorithmus verwendet,
welcher anstelle von Subtraktion die Division mit Rest (Modulo) verwendet. So
kann der Algorithmus neben den natürlichen Zahlen auch auf jeglichen
Zahlengruppen angewendet werden, die eine Division mit Rest gemäss den
natürlichen Zahlen definieren.

{{< split >}}

{{< figure
  src="https://upload.wikimedia.org/wikipedia/de/thumb/f/fb/Euklidischer_Algorithmus.png/330px-Euklidischer_Algorithmus.png"
  caption="Beispiel des euklidischen Algorithmus.<br>Quelle: Wikipedia"
  alt="Beispiel des euklidischen Algorithmus"
>}}

{{< split type="end" >}}

## Moderner Euklidischer Algorithmus

Heutzutage wird die Subtraktion eines Werts im klassischen Algorithmus durch
eine einzige Division mit Rest ersetzt. Diese Division wird so lange wiederholt,
bis der Rest $0$ beträgt. Der letzte Rest grösser als $0$ ist dann der grösste
gemeinsame Teiler. Dabei wird im ersten Schritt eine Division mit Rest für
$a \div b$.

$a = b \cdot q_1 + r_1$

Für die folgenden Schritte wird die Division mit Rest für den vorherig Divisor
durch den vorherigen Rest durchgeführt.

$b = r_1 \cdot q_2 + r_2$  
$r_1 = r_2 \cdot q_3 + r_3$  
$r_2 = r_3 \cdot q_4 + r_4$  
$\hspace{5mm}\vdots$  
$r_{n-1} = r_n \cdot q_{n+1} + 0$  

**Beispiel**

So wird Beispielhaft der grösste gemeinsame Teiler von $\textcolor{red}{2432}$
und $\textcolor{blue}{342}$ wie folgt berechnet:

$\textcolor{red}{2432} = \textcolor{blue}{342} \cdot 7 +
\textcolor{green}{38}$  
$\textcolor{blue}{342} = \textcolor{green}{38} \cdot 9 +
\textcolor{yellow}{0}$  

Der grösste gemeinsame Teiler von $\textcolor{red}{2432}$ und
$\textcolor{blue}{342}$ ist also $\textcolor{green}{38}$.

### Programmcode

{{< expand open="true" title="Implementation des euklidischen Algorithmus in C" >}}

{{< prism lang="c" line-numbers="true" >}}

#include <stdio.h>

int gcd(int a, int b)
{
  while (b != 0)
  {
    int r = a % b;
    a = b;
    b = r;
  }

  return a;
}

int main()
{
  int a = 2432;
  int b = 342;

  printf("%d\n", gcd(a, b));

  return 0;
}

{{< /prism >}}

{{< /expand >}}

### Steinscher Algorithmus

Als Erweiterung zum euklidischen Algorithmus wurde 1967 der steinsche
Algorithmus durch den Physiker Josef Stein vorgestellt. Dieser wird auch
binärer euklidischer Algorithmus genannt und bietet eine Verbesserte Laufzeit
auf Computern, da diese zur Basis 2 operieren.

Der Algorithmus nutzt folgende Rechenregeln:

**Falls b = 0:**

- $$\text{ggT}(a, 0) = a$$

**Falls b = ungerade:**

- {{< katex >}}
\[
  \text{ggT}(a, b) =
  \begin{cases}
    \text{ggT}(a, b - a) & \text{falls } b \geq a, \\
    \text{ggT}(b, a - b) & \text{sonst}
  \end{cases}
\]
  {{< /katex >}}

**Falls b = gerade:**

- {{< katex >}}
  \[
    \text{ggT}(a, b) =
    \begin{cases}
      \text{ggT}(a, b / 2) & \text{falls a ungerade}, \\
      \text{ggT}(b / 2, b / 2) \cdot 2 & \text{sonst}
    \end{cases}
  \]
  {{< /katex >}}

#### Programmcode

{{< expand open="true" title="Implementation des euklidischen Algorithmus in C" >}}

{{< prism lang="c" line-numbers="true" >}}

#include <stdio.h>
#include <stdlib.h>

int gcd(int a, int b)
{
  a = abs(a);
  b = abs(b);

  if (a == 0 || b == 0)
  {
    return a || b;
  }

  // Remove common factors of 2
  int k = 0;
  while (!((a & 1) && (b & 1)))
  {
    a >>= 1;
    b >>= 1;
    k++;
  }

  // Iterate until a and b are equal and thus the GCD is found
  while (a != b)
  {
    if (!(a & 1)) a >>= 1;
    else if (!(b & 1)) b >>= 1;
    // The result of the subtraction is always even as a and b are odd therefore it can immediatly be halved.
    else if (a > b) a = (a - b) >> 1;
    else b = (b - a) >> 1;
  }

  return a << k;
}

int main()
{
  int a = 209865;
  int b = 209797;

  printf("%d\n", gcd(a, b));

  return 0;
}

{{< /prism >}}

{{< /expand >}}

### Euklidischer Algorithmus für mehr als zwei Zahlen

Der euklidische Algorithmus kann auch verwendet werden, um den grössten
gemeinsamen Teiler von mehr als zwei Zahlen zu berechnen. Dazu wird der
$\text{ggT}$ Algorithmus wiederholt aufgerufen, wobei die erste Parameter das
Resultat der vorherigen Operation ist und der zweite die nächste Zahl ist.
Das heisst es gelten das Assoziativgesetz und das Kommutativgesetz, so gelten
für die beliebige natürliche Zahlen $a, b, c$.

$\text{ggT}(a, b, c) = \text{ggT}(\text{ggT}(a, b), c) =
\text{ggT}(a, \text{ggT}(b, c)) = \text{ggT}(\text{ggT}(a, c), b)$

## Erweiterter Euklidischer Algorithmus

Aus dem euklidischen Algorithmus entstand später der
[erweiterte euklidische Algorithmus][eea-wiki]. Dieser berechnet neben dem
grössten gemeinsamen Teiler zweier natürlicher Zahlen $a$ und $b$ noch zwei
Weitere ganze Zahlen $s$ und $t$, welche die folgende Gleichung erfüllen:

$\text{ggT}(a, b) = s \cdot a + t \cdot b$

Dieser wird meist nicht zur Berechnung des grössten gemeinsamen Teilers sonder
zur Bestimmung von inversen Elementen in [ganzzahligen Restklassenringen][prkg-wiki].
Dies stammt aus dem Fakt das wenn der Algorithmus das Triple $(d = \text{ggT}(a,b),
s, t)$ ermittelt, ist entweder $d = 1$ und somit gilt $1 \equiv t \cdot b \pmod
a$. $t$ ist also das multiplikative Inverse von $b \text{mod} a$ oder $d \neq 1$,
was bedeutet, dass $b \text{mod} a$ kein multiplikatives Inverses hat.

Das mutliplikative Inverse findet vor allem in der Kryptographie Anwendung, kann
jedoch in gewissen Fällen auch verwendet werden um die Division von Nummern in
Computersystem zu beschleunigen, falls diese keine Hardware Division
unterstützen, da die Berechnung des multiplikativen Invers und ein
Multiplikation schneller als eine Software Division sein kann. Das multiplikateive
Inverse wird auch für den [chinesischen Restsatz][chinese_remainder_theorem-wiki]
benötigt.

### Funktionsweise

Der erweiterte euklidische Algorithmus funktioniert ähnlich dem modernen
euklidischen Algorithmus, fügt jedoch zwei weitere Sequenzen hinzu.

{{< katex >}}

\[
\begin{array}{rl}
  r_0 = a \quad&\quad r_1 = b \\
  s_0 = 1 \quad&\quad s_1 = 0 \\
  t_0 = 0 \quad&\quad t_1 = 1 \\
  \vdots \quad&\quad \vdots \\
  r_{i + 1} = r_{i - 1} - q_i \cdot r_i \quad&\quad \text{und} 0 \leq r_{i + 1} < \lvert r_i \rvert \\
  s_{i + 1} = s_{i - 1} - q_i \cdot s_i \quad \\
  t_{i + 1} = t_{i - 1} - q_i \cdot t_i \quad \\
  \vdots \quad
\end{array}
\]

{{< /katex >}}

Die Berechnung endet sobald $r_{k + 1} = 0$ ist. In diesem Fall treffen folgende
Aussagen zu:

- $r_k$ ist der grösste gemeinsame Teiler von $a = r_0$ und $b = r_1$.
- $s_k$ und $t_k$ sind die gesuchten Zahlen, welche die Gleichung
  $\text{ggT}(a, b) = s \cdot a + t \cdot b$ erfüllen.

### Programmcode

{{< expand open="true" title="Implementation des erweiterten euklidischen Algorithmus in C++" >}}

{{< prism lang="cpp" line-numbers="true" >}}

#include <iostream>
#include <tuple>

std::tuple<int, int, int> gcd(int a, int b)
{
	int r0 = a, r1 = b;
	int s  = 1, t  = 0;
	int s1 = 0, t1 = 1;

	while (r1)
	{
		int q = r0 / r1;
		std::tie(s, s1) = std::make_tuple(s1, s - q * s1);
		std::tie(t, t1) = std::make_tuple(t1, t - q * t1);
		std::tie(r0, r1) = std::make_tuple(r1, r0 - q * r1);
	}

	return std::make_tuple(r0, s, t);
}

int main()
{
	int a = 30, b = 97;
	auto [d, s, t] = gcd(a, b);

	std::cout << "gcd(" << a << ", " << b << ") = " << d << " = " << s << " * " << a << " + " << t << " * " << b << std::endl;

	return 0;
}

{{< /prism >}}

{{< /expand >}}

## Ressourcen

[Euklidischer Algorithmus - Wikipedia][euclidean_algorithm-wiki]  
[Steinscher Algorithmus - Wikipedia][binary-gcd-wiki]  
[Erweiterter Euklidischer Algorithmus - Wikipedia][eea-wiki]  

[euclidean_algorithm-wiki]: https://de.wikipedia.org/wiki/Euklidischer_Algorithmus
[euclid-wiki]: https://de.wikipedia.org/wiki/Euklid
[binary-gcd-wiki]: https://de.wikipedia.org/wiki/Steinscher_Algorithmus
[eea-wiki]: https://de.wikipedia.org/wiki/Erweiterter_euklidischer_Algorithmus
[prkg-wiki]: https://de.wikipedia.org/wiki/Prime_Restklassengruppe
[chinese_remainder_theorem-wiki]: https://de.wikipedia.org/wiki/Chinesischer_Restsatz
