
# Productinfo Chart

[Productinfo](https://github.com/banzaicloud/productinfo) Provides resource and pricing information about products available on supported cloud providers - it is a building block of the Hollowtrees project. 

## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud-stable/productinfo
```

## Introduction

This chart bootstraps an [Productinfo](https://github.com/banzaicloud/banzai-charts/stable/productinfo) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/productinfo
```

The command deploys **productinfo** on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the productinfo chart and their default values.

|          Parameter            |                Description                               |             Default          |
| ----------------------------- | -------------------------------------------------------- | ---------------------------- |
| `image.repository`            | Container image repository                               | `banzaicloud/productinfo`    |
| `image.tag       `            | Container image tag                                      | `latest`                     |
| `image.pullPolicy`            | Container pull policy                                    | `Always`                     |
| `service.type`                | The kubernetes service type to use                       | `ClusterIP`                  |
| `service.name`                | The kubernetes service name to use                       | `productinfo`                |
| `service.port`                | Port to bind to for NodePort service type                | `nil`                        |
| `service.annotations`         | The kubernetes service annotations                       | `nil`                        |
| `app.logLevel`                | Log level                                                | `info`                       |
| `app.basePath`                | Application base path                                    | `/`                          |
| `auth.awsAccessKeyId`         | Amazon Access Key ID                                     | ""                           |
| `auth.awsSecretAccessKey`     | Amazon Secret Access Key                                 | ""                           |
| `auth.gceApiKey`              | GCE API Key                                              | ""                           |
| `auth.gceCredentials`         | GCE Credential file (encoded by base64)                  | ""                           |
| `auth.azureSubscriptionId`    | Azure Subscription GUID                                  | ""                           |
| `auth.azureCredentials`       | Azure Credential file (encoded by base64)                | ""                           |
| `auth.ociUser`                | The OCID of the user                                     | ""                           |
| `auth.ociTenancy`             | The OCID of the tenancy                                  | ""                           |
| `auth.ociRegion`              | Specific region for OCI                                  | ""                           |
| `auth.ociKey`                 | The key pair must be in PEM format. (encode by base64)   | ""                           |
| `auth.ociFingerprint`         | Fingerprint for the key pair being used                  | ""                           |
| `auth.alibabaAccessKeyId`     | Alibaba Access Key ID                                    | ""                           |
| `auth.alibabaAccessKeySecret` | Alibaba Access Key Secret                                | ""                           |
| `auth.alibabaRegionId`        | Alibaba Region ID                                        | ""                           |
| `deploymentLabels`            | Additional deployment labels                             | `{}`                         |
| `deploymentAnnotations`       | Additional deployment annotations                        | `{}`                         |

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/productinfo
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```

