# [SNIPPET_ID: tools/go/app-runner-demo]
# Description: Copies Go source code, compiles it statically, and sets the entrypoint.

WORKDIR /app

# Copy source code
COPY main.go .

# Build the Go application as a static binary
RUN go build -o app main.go

# Expose the standard port
EXPOSE 8080

# Run the compiled binary
CMD ["./app"]