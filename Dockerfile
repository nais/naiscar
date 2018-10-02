FROM envoyproxy/envoy:latest

RUN apt-get update && apt-get -q install -y curl

COPY envoy.yaml.tpl /etc/envoy/envoy.yaml.tpl
COPY inject_routes_and_run /etc/envoy/inject_routes_and_run

# --base-id to avoid conflict with shared memory files in pod
CMD /etc/envoy/inject_routes_and_run.sh ${ROUTES} ${TARGET_PORT}
