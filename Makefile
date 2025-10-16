.PHONY: test-server
test-server:
	ansible-playbook --connection=local --inventory localhost, server.yml

.PHONY: server
server:
	ansible-playbook -i inventory server.yml --limit server # --check --diff
