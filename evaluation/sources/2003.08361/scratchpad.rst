Points to be highlighted
------------------------

#. The middleware is free and open source - middlewares do not have numbers (only features), if they do have numbers then they do not scale, if they do scale they are not open source
#. Scales out of the box - use of docker swarm, easy to setup and use. Faster than kubernetes
#. Very high throughput despite using https - vertx, reactive design, connection pools, sysctl.conf, ulimit, replicas etc
#. Use of custom hash function for rabbitmq - treat rmq nodes independently. Eliminates inter-node synchronisation overheads
#. Performace of hash function is better than cluster mode operation - tests need to prove this. Cannot use federation use to dynamic nature of the design
#. Use of shovel for bind across independent nodes
#. Regular features of the middleware - Data exchange, owner and device management, security considerations, elasticsearch, unbind daemon etc
#. Has an elementary catalogue - should we add search capabilities?
#. Compare against single node performance with wrk vs tsung
#. Draw out attention to latency of docker swarm because of overlay networks

Shortcomings
------------

#. Only support for https in federated mode - cannot use amqp, mqtt, stomp etc. since the http proxy manages the cluster
#. Hence may need intermediate edge middlewares
#. Focus only on the computational aspect of IoT middlewares, thus behaves as a skeleton to which required features must be added

Future Scope
^^^^^^^^^^^^

#. Recommend a good hash function that uniformly distributes the load among brokers. This should be after studying username statistics of websites
#. Hash only a recommendation to treat broker nodes invidually. It needs to be consistent 
#. Develop proxies for AMQP, MQTT and STOMP, CoAP
#. Add an IFTT engine
#. Add a security layer over es and define proper protocols and access mechanisms for historical data
#. Add a dashboard to manage devices, plot graphs etc
#. Compare performance of different hash functions (Uniformity vs speed)
#. Support schemas for popular devices
#. Integrate with IUDX catalogue
#. Harden servers and prevent against DoS, DDoS etc
#. Have a failover node per bucket in the distributed setup
#. Find out ways to optimise docker swarm speed

Flow for the paper
------------------

Abstract
^^^^^^^^

Increase in number of IoT devices, middlewares must be capable of handling them. We present a powerful, scalable and open source IoT middleware platform called Vermillion. First contribution is the arcgitecture for scalable IoT systems. Second is a hash function to treat broker nodes independently. We also show that performance of the hash scheme is better than natural clustering of rmq. We make a recommendation for deployment depeneding on city size.

Introduction
^^^^^^^^^^^^

Massive increase in IoT devices due to the benefits they provide. Can help to severly curtail excessive resource consumption on already strained cities. When smart cities move from becoming accessories for cities to flaunt into crtical requirements for the cities to function, middlewares will play a very crucial role. Middlewares must be able to handle extremely high loads. Secondly, mws should not only focus on icccs. Common folk need to have access to data from cties. Thus it becomes important to specify formal protocols for data exchange. Just like how open source software benefits from collective wisdom of a large number of people to find and eliminate bugs, open data fosters profound and innovative insights into resource use patterns, outilers, anomalies etc.

In this paper, we present Vermillion which targets both these fronts - of being scalable, available and having high throughput, and providing formal means to discover and exchange not just open data but also protected, private and confidential data. Unlike typical middlewares, Vermillion uses Vertx, a reactive toolkit for building high-performace, event driven and non blocking software for JVM based languages. Vertx, by in itself is very fast (compare hello world numbers here). Furthermore, Vermillion uses connection pooling to minimise channel creation delays, and docker swarm to scale to multiple hardware nodes. Furthermore, we use a custom but simple hash function to uniformly distribute load across different rabbitmq nodes. This enables us to treat each node individually and hence helps prevent inter-node synchronisation delays which are incurred in clustering based approcahes. We also bring out comparisons in throughtput numbers for hash-based approach and cluster based approach.

The rest of the paper is structured as follows. We first explain the architectural design and the individual components of the middleware and how they function, for a single node and a multi node design. We then explain a simple flow to get access to protected data from a provider (talk about data discovery using the catalogue) Next we talk about the optimisations and accommodations used in the middleware - connection pools, hash functions, round-robin in cluster mode, shovel for inter-node binding etc. Next we present results and compare the numbers of the hash based scheme and the clustered scheme. Next we take popular cities and recommend a deployment strategies.











