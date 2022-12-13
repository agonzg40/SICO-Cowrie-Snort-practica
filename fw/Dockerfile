#Angel Gonzalez Gonzalez
#71468965F
#Dockerfile for the firewall configuration


FROM ubuntu:18.04

#ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update --fix-missing
RUN apt-get dist-upgrade -y

RUN apt install -y tzdata

RUN dpkg-reconfigure tzdata

RUN apt-get install -y openssh-server net-tools iputils-ping traceroute nano iptables iptables-dev iproute2 pkg-config tcpdump nmap 
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh

RUN mkdir ~/snort_src
RUN cd ~/snort_src && apt-get install -y build-essential autotools-dev libdumbnet-dev libluajit-5.1-dev libpcap-dev \
zlib1g-dev pkg-config libhwloc-dev cmake liblzma-dev openssl libssl-dev cpputest libsqlite3-dev \
libtool uuid-dev git autoconf bison flex libcmocka-dev libnetfilter-queue-dev libunwind-dev \
libmnl-dev ethtool libjemalloc-dev

#RUN apt-get install -y build-essential autotools-dev libdumbnet-dev libluajit-5.1-dev libpcap-dev

#RUN apt-get install -y zlib1g-dev pkg-config libhwloc-dev cmake liblzma-dev openssl libssl-dev cpputest libsqlite3-dev

#RUN apt-get install -y libtool uuid-dev git autoconf bison flex libcmocka-dev libnetfilter-queue-dev libunwind-dev

#RUN apt-get install -y libmnl-dev ethtool libjemalloc-dev

RUN cd ~/snort_src && wget https://github.com/rurban/safeclib/releases/download/v02092020/libsafec-02092020.tar.gz && \
tar -xvzf libsafec-02092020.tar.gz &&  cd libsafec-02092020.0-g6d921f && ./configure && make && make install

#RUN wget https://github.com/rurban/safeclib/releases/download/v02092020/libsafec-02092020.tar.gz

#RUN tar -xzvf libsafec-02092020.tar.gz

#RUN cd libsafec-02092020.0-g6d921f && ./configure

#WORKDIR /libsafec-02092020.0-g6d921f

#RUN ./configure

RUN cd ~/snort_src && wget https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz && tar -xzvf pcre-8.45.tar.gz && cd pcre-8.45 && \
./configure && make && make install

RUN cd ~/snort_src && wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz && tar xzvf gperftools-2.9.1.tar.gz && \
cd gperftools-2.9.1 && ./configure && make && make install

RUN cd ~/snort_src && wget http://www.colm.net/files/ragel/ragel-6.10.tar.gz && tar -xzvf ragel-6.10.tar.gz && \
cd ragel-6.10 && ./configure && make && make install

RUN cd ~/snort_src && wget https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.gz && tar -xvzf boost_1_77_0.tar.gz

RUN cd ~/snort_src && wget https://github.com/intel/hyperscan/archive/refs/tags/v5.4.0.tar.gz && tar -xvzf v5.4.0.tar.gz && \
mkdir ~/snort_src/hyperscan-5.4.0-build && cd hyperscan-5.4.0-build/ && cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBOOST_ROOT=~/snort_src/boost_1_77_0/ ../hyperscan-5.4.0 && \
make && make install

RUN cd ~/snort_src && wget https://github.com/google/flatbuffers/archive/refs/tags/v2.0.0.tar.gz -O flatbuffers-v2.0.0.tar.gz && tar -xzvf flatbuffers-v2.0.0.tar.gz && \
mkdir flatbuffers-build && cd flatbuffers-build && cmake ../flatbuffers-2.0.0 && make && make install

RUN cd ~/snort_src && wget https://github.com/snort3/libdaq/archive/refs/tags/v3.0.5.tar.gz -O libdaq-3.0.5.tar.gz && tar -xzvf libdaq-3.0.5.tar.gz && \
cd libdaq-3.0.5 && ./bootstrap && ./configure && make && make install

RUN ldconfig

RUN cd ~/snort_src && wget https://github.com/snort3/snort3/archive/refs/tags/3.1.18.0.tar.gz -O snort3-3.1.18.0.tar.gz && tar -xzvf snort3-3.1.18.0.tar.gz && \
cd snort3-3.1.18.0 && ./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc --enable-jemalloc && cd build && make && make install

#RUN sed -i 's/HOME_NET = 'any'/HOME_NET = [[ '10.5.2.0/24 10.5.1.0/24' ]]/g' \/usr\/local\/etc/snort\/snort.lua

#use sed to substitute the HOME_NET variable in snort.lua with the 10.5.2.0/24 10.5.1.0/24

RUN sed -i "s/HOME_NET = 'any'/HOME_NET = [[ 10.5.2.0\/24 10.5.1.0\/24 ]]/" \/usr\/local\/etc\/snort\/snort.lua



RUN cd /usr/local/etc/ && mkdir rules && cd rules && wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz && tar -xf snort3-community-rules.tar.gz && cd snort3-community-rules && mv snort3-community.rules /usr/local/etc/rules/
#RUN cd /usr/local/etc/rules && tar -xf community-rules.tar.gz

#&& tar -xzvf community-rules.tar.gz && cd /snort3-community-rules && mv community-rules/snort3-community.rules /usr/local/etc/rules/

RUN sed -i 's/# alert/alert/g' \/usr\/local\/etc\/rules\/snort3-community.rules

RUN sed -i '/$AIM_SERVERS/d' \/usr\/local\/etc\/rules\/snort3-community.rules


RUN echo 'alert tcp 10.5.0.20 any -> 10.5.2.20 any (msg:"Flood detected in internal"; flags:F)' > \/usr\/local\/etc\/rules\/snort3-community.rules


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
EXPOSE 2222
COPY ./start.sh .
RUN chmod +x start.sh
CMD ["./start.sh"]