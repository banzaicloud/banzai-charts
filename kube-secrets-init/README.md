# kube-secrets-init

[kube-secrets-init](https://github.com/doitintl/kube-secrets-init) is a Kubernetes mutating admission webhook, that mutates any Pod that is using specially prefixed environment variables, directly or from Kubernetes as Secret or ConfigMap.


## TL;DR;

**On Kubernetes <1.15 the namespace where you install the webhook must have a label of `name` with the namespace name as the value, so the `namespaceSelector` in the `MutatingWebhookConfiguration` can skip the namespace of the webhook and no self-mutation takes place. As of Kubernetes 1.15, the default `objectSelector` will prevent self-mutations.**


```bash
WEBHOOK_NS=${WEBHOOK_NS:-kube-secrets-init}
kubectl create namespace "${WEBHOOK_NS}"
kubectl label ns "${WEBHOOK_NS}" name="${WEBHOOK_NS}"
```

```bash
$ helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
$ helm repo update
```

```bash
$ helm install --namespace $WEBHOOK_NS --generate-name banzaicloud-stable/kube-secrets-init --wait
```


## Configuration

Check [values.yaml](values.yaml) for configuration options.


### Certificate

Webhooks require CA and TLS certificates to secure communication between the API server and the webhook.
The chart offers the following options for certificate provisioning:

#### Generate (default)

The default option is to let Helm generate the CA and TLS certificates during installation.

This will renew the certificates on each deployment.

```yaml
certificate:
  generate: true
```

#### Using cert-manager

If have [cert-manager](https://cert-manager.io/) installed in your cluster, you can use it to automatically provision and inject certificates.

```yaml
certificate:
  useCertManager: true
  generate: false
```


## About GKE Private Clusters

When Google configure the control plane for private clusters, they automatically configure VPC peering between your Kubernetes cluster’s network in a separate Google managed project.

The auto-generated rules **only** open ports 10250 and 443 between masters and nodes. This means that to use the webhook component with a GKE private cluster, you must configure an additional firewall rule to allow your masters CIDR to access your webhook pod using the port 8443.

You can read more information on how to add firewall rules for the GKE control plane nodes in the [GKE docs](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#add_firewall_rules).


## Roadmap

- add back service config
- add pod security policy support
- add pod distruption budget
- add all the remaining options of kube-secrets-init
