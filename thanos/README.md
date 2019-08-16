# Thanos Helm chart

This is a Helm Chart for Thanos. It does not include the required Prometheus and sidecar installation.

## Thanos

Thanos is a set of components that can be composed into a highly available metric system with unlimited storage capacity, which can be added seamlessly on top of existing Prometheus deployments.

Thanos leverages the Prometheus 2.0 storage format to cost-efficiently store historical metric data in any object storage while retaining fast query latencies. Additionally, it provides a global query view across all Prometheus installations and can merge data from Prometheus HA pairs on the fly.

Concretely the aims of the project are:

- Global query view of metrics.
- Unlimited retention of metrics.
- High availability of components, including Prometheus.

## Helm Chart

This chart is in **Beta** state to provide easy installation via Helm chart.
Things that we are improving in near future:
- [ ] Automatic TLS generation for communicating between in-cluster components
- [ ] Support for tracing configuration
- [ ] Grafana dashboards

## Architecture

This Chart will install a complete [Thanos](https://github.com/improbable-eng/thanos) solution. To understand how Thanos works please read it's official [Architecture design](https://github.com/improbable-eng/thanos/blob/master/docs/design.md).

## Installing the Chart

Add Banzai Cloud repository:

```bash
$ helm repo add banzaicloud-stable http://kubernetes-charts.banzaicloud.com/branch/master
$ helm repo update
```


## Storage examples

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
Create the Service Account and Bucket at Google cloud.

Install the chart:
```bash
helm install banzaicloud-stable/thanos -f my-values.yaml --set-file objstore=object-store.yaml

```

# Configuration

This section describes the values available

## General
|Name|Description| Default Value|
|----|-----------|--------------|
| image.repository | Thanos image repository and name | improbable/thanos |
| image.tag | Thanos image tag | master-2018-10-29-8f247d6 |
| image.pullPolicy | Image Kubernetes pull policy | IfNotPresent |
| objstore | Configuration for the backend object storage | {} |

## Common settings for all components

These setting applicable to nearly all components.

|Name|Description| Default Value|
|----|-----------|--------------|
| $component.labels | Additional labels to the Pod | {} |
| $component.annotations | Additional annotations to the Pod | {} |
| $component.deploymentLabels | Additional labels to the deployment | {} |
| $component.deploymentAnnotations | Additional annotations to the deployment | {} |
| $component.metrics.annotations.enabled | Prometheus annotation for component | false |
| $component.metrics.serviceMonitor.enabled | Prometheus ServiceMonitor definition for component | false |
| $component.securityContext | SecurityContext for Pod | {} |
| $component.resources | Resource definition for container | {} |
| $component.tolerations | [Node tolerations for server scheduling to nodes with taints](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) | {} |
| $component.nodeSelector | [Node labels for compact pod assignment](https://kubernetes.io/docs/user-guide/node-selection/) | {} |
| $component.affinity | [Pod affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity) | {} |
| $component.grpc.port | grpc listen port number | 10901 |
| $component.grpc.service.annotations | Service definition for grpc service | {} |
| $component.grpc.ingress.enabled | Set up ingress for the grpc service | false |
| $component.grpc.ingress.annotations | Add annotations to ingress | {} |
| $component.grpc.ingress.labels | Add labels to ingress | {} |
| $component.grpc.ingress.path | Ingress path | "/" |
| $component.grpc.ingress.hosts | Ingress hosts | [] |
| $component.grpc.ingress.tls | Ingress TLS configuration | [] |
| $component.http.port | http listen port number | 10902 |
| $component.http.service.annotations | Service definition for http service | {} |
| $component.http.ingress.enabled | Set up ingress for the http service | false |
| $component.http.ingress.annotations | Add annotations to ingress | {} |
| $component.http.ingress.labels | Add labels to ingress | {} |
| $component.http.ingress.path | Ingress path | "/" |
| $component.http.ingress.hosts | Ingress hosts | [] |
| $component.http.ingress.tls | Ingress TLS configuration | [] |

## Store

These values are just samples, for more fine-tuning please check the values.yaml.
 
|Name|Description| Default Value|
|----|-----------|--------------|
| store.enabled | Enable component | true |
| store.replicaCount | Pod replica count | 1 |
| store.logLevel | Log level | info |
| store.indexCacheSize | Maximum size of items held in the index cache. | 250MB | 
| store.chunkPoolSize | Maximum size of concurrently allocatable bytes for chunks. | 2GB |
| store.grpcSeriesSampleLimit | Maximum amount of samples returned via a single series call. 0 means no limit. NOTE: for efficiency we take 120 as the number of samples in chunk (it cannot be bigger than that), so the actual number of samples might be lower, even though the maximum could be hit. | 0 |
| store.grpcSeriesMaxConcurrency | Maximum number of concurrent Series calls. | 20 |
| store.syncBlockDuration |Repeat interval for syncing the blocks between local and remote view. | 3m |
| store.blockSyncConcurrency | Number of goroutines to use when syncing blocks from object storage. | 20 |
| store.extraEnv | Add extra environment variables | [] |
| store.extraArgs |Add extra arguments | [] |


## Query

|Name|Description| Default Value|
|----|-----------|--------------|
| query.enabled | Enable component | true |
| query.replicaCount | Pod replica count | 1 |
| query.logLevel | Log level | info |
| query.replicaLabel | Label to treat as a replica indicator along which data is deduplicated. Still you will be able to query without deduplication using 'dedup=false' parameter. | "" |
| query.webRoutePrefix |Prefix for API and UI endpoints. This allows thanos UI to be served on a sub-path. This option is analogous to --web.route-prefix of Promethus. | "" |
| query.webExternalPrefix |Static prefix for all HTML links and redirect URLs in the UI query web interface. Actual endpoints are still served on / or the web.route-prefix. This allows thanos UI to be served behind a reverse proxy that strips a URL sub-path | "" |
| query.webPrefixHeader | Name of HTTP request header used for dynamic prefixing of UI links and redirects. This option is ignored if web.external-prefix argument is set. Security risk: enable this option only if a reverse proxy in front of thanos is resetting the header. The --web.prefix-header=X-Forwarded-Prefix option can be useful, for example, if Thanos UI is served via Traefik reverse proxy with PathPrefixStrip option enabled, which sends the stripped prefix value in X-Forwarded-Prefix header. This allows thanos UI to be served on a sub-path | "" |
| query.storeDNSResolver | Custome DNS resolver because of [issue](https://github.com/improbable-eng/thanos/issues/1015) | miekgdns |
| query.storeDNSDiscovery | Enable DNS discovery for stores | true |
| query.sidecarDNSDiscovery | Enable DNS discovery for sidecars (this is for the chart built-in sidecar service) | true |
| query.stores | Addresses of statically configured store API servers (repeatable). The scheme may be prefixed with 'dns+' or 'dnssrv+' to detect store API servers through respective DNS lookups. | [] |
| query.extraEnv | Add extra environment variables | [] |
| query.extraArgs |Add extra arguments | [] |


## Compact

|Name|Description| Default Value|
|----|-----------|--------------|
| compact.enabled | Enable component | true |
| compact.replicaCount | Pod replica count | 1 |
| compact.logLevel | Log level | info |
|consistencyDelay | Minimum age of fresh (non-compacted) blocks before they are being processed. Malformed blocks older than the maximum of consistency-delay and 30m0s will be removed.| 30m |
| retentionResolutionRaw | How long to retain raw samples in bucket. 0d - disables this retention | 30d |
| retentionResolution5m | How long to retain samples of resolution 1 (5 minutes) in bucket. 0d - disables this retention | 120d |
| retentionResolution1h | How long to retain samples of resolution 2 (1 hour) in bucket. 0d - disables this retention | 1y |
| compactConcurrency | Number of goroutines to use when syncing block metadata from object storage. | 20 |
| blockSyncConcurrency | Number of goroutines to use when compacting groups. | 1 |

## Bucket

|Name|Description| Default Value|
|----|-----------|--------------|
| bucket.enabled | Enable component | true |
| bucket.logLevel | Log level | info |
| bucket.refresh | Refresh interval to download metadata from remote storage | 30m |
| bucket.timeout | Timeout to download metadata from remote storage | 5m |
| bucket.label | Prometheus label to use as timeline title | "" |
| bucket.http.port | Listening port for bucket web | 8080 |

## Sidecar

|Name|Description| Default Value|
|----|-----------|--------------|
| sidecar.enabled | NOTE: This is only the service references for the sidecar. It will create a service looking for `app: prometheus` labels| true |

## Contributing
Contributions are very welcome!
