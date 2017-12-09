# vagrant-evpn-vxlan
Vagrantfile for playing EVPN-VXLAN using gobgp and goplane.

## Topology

```
+---------+ +---------+ +---------+
|  netns  | |  netns  | |  netns  | (Network Namespaces)
+----|----+ +----|----+ +----|----+
+----|----+ +----|----+ +----|----+
| gobgp1  | | gobgp2  | | gobgp3  | (Virtualbox VMs)
+----|----+ +----|----+ +----|----+
     +-----------+-----------+
+----------------|----------------+
|             host OS             | (host OS)
+---------------------------------+
```

this vagrant file creates 3 virtual macines, which are working as PC router, and inside VMs, netns will created for playing vxlan.

## How to play
You need to install vagrant before playing vagrant evpn-vxlan.
This Vagrantfile create two virtual machine.

## Common

```
git clone https://github.com/skjune12/vagrant-evpn-vxlan

vagrant up
```

`vagrant up` takes long time for install dependencies. So please wait for a while.

## Setup gobgp1

### Create netns and configure interfaces
```
vagrant ssh gobgp1
sudo ~/config/config-interface.sh
```

### Running goplane

```bash
vagrant ssh gobgp1
sudo goplane -f ~/config/multiple-sites.conf

ip netns exec vxlan ping -c 5 192.168.1.4
```

## Setup gobgp2

### Create netns and configure interfaces
```
vagrant ssh gobgp2
sudo ~/config/config-interface.sh
```

### Running goplane

```bash
vagrant ssh gobgp2
sudo goplane -f ~/config/multiple-sites.conf
```

## Setup gobgp3

### Create netns and configure interfaces

```
vagrant ssh gobgp3
sudo ~/config/config-interface.sh
```

### Running goplane

```bash
vagrant ssh gobgp3
sudo goplane -f ~/config/multiple-sites.conf
```

## Let's play

### Check BGP status

Check whether bgp is established or not.

```bash
gobgp neigh
```

Check vtep status

```bash
gobgp global rib -a evpn
```

### Send ICMP message

Please open the new window if you need.

### from gobgp1 to gobgp2

```bash
ip netns exec vxlan ping -c 5 192.168.1.4
```

### from gobgp1 to gobgp3

```bash
ip netns exec vxlan ping -c 5 192.168.1.6
```

## Note
- `~/config/two-sites.conf` connects 2 VMs (gobgp1 and gobgp2). This file is stored in gobgp1 and gobgp2.
- On the other hands, `~/config/multiple-sites` connects all VMs (gobgp1, gobgp2, and gobgp3)
