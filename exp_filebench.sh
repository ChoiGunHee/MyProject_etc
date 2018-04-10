#! /bin/bash

FSNAME=$1
test_workloads=("createfiles" "filemicro_seqread" "filemicro_seqwrite" "randomread" "randomwrite")
test_realworkloads=("webproxy" "webserver" "fileserver")

echo current filesystem : ${FSNAME}
echo ---------------------------------------------------------
echo test workload

for value in "${test_workloads[@]}"; do
    echo $value
done

echo ---------------------------------------------------------
echo test real workload
for value in "${test_realworkloads[@]}"; do
    echo $value
done
echo ----------------------------------------------------------

echo filebench micro start!

for value in "${test_workloads[@]}"; do
    sleep 10;
sudo rm -rf ../testMemp5m/*
    echo remove testMemp5m
    sleep 10;
    echo start ${FSNAME}_${value}
sudo filebench << SCRIPT >> result/${FSNAME}_${value}_result.txt
stats clear
load ${value}
run 600
SCRIPT
    echo done_${FSNAME}_${value}
done 

echo filebench micro end!

echo -----------------------------------------------------------

echo filebench real workload start!

for value in "${test_realworkloads[@]}"; do
    sleep 10;
sudo rm -rf ../testMemp5m/*
    echo remove testMemp5m
    sleep 10;
    echo start ${FSNAME}_${value}
sudo filebench << SCRIPT >> result/${FSNAME}_${value}_result.txt
stats clear
load ${value}
run 600
SCRIPT
    echo done_${FSNAME}_${value}
done

echo filebench real workload end!

echo -----------------------------------------------------------
#sudo filebench << SCRIPT >> result/${FSNAME}_
#load randomwrite
#run 1
#SCRIPT

#sleep 10;
#sudo rm -rf ../testMemp5m/*
#echo remove testMemp5m

#sudo filebench << SCRIPT >> result/test2.txt
#load filemicro_seqwrite
#run 1
#SCRIPT

echo filebench end!
