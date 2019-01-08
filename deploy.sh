docker build -t edwolb/multi-client -f ./client/Dockerfile ./client
docker build -t edwolb/multi-server -f ./server/Dockerfile ./server
docker build -t edwolb/multi-worker -f ./worker/Dockerfile ./worker
docker push edwolb/multi-client
docker push edwolb/multi-server
docker push edwolb/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=edwolb/multi-server
