#! /usr/bin/env bash

function total() {
    local cardArray=( ${@} )

    local total=0
    # Check that they are not over.
    for num in "${cardArray[@]}"; do
        (( total += num ))
    done

    echo "${total}"
}
