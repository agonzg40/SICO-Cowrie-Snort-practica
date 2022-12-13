#Angel Gonzalez Gonzalez
#71468965F
#Dockerfile for the DMZ configuration


FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y openssh-server net-tools iputils-ping traceroute nano iptables iptables-dev iproute2 pkg-config tcpdump nmap apache2
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

RUN apt update && apt install -y git python3-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind virtualenv

RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
RUN tar -xf Python-3.8.0.tgz

RUN cd Python-3.8.0 && ./configure --enable-optimizations && make -j 8 && make altinstall


RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
    && add-apt-repository -y ppa:deadsnakes \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3.8-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :

RUN python3.8 -m venv /venv
ENV PATH=/venv/bin:$PATH

#RUN apt update && apt install -y python3.7 && apt install -y python3.8

RUN adduser cowrie && su cowrie

RUN git clone http://github.com/cowrie/cowrie

RUN chown -R cowrie:cowrie cowrie
USER cowrie

RUN cd cowrie && virtualenv -p python3 cowrie-env && . cowrie-env/bin/activate && pip install --upgrade pip && pip install --upgrade -r requirements.txt

#RUN virtualenv -p python3 cowrie-env

#RUN . cowrie-env/bin/activate && pip install --upgrade pip && pip install --upgrade -r requirements.txt

#RUN bin/cowrie start

#Change the hostname in cowrie
RUN sed -i 's/hostname = svr04/hostname = angel/g' cowrie/etc/cowrie.cfg.dist

RUN sed -i 's/timezone = UTC/timezone = GMT+1/g' cowrie/etc/cowrie.cfg.dist

RUN cd /cowrie/etc && touch userdb.txt && echo "angel:x:12345" > userdb.txt


USER root

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
EXPOSE 2222
COPY ./start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]