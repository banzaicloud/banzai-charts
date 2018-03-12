# Zeppelin-Spark Chart

This is a composite chart deploying the following sub-charts:

- [Zeppelin](https://github.com/banzaicloud/banzai-charts/tree/master/stable/zeppelin)
- [Spark](https://github.com/banzaicloud/banzai-charts/tree/master/stable/spark) this is again a composite charts deploying the following sub-charts:
  - [Spark History Server](https://github.com/banzaicloud/banzai-charts/tree/master/stable/spark-hs) only if enabled (*historyServer.enabled=true*)
  - [Spark Resource Staging Server](https://github.com/banzaicloud/banzai-charts/tree/master/stable/spark-rss)
  - [Spark Shuffle Service](https://github.com/banzaicloud/banzai-charts/tree/master/stable/spark-shuffle)

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install banzaicloud-stable/zeppelin
```

## Configuration

Helm let's you override all parameters in `values.yaml` of every chart and sub-chart, however in you don't need anything special you can install this chart as it is, with default values. If you want to use Spark History Server, you need to enable it and set some cloud storage for event logs file, depending on your cloud provider.  The below table lists the required parameters you need to set if you want to enable `Spark History Server`.

| Parameter                            | Required | Description                                                       |Example                           |
| ------------------------------------ | ---------|----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| zeppelin.sparkSubmitOptions.eventLogDirectory                     | yes      |the URL to the directory for event logs | s3a://yourBucketName/eventLogFoloder wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog gs://yourBucketName/eventLogFoloder|  
| zeppelin.sparkSubmitOptions.azureStorageAccountName          | only in case of using Azure Storage| Name of your Azure storage account        | see Notes |
| zeppelin.sparkSubmitOptions.azureStorageAccessKey            | only in case of using Azure Storage| Access key for your Azure storage account | see Notes |
| historyServer.enabled           | false by default| Enable deploying Spark History Server | true / false |
| spark.spark-hs.app.logDirectory                     | yes      |the URL to the directory containing application event logs to load| s3a://yourBucketName/eventLogFoloder wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog gs://yourBucketName/eventLogFoloder|  
| spark.spark-hs.app.azureStorageAccountName          | in case of WASB| Name of your Azure storage account        | see Notes |
| spark.spark-hs.app.azureStorageAccessKey            | in case of WASB| Access key for your Azure storage account | see Notes |

In case you want to use [Pipeline](https://github.com/banzaicloud/pipeline) to deploy this chart, you can checkout [Postman example Deployment requests](https://github.com/banzaicloud/pipeline/blob/master/docs/postman/deploy_examples.postman_collection.json).

## Notes

* in case of using S3 and Google Storage, we don't pass credentials and access keys we're using IAM roles and policies on Amazon and Service Account based access on Google Cloud
* in case of Azure the storage account name would be the dns prefix it's created (e.g. **mystorage.blob.core.windows.net** - the name would be mystorage), and you can you either the `primary` or `secondary` keys
