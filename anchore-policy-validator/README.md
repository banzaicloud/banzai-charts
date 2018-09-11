# Anchore policy validator

This chart deploys an admission-server that is used as a ValidatingWebhook in a k8s cluster. If it's working, kubernetes will send requests to the admission server when a Pod creation is initiated. The server checks the image, which is defined in PodSpec, against configured Anchore-engine API. If the API responds with an error, that the image is not valid according to defined policy, k8s will reject the Pod creation request.

## Installing the Chart

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

Deploying anchore-policy-validator using external Anchore-engine service:

```bash
$ helm install --name <name> --set externalAnchore.anchoreHost=<my.anchore.host>  --set externalAnchore.anchoreUser=<username> -set externalAnchore.anchorePass=<password> stable/anchore-policy-validator
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
|externalAnchore.anchoreHost          |external anchore-engine host                 |""                                        |
|externalAnchore.anchoreUser          |external anchore-engine username             |""                                        |
|externalAnchore.anchorePass          |external anchore-engine password             |""                                        |

[Due to some resource create with jobs, these resources has to be deleted by manually.](README-dev.md)

This chart based on:
[Vic Iglesias' kubernetes-anchore-image-validator](https://github.com/viglesiasce/kubernetes-anchore-image-validator)
