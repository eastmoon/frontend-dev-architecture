# Setting base image
FROM node:18

# Update npm
RUN npm update -g

# Install tools
RUN npm install -g create-react-app

# Setting
WORKDIR /app

# COMMAND
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
