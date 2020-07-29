# Running migrations for Cadence

As of version 0.7.1 the production Cadence image does not automatically run migrations.
While the helm chart provides a way to automatically run them,
it's recommended to run them manually before installing/upgrading Cadence.

This guide contains commands to run migrations on Cassandra or MySQL.

The first step is to start a new shell in a Cadence container:

```bash
export CADENCE_VERSION=0.7.1
docker run --rm -it ubercadence/server:${CADENCE_VERSION} bash
```


## Cassandra

Set up environment variables:

```bash
export CASSANDRA_HOST=docker.for.mac.host.internal
export CASSANDRA_PORT=9042
# Optionally:
# export CASSANDRA_USER=
# export CASSANDRA_PASSWORD=
export CADENCE_KEYSPACE=cadence
export VISIBILITY_KEYSPACE=cadence_visibility
```


### Create keyspaces

```bash
cadence-cassandra-tool create -k ${CADENCE_KEYSPACE}
cadence-cassandra-tool create -k ${VISIBILITY_KEYSPACE}
```

### Set up schema for the first time

```bash
CASSANDRA_KEYSPACE=${CADENCE_KEYSPACE} cadence-cassandra-tool setup-schema -v 0.0
CASSANDRA_KEYSPACE=${VISIBILITY_KEYSPACE} cadence-cassandra-tool setup-schema -v 0.0
```


### Update schema

```bash
CASSANDRA_KEYSPACE=${CADENCE_KEYSPACE} cadence-cassandra-tool update-schema -d /etc/cadence/schema/cassandra/cadence/versioned
CASSANDRA_KEYSPACE=${VISIBILITY_KEYSPACE} cadence-cassandra-tool update-schema -d /etc/cadence/schema/cassandra/visibility/versioned
```


## MySQL

Set up environment variables:

```bash
export SQL_PLUGIN=mysql
export SQL_HOST=docker.for.mac.host.internal
export SQL_PORT=3306
# Optionally:
# export SQL_USER=
# export SQL_PASSWORD=
export CADENCE_DATABASE=cadence
export VISIBILITY_DATABASE=cadence_visibility
```


### Create databases

```bash
cadence-sql-tool create --db ${CADENCE_DATABASE}
cadence-sql-tool create --db ${VISIBILITY_DATABASE}
```


### Set up schema for the first time

```bash
SQL_DATABASE=${CADENCE_DATABASE} cadence-sql-tool setup-schema -v 0.0
SQL_DATABASE=${VISIBILITY_DATABASE} cadence-sql-tool setup-schema -v 0.0
```


### Update schema

```bash
SQL_DATABASE=${CADENCE_DATABASE} cadence-sql-tool update-schema -d /etc/cadence/schema/mysql/v57/cadence/versioned
SQL_DATABASE=${VISIBILITY_DATABASE} cadence-sql-tool update-schema -d /etc/cadence/schema/mysql/v57/visibility/versioned
```
