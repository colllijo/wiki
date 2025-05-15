---
weight: 3400
title: "Euclidean algorithm"
description: |
  Documentation about the euclidean and extended euclidean algorithm.
icon: "article"
date: "2025-05-14T09:11:22+02:00"
lastmod: "2025-05-14T09:11:22+02:00"
draft: false
toc: true
katex: true
---

## Introduction

The euclidean algorithm is an algorithm for calculating the gratest common
divisor $\text{GCD}(a, b)$ of two natural numbers $a$ and $b$. The algorithm is
named after the greek mathematician [Euclid][euclid-wiki], who described it in his
work "The Elements". The algorithm is the fastest known method for calculating
the greatest common divisor, as long as the prime factorization of the numbers
is not known.

## Traditional method

> When CD does not measure AB, and one takes from AB, CD alternately always the
> shorter from the larger, then a number must remain that measures the
> preceding.  
> \- Euclid, The Elements, Book VII, Proposition 2

{{< split type="start" size="1fr auto" >}}

[Euclid][euclid-wiki] calculates the greatest common divisor by looking for a
"measure" for the length of two segments. To do this, the shorter segment is
subtracted from the longer segment until the two segments are equal in length.
This length is then the greatest common divisor of the two original segments.

This algorithm works very well for smaller numbers, but as the difference
between the two segments increases, the classical algorithm requires many steps
to calculate the greatest common divisor.  
For this reason, a modified form of the algorithm is used today, which uses
Division with remainder (modulo) instead of subtraction. This allows the
algorithm to be applied to any number group that defines a division with
remainder according to the natural numbers.

{{< split >}}

{{< figure
  src="https://upload.wikimedia.org/wikipedia/de/thumb/f/fb/Euklidischer_Algorithmus.png/330px-Euklidischer_Algorithmus.png"
  caption="Example of the euclidean algorithm.<br>Source: Wikipedia"
  alt="Example of the euclidean algorithm"
>}}

{{< split type="end" >}}

## Modern euclidean algorithm

Nowdays, the subtraction of a value from the classical algorithm is replaced by
a single division with remainder. These Divisions are repeated until the remainder
is $0$. The last non-zero remainder is then the greatest common divisor. The
algorithm starts in the first step with the calculation the quotient and remainder
of $a \div b$.

$a = b \cdot q_1 + r_1$

For the following steps, the division with remainder is done using the previous
dividor divided by teh previsou remainder.

$b = r_1 \cdot q_2 + r_2$  
$r_1 = r_2 \cdot q_3 + r_3$  
$r_2 = r_3 \cdot q_4 + r_4$  
$\hspace{5mm}\vdots$  
$r_{n-1} = r_n \cdot q_{n+1} + 0$  

**Example**

As an example, the greatest common divisor of $\textcolor{red}{2432}$ and
$\textcolor{blue}{342}$ is calculated as follows:

$\textcolor{red}{2432} = \textcolor{blue}{342} \cdot 7 +
\textcolor{green}{38}$  
$\textcolor{blue}{342} = \textcolor{green}{38} \cdot 9 +
\textcolor{yellow}{0}$  

The greatest common divisor of $\textcolor{red}{2432}$ and $\textcolor{blue}{342}$
is $\textcolor{green}{38}$.

### Implementation

{{< expand open="true" title="Implementation of the euclidean algorithm in C" >}}

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

### Stein's algorithm

In 1967 the physicist Josef Stein presented an extended Version of the algorithm
also know as binary GCD algorithm. This algorithm provides a better runtime on
computers which operate on base 2.

The algorithm defines the following rules:

**If b = 0:**

- $$\text{GCD}(a, 0) = a$$

**If b = odd:**

- {{< katex >}}
\[
  \text{GCD}(a, b) =
  \begin{cases}
    \text{GCD}(a, b - a) & \text{if } b \geq a, \\
    \text{GCD}(b, a - b) & \text{else}
  \end{cases}
\]
  {{< /katex >}}

**If b = even:**

- {{< katex >}}
  \[
    \text{GCD}(a, b) =
    \begin{cases}
      \text{GCD}(a, b / 2) & \text{if a odd}, \\
      \text{GCD}(b / 2, b / 2) \cdot 2 & \text{else}
    \end{cases}
  \]
  {{< /katex >}}

