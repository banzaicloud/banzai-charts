# Spot scheduler

This chart will install BanzaiCloud's spot-affinity scheduler, a fork of the default Kubernetes scheduler, that is able to schedule a set percent of replicas of a Kubernetes deployment to on-demand AWS instances.

## Installing the Chart

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

```bash
$ helm install --name <name> banzaicloud-stable/spot-scheduler
```

## Configuration

The following tables lists configurable parameters of the anchore-policy-validator chart and their default values.

|               Parameter             |                Description                  |                  Default                 |
| ----------------------------------- | ------------------------------------------- | -----------------------------------------|
|replicaCount                         |number of replicas                           |1                                         |
|image.repository                     |image repo that contains the scheduler       |banzaicloud/spot-scheduler                |
|image.tag                            |image tag                                    |1.10.3                                    |
|image.pullPolicy                     |image pull policy                            |IfNotPresent                              |
|extraArgs                            |map of extra args to add to the scheduler    |feature-gates: PersistentLocalVolumes=false,VolumeScheduling=false|
|resources                            |resources to request                         |{}                                        |
|nodeSelector                         |node selector to use                         |{}                                        |
|tolerations                          |tolerations to add                           |[]                                        |
|affinity                             |affinities to use                            |{}                                        |
|rbac.enabled                         |RBAC                                         |true                                      |
|rbac.psp.enabled                     |PSP enabled                                  |false                                     |
