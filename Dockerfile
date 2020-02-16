FROM golang:1.13
MAINTAINER ElrondNetwork
ARG CACHE_CANCELER=unknown

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl bash mc git make gcc g++ build-essential

WORKDIR ./elrond-go
ARG ELROND_VERSION
ENV GO111MODULE=on
COPY . .
RUN go mod vendor

WORKDIR /go/elrond-go/cmd/keygenerator
RUN go build
RUN ./filegen -mint-value 1000000000000000000000000000 -num-of-shards 5 -num-of-nodes-in-each-shard 21 -consensus-group-size 15 -num-of-observers-in-each-shard 1 -num-of-metachain-nodes 21 -metachain-consensus-group-size 15 -num-of-observers-in-metachain 1 -consensus-type bls -chain-id testnet

WORKDIR /go/elrond-go/cmd/node
RUN go build -i -v -ldflags="-X main.appVersion=$(git describe --tags --long --dirty)"
RUN cp ./node /workspace/

WORKDIR /go/elrond-go/cmd/seednode
RUN go build
RUN cp ./seednode /workspace/seednode
