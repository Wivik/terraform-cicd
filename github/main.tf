# Configure the GitHub Provider
provider "github" {
    token = var.GITHUB_TOKEN
    owner = var.organization
}
