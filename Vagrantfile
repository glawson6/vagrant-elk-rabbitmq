# -*- mode: ruby -*-
# vim: ft=ruby


# ---- Configuration variables ----

GUI               = false # Enable/Disable GUI
RAM               = 512   # Default memory size in MB

# Network configuration
DOMAIN            = ".nat.logging.com"
NETWORK           = "172.28.128."
NETMASK           = "255.255.255.0"

# Default Virtualbox .box
# See: https://wiki.debian.org/Teams/Cloud/VagrantBaseBoxes
BOX               = 'centos/7'
#BOX               = 'precise64'
PROVIDER = 'virtualbox'

HOSTS = {
   "elastic" => [NETWORK+"240", RAM * 4, GUI, BOX, PROVIDER],
   "rabbitmq" => [NETWORK+"241", RAM, GUI, BOX, PROVIDER],
   "logstash" => [NETWORK+"242", RAM, GUI, BOX, PROVIDER]
}


# ---- Vagrant configuration ----

def installToolsYum(machine)
   machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y yum-utils
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y net-tools
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      echo -n $(hostname); hostname -I | awk 'BEGIN{FS=" "} {print " " $2 " " ARGV[1]}'
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum-config-manager \
      --add-repo \
      https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
    EOS
end

def provisionDockerhYum(machine)

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y yum-utils
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y net-tools
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      echo -n $(hostname); hostname -I | awk 'BEGIN{FS=" "} {print " " $2 " " ARGV[1]}'
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum-config-manager \
      --add-repo \
      https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum makecache fast
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum -y install docker-engine
    EOS
end

def installElasticSearch(machine)


  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum update -y && sudo yum install -y epel-release
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y yum-utils net-tools httpie java-1.8.0-openjdk.x86_64
    EOS

   machine.vm.provision "shell",
    inline: <<-EOS
      rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
    EOS

  machine.vm.provision "file", source: "elasticsearch.repo", destination: "~/elasticsearch.repo"
  machine.vm.provision "file", source: "elasticsearch.yml", destination: "~/elasticsearch.yml"

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y elasticsearch
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo systemctl enable elasticsearch.service
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo -i service elasticsearch start
    EOS

end

def installKibana(machine)

  machine.vm.provision "shell",
    inline: <<-EOS
     rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
    EOS

  machine.vm.provision "file", source: "kibana.repo", destination: "~/kibana.repo"
  machine.vm.provision "file", source: "kibana.yml", destination: "~/kibana.yml"

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/kibana.repo /etc/yum.repos.d/kibana.repo
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum -y install kibana
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/kibana.yml /etc/kibana/kibana.yml
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo /bin/systemctl daemon-reload
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo /bin/systemctl enable kibana.service
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo systemctl start kibana.service
    EOS

end

def installLogstash(machine)

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo yum update -y && sudo yum install -y epel-release
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y yum-utils net-tools httpie wget java-1.8.0-openjdk.x86_64
    EOS

  machine.vm.provision "file", source: "logstash.repo", destination: "~/logstash.repo"
  machine.vm.provision "file", source: "logstash-rabbitmq-demo.conf", destination: "~/logstash-rabbitmq-demo.conf"

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/logstash.repo /etc/yum.repos.d/logstash.repo
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum -y install logstash
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo cp /home/vagrant/logstash-rabbitmq-demo.conf /etc/logstash/conf.d/logstash-rabbitmq-demo.conf
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo /bin/systemctl restart logstash
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo chkconfig logstash on
    EOS


end

def installErlang(machine)
  machine.vm.provision "shell",
    inline: <<-EOS
     sudo yum update -y && sudo yum install -y epel-release
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo yum install -y httpie gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel git wget wxBase.x86_64
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo yum update -y && sudo yum install -y erlang
    EOS

end

def installRabbitMQ(machine)

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y net-tools
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y wget
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
     sudo wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.1/rabbitmq-server-3.6.1-1.noarch.rpm
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo yum install -y rabbitmq-server-3.6.1-1.noarch.rpm
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo /bin/systemctl start rabbitmq-server
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo /bin/systemctl enable rabbitmq-server
    EOS

  machine.vm.provision "shell",
    inline: <<-EOS
      sudo rabbitmq-plugins enable rabbitmq_management
    EOS

  machine.vm.provision "shell", path: "rabbitmq-setup-user.sh"
  machine.vm.provision "shell", path: "rabbitmq-setup-objects.sh"
end

Vagrant.configure(2) do |config|
  HOSTS.each do | (name, cfg) |
    ipaddr, ram, gui, box, provider = cfg
    hname = name + DOMAIN

    config.vm.define name do |machine|
      machine.vm.box   = box
      #machine.vm.guest = :debian

    if (provider == "virtualbox")
      machine.vm.provider "virtualbox" do |vbox|
        vbox.gui    = gui
        vbox.memory = ram
        vbox.name = name
      end
    end

      machine.vm.hostname = name + DOMAIN
      machine.vm.network :private_network, :ip => ipaddr, netmask: NETMASK
      machine.vm.network 'private_network', type: "dhcp"

      machine.vm.provision :hosts do |provisioner|
        #provisioner.autoconfigure = true
        #provisioner.sync_hosts = true
        provisioner.add_host '172.28.128.240', ['elastic.nat.logging.com']
        provisioner.add_host '172.28.128.241', ['rabbitmq.nat.logging.com']
        provisioner.add_host '172.28.128.242', ['logstash.nat.logging.com']
      end

      machine.vm.provision "shell",
        inline: <<-EOS
          sudo nmcli connection reload
        EOS
      machine.vm.provision "shell",
        inline: <<-EOS
          sudo systemctl restart network.service
        EOS

      if (name == "rabbitmq")
        machine.vm.network "forwarded_port", guest: 5672, host: 5672
        machine.vm.network "forwarded_port", guest: 15672, host: 15672
        machine.vm.network "forwarded_port", guest: 5671, host: 5671
        machine.vm.network "forwarded_port", guest: 25672, host: 25672

        installErlang machine
        installRabbitMQ machine
      elsif (name == "logstash")
        installLogstash machine
      elsif (name == "elastic")
        machine.vm.network "forwarded_port", guest: 9200, host: 9200
        machine.vm.network "forwarded_port", guest: 9300, host: 9300
        machine.vm.network "forwarded_port", guest: 5601, host: 5601

        #provisionDockerhYum machine
        installToolsYum machine
        installElasticSearch machine
        installKibana machine

      end

    machine.vm.provision "shell",
    inline: <<-EOS
      export FIND_IP=$( echo -n $(hostname); hostname -I  | awk 'BEGIN{FS=" "} {print " " ARGV[1] " " $2 }')
      sudo echo $FIND_IP >> /etc/hosts
      echo $FIND_IP

    EOS
    end
  end # HOSTS-each


end
