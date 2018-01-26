# Spark History Server Chart

[SHS](https://apache-spark-on-k8s.github.io/userdocs/running-on-kubernetes.html) Spark History Server is the web UI for completed and running (aka incomplete) Spark applications. It is an extension of Spark’s web UI.

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install --set app.logDirectory=s3a://yourBucketName/eventLogFoloder .
```

## Configuration

The following tables lists the configurable parameters of the Spark History Sever chart and their default values.

| Parameter                            | Required | Description                                                       |Example                           |
| ------------------------------------ | ---------|----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| app.logDirectory                     | yes      |the URL to the directory containing application event logs to load| s3a://yourBucketName/eventLogFoloder or wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog|  
| app.azureStorageAccountName          | in case of WASB| Name of your Azure storage account        | * |
| app.azureStorageAccessKey            | in case of WASB| Access key for your Azure storage account | * |

NOTE: in case of using S3, we don't pass AWS keys we're using IAM roles and policies to allow S3 access.
