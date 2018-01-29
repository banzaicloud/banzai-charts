# Zeppelin Chart

[Zeppelin](https://zeppelin.apache.org/) is a web based notebook for interactive data analytics with Spark, SQL and Scala.

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install banzaicloud-stable/zeppelin
```

## Configuration

The following tables lists the configurable parameters of the Zeppelin Sever chart and their default values, in case you want to preserve your Spark application logs on S3 or Azure storage.

| Parameter                            | Required | Description                                                       |Example                           |
| ------------------------------------ | ---------|----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| sparkSubmitOptions.eventLogDirectory                     | yes      |the URL to the directory for event logs | s3a://yourBucketName/eventLogFoloder or wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog|  
| sparkSubmitOptions.azureStorageAccountName          | in case of WASB| Name of your Azure storage account        | see Notes |
| sparkSubmitOptions.azureStorageAccessKey            | in case of WASB| Access key for your Azure storage account | see Notes |

## Notes

* in case of using S3, we don't pass AWS keys we're using IAM roles and policies to allow S3 access
* in case of Azure the storage account name would be the dns prefix it's created (e.g. mystorage.blob.core.windows.net - the name would be mystorage), and you can you either the `primary` or `secondary` keys
