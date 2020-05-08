docker build -t bnassivet/multi-client:latest -t bnassivet/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bnassivet/multi-server:latest -t bnassivet/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bnassivet/multi-worker:latest -t bnassivet/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bnassivet/multi-client:latest
docker push bnassivet/multi-server:latest
docker push bnassivet/multi-worker:latest

docker push bnassivet/multi-client:$SHA
docker push bnassivet/multi-server:$SHA
docker push bnassivet/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=bnassivet/multi-client:$SHA
kubectl set image deployment/server-deployment server=bnassivet/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=bnassivet/multi-worker:$SHA