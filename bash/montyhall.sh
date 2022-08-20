#!/usr/bin/env bash
declare goat='🐐'; 
declare car='🚘';
declare door='🚪';
declare open_door_string='';
declare reveal_string='';
declare door_opt=(1 2 3)
declare door_car=$((1+$RANDOM % 3))
printf "Choose one of the doors 1, 2 or 3:\n$door $door $door\n"
read first_choice
left_opt=( ${door_opt[@]/$first_choice} )
if [[ $first_choice -ne $door_car ]];then
    for i in 1 2 3
    do
        if [[ $i -ne $door_car && $i -ne $first_choice ]]; then
            open=($i)
            break
        fi
    done
else
    rand=$(($RANDOM % 2))
    open=(${left_opt[$rand]})
fi
for i in 1 2 3
do
    #echo "$i and $open"
    if [ $i == $open ]; then
        open_door_string+=$goat
    else
        open_door_string+=$door
    fi
    open_door_string+=" "
done
printf "I open you door number $open, would you like to switch? (y/n)\n$open_door_string\n"
read $switch
if [[ $switch == "y" ]]; then
    if [[ ${left_opt[0]} == $first_choice ]];then
        $first_choice=${left_opt[1]}
    else
        $first_choice=${left_opt[0]}
    fi
fi
for i in 1 2 3
do
    if [ $i -eq $door_car ]; then
        reveal_string+=$car
    else
        reveal_string+=$goat
    fi
    reveal_string+=" "
done
printf "$reveal_string\n"
printf "The car was behind door number $door_car.\n"
if [[ $door_opt == $first_choice ]]; then
    printf "Congratulations, you won!\n"
fi