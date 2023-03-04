#! /bin/sh

# This is pretty scuffed and pretty specific to my TrueNAS Scale setup and network
ip route del 192.168.100.0/24 dev net1 scope link
