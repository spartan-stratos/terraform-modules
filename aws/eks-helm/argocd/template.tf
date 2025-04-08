locals {
  slack_templates = {
    "template.app-deployed" = <<EOT
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
EOT

    "template.app-health-degraded" = <<EOT
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
EOT

    "template.app-sync-failed" = <<EOT
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
EOT

    "template.app-sync-running" = <<EOT
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
EOT

    "template.app-sync-status-unknown" = <<EOT
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
EOT

    "template.app-sync-succeeded" = <<EOT
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
EOT
    "template.app-out-of-sync"    = <<EOT
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
EOT
  }

  slack_triggers = {
    "trigger.on-deployed" = <<EOT
- description: Application is synced and healthy. Triggered once per commit.
  oncePer: app.status.sync.revision
  send:
  - app-deployed
  when: app.status.operationState.phase in ['Succeeded'] and app.status.health.status == 'Healthy'
EOT

    "trigger.on-health-degraded" = <<EOT
- description: Application has degraded
  send:
  - app-health-degraded
  when: app.status.health.status == 'Degraded'
EOT

    "trigger.on-sync-failed" = <<EOT
- description: Application syncing has failed
  send:
  - app-sync-failed
  when: app.status.operationState.phase in ['Error', 'Failed']
EOT

    "trigger.on-sync-running" = <<EOT
- description: Application is being synced
  send:
  - app-sync-running
  when: app.status.operationState.phase in ['Running']
EOT

    "trigger.on-sync-status-unknown" = <<EOT
- description: Application status is 'Unknown'
  send:
  - app-sync-status-unknown
  when: app.status.sync.status == 'Unknown'
EOT

    "trigger.on-sync-succeeded" = <<EOT
- description: Application syncing has succeeded
  send:
  - app-sync-succeeded
  when: app.status.operationState.phase in ['Succeeded']
EOT

    "trigger.on-out-of-sync" = <<EOT
- description: Application is out of sync or has a sync error
  send:
  - app-out-of-sync
  when: app.status.sync.status == 'OutOfSync'
EOT
  }
}
