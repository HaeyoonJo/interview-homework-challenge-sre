# PR Title: add Helm chart to deploy challenge-3 Python HTTP server

## Task: Challenge-5

### Overview
Completes challenge 5 by adding a Helm chart in server-chart/ to deploy the Python HTTP server from challenge 3 to Kubernetes.

### Description
- `Chart.yaml` — chart metadata
- `values.yaml` — configurable image, replicas, service type/port, and resource limits
- `templates/_helpers.tpl` — (optional) templates for consistent naming and labels
- `templates/deployment.yaml` — Deployment targeting container port 8080
- `templates/service.yaml` — ClusterIP Service correctly routes to the deployment

### Test
- [x] `helm lint` passes without errors
- [x] `helm template` renders valid Kubernetes manifests
- [x] Deployment targets container port 8080
- [x] Service correctly routes to the deployment
- [x] All hardcoded values are parameterized in values.yaml

### PR status
- [x] Merged
- [x] Approved

### PR public Link
https://github.com/HaeyoonJo/interview-homework-challenge-sre/pull/6