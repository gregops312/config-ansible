default: lint

.PHONY: server
server:
	ansible-playbook -i inventory server.yml --limit server
