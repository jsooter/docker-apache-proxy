# use packet filter (pfctl) to forward 10.244.0.1:80 to 127.0.0.1:8008
echo "rdr pass on lo0 inet proto tcp from any to 10.244.0.1 port 80 -> 127.0.0.1 port 8008" | sudo pfctl -ef -
