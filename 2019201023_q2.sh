#!/bin/bash
fullpath=$1
h=0
len=${#fullpath}
# echo $len
for(( i=0; i<${#fullpath} ; i++ )); do
	if [[ "${fullpath:$i:1}" == "."  ]]; then
		h=$i
		break;
	fi
done
e=$(( $len-$h ))
ext="${fullpath:$h+1:$e}"
if [[ $ext == "html" ]]; then
	subl $fullpath
fi
# grep -o -E "(\\.([a-z]))" $fullpath
p=$(cat /usr/share/applications/defaults.list | grep ".*/$ext=*")
# echo $p
if [[ $p -eq "" ]]; then
	echo "Format not Specified"
else
j=0
# k=0
for (( i=0; i<${#p}; i++ )); do
  if [[ "${p:$i:1}" == "=" ]]; then
  	j=$i
  fi
  if [[ "${p:$i:1}" == "." ]]; then
   	k=$i
   	break;
  fi 
done
k=$(( $k-$j ))
s="${p:$j+1:$k-1}"

$s $fullpath
fi
# grep 	
# for(( j=i; j<${#p};j++));do
   	# 	s+=
   	
# find . -type f | egrep -i -E -o "\.{1}\w*$" | sort -su
# if [[ $fullpath == *".mp4"* ]]; then
# 	/usr/bin/totem $fullpath
# elif [[ $fullpath == *".txt"* ]] ; then
# 	/usr/bin/subl $fullpath
# elif [[ $fullpath == *".jpg"* ]] ; then
# 	/usr/bin/pix $fullpath
# elif [[ $fullpath == *".png"* ]] ; then
# 	/usr/bin/pix $fullpath
# elif [[ $fullpath == *".bmp"* ]] ; then
# 	/usr/bin/pix $fullpath
# elif [[ $fullpath == *".wav"* ]] ; then
# 	/usr/bin/vlc $fullpath
# elif [[ $fullpath == *".mp3"* ]] ; then
# 	/usr/bin/vlc $fullpath
# elif [[ $fullpath == *".flv"* ]] ; then
# 	/usr/bin/vlc $fullpath
# elif [[ $fullpath == *".c"* ]] ; then
# 	/usr/bin/subl $fullpath
# elif [[ $fullpath == *".cpp"* ]] ; then
# 	/usr/bin/subl $fullpath
# elif [[ $fullpath == *".py"* ]] ; then
# 	/usr/bin/subl $fullpath
# elif [[ $fullpath == *".html"* ]] ; then
# 	/usr/bin/subl $fullpath
# else
# 	echo "Format Not Supported"
# fi