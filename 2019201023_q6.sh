#!/bin/bash
arr=("$@")
len=${#arr[@]}
pw=$(pwd)
source=${arr[0]}
go=0
if [ -d $source ] 
then
	go=1     
else
    echo "Source does not exists."
fi

if [[ $go -eq 1 ]]; then
	a="all"
	ext=$(ls $source | sed 's/^.*\.//')
	flag=0
	echo ${#ext}
	echo $ext
	for (( i=1; i<$len; i++ )); do
		temp=${arr[$i]}
		# echo $temp
		if [[ $temp == $a ]]; then
			
			for j in $ext
			do
				pat="$source/$j"
				mkdir -p $pat
				t="$source/*.$j"
				mv $t $pat
			done
		else
			for k in $ext ;do
				if [[ $k == $temp ]]; then
					flag=1
				fi
			done
			if [[ $flag -eq 1 ]]; then
				pat="$source/$temp"
				mkdir -p $pat
				t="$source/*.$temp"
				mv $t $pat
			else
				echo "File type does not exist"
			fi
		fi
	done
fi


# echo $len
# echo $pw
# echo $source
# temp=${arr[1]}
# if [[ $temp == $a ]]; then
# 	echo hi
# fi
# echo $temp
# ext=$(ls $source | sed 's/^.*\.//')
# 		for j in $ext
# 		do
# 			echo $j
# 		done


# 		# mkdir -p /home/pratik/Desktop/allfiles mv -p $t /home/pratik/Desktop/allfiles
# 	# else
# 	# 	t="source/*.$temp"
# 	# 	s="pwd/$temp"
# 	# 	mkdir $s
# 	# 	mv -p $t $s
# 	# fi
# done




# elif [[ ${arr[$i]}==$pdf ]]; then
# 	temp="$source*.pdf"
# 	mv $temp /home/pratik/Desktop/pdf
# elif [[ ${arr[$i]}==$jpg ]]; then
# 	temp="$source*.pdf"
# 	mv $temp /home/pratik/Desktop/pdf
# elif [[ ${arr[$i]}==$jpg ]]; then
# 	temp="$source*.pdf"
# 	mv $temp /home/pratik/Desktop/pdf
# elif [[ ${arr[$i]}==$jpg ]]; then
# 	#temp="$source*.pdf"
# 	mv $temp /home/pratik/Desktop/pdf