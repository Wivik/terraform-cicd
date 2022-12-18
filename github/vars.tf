## The GITHUB_TOKEN PAT that'ill execute the actions
## It's an environment variable named TF_VARS_GITHUB_TOKEN that provide it
variable "GITHUB_TOKEN" {
    type = string
}

## The target organization
variable "organization" {
    default = "poochi-corp"
}

## The default repository template
variable "repository_template" {
    default = "std-template-repository"
}

## The teams roles to create for each repository
variable "teams_roles" {
    type = set(string)
    default = ["push", "admin"]
}

## The repositories list
variable "repositories" {
    type=set(string)
    default = [
        "dept-1-app-1",
        # "dept-2-app-1",
        # "dept-3-app-1",
        # "dept-4-app-1",
    ]
}