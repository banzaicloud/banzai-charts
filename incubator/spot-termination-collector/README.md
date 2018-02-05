# Hollowtrees spot instance termination collector

[Hollowtrees Spot Termination Collector](https://github.com/banzaicloud/spot-termination-collector) 

## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/spot-termination-collector
```

## Introduction

This chart bootstraps an BanzaiCloud  [Hollowtrees Spot Termination Collector](https://github.com/banzaicloud/banzai-charts/incubator/spot-termination-collector) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/spot-termination-collector
```

The command deploys Hollowtrees Spot Termination Collector on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Hollowtrees spot instance termination collector chart and their default values.

|                     Parameter                    |                Description                  |                      Default                      |
| ------------------------------------------------ | ------------------------------------------- | ------------------------------------------------- |
| `spotTerminationCollector.name`                  | Container name                              | `spot-termination-collector`                      |
| `spotTerminationCollector.image`                 | Container image                             | `banzaicloud/spot-termination-collector:{VERSION}`|
| `spotTerminationCollector.replicaCount`          | Replica Count                               | `1`                                               |
| `spotTerminationCollector.service.type`          | Kubernetes service type to expose           | `ClusterIP`                                       |
| `spotTerminationCollector.service.nodePort`      | Port to bind to for NodePort service type   | `nil`                                             |
| `spotTerminationCollector.service.annotations`   | Additional annotations to add to service    | `nil`                                             |
| `spotTerminationCollector.imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                                    |
| `spotTerminationCollector.logLevel`              | Log level                                   | `debug`                                           |
| `spotTerminationCollector.metadataEndpoint`      | Metadata Endpoint                           | `http://169.254.169.254/latest/meta-data/`        |
| `spotTerminationCollector.metricsPath`           | Metrics Path                                | `/metrics`                                        |
| `spotTerminationCollector.bindAddr`              | Port to bind to for service                 | `9189`                                            |
| `spotTerminationCollector.resources`             | CPU/Memory resource requests/limits         | Memory: `256Mi`, CPU: `100m`                      |
          
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/spot-termination-collector
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
