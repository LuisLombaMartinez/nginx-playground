# stop all containers
docker stop $(docker ps -aqf "name=nodeapp")
docker stop $(docker ps -aqf "name=ng")

# remove all containers 
docker rm $(docker ps -aqf "name=nodeapp")
docker rm $(docker ps -aqf "name=ng")

# remove network
docker network rm backend-network

# run nodeapp container
docker run --hostname nodeapp1 --name nodeapp1 -d nodeapp
docker run --hostname nodeapp2 --name nodeapp2 -d nodeapp
docker run --hostname nodeapp3 --name nodeapp3 -d nodeapp
docker run --hostname nodeapp4 --name nodeapp4 -d nodeapp
docker run --hostname nodeapp5 --name nodeapp5 -d nodeapp
docker run --hostname nodeapp6 --name nodeapp6 -d nodeapp
docker run --hostname nodeapp7 --name nodeapp7 -d nodeapp
docker run --hostname nodeapp8 --name nodeapp8 -d nodeapp
docker run --hostname nodeapp9 --name nodeapp9 -d nodeapp
docker run --hostname nodeapp10 --name nodeapp10 -d nodeapp

# create network
docker network create backend-network

# connect containers to network
docker network connect backend-network nodeapp1
docker network connect backend-network nodeapp2
docker network connect backend-network nodeapp3
docker network connect backend-network nodeapp4
docker network connect backend-network nodeapp5
docker network connect backend-network nodeapp6
docker network connect backend-network nodeapp7
docker network connect backend-network nodeapp8
docker network connect backend-network nodeapp9
docker network connect backend-network nodeapp10

# run nginx container
docker run --network backend-network --hostname ng1 --name ng1 -p 80:8080 -v ./nginx1.conf:/etc/nginx/nginx.conf -d nginx
docker run --network backend-network --hostname ng2 --name ng2 -p 81:8080 -v ./nginx2.conf:/etc/nginx/nginx.conf -d nginx
