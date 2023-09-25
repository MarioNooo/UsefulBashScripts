#!/bin/bash

collatz() {
    if (( $1 % 2 == 0 )); then
        echo $(( $1 / 2 ))
    else
        echo $(( 3 * $1 + 1 ))
    fi
}

declare -A steps_map

read -p "Enter the starting number: " start_num
read -p "Enter the ending number: " end_num

for (( num=start_num; num<=end_num; num++ )); do
    current_num=$num
    steps=0

    while (( current_num != 1 )); do
        current_num=$(collatz $current_num)
        steps=$(( steps + 1 ))
    done

    steps=$(( steps + 1 ))

    steps_map[$num]=$steps
done

sorted_steps_map=$(for key in "${!steps_map[@]}"; do echo "$key ${steps_map[$key]}"; done | sort -k2 -rn)

echo "Top 10 numbers with the largest steps:"
counter=0
while IFS= read -r line; do
    counter=$(( counter + 1 ))
    number=$(echo $line | awk '{print $1}')
    steps=$(echo $line | awk '{print $2}')
    echo "$counter. Number: $number, Steps: $steps"
    if (( counter == 10 )); then
        break
    fi
done <<< "$sorted_steps_map"

