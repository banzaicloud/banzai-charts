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