# AWS Spot price exporter Chart

[AWS Spot price exporter](https://github.com/banzaicloud/spot-price-exporter) Prometheus exporter for AWS spot prices.. 

## tl;dr:

## Add banzai-stable chart repo from specific branch

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/[branch-name]
```

## Introduction

This chart bootstraps an [AWS Spot price exporter](https://github.com/banzaicloud/spot-price-exporter) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/spot-price-exporter
```

The command deploys AWS Spot price exporter on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of this chart and their default values.

|          Parameter          |                Description                            |             Default               |
| --------------------------- | ----------------------------------------------------- | --------------------------------- |
| `image.repository`          | Container image repository                            | `banzaicloud/spot-price-exporter  |
| `image.tag       `          | Container image tag                                   | `0.0.1`                           |
| `image.pullPolicy`          | Container pull policy                                 | `IfNotPresent`                    |
| `podAnnotations`            | The kubernetes pod annotations                        | `nil`                             |
| `auth.awsAccessKeyId`       | Amazon Access Key ID                                  | ""                                |
| `auth.awsSecretAccessKey`   | Amazon Secret Access Key                              | ""                                |

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/spot-price-exporter
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
