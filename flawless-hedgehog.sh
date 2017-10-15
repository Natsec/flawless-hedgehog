#!/usr/bin/env bash

config=/etc/apache2/apache2.conf
backup=${config}.before_launching_flawless-hedgehog

clear
echo "[info] Making a backup of your configuration file as '${backup}'"
cp $config $backup

echo -e "\n##################################################" >> $config
echo -e "# Security directives added by flawless-hedgehog" >> $config
echo -e "##################################################\n" >> $config

read -p $'\n'"Do you want to hide Apache version in HTTP header ? (y/n):" ans
while [ "$ans" != 'y' ] && [ "$ans" != 'n' ]
do
	read -p "Do you want to hide Apache version in HTTP header ? (y/n):" ans
done
if [ "$ans" == 'y' ]
then
	echo "Setting Apache version display on Production mode"
	echo 'ServerTokens Prod' >> $config
fi

echo "Disabling server signature on error pages"
echo 'ServerSignature Off' >> $config






#~ grep 'timezone =' $conf
#~ echo "is now :"
#~ sed -i 's/^;\(date.timezone =\)[.]*/\1 Europe\/Paris/g' $conf
#~ grep 'timezone =' $conf

service apache2 reload

echo "If you feel like I fucked up your server, don't panic and run :"
echo "sudo cp $backup $config"
echo "Regards (^~^)"
