- type: {{ (index .Values.config.connectors 0 ).type }}
  id: {{ (index .Values.config.connectors 0 ).id }}
  name: {{ (index .Values.config.connectors 0 ).name }}
  config:
    loadAllGroups: {{ (index .Values.config.connectors 0 ).config.loadAllGroups }}
    clientID: {{ ( index .Values.config.connectors 0 ).config.clientID | quote }}
    clientSecret: {{ ( index .Values.config.connectors 0 ).config.clientSecret | quote }}
    redirectURI: {{ ( index .Values.config.connectors 0 ).config.redirectURI | quote }}
