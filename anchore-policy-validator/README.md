# anchore-policy-validator

This chart deploy an admission-server that is used as a ValidatingWebhook in a k8s cluster. If it's working, kubernetes will send requst to admission server when a Pod creation is initiated. The server check image, which is defined in PodSpec, against configured Anchore-engine API. If API response that image not valid according to defined policy, k8s will reject Pod creation request.

## Installing the Chart

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

Deploying Anchore-engine as a dependency managed in the chart:

```bash
$ helm install --name <name> stable/anchore-policy-validator
```


Using external Anchore-engine service:

```bash
$ helm install --name <name> --set externalAnchore.enabled=True --set externalAnchore.anchoreHost=<my.anchore.host>  --set externalAnchore.anchoreUser=<username> -set externalAnchore.anchorePass=<password> stable/anchore-policy-validator
```

## Configuration

The following tables lists configurable parameters of the anchore-policy-validator chart and their default values.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
|replicaCount                         |number of replicas                           |1                                         |
|logVerbosity                         |log verbosity level                          |8                                         |
|apiService.group                     |group of registered api service              |admission.anchore.io                      |
|apiService.version                   |version of registered api service            |v1beta1                                   |
|image.repository                     |admission-server image repo                  |viglesiasce/anchore-image-admission-server|
|image.tag                            |admission-server image tag                   |latest                                    |
|image.pullPolicy                     |admission-server image pull policy           |IfNotPresent                              |
|service.name                         |validation sevice name                       |anchoreimagecheck                         |
|service.type                         |validation service type                      |ClusterIP                                 |
|service.externalPort                 |validation service external port             |443                                       |
|service.internalPort                 |validation service external port             |443                                       |
|anchore-engine.enabled               |enable anchore-engine deploy                 |true                                      |
|externalAnchore.enabled              |enable external anchore-engine usage         |false                                     |
|externalAnchore.anchoreHost          |external anchore-engine host                 |""                                        |
|externalAnchore.anchoreUser          |external anchore-engine username             |""                                        |
|externalAnchore.anchorePass          |external anchore-engine password             |""                                        |


This chart based on:
[Vic Iglesias' kubernetes-anchore-image-validator](https://github.com/viglesiasce/kubernetes-anchore-image-validator)
