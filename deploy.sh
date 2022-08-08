docker build -t mukarramhodieva/multi-client:latest -t mukarramhodieva/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mukarramhodieva/multi-server:latest -t mukarramhodieva/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mukarramhodieva/multi-worker:latest -t mukarramhodieva/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mukarramhodieva/multi-client:latest
docker push mukarramhodieva/multi-server:latest
docker push mukarramhodieva/multi-worker:latest

docker push mukarramhodieva/multi-client:$SHA
docker push mukarramhodieva/multi-server:$SHA
docker push mukarramhodieva/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mukarramhodieva/multi-server:$SHA
kubectl set image deployments/client-deployment client=mukarramhodieva/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mukarramhodieva/multi-worker:$SHA
