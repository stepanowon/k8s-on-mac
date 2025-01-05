# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "gutehall/ubuntu24-10"

  config.vm.provider "vmware_desktop" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.define "master" do |node|
    node.vm.hostname = "master"
    node.vm.network "private_network", ip: "192.168.56.201"
  end

  (1..2).each do |i|
    hostname = "worker#{'%01d' % i}"
    config.vm.define "#{hostname}" do |node|
      node.vm.hostname = "#{hostname}"
      node.vm.network "private_network", ip: "192.168.56.#{201 + i}"
      node.vm.provider "vmware_desktop" do |vb|
        vb.cpus = 1
        vb.memory = 2048
      end
    end
  end

  shell_provision_configs = [
    {
      "name" => "set-host",
      "path" => "scripts/set-host.sh"
    },
    {
      "name" => "set-user",
      "path" => "scripts/set-user.sh"
    },
    {
      "name" => "default-config",
      "path" => "scripts/default-config.sh"
    },
    {
      "name" => "install-containerd",
      "path" => "scripts/install-containerd.sh"
    },
    {
      "name" => "install-kubeadm",
      "path" => "scripts/install-kubeadm.sh"
    },
    {
      "name" => "sample-copy",
      "path" => "scripts/sample-copy.sh"
    }
  ]

  shell_provision_configs.each do |cfg|
    config.vm.provision "shell" do |s|
      s.name = cfg["name"]
      s.path = cfg["path"]
      s.privileged = cfg["privileged"] ? cfg["privileged"] : true
      s.args = cfg["args"] ? cfg["args"] : []
    end
  end

end
