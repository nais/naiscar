static_resources:
  listeners:
  - address:
      socket_address:
        address: 0.0.0.0
        port_value: 6969
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        config:
          codec_type: auto
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: service
              domains:
              - "*"
              routes:
@@ROUTES@@
          http_filters:
          - name: envoy.router
            config: {}
  clusters:
  - name: local_service
    type: static
    connect_timeout: 0.25s
    lb_policy: round_robin
    hosts:
    - socket_address:
        address: 127.0.0.1
        port_value: @@TARGET_PORT@@

admin:
  access_log_path: /tmp/admin_access.log
  address:
    socket_address: 
      address: 127.0.0.1
      port_value: 9901
