#!/bin/bash

x=$HOME
sudo ip link delete tun0
p="$x/Downloads/*.ovpn"
rm $p
var="nameserver 10.4.20.204";
sudo sed -i '1d' /etc/resolv.conf