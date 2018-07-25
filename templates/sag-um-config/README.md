# Universal Messaging configurations

Use this template to configure Universal Messaging servers and clusters.

Consult [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)
for general information about applying templates.

## Requirements

### Supported Software AG releases

* Command Central 10.1 and higher
* Universal Messaging 9.10 and higher. See specific requirements for each configuration

### Supported platforms

All supported Windows and UNIX platforms.

### Supported configurations

* JNDI connection factories
* JNDI destinations (queues and topics)
* Channels
* Queues

## Configuring Universal Messaging

### Configuring JNDI connection factories and destinations

> Configuring JNDI factories and objects requires Universal Messaing 9.10 or higher.

```bash
sagcc exec templates composite apply sag-um-config \
  nodes=node \
  um.configs=jndi \
  um.instance.name=default \
  um.url=nsp://node:9000 \
  um.cf.name=mycf \
  um.q.cf.name=myqcf \
  um.q.jndi.name=myq \
  um.q.store.name=myq \
  um.topic.cf.name=mytcf \
  um.topic.jndi.name=mytopic \
  um.topic.store.name=mytopic \
  --sync-job
```

### Configuring queues

> Configuring queues requires Universal Messaging 10.1 or higher.

```bash
sagcc exec templates composite apply sag-um-config \
  nodes=node \
  um.configs=queues \
  um.instance.name=default \
  um.q.name=myq \
  um.q.type=Reliable \
  um.q.ttl=0 \
  um.q.capacity=10000 \
  um.q.clusterwide=true \
  --sync-job
```

### Configuring channels

> Configuring queues requires Universal Messaging 9.12 or higher.

TODO
