{{- define "eks-hub-cluster.environment" -}}
  {{- if not (empty $.Values.cluster.environment) }}
	  {{- $environment := $.Values.cluster.environment  -}}
    {{- print $environment -}}
  {{- else -}}
    {{- $environment := "hub"  -}}
    {{- print $environment -}}
  {{- end -}}
{{- end -}}

{{- define "eks-hub-cluster.labels" -}}
	{{- $environment := include "eks-hub-cluster.environment" $ -}}
	{{- $labels := dict -}}
	{{- $_ := set $labels "app.kubernetes.io/instance" .Chart.Name -}}
	{{- $_ := set $labels "app.kubernetes.io/managed-by" .Release.Service -}}
	{{- $_ := set $labels "app.kubernetes.io/name" .Chart.Name -}}
  {{- $_ := set $labels "app.kubernetes.io/environment" $environment -}}
	{{- $_ := set $labels "helm.sh/chart" (printf "%s-%s" .Chart.Name (.Chart.Version | replace "+" "_")) -}}
	{{- print (toYaml $labels) -}}
{{- end -}}

{{- define "eks-hub-cluster.ackNamespace" -}}
	{{- $namespace := required "Missing required value `ack.namespace`" $.Values.ack.namespace -}}
	{{- print $namespace -}}
{{- end -}}

{{- define "eks-hub-cluster.argocdNamespace" -}}
	{{- $namespace := required "Missing required value `argocd.namespace`" $.Values.argocd.namespace -}}
	{{- print $namespace -}}
{{- end -}}
