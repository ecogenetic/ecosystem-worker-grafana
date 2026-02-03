find . -type f -name ".DS_Store"
sudo find . -type f -name ".DS_Store" -exec rm -f {} +

docker stop grafana
docker rm grafana

# docker run -it --rm --name grafana \
#    --network ecosystem -p 3004:3000 \
#    -e "GF_SECURITY_ALLOW_EMBEDDING=true" \
#    -e "GF_INSTALL_PLUGINS=marcusolsson-json-datasource,volkovlabs-echarts-panel" \
#    -v ./grafana:/var/lib/grafana \
#    ecosystemai/ecosystem-grafana:arm64



docker run -it --rm --name grafana \
   --network ecosystem -p 3004:3000 \
   -e GF_PLUGINS_PREINSTALL="yesoreyeram-infinity-datasource,trino-datasource,marcusolsson-json-datasource,volkovlabs-echarts-panel" \
   -e GF_AUTH_JWT_URL="http://host.docker.internal:3001/api/auth/login" \
   -e GF_AUTH_USERNAME="system@ecosystem.ai" \
   -e GF_AUTH_PASSWORD="90a9b418-6c23-4632-831d-21dc830bca2e" \
   -e GF_AUTH_JWT_ENABLED=false \
   -v ./grafana_old:/var/lib/grafana \
   ecosystemai/ecosystem-grafana:arm64



# docker run -it --rm --name grafana \
#    --network ecosystem -p 3004:3000 \
#    -e "GF_AUTH_JWT_URL=http://host.docker.internal:3001/api/auth/login" \
#    -e "GF_AUTH_USERNAME=system@ecosystem.ai" \
#    -e "GF_AUTH_PASSWORD=90a9b418-6c23-4632-831d-21dc830bca2e" \
#    -v ./grafana:/var/lib/grafana \
#    ecosystemai/ecosystem-grafana:arm64

