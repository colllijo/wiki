---
weight: 5502
title: "RAII"
description: |
  Informationen und Beispiel zu Resource Acquisition Is Initialization (RAII).
icon: "article"
date: "2025-03-11T14:52:24+01:00"
lastmod: "2025-03-11T14:52:24+01:00"
draft: false
toc: true
---

## Resource acquisition is initialization (RAII)

Resource acquisition is initialization, zu deutsch Ressourcenbelegung ist
Initialisierung, ist ein Programmier-Idiom, welches in unterschiedlichen
Programmiersprachen, vor allem C++ verwendet wird um Ressourcen sicher zu
verwalten.  
Dabei wird sichergestellt, dass die Ressourcenbelegung als Teil der
Initialisierung der dafür zuständigen Klasse als Teil des Konstruktors erfolgt.
Die Freigabe der Ressourcen erfolgt dann als Teil des Destruktors. Dadurch wird
die Ressource klar an den Lebenszyklus des Objektes gebunden. So kann das Objekt
nur erstellt werden kann wenn auch die Ressource erworben wurde und es
ist garantiert, dass die Ressource mit dem Ende des Objekts wieder freigegeben
wird.

Diese automatische Freigabe funktioniert jedoch nur bei Objekten, welche auf
dem Stack deklariert wurden. Bei Objekten, welche auf dem Heap deklariert wurden
muss sichergestellt werden, dass diese in jedem Pfad des Programmes wieder
freigegeben werden. Dies kann zum Beispiel durch die Verwendung von Smart
Pointern erreicht werden.

## Beispiel

Um das ganze etwas verständlicher aufzuzeigen hier ein Beispiel. Im folgenden
Programmausschnitt sollen mithilfe eines Sockets eine Netzwerkkommunikation
stattfinden.

Hier ist eine Ausgansitation, welche RAII nicht verwendet:

{{< expand open="true" title="HTTP Request without RAII" >}}

{{< prism lang="cpp" line-numbers="true" >}}

#include <iostream>
#include <string>
#include <cstring>
#include <unistd.h>
#include <sys/socket.h>
#include <netdb.h>

int main() {
    const char* hostname = "www.example.com";
    const char* port = "80";
    const char* request = "GET / HTTP/1.1\r\nHost: www.example.com\r\nConnection: close\r\n\r\n";

    struct addrinfo hints, *res;
    int sockfd;

    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(hostname, port, &hints, &res) != 0) {
        std::cerr << "getaddrinfo failed" << std::endl;
        return 1;
    }

    sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sockfd == -1) {
        std::cerr << "socket creation failed" << std::endl;
        freeaddrinfo(res);
        return 1;
    }

    if (connect(sockfd, res->ai_addr, res->ai_addrlen) == -1) {
        std::cerr << "connection failed" << std::endl;
        close(sockfd);
        freeaddrinfo(res);
        return 1;
    }

    freeaddrinfo(res);

    if (send(sockfd, request, strlen(request), 0) == -1) {
        std::cerr << "send failed" << std::endl;
        close(sockfd);
        return 1;
    }

    char buffer[4096];
    ssize_t bytes_received;
    while ((bytes_received = recv(sockfd, buffer, sizeof(buffer) - 1, 0)) > 0) {
        buffer[bytes_received] = '\0';
        std::cout << buffer;
    }

    if (bytes_received == -1) {
        std::cerr << "recv failed" << std::endl;
    }

    close(sockfd);
    return 0;
}

{{< /prism >}}

{{< /expand >}}

An diesem Beispiel wird deutlich, dass die Freigabe der Ressourcen nicht einfach
ist, denn wir müssen die Funktion `freeaddrinfo(res);` und `close(sockfd);`
je nach Pfad des Programmes an unterschiedlichen Stellen aufrufen. Vergessen
wir an einem Pfad diese Funktionen aufzurufen, so entsteht ein Memory Leak oder
unsere Applikation hält die Ressourcen unnötig lange belegt.

Um dies zu vereinfachen können wir RAII verwenden. Dazu verschachteln wir die
Ressourcen in Klassen, welche RAII implementieren wodurch wir die Ressourcen
nicht mehr in der `main` Funktion freigeben müssen.

{{< expand open="true" title="HTTP Request with RAII" >}}

{{< prism lang="cpp" line-numbers="true" >}}

#include <iostream>
#include <string>
#include <cstring>
#include <unistd.h>
#include <sys/socket.h>
#include <netdb.h>

class AddrInfo {
public:
    AddrInfo(const char* hostname, const char* port) : res(nullptr) {
        struct addrinfo hints;
        memset(&hints, 0, sizeof(hints));
        hints.ai_family = AF_UNSPEC;
        hints.ai_socktype = SOCK_STREAM;

        if (getaddrinfo(hostname, port, &hints, &res) != 0) {
            throw std::runtime_error("getaddrinfo failed");
        }
    }

    ~AddrInfo() {
        if (res) {
            freeaddrinfo(res);
        }
    }

    struct addrinfo* get() const {
        return res;
    }

private:
    struct addrinfo* res;
};

class Socket {
public:
    Socket(const char* hostname, const char* port) : addrInfo(hostname, port) {
        sockfd = socket(addrInfo.get()->ai_family, addrInfo.get()->ai_socktype, addrInfo.get()->ai_protocol);
        if (sockfd == -1) {
            throw std::runtime_error("socket creation failed");
        }

        if (connect(sockfd, addrInfo.get()->ai_addr, addrInfo.get()->ai_addrlen) == -1) {
            throw std::runtime_error("connection failed");
        }
    }

    ~Socket() {
        if (sockfd != -1) {
            close(sockfd);
        }
    }

    ssize_t send(const void* buf, size_t len, int flags) {
        ssize_t bytes_sent = ::send(sockfd, buf, len, flags);
        if (bytes_sent == -1) {
            throw std::runtime_error("send failed");
        }
        return bytes_sent;
    }

    ssize_t recv(void* buf, size_t len, int flags) {
        ssize_t bytes_received = ::recv(sockfd, buf, len, flags);
        if (bytes_received == -1) {
            throw std::runtime_error("recv failed");
        }
        return bytes_received;
    }

private:
    int sockfd;
    AddrInfo addrInfo;
};

int main() {
    try {
        const char* hostname = "www.example.com";
        const char* port = "80";
        const char* request = "GET / HTTP/1.1\r\nHost: www.example.com\r\nConnection: close\r\n\r\n";

        Socket socket(hostname, port);
        socket.send(request, strlen(request), 0);

        char buffer[4096];
        ssize_t bytes_received;
        while ((bytes_received = socket.recv(buffer, sizeof(buffer) - 1, 0)) > 0) {
            buffer[bytes_received] = '\0';
            std::cout << buffer;
        }
    } catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}

{{< /prism >}}

{{< /expand >}}

Im obigen Code werden die `freeaddrinfo(res);` und `close(sockfd);` Funktionen
durch die Destruktoren der Wrapper-Klassen `AddrInfo` und `Socket` ersetzt. So
müssen wir diese nicht mehr manuell aufrufen, sondern haben eine Garantie, dass
diese bei der Zerstörung der Objekte aufgerufen werden.

## Ressourcen

[RAII - Wikipedia][raii-wiki]  

[raii-wiki]: https://de.wikipedia.org/wiki/Ressourcenbelegung_ist_Initialisierung
