# IngressAuthGenerator 

[IngressAuthGenerator](https://github.com/banzaicloud/ingressauthgenerator) 

## tl;dr:

```bash
$ helm repo add banzaicloud http://kubernetes-charts.banzaicloud.com
$ helm repo update
$ helm install banzaicloud/ingressauthgenerator
```

## Introduction

This chart bootstraps a Banzai Cloud  [IngressAuthGenerator](https://github.com/banzaicloud/banzai-charts/stable/ingressauthgenerator) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud/ingressauthgenerator
```

The command deploys IngressAuthGenerator to a Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the IngressAuthGenerator chart and their default values.

|                    Parameter                 |                Description                  |                  Default                     |
| -------------------------------------------- | ------------------------------------------- | -------------------------------------------- |
| `ingressauthgenerator.name`                  | Container name                              | `ingressauthgenerator`                       |
| `ingressauthgenerator.image`                 | Container image                             | `banzaicloud/ingressauthgenerator:{VERSION}` |
| `ingressauthgenerator.imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                               |
| `ingressauthgenerator.resources`             | CPU/Memory resource requests/limits         | Memory: `120Mi`, CPU: `20m`                 |
      
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud/ingressauthgenerator
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
