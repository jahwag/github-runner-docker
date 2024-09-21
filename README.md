# GitHub Actions Docker Runner

A Dockerized GitHub Actions self-hosted runner for Linux, enabling scalable and efficient CI/CD workflows.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed
- GitHub Personal Access Token with runner permissions

## Setup

### Build the Docker Image

```bash
docker build -t github-runner .
```

### Run the Container

#### For a Repository Runner:

```bash
docker run -d \
  --name github-runner \
  -e GITHUB_TOKEN=your_personal_access_token \
  -e GITHUB_URL=https://github.com/your-username \
  -e REPO=your-repo \
  github-runner
```

#### For an Organization Runner:

```bash
docker run -d \
  --name github-runner \
  -e GITHUB_TOKEN=your_personal_access_token \
  -e GITHUB_URL=https://github.com/your-org \
  github-runner
```

## Environment Variables

- `GITHUB_TOKEN` - Your GitHub Personal Access Token
- `GITHUB_URL` - GitHub URL (e.g., `https://github.com/your-org` or `https://github.com/your-username`)
- `REPO` - (Optional) Repository name for repository-specific runners
- `RUNNER_NAME` - (Optional) Name of the runner (default: `docker-runner`)
- `RUNNER_WORKDIR` - (Optional) Working directory (default: `_work`)

## Update Runner

1. Update `RUNNER_VERSION` in the `Dockerfile`.
2. Rebuild the image:
    ```bash
    docker build -t github-runner .
    ```
3. Restart the container:
    ```bash
    docker stop github-runner
    docker rm github-runner
    docker run -d [OPTIONS] github-runner
    ```
