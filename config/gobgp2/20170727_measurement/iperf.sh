#!/bin/bash

$PKTSIZE

if [ $# -ne 2 ]; then
	echo "error"
	exit
else
	TARGET=$1
	IDENTIFIER=$2
fi


for PKTSIZE in {0..9000..1000}
do
	if [ "$PKTSIZE" -eq "0" ]; then
		PKTSIZE=64
	fi

	echo $PKTSIZE
	echo "PAKCET_SIZE = $PKTSIZE" >> ${HOSTNAME}-${IDENTIFIER}-packetsize-${PKTSIZE}.txt
	iperf -c ${TARGET} -t 30 -i 1 -l ${PKTSIZE} | tee ${HOSTNAME}-${IDENTIFIER}-packetsize-${PKTSIZE}.txt
done
