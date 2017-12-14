#!/usr/bin/env bash

if [ $(id -u) != '0' ]
then
	echo "You should execute me as root, or better, with sudo"
	exit 1
fi


config=/etc/apache2/apache2.conf
backup=${config}.before_launching_flawless-hedgehog


clear
echo -e "[info] Making a backup of your configuration file as '${backup}'\n"
cp $config $backup


echo '          .:::::::::.   '
echo '         :::::::::::::  '
echo '        /. `::::::::::: '
echo '       o__,_::::::::::° '


echo -e "\n##################################################" >> $config
echo -e "# Security directives added by flawless-hedgehog" >> $config
echo -e "##################################################\n" >> $config



########################################
# hide version in HTTP header
########################################
read -p $'\n'"Do you want to hide Apache version in HTTP response header ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p "Do you want to hide Apache version in HTTP header ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Hidding Apache version in HTTP response header: Directive 'ServerTokens' set on Production mode"
	echo 'ServerTokens Prod' >> $config
fi

########################################
# server signature
########################################
read -p $'\n'"Do you want to disable server signature on error pages ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p $'\n'"Do you want to disable server signature on error pages ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling server signature on error pages: Directive 'ServerSignature' set to off"
	echo 'ServerSignature Off' >> $config
fi

########################################
# Etag
########################################
echo "Disabling Etag (could allow remote attacker to obtain informations on system): Directive 'FileETag' set to None"
echo 'FileETag None' >> $config

########################################
# directory listing
########################################
read -p $'\n'"Disable directory listing ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p $'\n'"Disable directory listing ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling directory listing: Added '-Indexes' to directive 'Options' for all directories"
	# if no 'indexes':
	sed -i sed -i 's/[.]*Options[.]*/-Indexes/g' $config
	# if grep 'indexes':
	# ajouter '-'
fi









service apache2 reload

echo -e "\nIf you feel like I messed up your configuration, don't panic and run :"
echo "sudo cp $backup $config"
echo "Regards (^~^)"
