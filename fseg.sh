#!/bin/bash

# generating directories by cretion date of files
function generate_dir {
	if [ $# -ge 2 ]; then
		new_dir=$2
	else
		new_dir='cache'
	fi

	mkdir $new_dir

	# $dir jest globalny, wiec przyjmuje wartosc argumentu $1 z wywolania skryptu
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
		0)	 echo $0': brak argumentow.'
			 echo 'Poprawna skladnia: `fseg.sh [KATALOG_ZRODLO] [KATALOG_DOCELOWY]`'
			 ;;
		401) echo $0': Brak dostępu do pliku '$1;;
		403) echo $0': Podany plik nie jest katalogiem';;
		404) echo $0': Podany plik '$dir' nie istnieje';;
		*) 	 echo 'We like trains';;
	esac
}

# *
# * main()
# * ------------------------------------------
# *

if [ $# -eq 0 ]; then
	error 0
else
	dir=$1
	if [ -e $dir ]; then # File exist?

		if [ -d $dir ]; then # File is a directory?

			if [ -r $dir ]; then # Can we read file?

				generate_dir $dir $2 # we can do it, finally!
			else
				error 401
			fi
		else
			error 403
		fi
	else
		error 404
	fi
fi