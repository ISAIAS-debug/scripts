#!/usr/bin/env bash
# teste_hosts_rede.sh - Um script de status da rede
#
# Autor: Isaias Barbosa
#
# Versão:
#		v1.0 - 17/11/2020
#			Script o criado
#
# Testado :
#		Bash 5.0.17   Ubuntu - 20
# Descrição: Script para relatar o status dos hosts ativos de determinada rede.
#
#

echo " Determine a rede que deseja verificar EX: 192.168.115"
echo " Informações das suas placas de rede: "
ip addr show
echo " Escreva aqui a rede?"
read rede

	for ip in $(seq 1 254)
		do
			ping -c2 $rede.$ip >
			> testeping1.txt
		done
