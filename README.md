# vagrant-evpn-vxlan
Vagrantfile for playing EVPN-VXLAN using [gobgp](https://github.com/osrg/gobgp) and [goplane](https://github.com/osrg/goplane).

## Topology

```
        (veth1) +--------+ (enp0s8)       mp-BGP      (enp0s8) +--------+ (veth1)
... ----------+ | gobgp1 | +---------------------------------+ | gobgp2 | +---------- ...
 192.168.1.1/24 |  (VM)  | 10.10.0.10/24         10.10.0.20/24 |  (VM)  | 192.168.1.4/24
                +--------+                                     +--------+
                < AS65000 >                                    < AS65000 >
```

## How to play
You need to install vagrant before playing vagrant evpn-vxlan.
This Vagrantfile creates two virtual machine.

## Common

```
git clone https://github.com/skjune12/vagrant-evpn-vxlan
cd vagrant-evpn-vxlan
vagrant up
```

`vagrant up` takes long time for install dependencies. So please wait for a while.


## Setup gobgp1

### Running goplane

```bash
vagrant ssh gobgp1
sudo -i
goplane -f config/goplane.conf

ip netns exec vxlan ping -c 5 192.168.1.4
```

### Send ICMP message

Please open the new window if you need.

```bash
ip netns exec vxlan ping -c 5 192.168.1.4
```


## Setup gobgp2

### Running goplane

```bash
vagrant ssh gobgp1
sudo -i
goplane -f config/goplane.conf
```

### Send ICMP message

Please open the new window if you need.

```bash
ip netns exec vxlan ping -c 5 192.168.1.1
```

