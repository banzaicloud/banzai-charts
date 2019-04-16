# HPA operator Chart

HPA operator (https://github.com/banzaicloud/hpa-operator) takes care of creating, deleting, updating HPA, with other words keeping in sync with your deployment annotations.

## Installing the Chart

To install the chart:

```
$ helm install banzaicloud-stable/hpa-operator
```

Installing chart with enabled PodSecurityPolicy:
```
$ helm install banzaicloud-stable/hpa-operator --set pspEnabled=true --set kube-metrics-adapter.pspEnabled=true
```

## Notes
