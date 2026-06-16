# PR Title: dockerize HTTP server for challenge-3

## Task: Challenge 3 (Dockerize HTTP server)

### Overview
Add `Dockerfile`, and a `README.md` walkthrough Challenge 3.

- `Dockerfile` — Builds a minimal python:3.11-slim image with a non-root user for security practice. It dockerize the existing server.py file to serve the HTTP server.
- `README.md` — Covers the full workflow: build, run, test, push, and cleanup.

### Testing
Verified locally via curl with and without the required header, and the production image has been pushed to the public [Docker Hub](https://hub.docker.com/repository/docker/orcahaeyoon/sre-interview-homwork/general).

The pushed docker image can be seen the public Docker Hub via the [link](https://hub.docker.com/repository/docker/orcahaeyoon/sre-interview-homwork/general). In case, you can't access due to the Docker Hub requires to sign in, then you can see the image details and image layer in the screenshots.

### Docker Hub details
- Repo: `orcahaeyoon/sre-interview-homwork`
- Tag: `challenge-3`

<img width="814" height="580" alt="Screenshot 2026-06-14 at 13 29 31" src="https://github.com/user-attachments/assets/a995ad33-93e5-4c99-98e5-f8ef921d6650" />
<img width="1152" height="847" alt="Screenshot 2026-06-14 at 13 29 49" src="https://github.com/user-attachments/assets/33464e45-717c-48eb-883f-f6b232665bb5" />

### PR status
- [x] Merged
- [x] Approved

### PR public Link
https://github.com/HaeyoonJo/interview-homework-challenge-sre/pull/2