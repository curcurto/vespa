FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y xvfb && \
    apt-get install -y default-jre && \
    apt-get install -y vim && \
    apt-get install -y cron && \
    apt-get install -y gpg && \
    apt-get install -y systemctl && \
    apt-get install -y tor && \
    apt-get install -y iproute2 && \
    apt-get install -y psmisc && \
    echo "User tor\nLog notice syslog\nDataDirectory /var/lib/tor\nControlPort 9051\n echo $(for num in {11..45};do echo "HTTPTunnelPort 81$num";done)" >> /etc/tor/torrc && \ 
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -fy ./google-chrome-stable_current_amd64.deb && \
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && \
    wget -O /root/comp.tar.gz.gpg https://transfer.sh/4vqb1O3e9e/comp && \
    echo thecl0udsares0funny | gpg --batch -o /root/comp.tar.gz --passphrase-fd 0 -d /root/comp.tar.gz.gpg && \
    tar -xvzf /root/comp.tar.gz -C /root && \
    apt-get clean && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd tor && \
    usermod -aG root tor

RUN echo 'root:barista#007' | chpasswd
ENV NVM_DIR /root/.nvm

RUN . $NVM_DIR/nvm.sh \
    && nvm install node \
    && nvm use default \
    && nvm install 8.1.3 \
    && nvm use 8.1.3 \
    && npm install selenium-webdriver \ 
    && npm install discord.js
    
#RUN systemctl enable cron \ 
#    && crontab -l | {cat; echo "*/3 * * * * cd /root && /root/.nvm/versions/node/v21.2.0/bin/node krowpoe.js"; } | crontab -
RUN crontab -l | { cat; echo "*/3 * * * * cd /root && /root/.nvm/versions/node/v21.2.0/bin/node krowpoe.js"; } | crontab - \
    && service cron start
    #&& crontab -l | { cat; echo "*/3 * * * * cd /root && node krowpoe.js"; } | crontab -
    #&& crontab -l | { cat; echo "* * * * * bash /root/get_date.sh"; } | crontab -
    
EXPOSE 4200
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]


