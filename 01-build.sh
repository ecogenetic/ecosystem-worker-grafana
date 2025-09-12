echo "=============================================================="
echo "Important steps to update plugins:"
echo "1. build container"
echo "2. run container, 3. stop container, 4. rerun container "
echo "5. new rebuild that components are installed"
echo "6. push once plugin updates were tested in second run"
echo "=============================================================="

echo "==="
echo "build cycle..."
echo "==="

find . -type f -name ".DS_Store"
sudo find . -type f -name ".DS_Store" -exec rm -f {} +
sleep 2

sudo find . -type f -name ".DS_Store" -exec rm -f {} +
docker build --platform linux/amd64 -f Dockerfile -t ecosystemai/ecosystem-grafana:latest .

sudo find . -type f -name ".DS_Store" -exec rm -f {} +
docker build --platform linux/arm64 -f Dockerfile -t ecosystemai/ecosystem-grafana:arm64 .
