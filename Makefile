default: check

.PHONY: tasks
tasks: ## Print available tasks
	@printf "\nUsage: make [target]\n\n"
	@grep -E '^[a-z][^:]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: cyclic_dependency_checks/install
cyclic_dependency_checks/install: ## Fetch dependencies for cyclic_dependency_checks
	cd cyclic_dependency_checks; dart pub get

.PHONY: cyclic_dependency_checks/format
cyclic_dependency_checks/format: ## Format cyclic_dependency_checks code
	cd cyclic_dependency_checks; dart format lib --line-length 100 --set-exit-if-changed

.PHONY: cyclic_dependency_checks/test
cyclic_dependency_checks/test: ## Run cyclic_dependency_checks tests
	cd cyclic_dependency_checks; dart scripts/generate_big_codebase.dart; dart test

.PHONY: weather_app/install
weather_app/install: ## Fetch dependencies for weather_app
	cd weather_app; flutter pub get

.PHONY: weather_app/format
weather_app/format: ## Format weather_app code
	cd weather_app; dart format lib --line-length 100 --set-exit-if-changed

.PHONY: weather_app/test
weather_app/test: ## Run weather_app tests
	cd weather_app; flutter test

.PHONY: format
format: cyclic_dependency_checks/format weather_app/format ## Format all code

.PHONY: test
test: cyclic_dependency_checks/test weather_app/test ## Run all tests

.PHONY: check-cycles
check-cycles: ## Test cyclic dependencies
	cd cyclic_dependency_checks; dart run cyclic_dependency_checks ../weather_app

.PHONY: check
check: format test check-cycles ## Check formatting and run tests
