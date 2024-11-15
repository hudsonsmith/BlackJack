#! /usr/bin/env bash

function playAgain() {
    local response
    read -p "Would you like to play again? [y/n] > " response

    [[ "${response}" != "y" ]] && return 1
    return 0
}
