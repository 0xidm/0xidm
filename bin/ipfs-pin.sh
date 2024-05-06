#!/bin/bash

ENS=0xidm.eth
IPNS_KHASH=k51qzi5uqu5dlk3a1ya0bqrp3oac0hlstzeubd6sz75c3d0nhketip7j0o9zna
PIN_CMD="echo starting..."

function append_resolve() {
    PIN_CMD="${PIN_CMD}; ipfs name resolve --nocache $1"
}

function append_pin() {
    PIN_CMD="${PIN_CMD}; ipfs pin add $1"
}

function ipfs_pin() {
    ssh -t "$1" "docker exec -it ipfs /bin/sh -c '${PIN_CMD}'"
}

append_resolve /ipns/${IPNS_KHASH}
append_resolve /ipns/${ENS}

append_pin /ipns/${IPNS_KHASH}
append_pin /ipns/${IPNS_KHASH}/index.html

ipfs_pin $1
