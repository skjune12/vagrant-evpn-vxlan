Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'

  config.vm.define :gobgp1 do |gobgp1|
    gobgp1.vm.hostname = "gobgp1"
    # outer network
    gobgp1.vm.network "private_network", ip: "10.0.12.10", netmask: "255.255.255.0"
    # basic setup
    gobgp1.vm.provision "shell", privileged: true, path: "./setup.sh"
    gobgp1.vm.provision "shell", privileged: true, path: "./config/gobgp1/config-interface.sh"
    gobgp1.vm.synced_folder "./config/gobgp1", "/root/config"
  end

  config.vm.define :gobgp2 do |gobgp2|
    gobgp2.vm.hostname = "gobgp2"
    # outer network
    gobgp2.vm.network "private_network", ip: "10.0.12.20", netmask: "255.255.255.0"
    gobgp2.vm.network "private_network", ip: "10.0.23.10", netmask: "255.255.255.0"
    # basic setup
    gobgp2.vm.provision "shell", privileged: true, path: "./setup.sh"
    gobgp2.vm.provision "shell", privileged: true, path: "./config/gobgp2/config-interface.sh"
    gobgp2.vm.synced_folder "./config/gobgp2", "/root/config"
  end

  config.vm.define :gobgp3 do |gobgp3|
    gobgp3.vm.hostname = "gobgp3"
    # outer network
    gobgp3.vm.network "private_network", ip: "10.0.23.20", netmask: "255.255.255.0"
    # basic setup
    gobgp3.vm.provision "shell", privileged: true, path: "./setup.sh"
    gobgp3.vm.synced_folder "./config/gobgp3", "/root/config"
  end
end
