# setup provider

provider "sonarqube" {
    token = var.SONAR_TOKEN
    host   = var.sonar_host
}

## create projects declared in vars

## Create the project

resource "sonarqube_project" "project" {
    for_each = var.projects
    name = each.value
    visibility = "public"
    project = "${var.organization}_${each.value}"
}

## Netsted loop for projects, teams and roles

locals {
    projects = var.projects
    teams_roles = var.teams_roles
    project_team = flatten([
        for project in local.projects : [
            for role in local.teams_roles : {
                project = project
                role = role
            }
        ]
    ])
}

## create its teams

resource "sonarqube_group" "teams" {
    for_each = { for entry in local.project_team: "${entry.project}-team-${entry.role}" => entry }
    name = "${each.value.project}-team-${each.value.role}"
    description = "${each.value.role} for ${each.value.project}"
}

## Assign teams

## wait a little because Sonarqube is working async

resource "time_sleep" "wait_30_seconds" {
    depends_on = [
        sonarqube_group.teams
    ]
    create_duration = "30s"
}

resource "sonarqube_permissions" "permissions" {
    depends_on = [
        time_sleep.wait_30_seconds
    ]
    for_each = { for entry in local.project_team: "${entry.project}-team-${entry.role}" => entry }
    group_name = "${each.value.project}-team-${each.value.role}"
    permissions = [each.value.role]
    project_key = "${var.organization}_${each.value.project}"
}

