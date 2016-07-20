# Vagrantfile for amaterasu dev station
Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.1"
  config.vm.network "private_network", ip: "192.168.33.11"
  config.vm.hostname = "node1"
  config.vm.synced_folder "~/Work/Shinto/io/amaterasu/target/scala-2.10", "/ama"
           
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4098"
		vb.cpus = 4
  end

  config.vm.provision "shell", run: "always" do |s|
	  s.path = "provision.sh"
	  s.privileged = true 
  end		 
end
