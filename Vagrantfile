Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    sudo apt update
    sudo apt install python3-vagrant
    sudo apt-get -y install python-pip
    pip install django
    sudo apt-get install libpq-dev python-dev
    pip install psycopg2
  SHELL

  config.vm.provision "file", source: "6/test.py", destination: "test.py"
end
