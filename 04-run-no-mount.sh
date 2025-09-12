docker stop grafana
docker rm grafana

docker run -it --rm --name grafana --network ecosystem -p 3000:3000 \
   -e "GF_SECURITY_ALLOW_EMBEDDING=true" \
   ecosystemai/ecosystem-grafana
