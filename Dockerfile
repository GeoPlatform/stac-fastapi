ARG PYTHON_VERSION=3.11

FROM python:${PYTHON_VERSION}-slim as base

# Install build dependencies and PostgreSQL libraries
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

FROM base as builder

WORKDIR /app

# Copy project files into the container
COPY . /app

# Install project dependencies
RUN python -m pip install -e .[server]

# Ensure psycopg with pool is installed
RUN python -m pip install psycopg[binary,pool]

# Run the FastAPI app using Uvicorn
CMD ["uvicorn", "stac_fastapi.pgstac.app:app", "--host", "0.0.0.0", "--port", "8080"]
