#!/bin/bash

# Point it to the DC/OS master on port 80
docker run -it -e SERVICE_HOST=172.17.0.2 -e HOST=0.0.0.0 -e SERVICE_PORT=8080 jeremykuhnash/haproxy-pass:http-1.7-6
