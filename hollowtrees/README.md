# Hollowtrees 

[Hollowtrees](https://github.com/banzaicloud/hollowtrees) 

## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud/hollowtrees
```

## Introduction

This chart bootstraps a Banzai Cloud  [Hollowtrees](https://github.com/banzaicloud/banzai-charts/tree/master/hollowtrees) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud/hollowtrees
```

The command deploys Hollowtrees to a Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Hollowtrees chart and their default values.

|               Parameter             |                Description                  |          Default         |
| ----------------------------------- | ------------------------------------------- | ------------------------ |
| `name`                  | Container name                              | `hollowtrees`                        |
| `image`                 | Container image                             | `banzaicloud/hollowtrees:{VERSION}`  |
| `replicaCount`          | Replica Count                               | `1`                                  |
| `service.type`          | Kubernetes service type to expose           | `ClusterIP`                          |
| `service.nodePort`      | Port to bind to for NodePort service type   | `nil`                                |
| `service.annotations`   | Additional annotations to add to service    | `nil`                                |
| `imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                       |
| `logLevel`              | hollowtrees Log level                       | `debug`                              |
| `logFormat`             | hollowtrees Log format                      | `text`                               |
| `bindAddr`              | Port to bind to for Recommender service     | `9092`                               |
| `buffersize`            | buffersize app buffersize                   | `100`                                |
| `resources`             | CPU/Memory resource requests/limits         | Memory: `256Mi`, CPU: `100m`         |
      
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud/hollowtrees
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
