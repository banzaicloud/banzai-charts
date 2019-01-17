# Instance termination handler

[Instance Termination Handler](https://github.com/banzaicloud/instance-termination-handler)

## tl;dr

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud-stable/instance-termination-handler
```

## Introduction

This chart bootstraps a Banzai Cloud [Instance Termination Handler](https://github.com/banzaicloud/banzai-charts/instance-termination-handler) deployment to a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/instance-termination-handler
```

The command deploys Instance Termination Handler on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

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
$ helm install --name my-release -f values.yaml banzaicloud-incubator/instance-termination-handler
```

> **Tip**: You can use the default [values.yaml](values.yaml)
