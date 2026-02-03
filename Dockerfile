FROM grafana/grafana:latest

USER root

RUN mkdir -p /var/lib/grafana

COPY ./grafana/grafana.db /etc/grafana-db/grafana.db.template
COPY ./grafana/plugins /etc/grafana/provisioning/plugins/
COPY entrypoint.sh /entrypoint.sh

COPY infinity-datasource.template.yaml /etc/grafana/provisioning/datasources/
COPY jsonapi-datasource.template.yaml /etc/grafana/provisioning/datasources/

RUN chmod +x /entrypoint.sh
RUN chmod 775 /var/lib/grafana

ENV GF_SECURITY_ALLOW_EMBEDDING=true
ENV GF_PLUGINS_PREINSTALL=yesoreyeram-infinity-datasource,trino-datasource,marcusolsson-json-datasource,volkovlabs-echarts-panel
ENV GF_AUTH_JWT_ENABLED=false

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
