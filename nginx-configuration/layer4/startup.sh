
# stop all containers
docker stop $(docker ps -aqf "name=node-server")
docker stop $(docker ps -aqf "name=nginx")

# remove all containers
docker rm $(docker ps -aqf "name=node-server")
docker rm $(docker ps -aqf "name=nginx")

# remove network
docker network rm backend-network

# ask for the number of containers to run
echo "How many containers do you want to run?"
read num

# run nodeapp containers
for i in $(seq 1 $num)
do
    docker run -p 3000$i:9999 -e APPID=$i --hostname node-server$i --name node-server$i -d node-server
done


# run the python script to set up the nginx configuration
python3 set_up_nginx_config.py $num

# create network
docker network create backend-network

# connect containers to network
for i in $(seq 1 $num)
do
    docker network connect backend-network node-server$i
done

# run nginx container
docker run --network backend-network --hostname nginx --name nginx -p 80:80 -v ./conf.d/nginx.conf:/etc/nginx/nginx.conf -d nginx
