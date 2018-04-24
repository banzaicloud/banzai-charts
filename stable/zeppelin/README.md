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
| username                     | no      | Admin username, by default is `admin` | |
| password                     | no      | Salted password of admin user, by default is `zeppelin` | You can salt your own password using [shiro cli tool](http://shiro.apache.org/command-line-hasher.html) ```java -jar ~/dev/tools/shiro-tools-hasher-1.3.2-cli.jar -p``` |
| sparkSubmitOptions.eventLogDirectory                     | yes      |the URL to the directory for event logs |s3a://yourBucketName/eventLogFoloder<br>wasb://your_blob_container_name@you_storage_account_name.blob.core.windows.net/eventLog<br>gs://yourBucketName/eventLogFoloder|  
| sparkSubmitOptions.azureStorageAccountName          | only in case of using Azure Storage| Name of your Azure storage account        | see Notes |
| sparkSubmitOptions.azureStorageAccessKey            | only in case of using Azure Storage| Access key for your Azure storage account | see Notes |

## Notes

* in case of using S3 and Google Storage, we don't pass credentials and access keys we're using IAM roles and policies on Amazon and Service Account based access on Google Cloud
* in case of Azure the storage account name would be the dns prefix it's created (e.g. **mystorage.blob.core.windows.net** - the name would be mystorage), and you can you either the `primary` or `secondary` keys
