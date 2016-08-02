# Vagrantfile for amaterasu dev station
Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.1"
  
  config.vm.define "node1" do |node1|
   
    node1.vm.network "private_network", ip: "192.168.33.11"
    node1.vm.hostname = "node1"
    node1.vm.synced_folder "~/Work/Shinto/io/amaterasu/target/scala-2.10", "/ama"
    node1.vm.synced_folder "~/Shinto/mesos-dependencies", "/mesos-dependencies"
           
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "2948"
		  vb.cpus = 2
    end

    node1.vm.provision "shell", run: "always" do |s|
	    s.path = "provision.sh"
	    s.privileged = true
    end
 
  end

  config.vm.define "node2" do |node2|

    node2.vm.network "private_network", ip: "192.168.33.12"
    node2.vm.hostname = "node2"

    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end

    node2.vm.provision "shell", run: "always" do |s|
      s.path = "provision_slave.sh"
      s.privileged = true
    end    

  end
end
