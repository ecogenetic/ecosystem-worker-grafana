echo "=============================================================="
echo "Important steps to update plugins:"
echo "1. build container"
echo "2. run container, 3. stop container, 4. rerun container "
echo "5. new rebuild that components are installed"
echo "6. push once plugin updates were tested in second run"
echo "=============================================================="

# azure
docker build --platform linux/amd64 -f Dockerfile-azure -t ecosystemai/ecosystem-grafana:azure .

docker stop grafana
docker rm grafana
echo ""
echo "ctlC to kill run and build final."
echo ""
docker run -it --rm --name grafana --network ecosystem -p 3000:3000 \
   -v /Users/jayvanzyl/Documents/Projects/ecosystem-oss-builds/grafana/grafana/grafana-azure:/var/lib/grafana \
   -e "GF_INSTALL_PLUGINS=marcusolsson-json-datasource,volkovlabs-echarts-panel" \
   ecosystemai/ecosystem-grafana:azure

docker build --platform linux/amd64 -f Dockerfile-azure -t ecosystemai/ecosystem-grafana:azure .
