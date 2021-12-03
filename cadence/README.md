# Cadence

[Cadence](https://cadenceworkflow.io/)  is a distributed, scalable, durable, and highly available orchestration engine to execute asynchronous long-running business logic in a scalable and resilient way.


## TL;DR;

```bash
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
$ helm repo update
```


## Introduction

This chart bootstraps a [Cadence](https://github.com/uber/cadence) and a [Cadence-UI](https://github.com/uber/cadence-web) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.7+ with Beta APIs enabled
- Cadence 0.23.0+


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release --namespace cadence banzaicloud-stable/cadence
```

> **Tip**: List all releases using `helm list`


## Upgrading Chart

```console
# Helm
$ helm upgrade [RELEASE_NAME] banzaicloud-stable/cadence
```

### From 0.20.x (or below) to 0.21.y (or above)

Version 0.21.0 extends the configuration interface by introducing
`clusterMetadata` settings to the `values.yaml` in a backward incompatible
manner with existing Cadence clusters.

To upgrade the Cadence deployment under **existing** Cadence clusters from
version 0.20.x (or below) to 0.21.y (or above) you **MUST** set the existing
cluster's configuration in the `values.yaml` file's
`.server.config.clusterMetadata` section to be used for the upgrade.

#### Example configuration for upgrading from version 0.16.x (or below)

```yaml
server:
  # ...
  config:
    clusterMetadata:
      enableGlobalDomain: true
      maximumClusterCount: 10
      masterClusterName: "active"
      currentClusterName: "active"
      clusterInformation:
        - name: active
          enabled: true
```

#### Example configuration for upgrading from version 0.17.x

```yaml
server:
  # ...
  config:
    clusterMetadata:
      enableGlobalDomain: true
      maximumClusterCount: 10
      masterClusterName: "master"
      currentClusterName: "master"
      clusterInformation:
        - name: master
          enabled: true
```

#### Example configuration for upgrading from 0.18.x (or above), single Cadence cluster

```yaml
server:
  # ...
  config:
    clusterMetadata:
      enableGlobalDomain: true
      maximumClusterCount: 10
      masterClusterName: "primary"
      currentClusterName: "primary"
      clusterInformation:
        - name: primary
          enabled: true
```

#### Example configuration for upgrading from 0.18.x (or above), multiple Cadence clusters

```yaml
server:
  # ...
  config:
    clusterMetadata:
      enableGlobalDomain: true
      maximumClusterCount: 10
      masterClusterName: "primary"
      currentClusterName: "primary" # "secondary" # Note: use the name of the Cadence cluster you are using on the cluster/namespace/release you are upgrading.
      clusterInformation:
        - name: primary
          enabled: true
        - name: secondary
          enabled: true
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Install the Chart with Cassandra

The chart comes with a single node Cassandra by default (from [incubator/cassandra](https://github.com/helm/charts/tree/master/incubator/cassandra)).

```bash
$ helm install banzaicloud-stable/cadence
```

You can increase the number of Cassandra nodes if you want:

```bash
$ helm install --set cassandra.config.cluster_size=3 banzaicloud-stable/cadence
```

> **Note:** It takes a few minutes to start Cassandra. You can speed it up by using configuration from `values.dev.yaml`.


## Configure the Chart to use existing Cassandra cluster

You can configure the chart to use an existing Cassandra cluster instead of installing one.

**Prerequisites:**

- Running Cassandra cluster
- Existing keyspaces for *default* and *visibility* stores
- Existing user(s) with access to those keyspaces (if authentication is required)

You can easily start your own Cassandra cluster using the same [incubator/cassandra](https://github.com/helm/charts/tree/master/incubator/cassandra) chart:

```bash
$ helm install -f values/cassandra.yaml --name cassandra incubator/cassandra
```

Wait for Cassandra to become ready:

```bash
$ kubectl wait --for=condition=Ready pod/cassandra-0 --timeout=90s
```

Create two Cassandra keyspaces:

```bash
$ kubectl exec -it cassandra-0 -- cqlsh -e "CREATE KEYSPACE cadence WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };"
$ kubectl exec -it cassandra-0 -- cqlsh -e "CREATE KEYSPACE cadence_visibility WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };"
```

```bash
$ helm install -f values/values.cassandra.yaml banzaicloud-stable/cadence
```

Alternatively, install the chart with manual migrations. Follow the steps in [migrations.md](migrations.md).

```bash
$ helm install -f values/values.cassandra.yaml --set schema.setup.enabled=false --set schema.update.enabled=false banzaicloud-stable/cadence
```


## Install the Chart with MySQL

> **Note:** MySQL support is currently *beta* in Cadence.

The chart can be installed with a single node MySQL (from [stable/mysql](https://github.com/helm/charts/tree/master/stable/mysql)).

```bash
$ helm install --set cassandra.enabled=false --set mysql.enabled=true --set mysql.mysqlPassword=cadence banzaicloud-stable/cadence
```

> **Note:** When installing MySQL from within the chart with automatic migrations, you **must** configure a password.
> See the [Limitations](#limitations) section for details.


## Configure the Chart to use existing MySQL instance

You can configure the chart to use an existing MySQL instance instead of installing one.

**Prerequisites:**

- Running MySQL instance
- Existing databases for *default* and *visibility* stores
- Existing user(s) with access to those databases

You can easily start your own MySQL instance using the same [stable/mysql](https://github.com/helm/charts/tree/master/stable/mysql) chart:

```bash
$ helm install -f values/mysql.yaml --name mysql stable/mysql
```

Wait for MySQL to become ready:

```bash
$ kubectl wait --for=condition=Ready pod/$(kubectl get pods -l 'app=mysql' -o jsonpath='{..metadata.name}') --timeout=90s
```

```bash
$ helm install -f values/values.mysql.yaml banzaicloud-stable/cadence
```

Alternatively, install the chart with manual migrations. Follow the steps in [migrations.md](migrations.md).

```bash
$ helm install -f values/values.mysql.yaml --set schema.setup.enabled=false --set schema.update.enabled=false banzaicloud-stable/cadence
```


## Prometheus monitoring

As of 0.5.8 Cadence exports Prometheus metrics. The chart supports annotating Cadence components with Prometheus annotations,
so that Prometheus can scrape them:

```bash
$ helm install --set server.metrics.annotations.enabled=true banzaicloud-stable/cadence
```

Alternatively, you can enable ServiceMonitor when using [Prometheus Operator](https://github.com/coreos/prometheus-operator):

```bash
$ helm install --set server.metrics.serviceMonitor.enabled=true banzaicloud-stable/cadence
```

Note that you can enable monitoring for each service separately. See the configuration reference bellow.


## Scaling Cadence

Cadence server components (frontend, history, matching, worker) are executed in separate Deployments, so scaling them separately is possible.
However you can decide to apply the same replica count to each service (just like in case of resource limits and taint/affinity settings).

See the configuration reference bellow for details.


## Recommended setup

The chart is self-contained, meaning it installs everything required for running the application by default.
It can install Cassandra (default) or MySQL,
but it is recommended that you configure every component and run migrations manually.

See [values.prod.yaml](values.prod.yaml) for details of a production setup.

See [migrations.md](migrations.md) for running migrations manually.


## Limitations

In order to use the automatic migration feature, you have to manually set credentials for the chosen storage type (if there is any).
The default Cassandra store is installed without password, but for MySQL to work you have to set `mysql.mysqlPassword` manually (if you install a storage engine from within the chart).

The reason behind this limitation is that migrations are executed as helm hooks, which needs the credentials before MySQL is even started.


## Port forwarding to Cadence frontend

As of version 0.5.1 of this chart service (frontend, history, matching, worker) pods use the [pod IP as bind address](https://github.com/banzaicloud/banzai-charts/pull/997).

This is a limitation of how Cadence cluster membership works and is required for scaling Cadence components.

Unfortunately, this change caused `kubectl port-forward` directly to Cadence pods to stop working.

If you need to port forward to any of the components (eg. to create a domain), you can use a `socat` sidecar container
(for example by installing and configuring the [stable/socat-tunneller](https://hub.helm.sh/charts/stable/socat-tunneller) chart):

```bash
helm install stable/socat-tunneller --name cadence-frontend-tunnel --set tunnel.host=cadence-frontend --set tunnel.port=7933 --set nameOverride=cadence-frontend-tunnel
```

Then you can port-forward to this tunnel:

```bash
kubectl port-forward svc/cadence-frontend-tunnel 7933:7933
```

and create a domain:

```bash
docker run --rm ubercadence/cli:master --address host.docker.internal:7933 --domain samples-domain domain register --global_domain false
```

## Metrics

Note: from chart version 0.19.0, the metrics collection services (Prometheus,
StatsD) are mutually exclusive - only one of those can be enabled at the same
time based on the values configuration. The default configuration enables
Prometheus.

If you want to enable StatsD (and disable Prometheus), you may edit the global
metrics configuration values accordingly. If you want to use them in a mixed
fashion, make sure to disable both in the global metrics configuration values
and enable the desired one in the service-specific configuration values (this is
required, because global configurations take precedence over service-specific
configurations).

## Configuration

The following table lists the configurable parameters of the chart and their default values.
Global options overridable per service are marked with an asterisk.

| Parameter                                         | Description                                           | Default               |
|---------------------------------------------------|-------------------------------------------------------|-----------------------|
| `nameOverride`                                    | Override name of the application                      | ``                    |
| `fullnameOverride`                                | Override full name of the application                 | ``                    |
| `server.image.repository`                         | Server image repository                               | `ubercadence/server`  |
| `server.image.tag`                                | Server image tag                                      | `0.23.2`              |
| `server.image.pullPolicy`                         | Server image pull policy                              | `IfNotPresent`        |
| `server.replicaCount`*                            | Server replica count                                  | `1`                   |
| `server.metrics.annotations.enabled`*             | Annotate pods with Prometheus annotations             | `false`               |
| `server.metrics.serviceMonitor.enabled`*          | Enable Prometheus ServiceMonitor                      | `false`               |
| `server.metrics.prometheus.timerType`*            | Prometheus timer type                                 | `histogram`           |
| `server.metrics.statsd.hostPort`*                 | Statsd daemon host and port                           | ``                    |
| `server.podAnnotations`*                          | Server pod annotations                                | `{}`                  |
| `server.podSecurityContext`*                      | Server pod security context                           | `{}`                  |
| `server.securityContext`*                         | Server security context                               | `{}`                  |
| `server.resources`*                               | Server CPU/Memory resource requests/limits            | `{}`                  |
| `server.nodeSelector`*                            | Node labels for pod assignment                        | `{}`                  |
| `server.tolerations`*                             | Toleration labels for pod assignment                  | `[]`                  |
| `server.affinity`*                                | Affinity settings for pod assignment                  | `{}`                  |
| `server.config.logLevel`                          | Server log level                                      | `debug,info`          |
| `server.config.numHistoryShards`                  | Number of history shards                              | `1000`                |
| `server.config.persistence.[store].driver`        | Connection driver                                     | `cassandra`           |
| `server.config.persistence.[store].cassandra`     | Cassandra connection details (see `values.yaml`)      | `{}`                  |
| `server.config.persistence.[store].sql`           | SQL connection details (see `values.yaml`)            | `{}`                  |
| `server.[service].service.type`                   | `[service]` service type                              | `ClusterIP`           |
| `server.[service].service.port`                   | `[service]` service port                              | `7933/7934/7935/7939` |
| `server.[service].service.annotations`            | `[service]` service annotations                       | `{}`                  |
| `server.[service].metrics.annotations.enabled`    | Annotate `[service]` pods with Prometheus annotations | ``                    |
| `server.[service].metrics.serviceMonitor.enabled` | Enable Prometheus ServiceMonitor for `[service]`      | ``                    |
| `server.[service].metrics.prometheus.timerType`   | `[service]` Prometheus timer type                     | ``                    |
| `server.[service].metrics.statsd.hostPort`        | `[service]` Statsd daemon host and port               | ``                    |
| `server.[service].podAnnotations`                 | `[service]` pod annotations                           | `{}`                  |
| `server.[service].podSecurityContext`             | `[service]` pod security context                      | `{}`                  |
| `server.[service].securityContext`                | `[service]` security context                          | `{}`                  |
| `server.[service].resources`                      | `[service]` CPU/Memory resource requests/limits       | `{}`                  |
| `server.[service].nodeSelector`                   | `[service]` Node labels for pod assignment            | `{}`                  |
| `server.[service].tolerations`                    | `[service]` Toleration labels for pod assignment      | `[]`                  |
| `server.[service].affinity`                       | `[service]` Affinity settings for pod assignment      | `{}`                  |
| `server.frontend.service.nodePort`                | frontend service nodePort, if service type is NodePort| ``                    |
| `web.enabled`                                     | Enable WebUI service                                  | `true`                |
| `web.replicaCount`                                | Number of WebUI service Replicas                      | `1`                   |
| `web.image.repository`                            | WebUI image repository                                | `ubercadence/web`     |
| `web.image.tag`                                   | WebUI image tag                                       | `3.29.5`              |
| `web.image.pullPolicy`                            | WebUI image pull policy                               | `IfNotPresent`        |
| `web.service.annotations`                         | WebUI service annotations                             | `{}`                  |
| `web.service.type`                                | WebUI service type                                    | `ClusterIP`           |
| `web.service.port`                                | WebUI service port                                    | `80`                  |
| `web.service.nodePort`                            | WebUI service nodePort, if service type is NodePort   | ``                    |
| `web.ingress.enabled`                             | Enable WebUI Ingress                                  | `false`               |
| `web.ingress.annotations`                         | WebUI Ingress annotations                             | `{}`                  |
| `web.ingress.hosts`                               | WebUI Ingress hosts                                   | `/`                   |
| `web.ingress.tls`                                 | WebUI Ingress tls config                              | `[]`                  |
| `web.podSecurityContext`                          | WebUI pod security context                            | `{}`                  |
| `web.securityContext`                             | WebUI security context                                | `{}`                  |
| `web.resources`                                   | WebUI CPU/Memory resource requests/limits             | `{}`                  |
| `web.nodeSelector`                                | Node labels for pod assignment                        | `{}`                  |
| `web.tolerations`                                 | Toleration labels for pod assignment                  | `[]`                  |
| `web.affinity`                                    | Affinity settings for pod assignment                  | `{}`                  |
| `schema.setup.enabled`                            | Create database or keyspace                           | `true`                |
| `schema.setup.backoffLimit`                       | Create database job back off limit                    | `100`                 |
| `schema.update.enabled`                           | Update schema                                         | `true`                |
| `schema.update.backoffLimit`                      | Update schema job back off limit                      | `100`                 |
| `cassandra.enabled`                               | Install Cassandra cluster                             | `true`                |
| `cassandra.config.cluster_size`                   | Cassandra cluster node number                         | `1`                   |
| `mysql.enabled`                                   | Install MySQL                                         | `false`               |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```bash
$ helm install --name my-release --set server.image.tag=0.7.1 banzaicloud-stable/cadence
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```bash
$ helm install --name my-release --values values.yaml banzaicloud-stable/cadence
```

## Contributing

### Chart upgrade

For contributions involving an upgrade to the Cadence server version or
modifying the chart and subsequently releasing new chart versions, please refer
to the [Cadence chart upgrade documentation](docs/cadence_chart_upgrade.md)
