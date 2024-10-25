default: lint

.PHONY: lint
lint:
	ansible-lint --force-color

.PHONY: laptop
laptop:
	ansible-playbook -c local -f 30 -i localhost, laptop.yml

.PHONY: server
server:
	ansible-playbook -f 30 -i inventory.yml --limit server playbook.yml

# ansible-playbook -f 30 -i inventory.yml --limit docker playbook.yml


##
## Vagrant testing
##
.PHONY: test-clean
test-clean:
	vagrant destroy -f

.PHONY: test-laptop
test-laptop:
	vagrant up --provision laptop

# linux_desktop
.PHONY: test-desktop
test-desktop:
	vagrant up --provision desktop

.PHONY: test-server
test-server:
	vagrant up --provision server


# PHONY: docker-test
# docker-test:
# 	ansible-playbook -i invenotry systems.yaml --limit docker --extra-vars "type=$(TYPE)"

# PHONY: vagrant-provision
# vagrant-provision:
# 	export TYPE='$(TYPE)'; vagrant provision
