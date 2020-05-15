# Supertubes Control-Plane chart

## Prerequisites

- Kubernetes 1.15.0+

## Installing the chart

To install the chart:

```
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
$ helm install supertubes-control-plane banzaicloud-stable/supertubes-control-plane
```

## Uninstalling the Chart

To uninstall/delete the `supertubes-control-plane` release:

```
$ helm delete supertubes-control-plane
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Banzaicloud Supertubes Control-plane chart and their default values.

Parameter | Description | Default
--------- | ----------- | -------
`imagePullSecrets` | Image pull secrets can be set | `[]`
`replicaCount` | Operator replica count can be set | `1`
`nameOverride` | Release name can be overwritten | `""`
`fullnameOverride` | Release full name can be overwritten | `""`
`crd.create` | Create CRDs | `true`
`webhook.certs.generate` | Helm chart will generate cert for the webhook | `true`
`webhook.certs.secret` | Helm chart will use the secret name applied here for the cert | `supertubes-manifest-controller-serving-cert`
`rbac.create` | Create rbac service account and roles | `true`
`operator.image.repository` | Operator container image repository | `banzaicloud/supertubes-manifest-controller`
`operator.image.tag` | Operator container image tag | `v0.1.0`
`operator.image.pullPolicy` | Operator container image pull policy | `IfNotPresent`
`operator.resources` | Resource limits for supertubes-control-plane | `{limits: cpu: 200m memory:256Mi requests: cpu:100m memory:128Mi}`
`prometheusMetrics.enabled` | If true, use direct access for Prometheus metrics | `false`
`prometheusMetrics.authProxy.enabled` | If true, use auth proxy for Prometheus metrics | `true`
`prometheusMetrics.authProxy.image.repository` | Auth proxy container image repository | `gcr.io/kubebuilder/kube-rbac-proxy`
`prometheusMetrics.authProxy.image.tag` | Auth proxy container image tag | `v0.4.0`
`prometheusMetrics.authProxy.image.pullPolicy` | Auth proxy container image pull policy | `IfNotPresent`
