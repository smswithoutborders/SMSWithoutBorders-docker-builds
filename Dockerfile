FROM ubuntu/apache2:latest

# install dependencies
RUN apt update
RUN apt install -y make curl gnupg apt-transport-https ca-certificates python3 \
    apache2-utils libapache2-mod-wsgi-py3 python3-venv wget
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && apt install nodejs && \
    corepack enable

# apache configs
COPY configs/apache2.conf /etc/apache2
COPY configs/services.conf /etc/apache2/sites-available

# enable site conf
RUN a2ensite services.conf
# enable apache2 rewrite engine so FE routes work correctly
RUN a2enmod rewrite && service apache2 restart

# copy files
WORKDIR /home
COPY frontend ./frontend
COPY backend ./backend
COPY platforms ./platforms

# build and deploy frontend
RUN  cd frontend && make build && make deploy

# setup backend
RUN cd backend && make install

CMD ["apache2ctl", "-D", "FOREGROUND"]
