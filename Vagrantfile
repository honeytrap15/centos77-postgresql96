# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # common setting
  config.vm.box = "bento/centos-7.7"
  config.vm.box_check_update = false
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # configure resources
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
    vb.cpus = 1
  end

  # setup private ip address
  config.vm.network "private_network", ip: "192.168.33.10"

  # install utility common package
  config.vm.provision "shell", inline: <<-SHELL
    yum -y install bash-completion bash-completion-extras
  SHELL

  # disable swap
  config.vm.provision "shell", inline: <<-SHELL
    swapoff -a
    sed -i '/swap/d' /etc/fstab
  SHELL

  # install postgres and create symlink
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
    yum install -y postgresql96-server
    ls /usr/pgsql-9.6/bin/ | xargs -I{} ln -s /usr/pgsql-9.6/bin/{} /usr/bin/{}
    ln -s /usr/pgsql-9.6/bin/postgresql96-setup /usr/bin/postgresql-setup
  SHELL

  # init postgresql
  config.vm.provision "shell", inline: <<-SHELL
    postgresql-setup initdb
    systemctl enable postgresql-9.6.service
  SHELL

  # change auth config
  config.vm.provision "shell", inline: <<-SHELL
    sed -i "s/ident$/md5/" /var/lib/pgsql/9.6/data/pg_hba.conf
  SHELL

end
