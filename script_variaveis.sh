#!/usr/bin/env bash

VAR1="UMA STRING"
VAR_COMANDO="mostrando a prioridade de swap: $(cat /proc/sys/vm/swappiness)"

VAR_ERROR=$?
NOME_SCRIPT=$0
PID=$$


echo $VAR1
echo $VAR_COMANDO
echo $NOME_SCRIPT



## trabalhando com condicionais


var_swap=$(cat /proc/sys/vm/swappiness)

if test var_swap = 60;  then
 echo "valor de swap padrâo!"
else
  echo "valor de swap diferente do padrao"
fi



#USO DO FOR

for (( i = 0; i < 10; i++ )); do
  echo $i
done

for i in $(seq 10); do
   ping -c2 192.168.115.$i

done
