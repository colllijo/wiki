---
weight: 7110
title: "Cross-Origin Resource Sharing"
description: "Dokumentation zu Cross-Origin Resource Sharing (CORS)"
icon: "share"
date: "2024-11-04T16:13:39+01:00"
lastmod: "2024-11-04T16:13:39+01:00"
draft: false
toc: true
---

## Einführung

Das `Cross-Origin Resource Sharing`, ist ein Mechanismus mit welchem Websites
Ausnahmen für die Same-Origin-Policy definieren können. Dies ermöglicht es
ausgewählten Webapplikation mittels clientseitigen Skriptsprachen, wie
JavaScript und CSS auf die eigenen Ressourcen zugreifen zu können.  
Dadurch ist es immer noch Möglich Ressourcen von anderen Domains zu laden ohne
auf Seiten der Sicherheit Abstriche machen zu müssen.

### Beispiel

Der JavaScript Code der Seite `https://cat.com` möchte die [`fetch() API`](https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch)
benutzen um eine JSON Datei von der Seite `https://dog.com` zu laden. Damit
diese in einer Tabelle angezeigt werden können.  
Aus Sicherheitsgründen wird diese Anfrage normalerweise durch die
Same-Origin-Policy blockiert.  
Wenn die Seite `https://dog.com` jedoch die entsprechenden CORS Header gesetzt
hat, so kann die Anfrage trotzdem durchgeführt werden.

{{< figure
  src="/docs/images/security/web/cors-example.svg"
  width="840px"
  class="text-center"
  alt="Graphik, welches ein CORS-Request aufzeigt"
>}}

## CORS Headers

CORS Funktioniert mittels spezifischer HTTP Header. Diese Header werden vom
Server den Antworten hinzugefügt und dann vom User Agent, aka dem Browser,
ausgewertet, dieser entscheidet, dann ob die Anfrage erlaubt ist oder nicht.
Je nach Request des Clients entscheidet der User Agent ob dies eine einfaches
Request oder nicht ist. Falls es sich um eine einfaches Request handelt kann er
dieses direkt versenden, ist dies jedoch nicht der Fall wird zuerst ein
Preflight Request gesendet. Dieses erlaubt dem Server mitzuteilen, welche
Aktionen auf der gewünschten Resource erlaubt sind, woraufhin der User Agent
entscheidet ob die tatsächliche Anfrage gesendet wird oder nicht.

### Response Headers

Die meisten CORS Header werden vom Server gesetzt um dem User Agent mitzuteilen
ob eine Anfrage erlaubt werden darf oder nicht. Folgende Header sind dabei
definiert:

{{% alert context="danger" %}}

Bei den folgenden Headern gibt es bei einigen die Möglichkeit eine Wildcard
(`*`) zu verwenden. Diese funktioniert jedoch nur wenn **keine Credentials** im
Request verwendet werden. Wird die Wildcard trotzdem verwendet, resultiert dies
entweder in einem Fehler oder die Wildcard wird als `*` interpretiert (Ein 
einfacher Stern keine Wildcard).

{{% /alert %}}

#### Access-Control-Allow-Origin

Der `Access-Control-Allow-Origin` Header gibt an mit welchen Origins die
Antwort geteilt werden darf.  
Es ist möglich `*` als Wert zu verwenden, dies wird als Wildcard gewertet und
ermöglicht allen Origins den Zugriff.  
Es ist auch möglich direkt eine Origin anzugeben, welche erlaubt ist. Es ist
jedoch nicht möglich mehrere Origins anzugeben. Soll die Antwort mit mehreren
Origins geteilt werden können, so muss der Server die jeweilige Origin setzen.  
Neben den obigen Methoden ist es möglich `null` als Wert zu setzen, dies ist
jedoch **nicht** empfohlen, da es unerlaubten Zugriff erlauben könnte.

```http
Access-Control-Allow-Origin: *
Access-Control-Allow-Origin: https://cat.com
```

#### Access-Control-Allow-Credentials

Der `Access-Control-Allow-Credentials` Header gibt an ob die Anfrage, welche
Credentials enthält erlaubt ist.  

```http
Access-Control-Allow-Credentials: true
```

#### Access-Control-Allow-Headers

