#!/bin/bash

#make sure there are three arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 dir malicious_dir interval-secs"
    exit 1
fi

main_dir="$1"
quarantine_dir="$2"
interval="$3"

extentions=("exe" "bat" "vbs" "scr" "ps1")
bad_names=("virus" "trojan" "malware" "worm" "ransomware")
	
scan(){
	shopt -s nullglob
	for file in "$main_dir"/*;do
		if [! -f "$file"|| ! -e "$file"];then
			continue
		fi
		filename=$(basename "$file")
		
		if grep -qxf "$filename" "whitelist.txt";then
			continue
		fi
		
		malicious=0

		#check for extention
		extention="${filename##*.}"
		for ext in "${extentions}";do
			if [ "$extention" = "$ext" ];then
				malicious=1
				break
			fi
		done

		#if the file wasn't flagged check the content
		if [ "$malicious" -eq 0 ];then
			for content in "${bad_names}";do		
				if grep -qi "$content" "$file";then
					malicious=1	
					break
				fi
			done
		fi
		
		#move file to quarantine and remove it from the main dir
		if [ "$malicious -eq 1" ];then
			echo "file $filename is malicious and it is DELETED"
			cp "$file" "$quarantine_dir"
			rm -f "$file"
		fi
	done		   		
}

last_scan="directory-info.last"
new_scan="directory-info.new"

#to check if "directory-info.last" actually exists or not and to make sure it is a file
#if not then it will scan
if [ ! -f "$last_scan" ];then
	scan
	ls -l "$main_dir" > "$last_scan"
fi

#main loop of the script
while true;do
	sleep "$interval"
	ls -l "$main_dir" > "$new_scan"
	if ! cmp -s "$new_scan" "$last_scan";then
		scan
		cp "$new_scan" "$last_scan"
	fi
done
	
