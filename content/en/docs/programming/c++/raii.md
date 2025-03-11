---
weight: 5502
title: "RAII"
description: |
  Information and example about Resource Acquisition Is Initialization (RAII).
icon: "article"
date: "2025-03-11T14:52:28+01:00"
lastmod: "2025-03-11T14:52:28+01:00"
draft: false
toc: true
---

## Resource acquisition is initialization (RAII)

Resource acquisition is initialization, or RAII, is a programming idiom used in
various programming languages, especially C++, to manage resources safely.  
It ensures that resource acquisition is part of the initialization of the class
and the release of resources is part of the destructor. This binds the resource
to the lifecycle of the object. This means that the object can only be created
if the resource has been acquired and it is guaranteed that the resource will be
released with the end of the object.

This automatic release only works for objects declared on the stack. For objects
declared on the heap, it must be ensured that they are released again in every
path of the program. This can be achieved, for example, by using smart pointers.

## Example

To show this a bit more clearly, here is an example. In the following program
a network communication should take place using a socket.

Here is a situation that does not use RAII:

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

This example show that releasing resources is not easy, because we have to call
the functions `freeaddrinf(res);` and `close(sockfd);` depending on the path of
program execution in three different places. If we forget to call one of these
functions, we have a resource leak.

To simplify this and avoid a resource leak, we can use RAII. For this we
encapsulate the resources in classes, which implement RAII, thus relive use
from needing to manually free the resources in `main`.


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

In the above code the `freeaddrinfo(res);` and `close(sockfd);` functions are
called in the destructors of the wrapper classes `AddrInfo` and `Socket`. This
replaces the need to call these manually and ensures that they are called when
destroying the objects.

## Resources

[RAII - Wikipedia][raii-wiki]  

[raii-wiki]: https://en.wikipedia.org/wiki/Resource_acquisition_is_initialization
