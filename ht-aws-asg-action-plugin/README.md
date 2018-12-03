# Hollowtrees Auto Scaling Groups Plugin 

[Hollowtrees ASG Action Plugin](https://github.com/banzaicloud/ht-aws-asg-action-plugin) 

## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud/ht-aws-asg-action-plugin
```

## Introduction

This chart bootstraps a Banzai Cloud  [Hollowtrees ASG Action Plugin](https://github.com/banzaicloud/banzai-charts/tree/master/ht-aws-asg-action-plugin) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud/ht-aws-asg-action-plugin
```

The command deploys Hollowtrees ASG action plugin to a Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Hollowtrees Auto Scaling Groups Plugin  chart and their default values.

|                     Parameter             |                Description                  |                      Default                    |
| ----------------------------------------- | ------------------------------------------- | ----------------------------------------------- |
| `name`                  | Container name                              | `ht-aws-asg-action-plugin`                      |
| `image`                 | Container image                             | `banzaicloud/ht-aws-asg-action-plugin:{VERSION}`|
| `replicaCount`          | Replica Count                               | `1`                                             |
| `service.type`          | Kubernetes service type to expose           | `ClusterIP`                                     |
| `service.nodePort`      | Port to bind to for NodePort service type   | `nil`                                           |
| `service.annotations`   | Additional annotations to add to service    | `nil`                                           |
| `imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                                  |
| `logLevel`              | Log level                                   | `debug`                                         |
| `logFormat`             | Log format                                  | `text`                                          |
| `bindAddr`              | Port to bind to for service                 | `8888`                                          |
| `region`                | ASG Region                                  | `eu-west-1`                                     |
| `resources`             | CPU/Memory resource requests/limits         | Memory: `256Mi`, CPU: `100m`                    |
          
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud/ht-aws-asg-action-plugin
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
