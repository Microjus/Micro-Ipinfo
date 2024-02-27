#!/usr/bin/env bash

# Autor: Microjus - Dark-Shell 
# Criaçao: 25/02/2024
# Este script usa a api do ip info
# Changelog: Ultima atualização - 26/02/2024 18:47pm

#------------------------------------------------------------------------------|

trap encerrar INT

encerrar() {

        # Exibe mensagem de saida
	
	printf "%s\r\033c${cor_amarela}[+] Detectando Tentativa de saida...
	
	\r[+] Encerrando serviços, Aguarde...\n" | pv -qL 100
  	
	# Exibe mensagem de agradecimento e finaliza o script
	
	printf "%s\n\r[+] Obrigado por usar este programa  =).
	
	\r[+] Microjus_By_DarkShell. $fechar_cor " | pv -qL 100
	
	exit 0
	
}

insigna() {

	printf "\033c
 __  __ _               ___       _        __       
|  \/  (_) ___ _ __ ___|_ _|_ __ (_)_ __  / _| ___  
| |\/| | |/ __| '__/ _ \| || '_ \| | '_ \| |_ / _ \ 
| |  | | | (__| | | (_) | || |_) | | | | |  _| (_) |
|_|  |_|_|\___|_|  \___/___| .__/|_|_| |_|_|  \___/ 
                           |_|                      
"

}

ipinfo() {

	read -p "Insira o Endereço Ip: " ip
    
	url="http://ip-api.com/json/$ip"
	response=$(curl -s $url)

	query=$(echo $response | jq -r '.query')
	status=$(echo $response | jq -r '.status')
	region=$(echo $response | jq -r '.regionName')
	country=$(echo $response | jq -r '.country')
	datetime=$(date '+%Y-%m-%d %H:%M:%S')
	city=$(echo $response | jq -r '.city')
	isp=$(echo $response | jq -r '.isp')
	lat=$(echo $response | jq -r '.lat')
	lon=$(echo $response | jq -r '.lon')
	zip=$(echo $response | jq -r '.zip')
	timezone=$(echo $response | jq -r '.timezone')
	as=$(echo $response | jq -r '.as')
  
	insigna
    
	printf "\r=====================================

		\r|          IP Information           |
	
	        \r=====================================
	
[+] IP          : $query
[+] Status      : $status
[+] Regiao      : $region
[+] Pais        : $country
[+] Data & Hora : $datetime
[+] Cidade      : $city
[+] ISP         : $isp
[+] Lat,Lon     : $lat,$lon
[+] ZIPCODE     : $zip
[+] TimeZone    : $timezone
[+] AS          : $as"

read -p "

Pressione ENTER Para Continuar" ip
    
	if [ -z "$vip" ]; then
    
	clear
        
	main
        
	else
    
	clear
        
	main

	fi

}


about() {

	insigna    
	
    	tput civis ; read -s -p "
    
-----------------------------------------------

[+] Nome da ferramenta   : MicroIpinfo

[+] Ultima atualizacao   : 26/02/2024

[+] Autor                : Microjus

[+] Github               : Microjus

-----------------------------------------------

[+] Pressione Enter Para Continuar [+]"
 
main
	
}


main() {

	insigna    
	
    	tput civis ; read -s -p "

[ 1 ] Capturar informacoes do ip
[ 2 ] Sobre a ferramenta
[ 0 ] Sair
	
[+] Selecione uma opcao:" -n1 _OPC 

	case $_OPC in

	1) clear; 

		ipinfo; exit ;;

	0) clear; 
	
		encerrar; exit ;;

	2) clear; 
	
		about; exit ;;

	*)
	
	{ tput flash ; clear ; printf "E: Opçao invalida." ; sleep 1s ; _init_program ; } # Retorno de opçoes invalidas
	;;

	esac
    
}

main

