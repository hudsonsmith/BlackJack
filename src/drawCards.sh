#! /usr/bin/env bash

function drawCards() {
    # ${1} Card Array
    # ${2} Name of the player.
    local params=( ${@} )
    local cardArray=()
    local playerName="${params[ $(( $# - 1 )) ]}"

    local i=0
    for param in "${@}"; do
        # Make sure not to grab the last element, because that's a
        # seperate param entirely.
        (( i > ${#} - 2 )) && break
        cardArray+=( "${param}" )
        (( i++ ))
    done

    echo -n "${playerName} Cards: "

    for card in "${cardArray[@]}"; do
        echo -n "[${card}] "
    done

    local total=0
    # Check that they are not over.
    for num in "${cardArray[@]}"; do
        (( total += num ))
    done

    if (( total > 21 )); then
        echo -en "--> \e[31m${total}, Bust!!!!!\e[0m"
        echo
    else
        echo -en "--> \e[32m${total}\e[0m"
        echo
    fi
}
