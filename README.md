# haproxy-pass
Very simple parameterized haproxy container.

Primary use case: Provide a (known high performance) proxy for surfacing services within a cluster to an ingress LB, like is common DC/OS or K8S. 

1.) Browser --- dcos.example.com ----> Marathon LB ---> leader.mesos (Proxies DC/OS console as a Marathon LB VHOST)

2.) Browser --- jenkins.example.com ----> Marathon LB ---> jenkins.marathon.l4lb.thisdcos.directory:80 (Proxies Jenkins virtual IP as a Marathon LB VHOST)

Other variations possible, backend host and port can be configured. SSL version built alongside, available for use with a bit more work after the POC. 

