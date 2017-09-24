# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  if Vagrant::Util::Platform.windows?
    config.vm.synced_folder ".", "/vagrant/ansible-role-ruby"
    config.vm.provision "ansible_local" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.config_file = "tests/ansible.cfg"
      ansible.become = true
      ansible.playbook = "tests/test.yml"
      ansible.provisioning_path = "/vagrant/ansible-role-ruby"
      ansible.install_mode = "pip"
      ansible.version = "2.3.2.0"
    end
  else
    config.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.config_file = "tests/ansible.cfg"
      ansible.become = true
      ansible.playbook = "tests/test.yml"
    end
  end
end
