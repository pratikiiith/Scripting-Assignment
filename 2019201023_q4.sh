#!/bin/bash
echo "Enter pass..."
read -s pass
flag=0
for((i=4;i<=${#pass};i++))
do
  for((j=0;j<=${#pass}-$i;j++))
  do
    if [ `grep -cE "^${pass:$j:$i}$" /usr/share/dict/words` -gt 0 ]
    then
      echo "Password contains dictionary words"
      flag=1
      break;
    fi
  done
  if [[ $flag -eq 1 ]]; then
    break;
  fi
done          
if [[ $flag -eq 0 ]]; then
  if [[ ${#pass} -ge 8 && "$pass" == *[0-9]* && "$pass" == *[@#$]* ]]; then
    echo "Password Accepted"
  elif [ ${#pass} -lt 8 ] ; then        
      echo "Weak Password: Minimum length must be 8"
  elif [ `echo $pass | grep -Ec "[0-9]+"` -eq 0 ] ; then
      echo "Weak Password: Minimum one digit required"       
  elif [ `echo $pass | grep -Ec "[@#$%&*=+-]+"` -eq 0 ] ; then
      echo "Weak Password : Minimum one Special character required"
  fi
fi
         
        