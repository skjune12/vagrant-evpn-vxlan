#!/bin/bash

PKTSIZ=0

for PKTSIZ in `seq 0 15`;
do
    if [ $PKTSIZ -eq 0 ]; then
        PKTSIZ=64
    else
        PKTSIZ=$(($PKTSIZ*100))
    fi

    FILENAME=gobgp1to2-underlay-$PKTSIZ.txt
    echo $FILENAME
    iperf -c 10.0.12.20 -t 10 -i 1 -l $PKTSIZ | tee $FILENAME

    FILENAME=gobgp1to2-overlay-$PKTSIZ.txt
    echo $FILENAME
    ip netns exec vxlan iperf -c 192.168.1.4 -t 10 -i 1 -l $PKTSIZ | tee $FILENAME

    FILENAME=gobgp1to3-underlay-$PKTSIZ.txt
    echo $FILENAME
    iperf -c 10.0.23.20 -t 10 -i 1 -l $PKTSIZ | tee $FILENAME

    FILENAME=gobgp1to3-overlay-$PKTSIZ.txt
    echo $FILENAME
    ip netns exec vxlan iperf -c 192.168.1.6 -t 10 -i 1 -l $PKTSIZ | tee $FILENAME
done
