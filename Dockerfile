FROM python:3.12-slim

# Install the MCP server from PyPI
RUN pip install --no-cache-dir intervals-icu-mcp

# Render provides $PORT at runtime; the server takes it as a CLI flag.
# Bind to 0.0.0.0 so Render's proxy can reach it inside the container.
# MCP_PATH is the hard-to-guess secret path, supplied as a Render env var so
# it never lives in this repo. It's the only thing protecting this
# unauthenticated server, so treat the full URL like a password.
CMD ["sh", "-c", "intervals-icu-mcp --transport http --host 0.0.0.0 --port ${PORT:-8000} --path /${MCP_PATH}/"]
