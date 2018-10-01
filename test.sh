#!/usr/bin/env bash

cmd="python3 AES.py"

set -e
# Comment in the below line to see tester output
# set -x

for i in `seq 1 64`;
do
    # Print current size
    echo "Testing input size: $i"
    # Get input file
    dd if=/dev/urandom of=in_rand bs=${i} status=none count=1
    # Get key 128
    dd if=/dev/urandom of=key_128 bs=16 status=none count=1
    # Get key 256
    dd if=/dev/urandom of=key_256 bs=32 status=none count=1
    # Execute encrypt 128
    $cmd --keysize 128 --keyfile key_128 --inputfile in_rand --outputfile out_enc_128 --mode encrypt
    # Execute encrypt 256
    $cmd --keysize 256 --keyfile key_256 --inputfile in_rand --outputfile out_enc_256 --mode encrypt
    # Execute decrypt 128
    $cmd --keysize 128 --keyfile key_128 --inputfile out_enc_128 --outputfile out_128 --mode decrypt
    # Execute decrypt 256
    $cmd --keysize 256 --keyfile key_256 --inputfile out_enc_256 --outputfile out_256 --mode decrypt
    # Verify 128 worked
    cmp in_rand out_128
    # Verify 256 worked
    cmp in_rand out_256
done

echo "Done! All tests passed."

rm in_rand key_128 key_256 out_128 out_256 out_enc_128 out_enc_256
