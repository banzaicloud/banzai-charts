# Istio-operator chart

[Istio-operator](https://github.com/banzaicloud/istio-operator) is a Kubernetes operator to deploy and manage [Istio](https://istio.io/) resources for a Kubernetes cluster.


## Prerequisites

- Kubernetes 1.10.0+


## Installing the chart

To install the chart:

```
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm install --name=istio-operator --namespace=istio-system banzaicloud-stable/istio-operator
```


## Uninstalling the Chart

To uninstall/delete the `istio-operator` release:
```
$ helm del --purge istio-operator
```
The command removes all the Kubernetes components associated with the chart and deletes the release.
