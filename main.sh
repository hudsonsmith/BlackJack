#! /usr/bin/env bash

# Import all helper functions.
for file in ./src/*; do
    source "${file}"
done

function main() {
    [[ ! -f "./money" ]] && echo "Money file doesn't exist, creating" && echo "0" > money
    local money=$(cat ./money)
    local roundsPlayed=0

    while true; do
        while true; do
            clear
            banner "${money}" "${roundsPlayed}"
            local playerCards=()
            local dealerCards=()
            local busted=0

            playerCards+=( $(randomCard) )

            # Give the dealer 11 and up to 10, that way the dealer doesn't accidentally bust.
            dealerCards+=( $(randomCard) $(randomCard) )

            clear
            banner "${money}" "${roundsPlayed}"
            drawCards "${playerCards[@]}" "Your"

            echo ""
            echo "Dealer's Card: [${dealerCards[1]}] [?]"
            
            local bet
            read -p "Enter your bet (\$\$\$): " bet

            # Hit or stay
            while true; do
                # Player cards, and prelim checks
                clear
                banner "${money}" "${roundsPlayed}"
                drawCards "${playerCards[@]}" "Your"

                echo ""
                echo "Dealer's Card: [${dealerCards[1]}] [?]"

                # If the player went over 21, then break out of the loop.
                if [[ $(didBust "${playerCards[@]}") == "1" ]]; then
                    busted=1
                    break
                fi


                local hitOrStay
                read -p "[H]it or [S]tay? > " hitOrStay

                # First Character
                hitOrStay="${hitOrStay:0:1}"

                # Lowercase it.
                hitOrStay="${hitOrStay,,}"

                if [[ "${hitOrStay}" == "h" ]]; then
                    playerCards+=( $(randomCard) )

                    
                elif [[ "${hitOrStay}" == "s" ]]; then
                    break;
                fi
            done

            # Break early
            if [[ "${busted}" == "1" ]]; then
                echo -e "\e[31mYou lost (you busted)\e[0m"
                break
            fi
            

            while (( $(total "${dealerCards[@]}") < 15 )); do
                clear
                banner "${money}" "${roundsPlayed}"
                drawCards "${playerCards[@]}" "Your"
                drawCards "${dealerCards[@]}" "Dealer's"

                echo -e "\e[32mDealer\e[0m: *Draws another card*"
                animatedWait 3
                dealerCards+=( $(randomCard) )
            done

            clear
            banner "${money}" "${roundsPlayed}"
            drawCards "${playerCards[@]}" "Your"
            drawCards "${dealerCards[@]}" "Dealer's"
            
            local dealerTotal=$(total "${dealerCards[@]}")
            local playerTotal=$(total "${playerCards[@]}")

            if (( dealerTotal > 21 )); then
                echo -e "\n\n\e[32mYou won (dealer busted)!\e[0m"
                (( money += bet ))

            elif (( playerTotal > dealerTotal )); then
                echo -e "\n\n\e[32mYou won (you beat the odds against the dealer)!\e[0m"
                (( money += bet ))

            elif (( playerTotal < dealerTotal )); then
                echo -e "\n\n\e[31mYou lost (the dealer had a higher hand)!\e[0m"
                (( money -= bet ))

            elif (( playerTotal == dealerTotal )); then
                echo -e "\n\n\e[32mTie. No money was lost.\e[0m"

            fi

            # Super important
            break
        done

        if ! playAgain; then
            echo "Bye!"
            echo "${money}" > ./money
            exit
        fi
        (( roundsPlayed++ ))
    done

}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main

