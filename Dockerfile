# Use the official Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    sudo \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create a user for the runner
RUN useradd -m runner

# Switch to the runner user
USER runner
WORKDIR /home/runner

# Define GitHub runner version
ENV RUNNER_VERSION=2.319.1

# Download and install the GitHub runner
RUN mkdir actions-runner && cd actions-runner \
    && curl -o actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz \
    && tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz \
    && rm actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

# Install any additional tools if necessary
# Example: Install Docker inside the runner
USER root
RUN apt-get update && apt-get install -y \
    docker.io \
    && rm -rf /var/lib/apt/lists/* \
    && usermod -aG docker runner

USER runner

# Copy entrypoint script
COPY entrypoint.sh /home/runner/entrypoint.sh

# Define default command
ENTRYPOINT ["/home/runner/entrypoint.sh"]
