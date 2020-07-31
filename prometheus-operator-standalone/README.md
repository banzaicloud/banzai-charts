# Prometheus operator standalone

This is a stripped down version of the upstream prometheus-operator chart.

This chart can be used to install the prometheus operator only, additionally using
the `.Values.prometheusOperator.customResourceGroupRemap` settings you can make it
coexist with any prometheus operator already installed in the target system.

For example this values.yaml

```yaml

prometheusOperator:
    createCustomResource: true
    customResourceGroupRemap:
        enabled: true
        newGroup: "monitoring.backyards.banzaicloud.io"

```

Will result in a setup that the usual monitoring CRDs will have a group name of
`monitoring.backyards.banzaicloud.io`. In this setup to define a new Prometheus you
will need to use the `monitoring.backyards.banzaicloud.io/v1/Prometheus` object.

To achieve this effect, we are relying on [k8s-proxy](https://github.com/banzaicloud/k8s-proxy)
