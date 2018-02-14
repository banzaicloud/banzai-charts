### Testing charts during development from a feature branch

Charts are automatically pushed to the Banzai cloud S3 repository from every feature branch. e.g.:

- stable charts from branch `fb-1` are pushed to `https://s3-eu-west-1.amazonaws.com/kubernetes-charts.banzaicloud.com/branch/fb-1`
- incubator charts from branch `fb-1` are pushed to `https://s3-eu-west-1.amazonaws.com/kubernetes-charts-incubator.banzaicloud.com/branch/fb-1`

These charts can be used from any `helm` environment manually by adding them as a new repo with (*note the `/` at the end of the URL*):

```
helm repo add fb-1-stable http://kubernetes-charts.banzaicloud.com/branch/fb-1/
helm repo add fb-1-incubator http://kubernetes-charts-incubator.banzaicloud.com/branch/fb-1/
```

If you want to test on a Pipeline cluster from the control plane make sure to set `HELM_HOME` and `KUBECONFIG` before issuing `helm` commands.

Or if you want to test it from Pipeline, you can do it by specifying the following environment variable:

```
PIPELINE_HELM_BANZAIREPOSITORYURL="http://kubernetes-charts.banzaicloud.com/branch/fb-1"
```

Clusters created with Pipeline will add this helm repo as `banzaicloud-stable`.