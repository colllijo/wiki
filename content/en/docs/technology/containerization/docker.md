---
weight: 4701
title: "Docker"
description: |
  Information about docker
icon: "article"
date: "2025-03-06T12:50:14+01:00"
lastmod: "2025-03-06T12:50:14+01:00"
draft: false
toc: true
---

## What is Docker?

[Docker][docker] is a free software used for
[container virtualization][os-virtualization-wiki]. This allows applications to
run in containers, isolated and independent of the host environment. This
simplifies the deployment of applications, as all necessary components such as
code, runtime, system tools, and libraries are contained in the container and do
not need to be installed on the other system.

{{% alert context="info" %}}

Docker itself does not implement container virtualization, but is only a tool
which simplifies the creation and management of containers.  
Docker itself uses [containerd][containerd], which in turn uses [runc][runc],
to enable the actual virtualization.

{{% /alert %}}

## Docker Terminology

When working with Docker, it is important to know some basic terms:

- **Image**: A Docker image is an immutable template that contains all the
  necessary instructions to run an application. It is based on a series of
  layers, each representing changes from the previous layer. Images are created
  from Dockerfiles and can be stored in registries and retrieved from
  there.

- **Container**: A container is a running instance of a Docker image. It
  contains everything the application needs to run in an isolated environment,
  including the code, runtime, system tools, and libraries. Containers are
  lightweight and portable, making them ideal for developing and deploying
  applications.

- **Dockerfile**: A Dockerfile is a text file that contains a series of
  instructions on how to create a Docker image. Each instruction in a Dockerfile
  creates a new layer in the image. Typical instructions include `FROM` to
  specify the base image, `RUN` to execute commands, and `COPY` to copy files
  into the image.

- **Registry**: A registry is a storage location for Docker images. The most
  well-known registry is Docker Hub, but there are also private registries that
  can be used within organizations. Registries allow images to be shared and
  versioned. Developers can push images to a registry and pull them from there
  to use on different systems.

- **Volume**: A volume is a mechanism to store data outside the container so
  that it persists even after the container is stopped or deleted. Volumes are
  particularly useful for storing data that needs to be shared between multiple
  containers or for storing data that needs to persist across container
  restarts.

- **Network**: Docker networks enable communication between containers and
  other services. There are different network modes, such as bridge, host, and
  overlay. The bridge mode is the default mode and creates a private internal
  network for containers on the same host. The host mode allows containers to
  have direct access to the host's network. The overlay mode is used to connect
  containers across multiple hosts.

## Example

To show the basic usage of Docker, let's create a simple web server using the
nginx webserver and run everything in a Docker container.

For this we can create a project directory which contains an HTML file (our
website), as well as a Dockerfile which is needed to create our Docker image.

Here an example of a simple HTML website in the file `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Docker Website</title>
  </head>
  <body>
    <h1>Welcome to my Docker website!</h1>
    <p>This is a simple static website, deployed using docker.</p>
  </body>
</html>
```

Now we need to create a Dockerfile which serves our HTML file with a webserver:

```Dockerfile
# Using the nginx webserver as base image
FROM nginx:alpine

# Copy the index.html file to the html directory served by nginx
COPY index.html /usr/share/nginx/html/index.html

# Expose the Port so that it can be accessed
EXPOSE 80
```

With these two files, we can now create the Docker image. For this we can use
the `build` command of Docker:

```bash
docker build -t my-docker-website .
```

The `-t` flag is used to give the image a name and the dot at the end sets the
Build-Context to the current directory.

After the build is finished, we can create a container from the image. For this
we use the `run` command:

```bash
docker run -d -p 8080:80 --name docker-website my-docker-website
```

The `-d` flag runs the container in detached mode, `-p` maps the container port
`80` to the port `8080` on the host system, and `--name` gives the container a
name. The last argument is the name of the image to run the container from.

After the container is running, you can access the website by opening a browser
and accessing `http://localhost:8080`. You can check if the container is running
by using the `docker ps` command, which lists all running containers.

```bash
docker ps
```

The container can be stopped with the `stop` command and removed with the
`rm` command:

```bash
docker stop docker-website
docker rm docker-website
```

If the image is no longer needed, it can be removed with the `rmi` command:

```bash
docker rmi my-docker-website
```

## Docker Alternatives

Next to Docker, there are other containerization tools available. One of the
most well-known alternatives is Podman. Podman is an Open-Source container
engine, which in contrast to Docker, does not require a daemon to run. This
allows Podman to run containers as regular users without the need for root.
Podman is also compatible with Docker images and containers, making it a good
drop-in replacement for Docker.

## Resources

[Docker][docker]  
[Docker - Wikipedia][docker-wiki]  
[OS-level virtualization - Wikipedia][os-virtualization-wiki]

[docker]: https://www.docker.com/
[containerd]: https://containerd.io/
[runc]: https://github.com/opencontainers/runc
[docker-wiki]: https://en.wikipedia.org/wiki/Docker_(software)
[os-virtualization-wiki]: https://en.wikipedia.org/wiki/OS-level_virtualization

