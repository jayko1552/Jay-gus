#!/bin/bash
#Autor: Fenix
#Descripción: Detecta a los hosts conectados en nuestra red
#Requiere: nmap
#
#Atención: Lo único q requiere configurar es la interfaz en donde se desea escuchar
INTER='wlan0'


function mask2bits {
        m=`ifconfig $INTER | awk '{print $4}' | grep -o -E '([0-9]{1,3}\.){3}[0-9]+' `
        nbits=0
        for i in {1..4}
        do  
                v=`echo $m | cut -d'.' -f$i`
                while [ $v -ge 1 ]; do
                        let nbits=nbits+$v%2
                        let v=v/2
                done
        done
        echo $nbits
}

#
MASK=`mask2bits`
IP=`ifconfig $INTER | grep -o -E '([0-9]{1,3}\.){3}[1-9]+' | head -1`
nmap -sP $IP/$MASK  | grep -o -E '([0-9]{1,3}\.){3}[0-9]+'