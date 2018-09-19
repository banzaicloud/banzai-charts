# Mysql Operator

[Mysql Operator](https://github.com/oracle/mysql-operator) 

## How to add repo chart repo

Please read this [README.md][https://github.com/banzaicloud/banzai-charts] 

## tl;dr:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
$ helm install banzaicloud-stable/mysql-operator
```

## Introduction for example

This chart bootstraps the [Mysql Operator](https://github.com/oracle/mysql-operator) deployment on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-stable/mysql-operator
```

The command deploys Mysql Operator to a Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

| Parameter               | Description                                                           | Default                             |
| ----------------------- | --------------------------------------------------------------------  | ----------------------------------- |
| `image.repository`      | `mysql-operator` image repository                                     | `iad.ocir.io/oracle/mysql-operator` |
| `image.tag`             | `mysql-operator` image tag                                            | `0.2.0`                             |
| `image.pullPolicy`      | `mysql-operator` image pull policy                                    | `IfNotPresent`                      |
| `rbac.enabled`          | Install required rbac sa. and roles and rolebindings                  | true                                |
| `operator.global`       | The namespace for which the MySQL operator manages MySQL clusters.    | if not set manage `all` namespaces  |
| `operator.namespace`    | The namespace for which the MySQL operator manages MySQL clusters.    | if not set manage `all` namespaces  |
| `operator.register_crd` | Enable CRD registration                                               | true                                |
| `mysql.server.image`    | The name of the target 'mysql-server' image.                          | `mysql/mysql-server`                |
| `mysql.agent.image`     | The name of the target 'mysql-agent' image.                           | `iad.ocir.io/oracle/mysql-agent`    |

## Using Operator

Visit [mysql-operator documentation](https://github.com/oracle/mysql-operator/tree/master/docs/user) page
