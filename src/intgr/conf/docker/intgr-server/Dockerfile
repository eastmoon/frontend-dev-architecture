# Setting base image
FROM nginx

## Update linux package manager
RUN apt-get update -y

# Install linux packages
COPY packages.txt /tmp/packages.txt
RUN xargs apt-get install -y < /tmp/packages.txt

# Install integrate script
ADD ./99-initial-webcom-list.sh /docker-entrypoint.d/99-initial-webcom-list.sh
