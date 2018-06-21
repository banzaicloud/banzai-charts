# Telescopes Chart

[Telescopes](https://github.com/banzaicloud/telescopes) Instance recommender is a building block of the Hollowtrees project. 

## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/
$ helm repo update
$ helm install banzaicloud-stable/telescopes
```

## Introduction

This chart bootstraps an [Telescopes](https://github.com/banzaicloud/banzai-charts/stable/telescopes) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/telescopes
```

The command deploys telescopes on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the telescopes chart and their default values.

|               Parameter             |                          Description                         |                   Default                   |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------------------------- |
| `telescopes.name`                  |  Telescopes container name                              | `telescopes`                               |
| `telescopes.image`                 | Telescopes container image                             | `banzaicloud/telescopes:{VERSION}`     |
| `telescopes.replicaCount`          | Replica Count                                                | `3`                                         |
| `telescopes.service.type`          | Kubernetes service type to expose                            | `ClusterIP`                                 |
| `telescopes.service.nodePort`      | Port to bind to for NodePort service type                    | `nil`                                       |
| `telescopes.service.annotations`   | Additional annotations to add to service                     | `nil`                                       |
| `telescopes.imagePullPolicy`       | Image pull policy.                                           | `IfNotPresent`                              |
| `telescopes.logLevel`              | Log level                                        | `info`                                      |
| `telescopes.appPort`               | Port to bind to for Recommender service                      | `9090`                                      |
| `telescopes.cacheInstanceTypes`    | Recommendations are cached for these instance types          | `m4.xlarge,m5.xlarge,c5.xlarge`             |
| `telescopes.reevaluationInterval`  | Time (in seconds) between reevaluating the recommendations.  | `1m0s`                                      |
| `telescopes.region`                | AWS region where the recommender should work.                | `eu-west-1`                                 |
| `telescopes.resources`             | CPU/Memory resource requests/limits                          | Memory: `256Mi`, CPU: `100m`                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/telescopes
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
