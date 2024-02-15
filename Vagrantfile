Vagrant.require_version ">= 1.7.0"

$os_image = (ENV['OS_IMAGE'] || "ubuntu").to_sym

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
NUM_MASTER_NODE = 1
NUM_WORKER_NODE = 1
NUM_BLANK_SERVER_NODE = 0

IP_NW = "192.168.57."
MASTER_IP_START = 60
NODE_IP_START = 70
SERVER_IP_START = 80

def set_vbox(vb, config)
  # vb.gui = false
  # vb.memory = 2048
  # vb.cpus = 2

  case $os_image
  when :centos7
    config.vm.box = "centos/7"
  when :ubuntu
    config.vm.box = "ubuntu/jammy64"
  end
end

# Sets up hosts file,  and ssh authorized keys
def setup_hosts(node)
  # Set up /etc/hosts
  node.vm.provision :shell, path: "./hack/setup-vms.sh"
  # Set up ssh connection
  node.vm.provision :shell, path: "./hack/setup-ssh.sh"
end

# Vagrant.configure("2") do |config|
#   config.vm.provider "virtualbox"
#   master = 1
#   node = 1
#
#   private_count = 10
#   (1..(master + node)).each do |mid|
#     name = (mid <= node) ? "n" : "m"
#     id   = (mid <= node) ? mid : (mid - node)
#
#     config.vm.define "k8s-#{name}#{id}" do |n|
#       n.vm.hostname = "k8s-#{name}#{id}"
#       ip_addr = "192.16.35.#{private_count}"
#       n.vm.network :private_network, ip: "#{ip_addr}",  auto_config: true
#
#       n.vm.provider :virtualbox do |vb, override|
#         vb.name = "#{n.vm.hostname}"
#         set_vbox(vb, override)
#       end
#       private_count += 1
#     end
#   end
#
#   # Install of dependency packages using script
#   config.vm.provision :shell, path: "./hack/setup-vms.sh"
# end

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # add this line to prevent revocation error
  # config.vm.box = "ubuntu/jammy64"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
    config.vm.define "kubemaster-#{$os_image}-#{i}" do |node|
      # Name shown in the GUI
      node.vm.provider "virtualbox" do |vb, override|
        vb.name = "kubemaster-#{$os_image}-#{i}"
        set_vbox(vb, override)
        if i == 1
          vb.memory = 2048    # More needed to run e2e tests at end
        else
          vb.memory = 1024
        end
        vb.cpus = 2
      end
      node.vm.hostname = "kubemaster-#{$os_image}-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2740 + i}"
      # node.vm.provision "setup-host", type: "shell", :path => "vagrant/setup-hosts.sh"
      # node.vm.provision "setup-host", type: "shell", :path => "hack/setup-ssh.sh"
      # Install of dependency packages using script and ssh
      setup_hosts node
    end
  end

  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "kubeworker-#{$os_image}-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb, override|
        vb.name = "kubeworker-#{$os_image}-#{i}"
        vb.memory = 2048
        vb.cpus = 1
        set_vbox(vb, override)
      end
      node.vm.hostname = "kubeworker-#{$os_image}-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2750 + i}"
      # Install of dependency packages using script and ssh
      setup_hosts node
    end
  end

  # provision blank server Nodes
  (1..NUM_BLANK_SERVER_NODE).each do |i|
    config.vm.define "server-#{$os_image}-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "server-#{os_image}-#{i}"
        vb.memory = 2048
        vb.cpus = 1
      end
      node.vm.hostname = "server-#{$os_image}-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{SERVER_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2760 + i}"
      setup_hosts node
    end
  end
end
