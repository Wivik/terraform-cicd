## The SONAR_TOKEN that will execute the actions
## It's an environment variable named TF_VAR_SONAR_TOKEN that provide it
variable "SONAR_TOKEN" {
    type = string
}

variable "sonar_host" {
    type = string
    default = "http://127.0.0.1:9000"
}

variable "organization" {
    type = string
    default = "poochi-corp"
}

## The teams roles to create for each project
variable "teams_roles" {
    type = set(string)
    default = ["user", "admin"]
}

## The projects list
variable "projects" {
    type=set(string)
    default = [
        "dept-1-app-1",
        "dept-2-app-1",
        # "dept-3-app-1",
        # "dept-4-app-1",
    ]
}