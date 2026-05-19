# Dockerfile for Ansible Testing
FROM ubuntu:26.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV ANSIBLE_STDOUT_CALLBACK=ansible.builtin.default
ENV ANSIBLE_CALLBACK_RESULT_FORMAT=yaml
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
        systemd \
        systemd-sysv \
        sshpass

# Remove unnecessary systemd units that cause issues in containers
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev*

# Create ansible user with sudo privileges
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set working directory
WORKDIR /ansible

# Create directories for test data
RUN mkdir -p /data /tmp/ansible

# Verify installation (as ansible user)
USER ansible
RUN ansible --version && \
    ansible-lint --version

# Switch back to root for systemd init (required for Docker-in-Docker)
USER root

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
