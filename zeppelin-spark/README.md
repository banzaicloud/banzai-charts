# Zeppelin-Spark Chart

This is a composite chart deploying the following sub-charts:

- [Zeppelin](https://github.com/banzaicloud/banzai-charts/tree/master/zeppelin)
- [Spark](https://github.com/banzaicloud/banzai-charts/tree/master/spark) this is again a composite charts deploying the following sub-charts:
  - [Spark History Server](https://github.com/banzaicloud/banzai-charts/tree/master/spark-hs) only if enabled (default *historyServer.enabled=true*)
  - [Spark Resource Staging Server](https://github.com/banzaicloud/banzai-charts/tree/master/spark-rss) only if enabled (default *resourceStagingServer.enabled=false*)
  - [Spark Shuffle Service](https://github.com/banzaicloud/banzai-charts/tree/master/spark-shuffle) only if enabled (default *sparkShuffle.enabled=false*)

## DEPRECATION NOTICE

This chart is deprecated and no longer supported.

## Chart Details

## Installing the Chart

To install the chart:

```
$ helm install banzaicloud-stable/zeppelin
```

## Configuration

Helm let's you override all parameters in `values.yaml` of every chart and sub-chart, however in this chart you don't need anything special you can install this as it is, with default values. If you want to use Spark History Server, you need to enable it and set some cloud storage for event logs file, depending on your cloud provider.  The below table lists the required parameters you need to set if you want to enable `Spark History Server`.

| Parameter                            | Required | Description                                                       |Example                           |
| ------------------------------------ | ---------|----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| zeppelin.username                     | no      | Admin username, by default is `admin` | |
| zeppelin.password                     | no      | Salted password of admin user, by default is `zeppelin` | You can salt your own password using [shiro cli tool](http://shiro.apache.org/command-line-hasher.html) ```java -jar ~/dev/tools/shiro-tools-hasher-1.3.2-cli.jar -p``` |
| zeppelin.userCredentialSecretName     | no      | Credentials above are set in a K8s secret. Instead of specifying username & password directly you can provide the name of this K8s secret containing these fields | |
| zeppelin.sparkEventLogStorage.logDirectory                     | yes      |the URL to the directory containing application event logs to load|yourBucketName/eventLogFoloder |
| zeppelin.sparkEventLogStorage.cloudProvider                    | yes      |the cloud provider where the objectstore/bucket located| amazon<br>google<br>azure<br>oracle<br>alibaba |
| zeppelin.sparkEventLogStorage.secretName          | no | the name of K8s secret containing credentials for selected cloud provider. If no secretName is passed then there will be a secret created with the same structure populated from values. Checkout the required secret properties for each provider in next section below. | see below |
| historyServer.enabled           | false by default| Enable deploying Spark History Server | true / false |
| spark.spark-hs.sparkEventLogStorage.logDirectory                     | yes      |the URL to the directory containing application event logs to load|yourBucketName/eventLogFoloder |
| spark.spark-hs.sparkEventLogStorage.cloudProvider                    | yes      |the cloud provider where the objectstore/bucket located| amazon<br>google<br>azure<br>oracle<br>alibaba |
| spark.spark-hs.sparkEventLogStorage.secretName          | no | the name of K8s secret containing credentials for selected cloud provider. If no secretName is passed then there will be a secret created with the same structure populated from values. Checkout the required secret properties for each provider in next section below. | see below |

## Structure of credential secret for each supported cloud provider

### Amazon

```
AWS_ACCESS_KEY_ID: {{ .Values.sparkEventLogStorage.awsAccessKeyId | b64enc | quote }}
AWS_SECRET_ACCESS_KEY: {{ .Values.sparkEventLogStorage.awsSecretAccessKey | b64enc | quote }}
```

### Azure

```
storageAccount: {{ .Values.sparkEventLogStorage.azureStorageAccountName | b64enc | quote }}
accessKey: {{ .Values.sparkEventLogStorage.azureStorageAccessKey | b64enc | quote }}
```

### Alibaba

```
ALIBABA_ACCESS_KEY_ID: {{ .Values.sparkEventLogStorage.aliAccessKeyId | b64enc | quote }}
ALIBABA_ACCESS_KEY_SECRET: {{ .Values.sparkEventLogStorage.aliSecretAccessKey | b64enc | quote }}
```

### Google

```
google.json: {{ .Values.sparkEventLogStorage.googleJson | quote }}
```

### Oracle

```
api_key: {{ .Values.sparkEventLogStorage.apiKey | b64enc | quote }}
tenancy_ocid: {{ .Values.sparkEventLogStorage.oracleTenancyId | b64enc | quote }}
user_ocid:  {{ .Values.sparkEventLogStorage.oracleUserId | b64enc | quote }}
api_key_fingerprint:  {{ .Values.sparkEventLogStorage.oracleApiKeyFingerprint | b64enc | quote }}
```

NOTE: values must be prefixed with subchart name, see the example below how to specify AWS credential properties for zepplin and spark-hs chart sparkEventLogStorage:

```
zeppelin.sparkEventLogStorage.awsAccessKeyId=XXXXXXXXX
zeppelin.sparkEventLogStorage.awsSecretAccessKey=XXXXXXXXXXXXXXXX
spark.spark-hs.sparkEventLogStorage.awsAccessKeyId=XXXXXXXXX
spark.spark-hs.sparkEventLogStorage.awsSecretAccessKey=XXXXXXXXXXXXXXXX
```
