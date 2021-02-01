{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. This is suffixed with -alertmanager, which means subtract 13 from longest 63 available */}}
{{- define "prometheus-operator.name" -}}
{{- default (print "backyards-" .Chart.Name) .Values.nameOverride | trunc 50 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
The components in this chart create additional resources that expand the longest created name strings.
The longest name that gets created adds and extra 37 characters, so truncation should be 63-35=26.
*/}}
{{- define "prometheus-operator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 42 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 42 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 42 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Fullname suffixed with operator */}}
{{- define "prometheus-operator.operator.fullname" -}}
{{- printf "%s-operator" (include "prometheus-operator.fullname" .) -}}
{{- end }}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "prometheus-operator.chartref" -}}
{{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end }}

{{/* Generate basic labels */}}
{{- define "prometheus-operator.labels" -}}
app: {{ template "prometheus-operator.name" . }}
app.kubernetes.io/name: {{ template "prometheus-operator.name" . }}
helm.sh/chart: {{ template "prometheus-operator.chartref" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | replace "+" "_" }}
app.kubernetes.io/component: application
{{- $kubeTargetVersion := default .Capabilities.KubeVersion.GitVersion .Values.kubeTargetVersionOverride }}
prometheusoperator.coreos.com/version: {{ .Values.prometheusOperator.image.tag }}
{{- end }}

{{- define "prometheus-operator.label-selectors" -}}
app: {{ template "prometheus-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | replace "+" "_" }}
app.kubernetes.io/component: application
{{- $kubeTargetVersion := default .Capabilities.KubeVersion.GitVersion .Values.kubeTargetVersionOverride }}
prometheusoperator.coreos.com/version: {{ .Values.prometheusOperator.image.tag }}
{{- end }}
