docker build -t edwolb/multi-client:latest -t edwolb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t edwolb/multi-server:latest -t edwolb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t edwolb/multi-worker:latest -t edwolb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push edwolb/multi-client:latest
docker push edwolb/multi-server:latest
docker push edwolb/multi-worker:latest

docker push edwolb/multi-client:$SHA
docker push edwolb/multi-server:$SHA
docker push edwolb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=edwolb/multi-server:$SHA
kubectl set image deployments/client-deployment client=edwolb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=edwolb/multi-worker:$SHA
