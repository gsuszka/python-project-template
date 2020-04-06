.PHONY: help test

.DEFAULT_GOAL := help

include $(wildcard makefiles/*.mk)
include $(wildcard .env*)

create-project: scripts/create_project.sh ## Creates project
	$(call envvars) bash scripts/create_project.sh

help: ## Shows this help
	@grep -hE '^[a-zA-Z_-]+:.*##.*$$' $(MAKEFILE_LIST) |sort| awk 'BEGIN { FS = ":.*##" }; { printf "\033[36m%-30s\033[0m%s\n", $$1, $$2 }'

