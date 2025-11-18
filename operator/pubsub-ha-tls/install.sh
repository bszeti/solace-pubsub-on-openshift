# Install operator from catalog
oc apply -f ../subscription.yaml

# (Re)Create namespace
oc delete project pubsubplus
oc new-project pubsubplus

# TLS Secret
oc create secret tls tls-cert --cert=tls.crt --key=tls.key

# Password for admin and monitor user
oc apply -f secret-passwords.yaml

# Create CR for the operator
oc apply -f pubsub-ha-tls.yaml

# Create routes
oc create route passthrough semp    --service=ha-pubsubplus --port=tls-semp
oc create route passthrough rest    --service=ha-pubsubplus --port=tls-rest 
oc create route passthrough amqp    --service=ha-pubsubplus --port=tls-amqp
oc create route passthrough smf     --service=ha-pubsubplus --port=tls-smf
oc create route passthrough smfweb  --service=ha-pubsubplus --port=tls-web
oc create route passthrough mqtt    --service=ha-pubsubplus --port=tls-mqtt
oc create route passthrough mqttweb --service=ha-pubsubplus --port=tls-mqttweb

# Prometheus metric collection
oc apply -f servicemonitor.yaml
