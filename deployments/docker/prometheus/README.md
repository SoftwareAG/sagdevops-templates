# Monitoring stack using Prometheus and Grafana on Docker

Use this stack to launch [Prometheus](https://hub.docker.com/r/prom/prometheus/)
and [Graphana](https://hub.docker.com/r/grafana/grafana) containers
with default dashboards integrated with Command Central 10.3
basic monitoring REST API.

## Requirements

### Supported Software AG releases

* Command Central 10.3

### Supported platforms

* Docker 17.09+

### Supported use cases

* Monitoring dashbards using Command Central monitoring REST API

## Launching monitoring stack using docker-compose

Launch [Command Central 10.3 Stack](../sag-cc/) first.

Launch Prometheus and Grafana stack:

```bash
docker-compose up -d
```

Browse to http://localhost:3000 to open Grafana Web UI. Login (admin/admin)
