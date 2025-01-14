
{{- define "eks-hub-cluster.ackControllers.policyJson(ctx, name)" }}
  {{- $ctx := .ctx -}}
  {{- $name := .name -}}
  {{- $actionList := (get (($.ctx.Values.ack).controllersPolicyActionMap | default dict ) $name | default list) -}}
  {{- $policyResult := dict -}}
	{{- $_ := set $policyResult "Version" "2012-10-17" -}}

	{{- $statementsList := list -}}

	{{- $statement := dict -}}
	{{- $_ := set $statement "Effect" "Allow" -}}
	{{- $_ := set $statement "Action" $actionList -}}
  {{- $_ := set $statement "Resource" "*"  -}}

	{{- $statementsList := append $statementsList $statement -}}
	{{- $_ := set $policyResult "Statement" $statementsList -}}

	{{- printf "%s" ($policyResult | toJson) -}}
{{- end -}}