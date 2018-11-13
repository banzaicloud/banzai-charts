# Spot config webhook

This chart will install a mutating admission webhook, that annotates pods in a deployment with a specific annotation that works with BanzaiCloud's spot-scheduler.
Pods are annotated based on a specific configmap that's updated by Pipeline.
The webhook also sets "spot-scheduler" as `schedulerName` for these pods.

## Installing the Chart

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

```bash
$ helm install --name <name> banzaicloud-stable/spot-config-webhook
```

## Configuration

The following tables lists configurable parameters of the spot-config-webhook chart and their default values.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
|replicaCount                         |number of replicas                           |1                                         |
|logVerbosity                         |log verbosity level                          |8                                         |
|apiService.group                     |group of registered api service              |admission.banzaicloud.com                 |
|apiService.version                   |version of registered api service            |v1beta1                                   |
|apiService.resource                  |api service endpoint where hook is available |spotscheduling                            |
|image.repository                     |image repo that contains the admission server|banzaicloud/spot-config-webhook           |
|image.tag                            |image tag                                    |0.1.0                                     |
|image.pullPolicy                     |image pull policy                            |IfNotPresent                              |
|service.name                         |spot config webhook service name             |spotwebhook                               |
|service.type                         |spot config webhook service type             |ClusterIP                                 |
|service.externalPort                 |spot config webhook service external port    |443                                       |
|service.internalPort                 |spot config webhook service external port    |443                                       |
|webhook.spotAnnotationKey            |annotation key of on-demand percentage       |app.banzaicloud.io/odPercentage           |
|webhook.configMapNamespace           |namespace of configMap that holds spot info  |pipeline-system                           |
|webhook.configMapName                |name of configMap that holds spot info       |spot-deploy-config                        |
|webhook.schedulerName                |name of spot-affinity scheduler              |spot-scheduler                            |
|resources                            |resources to request                         |{}                                        |
|nodeSelector                         |node selector to use                         |{}                                        |
|tolerations                          |tolerations to add                           |[]                                        |
|affinity                             |affinities to use                            |{}                                        |
