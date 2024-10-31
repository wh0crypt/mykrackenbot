FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y openssh-server git python3 python3-pip
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

RUN mkdir -p /root/.ssh/

RUN git clone --single-branch --branch main https://github.com/wh0crypt/mykrackenbot.git /root/mykrackenbot
RUN chmod 777 -R /root/mykrackenbot/
COPY .env /root/mykrackenbot/.env
RUN pip3 install --break-system-packages -r /root/mykrackenbot/requirements.txt

RUN echo '#!/bin/bash\ncd /root/mykrackenbot && git fetch origin\nexec /usr/sbin/sshd -D' > /root/start.sh && \
    chmod +x /root/start.sh

EXPOSE 22

CMD ["/root/start.sh"]
