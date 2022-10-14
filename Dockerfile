FROM ubuntu/apache2:latest


# install dependencies
RUN apt update
RUN apt install -y make curl gnupg apt-transport-https ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && apt install nodejs && \
    corepack enable

# copy files
WORKDIR /home
COPY frontend ./frontend

# build frontend
RUN  cd frontend && make build && make deploy

CMD ["apache2ctl", "-D", "FOREGROUND"]
