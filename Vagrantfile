# Read this
# https://developer.hashicorp.com/vagrant/docs/provisioning/ansible
# https://gist.github.com/akrabat/a4bf3e60ea9c3a39a2c162afcf154d24

Vagrant.configure(2) do |config|
  config.vm.box_check_update = true
  config.vm.provider :virtualbox do |v|
    v.cpus = 2
    v.memory = "4096"
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end

  ##
  ## Linux
  ##
  # https://app.vagrantup.com/ubuntu
  # user/pass = vagrant

  # desktop
  config.vm.define :linux_desktop do |host|
    host.vm.box = "ubuntu/focal64"
    host.vm.provision "shell", inline: "sudo apt-get update -y"
    host.vm.provision "shell", inline: "sudo apt-get install -y net-tools openssh-server python"

    host.vm.provider :virtualbox do |v|
      v.name = "linux_desktop"
      v.gui = true
    end

    host.vm.provision "ansible" do |ansible|
      ansible.playbook = "desktop.yml"
      # ansible.verbose = "v"
    end
  end

  # laptop
  config.vm.define :linux_laptop do |host|
    host.vm.box = "ubuntu/focal64"
    host.vm.provision "shell", inline: "sudo apt-get update -y"
    host.vm.provision "shell", inline: "sudo apt-get install -y net-tools openssh-server python"

    host.vm.provider :virtualbox do |v|
      v.name = "linux_laptop"
      v.gui = true
    end

    host.vm.provision "ansible" do |ansible|
      ansible.playbook = "laptop.yml"
      # ansible.verbose = "v"
    end
  end

  # server
  config.vm.define :server do |host|
    host.vm.box = "ubuntu/focal64"
    host.vm.provision "shell", inline: "sudo apt-get update -y"
    host.vm.provision "shell", inline: "sudo apt-get install -y net-tools openssh-server python"

    host.vm.provider :virtualbox do |v|
      v.name = "server"
      v.gui = false
    end

    host.vm.provision "ansible" do |ansible|
      ansible.playbook = "server.yml"
      # ansible.verbose = "v"
    end
  end

  ##
  ## Windows
  ##
  # desktop
  # config.ssh.remote_user = "admin"
  # config.ssh.username = "admin"
  # config.winrm.username = "admin"
  # config.winrm.password = "admin"
  provisioner = Vagrant::Util::Platform.windows? ? :guest_ansible : :ansible

  config.vm.define :windows_desktop do |host|
    host.vm.box = "gusztavvargadr/windows-10"
    host.vm.boot_timeout = 600
    host.vm.provider :virtualbox do |vb|
      vb.name = "windows_desktop"
      vb.gui = true
    end

    host.vm.provision "ansible" do |ansible|
      ansible.playbook = "desktop.yml"
      # ansible.verbose = "v"
    end
  end

  # laptop
  config.vm.define :windows_laptop do |host|
    host.vm.box = "gusztavvargadr/windows-10"
    host.vm.provider :virtualbox do |v|
      v.name = "windows_laptop"
      v.gui = true
    end

    host.vm.provision "ansible" do |ansible|
      ansible.playbook = "laptop.yml"
      # ansible.verbose = "v"
    end
  end
end





###
### Example of more reusable code
###
# servers=[
#   {
#     :name => "linux_desktop",
#     :box => "ubuntu/focal64",
#     :gui => true,
#     :playbook => "desktop.yml"
#   },
#   {
#     :name => "linux_laptop",
#     :box => "ubuntu/focal64",
#     :gui => true,
#     :playbook => "laptop.yml"
#   },
#   {
#     :name => "server",
#     :box => "ubuntu/focal64",
#     :gui => false,
#     :playbook => "server.yml"
#   },
#   {
#     :name => "windows_desktop",
#     :box => "gusztavvargadr/windows-10",
#     :gui => true,
#     :playbook => "desktop.yml"
#   },
#   {
#     :name => "windows_laptop",
#     :box => "gusztavvargadr/windows-10",
#     :gui => true,
#     :playbook => "laptop.yml"
#   },
# ]

# Vagrant.configure(2) do |config|
#   config.vm.box_check_update = true

#   servers.each do |server|
#     config.vm.define server[:hostname] do |node|
#       node.vm.box = server[:box]
#       # node.vm.hostname = machine[:hostname]
#       # node.vm.network "private_network", ip: machine[:ip]
#       # node.vm.provider :virtualbox do |vb|
#       #     vb.name = server[:name]
#       #     v.gui = server[:gui]
#       #     v.cpus = 2
#       #     v.memory = "4096"
#       #     v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
#       # end

#       # node.vm.provision :ansible do |ansible|
#       #   ansible.playbook = machine[:playbook]
#       # end
#     end
#   end
# end
