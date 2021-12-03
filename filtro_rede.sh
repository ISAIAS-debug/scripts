#!/usr/bin/env bash
#
# filtro_rede.sh - script para investigar hosts ativos
#
#  Autor - Isaias Barbosa
#
#  v1.0 - 16/11/2020
#     Criado o script
#
#  Agradecimentos - Turma I de Defesa Cibernetica Marinha do Brasil
#
# Testado:
#    Bash 5.0.17   Kali linux
#
# Descrição :
#    O script coloca os hosts ativos de determinada rede em um arquivo que será usado pelo nmap para investigação profunda.
#


echo "Qual rede deseja scanear ?"
read ip
netenum  $ip 3 1 >  host1 |  tail -n +2  host1

while read line;
  do nmap -A -T 4 -sS -O -sV -PN  $line;
done < host1
