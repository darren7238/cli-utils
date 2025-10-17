
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean the project using cargo
	cargo clean

build: ## Build the project using cargo
	cargo build

lint: ## Lint the project using cargo clippy
	@rustup component add clippy 2> /dev/null
	cargo clippy

fmt: ## Format the project using cargo
	@rustup component add rustfmt 2> /dev/null
	cargo fmt

bump: ## Bump the version using cargo
	echo "Current version: $$(cargo pkgid | cut -d# -f2)"
	@read -p "Enter new version: " version; \
	updated_version=$$(cargo pkgid | cut -d# -f2 | sed -E "s/^[0-9]+\.[0-9]+\.[0-9]+/$$version/"); \
	echo "New version is $(cargo pkgid | cut -d# -f2)"%
