#!/bin/bash

# create veth pair and netns
ip netns add vxlan
ip link add veth0 type veth peer name veth1
ip link set veth0 netns vxlan
ip netns exec vxlan ifconfig lo up
ip netns exec vxlan ifconfig veth0 192.168.1.4 up
ifconfig veth1 192.168.1.3 up

cat <<EOF > /etc/rc.local
ip netns add vxlan
ip link add veth0 type veth peer name veth1
ip link set veth0 netns vxlan
ip netns exec vxlan ifconfig lo up
ip netns exec vxlan ifconfig veth0 192.168.1.4 up
ifconfig veth1 192.168.1.3 up

exit 0
EOF

exit
