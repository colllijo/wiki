---
weight: 8201
title: "RSA - Encryption"
description: |
  Documentation on asymmetric RSA encryption
icon: "article"
date: "2025-04-09T08:56:18+02:00"
lastmod: "2025-04-09T08:56:18+02:00"
draft: false
toc: true
katex: true
---

## Introduction

RSA (Rivest-Shamir-Adelman) is named after the three mathematicians who
developed developed the algorithm. [Ronald L. Rivest][rivest-wiki],
[Adi Shamir][shamir-wiki] and [Leonard Adleman][adleman-wiki]. RSA is an
asymmetric cryptographic algorithm that is used for encryption and digital
signatures. As an asymmetric algorithm, it uses a keypair consisting of a public
and a private key. Where the public key can reverse the encryption of the
private key and the inverse. The security of RSA is based on keeping the private
key secret and the impossibility of calculating the private key from the public
key. Which given modern computing power is not yet possible in a realistic
timeframe.  
See also [Shor's algorithm][shor-wiki].

## Algorithm

To encrypt a message, RSA uses a one-way permutation with a trapdoor. A
[one-way function][onewayfunction-wiki] is a function that is easy to compute
but whose inverse is very difficult to compute. RSA uses the multiplication of
large prime numbers as a one-way function. Because the prime factorization
(The inverse function of prime number multiplication) of large numbers is by
today's knowledge very expensive. A one-way function has a
[trapdoor][trapdoorfunction-wiki] if there is a secret information that allows
the inverse of the function to be computed trivially. In RSA this is the private
key.

### Key Generation

They keys for the RSA algorithm consist of the three numbers: $e$, $d$ and $N$.
Here, $N$ is the RSA modulus, $e$ is the encryption exponent, and $d$ is the
decryption exponent. The pair $(e, N)$ forms the public key, and $(d, N)$ forms
the private key. These numbers are generated using the following procedure:

1. Two stochastically independent prime numbers $p$ and $q$ are chosen such that
   $p \neq q$. Additionally, these numbers should have the same order of
   magnitude, satisfying the confition $0.1 < \lvert \log_2(p) - \log_2(q)
   \rvert < 30$.
2. Compute the RSA modulus $N = p \cdot q$.
3. Compute Euler's totient function $\varphi(N) = (p-1)(q-1)$.
4. Choose a number $e$ that is coprime to $\varphi(N)$ and satisfies $1 < e
   < \varphi(N)$.
5. Compute the decryption exponent $d$ as the modular multiplicative inverse of
   $e$ with respect to $\varphi(N)$, such that $d \cdot e \equiv 1 \mod
   \varphi(N)$.

The numbers $p$, $q$ and $\varphi(N)$ are no longer needed after key generation
and can be deleted. However, $p$, $q$, $\varphi(N)$, and $d$ must be kept
secret, as they can be used to reconstruct the private key.

Generating two stochastically independent prime numbers means that the choice of
the first prime $p$ must not statistically influence the choice of the second
prime $q$.

Nowdays, prime number tests are fast enough that the order of key generation can
be slightly modified. First, the exponent $e$ is chosen with the condition
$2^{16} < e < 2^{64}$ and the primes $p$ and $q$ are discarded until $p -1$ and
$q - 1$ are coprime to $e$. It is important that $e$ is greater than the
[Fermat number][fermat-number-wiki] $F_4 = 2^{2^4} + 1 = 65537$ to prevent
potential attacks. If $d$ has fewer than a quarter of the bits of the RSA
modulus $N$, it is possible to efficiently determine $d$, which is why the upper
limit $2^{64}$ for $e$ is chosen to exclude this possibility.

#### Example

This example uses the modified method where the decryption exponent $e$ is
chosen first.

1. Choose the exponent $e = 27$.
2. Choose $p = 17$ and $q = 29$, where $p - 1 = 16$ and $q - 1 = 28$ are coprime
   to $e$.
3. Compute the RSA modulus $N = 17 \cdot 29 = 493$.
4. Compute Euler's totient function $\varphi(N) = (p-1)(q-1) = 16 \cdot 28 =
   448$.
5. Compute the decryption exponent $d$ as the modular multiplicative inverse of
   $e$ modulo $\varphi(N)$, such that $d \cdot e \equiv 1 \mod 448$. This can be
   calculated using the [extended Euclidean algorithm][eea-wiki].  
   For example: $e \cdot d + k \cdot \varphi(N) = 1 = \text{gcd}(e,
   \varphi(N))$ In this case: $27 \cdot d + k \cdot 448 = 1 =
   \text{gcd}(27, 448)$ Using the extended Euclidean algorithm, we find $d
   = 83$ and $k = -5$. Here, $d = 83$ is the private key, and $k$ can be
   discarded.

### Encryption

To encrypt a message $m$ with RSA, the following formula is used:

$c \equiv m^e \mod N$

This transforms the message $m$ into the ciphertext $c$. The number $m$ must be
smaller than the RSA modulus $N$.

#### Example

Using the public key generated above, the message $42$ can be encrypted to
produce the ciphertext $c$ using the formula:

$c \equiv 42^{27} \mod 448$

This results in $c = 444$.

### Decryption

The ciphertext $c$ can be decrypted back to the plaintext $m$ using modular
exponentiation with the following formula:

$m \equiv c^d \mod N$

#### Example

For example, the previously encrypted message $c = 444$ can be decrypted using
the private key $d = 83$:

$m \equiv 444^{83} \mod 493$

This recovers the original message $m = 42$.

### Signing Messages

This encryption process can also be reversed by encrypting the message with the
private key $d$ and then decrypting it with the public key $e$. Since the public
key is known, anyone can decrypt the message, so this method does not ensure
confidentiality. Instead, it verifies the authenticity and integrity of the
message, as only the owner of the private key can encrypt a message that can be
decrypted with the public key. This process is called signing.

Directly signing a message is not recommended for security reasons, as it allows
an attacker to compute signatures for other messages. A simple solution to this
problem is to hash the message before signing it. However, even this is no
longer considered secure enough, so other methods, such as
[RSA-PSS][rsa-pss-wiki], should be used.

## Resources

[One-way function - Wikipedia][onewayfunction-wiki]  
[Trapdoor function - Wikipedia][trapdoorfunction-wiki]  
[Extended euclidean algorithm - Wikipedia][eea-wiki]  
[RSA-PSS - Wikipedia][rsa-pss-wiki]  

[Ronald L. Rivest - Wikipedia][rivest-wiki]  
[Adi Shamir - Wikipedia][shamir-wiki]  
[Leonard Adleman - Wikipedia][adleman-wiki]  

[Shor's algorithm - Wikipedia][shor-wiki]  

[rivest-wiki]: https://en.wikipedia.org/wiki/Ron_Rivest
[shamir-wiki]: https://en.wikipedia.org/wiki/Adi_Shamir
[adleman-wiki]: https://en.wikipedia.org/wiki/Leonard_Adleman
[shor-wiki]: https://en.wikipedia.org/wiki/Shor%27s_algorithm
[onewayfunction-wiki]: https://en.wikipedia.org/wiki/One-way_function
[trapdoorfunction-wiki]: https://en.wikipedia.org/wiki/Trapdoor_function
[fermat-number-wiki]: https://en.wikipedia.org/wiki/Fermat_number
[eea-wiki]: https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm
[rsa-pss-wiki]: https://en.wikipedia.org/wiki/Probabilistic_signature_scheme
