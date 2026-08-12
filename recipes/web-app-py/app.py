#!/usr/bin/env python3
"""
[CONTAINER-CRAFT DEMO] High-performance FastAPI Microservice.
Runs an asynchronous web server inside the secured container.
"""

from fastapi import FastAPI

# Initialize the FastAPI application
app = FastAPI(
    title="Container-Craft FastAPI Service",
    version="1.0.0",
    description="A modular microservice built with container-craft"
)

@app.get("/", tags=["Health"])
def health_check():
    """
    Health check endpoint confirming the container is running successfully.
    """
    return {
        "status": "success",
        "message": "Hello from container-craft FastAPI microservice!",
        "architecture": "modular"
    }