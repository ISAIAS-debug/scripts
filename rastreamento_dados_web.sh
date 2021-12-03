#!/bin/usr/env bash
#
#  
# 1. identificando padrão no HTML
# 2. Criar script considerando o padrão das tags HTML
# 3. instale  e verifique o lynx :
#          apt install lynx   ; wich linyx
# 4. Verificando a pagina web com o Lynx:
#          lynx -source http://pagina.com
# 5. filtra os padrões encontrados com lynx e grep  :
#           lynx -source http://pagina.com | grep "expressão" > arquivo.txt
#           tail -n 1 arquivo.txt | sed 's/<div.*line">//'; 's/<\/span.*//'   ;= substitui a repetição do sed
#
#
# Variaveis
ARQUIVO_TITULOS='titulos.txt'
R="\033[31m"     #EX echo -e "${RED}" "STRING "
G="\033[32m"
NC="\033[0m"




#  Validação:
 [ ! -x "$(which lynx)" ] && sudo apt install lynx -y  # validando o lynx

 # Execução:  Utilizando a pagina do lxer como exemplo
 lynx -source http://lxer.com/ | grep blutb | sed 's/<div.*line">//;s/<\/sapm.*//' > titulos.txt # Modificar este filtro para minhas  buscas.


# while, ler o arquivo titulos.txt=$ARQUIVO_TITULOS em quanto houver o que ler.
while read -r titulo_pagina
do
	echo -e "${R}Titulo: ${g}$titulo_pagina"  # Todos os titulos gravados em titulo pagina seram printados
done < "$ARQUIVO_TITULOS"
