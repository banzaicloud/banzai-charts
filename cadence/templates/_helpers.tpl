{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cadence.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cadence.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cadence.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified component name from the full app name and a component name.
We truncate the full name at 63 - 1 (last dash) - len(component name) chars because some Kubernetes name fields are limited to this (by the DNS naming spec)
and we want to make sure that the component is included in the name.
*/}}
{{- define "cadence.componentname" -}}
{{- $global := index . 0 -}}
{{- $component := index . 1 | trimPrefix "-" -}}
{{- printf "%s-%s" (include "cadence.fullname" $global | trunc (sub 62 (len $component) | int) | trimSuffix "-" ) $component | trimSuffix "-" -}}
{{- end -}}

{{/*
Call nested templates.
Source: https://stackoverflow.com/a/52024583/3027614
*/}}
{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 }}
{{- $template := index . 2 }}
{{- include $template (dict "Chart" (dict "Name" $subchart) "Values" (index $dot.Values $subchart) "Release" $dot.Release "Capabilities" $dot.Capabilities) }}
{{- end }}

{{- define "cadence.frontend.internalPort" -}}
7933
{{- end -}}

{{- define "cadence.history.internalPort" -}}
7934
{{- end -}}

{{- define "cadence.matching.internalPort" -}}
7935
{{- end -}}

{{- define "cadence.worker.internalPort" -}}
7939
{{- end -}}

