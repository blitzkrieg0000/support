#!/bin/bash

out="host-info.txt"
mac_cmds="sw_vers,cat /etc/hosts,ifconfig -v,netstat -nr,scutil --dns,ps -A,ls /Library/LaunchDaemons,ls /System/Library/LaunchDaemons,ls /Library/LaunchAgents,ls /System/Library/LaunchAgents,ls ~/Library/LaunchAgents"
linux_cmds="cat /etc/hosts,ip addr show,ip link show,resolvectl status --no-pager,cat /etc/resolv.conf,hostnamectl"
IFS=,

plat="$(uname -s)"
case "${plat}" in
	Linux*)		cmds=${linux_cmds};;
	Darwin*)	cmds=${mac_cmds};;
	*)		echo "Unrecognized platform"
esac

if [ -z cmds ]
then
	exit 0
else
	date > "${out}"
	echo >> "${out}"
	for i in ${cmds}
	do
		echo "Running ${i}"
		eval ${i} >> "${out}"
		printf '\n==========\n\n' >> "${out}"
	done
fi
