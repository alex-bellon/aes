# AES Implementation

## Step 0: Expand the key, fill in the matrices

### Key scheduling/expansion
Iterate over the number of words in the key. With N = 4 (128 bit) or 8 (256 bit), for the `i`th word, if:
- `i < n`, then the `i`th word is unchanged.
- `i >= n` and `i % n` is 0, then get the preceding word, rotate it and substitute it (from `Sbox`), and then XOR with the `i-n`th word, then `XOR` with round constant `i/n`.
- `i >= n`, `n > 6`, and `i % n = 4`, then `XOR` together the `i-n`th word and the previous word substituted (from `Sbox`).
- else, `XOR` the previous word with the `i-n`th word.

## Fill in the  matrices:
Put the plaintext into a 4x4 column major matrix, and pad with `16 - a % 16` in the empty cells where `a` is the length of the plaintext in bytes.

## Step 1: SubBytes

Index into `Sbox` and replace each byte with it's counterpart in `Sbox`.

## Step 2: ShiftRows

Shift each row 'i' left by 'i' places.

## Step 3: MixCols

Do matrix multiplication on each column by a defined matrix. In this step, adding is `XOR`ing and multiplication uses the Galois lookup table.

## Step 4: AddKey

`XOR` the expanded keys with the resulting matrices 

## CBC Mode

Generate a 16 byte initialization vector. On the first round, XOR that with the plaintext before doing the round. In every following round, you XOR the previous block's ciphertext with the current round's plaintext before doing the round.

# Usage

### ECB Mode
`python AES.py --keysize <128/256> --keyfile <file> --inputfile <file> --outputfile <file> --mode <encrypt/decrypt>`

### CBC Mode
Add the `--cbc <file>` flag where the file is the initialization vector.
