{{/*
Expand the chart name.
*/}}
{{- define "excalidraw.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a release-specific full name.
*/}}
{{- define "excalidraw.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Chart label.
*/}}
{{- define "excalidraw.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version |
    replace "+" "_" |
    trunc 63 |
    trimSuffix "-" }}
{{- end }}

{{/*
Labels used on every managed object.
*/}}
{{- define "excalidraw.labels" -}}
helm.sh/chart: {{ include "excalidraw.chart" . }}
{{ include "excalidraw.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Labels used in immutable workload and Service selectors.
*/}}
{{- define "excalidraw.selectorLabels" -}}
app.kubernetes.io/name: {{ include "excalidraw.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name.
*/}}
{{- define "excalidraw.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "excalidraw.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}