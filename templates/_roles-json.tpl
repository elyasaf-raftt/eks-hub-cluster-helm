{{- define "eks-hub-cluster.ackControllers.roleJson" -}}
  {{- $ctx := .ctx}}
	{{- $saList := required "Missing serviceAccount to assign permissions" .serviceSccountList  -}}
  {{- $namespace := include "eks-hub-cluster.ackNamespace" $ctx -}}
	{{- $roleResult := dict -}}
  {{- $accountID := $ctx.Values.aws.accountID | int }}
  {{- $oidcProvider := $ctx.Values.aws.oidcProvider }}

	{{- $_ := set $roleResult "Version" "2012-10-17" -}}

	{{- $statementsList := list -}}

	{{- $statement := dict -}}
	{{- $_ := set $statement "Effect" "Allow" -}}
	{{- $_ := set $statement "Action" "sts:AssumeRoleWithWebIdentity" -}}
	{{- $federated := printf "arn:aws:iam::%v:%s" $accountID $oidcProvider -}}
	{{- $_ := set $statement "Principal" (dict "Federated" $federated) -}}
	{{- $statementsList := append $statementsList $statement -}}
	{{- $_ := set $roleResult "Statement" $statementsList -}}

	{{- $conditions := dict -}}

	{{- $stringEquals := dict -}}

  {{- $saListForRole := list -}}
  {{- range $saList -}}
    {{- $saListForRole = append $saListForRole (printf "system:serviceaccount:%s:%s" $namespace .) -}}
  {{- end -}}

	{{- $key := printf "%s:sub" $oidcProvider -}}
	{{- $_ := set $stringEquals $key $saListForRole -}}
	{{- $_ := set $conditions "StringEquals" $stringEquals -}}
	{{- $_ := set $roleResult "Condition" $conditions -}}

	{{- printf "%s" ($roleResult | toJson) -}}
{{- end -}}