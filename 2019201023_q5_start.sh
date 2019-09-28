#!/bin/bash

x=$HOME
p="$x/Downloads/"
read username
read -s password
wget --user $username --password $password https://vpn.iiit.ac.in/secure/linux.ovpn -P $p
q="$p/linux.ovpn"
sed -i 's/.*group nobody.*/group nogroup/' $q
sed -i 's/.*ns-cert-type server.*/remote-cert-tls server/' $q
# echo $p
var="nameserver 10.4.20.204";
sudo sed -i '1s/^/nameserver 10.4.20.204\n/' /etc/resolv.conf
sudo openvpn --config $q
# sleep 10

