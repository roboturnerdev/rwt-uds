{{- define "excalidraw.name" -}}
excalidraw
{{- end }}

{{- define "excalidraw.fullname" -}}
excalidraw
{{- end }}

{{- define "excalidraw.labels" -}}
app.kubernetes.io/name: excalidraw
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}