# Pipeline CI/CD

[Pipeline CI/CD](https://beta.banzaicloud.io/docs/cicd/getting_started/ is a Continuous Integration platform built on Kubernetes.

## Installing the Chart

Checkout the repository and execute:

```console
$ cd pipeline-cicd
$ helm upgrade --install pipeline-cicd . --set global.auth.clientid=$GITHUB_CLIENT_ID --set global.auth.clientsecret=$GITHUB_CLIENT_SECRET
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete --purge pipeline-cicd
```

The command removes nearly all the Kubernetes components associated with the
chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the chart and their default values.

| Parameter               | Description                                                                                   | Default                 |
|-------------------------|-----------------------------------------------------------------------------------------------|-------------------------|
| `image.repository`      | CI/CD **server** image                                                                        | `banzaicloud/cicd` |
| `image.tag`             | CI/CD **server** image tag                                                                    | `latest`                 |
| `image.pullPolicy`      | CI/CD **server** image pull policy                                                            | `IfNotPresent`          |
| `agentImage.repository` | CI/CD **agent** image                                                                         | `banzaicloud/cicd` |
| `agentImage.tag`        | CI/CD **agent** image tag                                                                     | `0.8.1`                 |
| `agentImage.pullPolicy` | CI/CD **agent** image pull policy                                                             | `IfNotPresent`          |
| `service.httpPort`      | CI/CD's Web GUI HTTP port                                                                     | `80`                    |
| `service.nodePort`      | If `service.type` is `NodePort` and this is non-empty, sets the http node port of the service | `32015`                 |
| `service.type`          | Service type (ClusterIP, NodePort or LoadBalancer)                                            | `ClusterIP`             |
| `ingress.enabled`       | Enables Ingress for CI/CD                                                                     | `false`                 |
| `ingress.annotations`   | Ingress annotations                                                                           | `{}`                    |
| `ingress.hosts`         | Ingress accepted hostnames                                                                    | `nil`                   |
| `ingress.tls`           | Ingress TLS configuration                                                                     | `[]`                    |
| `server.host`           | CI/CD **server** hostname                                                                     | `(internal hostname)`   |
| `server.env`            | CI/CD **server** environment variables                                                        | `(default values)`      |
| `server.resources`      | CI/CD **server** pod resource requests & limits                                               | `{}`                    |
| `agent.env`             | CI/CD **agent** environment variables                                                         | `(default values)`      |
| `agent.resources`       | CI/CD **agent** pod resource requests & limits                                                | `{}`                    |
| `sharedSecret`         | CI/CD server and agent shared secret                                                          | `(random value)`        |
