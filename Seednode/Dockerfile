FROM golang:1.13
MAINTAINER ElrondNetwork
ARG CACHE_CANCELER=unknown

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl bash mc git make gcc g++ build-essential

WORKDIR ./elrond-go
ARG ELROND_VERSION
ENV GO111MODULE=on
COPY /workspace/seednode .
RUN go mod vendor

CMD ["./seednode"]
