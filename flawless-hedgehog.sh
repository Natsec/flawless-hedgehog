#!/usr/bin/env bash

conf=/etc/php5/apache2/php.ini


cp $conf ${conf}.hedgehog_backup

echo 'ServerTokens Prod' >> $conf
echo 'ServerSignature Off' >> $conf











grep 'timezone =' $conf
echo "est maintenant"
sed -i 's/^;\(date.timezone =\)[.]*/\1 Europe\/Paris/g' $conf
grep 'timezone =' $conf

service apache2 reload
