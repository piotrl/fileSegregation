#!/bin/bash

# generating directories by cretion date of files
function generate_dir {
	if [ $# = 2 ]; then
		new_dir=$2
		if [ -e $new_dir ]; then    # destination director exists
		  
		    if [ -d $new_dir ]; then  # destination is a directiory
		      
			if [ -r $new_dir ]; then
			  cd $dir
			  search $new_dir;
		        else error 401
		      
			fi
		    else error 403
		  
		    fi
		else  
		    mkdir $new_dir
		    cd $dir
		    search $new_dir;       
	        fi
          else
		new_dir='cache'
		mkdir $new_dir
		cd $dir
		search $new_dir; 
	fi
}

# searching files

function search {
    for file in *
    do                   
		cdate_year=`date +%Y -r $file`
		if [ -d $new_dir/$cdate_year ]; then   
     		    $action $file $new_dir/$cdate_year/;
		    
		else
		    mkdir $new_dir/$cdate_year/
		    $action $file $new_dir/$cdate_year/;
		   
		fi
    done
}

# $dir jest globalny, wiec przyjmuje wartosc argumentu $1 z wywolania skryptu# error handling error handling

function backup {
    name=`date +%F` 
    cd $new_dir
    tar -cvzf $name.tar.gz *
}

function error {
	code=$1

	case $code in
		0)	 echo $0': brak argumentow.'
			 echo 'Poprawna skladnia: `fseg.sh [KATALOG_ZRODLO] [KATALOG_DOCELOWY]`'
			 ;;
	        400) echo $0': Nieznana opcja';;
		401) echo $0': Brak dostępu do pliku lub katalogu ';;
		403) echo $0': Podany plik nie jest katalogiem';;
		404) echo $0': Podany plik '$dir' nie istnieje';;
		405) echo $0': Brak pliku do wyslania ';;
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
    backup=false
    action='cp'
    while [ $# -gt 0 ]   # options
    do
	case $1 in
	-b) backup=true
	    ;;
	-m) action='mv'
	    ;;
	--) shift
	    break
	    ;;
	-*) error 400
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
				 
			    if [ $backup = true ]; then backup $2;
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