# Commands required to setup working docker environment, link
# containers etc.
$setup = <<SCRIPT
# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Build containers from Dockerfiles
docker build -t postgres /app/docker/postgres
# docker build -t rails /app

# Run and link the containers
docker run -d --name postgres -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker postgres:latest
# docker run -d -p 3000:3000 -v /app:/app --link postgres:db --name rails rails:latest

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
docker start postgres
# docker start rails
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Setup resource requirements
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.box = "ubuntu/trusty64"
  end
  
  config.vm.provider "docker" do |d|
    d.name = 'postgres'
    d.env = {"POSTGRESQL_USER" => "joatu", "POSTGRESQL_PASS" => "joatu-dev-pass"}
    d.build_dir = "./docker/postgres"
    d.vagrant_vagrantfile = "docker/Vagrantfile"
  end

  # config.vm.provider "docker" do |d|
    # d.name = 'joatu-rails'
    # d.build_dir = "."
  # end

  # need a private network for NFS shares to work
  # config.vm.network "private_network", ip: "192.168.50.4"

  # Rails Server Port Forwarding
  # config.vm.network "forwarded_port", guest: 3000, host: 3000

  # config.vm.provision "shell", inline: "apt-get -y update"

  # Install latest docker
  # config.vm.provision "docker"

  # Must use NFS for this otherwise rails
  # performance will be awful
  # config.vm.synced_folder ".", "/app", type: "nfs"

  # Setup the containers when the VM is first
  # created
  # config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  # config.vm.provision "shell", run: "always", inline: $start
end
