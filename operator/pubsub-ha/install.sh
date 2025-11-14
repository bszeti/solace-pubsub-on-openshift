# Install operator from catalog
oc apply -f ../subscription.yaml

# (Re)Create namespace
oc delete project pubsubplus
oc new-project pubsubplus

# Password for admin and monitor user
oc apply -f secret-passwords.yaml

# Create CR for the operator
oc apply -f pubsub-ha.yaml

# Create routes
oc create route edge --insecure-policy=None semp    --service=ha-pubsubplus --port=tcp-semp
oc create route edge --insecure-policy=None rest    --service=ha-pubsubplus --port=tcp-rest 
oc create route edge --insecure-policy=None smfweb  --service=ha-pubsubplus --port=tcp-web
oc create route edge --insecure-policy=None mqttweb --service=ha-pubsubplus --port=tcp-mqttweb