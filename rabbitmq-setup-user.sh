sudo rabbitmqctl add_user myuser mypass
sudo rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"
sudo rabbitmqctl set_user_tags myuser administrator

