#!/bin/bash
#Wordpress Theme Downloader
#Larry W. Cashdollar, @_larry0
#Usage ./wpd.sh pagenumber searchstring
#The search page lets you search on a single character
# for x in `seq 1 140`; do ./wpd.sh $x a ; done

USERAGENT="\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.101 Safari/537.36\""

for x in `curl -sk -A $USERAGENT "https://wordpress.org/themes/search.php?page=$1&q=$2" |egrep "href=\"/themes/[a-z]*|-\"" |awk -F\" '{print $2}' | sort -u | tail -n 8 | awk '{print "https://wordpress.org"$1}'` ; do
        curl -sk -A $USERAGENT "$x" |grep "Download Version"| sed -e "s/<p class\=\"button\"><a href='\///"|sed -e "s/'>Download Version//" | awk '{print "https:/"$1}' | xargs wget -nc
done
