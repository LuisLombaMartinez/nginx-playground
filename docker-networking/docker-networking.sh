# stop and remove all running containers with the same name
docker stop $(docker ps -aqf "name=s")
docker rm $(docker ps -aqf "name=s")
docker stop $(docker ps -aqf "name=gw")
docker rm $(docker ps -aqf "name=gw")

# remove all networks
docker network rm frontend
docker network rm backend

# build docker image
docker build -t docker-networking .

# create docker networks
docker network create frontend --subnet=10.0.1.0/24
docker network create backend --subnet=10.0.0.0/24

# run docker container
docker run -d --name s1 --cap-add=NET_ADMIN --network backend docker-networking 
docker run -d --name s2 --cap-add=NET_ADMIN --network frontend  docker-networking
docker run -d --name gw --network frontend --network backend docker-networking

# add routes to the s1 container
docker exec s1 bash -c "ip route add 10.0.1.0/24 via 10.0.0.3"
docker exec s1 bash -c "echo '<html><body><h1>This is s1!</h1></body></html>' > /usr/local/apache2/htdocs/index.html"

# add routes to the s2 container
docker exec s2 bash -c "ip route add 10.0.0.0/24 via 10.0.1.3"
docker exec s2 bash -c "echo '<html><body><h1>This is s2!</h1></body></html>' > /usr/local/apache2/htdocs/index.html"