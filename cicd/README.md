# Pipeline CI/CD

[Pipeline CI/CD](https://beta.banzaicloud.io/docs/cicd/getting_started/) is a Continuous Integration platform built on Kubernetes.

## Installing the Chart

Checkout the repository and execute:

```console
$ helm upgrade --install cicd ./cicd/ --set github.clientID=$GITHUB_CLIENT_ID --set github.clientSecret=$GITHUB_CLIENT_SECRET
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete --purge cicd
```

The command removes nearly all the Kubernetes components associated with the
chart and deletes the release.


## Configuration (Database)

The following table lists the configurable parameters of the CICD chart database configuration and their default values.

#### Postgres (default)

Read more [stable/postgresql](https://github.com/helm/charts/tree/master/stable/postgresql)

```yaml
postgres:
  enabled: true
```

| Parameter        | Description              | Default  |
| ---------------- | ------------------------ | -------- |
| postgres.enabled | Install postgresql chart | true     |

#### Mysql

Read more [stable/mysql](https://github.com/helm/charts/tree/master/stable/mysql)

```yaml
mysql:
  enabled: true
```

| Parameter     | Description         | Default  |
| ------------- | ------------------- | -------- |
| mysql.enabled | Install mysql chart | false    |

#### Custom settings (These `values` ​​are preferred against mysql or postgres `values`)

| Parameter               | Description                                   | Default       |
| ------------------------| --------------------------------------------- | ------------- |
| database.driver         | Database driver (mysql, postgres)             | ``            |
| database.host           | Database host                                 | ``            |
| database.port           | Database port                                 | ``            |
| database.name           | Database name                                 | `cicd`    |
| database.username       | Database username                             | `pipeline-rw` |
| database.password       | Database password                             | ``            |
| database.existingSecret | Use an existing secret for database passwords | ``            |

#### Setting up Google CloudSQL Proxy

Read more [rimusz/gcloud-sqlproxy](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy)

```yaml
cloudsql:
  enabled: true
    instances: []
#      - project:
#        region: 
#        instance:
#        port:
```

| Parameter        | Description            | Default  |
| ---------------- | ---------------------- | -------- |
| cloudsql.enabled | Install cloudsql chart | false    |


## Configuration

The following tables lists the configurable parameters of the chart and their default values.

| Parameter               | Description                                                                                   | Default                 |
|-------------------------|-----------------------------------------------------------------------------------------------|-------------------------|
| `image.repository`      | CI/CD **server** image                                                                        | `banzaicloud/cicd`      |
| `image.tag`             | CI/CD **server** image tag                                                                    | `0.8.7`                |
| `image.pullPolicy`      | CI/CD **server** image pull policy                                                            | `IfNotPresent`          |
| `agentImage.repository` | CI/CD **agent** image                                                                         | `banzaicloud/cicd`      |
| `agentImage.tag`        | CI/CD **agent** image tag                                                                     | `0.8.7`                 |
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
| `sharedSecret`          | CI/CD server and agent shared secret                                                          | `(random value)`        |
