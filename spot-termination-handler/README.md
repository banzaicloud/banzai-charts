# Spot instance termination handler

[Spot Termination Handler](https://github.com/banzaicloud/spot-termination-handler)

## tl;dr

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud-stable/spot-termination-handler
```

## Introduction

This chart bootstraps a Banzai Cloud [Spot Termination Handler](https://github.com/banzaicloud/banzai-charts/spot-termination-handler) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/spot-termination-handler
```

The command deploys Spot Termination Handler on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The available configuration values defined in the `values.yaml` file.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/spot-termination-handler
```

> **Tip**: You can use the default [values.yaml](values.yaml)
