## Banzai Cloud Helm charts

At Banzai Cloud we use Helm as our package manager to deploy Kubernetes applications. This is a collection of curated Banzai Cloud Helm charts being part of our PaaS, Pipeline. 

>We made Helm deployments available through a RESTful API as well - [Helm via REST](https://banzaicloud.com/blog/helm-rest-api/)

### Chart collections
  
- [Stable](#pipeline)
  - [Drone](stable/drone)
  - [etcd operator](stable/etcd-operator )
  - [etcd](stable/etcd)
  - [Hollowtrees AWS autoscaling exporter](stable/aws-autoscaling-exporter)
  - [Hollowtrees Kubernetes plugin](stable/ht-k8s-action-plugin)
  - [Hollowtrees spot instance recommender](stable/spot-recommender)
  - [Hollowtrees spot termination exporter](stable/termination-exporter)
  - [Kafka](stable/kafka)
  - [OpenFaaS](stable/openfaas)
  - [Pipeline cluster ingress](stable/pipeline-cluster-ingress)
  - [Pipeline cluster ingress](stable/pipeline-cluster-monitor)
  - [Pipeline cluster](stable/pipeline-cluster)
  - [Pipeline control plane](stable/pipeline-cluster-cp)
  - [Pipeline](stable/pipeline)
  - [Spark history server](stable/spark-hs)
  - [Spark resource staging server](stable/spark-rss)
  - [Spark shuffle](stable/spark-shuffle)
  - [Spark](stable/spark)
  - [Vault](stable/vault)
  - [Zeppelin](stable/zeppelin)
- [Incubator](#architecture-overview)


### Testing

Helm has some `requirements` for testing charts which can be cumbersome or requires resources developers might not have on their laptop. We have automated testing of Helm charts from a **feature** branch. 

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

