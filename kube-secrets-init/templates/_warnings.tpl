{{/* this file is for generating warnings about incorrect usage of the chart */}}

{{- if and .Values.certificate.certManager .Values.certificate.generate  }}
  {{ fail "CertManager and certificate generation are mutually exclusive. Please enable only one of certificate.useCertManager and certificate.generate."}}
{{- end }}
