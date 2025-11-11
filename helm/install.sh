# Create namesapce
oc new-project pubsubplus-helm

# TLS
oc create secret tls tls-openshift --cert=tls.crt --key=tls.key

# Use path of git https://github.com/SolaceProducts/pubsubplus-kubernetes-helm-quickstart/ 
helm upgrade -i ha ~/git/pubsubplus-kubernetes-helm-quickstart/pubsubplus -f values-ha.yaml

# Create routes
oc create route passthrough semp    --service=ha-pubsubplus --port=tls-semp
oc create route passthrough amqp    --service=ha-pubsubplus --port=tls-amqp
oc create route passthrough smf     --service=ha-pubsubplus --port=tls-smf
oc create route passthrough smfweb  --service=ha-pubsubplus --port=tls-web
oc create route passthrough mqtt    --service=ha-pubsubplus --port=tls-mqtt
oc create route passthrough mqttweb --service=ha-pubsubplus --port=tls-mqttweb