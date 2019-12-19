#!/bin/bash

## man page for openssl is somewhat sparse. Mostly to remember what
## the relevant flags should be

## https://stackoverflow.com/a/16056298
## http://tombuntu.com/index.php/2007/12/12/simple-file-encryption-with-openssl/

IN="$1"    ## Fist argument is the file to process
ASCII="$2" ## Second argument is ASCII flag
MODE="$3"  ## Can be set automatically, but can be manually set to
           ## 'enc' (encrypt the input) or 'dec' (decrypt input)

if [[ -z "$IN" ]]; then
    echo -e "
openssl.sh <FILE>
openssl.sh <FILE> -a
openssl.sh <FILE> -a enc  # Force encryption of ASCII file with base64 output


  If FILE appears to be data, will prompt for password and decrypt to STDOUT
  Otherwise prompts for password and encrypts to STDOUT

  Pass any value as second argument to (en|de)crypt as ASCII (base64)

"
    exit
fi

## Set ASCII flag
if [[ -z "$ASCII" ]]; then
    ## Not ASCII
    ASCII=""
    ## We then expect encrypted files to be `data`
    DODECRYPT=`file "$IN" | grep -P "\Q$IN\E: data"$`
    ## Some raw files could be data, too. In that case, you'll need to
    ## build the openssl command yourself.
else
    ## Request to use (or expect) base64 ASCII data
    ASCII="-a"
    ## So obviously encrypted files should be ASCII:
    DODECRYPT=`file "$IN" | grep -P "\Q$IN\E: ASCII text"$`
    ## Again, a plaintext file could already be ASCII, in which case
    ## you'd need to run openssl directly.
fi
if [[ -z "$MODE" ]]; then
    if [[ -n "$DODECRYPT" ]]; then
        MODE="dec"
    else
        MODE="enc"
    fi
fi

if [[ "$MODE" == 'dec' ]]; then
    ## We are presumably decrypting the file. You will be prompted for password
    openssl aes-256-cbc -d $ASCII -in "$IN"
else
    ## Otherwise, encrypt, will prompt twice for password:
    openssl aes-256-cbc -salt $ASCII -in "$IN"
fi
