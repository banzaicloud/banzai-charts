
# Logging Operator Nginx demonstration Chart

[Logging Operator](https://github.com/banzaicloud/logging-operator) Managed centralized logging component fluentd and fluent-bit instance on cluster.
## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud-stable/nginx-logging-demo
```

## Introduction

This chart demonstrates an example app that utilise [Logging Operator](https://github.com/banzaicloud/banzai-charts/logging-operator) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- [Logging Operator](https://github.com/banzaicloud/logging-operator) available on the cluster


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name log-test-nginx banzaicloud-stable/nginx-logging-demo
```
## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the logging-operator chart and their default values.

|                      Parameter                      |                        Description                     |             Default            |
| --------------------------------------------------- | ------------------------------------------------------ | ------------------------------ |
| `image.repository`                                  | Container image repository                             | `banzaicloud/logging-operator` |
| `image.tag`                                         | Container image tag                                    | `0.1.2`                        |
| `image.pullPolicy`                                  | Container pull policy                                  | `IfNotPresent`                 |
| `nameOverride`                                      | Override name of app                                   | ``                             |
| `fullnameOverride`                                  | Override full name of app                              | ``                             |
| `watchNamespace`                                    | Namespace to watch fot LoggingOperator CRD             | ``                             |
| `affinity`                                          | Node Affinity                                          | `{}`                           |
| `resources`                                         | CPU/Memory resource requests/limits                    | `{}`                           |
| `tolerations`                                       | Node Tolerations                                       | `[]`                           |
| `nodeSelector`                                      | Define which Nodes the Pods are scheduled on.          | `{}`                           |
| `securityContext`                                   | SecurityContext for Logging operator                   | `{"runAsNonRoot": true, "runAsUser": 1000}` |

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/logging-operator
```

> **Tip**: You can use the default [values.yaml](values.yaml)

