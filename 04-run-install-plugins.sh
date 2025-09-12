docker stop grafana
docker rm grafana

docker run -it --rm --name grafana --network ecosystem -p 3004:3000 \
   -e "GF_SECURITY_ALLOW_EMBEDDING=true" \
   -e "GF_INSTALL_PLUGINS=marcusolsson-json-datasource,volkovlabs-echarts-panel" \
   -v ./grafana:/var/lib/grafana \
   ecosystemai/ecosystem-grafana:arm64
