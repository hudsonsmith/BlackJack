#! /usr/bin/env bash

# animatedWait.sh: meant to be imported into main.sh.

function animatedWait() {
    local waitTime="${1}"
    (( waitTime *= 10 ))

    while (( waitTime > 0 )); do
        [[ "${#waitTime}" == "1" ]] && echo -ne "\r0.${waitTime:0:1} " || echo -ne "\r${waitTime:0:1}.${waitTime:1:2} "


        (( waitTime-- ))
        sleep 0.1
    done
}
