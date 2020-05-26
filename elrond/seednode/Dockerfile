FROM golang:1.13.6 as builder

RUN git clone https://github.com/ElrondNetwork/elrond-go.git
WORKDIR /go/elrond-go
RUN git checkout tags/v1.0.99
RUN GO111MODULE=on go mod vendor
# Seednode
WORKDIR /go/elrond-go/cmd/seednode
RUN go build

# ===== SECOND STAGE ======
FROM ubuntu
COPY --from=builder /go/elrond-go/cmd/seednode /go/elrond-go/cmd/seednode
WORKDIR /go/elrond-go/cmd/seednode/
EXPOSE 10000
CMD ["./seednode"]
