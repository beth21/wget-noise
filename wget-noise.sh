#!/bin/bash

usage()
{
cat << _END_
$(basename $0) [file]

Initiates a recursive web spider retrieval of web pages listed
in the specified file. If no file is specified, a brief help
text is displayed. 

Remember that wget reads configuration settings from .wgetrc

pastables:

pgrep -l -f wget
pkill wget
cd /tmp/wget-out

_END_
}

if [ $# -eq 0 ]
then
  usage
  exit  
fi

# Canonicalize the file name 
file=$(readlink -f "$1")

if [ ! -f "$1" ]
then
  echo "File $file not found"  
  exit
fi


cd /tmp
[ -e wget-out ] || mkdir wget-out
cd wget-out

echo "Writing output to $PWD"

sed -e '/^#/d' "$file" | while read n
do
  # Note that configuration parameters are set in ~/.wgetrc
  wget "$n" > /dev/null
done