#### Implementation

{{< expand open="true" title="Implementation of the binary GCD algorithm in C" >}}

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

### GCD for more than two numbers

The euclidean algorithm can be extended to calculate the greatest common divisor
of more than two numbers. For this the $\text{GCD}$ function is applied
recursively which means that the GCD of the first two numbers is calculated and
then that value is used to calculate the GCD with the next number until the final
GCD is reached.  
This works because the GCD due to the associative and commutative property of the
algorithm. For arbitrary numbers $a_1, a_2, \ldots, a_n$ the following applies:

$\text{ggT}(a, b, c) = \text{ggT}(\text{ggT}(a, b), c) =
\text{ggT}(a, \text{ggT}(b, c)) = \text{ggT}(\text{ggT}(a, c), b)$

## Extended euclidean algorithm

The [Extended Euclidean Algorithm][eea-wiki] is derived from the Euclidean Algorithm.
In addition to calculating the greatest common divisor (GCD) of two natural numbers
\(a\) and \(b\), it also computes two additional integers \(s\) and \(t\) that satisfy
the following equation:

\[
\text{GCD}(a, b) = s \cdot a + t \cdot b
\]

This algorithm is primarily used not for finding the GCD but for determining inverse
elements in [integer residue classes][prkg-wiki]. This is based on the fact that
if the algorithm determines the triple \((d = \text{GCD}(a, b), s, t)\), then either
\(d = 1\), which implies \(1 \equiv t \cdot b \pmod{a}\). Here, \(t\) is the multiplicative
inverse of \(b \mod a\), or \(d \neq 1\), which means \(b \mod a\) does not have
a multiplicative inverse.

The multiplicative inverse is particularly useful in cryptography but can also be
used in certain cases to speed up division in computer systems that lack hardware
division support. This is because calculating the multiplicative inverse and performing
a multiplication can be faster than a software-based division. The multiplicative
inverse is also required for the [Chinese Remainder Theorem][chinese_remainder_theorem-wiki].

### Functionality

The Extended Euclidean Algorithm works similarly to the modern Euclidean Algorithm
but adds two additional sequences.

\[
\begin{array}{rl}
  r_0 = a \quad&\quad r_1 = b \\
  s_0 = 1 \quad&\quad s_1 = 0 \\
  t_0 = 0 \quad&\quad t_1 = 1 \\
  \vdots \quad&\quad \vdots \\
  r_{i + 1} = r_{i - 1} - q_i \cdot r_i \quad&\quad \text{and} \ 0 \leq r_{i + 1} < \lvert r_i \rvert \\
  s_{i + 1} = s_{i - 1} - q_i \cdot s_i \quad \\
  t_{i + 1} = t_{i - 1} - q_i \cdot t_i \quad \\
  \vdots \quad
\end{array}
\]

The calculation ends when \(r_{k + 1} = 0\). At this point, the following statements
hold true:

- \(r_k\) is the greatest common divisor of \(a = r_0\) and \(b = r_1\).
- \(s_k\) and \(t_k\) are the integers that satisfy the equation \(\text{GCD}(a, b) = s \cdot a + t \cdot b\).

### Implementation

{{< expand open="true" title="Implementation of the extended euclidean algorithm in C++" >}}

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

## Resources

[Euclidean algorithm - Wikipedia][euclidean_algorithm-wiki]  
[Binary GCD algorithm - Wikipedia][binary-gcd-wiki]  
[extended euclidean algorithm - Wikipedia][eea-wiki]  

[euclidean_algorithm-wiki]: https://en.wikipedia.org/wiki/Euclidean_algorithm
[euclid-wiki]: https://en.wikipedia.org/wiki/Euclid
[binary-gcd-wiki]: https://en.wikipedia.org/wiki/Binary_GCD_algorithm
[eea-wiki]: https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm
[prkg-wiki]: https://en.wikipedia.org/wiki/Prime_residue_group
[chinese_remainder_theorem-wiki]: https://en.wikipedia.org/wiki/Chinese_remainder_theorem
