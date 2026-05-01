# Dockerfile for Ansible Testing
FROM ubuntu:26.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV ANSIBLE_STDOUT_CALLBACK=yaml
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y \
        ansible \
        ansible-lint \
        curl \
        git \
        openssh-client \
        python3 \
        python3-pip \
        python3-venv \
        python3-apt \
        rsync \
        sudo \
        sshpass

# Create ansible user with sudo privileges
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set working directory
WORKDIR /ansible

# Create directories for test data
RUN mkdir -p /data /tmp/ansible

# Switch to ansible user
USER ansible

# Verify installation
RUN ansible --version && \
    ansible-lint --version

# Default command (can be overridden)
CMD ["bash"]
