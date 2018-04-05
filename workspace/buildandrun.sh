#!/usr/bin/env bash

cmake ..

make && for file in ../build/*; do 
(
    [[ -x "$file" ]] && $file "${@:1}"
); done
