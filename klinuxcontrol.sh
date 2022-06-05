#!/usr/bin/bash
#
# Autor: Isaias Barbosa
# Mantenedor : Isaias Barbosa
#
#  Versão: v1.0
#
#  klinuxcontrol.sh - Script para obter kernel linux via terminal.
#
#  Descrição: O script representa um front-end para as versões linux oficiais
#  disponibilizadas por Linus Trovalds. Permitirá acompanhar novas versões e obte-las caso queira.
#
#  Testado: /bin/bash e lynx
#
# Variaveis
RELEASE_PRINCIPAL='releases.txt'
R="\033[31m"     #EX echo -e "${RED}" "STRING "
G="\033[32m"
NC="\033[0m"




#  Validação:
 [ ! -x "$(which lynx)" ] && sudo apt install lynx -y  # validação para instalar o lynx

 # Execução:  pagina https://www.kernel.org/
 lynx -source https://www.kernel.org/ | grep strong | sed 's/<td>//;s/<strong>//;s/<\/stron.*d>//;s/<sp.*an>//;s/La.*//' > releases.txt # Modificar este filtro para minhas  buscas.


# while, ler o arquivo titulos.txt=$ARQUIVO_TITULOS em quanto houver o que ler.
while read -r versoes_kernel
do
	echo -e "${G}Versão: ${R}$versoes_kernel ${NC}"  # print das versões
done < "$RELEASE_PRINCIPAL"

sleep 1

echo -e "Deseja baixar uma das versões a cima: (y/n)"
read UP

case "$UP" in
y) if [  -x "$(which wget)" ]; then
                               sleep 1
                               echo -e "Qual versão? (Digite como mostrado no menu. ex: 4.4.39 )"
                               read VERSAO
                               sleep 1
                               echo -e "OK, baixando..."
                               wget --show-progress https://git.kernel.org/torvalds/t/linux-$VERSAO.tar.gz
   fi                                   ;;
n) echo -e "Ok, saindo..."              ;;
*) echo -e "Escolha uma opção valida! " ;;
esac
