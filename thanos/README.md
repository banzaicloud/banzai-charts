# Thanos Helm chart

Thanos is a set of components that can be composed into a highly available metric system with unlimited storage capacity. It can be added seamlessly on top of existing Prometheus deployments and leverages the Prometheus 2.0 storage format to cost-efficiently store historical metric data in any object storage while retaining fast query latencies. Additionally, it provides a global query view across all Prometheus installations and can merge data from Prometheus HA pairs on the fly.

This chart is in **Alpha** state to provide easy installation via Helm chart.

## Architecture

This Chart will install a complete [Thanos](https://github.com/improbable-eng/thanos) solution. As Thanos requires Prometheus sidecar container it includes a custom Prometheus Chart with built-in sidecar support. To understand how Thanos works please read it's official [Architecture design](https://github.com/improbable-eng/thanos/blob/master/docs/design.md).

## Installing the Chart

Add Banzai Cloud repository:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```

Create the Service Account and Bucket at Google cloud.

Install the chart:
```bash 
helm install banzaicloud-stable/thanos --set objstore.bucketName="test-bucket" --set objstore.gcsCredentials="<base64encoded>"

```

## Configuration

|Name|Description| Default Value|
|----|-----------|--------------|
| image.repository| Thanos image repository and name | improbable/thanos|
| image.tag| Thanos image tag | master-2018-10-29-8f247d6|
| image.pullPolicy| Image Kubernetes pull policy | IfNotPresent|
| store.replicaCount | Pod replica count | 1 |
| store.monitoring.enabled | Enable prometheus scraping endpoint | true |
| store.http.port | Enable http port (includes /metrics) | 10902 |
| store.grpc.port | Enable grpc port (data plane) | 10901 |
| store.logLevel | Log level | debug |
| query.replicaCount | Pod replica count| 1 |
| query.monitoring.enabled | | true |
| query.http.port | Enable http port (includes /metrics) | 10901 |
| query.grpc.port | Enable grpc port (data plane) | 10902 |
| query.logLevel | Log level| debug |
| compact.monitoring.enabled | Enable prometheus scraping endpoint | true |
| compact.http.port | Enable http port (includes /metrics) | 10902 |
| compact.logLevel |  Log level | DEBUG |
| cluster.address | Binding address for cluster discovery | 0.0.0.0 |
| cluster.port | Binding port for cluster discovery | 10900 |
| objstore.provider | Supported providers: `gcs` (soon s3) | gcs |
| objstore.configFile | The file name containing bucket configuration |  "bucket.yaml" |
| objstore.bucketName | The bucket name used to store logs | "" |
| objstore.gcsCredentials | Google credentials **json content base64 encoded** | "" |
| replicaLabelName | Replica label (separate different Prometheus instances)| "replica" |
| prometheus.enabled | Prometheus deployment with sidecar | false |
| prometheus.thanosSidecar.enabled | Enable sidecar in Prometheus  | true |

## Upcoming features
- Support S3
- Add override options to custom configuration and secrets

## Contributing
Contributions are very welcome!