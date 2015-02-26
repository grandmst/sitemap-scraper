#!/bin/sh

SITEMAP=$1

if [ "$SITEMAP" = "" ]; then
    echo "Usage: $0 http://domain.com/sitemap.xml"
        exit 1
fi

XML=`wget -O - --quiet $SITEMAP`
URLS=`echo $XML | egrep -o "<loc>[^<>]*</loc>" | sed -e 's:</*loc>::g'`
echo $URLS\n > save.txt
echo $URLS | tr ' ' '\n' | wget -O /dev/null -i - --wait=1 --random-wait -nv
