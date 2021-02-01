#/bin/bash

docker build -t anilverma/multi-client:latest  -t anilverma/multi-client:$SHA -f ./frontend/Dockerfile ./frontend
docker build -t anilverma/multi-server:latest -t anilverma/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t anilverma/multi-worker -t anilverma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anilverma/multi-client:latest 
docker push anilverma/multi-server:latest
docker push anilverma/multi-worker:latest


docker push anilverma/multi-client:$SHA
docker push anilverma/multi-server:$SHA
docker push anilverma/multi-worker:$SHA

kubectl apply -f k8s

