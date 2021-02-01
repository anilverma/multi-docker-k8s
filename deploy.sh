docker build -t anilverma/multi-client:latest  -t anilverma/multi-client:$SHA -f ./frontend/Dockerfile ./frontend
docker build -t anilverma/multi-server:latest -t anilverma/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t anilverma/multi-worker:latest -t anilverma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anilverma/multi-client:latest 
docker push anilverma/multi-server:latest
docker push anilverma/multi-worker:latest


docker push anilverma/multi-client:$SHA
docker push anilverma/multi-server:$SHA
docker push anilverma/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=anilverma/multi-server:$SHA
kubectl set image deployments/client-deployment client=anilverma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anilverma/multi-worker:$SHA