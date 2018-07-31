# Monitoring stack using Prometheus and Grafana on Docker

Use this template to provision and configure containers stack with the following runtimes:

* [Prometheus](https://hub.docker.com/r/prom/prometheus/)
* [Graphana](https://hub.docker.com/r/grafana/grafana)

## Requirements

### Supported Software AG releases

* Command Central 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Monitoring dashbards using Command Central monitoring REST API

## Using Docker Compose

### Launching containers with docker-compose

Launch Command Central container from the project root:

```bash
docker-compose up cc -d
```

Launch prometheus and grafana stack:

```bash
docker-compose -f templates/prometheus/docker-compose.yml up -d
```

Browse to http://localhost:3000 to open Grafana Web UI. Login (admin/admin)
