#!/bin/bash
dir=-1
arrx=-1
arry=-1
arrrx=-1
arrry=-1
width=100
height=25
snakex=()
snakey=()
LENGTH=3
sanke="#"

function deleteprevious () {
	arrrx=${snakex[$(($LENGTH-1))]}
	arrry=${snakey[$(($LENGTH-1))]}
}

function move () {
	
	for ((i=$(($LENGTH-1)); i>0; i--))
	do
		snakex[$i]=${snakex[$(($i-1))]}
		snakey[$i]=${snakey[$(($i-1))]}
		if [ $arrx = ${snakex[$i]} ] && [ $arry = ${snakey[$i]} ];
		then
			restart
		fi
	done
}

function resetpos () {
	snakex[0]=$arrx
	snakey[0]=$arry
}

function gameover ()
{
  setterm -cursor on
  tput cvvis
  stty echo
  clear
  exit
}

function restart ()
{
  printf "Restart Y/N"
  while true; do
    read -n 1 -t 1 opt
    case $opt in
      [y]) newgame ;;
      [n]) gameover ;;
    esac
  done
}


function snake () {

	for (( i=0; i<$(( $LENGTH )); i++ ));
	do
		tput cup ${snakey[$i]} ${snakex[$i]}
		printf "%s" $sanke
	done

}

function keycommand(){
	read -n1 -t 0.01 key
		case $key in 
			$'\x1b')
				read -n2 -t 0.01 dd
					case $dd in
					'[A')
						if [ "$dir" != "[B" ];
						then
							dir="[A"
							tput setaf 2
						fi
					;;
					'[B')
						if [ "$dir" != "[A" ];
						then
							dir="[B"
							tput setaf 1
						fi
					;;
					'[D')
						if [ "$dir" != "[C" ];
						then
							dir="[D"
							tput setaf 3
						fi
					;;
					'[C')
						if [ "$dir" != "[D" ];
						then
							dir="[C"
							tput setaf 4
						fi
					;;
					esac
					sleep 0.1
		;;
		esac

		case $dir in
		   '[A')
				arry=$(($arry-1))
			;;
		   '[B')
				arry=$(($arry+1))
			;;
		   '[D')
				arrx=$(($arrx-1))
			;;
		   '[C')
				arrx=$(($arrx+1))
			;;
			esac
}

function newgame ()
{	
	border
	dir="[A"
	arrx=$((100/2))
	arry=$((20/2))
	for (( i=0; i<$(($LENGTH)); i++ ));
		do
			snakex[$i]=$(($arrx+$i))
			snakey[$i]=$((arry))
		done
	snake
	val=1
	k=1
	while [[ $val -eq 1 ]]; do
		keycommand
		# changepos
		deleteprevious
		move
		resetpos
		k=$(($k+1))
		if [[ $(($k%30)) == 0 ]]; then
			for ((t=0; t<3; t++))
				do
					snakex+=(${snakex[-1]})
					snakey+=(${snakey[-1]})
					LENGTH=$(( $LENGTH + 1 ))
				done
		fi
		snake
		if [[ $arrry -ne -1 ]] && [[ $arrrx -ne -1 ]]
		then
			tput cup $arrry $arrrx
		fi
		printf " "
		sleep 0.1
		if [ $arry -ge $height ] || [ $arrx -ge $width ] ;
		then
			restart
		fi
		if [ $arry -le 0 ]  || [ $arrx -le 0 ]; then
			restart
		fi
	done
}

border()
{
  setterm -cursor off
  stty -echo
  clear
  tput cup 0 0;
  
  W=$(($width))
  H=$(($height))
  	for i in `seq 1 $H`
	do
		tput cup $i 0
		echo "|"
		tput cup $i $W
		echo "|"
	done

  	for i in `seq 0 $W`
	do
		tput cup 0 $i
		echo "-"
		tput cup $H $i
		echo "-"		
	done
}


menu()
{
  border
  tput cup 1 1
  printf "'N' - New Game"
  printf " 'Q' - Quit"

  while true; do
    read -n 1 -t 1 opt
    case $opt in
      [m]) menu ;;
      [n]) newgame ;;
      [q]) gameover ;;
      *) ;;
    esac
  done
}


menu
