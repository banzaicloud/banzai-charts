# grafana-operator

[grafana-operator](https://github.com/integr8ly/grafana-operator) is an Operator which introduces Lifecycle Management for Grafana Dashboards and Plugins.
This chart is based on bitnami's [grafana-operator]https://github.com/bitnami/charts) chart.

## TL;DR

```bash
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
$ helm repo update
$ helm install banzaicloud-stable/grafana-operator
```

## Introduction

This chart bootstraps a [Grafana Operator]https://github.com/integr8ly/grafana-operator) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
- Kubernetes 1.16+ with Beta APIs enabled


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
$ helm install banzaicloud-stable/grafana-operator
```

### CRDs
Use `createCustomResource=false` with Helm v3 to avoid trying to create CRDs from the `crds` folder and from templates at the same time.

The command deploys **Grafana operator** on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all Kubernetes components associated with the chart and deletes the release.


## Parameters

The following tables lists the configurable parameters of the grafana-operator chart and their default values.

| Parameter                                             | Description                                                                                          | Default                                                 |
|-------------------------------------------------------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `global.imageRegistry`                                | Global Docker image registry                                                                         | `nil`                                                   |
| `global.imagePullSecrets`                             | Global Docker registry secret names as an array                                                      | `[]` (does not add image pull secrets to deployed pods) |
| `image.registry`                                      | Grafana Operator image registry                                                                      | `quay.io`                                             |
| `image.repository`                                    | Grafana Operator image name                                                                          | `integreatly/grafana-operator`                              |
| `image.tag`                                           | Grafana Operator image tag                                                                           | `{TAG_NAME}`                                            |
| `image.pullPolicy`                                    | Grafana Operator image pull policy                                                                   | `IfNotPresent`                                          |
| `image.pullSecrets`                                   | Specify docker-registry secret names as an array                                                     | `[]` (does not add image pull secrets to deployed pods) |
| `replicaCount`                                        | Specify the amount of replicas running                                                               | `1`                                                     |
| `updateStrategy`                                      | Specify the updateStrategy of the containers                                                         | `{"type": "RollingUpdate"}`                             |
| `args.scanAllNamespaces`                              | Specify if all namespace should be scanned for dashboards and datasources. (Creates ClusterRole)     | `false`                                                 |
| `args.scanNamespaces`                                 | Specify the namespaces which should be scanned for dashboards and datasources (Creates ClusterRole)  | `[]` (does not add ClusterRole or Namespaces)           |
| `grafana.image.registry`                              | Grafana image registry                                                                               | `docker.io`                                             |
| `grafana.image.repository`                            | Grafana image name                                                                                   | `grafana/grafana`                                       |
| `grafana.image.tag`                                   | Grafana image tag                                                                                    | `{TAG_NAME}`                                            |
| `grafanaPluginInit.image.registry`                    | Grafana Plugin Init image registry                                                                   | `quay.io`                                               |
| `grafanaPluginInit.image.repository`                  | Grafana Plugin Init image name                                                                       | `integreatly/grafana_plugins_init`                      |
| `grafanaPluginInit.image.tag`                         | Grafana Plugin Init image tag                                                                        | `{TAG_NAME}`                                            |
| `resources.limits`                                    | Specify resource limits which the container is not allowed to succeed.                               | `{}` (does not add resource limits to deployed pods)    |
| `resources.requests`                                  | Specify resource requests which the container needs to spawn.                                        | `{}` (does not add resource limits to deployed pods)    |
| `nodeSelector`                                        | Node labels for controller pod assignment                                                            | `{}`                                                    |
| `tolerations`                                         | Tolerations for controller pod assignment                                                            | `[]`                                                    |
| `affinity`                                            | Affinity for controller pod assignment                                                               | `{}`                                                    |
| `podAnnotations`                                      | Controller Pod annotations                                                                           | `{}`                                                    |
| `serviceAccount.create`                               | create a serviceAccount for the controller pod                                                       | `true`                                                  |
| `serviceAccount.name`                                 | use the serviceAccount with the specified name                                                       | ``                                                      |
| `securityContext.enabled`                             | Enable pods' security context                                                                        | `true`                                                  |
| `securityContext.runAsNonRoot`                        | MetalLB Controller must runs as nonRoot.                                                             | `true`                                                  |
| `securityContext.runAsUser`                           | User ID for the pods.                                                                                | `1001`                                                  |
| `securityContext.runAsGroup`                          | User ID for the pods.                                                                                | `1001`                                                  |
| `securityContext.fsGroup`                             | Group ID for the pods.                                                                               | `1001`                                                  |
| `securityContext.supplementalGroups`                  | Drop capabilities for the securityContext                                                            | `[]`                                                    |
| `speaker.extraEnvVars`                                | Extra environment variable to pass to the running container.                                         | `[]`                                                    |
| `nameOverride`                                        | String to partially override metallb.fullname template with a string (will prepend the release name) | `nil`                                                   |
| `fullnameOverride`                                    | String to fully override metallb.fullname template with a string                                     | `nil`                                                   |
| `livenessProbe.enabled`                               | Enable/disable the Liveness probe                                                                    | `true`                                                  |
| `livenessProbe.initialDelaySeconds`                   | Delay before liveness probe is initiated                                                             | `3`                                                     |
| `livenessProbe.periodSeconds`                         | How often to perform the probe                                                                       | `10`                                                    |
| `livenessProbe.timeoutSeconds`                        | When the probe times out                                                                             | `10`                                                    |
| `livenessProbe.successThreshold`                      | Minimum consecutive successes for the probe to be considered successful after having failed.         | `1`                                                     |
| `livenessProbe.failureThreshold`                      | Minimum consecutive failures for the probe to be considered failed after having succeeded.           | `1`                                                     |
| `readinessProbe.enabled`                              | Enable/disable the Liveness probe                                                                    | `true`                                                  |
| `readinessProbe.initialDelaySeconds`                  | Delay before liveness probe is initiated                                                             | `3`                                                     |
| `readinessProbe.periodSeconds`                        | How often to perform the probe                                                                       | `10`                                                    |
| `readinessProbe.timeoutSeconds`                       | When the probe times out                                                                             | `10`                                                    |
| `readinessProbe.successThreshold`                     | Minimum consecutive successes for the probe to be considered successful after having failed.         | `1`                                                     |
| `readinessProbe.failureThreshold`                     | Minimum consecutive failures for the probe to be considered failed after having succeeded.           | `1`                                                     |
| `rbac.create`                                         | Specify if an rbac authorization should be created with the necessarry Rolebindings.                 | `true`                                                  |
| `prometheus.serviceMonitor.enabled`                   | Specify if a servicemonitor will be deployed for prometheus-operator.                                | `true`                                                  |
| `prometheus.serviceMonitor.jobLabel`                  | Specify the jobLabel to use for the prometheus-operator                                              | `app.kubernetes.io/name`                                |
| `prometheus.serviceMonitor.interval`                  | Specify the scrape interval if not specified use defaul prometheus scrapeIntervall                   | `""`                                                    |
| `prometheus.serviceMonitor.metricRelabelings`         | Specify additional relabeling of metrics.                                                            | `[]`                                                    |
| `prometheus.serviceMonitor.relabelings`               | Specify general relabeling.                                                                          | `[]`                                                    |
| `defaultDashboards.enabled`                           | Enable Default Dashboards                                                                            | `true`                                                  |
| `defaultDashboards.kubeScheduler.enabled`             | Enable kubeScheduler Dashboard                                                                       | `true`                                                  |
| `defaultDashboards.kubelet.enabled`                   | Enable kubelet Dashboard                                                                             | `true`                                                  |
| `defaultDashboards.kubeEtcd.enabled`                  | Enable kubeEtcd Dashboard                                                                            | `true`                                                  |
| `defaultDashboards.kubeControllerManager.enabled`     | Enable kubeControllerManager Dashboard                                                               | `true`                                                  |
| `defaultDashboards.prometheus.prometheusSpec.remoteWriteDashboards`  | Enable Remove Write Protmetheus Dashboards                                            | `false`                                                 |
| `defaultDashboards.nodeExporter.enabled`              | Enable NodeExporter Dashboard                                                                        | `true`                                                  |
| `defaultDeployment.enabled`                           | Enable Default Grafana Instance                                                                      | `true`                                                  |
| `defaultDeployment.ingress.enabled`                   | Enable Default Grafana Instance Ingress                                                              | `false`                                                  |
| `defaultDeployment.ingress.tlsEnabled`                | Enable TLS for default Grafana Instance Ingress                                                      | `true`                                                  |
| `defaultDeployment.ingress.tlsSecretName`             | Set Default Grafana Instance Ingress TLS secret name                                                 | `true`                                                  |
| `defaultDeployment.ingress.annotations`               | Additional annotations for Default Grafana Instance Ingress                                          | `{}`                                                  |
| `defaultDeployment.service.type`                      | Set Default Grafana Instance Service type                                                            | `true`                                                  |
| `defaultDeployment.service.ports[0].name`             | Set Default Grafana Instance Service port name                                                       | `true`                                                  |
| `defaultDeployment.service.ports[0].port`             | Set Default Grafana Instance Service port port                                                       | `true`                                                  |
| `defaultDeployment.service.ports[0].protocol`         | Set Default Grafana Instance Service port protocol                                                   | `true`                                                  |
| `defaultDeployment.service.ports[0].targetPort`       | Set Default Grafana Instance Service port targetPort                                                 | `true`                                                  |
| `defaultDeployment.service.annotations`               | Additional annotations for Default Grafana Instance Service                                          | `{}`                                                  |
| `defaultDeployment.log.mode`                          | Set Default Grafana Instance Log mode                                                                | `console`                                               |
| `defaultDeployment.log.level`                         | Set Default Grafana Instance Log Level                                                               | `warn`                                                  |
| `defaultDeployment.log.level`                         | Set Default Grafana Instance Log Level                                                               | `warn`                                                  |
| `defaultDeployment.security.adminUser`                | Set Default Grafana Instance admin username                                                          | `root`                                                  |
| `defaultDeployment.security.adminPassword`            | Set Default Grafana Instance admin password                                                          | `secret`                                                |
| `defaultDeployment.auth.disableLoginForm`             | Set Default Grafana Instance login form disabled                                                     | `False`                                                 |
| `defaultDeployment.auth.disableSignoutMenu`           | Set Default Grafana Instance signeout menu disabled                                                  | `True`                                                  |
| `defaultDeployment.auth.anonymous`                    | Enable Default Grafana Instance anonymous login                                                      | `False`                                                 |
| `defaultDeployment.dashboardLabelSelector`            | GrafanaDashboards to select for discovery via matchExpressions or matchLabels                        | `{{ .Release.Name }}` (just the default dashboards)     |
| `defaultDeployment.resources`                         | Set Default Grafana Instance resources                                                               | `{}`                                                    |
| `defaultDatasouce.enabled`                            | Enable Default Datasource                                                                            | `true`                                                  |
| `defaultDatasouce.name`                               | Set Default Datasource Name                                                                          | `Prometheus`                                            | 
| `defaultDatasouce.type`                               | Set Default Datasource type                                                                          | `prometheus`                                            |
| `defaultDatasouce.access`                             | Set Default Datasource access                                                                        | `proxy`                                                 |
| `defaultDatasouce.url`                                | Set Default Datasource URL                                                                           | `http://monitor-prometheus-operato-prometheus:9090`     |
| `defaultDatasouce.isDefault`                          | Set Default Datasource default flag                                                                  | `true`                                                  |
| `defaultDatasouce.version`                            | Set Default Datasource default version                                                               | `1`                                                     |
| `defaultDatasouce.editable`                           | Set Default Datasource editable                                                                      | `true`                                                  |
| `defaultDatasouce.jsonData.tlsSkipVerify`             | Enable Default Datasource TLS Skip Verify                                                            | `true`                                                  |
| `defaultDatasouce.jsonData.timeInterval`              | Set Default Datasource Time Interval                                                                 | `5s`                                                    |


Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

```bash
$ helm install --name my-release -f values.yaml banzaicloud-stable/grafana-operator
```

> **Tip**: You can use the default [values.yaml](values.yaml)


### Dashboard 
After the installation you can create your Dashboards under a CRD of your kubernetes cluster.

For more details regarding what is possible with those CRDs please have a look at [Docs](https://github.com/integr8ly/grafana-operator/blob/master/documentation/dashboards.md)

