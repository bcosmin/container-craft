<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 160" width="100%" height="100%">
  <defs>
    <linearGradient id="boxGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#0db7ed;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#0284c7;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="craftGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#f97316;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#ea580c;stop-opacity:1" />
    </linearGradient>
  </defs>

  <!-- Dark minimal background -->
  <rect width="650" height="160" rx="12" fill="#090d16" />

  <!-- Geometric Minimalist Icon: Modular interlocking craft/container blocks -->
  <g transform="translate(35, 30)">
    <!-- Base Container Box -->
    <rect x="0" y="20" width="60" height="60" rx="10" fill="url(#boxGrad)" opacity="0.25" />
    <rect x="10" y="30" width="60" height="60" rx="10" fill="url(#boxGrad)" />
    
    <!-- Modular Plug-in / Craft Block -->
    <rect x="40" y="10" width="35" height="35" rx="8" fill="url(#craftGrad)" />
    <!-- Inner tech dot -->
    <circle cx="57.5" cy="27.5" r="4" fill="#090d16" />
  </g>

  <!-- Typography: container-craft -->
  <text x="145" y="92" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif" font-size="42" font-weight="700" fill="#f8fafc" letter-spacing="-0.5">
    container<tspan fill="#0db7ed">-</tspan><tspan fill="#f97316">craft</tspan>
  </text>
  
  <!-- Subtitle -->
  <text x="148" y="118" font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif" font-size="12" font-weight="600" fill="#64748b" letter-spacing="3.5">
    MODULAR DOCKER FACTORY
  </text>
</svg>


 
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

or you can use make

```bash
make build RECIPE=web-app-py
make build RECIPE=web-app-go
```

**Note:** This will validate the pipeline, assemble the unified Dockerfile inside `output/<recipe_name>/`, and trigger the Docker build using the recipe's context.

### 2. Verify your image

Run the built-in test suite to ensure the image meets security and health standards:

```bash
./tests/container-tests.sh container-craft/<your-app>:latest
# Example: ./tests/container-tests.sh container-craft/web-app-py:latest
```

or using make

```bash
make test IMAGE=container-craft/fastapi-app:latest
make test IMAGE=container-craft/go-app:latest
```

### 3. Cleanup

To remove all generated output artifacts:

```bash
make clean
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
