# =====================================================================
# [CONTAINER-CRAFT MAKEFILE]
# =====================================================================

.PHONY: help build test clean

# Default target when running just 'make'
default: help

help:
	@echo "container-craft available commands:"
	@echo "  make build RECIPE=<name>   - Build any custom recipe (e.g., make build RECIPE=web-app-py)"
	@echo "  make test IMAGE=<tag>      - Run automated tests for any image (e.g., make test IMAGE=container-craft/my-app:latest)"
	@echo "  make clean                 - Remove generated output artifacts"

# --- DYNAMIC BUILD ---
build:
	@if [ -z "$(RECIPE)" ]; then \
		echo "Error: RECIPE variable is not set. Please specify a recipe to build."; \
		exit 1; \
	fi
	@echo "Building recipe: $(RECIPE)"
	@./core/builder.sh $(RECIPE)

# --- DYNAMIC TESTS ---
test:
	@if [ -z "$(IMAGE)" ]; then \
		echo "Error: IMAGE parameter is missing."; \
		echo "Usage: make test IMAGE=<image_name:tag>"; \
		exit 1; \
	fi
	@echo "[*] Testing image: $(IMAGE)..."
	./tests/container-tests.sh $(IMAGE)

# --- MAINTENANCE ---
clean:
	@echo "[*] Cleaning up output artifacts..."
	rm -rf output/*
	@echo "[+] Clean complete."