docker build -t tmcmilla/multi-client:latest -t tmcmilla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tmcmilla/multi-server:latest -t tmcmilla/multi-server:$SHA -f ./server/Dockerfile ./server
docker bulld -t tmcmilla/multi-worker:latest -t tmcmilla/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tmcmilla/multi-client:latest
docker push tmcmilla/multi-server:latest
docker push tmcmilla/multi-worker:latest

docker push tmcmilla/multi-client:$SHA
docker push tmcmilla/multi-server:$SHA
docker push tmcmilla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tmcmilla/multi-server:$SHA
kubectl set image deployments/client-deployment client=tmcmilla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tmcmilla/multi-worker:$SHA
