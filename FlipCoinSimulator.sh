#!/bin/bash -x
#result=k
declare -A singlet
declare -A doublet
singlet=( ["H"]=0 ["T"]=0 )
doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )
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
		elif [[ $numberOfCoin -eq 2 ]]
		then
			check
	      temp1=$result
   	   check
      	temp2=$result
        	if [[ $temp1 -eq 1 && $temp2 -eq 1 ]]
         then
            doublet[HH]=$(( ${doublet[HH]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 0 ]]
         then
            doublet[TT]=$(( ${doublet[TT]}+1 ))
         elif [[ $temp1 -eq 1 && $temp2 -eq 0 ]]
         then
            doublet[HT]=$(( ${doublet[HT]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 1 ]]
         then
            doublet[TH]=$(( ${doublet[TH]}+1 ))
         fi
		fi
	done
	if [[ $numberOfCoin -eq 1 ]]
   then
		echo ${singlet[@]}
   	echo ${!singlet[@]}
   	headPercent=`expr "scale=2; ( ${singlet[H]} / $number *100 ) " | bc -l`
   	echo "percentage=$headPercent%"
		tailPercent=`expr "scale=2; ( ${singlet[T]} / $number *100 ) " | bc -l`
      echo "Percentage=$tailPercent%"

	elif [[ $numberOfCoin -eq 2 ]]
	then
		echo ${doublet[@]}
      echo ${!doublet[@]}
      headHead=`expr "scale=2; ( ${doublet[HH]} / $number *100 ) " | bc -l`
      echo "Percentage of HH =$headHead%"
		tailTail=`expr "scale=2; ( ${doublet[TT]} / $number *100 ) " | bc -l`
      echo "Percentage of TT=$tailTail%"
		headTail=`expr "scale=2; ( ${doublet[HT]} / $number *100 ) " | bc -l`
      echo "Percentage of HT =$headTail%"
      tailHead=`expr "scale=2; ( ${doublet[TH]} / $number *100 ) " | bc -l`
      echo "Percentage of TT=$tailHead%"


	fi
}
flipCoin
