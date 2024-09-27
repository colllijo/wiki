# Wiki

This is the source code repository for my personal wiki. It will contain all
sorts of information that I find interesting and useful. Without any guarantee
of correctness.  
This wiki is built with [Hugo](https://gohugo.io/) and [Lotusdocs](https://lotusdocs.dev).

## Usage

This wiki is built with GitHub Actions and hosted as a GitHub Page under the URL: `https://wiki.coll.dev`.

## Development

For adding new content to the wiki, or modifying the style of the wiki [Hugo](https://gohugo.io/) is needed.
With the repository cloned and `hugo` installed it is possible to run `hugo server -D`
to start the local development server. Which by default can be accessed at `http://localhost:1313`.
To see a preview of the actual site run `hugo server` without the `-D` flag, to not include draft pages.

### Modifying content

The content of the wiki is located in the `content` directory.
As the base language is English, those file are located in the root of the `content` directory.
The translations into the other languages are located in the directories with the respective language codes.

### Modifying the style

Modifying the style of the wiki is mostly done in the `layouts` directory for structural changes and
in the `assets` directory for styling changes.

## Backlog

- Translations

- [ ] Testing
  - [ ] Testing - JUnit
  - [ ] Testing - Cypress
  - [ ] Testing - K6
  - [ ] Testing - Sentry
- [ ] C++
  - [ ] C++ - CMake
  - [ ] C++ - Clang
- [ ] Java CLI
- [ ] Maven
- [ ] Nestjs
- [ ] Neovim
- [ ] Arch Linux
- [ ] Design Patterns
- [ ] Software Architektur
- [ ] Kubernetes
- [ ] Sonarcube
- [ ] Hugo
  - [ ] My hugo theme colllijo/lotusdocs
- [ ] Wireshark
- [ ] CTFs
  - [ ] Ghidra
  - [ ] Pwntools
- [ ] Technologien
  - [ ] WebSockets
  - [ ] RabbitMQ
  - [ ] MQTT
  - [ ] REST
  - [ ] GraphQL
- [ ] Monitoring
  - [ ] Graphana
  - [ ] Prometheus
  - [ ] CheckMK
- [ ] Deployment
  - [ ] Docker
  - [ ] Kubernetes
  - [ ] ArgoCD
- [ ] Databases
  - [ ] Relational
  - [ ] NoSQL
- [ ] Assembly
