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
| store.resources | Resources of the pods | {} |
| store.securityContext | Manage securityContext of store pods | {} |
| store.certSecretName  | Existing secret name with TLS certs mount to the /etc/certs path  |  "" |
| query.replicaCount | Pod replica count| 1 |
| query.monitoring.enabled | | true |
| query.http.port | Enable http port (includes /metrics) | 10901 |
| query.grpc.port | Enable grpc port (data plane) | 10902 |
| query.logLevel | Log level| debug |
| query.resources | Resources of the pods | {} |
| query.livenessProbe  | Liveness probe for query port  | {}  |
| query.readinessProbe  | Readiness probe for query port  | {}  |
| query.securityContext | Manage securityContext of query pods | {} |
| query.certSecretName  | Existing secret name with TLS certs mount to the /etc/certs path |  "" |
| compact.monitoring.enabled | Enable prometheus scraping endpoint | true |
| compact.http.port | Enable http port (includes /metrics) | 10902 |
| compact.logLevel | Log level | DEBUG |
| compact.resources | Resources of the pods | {} |
| compact.securityContext | Manage securityContext of compact pods | {} |
| compact.dataVolume.name | The data volume name  |  "data" |
| compact.dataVolume.backend | Data backend volume (i.e persistentVolumeClaim, emptyDir etc.)| {}  |
| cluster.address | Binding address for cluster discovery | 0.0.0.0 |
| cluster.port | Binding port for cluster discovery | 10900 |
| objstore.provider | Supported providers: `gcs` (soon s3) | gcs |
| objstore.configFile | The file name containing bucket configuration |  "bucket.yaml" |
| objstore.config | The storage module configuration check [official documentation](https://github.com/improbable-eng/thanos/blob/master/docs/storage.md) | "" |
| objstore.gcsCredentials | Google credentials **json content base64 encoded** | "" |
| replicaLabelName | Replica label (separate different Prometheus instances)| "replica" |

### Example GCS configuration
```
objstore:
  type: GCS
    config:
      bucket: "thanos"
      service_account: |-
        {
          "type": "service_account",
          "project_id": "project",
          "private_key_id": "abcdefghijklmnopqrstuvwxyz12345678906666",
          "private_key": "-----BEGIN PRIVATE KEY-----\...\n-----END PRIVATE KEY-----\n",
          "client_email": "project@thanos.iam.gserviceaccount.com",
          "client_id": "123456789012345678901",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/thanos%40gitpods.iam.gserviceaccount.com"
        }
```

### Example S3 configuration
This is an example configuration using thanos with S3. Check endpoints here: https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region

```   
objstore:
  type: S3
  config:
    bucket: ""
    endpoint: ""
    region: ""
    access_key: ""
    insecure: false
    signature_version2: false
    encrypt_sse: false
    secret_key: ""
    put_user_metadata: {}
    http_config:
      idle_conn_timeout: 0s
      response_header_timeout: 0s
      insecure_skip_verify: false
    trace:
      enable: false
    part_size: 0
```

### Example Azure configuration

```
objstore:
  type: AZURE
  config:
    storage_account: ""
    storage_account_key: ""
    container: ""
    endpoint: ""
    max_retries: 0
```

## Contributing
Contributions are very welcome!
