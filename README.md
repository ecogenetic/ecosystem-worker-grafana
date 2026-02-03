### Updated README.md

# EcosystemAI Grafana Deployment

This repository provides a containerized **Grafana** environment customized for the **EcosystemAI** platform. It automates the pre-installation of specific plugins and dynamically configures datasources with **JWT authentication** during the container startup process.

---

## Repository Purpose

The primary goal of this codebase is to maintain a standardized Grafana image (`ecosystem-grafana`) that is ready to use with internal APIs. It handles the complexity of:

* **Multi-Platform Support:** Building images for both `amd64` and `arm64` architectures.
* **Dynamic Authentication:** Automatically fetching a JWT token from a remote server and injecting it into datasource configurations.
* **Persistent Provisioning:** Managing a template database and pre-installed plugins to ensure environment consistency.

---

## Core Components

### Docker Configurations

The repository contains two distinct Docker setups:

* **Standard Dockerfile:** Based on `grafana/grafana:latest`, it pre-installs plugins and uses `entrypoint.sh` for JWT token handling.
* **No-JWT Dockerfile (`Dockerfile-nojwt`):** A variation that skips automated token retrieval while still provisioning necessary plugins and templates.

### Entrypoint Logic

The `entrypoint.sh` script manages the container's lifecycle before Grafana starts:

1. **Token Retrieval:** It makes up to five attempts to fetch a JWT token via a POST request to the `GF_AUTH_JWT_URL`.
2. **Configuration Injection:** Once retrieved, it uses `sed` to replace `${JWT_TOKEN}` placeholders in the datasource templates.
3. **Database Setup:** If no existing database is found in the volume, it initializes the environment using `grafana.db.template`.

---

## Management Scripts

| Script | Purpose |
| --- | --- |
| `01-build.sh` | Orchestrates multi-platform builds for `latest`, `arm64`, and `nojwt` tags. |
| `02-push.sh` | Pushes the built images to the `ecosystemai/ecosystem-grafana` Docker Hub. |
| `04-run-install-plugins.sh` | Utility for local testing with specific environment variables. |

---

## Provisioned Plugins & Datasources

The following plugins are bundled or pre-installed via environment variables:

### Current Standards

* **Infinity Datasource:** (`yesoreyeram-infinity-datasource`) The primary engine for connecting to `http://ecosystem-server:3001/api` using Bearer Tokens.
* **Trino Datasource:** (`trino-datasource`) For high-performance distributed SQL queries.

### Deprecated (Maintenance Only)

* **JSON API Datasource:** (`marcusolsson-json-datasource`).
* **ECharts Panel:** (`volkovlabs-echarts-panel`).

---

## Setup Process for Ecosystem Server Connector

To avoid build errors in MDX/Markdown, ensure placeholders are wrapped in backticks:

1. Use the **Infinity** or **JSON API** source.
2. Assign the URL for login: `http://<server>:3001/api/auth/login`
3. Sign into the Swagger UI of the ecosystem server to generate a JWT token `<key>`.
4. Setup a custom header with `Authorization` and a value of `Bearer <key>`.

> **Note:** The `01-build.sh` script includes a cleanup step to remove `.DS_Store` files to prevent plugin loading failures.
