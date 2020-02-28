#!/bin/bash -x
#result=k
declare -A singlet
declare -A doublet
declare -A triplet
singlet=( ["H"]=0 ["T"]=0 )
doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )
triplet=( ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["THH"]=0 ["HTT"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 )
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
		elif [[ $numberOfCoin -eq 3 ]]
      then
         check
         temp1=$result
         check
         temp2=$result
			check
			temp3=$result
         if [[ $temp1 -eq 1 && $temp2 -eq 1 && $temp3 -eq 1 ]]
         then
            triplet[HHH]=$(( ${triplet[HHH]}+1 ))
         elif [[ $temp1 -eq 1 && $temp2 -eq 1 && $temp3 -eq 0 ]]
         then
            triplet[HHT]=$(( ${triplet[HHT]}+1 ))
         elif [[ $temp1 -eq 1 && $temp2 -eq 0 && $temp3 -eq 1 ]]
         then
            triplet[HTH]=$(( ${triplet[HTH]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 1 && $temp3 -eq 1 ]]
         then
            triplet[THH]=$(( ${triplet[THH]}+1 ))
			elif [[ $temp1 -eq 1 && $temp2 -eq 0 && $temp3 -eq 0 ]]
         then
            triplet[HTT]=$(( ${triplet[HTT]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 1 && $temp3 -eq 0 ]]
         then
            triplet[THT]=$(( ${triplet[THT]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 0 && $temp3 -eq 1 ]]
         then
            triplet[TTH]=$(( ${triplet[TTH]}+1 ))
         elif [[ $temp1 -eq 0 && $temp2 -eq 0 && $temp3 -eq 0 ]]
         then
            triplet[TTT]=$(( ${triplet[TTT]}+1 ))
			fi
		fi
	done
	if [[ $numberOfCoin -eq 1 ]]
   then
		echo ${singlet[@]}
   	echo ${!singlet[@]}
   	echo "Percentage of H=`expr "scale=2; ( ${singlet[H]} / $number *100 ) " | bc -l`"
		echo "Percentage of T=`expr "scale=2; ( ${singlet[T]} / $number *100 ) " | bc -l`"
	elif [[ $numberOfCoin -eq 2 ]]
	then
		echo ${doublet[@]}
      echo ${!doublet[@]}
      echo "Percentage of HH="`expr "scale=2; ( ${doublet[HH]} / $number *100 ) " | bc -l`
		echo "Percentage of TT="`expr "scale=2; ( ${doublet[TT]} / $number *100 ) " | bc -l`
		echo "Percentage of HT="`expr "scale=2; ( ${doublet[HT]} / $number *100 ) " | bc -l`
      echo "Percentage of TT="`expr "scale=2; ( ${doublet[TH]} / $number *100 ) " | bc -l`
	elif [[ $numberOfCoin -eq 3 ]]
   then
      echo ${triplet[@]}
      echo ${!triplet[@]}
      echo "Percentage of HHH="`expr "scale=2; ( ${triplet[HHH]} / $number *100 ) " | bc -l`
      echo "Percentage of HHT="`expr "scale=2; ( ${triplet[HHT]} / $number *100 ) " | bc -l`
      echo "Percentage of HTH="`expr "scale=2; ( ${triplet[HTH]} / $number *100 ) " | bc -l`
      echo "Percentage of THH="`expr "scale=2; ( ${triplet[THH]} / $number *100 ) " | bc -l`
	   echo "Percentage of HTT="`expr "scale=2; ( ${triplet[HTT]} / $number *100 ) " | bc -l`
      echo "Percentage of THT="`expr "scale=2; ( ${triplet[THT]} / $number *100 ) " | bc -l`
      echo "Percentage of TTH="`expr "scale=2; ( ${triplet[TTH]} / $number *100 ) " | bc -l`
      echo "Percentage of TTT="`expr "scale=2; ( ${triplet[TTT]} / $number *100 ) " | bc -l`
	fi
}
flipCoin
