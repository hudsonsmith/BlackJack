#! /usr/bin/env bash

source ./main.sh

function testWait() {
    animatedWait 2.5

}

function main() {
    testWait
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main
