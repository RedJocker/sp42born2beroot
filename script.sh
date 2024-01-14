#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: maurodri <maurodri@student.42sp...>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 22:11:06 by maurodri          #+#    #+#              #
#    Updated: 2024/01/16 21:43:38 by maurodri         ###   ########.fr        #
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
    # basing number on number on unique cores-socket pair
    # based on reading
    # https://www.howtogeek.com/194756/cpu-basics-multiple-cpus-cores-and-hyper-threading-explained/
    echo -e "CPU physical:"\
	 "$(lscpu -e=core,socket | sort -u | grep [0-9] -c)"
}

log_num_logical_processors() {
    echo -e "vCPU:"\
	 "$(lscpu -e=cpu | grep [0-9] -c)"
}

log_memory_ram_usage() {
    # reference https://vitux.com/how-to-check-installed-ram-on-debian/
    free --mega \
	| awk '/Mem/ { total=$2; used=$3; percent=used/total*100 }
	       END { printf "Memory usage: %s/%s (%.2f%%)\n",
	       	     	    	    	   used, total, percent }'
}

log_hard_disk_usage() {
    # reference https://www.tomshardware.com/how-to/check-disk-usage-linux
    df --total --block-size=GB \
	| awk '/total/ {
	           gsub(/GB/, "", $3);
	  	   total=$2; used=$3; percent=$5
	       }
	       END {
	           printf "Disk Usage: %s/%s (%s)\n",
		   	  used, total, percent
	       }'
}

log_cpu_load() {
    top -b -n1 \
      | awk 'NR==3 {
	       printf "CPU load: %.2f%%\n", 100-$8
	     }'\
      | tr , .
}

log_system_boot() {
	# reference
	# https://www.cyberciti.biz/tips/linux-last-reboot-time-and-date-find-out.html
	who -b \
		| awk '{ print "Last boot:",$3,$4}'
}

log_lvm_usage() {
	local is_lvm_used=''
	if [[ $(lsblk --list --output type | grep -c lvm) -gt 0 ]]; then
		is_lvm_used='yes'
	else
		is_lvm_used='no'
	fi
	echo "LVM use: $is_lvm_used"
}

log_tcp_connections() {
	echo "Connections TCP : $(ss -t | grep -c 'ESTAB') ESTABLISHED"
}

log_active_users() {
	echo "User log: $(w --no-header | cut -d ' ' -f 1 | sort -u | wc -l)"
}

log_architecture
log_num_physical_processors
log_num_logical_processors
log_memory_ram_usage
log_hard_disk_usage
log_cpu_load
log_system_boot
log_lvm_usage
log_tcp_connections
log_active_users
