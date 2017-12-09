#!/bin/bash

# create veth pair and netns
ip netns add vxlan
ip link add veth0 type veth peer name veth1
ip link set veth0 mtu 1450
ip link set veth1 mtu 1450
ip link set veth0 netns vxlan
ip netns exec vxlan ifconfig lo up
ip netns exec vxlan ifconfig veth0 192.168.1.6 up
ifconfig veth1 192.168.1.5 up

cat <<EOF > /etc/rc.local
ip netns add vxlan
ip link add veth0 type veth peer name veth1
ip link set veth0 netns vxlan
ip netns exec vxlan ifconfig lo up
ip netns exec vxlan ifconfig veth0 192.168.1.6 up
ifconfig veth1 192.168.1.5 up

exit 0
EOF

ip route add 10.0.12.0/24 via 10.0.23.10
ip route add 1.1.1.1/32 via 10.0.23.10

exit
