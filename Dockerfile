FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y openssh-server git python3 python3-pip
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh/

RUN git clone https://github.com/wh0crypt/mykrackenbot.git /root/mykrackenbot
RUN chmod -R 777 /root/mykrackenbot/
COPY .env /root/.env
COPY .env /root/mykrackenbot/.env
RUN pip3 install --break-system-packages -r /root/mykrackenbot/requirements.txt

RUN echo '#!/bin/bash' > /root/start.sh && \
        'rm -rf /root/mykrackenbot' >> /root/start.sh && \
        'git clone https://github.com/wh0crypt/mykrackenbot.git /root/mykrackenbot' >> /root/start.sh && \
        'cp /root/.env /root/mykrackenbot/.env' >> /root/start.sh && \
        'exec /usr/sbin/sshd -D' >> /root/start.sh && \
        chmod +x /root/start.sh

EXPOSE 22

CMD ["/root/start.sh"]
