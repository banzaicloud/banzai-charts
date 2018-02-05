# Hollowtrees spot instance termination exporter

[Hollowtrees Spot Termination exporter](https://github.com/banzaicloud/spot-termination-exporter) 

## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/spot-termination-exporter
```

## Introduction

This chart bootstraps a Banzai Cloud  [Hollowtrees Spot Termination exporter](https://github.com/banzaicloud/banzai-charts/incubator/spot-termination-exporter) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/spot-termination-exporter
```

The command deploys Hollowtrees Spot Termination exporter on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Hollowtrees spot instance termination exporter chart and their default values.

|                     Parameter                    |                Description                  |                      Default                      |
| ------------------------------------------------ | ------------------------------------------- | ------------------------------------------------- |
| `spotTerminationexporter.name`                  | Container name                              | `spot-termination-exporter`                      |
| `spotTerminationexporter.image`                 | Container image                             | `banzaicloud/spot-termination-exporter:{VERSION}`|
| `spotTerminationexporter.replicaCount`          | Replica Count                               | `1`                                               |
| `spotTerminationexporter.service.type`          | Kubernetes service type to expose           | `ClusterIP`                                       |
| `spotTerminationexporter.service.nodePort`      | Port to bind to for NodePort service type   | `nil`                                             |
| `spotTerminationexporter.service.annotations`   | Additional annotations to add to service    | `nil`                                             |
| `spotTerminationexporter.imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                                    |
| `spotTerminationexporter.logLevel`              | Log level                                   | `debug`                                           |
| `spotTerminationexporter.metadataEndpoint`      | Metadata Endpoint                           | `http://169.254.169.254/latest/meta-data/`        |
| `spotTerminationexporter.metricsPath`           | Metrics Path                                | `/metrics`                                        |
| `spotTerminationexporter.bindAddr`              | Port to bind to for service                 | `9189`                                            |
| `spotTerminationexporter.resources`             | CPU/Memory resource requests/limits         | Memory: `256Mi`, CPU: `100m`                      |
          
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/spot-termination-exporter
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
