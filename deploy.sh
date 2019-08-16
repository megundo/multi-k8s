docker build -t melihx/multi-client:latest -t melihx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t melihx/multi-server:latest -t melihx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t melihx/multi-worker:latest -t melihx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push melihx/multi-client:latest
docker push melihx/multi-server:latest
docker push melihx/multi-worker:latest

docker push melihx/multi-client:$SHA
docker push melihx/multi-server:$SHA
docker push melihx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=melihx/multi-server:$SHA
kubectl set image deployments/client-deployment client=melihx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=melihx/multi-worker:$SHA
