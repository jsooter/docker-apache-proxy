# use iptables to forward 10.244.0.1:80 to 127.0.0.1:8008
iptables -t nat -A OUTPUT -p tcp --dport 80 -d 10.244.0.1 -j DNAT --to-destination 127.0.0.1:8008
