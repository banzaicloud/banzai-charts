# Anchore Engine Helm Chart

This chart deploys the Anchore Engine docker container image analysis system. Anchore Engine
requires a PostgreSQL database (>=9.6) which may be handled by the chart or supplied externally,
and executes in a 2-tier architecture with an api/control layer and a batch execution worker pool layer.

See [Anchore Engine](https://github.com/anchore/anchore-engine) for more project details.


## tl;dr:

The chart is split into three primary sections: GlobalConfig, CoreConfig, WorkerConfig. As the name implies,
the GlobalConfig is for configuration values that all components require, while the Core and Worker sections are
tier-specific and allow customization for each role.

NOTE: It is highly recommended to set a non-default password when deploying. The admin password is set to a default in the chart. To customize it use:
 `--set globalConfig.users.admin.password=<pass>` or set it in the values.yaml locally.


### Core Role
The core services provide the apis and state management for the system. Core services must be available within the cluster
for use by the workers.
* Core component provides webhook calls to external services for notifications of events:
  * New images added
  * CVE changes in images
  * Policy evaluation state change for an image


### Worker Role
The workers download and analyze images and upload results to the core services. The workers poll the queue service and
do not have their own external api.


## Installing the Chart

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

Deploying PostgreSQL as a dependency managed in the chart:

```bash
$ helm install --name <name> banzaicloud-stable/anchore-engine
```


Using GKE Cloudsql (PostgreSQL) service:

```bash
$ helm install --name <name> --set postgresql.enabled=False --set cloudsql.enabled=True banzaicloud-stable/anchore-engine
```


## Configuration

The following tables lists the main configurable parameters of the anchore-engine chart and their default values.

|               Parameter             |                Description                  |                  Default              |
| ----------------------------------- | ------------------------------------------- | ------------------------------------- |
|service.type                         |service type                                 |ClusterIP                              |
|service.ports.api                    |anchore-engine api port                      |8228                                   |
|image.repository                     |anchore-engine image repo                    |"docker.io/anchore/anchore-engine"     |
|image.tag                            |anchore-engine image tag                     |"v0.2.3"                               |
|image.pullPolicy                     |anchore-engine image pull policy             |IfNotPresent                           |
|ingress.enable                       |enable ingress                               |false                                  |
|ingress.annotations                  |ingress annotations                          |{}                                     |
|ingress.hosts                        |ingress hosts definitions                    |"/"                                    |
|ingress.tls                          |ingress tls                                  |[]                                     |
|postgresql.enabled                   |Deploy postgres pod                          |true                                   |
|postgresql.externalEndpoint          |use external PostgreSQL db                   |null                                   |
|postgresUser                         |postgres username                            |postgres                               |
|postgresPassword                     |postgres password                            |anchore                                |
|postgresDatabase                     |postgres database name                       |anchore                                |
|cloudsql.enable                      |use GKE cloudsql instead of local postgres   |false                                  |
|cloudsql.instance                    |Cloudsql instance                            |""                                     |
|cloudsql.image.repository            |Cloudsql proxy image repo                    |gcr.io/cloudsql-docker/gce-proxy       |
|cloudsql.image.tag                   |Cloudsql proxy image tag                     |1.11                                   |
|cloudsql.image.pullPolicy            |Cloudsql proxy image pull policy             |IfNotPresent                           |
|coreConfig.policyBundleSyncEnabled   |sync policy bundles from anchore.io          |false                                  |
|globalConfig.enableMetrics           |export prometheus metrics                    |false                                  |


## Adding Core Components

To set a specific number of core service containers:

```bash
$ helm install banzaicloud-stable/anchore-engine --set coreConfig.replicaCount=2
```

To update the number in a running configuration:

```bash
$ helm upgrade --set coreConfig.replicaCount=2 <releasename> banzaicloud-stable/anchore-engine <-f values.yaml>
```

## Adding Workers

To set a specific number of workers once the service is running:

If using defaults from the chart:

```bash
$ helm upgrade --set workerConfig.replicaCount=2 <releasename> banzaicloud-stable/anchore-engine
```

If customized values, use the local directory for the chart values:

```bash
$ helm upgrade --set workerConfig.replicaCount=2 <releasename> ./anchore-engine
```

To launch with more than one worker you can either modify values.yaml or run with:

```bash
$ helm install --set workerConfig.replicaCount=2 banzaicloud-stable/anchore-engine
```