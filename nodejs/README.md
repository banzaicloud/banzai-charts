# Node.js
### Generic Node.js Application chart

[Node.js](https://nodejs.org/en/) application

## How to add repo chart repo

Please read this [README.md][https://github.com/banzaicloud/banzai-charts] 

## tl;dr:

```bash
$ helm install banzaicloud-stable/nodejs
```

## Introduction for example

This chart bootstraps [Node.js application](https://github.com/banzaicloud/banzai-charts/stable/ingressauthgenerator) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/nodejs
```

The command deploys Node.js to a Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

Soon.

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/nodejs
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
