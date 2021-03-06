#!/bin/bash

function generate_dir {
	# generate list of directories by files modification date
	# and move/copy them right away
	#
	# $new_dir	assumes a value according to stdin
	# 		 	if $2 isn't exist, then by default
	#			get as a value, current directory.
	# $dir 	 	name of current directory.
	#			Read form the stdin (check the main section)
	# $files	Stores list of files to segregate (with the path of each)

	if [ $# -eq 2 ]; then
		new_dir=$2
      else
		new_dir=$dir
	fi

	if [ setting_reccur = true ]; then
		files=`find $dir/* -type f`
	else
		files=`find $dir/* -maxdepth 0 -type f`
	fi

    for file in $files
    do
		mdate_year=`date +%Y -r $file`
		mdate_month=`date +%m -r $file`

		if [ $setting_day = true ]; then
			mdate_day=`date +%d -r $file`
		else
			mdate_day=''
		fi

		if [ $setting_backup = true ]; then
			echo $mdate_year >> files_to_backup
		fi

		path=$new_dir/$mdate_year/$mdate_month/$mdate_day

		if [ -d $path ]; then
     		    $setting_action $file $path
		else
		    mkdir -p $path
		    $setting_action $file $path
		fi
	done
}

function backup {
	# $new_dir	[ check in generate_dir ]
	name='backup_'`date +%F`
	b_file=`cat files_to_backup | uniq`
	rm files_to_backup

	cd $new_dir
	tar -cvzf $name.tar.gz $b_file

}

function help {
	echo
	echo 'Skladnia: `fseg.sh [KATALOG_ZRODLO] [KATALOG_DOCELOWY]`'
	echo 'Jeśli nie podany [KATALOG_DOCELOWY], to segreguje wewnątrz [KATALOG_ZRODLO]'
	echo
	echo 'Argumenty nieobowiązkowe, wyłącznie krótkie opcje:'
	echo '	-b 	spakowanie backupu posegregowanego katalogu (nazwa tworzona automatycznie)'
	echo '	-d 	zawęża datę segregacji do dnia ostatniej modyfikacji pliku'
	echo '	-m 	przenosi segregowane pliki przez `mv`'
	echo '	-r 	uwzględnia podkatalogi podczas segregacji'
	echo
}

function error {
	# $code	store the number of error
	# $option store the name of option (only in 405 err)

	code=$1
	option=$2

	case $code in
		0)	 echo $0': brak argumentow.'
			 echo 'Spróbuj `fseg.sh --help` dla uzyskania informacji.'
			 ;;
		401) echo $0': Brak dostępu do pliku lub katalogu ';;
		403) echo $0': Podany plik nie jest katalogiem';;
		404) echo $0': Podany plik '$dir' nie istnieje';;
		405) echo $0': '$option': Nieznana opcja ' 
			echo 'Spróbuj `fseg.sh -- help` dla uzyskania informacji.'
			;;
		*) 	 echo 'We like trains';;
	esac
	exit 0
}

#
# main()
# ------------------------------------------
#

if [ $# -eq 0 ]; then
	error 0
else
	setting_backup=false
	setting_action='cp'
	setting_day=false
	setting_reccur=false

	while [ $# -gt 0 ]; do # options

		case $1 in
			-b) setting_backup=true;;
			-m) setting_action='mv';;
			-d) setting_day=true;;
			-r) setting_reccur=true;;
			--help) help;;
			--) shift
				break
				;;
			-*) error 405 $1;;
			*) break;;
		esac

	shift
	done

	dir=$1

	if [ -e $dir ]; then # File exist?

		if [ -d $dir ]; then # File is a directory?

			if [ -r $dir ]; then # Can we read file?

				generate_dir $dir $2   # we can do it, finally!

				if [ $setting_backup = true ]; then
					backup
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
