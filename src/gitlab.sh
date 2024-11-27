#!/usr/bin/env bash

# shellcheck source=../lib-valet
source gitlab

#===============================================================
# >>> command: showcase command1
#===============================================================

##<<VALET_COMMAND
# command: gitlab projects
# function: gitlabProjects
# shortDescription: List GitLab projects.
# description: |-
#   List GitLab projects.
# options:
# - name: -r, --role <role>
#   description: |-
#     Filter projects by role. Possible values are: `guest`, `reporter`, `developer`, `maintainer`, `owner`.
#   default: developer
# examples:
# - name: gitlab projects
#   description: |-
#     List all projects where the user is a developer.
##VALET_COMMAND
function gitlabProjects() {
  local role
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  :;
}
