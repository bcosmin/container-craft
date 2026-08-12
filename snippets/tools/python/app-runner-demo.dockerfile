# [SNIPPET_ID: tools/python/app-runner-demo]
# Description: Copies application source code and defines the default startup command.
# Note: Assumes app.py is present in the build context.

WORKDIR /app

# Copy the application source code
COPY app.py .

# Expose the standard port for the microservice
EXPOSE 8080

# Start the FastAPI application using Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]