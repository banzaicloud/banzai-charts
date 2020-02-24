## Helm Charts Repository

The official Banzai Cloud Helm Charts repository.

At Banzai Cloud we use Helm as our package manager to deploy Kubernetes applications. This is a collection of curated Banzai Cloud Helm charts being part of our PaaS, Pipeline. 

>We made Helm deployments available through a RESTful API as well - [Helm via REST](https://banzaicloud.com/blog/helm-rest-api/)

## Install Helm

Get the latest [Helm release](https://github.com/kubernetes/helm#install).

For more information on using Helm, refer to the [Helm's documentation](https://github.com/kubernetes/helm#docs).

## How do I install these charts?

To add the Banzai Cloud charts for your local client, run `helm repo add`:

```bash
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
"banzaicloud-stable" has been added to your repositories
```

Just helm install banzaicloud-stable/<chart>.

Clusters created with Pipeline will add this Helm repo as `banzaicloud-stable` automatically.

## Where to find us

For issues and support join the (#banzai-charts) room in the [Banzai Cloud Community](https://pages.banzaicloud.com/invite-slack).
