#!/bin/bash

#This script must be executed on the target server as root.

#Configure iptables service to automatically start on reboot
chkconfig --level 235 iptables on

# Flush all current rules from iptables
iptables -F

# GROUND RULES: Allow established TCP traffic 
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT

# ALLOW: ssh, smtp, http, https, pings, local traffic
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT


# REJECT: anything that wasn't explicitly allowed
iptables -A INPUT -j REJECT
iptables -A FORWARD -j REJECT

# Save rules so they'll be used after reboots. Command changed to this with Fedora 17
/usr/libexec/iptables.init save 