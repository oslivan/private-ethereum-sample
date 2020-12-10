#!/bin/sh
set -e

geth init ./genesis.json
nodeip=`tail -n1 /etc/hosts | awk '{print $1}'`

if [[ $MASTER ]];then
  geth account new --password passfile
  kn=`ls -ltc -r ./keystore | awk '{if($(NF)>"UTC") print $(NF)}' | head -n 1`
  # UTC--2020-12-04T06-27-40.602690000Z--311b369043e4c5fc50eebfac09c35114ec42563e
  address=`echo "0x${kn:0-40}"`
  geth --mine --miner.threads=1 --miner.etherbase=$address --nodekey boot.key --nat extip:$nodeip --http --http.api="db,eth,net,web3,personal" --http.addr "0.0.0.0"
else
  # PING geth.master (172.24.0.2): 56 data bytes
  bootip=`ping -c 1 geth.master | head -n1 | sed 's/.*(\(.*\)).*/\1/g'`
  geth --nat extip:$nodeip --http --http.api="db,eth,net,web3,personal" --http.addr "0.0.0.0" --bootnodes="enode://$MASTER_NODE_KEY@$bootip:30303"
fi

exec "$@"