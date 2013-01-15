#!/bin/bash

# przenoszenie plików do wygenerowanego drzewa katalogów
for x in *
do
    file=`date +%Y -r $x`
    f_name=`date +%d/%m -r $x`
    if [ -d ../$file ]; then  
	`cp $x ../$file`;
     else 
        `mkdir ../$file/` 
	`cp $x ../$file/`
	
    fi
    
done