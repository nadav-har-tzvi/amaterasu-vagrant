# Vagrantfile for amaterasu dev station
Vagrant.configure(2) do |config|

  config.vm.box = "js-schibsted/base-centos6"
  config.vm.box_download_insecure=true
  config.vm.provision :file, source: "amaterasu.properties", destination: "amaterasu.properties"
  
  config.vm.define "node1" do |node1|

    node1.vm.provider :aws do |aws, override|
      aws.keypair_name = "amaterasu-new"
      aws.ami = "ami-7cbc6e13"
      aws.instance_type = "c4.xlarge"
      aws.region = "eu-central-1"
      aws.security_groups = ["launch-wizard-3"]
      override.ssh.username = "centos"
      override.ssh.private_key_path = "C:\\Users\\nadavh\\Downloads\\amaterasu-new.pem"
    end

    node1.vm.provision "shell", run: "always" do |s|
	    s.path = "provision.sh"
	    s.privileged = true
    end
 
  end

#  config.vm.define "node2" do |node2|
#
#    node2.vm.network "private_network", ip: "192.168.33.12"
#    node2.vm.hostname = "node2"

#    node2.vm.provider "virtualbox" do |vb|
#      vb.memory = "2048"
#      vb.cpus = 2
#    end

#    node2.vm.provision "shell", run: "always" do |s|
#      s.path = "provision_slave.sh"
#      s.privileged = true
#    end    

#  end

#  config.vm.define "node3" do |node2|
 
#    node2.vm.network "private_network", ip: "192.168.33.13"
#    node2.vm.hostname = "node3"
 
#    node2.vm.provider "virtualbox" do |vb|
#      vb.memory = "2048"
#      vb.cpus = 2
#    end

#    node2.vm.provision "shell", run: "always" do |s|
#      s.path = "provision_slave2.sh"
#      s.privileged = true
#    end

#  end
end
