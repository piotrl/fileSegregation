#!/bin/bash

function generate_dir {
	if [ $# -eq 2 ]; then
		new_dir=$2
      	else
		new_dir='cache'
	fi	

    for file in $dir/*
    do                   
		cdate_year=`date +%Y -r $file`
		if [ -d $new_dir/$cdate_year ]; then   
     		    $action $file $new_dir/$cdate_year/;
		else
		    mkdir -p $new_dir/$cdate_year/
		    $action $file $new_dir/$cdate_year/;
		fi
	done
}

function backup {
	name='backup_'`date +%F`
	cd $new_dir
	tar -cvzf $name.tar.gz *
}

function error {
	code=$1
	option=$2

	case $code in
		0)	 echo $0': brak argumentow.'
			 echo 'Poprawna skladnia: `fseg.sh [KATALOG_ZRODLO] [KATALOG_DOCELOWY]`'
			 ;;
		401) echo $0': Brak dostępu do pliku lub katalogu ';;
		403) echo $0': Podany plik nie jest katalogiem';;
		404) echo $0': Podany plik '$dir' nie istnieje';;
	        405) echo $0': Nieznana opcja '$option;;
		*) 	 echo 'We like trains';;
	esac
	exit 0
}

# *
# * main()
# * ------------------------------------------
# *

if [ $# -eq 0 ]; then
	error 0
else
	backup=false
	action='cp'

	while [ $# -gt 0 ]; do # options

		case $1 in
		-b) backup=true
			;;
		-m) action='mv'
			;;
		--) shift
			break
			;;
		-*) error 400 $1
			;;
		*) break
			;;
		esac

	shift
	done

	dir=$1;

	if [ -e $dir ]; then # File exist?

		if [ -d $dir ]; then # File is a directory?

			if [ -r $dir ]; then # Can we read file?

				generate_dir $dir $2   # we can do it, finally!

				if [ $backup = true ]; then
					backup $2
				fi
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
