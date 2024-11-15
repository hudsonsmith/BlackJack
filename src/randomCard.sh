#! /usr/bin/env bash

function randomCard() {
    echo "$(( RANDOM % 10 + 2 ))"
}
