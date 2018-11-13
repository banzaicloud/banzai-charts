# Thanos Helm chart



## Architecture

## Installing the Chart

## Options

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
| objstore.secretName | Secret name for bucket credentials | "" |
| objstore.configFile | The file name containing bucket configuration |  "bucket.yaml" |
| objstore.bucketName | The bucket name used to store logs | "" |
| objstore.gcsCredentials | Google credentials json content | "" |
| replicaLabelName | Replica label (separate different Prometheus instances)| "replica" |
| prometheus.enabled | Prometheus deployment with sidecar | false |
| prometheus.thanosSidecar.enabled | Enable sidecar in Prometheus  | true |