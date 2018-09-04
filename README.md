## Banzai Cloud Helm charts

At Banzai Cloud we use Helm as our package manager to deploy Kubernetes applications. This is a collection of curated Banzai Cloud Helm charts being part of our PaaS, Pipeline. 

>We made Helm deployments available through a RESTful API as well - [Helm via REST](https://banzaicloud.com/blog/helm-rest-api/)

### Testing

Helm has some `requirements` for testing charts which can be cumbersome or requires resources developers might not have on their laptop. We have automated testing of Helm charts from a **feature** branch. 

Charts are automatically pushed to the Banzai cloud S3 repository from every feature branch. e.g.:

- stable charts from branch `master` are pushed to `http://kubernetes-charts.banzaicloud.com/branch/master`

These charts can be used from any `helm` environment manually by adding them as a new repo with (*note the `/` at the end of the URL*):

```
helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
```

If you want to test on a Pipeline cluster from the control plane make sure to set `HELM_HOME` and `KUBECONFIG` before issuing `helm` commands.

Or if you want to test it from Pipeline, you can do it by specifying the following environment variable:

```
PIPELINE_HELM_BANZAIREPOSITORYURL="http://kubernetes-charts.banzaicloud.com/branch/master"
```

Clusters created with Pipeline will add this Helm repo as `banzaicloud-stable`.

