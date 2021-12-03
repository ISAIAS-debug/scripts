#!/usr/bin/env bash
if [ -d /etc/network ]; then
											echo " Quantos ip deseja verificar ? "
											read ip
											sleep 1
											echo " Determine o ip de inicio? "
											read IP_1
											sleep 1
											echo " Determine o endereço ip fina? "
											read IP_2
											sleep 1
											echo " Determine a faixa de IP, ex: "
											read REDE
											 		for ip in $(seq $IP_1 $IP_2);do
																		# rm -R /hom/ping.txt
																		ping -c1 $REDE$ip >> /home/ping.txt
													done
																    if [ -f /home/ping.txt ]; then
																				echo " Temos $(cat /home/ping.txt | grep -c tt=128 ) computadores WINDOWS" ;
																	      echo " Temos $(cat /home/ping.txt | grep -c ttl=64 ) computadores LINUX";
											 						  fi

														#echo "Existe respondendo ao ping: $WIN    computadores windows"
														#echo " Existe respondendo ao ping: $UBUNT computadores ubuntu"

											#sleep 1
											#echo " Determine o ip de inicio ? $(read IP_1)"
											#sleep 1
											#echo " Determine o ip final?  $(read IP_2)"
											#sleep 1
											#echo " Determine a faixa de IP , ex: 192.168.5 $(read REDE)"
											#	for ip in $(seq $IP_1 $IP_2);do
											#						if [ "$(ping -c4 $REDE$ip | grep ttl=128)" ]; then
											#						echo " Computador WINDOWS " WIN=WIN+1
											#						elif [ "$(ping -c4 $REDE$ip | grep ttl=64)" ]; then
											#						echo " Computador LINUX " UBUNT=UBUNT+1
											#						fi
											#				echo "Existe respondendo ao ping: $WIN computadores windows"
											#				echo " Existe respondendo ao ping $UBUNT computadores ubuntu"
											#	done
										fi
