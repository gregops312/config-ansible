# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  Docker Testing (Primary):"
	@echo "    docker-build          - Build Ansible test image"
	@echo "    docker-clean          - Remove Docker test image and cleanup"
	@echo "    docker-playbook       - Run playbook: make docker-playbook PLAYBOOK=server.yml [ARGS='--check']"
	@echo "    docker-shell          - Interactive shell in Ansible container"

	@echo ""
	@echo "  Lint/Test"
	@echo "    syntax-check          - Check playbook syntax locally"
	@echo ""
	@echo "  Deploys:"
	@echo "    local-gui             - Deploy gui to localhost"
	@echo "    local-server          - Deploy server to localhost"
	@echo "    server                - Deploy to production server"

# =============================================================================
# Docker
# =============================================================================

# Build the test image
.PHONY: docker-build
docker-build:
		docker build -t ansible-test .

# Clean up Docker
.PHONY: docker-clean
docker-clean:
	@echo "Cleaning up Docker test environment..."
	docker rmi ansible-test 2>/dev/null || true
	docker system prune -f

# Run ansible-playbook with custom arguments
.PHONY: docker-playbook
docker-playbook: docker-build
	@if [ -z "$(PLAYBOOK)" ]; then \
		echo "Usage: make docker-playbook PLAYBOOK=playbook.yml [ARGS='--check --diff']"; \
		echo "Example: make docker-playbook PLAYBOOK=server.yml ARGS='--check --diff'"; \
		exit 1; \
	fi
	@set -e; \
		docker rm -f ansible-test >/dev/null 2>&1 || true; \
		trap 'docker stop ansible-test >/dev/null 2>&1 || true' EXIT; \
		docker run -d --rm --name ansible-test \
			--privileged \
			--cgroupns=host \
			--tmpfs /run \
			--tmpfs /run/lock \
			-v $(PWD):/ansible:ro \
			ansible-test >/dev/null; \
		echo "Waiting for systemd..."; \
		timeout 30 sh -c 'until docker exec ansible-test systemctl is-system-running 2>/dev/null | grep -qE "running|degraded"; do sleep 1; done'; \
		ansible-playbook -i ansible-test, -c docker -e ansible_user=root $(ARGS) $(PLAYBOOK)

# Interactive shell in the container
.PHONY: docker-shell
docker-shell: docker-build
	@echo "Starting interactive Ansible container shell..."
	@docker rm -f ansible-test-shell >/dev/null 2>&1 || true
	@docker run -d --name ansible-test-shell \
		--privileged \
		--cgroupns=host \
		--tmpfs /run \
		--tmpfs /run/lock \
		-v $(PWD):/ansible \
		-w /ansible \
		ansible-test >/dev/null
	@echo "Waiting for systemd..."
	@timeout 30 sh -c 'until docker exec ansible-test-shell systemctl is-system-running 2>/dev/null | grep -qE "running|degraded"; do sleep 1; done'
	@echo "Ready — type 'exit' to stop the container."
	@docker exec -it ansible-test-shell bash || true
	@docker rm -f ansible-test-shell >/dev/null 2>&1 || true

# =============================================================================
# lint/test
# =============================================================================
.PHONY: syntax-check
syntax-check:
	ansible-playbook --syntax-check server.yml gui.yml

# =============================================================================
# Runs
# =============================================================================
.PHONY: local-gui
local-gui:
	ansible-playbook --connection=local --inventory localhost, gui.yml

.PHONY: local-server
local-server:
	ansible-playbook --connection=local --inventory localhost, server.yml

.PHONY: server
server:
	ansible-playbook -i inventory server.yml --limit server # --check --diff
