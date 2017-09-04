Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.gui = false
    vb.linked_clone = true
  end
  config.vm.provision "shell", path: "install_ruby.sh", privileged: false, keep_color: true, name: "install_ruby"
  config.vm.provision "shell", path: "install_mongodb.sh", keep_color: true, name: "install_mongodb"
  config.vm.provision "shell", path: "deploy.sh", privileged: false, keep_color: true, name: "deploy_app"
end
