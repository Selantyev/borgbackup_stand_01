# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrant 2.2.14
# VirtualBox 6.1.16
# Windows 10 2004

INTERNAL_NET="192.168.30."
DOMAIN="bkp.local"

servers=[
  {
    :hostname => "client." + DOMAIN,
    :ip_int => INTERNAL_NET + "11",
	:cpus => 1,
    :ram => 256	
  },
  {
    :hostname => "backup-server." + DOMAIN,
    :ip_int => INTERNAL_NET + "10",
	:cpus => 1,
    :ram => 1024
  },
]
 
Vagrant.configure(2) do |config|
    config.vm.synced_folder ".", "/vagrant", disabled: true
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = "centos/7"
            node.vm.usable_port_range = (2300..2303)
            node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip_int], virtualbox__intnet: "bkp"
            node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--cpus", machine[:cpus], "--memory", machine[:ram]]
                vb.name = machine[:hostname]
            end
        end
    end
end