.DEFAULT_GOAL := help

build-modules: ## Rebuild all modules of the current project
	@scripts/build-all-modules

analyze-modules: ## Do static Analysis on all modules of the current project
	@scripts/analyze-all-modules

test-modules: ## Run test on all modules of the current project
	@scripts/test-all-modules

merge-modules: ## Run merge lcov on all modules of the current project
	@scripts/merge-all-lcov "**/*module.dart **/pages/*.dart **/main.dart **/app_widget.dart"

genhtml: ## Run merge lcov on all modules of the current project and generate html
	@scripts/genhtml-lcov

percent-modules: ## Run percent from lcov on all modules
	@scripts/coverage-percent

help: ## Print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
