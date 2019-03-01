# Cadence

[Cadence](https://cadenceworkflow.io/) Cadence is a distributed, scalable, durable, and highly available orchestration engine to execute asynchronous long-running business logic in a scalable and resilient way.

## TL;DR;

```bash
$ helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
$ helm install --namespace kubeless incubator/cadence
```

## Introduction

This chart bootstraps a [Cadence](https://github.com/uber/cadence) and a [Cadence-UI](https://github.com/uber/cadence-web) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.7+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release --namespace cadence incubator/cadence
```

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Configuration

The following table lists the configurable parameters of the Kubeless chart and their default values.

| Parameter                                                         | Description                                | Default                                   |
| ----------------------------------------------------------------- | ------------------------------------------ | ----------------------------------------- |
| `rbac.create`                                                     | Create RBAC backed ServiceAccount          | `false`                                   |
| `config.builderImage`                                             | Function builder image                     | `kubeless/function-image-builder`         |
| `config.builderImagePullSecret`                                   | Secret to pull builder image               | ""                                        |
| `config.builderImage`                                             | Provision image                            | `kubeless/unzip`                          |
| `config.builderImagePullSecret`                                   | Secret to pull provision image             | ""                                        |
| `config.deploymentTemplate`                                       | Deployment template for functions          | `{}`                                      |
| `config.enableBuildStep`                                          | Enable builder functionality               | `false`                                   |
| `config.functionRegistryTLSVerify`                                | Enable TLS verification for image registry | `{}`                                      |
| `config.runtimeImages`                                            | Runtimes available                         | python, nodejs, ruby, php and go          |
| `controller.deployment.functionController.image.repository`       | Function Controller image                  | `kubeless/function-controller`            |
| `controller.deployment.functionController.image.pullPolicy`       | Function Controller image pull policy      | `IfNotPresent`                            |
| `controller.deployment.httpTriggerController.image.repository`    | HTTP Controller image                      | `bitnami/bitnami/http-trigger-controller` |
| `controller.deployment.httpTriggerController.image.pullPolicy`    | HTTP Controller image pull policy          | `IfNotPresent`                            |
| `controller.deployment.cronJobTriggerController.image.repository` | CronJob Controller image                   | `bitnami/cronjob-trigger-controller`      |
| `controller.deployment.cronJobTriggerController.image.pullPolicy` | CronJob Controller image pull policy       | `IfNotPresent`                            |
| `controller.deployment.replicaCount`                              | Number of replicas                         | `1`                                       |
| `ui.enabled`                                                      | Kubeless UI component                      | `false`                                   |
| `ui.deployment.ui.image.repository`                               | Kubeless UI image                          | `bitnami/kubeless-ui`                     |
| `ui.deployment.ui.image.pullPolicy`                               | Kubeless UI image pull policy              | `IfNotPresent`                            |
| `ui.deployment.proxy.image.repository`                            | Proxy image                                | `kelseyhightower/kubectl`                 |
| `ui.deployment.proxy.image.pullPolicy`                            | Proxy image pull policy                    | `IfNotPresent`                            |
| `ui.deployment.replicaCount`                                      | Number of replicas                         | `1`                                       |
| `ui.service.name`                                                 | Service name                               | `ui-port`                                 |
| `ui.service.type`                                                 | Kubernetes service name                    | `NodePort`                                |
| `ui.service.externalPort`                                         | Service external port                      | `3000`                                    |
| `ui.ingress.enabled`                                              | Kubeless UI ingress switch                 | `false`                                   |
| `ui.ingress.annotations`                                          | Kubeless UI ingress annotations            | `{}`                                      |
| `ui.ingress.path`                                                 | Kubeless UI ingress path                   | `{}`                                      |
| `ui.ingress.hosts`                                                | Kubeless UI ingress hosts                  | `[chart-example.local]`                   |
| `ui.ingress.tls`                                                  | Kubeless UI ingress TLS                    | `[]`                                      |
| `kafkaTrigger.enabled`                                            | Kubeless Kafka Trigger                     | `false`                                   |
| `kafkaTrigger.env.kafkaBrokers`                                   | Kafka Brokers Environment Variable         | `localhost:9092`                          |
| `kafkaTrigger.deployment.ui.image.repository`                     | Kubeless Kafka Trigger image               | `bitnami/kubeless-ui`                     |
| `kafkaTrigger.deployment.ui.image.pullPolicy`                     | Kubeless Kafka Trigger image pull policy   | `IfNotPresent`                            |
| `kafkaTrigger.deployment.ui.image.tag`                            | Kubeless Kafka Trigger image tag           | `v1.0.0-alpha.3`                          |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release --set service.name=ui-service,service,externalPort=4000 --namespace kubeless incubator/kubeless
```

The above command sets the Kubeless service name to `ui-service` and the external port to `4000`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml --namespace kubeless incubator/kubeless
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Kubeless UI

The [Kubeless UI](https://github.com/kubeless/kubeless-ui) component is disabled by default. In order to enable it set the ui.enabled property to true. For example,

```bash
$ helm install --name my-release --set ui.enabled=true --namespace kubeless incubator/kubeless
```
