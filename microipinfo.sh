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
	
	\r[+] Encerrando serviços, Aguarde...\n" | pv -qL 70
  	
	# Exibe mensagem de agradecimento e finaliza o script
	
	printf "%s\n\r[+] Obrigado por usar este programa  =).
	
	\r[+] Microjus_By_DarkShell. $fechar_cor " | pv -qL 70
	
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
    
    echo "====================================="
    echo -e "|          IP Information           |"
    echo "====================================="
    echo -e "\nIP          : $query"
    echo "Status      : $status"
    echo "Region      : $region"
    echo "Country     : $country"
    echo "Date & Time : $datetime"
    echo "City        : $city"
    echo "ISP         : $isp"
    echo "Lat,Lon     : $lat,$lon"
    echo "ZIPCODE     : $zip"
    echo "TimeZone    : $timezone"
    echo "AS          : $as"
   
    echo -e "\nPressione ENTER Para Continuar"
    
    read -p "[+] Insira o IP: " vpp
    
    if [ -z "$vpp" ]; then
    
        clear
        
        main
        
    else
    
        clear
        
        main
    fi
}

pular_linhas() {

    local linhas=$1
    for (( i = 0; i < linhas; i++ )); do
        echo
    done
    
}

about() {

    insigna
    
    printf "
    
-----------------------------------------------

[+] Nome da ferramenta   : MicroIpinfo

[+] Ultima atualizacao   : 26/02/2024

[+] Autor                : Microjus

[+] Github               : Microjus

-----------------------------------------------$(pular_linhas 3)"

}



	read -p "[+] Pressione Enter Para Continuar [+]" magas
    
	if [ -z "$magas" ]; then

        clear
        
        
        main
    else
    
        clear
        
        main
    fi
}


main() {

    insigna    
    
    echo " "
    echo "[ 1 ] Scan IP Address"
    echo "[ 2 ] About This Tool"
    echo "[ 0 ] Exit"
    echo "     "
    read -p "[+] Escolha Uma Opcao: " option
    case $option in
        1) clear; ipinfo; exit ;;
        0) clear; encerrar; exit ;;
        2) clear; about; exit ;;
        *) clear; echo "Enter Correct Number!!!"; sleep 2; clear; main ;;
    esac
    
}

main

