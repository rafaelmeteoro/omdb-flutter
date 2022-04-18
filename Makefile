.DEFAULT_GOAL := help

analyze-modules: ## Do static Analysis on all modules of the current project
				@scripts/analyze-all-modules

help: ## Print this help
				@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
