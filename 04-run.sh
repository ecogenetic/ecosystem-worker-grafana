docker stop grafana
docker rm grafana

docker run -it --rm --name grafana --network ecosystem -p 3004:3000 \
   -e "GF_SECURITY_ALLOW_EMBEDDING=true" \
   -v ./grafana:/var/lib/grafana \
   ecosystemai/ecosystem-grafana:arm64
