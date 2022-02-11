docker build -t sythnlkn/multi-client:latest -t sythnlkn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sythnlkn/multi-server:latest -t sythnlkn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sythnlkn/multi-worker:latest -t sythnlkn/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sythnlkn/multi-client:latest
docker push sythnlkn/multi-server:latest
docker push sythnlkn/multi-worker:latest

docker push sythnlkn/multi-client:$SHA
docker push sythnlkn/multi-server:$SHA
docker push sythnlkn/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sythnlkn/multi-server:$SHA
kubectl set image deployments/client-deployment server=sythnlkn/multi-client:$SHA
kubectl set image deployments/worker-deployment server=sythnlkn/multi-worker:$SHA