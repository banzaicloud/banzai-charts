# Spark History Server Chart

[SHS](https://apache-spark-on-k8s.github.io/userdocs/running-on-kubernetes.html) Spark History Server is the web UI for completed and running (aka incomplete) Spark applications. It is an extension of Spark’s web UI.

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install --set app.logDirectory=s3a://yourBucketName/eventLogFoloder .
```

## Configuration

The following tables lists the configurable parameters of the Zeppelin chart and their default values.

| Parameter                            | Description                                                       | Default                                                    |
| ------------------------------------ | ----------------------------------------------------------------- | ---------------------------------------------------------- |
