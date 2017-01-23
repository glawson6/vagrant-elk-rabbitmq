curl -i -u myuser:mypass -H "content-type:application/json" \
   -XPUT http://localhost:15672/api/vhosts/%2fdev
sudo rabbitmqctl set_permissions -p /dev myuser ".*" ".*" ".*"
sudo rabbitmqctl set_permissions -p /dev guest ".*" ".*" ".*"
curl -i -u myuser:mypass -H "content-type:application/json" \
    -XPUT -d'{"type":"direct","durable":true}' \
    http://localhost:15672/api/exchanges/%2fdev/logging.event.exchange
curl -i -u myuser:mypass -H "content-type:application/json" \
    -XPUT -d'{"auto_delete":false,"durable":true,"arguments":{},"node":"rabbit@rabbitmq"}' \
    http://localhost:15672/api/queues/%2fdev/logging.event.queue
curl -i -u myuser:mypass -H "content-type:application/json" \
    -XPOST -d'{"routing_key":"logging.event","arguments":{}}' \
    http://localhost:15672/api/bindings/%2fdev/e/logging.event.exchange/q/logging.event.queue
