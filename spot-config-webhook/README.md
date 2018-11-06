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