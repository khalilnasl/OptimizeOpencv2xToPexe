#!/bin/bash

for a in $(seq 9 3 30)
do
    for b in $(seq 0 1 9)
    do
        echo "Processing PlatooningNoGui_${a}_${b}.vec..."
        opp_vec2csv.pl --merge-by em -A configname -F tbSent:vector -F senderID:vector -F sciUnsensed:vector -F tbFailedDueToProp:vector -F tbDecoded:vector PlatooningNoGui_${a}_${b}.vec | tr ' ' ',' > P10_${a}_${b}.csv

        # If the csv file was created successfully, delete the vec file
        if [ $? -eq 0 ]
        then
            echo "Removing PlatooningNoGui_${a}_${b}.vec..."
            rm PlatooningNoGui_${a}_${b}.vec
        else
            echo "Error converting PlatooningNoGui_${a}_${b}.vec, skipping deletion..."
        fi
    done
done


