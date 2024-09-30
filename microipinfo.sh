#!/usr/bin/env bash

# Autor: Microjus - Dark-Shell 
# Criaçao: 25/02/2024
# Este script usa a api do ip info
# Changelog: Ultima atualização - 26/02/2024 18:47pm

#------------------------------------------------------------------------------|

# Função para lidar com o sinal INT (geralmente enviado quando o usuário pressiona Ctrl+C)
trap encerrar INT

# Função para verificar e instalar dependências necessárias
verificar_dependencias() {

	# Verifica se o comando jq está disponível
	if ! command -v jq &>/dev/null; then
	clear ; read -p "O comando 'jq' não está instalado.
Deseja instalá-lo agora? (s/n): " instalar_jq
 
	if [ "$instalar_jq" = "s" ]; then
	# Comando para instalar o jq, você pode modificar de acordo com a sua distribuição
	apt install jq -y # Exemplo para distribuições baseadas em Debian/Ubuntu
	# Se sua distribuição for diferente, substitua o comando acima pelo comando de instalação apropriado
 
	else
 
	printf "Certifique-se de instalar o 'jq' manualmente para usar este script.\n"
 
	fi
 
	fi
 
	# Verifica se o comando pv está disponível
	if ! command -v pv &>/dev/null; then
	clear ; read -p "O comando 'tput' não está instalado. 
Deseja instalá-lo agora? (s/n): " instalar_pv
	if [ "$instalar_pv" = "s" ]; then
 
	# Comando para instalar o pv, você pode modificar de acordo com a sua distribuição
	 apt install pv -y # Exemplo para distribuições baseadas em Debian/Ubuntu
	# Se sua distribuição for diferente, substitua o comando acima pelo comando de instalação apropriado
 
	else
 
	printf "Certifique-se de instalar o 'pv' manualmente para usar este script.\n"
	fi
 
	fi

        # Verifica se o comando tput está disponível
	if ! command -v tput &>/dev/null; then
	clear ; read -p "O comando 'tput' não está instalado. 
Deseja instalá-lo agora? (s/n): " instalar_tput
	if [ "$instalar_tput" = "s" ]; then
 
	# Comando para instalar o tput, você pode modificar de acordo com a sua distribuição
	 pkg install ncurses-utils -y # Exemplo para distribuições baseadas em Debian/Ubuntu
	# Se sua distribuição for diferente, substitua o comando acima pelo comando de instalação apropriado
 
	else
 
	printf "Certifique-se de instalar o 'tput' manualmente para usar este script.\n"
	fi
 
	fi
 
 	_init_program
}

# Função de monitoramento em tempo real
monitorar() {

insigna
while true
do
    # Capturar o IP interno
    IP_REAL=$(hostname -I | awk '{print $1}')
    
    # Capturar o IP público usando ipinfo.io
    IP_PUBLICO=$(curl -s ipinfo.io/ip)
    
    # Exibir IP real e IP público
    echo "IP Real: $IP_REAL"
    echo "IP Público (VPN/Internet): $IP_PUBLICO"
    
    # Esperar 10 segundos
    sleep 10 ; clear
done

}

# Função para encerrar o script
encerrar() {

        # Exibe mensagem de saida
	printf "%s\r\033c${cor_amarela}[+] Detectando Tentativa de saida...
	
	\r[+] Encerrando serviços, Aguarde...\n" | pv -qL 100
  	
	# Exibe mensagem de agradecimento e finaliza o script
	printf "%s\n\r[+] Obrigado por usar este programa  =).
	
	\r[+] Microjus_By_DarkShell. $fechar_cor \n" | pv -qL 100
	
	exit 0
	
}

# Função para exibir a logomarca do programa
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

# Função principal para obter informações do IP
ipinfo() {

	read -p "Insira o Endereço Ip: " ip
    
	url="http://ip-api.com/json/$ip"
	response=$(curl -s $url)

	# Extrai informações do JSON retornado pela API
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
  
	# Exibe as informações do IP formatadas
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

# Pausa e aguarda o usuário pressionar ENTER para continuar
read -p "

Pressione ENTER Para Continuar" ip

    	# Verifica se o usuário pressionou ENTER e retorna ao menu principal
	if [ -z "$vip" ]; then
    
	clear
        
	_init_program
        
	else
    
	clear
        
	_init_program

	fi

}

# Função para exibir informações sobre o programa
sobre() {

	insigna    
	
    	tput civis ; read -s -p "
    
-----------------------------------------------

[+] Nome da ferramenta   : MicroIpinfo

[+] Ultima atualizacao   : 26/02/2024

[+] Autor                : Microjus

[+] Github               : Microjus

-----------------------------------------------

[+] Pressione Enter Para Continuar [+]"
 
_init_program
	
}


_init_program() {

	insigna    
	
    	tput civis ; read -s -p "

[ 1 ] Capturar informacoes do ip
[ 2 ] Sobre a ferramenta
[ 3 ] Monitoramento em tempo real
[ 0 ] Sair
	
[+] Selecione uma opcao:" -n1 _OPC 

	case $_OPC in

	1) clear; 

		ipinfo; exit ;;

	0) clear; 
	
		encerrar; exit ;;

	2) clear; 
	
		sobre; exit ;;

  	3) monitorar;

     		monitorar; exit ;;

	*)
	
	{ tput flash ; clear ; printf "E: Opçao invalida." ; sleep 1s ; _init_program ; } # Retorno de opçoes invalidas
	;;

	esac
    
}

verificar_dependencias

