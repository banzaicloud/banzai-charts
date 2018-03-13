# Spark History Server Chart

[SHS](https://apache-spark-on-k8s.github.io/userdocs/running-on-kubernetes.html) Spark History Server is the web UI for completed and running (aka incomplete) Spark applications. It is an extension of Spark’s web UI.

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install --set app.logDirectory=s3a://yourBucketName/eventLogFoloder banzaicloud-stable/spark-hs
```

## Configuration

The following tables lists the configurable parameters of the Spark History Sever chart and their default values.

| Parameter                            | Required | Description                                                       |Example                           |
| ------------------------------------ | ---------|----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| app.logDirectory                     | yes      |the URL to the directory containing application event logs to load|s3a://yourBucketName/eventLogFoloder<br>wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog<br>gs://yourBucketName/eventLogFoloder|  
| app.azureStorageAccountName          | in case of WASB| Name of your Azure storage account        | see Notes |
| app.azureStorageAccessKey            | in case of WASB| Access key for your Azure storage account | see Notes |

## Notes

* in case of using S3 and Google Storage, we don't pass credentials and access keys we're using IAM roles and policies on Amazon and Service Account based access on Google Cloud
* in case of Azure the storage account name would be the dns prefix it's created (e.g. **mystorage.blob.core.windows.net** - the name would be mystorage), and you can you either the `primary` or `secondary` keys
