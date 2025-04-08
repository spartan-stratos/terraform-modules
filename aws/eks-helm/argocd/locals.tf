locals {
  node_selectors = flatten([
    for key, value in var.node_selector : {
      key   = key
      value = value
    }
  ])

  tolerations = flatten([
    for key, value in var.tolerations : {
      key   = key
      value = value
    }
  ])

  ingress_annotations = flatten([
    for key, value in var.ingress.annotations : {
      key   = key
      value = value
    }
  ])
  # ----- MANIFEST YAML FILE ------

  manifest = <<YAML
global:
  domain: "argocd.${var.domain_name}"
  %{if length(local.node_selectors) > 0}
  nodeSelector:
    %{for node in local.node_selectors}
    ${node.key}: ${node.value}
    %{endfor}
  %{endif}
  %{if length(var.tolerations) > 0}
  tolerations:
    %{for toleration in local.tolerations}
    - ${toleration.key}: ${toleration.value}
    %{endfor}
  %{endif}
server:
  ingress:
    enabled: ${var.ingress.enabled}
    hostname: "argocd.${var.domain_name}"
    ingressClassName: ${var.ingress.ingress_class}
    controller: ${var.ingress.controller}
    annotations:
      %{for annotation in local.ingress_annotations}
      ${annotation.key}: ${annotation.value}
      %{endfor}
    path: ${var.ingress.path}
    pathType: ${var.ingress.pathType}

dex:
  enabled: true

configs:
  params:
    server.insecure: ${!var.handle_tls}
    controller.diff.server.side: "${var.server_side_diff}"
  cm:
    dex.config: |
      connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: ${var.oidc_github_client_id}
            clientSecret: ${var.oidc_github_client_secret}
            orgs:
              - name: ${var.oidc_github_organization}
      issuer: ${var.issuer_url}
  rbac:
    policy.csv: |
      ${join("\n", var.rbac_policies)}
  %{if length(var.external_clusters) > 0}
  clusterCredentials:
    ${yamlencode(var.external_clusters)}
  %{endif}
notifications:
  enabled: true
  secret:
    items:
      slack-token: ${var.slack_token}
  subscriptions:
    - recipients:
        - slack:social
      triggers:
        - on-sync-status-unknown
        - app-deployed
        - app-sync-failed
        - app-sync-running
        - app-sync-succeeded
  notifiers:
    service.slack: |
      token: $slack-token
  templates:
    template.app-deployed: |
      slack:
        attachments: |
          [{
            "title": ":rocket: Application Deployed: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#18be52",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              },
              {
                "title": "Revision",
                "value": "{{.app.status.sync.revision}}",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": "{{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-health-degraded: |
      slack:
        attachments: |-
          [{
            "title": ":warning: Health Degraded: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#f4c030",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": ":warning: {{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-sync-failed: |
      slack:
        attachments: |-
          [{
            "title": ":x: Sync Failed: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#E96D76",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": ":x: {{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-sync-running: |
      slack:
        attachments: |-
          [{
            "title": ":hourglass_flowing_sand: Sync In Progress: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#0DADEA",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": " Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": "{{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-sync-status-unknown: |
      slack:
        attachments: |-
          [{
            "title": ":question: Sync Status Unknown: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#E96D76",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": ":question: {{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-sync-succeeded: |
      slack:
        attachments: |-
          [{
            "title": ":white_check_mark: Sync Succeeded: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#18be52",
            "fields": [
              {
                "title": "Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": "{{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ]
          }]
    template.app-out-of-sync: |
      slack:
        attachments: |-
          [{
            "title": "Out of Sync: {{ .app.metadata.name}}",
            "title_link": "{{.context.argocdUrl}}/applications/{{.app.metadata.name}}",
            "color": "#f4c030",
            "fields": [
              {
                "title": " Sync Status",
                "value": "{{.app.status.sync.status}}",
                "short": true
              },
              {
                "title": "Repository",
                "value": "<{{.app.spec.source.repoURL}}|View Repo>",
                "short": true
              }
              {{range $index, $c := .app.status.conditions}}
              {{if not $index}},{{end}}
              {{if $index}},{{end}}
              {
                "title": "{{$c.type}}",
                "value": "{{$c.message}}",
                "short": true
              }
              {{end}}
            ],
            "footer": "ArgoCD Sync Issue"
          }]
  triggers:
    trigger.on-deployed: |
      - description: Application is synced and healthy. Triggered once per commit.
        oncePer: app.status.sync.revision
        send:
        - app-deployed
        when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status == 'Healthy'
    trigger.on-health-degraded: |
      - description: Application has degraded
        send:
        - app-health-degraded
        when: app.status.health.status == 'Degraded'
    trigger.on-sync-failed: |
      - description: Application syncing has failed
        send:
        - app-sync-failed
        when: app.status.operationState.phase in ['Error', 'Failed']
    trigger.on-sync-running: |
      - description: Application is being synced
        send:
        - app-sync-running
        when: app.status.operationState.phase in ['Running']
    trigger.on-sync-status-unknown: |
      - description: Application status is 'Unknown'
        send:
        - app-sync-status-unknown
        when: app.status.sync.status == 'Unknown'
    trigger.on-sync-succeeded: |
      - description: Application syncing has succeeded
        send:
        - app-sync-succeeded
        when: app.status.operationState.phase in ['Succeeded']
    trigger.on-out-of-sync: |
      - description: Application is out of sync or has a sync error
        send:
        - app-out-of-sync
        when: app.status.sync.status == 'OutOfSync'
YAML
}