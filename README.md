https://docs.warp.dev/getting-started/getting-started-with-warp

# Config Ansible

## Setup

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## References

- Ansible
  - [What is an Ansible role](https://www.redhat.com/en/topics/automation/what-is-an-ansible-role)
  - [Playbook reuse roles](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_reuse_roles.html)
  - [Playbook vars](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html)
  - [Target hosts & groups](https://docs.ansible.com/ansible/latest/inventory_guide/intro_patterns.html)
  - [Injecting hosts](https://stackoverflow.com/questions/18195142/safely-limiting-ansible-playbooks-to-a-single-machine)
- Docker
  - [Galaxy](https://galaxy.ansible.com/ui/standalone/roles/geerlingguy/docker/documentation/)
  - [Docker](https://github.com/geerlingguy/ansible-role-docker)
- Testing
  - [Pytest-testinfra](https://github.com/pytest-dev/pytest-testinfra)
- Windows
  - [Vagrant Powershell](https://gist.github.com/akrabat/a4bf3e60ea9c3a39a2c162afcf154d24)
- Vagrant
  - [Ansible](https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_intro)

## Misc

### Playbooks

```yaml
# pre_tasks can be used before running roles
pre_tasks:
  - name: Laptop proof
    ansible.builtin.debug:
      msg:
        - "{{ ansible_facts }}"
```
