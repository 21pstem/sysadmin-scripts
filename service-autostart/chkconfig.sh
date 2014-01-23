#NOTE: If we update a component [mysql,firewall] via package manager to a new version, the update script may change the default startup settings.

#commands:

#chkconfig --level concat_string_of_run_levels <service_name> [on|off]

#I made the changes in run levels 2, 3 and 5

#examples

#chkconfig --level 235 httpd on
#chkconfig --level 235 iptables off

#More about Redhat run levels here: http://magazine.redhat.com/2008/06/03/run-levels-create-use-modify-and-master/

chkconfig --level 235 httpd on
chkconfig --level 235 iptables on
