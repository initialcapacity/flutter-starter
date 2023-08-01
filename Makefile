default: check

.PHONY: tasks
tasks: ## Print available tasks
	@printf "\nUsage: make [target]\n\n"
	@grep -E '^[a-z][^:]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: format
format: ## Format code
	cd weather_app; dart format lib --line-length 100 --set-exit-if-changed

.PHONY: test
test: ## Run tests
	cd weather_app; flutter test

.PHONY: check
check: format test ## Check formatting and run tests
