#!/bin/bash -x
#result=k
declare -A singlet
declare -A doublet
singlet=( ["H"]=0 ["T"]=0 )
function check()
{
	toss=$((RANDOM%2))
	if [[ $toss -eq 1 ]]
	then
  		printf "Heads "
		result=1
	else
   	printf "Tails "
		result=0
	fi
}
function flipCoin()
{
	read -p "Enter how many coins you want to flip simultaniosly: " numberOfCoin
	read -p "Enter the number of times you want flip the coin: " number
	for (( counter=0;counter<$number;counter++ ))
	do
		if [[ $numberOfCoin -eq 1 ]]
		then
			check
			if [[ $result -eq 1 ]]
			then
				singlet[H]=$(( ${singlet[H]}+1 ))
			elif [[ $result -eq 0 ]]
			then
				singlet[T]=$(( ${singlet[T]}+1 ))
			fi
		fi
	done
	echo ${singlet[@]}
	echo ${!singlet[@]}
	headPercent=`expr "scale=2; ( ${singlet[H]} / $number *100 ) " | bc -l`
	echo "percentage=$headPercent%"
}
flipCoin
