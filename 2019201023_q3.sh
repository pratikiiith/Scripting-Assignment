#!/bin/bash

fullpath=$1
check=0
if [[ -f "$fullpath" ]]; then
	check=1
fi

if [[ $check -eq 1 ]]; then
	if [[ $fullpath == *"tar.bz2"* ]]; then
		tar -xjf $fullpath
	elif [[ $fullpath == *"tar.gz"* ]] ; then
		tar -xzf $fullpath	
	elif [[ $fullpath == *"zip"* ]] ; then
		unzip $fullpath
	elif [[ $fullpath == *"tar.z"* ]]; then
		uncompress $fullpath
	elif [[ $fullpath == *"tar"* ]] ; then
		tar -xf $fullpath	
	elif [[ $fullpath == *"7z"* ]]; then
		7z x $fullpath
	elif [[ $fullpath == *"ar"* ]]; then
		ar xv $fullpath
	elif [[ $fullpath == *"cbz"* ]]; then
		unzip -j $fullpath
	elif [[ $fullpath == *"ear"* ]]; then
		unzip xv $fullpath
	elif [[ $fullpath == *"iso"* ]]; then
		7z x $fullpath
	elif [[ $fullpath == *"lzma"* ]]; then
		lzma -d $fullpath
	elif [[ $fullpath == *"war"* ]]; then
		unzip $fullpath
	elif [[ $fullpath == *"xz"* ]]; then
		xz --decompress $fullpath
	elif [[ $fullpath == *"jar"* ]]; then
		unzip $fullpath
	else
		echo "Not a compressed file"
	fi
else
	echo "File Not Found"
fi