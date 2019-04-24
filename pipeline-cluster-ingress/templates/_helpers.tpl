{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{- define "pipeline-cluster-ingress.saname" -}}
{{- if .Values.traefik.fullnameOverride -}}
{{- .Values.traefik.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default (printf "%s-traefik" .Release.Name ) .Values.traefik.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
