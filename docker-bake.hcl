group "default" {
  targets = ["base", "builder", "postgres", "git", "node", "zsh"]
}

target "postgres" {
  context = "./tools/postgres"
  dockerfile = "../tool/Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/postgres:latest"]
  args = {
    TOOL_NAME = "postgres"
    TOOL_VERSION = "17.4"
  }
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "git" {
  context = "./tools/git"
  dockerfile = "../tool/Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/git:latest"]
  args = {
    TOOL_NAME = "git"
    TOOL_VERSION = "2.51.0"
  }
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "node" {
  context = "./tools/node"
  dockerfile = "../tool/Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/node:latest"]
  args = {
    TOOL_NAME = "node"
    TOOL_VERSION = "22.18.0"
  }
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "zsh" {
  context = "./tools/zsh"
  dockerfile = "../tool/Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/zsh:latest"]
  args = {
    TOOL_NAME = "zsh"
    TOOL_VERSION = "5.9"
  }
  contexts = {
    base = "target:base"
    builder = "target:builder"
  }
}

target "base" {
  context = "./tools/base"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/base:latest"]
}

target "builder" {
  context = "./tools/builder"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/withlogicco/devcontainers/tools/builder:latest"]
  contexts = {
    base = "target:base"
  }
}
