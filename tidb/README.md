# TiDB

TiDB on Kubernetes: https://banzaicloud.com/blog/tidb-kubernetes/

[TiDB](https://www.pingcap.com/docs/) (The pronunciation is: /‘taɪdiːbi:/ tai-D-B, etymology: titanium) is a Hybrid Transactional/Analytical Processing (HTAP) database. Inspired by the design of Google F1 and Google Spanner, TiDB features infinite horizontal scalability, strong consistency, and high availability. The goal of TiDB is to serve as a one-stop solution for online transactions and analyses.


## tl;dr:

```bash
$ helm repo add banzaicloud-incubator http://kubernetes-charts-incubator.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-incubator/tidb
```

## Introduction

This chart bootstraps a [TiDB](https://github.com/banzaicloud/banzai-charts/incubator/tidb) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.7+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release banzaicloud-incubator/tidb
```

The command deploys TiDB on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the TiDB chart and their default values.

|               Parameter          |                Description                 |                   Default                   |
| -------------------------------- | ------------------------------------------ | ------------------------------------------- |
| `pd.name`                        | Placement Drive container name             | `pd`                                        |
| `pd.image`                       | Placement Drive container image            | `pingcap/pd:{VERSION}`                      |
| `pd.replicaCount`                | Replica Count                              | `3`                                         |
| `pd.service.type`                | Kubernetes service type to expose          | `ClusterIP`                                 |
| `pd.service.nodePort`            | Port to bind to for NodePort service type  | `nil`                                       |
| `pd.service.annotations`         | Additional annotations to add to service   | `nil`                                       |
| `pd.service.PeerPort`            | Port to bind to for Peer service type      | `2380`                                      |
| `pd.service.ClientPort`          | Port to bind to for Client service type    | `2379`                                      |
| `pd.imagePullPolicy`             | Image pull policy.                         | `IfNotPresent`                              |
| `pd.resources`                   | CPU/Memory resource requests/limits        | Memory: `256Mi`, CPU: `100m`                |
| `tidb.name`                      | TiDB container name                        | `db`                                        |
| `tidb.image`                     | TiDB container image                       | `pingcap/tidb:{VERSION}`                    |
| `tidb.replicaCount`              | Replica Count                              | `2`                                         |
| `tidb.service.type`              | Kubernetes service type to expose          | `ClusterIP`                                 |
| `tidb.service.nodePort`          | Port to bind to for NodePort service type  | `nil`                                       |
| `tidb.service.annotations`       | Additional annotations to add to service   | `nil`                                       |
| `tidb.service.mysql`             | Port to bind to for Mysql service type     | `4000`                                      |
| `tidb.service.status`            | Port to bind to for Status service type    | `10080`                                     |
| `tidb.imagePullPolicy`           | Image pull policy.                         | `IfNotPresent`                              |
| `tidb.persistence.enabled        | Use a PVC to persist data                  | `false`                                     |
| `tidb.persistence.existingClaim` | Use an existing PVC                        | `nil`                                       |
| `tidb.persistence.storageClass`  | Storage class of backing PVC               | `nil` (uses alpha storage class annotation) |
| `tidb.persistence.accessMode`    | Use volume as ReadOnly or ReadWrite        | `ReadWriteOnce`                             |
| `tidb.persistence.size`          | Size of data volume                        | `8Gi`                                       |
| `tidb.resources`                 | CPU/Memory resource requests/limits        | Memory: `128Mi`, CPU: `100m`                |
| `tikv.name`                      | TiKV container name                        | `kv`                                        |
| `tikv.image`                     | TiKV container image                       | `pingcap/tikv:{VERSION}`                    |
| `tikv.replicaCount`              | Replica Count                              | `3`                                         |
| `tikv.service.type`              | Kubernetes service type to expose          | `ClusterIP`                                 |
| `tikv.service.nodePort`          | Port to bind to for NodePort service type  | `nil`                                       |
| `tikv.service.annotations`       | Additional annotations to add to service   | `nil`                                       |
| `tidb.service.ClientPort`        | Port to bind to for Client service type    | `20160`                                     |
| `tikv.imagePullPolicy`           | Image pull policy.                         | `IfNotPresent`                              |
| `tikv.persistence.enabled`        | Use a PVC to persist data                  | `false`                                     |
| `tikv.persistence.existingClaim` | Use an existing PVC                        | `nil`                                       |
| `tikv.persistence.storageClass`  | Storage class of backing PVC               | `nil` (uses alpha storage class annotation) |
| `tikv.persistence.accessMode`    | Use volume as ReadOnly or ReadWrite        | `ReadWriteOnce`                             |
| `tikv.persistence.size`          | Size of data volume                        | `8Gi`                                       |
| `tikv.resources`                 | CPU/Memory resource requests/limits        | Memory: `128Mi`, CPU: `100m`                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. 

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-incubator/tidb
```

> **Tip**: You can use the default [values.yaml](values.yaml)


```

## Persistence

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can be defined.

### Existing PersistentVolumeClaims

1. Create the PersistentVolume
1. Create the PersistentVolumeClaim
1. Install the chart
```bash
$ helm install --set persistence.existingClaim=PVC_NAME banzaicloud-incubator/tidb
```
