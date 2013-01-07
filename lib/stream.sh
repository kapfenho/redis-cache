#!/bin/bash

SRC=pv
if ! type ${SRC} > /dev/null; then
  SRC=cat
fi

${SRC} $1 | redis-cli --pipe
  
