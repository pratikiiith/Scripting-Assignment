#!/bin/bash
echo "Hello..Weather Report"
arr=("$@")
len=${#arr[@]}
Lattitude=0
Longitude=0

if [[ $len -eq 1 ]]; then
	city=${arr[0]}
	# echo $city
	website="https://www.latlong.net/search.php?keyword="
	n="$website$city"
	# echo $n
	wget $n -q -O /home/pratik/Desktop/wee.html
	s=`cat /home/pratik/Desktop/wee.html | grep -E -o "<td>[0-9.]*" | grep -E -o [0-9.]*`
	arrr=( $s )
	Lattitude=${arrr[0]}
	Longitude=${arrr[1]}
else	
Lattitude=${arr[0]}
Longitude=${arr[1]}
fi

website="https://darksky.net/forecast/"
p="$website$Lattitude,$Longitude/si12/en"
wget $p -q -O  /home/pratik/Desktop/we.html

temp=$(cat /home/pratik/Desktop/we.html | grep -w "summary swap" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
lowtemp=$(cat /home/pratik/Desktop/we.html | grep -w "low-temp-text" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
hightemp=$(cat /home/pratik/Desktop/we.html | grep -w "high-temp-text" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
wind=$(cat /home/pratik/Desktop/we.html | grep -w "num swip wind__speed__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
humid=$(cat /home/pratik/Desktop/we.html | grep -w "num swip humidity__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
dew=$(cat /home/pratik/Desktop/we.html | grep -w "num dew__point__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
uv=$(cat /home/pratik/Desktop/we.html | grep -w "num uv__index__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
visi=$(cat /home/pratik/Desktop/we.html | grep -w "num swip visibility__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')
pressure=$(cat /home/pratik/Desktop/we.html | grep -w "num swip pressure__value" |  sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g')

echo "Temperature is :" "$temp˚C"
echo "Lowest Temperature :" "$lowtemp ˚C"
echo "Highest Temperature :" "$hightemp ˚C"
echo "Wind :" "$wind m/s"
echo "Humid :" "$humid %"
echo "Dew :" "$dew ˚"
echo "UV :" $uv
echo "Visibility Index :""$visi km"
echo "Pressure :""$pressure hPa"
