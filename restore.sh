#!/bin/bash

#make sure there are two arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 dir malicious_dir"
    exit 1
fi

main_dir=$1
malicious_dir=$2

while true;do
	shopt -s nullglob
	files=("$malicious_dir"/*)
	k=0
	array=()
	
	for i in "${files[@]}";do
		((k++))
		echo "$k $(basename "$i")"
		array+=("$i")
	done
	
	# k here acts as the size of the array
	if ((k==0));then
		echo "no malicious files to review"
		break
	fi
	
	echo "input a number to choose one of the previous files(q to quit)"
	read x
	
	if [ "$x" = "q" ];then
		break
	elif ((x > k || x <= 0));then
		echo "invalid input"
		continue
	fi
		
	
	file=${array[$((x-1))]}
	filename=$(basename "$file")
	echo "for $filename"
	echo "1- Restore this file back into dir"
	echo "2- Permanently delete this file from malicious_dir"
	echo "3- Leave this file as-is and go back to the list"
	echo "choose an option:"
	read y

	case $y in
		1)
			# main_dir/ will make bash give an error if the dir doesn't exist
			echo "$filename" >> "whitelist.txt"
			mv "$file" "$main_dir/"
			echo "restored $filename to $main_dir"
			;;
		2)
			rm -f "$file"
			echo "$filename has been DELETED"
			;;
		3)
			continue
			;;
		*)
			echo "invalid input"
			;;
	esac
done		