Der `Access-Control-Allow-Headers` Header gibt als Antwort auf ein Preflight,
welche Header im effektiven Request erlaubt sind. Neben den hier aufgelisteten
Headern sind auch immer die Header auf der CORS Safelist erlaubt, diese können
jedoch auch nochmals im `Access-Control-Allow-Headers` Header aufgelistet werden,
wodurch die zusätzlichen Restriktion für diese Header aufgehoben werden.  
Die Header werden dabei als Komma-separierte Liste angegeben. Auch hier ist eine
Wildcard `*` möglich.

```http
Access-Control-Allow-Headers: X-Custom-Header
Access-Control-Allow-Headers: Content-Type, X-Custom-Header
```

#### Access-Control-Allow-Methods

Der `Access-Control-Allow-Methods` Header funktioniert ähnlich dem
`Access-Control-Allow-Headers` Header, gibt jedoch an welche HTTP-Methoden
erlaubt sind. Hier können die erlaubten Methoden als Komma-separierte Liste
angegeben werden oder es kann die Wildcard `*` verwendet werden.

```http
Access-Control-Allow-Methods: GET
Access-Control-Allow-Methods: GET, POST
Access-Control-Allow-Methods: *
```

#### Access-Control-Expose-Headers

Standardmässig kann eine clientseitig Skriptsprache nur auf die Antwortheader
der CORS Safelist zugreifen. Mit dem `Access-Control-Expose-Headers` Header
kann diese Liste erweitert werden. Hierbei können die erlaubten Header als
Komma-separierte Liste oder mittels Wildcard `*` angegeben werden.

```http
Access-Control-Expose-Headers: X-Custom-Header
Access-Control-Expose-Headers: X-Custom-Header, Content-Encoding
Access-Control-Expose-Headers: *
```

### Request Headers

Die folgenden Header können vom User Agent beim senden des Preflight Requests
an den Server mitgesendet werden, damit dieser weiss, welche Header der Client
beim tatsächlichen Request senden möchte.

#### Access-Control-Request-Headers

Im `Access-Control-Request-Headers` Header des Preflight Requests muss der
der User Agent alle Header angeben, welche der Client im effektiven Request
verwenden möchte. Diese werden als Komma-separierte Liste angegeben.

```http
Access-Control-Request-Headers: X-Custom-Header
```

#### Access-Control-Request-Method

Im `Access-Control-Request-Method` Header des Preflight Requests muss der
User Agent die Methode angeben, welche der Client im effektiven Request
verwenden möchte.

```http
Access-Control-Request-Method: GET
```

## Preflight Request

### Einfaches Request

Ein Preflight Request wird nur dann gesendet, wenn es sich bei der Anfrage nicht
um ein einfaches Request handelt. Dies ist der Fall wenn die folgenden
Bedingungen nicht erfüllt sind:

Das Request benutzt eine der folgenden Methoden:

- `GET`
- `HEAD`
- `POST`

Das Request benutzt nur die folgenden Header, welche durch CORS gesafelistet
sind:

- `Accept`
- `Accept-Language`
- `Content-Language`
- `Content-Type`
- `Range`

Zusätzlich müssen folgende Restriktionen eingehalten sein:

- `Accpet-Language` und `Content-Language` dürfen nur einen Wert enthalten
  welche aus den Zeichen `A-Za-z`, `0-9` und ` *,-.;=`.
- `Content-Type` darf nur die Werte `application/x-www-form-urlencoded`,
  `multipart/form-data` oder `text/plain` enthalten.

### Ablauf

Wenn für ein Request festgestellt wird, dass dieses kein einfaches Request ist
so wird zuerst ein Preflight Request versendet. Dieses nutzt die HTTP-Methode
`OPTIONS` und enthält zwei - drei Header:

```http
OPTIONS /resource/bar
Access-Control-Request-Method: PATCH
Access-Control-Requested-Headers: X-Custom-Header (Wird nur bei Bedarf gesendet)
Origin: https://cat.com
```

Anhand der Antwort vom Server wird entschieden ob das tatsächliche Request
gesendet werden kann. Eine positive Antwort könnte wie folgt aussehen:

```http
HTTP/1.1 204 No Content
Connection: keep-alive
Access-Control-Allow-Origin: https://cat.com
Access-Control-Allow-Methods: GET, POST, PUT, PATCH
Access-Control-Allow-Headers: X-Custom-Header
Access-Control-Max-Age: 86400
```

## Ressourcen

[Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)  
[Cross-Origin Resource Sharing - W3C](https://www.w3.org/TR/2020/SPSD-cors-20200602/)
