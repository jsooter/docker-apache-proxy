

### Setup a local domain in /etc/hosts

```
echo "10.244.0.1" >> /etc/hosts
```

### Forward port 80 with iptables

```
iptables -t nat -A OUTPUT -p tcp --dport 80 -d 10.244.0.1 -j DNAT --to-destination 127.0.0.1:8008
```

### Configure proxy

Open sites-enabled/000-default.conf

Edit the the following lines and replace www.google.com with your destination domain

```
ProxyPass / https://www.google.com/
ProxyPassReverse / https://www.google.com/
```

### Start the proxy container

```
docker-compose build

docker-compose up -d
```

this is a test