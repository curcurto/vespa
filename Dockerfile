FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get clean && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'vespa:barista#007' | chpasswd
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]

RUN apt install  -y curl wget unzip xvfb default-jre
    
ENV NVM_DIR "$HOME/.nvm"
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && \
source $NVM_DIR/nvm.sh && \
source $NVM_DIR/bash_completion && \
nvm install node && \
npm install selenium-webdriver && \
npm install discord.js && \
npm fund

EXPOSE 4200

