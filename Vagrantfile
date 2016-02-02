# Vagrantfile for amaterasu dev station
Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.1"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "node1"
  config.vm.synced_folder "~/Shinto/amaterasu/target/scala-2.11", "/ama"
           
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4098"
  end

  config.vm.provision "shell", run: "always" do |s|
	  s.path = "provision.sh"
	  s.privileged = true 
  end		 
end
