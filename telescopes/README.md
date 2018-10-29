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

|          Parameter          |                Description                            |             Default             |
| --------------------------- | ----------------------------------------------------- | ------------------------------- |
| `image.repository`          | Container image repository                            | `banzaicloud/telescopes`        |
| `image.tag       `          | Container image tag                                   | `latest`                        |
| `image.pullPolicy`          | Container pull policy                                 | `Always`                        |
| `service.type`              | The kubernetes service type to use                    | `ClusterIP`                     |
| `service.name`              | The kubernetes service name to use                    | `telescopes`                    |
| `service.port`              | Port to bind to for NodePort service type             | `nil`                           |
| `service.annotations`       | The kubernetes service annotations                    | `nil`                           |
| `app.logLevel`              | Log level                                             | `info`                          |
| `app.productInfoAddress`    | The address of the Product Info service               | `http://localhost:9090/api/v1`  |
| `app.devMode`               | Developer mode                                        | `false`                         |
| `app.vaultAddress`          | The vault address for authentication token management | `nil`                           |
| `app.tokenSigningKey`       | The token signing key for the authentication process  | `nil`                           |
| `deploymentLabels`          | Additional deployment labels                          | `{}`                            |
| `deploymentAnnotations`     | Additional deployment annotations                     | `{}`                            |

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/telescopes
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```
