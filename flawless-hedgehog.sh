#!/usr/bin/env bash

conf=/etc/apache2/apache2.conf

clear
echo "[info] Making a backup of your configuration file as ???"
cp $conf ${conf}.before_launching_flawless-hedgehog

echo -e "\n##################################################" >> $conf
echo -e "# Security directives added by flawless-hedgehog" >> $conf
echo -e "##################################################\n" >> $conf

echo "Setting Apache version display on Production mode"
echo 'ServerTokens Prod' >> $conf
echo "Disabling server signature on error pages"
echo 'ServerSignature Off' >> $conf






#~ grep 'timezone =' $conf
#~ echo "is now :"
#~ sed -i 's/^;\(date.timezone =\)[.]*/\1 Europe\/Paris/g' $conf
#~ grep 'timezone =' $conf

service apache2 reload
