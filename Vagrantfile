Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.disksize.size = "200GB"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.44.44"
  config.vm.network "private_network", ip: "192.168.50.4"

  # docker daemon
  config.vm.network "forwarded_port", guest: 2375, host: 2375, auto_correct: false
  # registry
  config.vm.network "forwarded_port", guest: 5000, host: 5000, auto_correct: false
  # kubernetes dashboard
  config.vm.network "forwarded_port", guest: 5080, host: 5080, auto_correct: false
  # openfaas gateway
  config.vm.network "forwarded_port", guest: 5180, host: 5180, auto_correct: false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "d:\\", "/d"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "8192"
	vb.cpus = 4
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL

    # take care that credentials for accessing minikube are accessible by vagrant user
    # in provision-kubernetes.sh the owner and group of the .kube and .minikube folders are changed to vagrant:vagrant
    export VAGRANT_USER_HOME=/home/vagrant
    export MINIKUBE_WANTUPDATENOTIFICATION=false
    export MINIKUBE_WANTREPORTERRORPROMPT=false
    export MINIKUBE_HOME=$VAGRANT_USER_HOME
    export CHANGE_MINIKUBE_NONE_USER=true
    export KUBECONFIG=$VAGRANT_USER_HOME/.kube/config
    mkdir -p $VAGRANT_USER_HOME/.kube
    mkdir -p $VAGRANT_USER_HOME/.minikube
    touch $KUBECONFIG

    cd /vagrant/vagrant
    chmod +x *.sh
    ./provision-bash.sh
    ./provision-docker.sh

    ./provision-kubectl.sh

    # nested virtual boxes are not (yet) supported
    # -> use --vm-driver=none when starting the minikube
    # -> the already installed docker daemon is reused by minikube (--vm-driver=none)
    # ./provision-virtual-box.sh"

    # minikube
    ./provision-minikube.sh

    # kubernetes in docker aka kind
    # ./provision-kind.sh

    ./provision-helm.sh
    ./provision-openfaas.sh
    ./provision-registry.sh
  SHELL
end
