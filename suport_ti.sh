#!/usr/bin/env bash
#
# Autor :      Isaias Barbosa
# Mantenedor : Isaias Barbosa
#
#
# suport_ti.sh - Gerencia diversos aspectos do Sistema.
# Versão: v1.1
#
# Descrição: Este script tem o objetivo de ajudar os técnicos de suporte linux
# a solucionar diversos problemas do dia-a-dia.
#
#Testeado : /bin/bash
#
# Modificações:
#  1. Novas funções criadas para o bloco da verificação --swap --saude-disco
#
#
#
#==============================================================================
# VARIAVÉIS

MENU_VAR="$(basename $0)  +  [OPÇÕES]:
-h - Ajuda, todas as OPÇÕES.
-u - Bloquear as portas USB.
-c - Bloquear os dispostivos ISO 9660 (CD-ROM).
-n - Informações  do PC (Sistema operacional, Nome,   Endereços de rede, etc...).
-v - Versão do script
-s - Realizar uma verificação de hosts ativos em determinado Bloco de IPs.
-z - Procurar chave Zimbra no Computador.
-d - Reconfiguração do Dominio( Você precisara deixar o ip do SRV ARQ no DNS antes deste procedimento)
--disco-saude -  Verificar a saude de uma disco ou partição.
--swap - Para realizar alterações no uso de swap. Reduzila para menos de 60 o PC deve possui 4 gb de RAM.
Execute o codigo novamente com uma das opções.
"
VERSAO_VAR="v1.0"
CHAVE_H=0
CHAVE_U=0
CHAVE_C=0
CHAVE_N=0
CHAVE_V=0
CHAVE_S=0
CHAVE_Z=0
CHAVE_D=0
CHAVE_SAUDE=0
CHAVE_SWAP=0
R="\033[31m"     #EX echo -e "${RED}" "STRING "
G="\033[32m"
NC="\033[0m"

#================================================================================
#FUNÇÕES
#Deleta arquivo de ping
delping() {
	if [ -f /home/ping-$(date -I).txt ]; then
		rm /home/ping-$(date -I).txt
	else
		echo "Não existe arquivo de log ping anterior, continuando..."
		sleep 1
	fi
}

#Verifica saude do disco
saudedisco() {
	echo -e "${G} Lista de discos SATA ou USB. ${NC} "
	df -lh | grep  .*sd
	echo " Verificar qual disco? , coloque ex: dev/sda?"
	read SMART
	smartctl -H "$SMART"
	echo " Deseja obter informações sobre o disco ?(y,n)"
	read DISCO
	case $DISCO in
		y) smartctl -i "$SMART"                ;;
		n) echo "Saindo ..."                  ;;
		*) echo "Escolha uma opção padrao..." ;;
	esac
}

#Configura swappiness
confswap() {
echo -e "${G} Vale lembrar que para diminuir este valor é preciso no minimo 4 gb de RAM ${NC}"
echo "Valor da prioridade de swap/virtual atual :"
sysctl vm.swappiness
sleep 1
echo "Informações da memoria RAM e virtual: "
free -h
echo " Digite um novo valor, caso queira alterar a prioridade :"
read SWAP
		if [ $SWAP > 0 ]; then
				sysctl -w vm.swappiness=$SWAP
				echo $SWAP >> /proc/sys/vm/swappiness
				sleep 1
				echo -e "${G}Valores alterados para agora e a proxima inicialização... ${NC}"
		elif [ -z $SWAP  ]; then
				echo "OK, nada sera feito"
				sleep 1
		fi
	}


#================================================================================

#Estrutura
#Case:

case "$1" in
	-h) CHAVE_H=1      ;;                                           # exit 0 ;; - Para finalizar e sair do script
	-u) CHAVE_U=1      ;;
	-c) CHAVE_C=1      ;;
	-n) CHAVE_N=1      ;;
	-v) CHAVE_V=1      ;;
	-s) CHAVE_S=1      ;;
	-z) CHAVE_Z=1      ;;
	-d) CHAVE_D=1      ;;
	--disco-saude) CHAVE_SAUDE=1 ;;
	--swap) CHAVE_SWAP=1 ;;
	 *) echo "$MENU_VAR" ;;
esac
# Continuar colocando os valores para cada chave


#Chaves e validação:

# Retorna o MENU.
[ $CHAVE_H -eq 1 ] && echo "$MENU_VAR"

