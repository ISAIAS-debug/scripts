
- Script bash para descobrir hosts ativos com Netenum na rede e fazer varredura com Nmap:




#!/bin/bash

echo "Qual rede deseja scanear ?"
read ip
netenum  $ip 3 1 >  host1 |  tail -n +2  host1

while read line;
do nmap -A -T 4 -sS -O -sV -PN  $line;
done < host1
