#! /usr/bin/env bash

function didBust() {
    local cardArray=( ${@} )

    local total=0
    # Check that they are not over.
    for num in "${cardArray[@]}"; do
        (( total += num ))
    done

    if (( total > 21 )); then
        echo "1"
    else
        echo "0"
    fi
}
