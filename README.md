# 私有 Ethereum 节点搭建

基于 ethereum 创建了两个私有节点，一个 master 节点开启了挖矿，一个 slave 节点从 master 节点同步区块数据。

## 启动节点
```bash
docker-compose build
docker-compose up -d
```

## 文件解释

**genesis.json**

该文件是定义私有网络的文件，里面的参数 `chainId` 和 `nonce` 可以进行修改，然后在启动节点前，执行 `geth init genesis.json`, 具体资料可以[参考](https://github.com/ethereum/go-ethereum)。

**boot.key**

该文件用来生成 master 节点 p2p 的 nodeKey，为了每次节点启动生成固定的 nodeKey，所以在启动 master 节点时指定 boot.key 即可，如果想要使用新的 boot.key，可以使用 `bootnode --genkey=boot.key` 生成。

**passfile**

该文件用来指定创建矿工账号的密码，因为挖矿节点需要一个账户，目前默认使用 master 节点进行挖矿。

## JSON 调用示例
```bash
curl -s -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":83}' \
     -X POST localhost:18546 | jq
```

## 其他

- 如果将各个节点的IP固定了，那么就可以指定一个静态节点文件 `geth/static-nodes.json`，这样比现有的这种方式要优雅一点。
- 从 slave 节点发布一个合约到私有网络上
