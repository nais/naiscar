FROM envoyproxy/envoy:latest

RUN apt-get update && apt-get -q install -y curl

COPY envoy.yaml /etc/envoy/envoy.yaml

# --base-id to avoid conflict with shared memory files in pod
CMD /usr/local/bin/envoy -c /etc/envoy/envoy.yaml --base-id 69
