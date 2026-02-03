docker stop grafana
docker rm grafana

sudo find . -type f -name ".DS_Store" -exec rm -f {} +

docker run -it --rm --name grafana --network ecosystem -p 3004:3000 \
   -e "GF_SECURITY_ALLOW_EMBEDDING=true" \
   -e   GF_SECURITY_ALLOW_EMBEDDING: true \
   -e   GF_AUTH_JWT_URL: http://ecosystem-server:3001/api/auth/login \
   -e   GF_AUTH_USERNAME: email \
   -e   GF_AUTH_PASSWORD: password \
   -e "GF_INSTALL_PLUGINS=yesoreyeram-infinity-datasource,trino-datasource,marcusolsson-json-datasource,volkovlabs-echarts-panel" \
   -v ./grafana:/var/lib/grafana \
   ecosystemai/ecosystem-grafana:arm64
