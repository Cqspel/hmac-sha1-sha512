#!/bin/bash

CPUC=$2
if [ -z $CPUC ]; then
	CPUC=`nproc --all`
	CPUC=$(($CPUC + 1))
fi

DOCLEAN=$1

if [ -z $DOCLEAN ]; then
        DOCLEAN=0
else
	DOCLEAN=1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	CURRDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
CURRDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo "##############################################"
echo "################  Build bins:  ###############"
echo ' _______  _______  _        _______  _______  _______  _______ '
echo '(  ____ )(  ____ \( \      (  ____ \(  ___  )(  ____ \(  ____ \'
echo '| (    )|| (    \/| (      | (    \/| (   ) || (    \/| (    \/'
echo '| (____)|| (__    | |      | (__    | (___) || (_____ | (__    '
echo '|     __)|  __)   | |      |  __)   |  ___  |(_____  )|  __)   '
echo '| (\ (   | (      | |      | (      | (   ) |      ) || (      '
echo '| ) \ \__| (____/\| (____/\| (____/\| )   ( |/\____) || (____/\'
echo '|/   \__/(_______/(_______/(_______/|/     \|\_______)(_______/'
echo "##############################################"
if [ "$DOCLEAN" == "1" ]; then
	cd ${CURRDIR}/../Release/ && make clean
fi
cd ${CURRDIR}/../Release/ && make all -j $CPUC
echo "###############i# END ########################"
echo ""
echo "##############################################"
echo "################  Build bins:  ###############"
echo ' ______   _______  ______            _______ '
echo '(  __  \ (  ____ \(  ___ \ |\     /|(  ____ \'
echo '| (  \  )| (    \/| (   ) )| )   ( || (    \/'
echo '| |   ) || (__    | (__/ / | |   | || |      '
echo '| |   | ||  __)   |  __ (  | |   | || | ____ '
echo '| |   ) || (      | (  \ \ | |   | || | \_  )'
echo '| (__/  )| (____/\| )___) )| (___) || (___) |'
echo '(______/ (_______/|/ \___/ (_______)(_______)'
echo "##############################################"
if [ "$DOCLEAN" == "1" ]; then
        cd ${CURRDIR}/../Debug/ && make clean
fi
cd ${CURRDIR}/../Debug/ && make all -j $CPUC
echo "###############i# END ########################"
echo ""
echo "Done"
