#! /usr/bin/env bash

function banner() {
    # Current money ${1}
    # Rounds Played ${2}

    if [[ "${2}" == "0" ]]; then
        echo "Current Money: \$${1}"
        echo "------------------------------------------------------"
    else
        echo "Current Money: \$${1} | Rounds Played ${2}"
        echo "------------------------------------------------------"
    fi
}