# Bloqueia o uso dispositivos de armazenamento USB
[ $CHAVE_U -eq 1 ] && if [ -d /media ]; then
										      chmod -R 700 /media
													chmod -R 700 /mnt
													sleep 1
												  echo   "Permissões de uso retiradas dos pontos de montagem, aguarde,
					 		             Bloqueando os modulos das portas USB..."
													sleep 1
													echo "blacklist uas" >>          /etc/modprobe.d/blacklist.conf
													sleep 1
													echo "blacklist usb_storage" >>  /etc/modprobe.d/blacklist.conf
													sleep 1
        	                echo    "Modulos removidos!"
											fi

# Bloqueia os dispositivos CD-ROM, ISO-9660
[ $CHAVE_C -eq 1 ] && if [ -f /etc/fstab ]; then
									echo    "Retirando permissões de uso do CD-ROM"
									sleep 1
								  echo "/dev/sr0        /media    udf,iso9660     root,noauto     0       0" >> /etc/fstab
        	        sleep 1
        	        echo "Permissões retiradas"
								      fi

# Mostra informações uteis do PC
[ $CHAVE_N -eq 1 ] && echo -e  "Nome do Computador:
$(cat /etc/hostname)
${G}IP${NC}:
$(hostname -I)
${G}MAC${NC}:
$(ip link show | grep ether| cut -d r  -f 2)
${G}Nome do Dominio${NC}:
$(hostname -d)
${G}Nome do PC FQDN:${NC}
$(hostname -f)
$(exit 0)
														"
# Mostra a versão do codigo
[ $CHAVE_V -eq 1 ] && echo $VERSAO_VAR

# Faz uma verificação de hosts ativos na REDE e retorna a quantidade por SO(WIN ou LINUX)
[ $CHAVE_S -eq 1 ] &&	if [ -d / ]; then
	if [ -d /etc/network ]; then
												delping
												echo " Quantos ip deseja verificar ? "
												read ip
												sleep 1
												echo " Determine o ip de inicio? "
												read IP_1
												sleep 1
												echo " Determine o endereço ip final? "
												read IP_2
												sleep 1
												echo " Determine a faixa de IP, ex 192.168.0. (digite ate o ponto): "
												read REDE
												echo " O termino deste comando pode demorar um pouco, aguarde..."
														for ip in $(seq $IP_1 $IP_2);do
																			ping -c1 $REDE$ip >> /home/ping-$(date -I).txt
																			RESULT=/home/ping-$(date -I).txt
														done

																			if [ -f $RESULT ]; then
																					echo -e  " Temos ${G}$(cat $RESULT | grep -c ttl=128 )${NC} computadores WINDOWS ativos. "
																					echo  -e " Temos ${G}$(cat $RESULT | grep -c ttl=64 )${NC} computadores LINUX ativos."
																					echo -e  " Temos ${G}$(cat $RESULT | grep -c ttl=255)${NC} impressoras ativas. "
																					echo -e  " ${G} Deseja verificar quais PC responderam ao ping(y/n)   ?${NC} "
																					read PING
																					  			case $PING in
																										y) cat $RESULT | grep "64 bytes" | less                   ;;
																										n) echo " OK, nada será feito..."               && exit 0 ;;
																										*) echo " Digite um valor valido "              && exit 0 ;;
																									esac
																			fi
	fi
                      fi

# Procura pelo arquivo de backup zimbra do google Authenticator.
[ $CHAVE_Z -eq 1 ] && find /home  | grep authenticator.txt

# Prepara a maquina para que seja colocada no Dominio.
[ $CHAVE_D -eq 1 ] &&  if [ -f /etc/krb.* ];then
												rm -R /etc/krb*
												sleep 1
												echo "Registros de dominio deletados..."
												sleep 1
												echo " Abrindo janela para colocar o PC no dominio..."
												sleep 1
												# exec NOME_CAMINHO_SCRIPT.py
											else
												echo " Arquivos do kerberos não existem. "
												sleep 1
												# exec NOME_CAMINHO_SCRIPT.py
											fi

# Verifica a saúde de um disco ou partição.
[ $CHAVE_SAUDE -eq 1 ] && if [ -x $(which smartctl) ];then
															saudedisco
													else
															sleep 1
															echo "Instalando... SMARTD"
															apt install smartmontools
															sleep 1
															echo "SMARTD instalado para verificar o disco."
															sleep 1
															saudedisco
													fi

# Faz a configuração da prioridade do uso de memoria virtual.
[ $CHAVE_SWAP -eq 1 ] && if [  -x $(which sysctl) ]; then
														confswap
			 									else
														 echo -e "Instalando o gerenciador de recursos sysctl..."
														 sleep 1
														 apt install procps
														 echo -e " Sysctl instalado, continuando..."
														 sleep 1
														 confswap
			fi
