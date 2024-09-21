#!/bin/bash
set -e

# Variables (should be passed as environment variables)
GITHUB_TOKEN=${GITHUB_TOKEN}
RUNNER_NAME=${RUNNER_NAME:-docker-runner}
RUNNER_WORKDIR=${RUNNER_WORKDIR:-_work}
GITHUB_URL=${GITHUB_URL:-https://github.com/your-org-or-user}
REPO=${REPO:-your-repo} # Leave empty if registering for an org

# Registration script
cd actions-runner

# Configure the runner
if [ -z "$REPO" ]; then
    # Register as an organization runner
    ./config.sh --url $GITHUB_URL --token $GITHUB_TOKEN --name $RUNNER_NAME --work $RUNNER_WORKDIR --unattended --replace
else
    # Register as a repository runner
    ./config.sh --url $GITHUB_URL/$REPO --token $GITHUB_TOKEN --name $RUNNER_NAME --work $RUNNER_WORKDIR --unattended --replace
fi

# Install and start the service
./svc.sh install
./svc.sh start

# Keep the container running
tail -f /dev/null
