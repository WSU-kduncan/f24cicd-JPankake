#!/bin/bash

# Pull the latest image
sudo docker pull jpankake67/pankake-ceg3150:tag

# Stop and remove the previously running container
sudo docker stop p5
sudo docker rm p5

# Run the new container with the latest image
sudo docker run -d -p 80:4200 --name p5 jpankake67/pankake-ceg3150:tag
