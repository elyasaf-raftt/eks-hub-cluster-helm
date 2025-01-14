

{{- define "eks-hub-cluster.ackControllers.policies(ctx, name)" -}}
  {{- $ctx := .ctx -}}
  {{- $name := .name -}}
  {{- $namespace := include "eks-hub-cluster.ackNamespace" $ctx -}}
  {{- $environment := include "eks-hub-cluster.environment" $ctx }}

  {{- $result := dict -}}

  {{- $policyName := printf "ack-%s-controller-%s" $name $environment -}}
  {{- $policyRef := dict "from" (dict "name" $policyName) -}}
  {{- $_ := set $result "policyRefs" (list $policyRef)  -}}

  {{- $attachExistingPolicies := get (($.ctx.Values.ack).attachExistingPolicies | default dict) $name -}}

  {{- if $attachExistingPolicies -}}
    {{- $_ := set $result "policies" $attachExistingPolicies -}}
  {{- end -}}

  {{- printf "%s" ($result | toYaml) -}}
{{- end -}}