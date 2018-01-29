# Hollowtrees Spot Recommender

[SpotRecommender](https://github.com/banzaicloud/spot-recommender) Spot instance recommender is a building block of the Hollowtrees project. 

## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/spot-recommender
```

## Introduction

This chart bootstraps an [AWS spot recommender](https://github.com/banzaicloud/banzai-charts/incubator/spot-recommender) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/spot-recommender
```

The command deploys SpotRecommender on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the SpotRecommender chart and their default values.

|               Parameter             |                          Description                         |                   Default                   |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------------------------- |
| `recommender.name`                  | Spot Recommender container name                              | `recommender`                               |
| `recommender.image`                 | Spot Recommender container image                             | `banzaicloud/spot-recommende:{VERSION}`     |
| `recommender.replicaCount`          | Replica Count                                                | `3`                                         |
| `recommender.service.type`          | Kubernetes service type to expose                            | `ClusterIP`                                 |
| `recommender.service.nodePort`      | Port to bind to for NodePort service type                    | `nil`                                       |
| `recommender.service.annotations`   | Additional annotations to add to service                     | `nil`                                       |
| `recommender.imagePullPolicy`       | Image pull policy.                                           | `IfNotPresent`                              |
| `recommender.logLevel`              | Recommender Log level                                        | `info`                                      |
| `recommender.appPort`               | Port to bind to for Recommender service                      | `9090`                                      |
| `recommender.cacheInstanceTypes`    | Recommendations are cached for these instance types          | `m4.xlarge,m5.xlarge,c5.xlarge`             |
| `recommender.reevaluationInterval`  | Time (in seconds) between reevaluating the recommendations.  | `1m0s`                                      |
| `recommender.region`                | AWS region where the recommender should work.                | `eu-west-1`                                 |
| `recommender.resources`             | CPU/Memory resource requests/limits                          | Memory: `256Mi`, CPU: `100m`                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/spot-recommender
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
