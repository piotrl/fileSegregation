#!/bin/bash

# generating directories by cretion date of files
function generate_dir {
	dir=$1
	if [ $# -ge 2 ]; then
		new_dir=$2
	else
		new_dir='cache'
	fi

	mkdir $new_dir
	cd $dir


	for file in *
	do
		cdate_year=`date +%Y -r $file`
		#f_name=`date +%d/%m -r $file`

		if [ -d ../$new_dir/$cdate_year ]; then
			cp $file ../$new_dir/$cdate_year
		else
			mkdir ../$new_dir/$cdate_year/
			cp $file ../$new_dir/$cdate_year/
		fi
	done
}

# error handling
function error {
	code=$1

	case $code in
		0) 	echo $0': brak argumentow.'
			echo 'Poprawna skladnia: `fseg.sh [KATALOG_ZRODLO] [KATALOG_DOCELOWY]`'
			;;
		1) 	echo $0': blad nr 1';; # for the future!
		*) 	echo 'We like trains';;
	esac
}

# *
# * main()
# * ------------------------------------------
# *

if [ $# -eq 0 ]; then
	error 0
else
	generate_dir $1 $2
fi
