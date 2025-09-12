FROM grafana/grafana:main

USER root

RUN mkdir -p /var/lib/grafana

COPY ./grafana/grafana.db /etc/grafana-db/grafana.db.template
COPY entrypoint.sh /entrypoint.sh
COPY jsonapi-datasource.template.yaml /etc/grafana/provisioning/datasources/

RUN chmod +x /entrypoint.sh
RUN chmod 775 /var/lib/grafana

ENV GF_SECURITY_ALLOW_EMBEDDING=true
ENV GF_INSTALL_PLUGINS=marcusolsson-json-datasource,volkovlabs-echarts-panel

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
