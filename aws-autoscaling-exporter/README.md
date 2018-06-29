# Hollowtrees AWS Autoscaling Exporter

[AutoscalingExporter](https://github.com/banzaicloud/aws-autoscaling-exporter) Prometheus exporter for AWS auto scaling groups.

## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/aws-autoscaling-exporter
```

## Introduction

This chart bootstraps an AWS [Autoscaling exporter](https://github.com/banzaicloud/banzai-charts/incubator/aws-autoscaling-exporter) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/aws-autoscaling-exporter
```

The command deploys AutoscalingExporter on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the AWS Autoscaling Exporter chart and their default values.

|               Parameter                     |                          Description                         |                       Default                     |
| ------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------- |
| `autoscalingExporter.name`                  | Autoscaling Exporter container name                          | `autoscalingExporter`                             |
| `autoscalingExporter.image`                 | Autoscaling Exporter container image                         | `banzaicloud/aws-autoscaling-exporter:{VERSION}`  |
| `autoscalingExporter.replicaCount`          | Replica Count                                                | `3`                                               |
| `autoscalingExporter.service.type`          | Kubernetes service type to expose                            | `ClusterIP`                                       |
| `autoscalingExporter.service.nodePort`      | Port to bind to for NodePort service type                    | `nil`                                             |
| `autoscalingExporter.service.annotations`   | Additional annotations to add to service                     | `nil`                                             |
| `autoscalingExporter.imagePullPolicy`       | Image pull policy.                                           | `IfNotPresent`                                    |
| `autoscalingExporter.logLevel`              | Recommender Log level                                        | `info`                                            |
| `autoscalingExporter.appPort`               | Port to bind to for Recommender service                      | `8089`                                            |
| `autoscalingExporter.recommenderUrl`        | URL of the spot instance recommender                         | `http://localhost:9090`                           |
| `autoscalingExporter.metricsPath`           | Path to metrics endpoint                                     | `/metrics`                                        |
| `autoscalingExporter.region`                | AWS region where the recommender should work.                | `eu-west-1`                                       |
| `autoscalingExporter.resources`             | CPU/Memory resource requests/limits                          | Memory: `256Mi`, CPU: `100m`                      |
      
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/aws-autoscaling-exporter
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
