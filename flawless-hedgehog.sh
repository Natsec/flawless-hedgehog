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


read -p $'\n'"Do you want to disable server signature on error pages ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p "Do you want to hide Apache version in HTTP header ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Disabling server signature on error pages: Directive 'ServerSignature' set to off"
	echo 'ServerSignature Off' >> $config
fi









#~ grep 'timezone =' $conf
#~ echo "is now :"
#~ sed -i 's/^;\(date.timezone =\)[.]*/\1 Europe\/Paris/g' $conf
#~ grep 'timezone =' $conf

service apache2 reload

echo -e "\nIf you feel like I fucked up your server, don't panic and run :"
echo "sudo cp $backup $config"
echo "Regards (^~^)"