{{- define "cadence.persistence.schema" -}}
{{- if eq . "default" -}}
{{- print "cadence" -}}
{{- else -}}
{{- print . -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.driver" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.driver -}}
{{- $storeConfig.driver -}}
{{- else if $global.Values.cassandra.enabled -}}
{{- print "cassandra" -}}
{{- else if $global.Values.mysql.enabled -}}
{{- print "sql" -}}
{{- else -}}
{{- required (printf "Please specify persistence driver for %s store" $store) $storeConfig.driver -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.cassandra.hosts" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.cassandra.hosts -}}
{{- $storeConfig.cassandra.hosts | join "," -}}
{{- else if and $global.Values.cassandra.enabled (eq (include "cadence.persistence.driver" (list $global $store)) "cassandra") -}}
{{- include "cassandra.hosts" $global -}}
{{- else -}}
{{- required (printf "Please specify cassandra hosts for %s store" $store) $storeConfig.cassandra.hosts -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.cassandra.port" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.cassandra.port -}}
{{- $storeConfig.cassandra.port -}}
{{- else if and $global.Values.cassandra.enabled (eq (include "cadence.persistence.driver" (list $global $store)) "cassandra") -}}
{{- $global.Values.cassandra.config.ports.cql -}}
{{- else -}}
{{- required (printf "Please specify cassandra port for %s store" $store) $storeConfig.cassandra.port -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.cassandra.secretName" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.cassandra.existingSecret -}}
{{- $storeConfig.cassandra.existingSecret -}}
{{- else if $storeConfig.cassandra.password -}}
{{- include "cadence.componentname" (list $global (printf "%s-store" $store)) -}}
{{- else -}}
{{/* Cassandra password is optional, but we will create an empty secret for it */}}
{{- include "cadence.componentname" (list $global (printf "%s-store" $store)) -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.cassandra.secretKey" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if or $storeConfig.sql.existingSecret $storeConfig.sql.password -}}
{{- print "password" -}}
{{- else -}}
{{/* Cassandra password is optional, but we will create an empty secret for it */}}
{{- print "password" -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.pluginName" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.pluginName -}}
{{- $storeConfig.sql.pluginName -}}
{{- else if $global.Values.mysql.enabled -}}
{{- print "mysql" -}}
{{- else -}}
{{- required (printf "Please specify sql plugin for %s store" $store) $storeConfig.sql.host -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.host" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.host -}}
{{- $storeConfig.sql.host -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- include "mysql.host" $global -}}
{{- else -}}
{{- required (printf "Please specify sql host for %s store" $store) $storeConfig.sql.host -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.port" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.port -}}
{{- $storeConfig.sql.port -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- $global.Values.mysql.service.port -}}
{{- else -}}
{{- required (printf "Please specify sql port for %s store" $store) $storeConfig.sql.port -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.user" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.user -}}
{{- $storeConfig.sql.user -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- $global.Values.mysql.mysqlUser -}}
{{- else -}}
{{- required (printf "Please specify sql user for %s store" $store) $storeConfig.sql.user -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.password" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.password -}}
{{- $storeConfig.sql.password -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- if or $global.Values.schema.setup.enabled $global.Values.schema.update.enabled -}}
{{- required "Please specify password for MySQL chart" $global.Values.mysql.mysqlPassword -}}
{{- else -}}
{{- $global.Values.mysql.mysqlPassword -}}
{{- end -}}
{{- else -}}
{{- required (printf "Please specify sql password for %s store" $store) $storeConfig.sql.password -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.secretName" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if $storeConfig.sql.existingSecret -}}
{{- $storeConfig.sql.existingSecret -}}
{{- else if $storeConfig.sql.password -}}
{{- include "cadence.componentname" (list $global (printf "%s-store" $store)) -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- include "call-nested" (list $global "mysql" "mysql.secretName") -}}
{{- else -}}
{{- required (printf "Please specify sql password or existing secret for %s store" $store) $storeConfig.sql.existingSecret -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.sql.secretKey" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- $storeConfig := index $global.Values.server.config.persistence $store -}}
{{- if or $storeConfig.sql.existingSecret $storeConfig.sql.password -}}
{{- print "password" -}}
{{- else if and $global.Values.mysql.enabled (and (eq (include "cadence.persistence.driver" (list $global $store)) "sql") (eq (include "cadence.persistence.sql.pluginName" (list $global $store)) "mysql")) -}}
{{- print "mysql-password" -}}
{{- else -}}
{{- fail (printf "Please specify sql password or existing secret for %s store" $store) -}}
{{- end -}}
{{- end -}}

{{- define "cadence.persistence.secretName" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- include (printf "cadence.persistence.%s.secretName" (include "cadence.persistence.driver" (list $global $store))) (list $global $store) -}}
{{- end -}}

{{- define "cadence.persistence.secretKey" -}}
{{- $global := index . 0 -}}
{{- $store := index . 1 -}}
{{- include (printf "cadence.persistence.%s.secretKey" (include "cadence.persistence.driver" (list $global $store))) (list $global $store) -}}
{{- end -}}

{{/*
All Cassandra hosts.
*/}}
{{- define "cassandra.hosts" -}}
{{- range $i := (until (int .Values.cassandra.config.cluster_size)) }}
{{- $cassandraName := include "call-nested" (list $ "cassandra" "cassandra.fullname") -}}
{{- printf "%s-%d.%s.%s.svc.cluster.local," $cassandraName $i $cassandraName $.Release.Namespace -}}
{{- end }}
{{- end -}}

{{/*
The first Cassandra host in the stateful set.
*/}}
{{- define "cassandra.host" -}}
{{- $cassandraName := include "call-nested" (list . "cassandra" "cassandra.fullname") -}}
{{- printf "%s-0.%s.%s.svc.cluster.local" $cassandraName $cassandraName .Release.Namespace -}}
{{- end -}}

{{/*
MySQL host.
*/}}
{{- define "mysql.host" -}}
{{- printf "%s.%s.svc.cluster.local" (include "call-nested" (list . "mysql" "mysql.fullname")) .Release.Namespace -}}
{{- end -}}

{{/*
Format a string map as a query string.
*/}}
{{- define "to-query" }}
{{- trimSuffix "&" (include "_to-query" .)  }}
{{- end }}

{{/*
Format a string map as a query string.
*/}}
{{- define "_to-query" }}
{{- range $key, $value := . -}}{{ $key }}={{ $value }}&{{- end -}}
{{- end }}
