#!/bin/bash

#Angel Gonzalez Gonzalez
#71468965F
#script for the DMZ configuration


ip route replace default via 10.5.1.1 dev eth0

/etc/init.d/apache2 start

iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222


#iptables -t nat -I PREROUTING -p tcp --dport 22 -j REDIRECT --to-ports 2222

#iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 22 -j REDIRECT --to-port 2222

#iptables -A PREROUTING -t nat -p tcp --dport 22 -j REDIRECT --to-ports 2222



/usr/sbin/sshd -D