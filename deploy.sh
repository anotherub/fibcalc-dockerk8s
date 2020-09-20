docker build -t umeshbhat/multiclient:latest -t umeshbhat/multiclient:$SHA -f ./client/Dockerfile ./client
docker build -t umeshbhat/multiserver:latest -t umeshbhat/multiserver:$SHA -f ./server/Dockerfile ./server
docker build -t umeshbhat/multiworker:latest -t umeshbhat/multiworker:$SHA -f ./worker/Dockerfile ./worker

docker push umeshbhat/multiclient:latest
docker push umeshbhat/multiserver:latest
docker push umeshbhat/multiworker:latest

docker push umeshbhat/multiclient:$SHA
docker push umeshbhat/multiserver:$SHA
docker push umeshbhat/multiworker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=umeshbhat/multiclient:$SHA
kubectl set image deployments/server-deployment server=umeshbhat/multiserver:$SHA
kubectl set image deployments/worker-deployment worker=umeshbhat/multiworker:$SHA
