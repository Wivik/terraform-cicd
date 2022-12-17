variable "GITHUB_TOKEN" {
    type = string
}

variable "organization" {
    default = "poochi-corp"
}

variable "repository_template" {
    default = "std-template-repository"
}

variable "teams_roles" {
    type = set(string)
    default = ["read", "write", "admin"]
}