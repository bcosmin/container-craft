# container-craft

**container-craft** is a modular "Docker factory" designed to orchestrate container builds using reusable snippets, bash-based orchestration, and structured recipes. It eliminates code duplication and enforces security best practices across all your microservices.

## Features

- **Modular Design:** Compose production-ready `Dockerfiles` using clean, reusable snippets (`base/`, `security/`, `tools/`).
- **Pure Bash Engine:** No external dependencies like Python or heavy parsers—everything runs natively via robust shell scripts.
- **Security First:** Enforces least-privilege principles out-of-the-box with automated non-root user creation.
- **Isolated Output:** Automatically generates and preserves final `Dockerfiles` inside an organized `output/` directory for easy inspection and auditing.
- **Pre-flight Validation:** Verifies all pipeline components before triggering a build to prevent mid-way failures.
- **Automated Validation:** Includes a built-in test suite to verify container health and security policy compliance.

## Prerequisites

Before running **container-craft**, ensure you have the following installed on your system:

- **Docker:** Engine running and accessible via CLI (`docker version`)
- **Bash:** Version 4.0 or higher
- **Core Utilities:** Standard Unix utilities (`git`, `curl`, `uname`, `mkdir`, `cat`)

## Structure

```text
container-craft/
├── core/           # Production-grade build orchestration engine (builder.sh)
├── snippets/       # Modular Dockerfile building blocks (base, security, tools)
├── recipes/        # Application recipes (configuration configs & source code)
├── output/         # Generated Dockerfiles
└── tests/          # Automated container validation scripts       
```

## Getting Started

### 1. Build a recipe

#### Anatomy of a Recipe (`recipes/<recipe_name>/`)

Every recipe consists of a configuration file (recipe.cfg) and its application source code:

```bash
# [RECIPE CONFIG: FastAPI Web Microservice]
IMAGE_NAME="container-craft/fastapi-app"
IMAGE_TAG="latest"

# Modular pipeline order
PIPELINE=(
    "base/ubuntu"
    "tools/python/install-python"
    "tools/python/deps"
    "security/non-root-user"
    "tools/python/app-runner"
)
```

Choose a recipe and run the orchestration engine:

```bash
./core/builder.sh <recipe_name>
# Example: ./core/builder.sh web-app-py
```

**Note:** This will validate the pipeline, assemble the unified Dockerfile inside `output/<recipe_name>/`, and trigger the Docker build using the recipe's context.

### 2. Verify your image

Run the built-in test suite to ensure the image meets security and health standards:

```bash
./tests/container-tests.sh container-craft/<your-app>:latest
# Example: ./tests/container-tests.sh container-craft/web-app-py:latest
```

## Adding a New Snippet

To add a new tool or configuration:

- Create a directory under `snippets/tools/<name>/`.
- Create a `.dockerfile` inside that directory.
- Use the `[SNIPPET_ID: tools/<name>/<filename>]` convention in the header.

## Contributing

- Recipes: Add a new directory in `recipes/` with a `recipe.cfg` file.
- Snippets: Contributions to the library of modular Dockerfile snippets are welcome.

## License

MIT
