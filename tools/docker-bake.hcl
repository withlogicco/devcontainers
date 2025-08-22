group "default" {
  targets = ["base", "builder", "postgres", "git", "node", "zsh"]
}

target "postgres" {
  context = "./postgres"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/postgres:latest"]
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "git" {
  context = "./git"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/git:latest"]
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "node" {
  context = "./node"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/node:latest"]
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "zsh" {
  context = "./zsh"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/zsh:latest"]
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "base" {
  context = "./base"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/base:latest"]
}

target "builder" {
  context = "./builder"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/builder:latest"]
  contexts = {
    base = "target:base"
  }
}
