#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maurodri <maurodri@student.42sp...>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 22:11:06 by maurodri          #+#    #+#              #
#    Updated: 2024/01/14 23:14:40 by maurodri         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

log_partitions() {
	lsblk
}

enter_virtual_machine() {
	# run on virtual machine to get ip
	#ip=$(hostname -I)
	# run on guest machine replacing ip with ip from virtual machine
	#ssh maurodri@$ip -p 4242
	echo ""
}

firewall_setting() {
	## install firewall
	#sudo apt install ufw
	## enable firewall
	#sudo ufw enable
	## open 4224 port
	#sudo ufw allow 4242
	echo ""
}

log_architecture() {
	echo -e "Architecture: $(uname -a)"
}

log_num_physical_processors() {
	echo -e "CPU physical: $(lscpu -e=socket | awk '$1 ~ /[0-9]+/ { print $1 }' | sort -u | wc -l)"
}

log_num_logical_processors() {
	echo -e $"vCPU: $(lscpu -e=cpu | awk '$1 ~ /[0-9]+/ { print $1 }' | wc -l)"
}


log_architecture
log_num_physical_processors
log_num_logical_processors



