#!/bin/bash

sleep 10

while true;
do
    echo "hellllooo"

    echo "starting in /tmp"
    mkdir /tmp/testerrr

    sleep 10

    echo "cleanup"
    rm -r /tmp/testerrr
    rm /usr/bin/tester2

done
