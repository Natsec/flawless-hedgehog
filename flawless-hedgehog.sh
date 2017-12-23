#!/usr/bin/env bash

if [ $(id -u) != '0' ]
then
	echo "You should execute me as root, or better, with sudo"
	exit 1
fi

clear
config=/etc/apache2/apache2.conf
backup=${config}.before_launching_flawless-hedgehog
echo -e "[info] Making a backup of your configuration file as '${backup}'\n"
cp $config $backup


echo '          .:::::::::.   '
echo '         :::::::::::::  '
echo '        /. `::::::::::: '
echo '       o__,_::::::::::° '


echo -e "\n# Security directives added by flawless-hedgehog.sh on $(date)" >> $config


echo -e "\n"
echo " Information leakage"
echo "##################################################"

# hide version in HTTP header
read -p $'\n'"Hide Apache version in HTTP response header ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p "Hide Apache version in HTTP header ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Hidding Apache version in HTTP response header: Directive 'ServerTokens' set to Production mode"
	echo 'ServerTokens Prod' >> $config
fi

# server signature
read -p $'\n'"Disable server signature on error pages ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p $'\n'"Disable server signature on error pages ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling server signature on error pages: Directive 'ServerSignature' set to off"
	echo 'ServerSignature Off' >> $config
fi

# etag
read -p $'\n'"Disable Etag header ? (a remote attacker could obtain informations on your system). (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p $'\n'"Disable Etag header ? (a remote attacker could obtain informations on your system). (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling Etag response header: Directive 'FileETag' set to None"
	echo 'FileETag None' >> $config
fi


echo -e "\n"
echo " Exploration"
echo "##################################################"

# directory listing
read -p $'\n'"Disable directory listing ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p $'\n'"Disable directory listing ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling directory listing: Removed parameter 'Indexes' from directive 'Options' for all directories"
	sed -i 's/ Indexes//g' $config
fi








echo -e "\n[info] Restarting Apache server ...\n"
service apache2 restart
service apache2 status

clear
echo -e "Little hedgehog fluffed his spikes, your Apache configuration now has a first minimal layer of security !\n"

echo '          ./////////.   '
echo '         /////////////  '
echo '        /. `/////////// '
echo '       o__,_//////////° '

echo -e "\nIf you feel like I messed up your configuration, don't panic and run :"
echo -e "sudo cp $backup $config"
echo -e "\nRegards (^~^)"
