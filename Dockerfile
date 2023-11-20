FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y xvfb && \
    apt-get install -y default-jre && \
    apt-get clean && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'root:root' | chpasswd

    
ENV NVM_DIR "$HOME/.nvm"
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | sh && \
source $NVM_DIR/nvm.sh && \
source $NVM_DIR/bash_completion && \
nvm install node && \
npm install selenium-webdriver && \
npm install discord.js && \
npm fund

EXPOSE 4200
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]


