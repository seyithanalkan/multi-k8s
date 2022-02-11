docker build -t sythnlkn/multi-client-k8s:latest -t sythnlkn/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t sythnlkn/multi-server-k8s-pgfix:latest -t sythnlkn/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t sythnlkn/multi-worker-k8s:latest -t sythnlkn/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push sythnlkn/multi-client-k8s:latest
docker push sythnlkn/multi-server-k8s-pgfix:latest
docker push sythnlkn/multi-worker-k8s:latest

docker push sythnlkn/multi-client-k8s:$SHA
docker push sythnlkn/multi-server-k8s-pgfix:$SHA
docker push sythnlkn/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sythnlkn/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=sythnlkn/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=sythnlkn/multi-worker-k8s:$SHA