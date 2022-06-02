#!/bin/bash

function hi() {
 	 if [ -d "$1" ]
	 then
		 cd $1
		 if [ -f "master.tex" ]; then
			 cd ..
			 vim $1/master.tex
		 else 
			 cp /mnt/psf/Home/mipt/master.tex master.tex
			 cd ..
			 vim $1/master.tex
		 fi 
	 else
		 mkdir $1
		 cp /mnt/psf/Home/mipt/master.tex $1
		 vim $1/master.tex
	 fi
}

function preamble {
	vim ~/current_course/../preamble.tex
}

function snippets {
	vim ~/.vim/UltiSnips/tex.snippets
}
