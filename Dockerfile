FROM ubuntu:latest

# Prepare container
RUN apt-get update -y && \
    apt-get install -y openssh-server git python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh/

# Clone repo and configure permissions
RUN git clone https://github.com/wh0crypt/mykrackenbot.git /root/mykrackenbot && \
    chmod -R 777 /root/mykrackenbot/
COPY .env /root/.env
COPY .env /root/mykrackenbot/.env
RUN pip3 install --break-system-packages -r /root/mykrackenbot/requirements.txt

# Create the script start.sh
RUN echo '#!/bin/bash' > /root/start.sh && \
    echo 'rm -rf /root/mykrackenbot' >> /root/start.sh && \
    echo 'git clone https://github.com/wh0crypt/mykrackenbot.git /root/mykrackenbot' >> /root/start.sh && \
    echo 'cp /root/.env /root/mykrackenbot/.env' >> /root/start.sh && \
    echo 'chmod -R 777 /root/mykrackenbot/' >> /root/start.sh && \
    echo '/root/mykrackenbot/setup.sh' >> /root/start.sh && \
    echo 'exec /usr/sbin/sshd -D' >> /root/start.sh && \
    chmod +x /root/start.sh

EXPOSE 22

CMD ["/root/start.sh"]