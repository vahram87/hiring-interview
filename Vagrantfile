# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
WORKING_DIR = '/srv/exchange_office'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/bionic64"
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, host: 3000, guest: 3000     # ROR

  config.vm.synced_folder '.', WORKING_DIR, create: true

  config.vm.provider :virtualbox do | vb |
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--memory", ENV.fetch('VAGRANT_RAM', 3072)]
    vb.customize ["modifyvm", :id, "--cpus", ENV.fetch('VAGRANT_CPUS', 2)]
  end

  provision_commands = [
    # PostgreSQL install
    "sudo sh -c 'echo \"deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main\" > /etc/apt/sources.list.d/pgdg.list'",
    "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -",
    "sudo apt-get update",
    "sudo apt-get -y install postgresql",
    "sudo -u postgres psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\"",
    "sudo -u postgres psql -c \"ALTER ROLE vagrant SUPERUSER;\"",

    # Gems dependencies
    "sudo apt-get -y install libpq-dev", # for pg gem

    # # RVM install, ruby install, gems install
    "curl -sSL https://rvm.io/mpapis.asc | gpg --import -",
    "curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -",
    "\\curl -sSL https://get.rvm.io | bash -s stable",
    "source /home/vagrant/.rvm/scripts/rvm",
    "rvm install ruby-3.1.0",
    "cd #{WORKING_DIR}",
    "bundle install",

    # # nodejs and yarn install
    "curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -",
    "sudo apt install -y nodejs",
    "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -",
    "echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list",
    "sudo apt update && sudo apt install yarn",
    "yarn install",

    # # configure local env
    "rails db:create",
    "rails db:migrate",
    "rails db:seed",
    "rails db:migrate RAILS_ENV=test",
    "rails db:seed RAILS_ENV=test",
  ].join (' && ')

  config.vm.provision "shell", inline: provision_commands, privileged: false

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end
