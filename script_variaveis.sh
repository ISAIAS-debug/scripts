#!/usr/bin/env bash


# Anotações feitas apartir do conteudo de shell script avancado

VAR1="UMA STRING"
VAR_COMANDO="mostrando a prioridade de swap: $(cat /proc/sys/vm/swappiness)"

VAR_ERROR=$?
NOME_SCRIPT=$0
PID=$$


echo $VAR1
echo $VAR_COMANDO
echo $NOME_SCRIPT



# Trabalhando com condicionais


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



# Trabalhando com arquivos de configurações


# var recebendo file de conf:
ARQUIVO_CONF="configuraçao.cf"
MENSAGEM="Mensagem de teste"
CORES=
MAISCULULA=

# Validando se o arquivo existe:
[ ! -r "$ARQUIVO_CONF" ]  && echo " Arquivo de configuração não existe "

# criar a função parametro
DefinirParametro (){
 local parametro "$(echo $1 | cut -d =   -f 1)"
 local valor="$(echo $1 | cut -d = -f 2)"
 
 case "$parametro" in
  USAR
}

while read -r linha
do 
[ "$(echo -e "$linha" | cut -c1" = "#" ) ] && continue     #se for vazio continuar, pula a linha
[ ! "$linha" ]  && continue                                #pula linhas em branco
DefinirParametro "$linha"
# echo "$linha"
done < ARQUIVO_CONF

OBS: uso do cut para eliminar espaços e comentarios

#parei aqui na aula.
