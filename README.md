# docker-image-node

[![Build Status](https://travis-ci.org/chesszebra/docker-image-node.svg?branch=master)](https://travis-ci.org/chesszebra/docker-image-node)

This repository contains the Docker image used to run NodeJS from the 
command line.

## Usage

To use this image, make sure to map a directory to the `/data` directory within the container.

```
docker run --rm -it -v $(pwd):/data chesszebra/node
```

You can also explicitly specify node:

```
docker run --rm -it -v $(pwd):/data chesszebra/node node
```

### NPM and Yarn

NPM and Yarn can be used:

```
docker run --rm -it -v $(pwd):/data chesszebra/node npm
```

```
docker run --rm -it -v $(pwd):/data chesszebra/node yarn
```

### Python, Ruby and others

Many Node packages require external dependencies that make use of Python or Ruby. Take `Sass` for example, `Sass` 
should be installed using Ruby's `gem` installer. For convenience we've installed Python and Ruby in this container so
that it becomes easier to run other scripts.
