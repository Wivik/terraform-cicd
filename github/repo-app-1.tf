## Create the repository

resource "github_repository" "dept-1-app-1" {
    name = "dept-1-app-1"
    description = "Repository for application 1 of department 1"
    visibility = "private"
    topics = ["app-1", "dept-1"]
    vulnerability_alerts = true

    template {
        owner = var.organization
        repository = var.repository_template
    }
}

## create its teams

resource "github_team" "dept-1-app-1-team" {
    for_each = var.teams_roles
    name = "dept-1-app-1-team-${each.value}"
}

## Assign teams

resource "github_team_repository" "dept-1-app-1-team-repo" {
    for_each = var.teams_roles
    team_id = "dept-1-app-1-team-${each.value}"
    permission = each.value
    repository = "dept-1-app-1"
}