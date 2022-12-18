# Configure the GitHub Provider
provider "github" {
    token = var.GITHUB_TOKEN
    owner = var.organization
}

## create repositories declared in vars

## Create the repository

resource "github_repository" "repository" {
    for_each = var.repositories
    name = each.value
    visibility = "private"
    vulnerability_alerts = true

    template {
        owner = var.organization
        repository = var.repository_template
    }
}

## Netsted loop for repositories, teams and roles

locals {
    repositories = var.repositories
    teams_roles = var.teams_roles
    repository_team = flatten([
        for repository in local.repositories : [
            for role in local.teams_roles : {
                repository = repository
                role = role
            }
        ]
    ])
}

## create its teams

resource "github_team" "teams" {
    for_each = { for entry in local.repository_team: "${entry.repository}-team-${entry.role}" => entry }
    name = "${each.value.repository}-team-${each.value.role}"
    # create_default_maintainer = true
}

## Assign teams

resource "github_team_repository" "dept-1-app-1-team-repo" {
    for_each = { for entry in local.repository_team: "${entry.repository}-team-${entry.role}" => entry }
    team_id = "${each.value.repository}-${each.value.role}"
    permission = each.value.role
    repository = each.value.repository
}

