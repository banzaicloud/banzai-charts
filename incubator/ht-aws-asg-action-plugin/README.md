# Hollowtrees Auto Scaling Groups Plugin 

[Hollowtrees ASG Action Plugin](https://github.com/banzaicloud/ht-aws-asg-action-plugin) 

## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/ht-aws-asg-action-plugin
```

## Introduction

This chart bootstraps an BanzaiCloud  [Hollowtrees ASG Action Plugin](https://github.com/banzaicloud/banzai-charts/incubator/ht-aws-asg-action-plugin) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/ht-aws-asg-action-plugin
```

The command deploys Hollowtrees ASG action plugin on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

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
| `htAsgActionPlugin.name`                  | Container name                              | `ht-aws-asg-action-plugin`                      |
| `htAsgActionPlugin.image`                 | Container image                             | `banzaicloud/ht-aws-asg-action-plugin:{VERSION}`|
| `htAsgActionPlugin.replicaCount`          | Replica Count                               | `1`                                             |
| `htAsgActionPlugin.service.type`          | Kubernetes service type to expose           | `ClusterIP`                                     |
| `htAsgActionPlugin.service.nodePort`      | Port to bind to for NodePort service type   | `nil`                                           |
| `htAsgActionPlugin.service.annotations`   | Additional annotations to add to service    | `nil`                                           |
| `htAsgActionPlugin.imagePullPolicy`       | Image pull policy.                          | `IfNotPresent`                                  |
| `htAsgActionPlugin.logLevel`              | Log level                                   | `debug`                                         |
| `htAsgActionPlugin.logFormat`             | Log format                                  | `text`                                          |
| `htAsgActionPlugin.bindAddr`              | Port to bind to for service                 | `8888`                                          |
| `htAsgActionPlugin.region`                | ASG Region                                  | `eu-west-1`                                     |
| `htAsgActionPlugin.resources`             | CPU/Memory resource requests/limits         | Memory: `256Mi`, CPU: `100m`                    |
          
Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/ht-aws-asg-action-plugin
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
