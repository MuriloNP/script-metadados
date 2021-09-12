#!/bin/bash

baixa_arquivos()
{
	local guardaUrl=$1
	wget -q $guardaUrl
	printf "\033[31;1m===>\033[m $guardaUrl\n"
}

if [ "$2" == "" ]
then
	echo "Erro: Argumentos insuficientes..."
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++"
	printf "Extensoes: \033[31;1mpdf, doc, docx, xls, xlsx, ppt, pptx\033[m\n"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	echo "Usage: $0 alvo.com [EXTENSAO]"
else
	echo ""
	printf "\033[34;1m[+]Efetuando os meta dados...\033[m\n"
	echo ""
	if [ "$2" == "pdf" ]
	then
		lynx --dump "http://google.com/search?&q=site:$1+ext:$2" | grep ".pdf" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' | egrep -v "/searc"> dumpArchive.txt

		for url in $(cat dumpArchive.txt);
		do
			baixa_arquivos $url
		done
		echo ""
		exiftool *.$2
		rm *.$2 &> /dev/null
		rm dumpArchive.txt &> /dev/null
	elif [ "$2" == "doc" ]
	then
		lynx --dump "http://google.com/search?&q=site:$1+ext:$2" | grep ".doc" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' | egrep -v "/searc" > dumpArchive.txt
		for url in $(cat dumpArchive.txt);
		do
			baixa_arquivos $url
		done
		echo ""
		exiftool *.$2
		rm dumpArchive.txt &> /dev/null
		rm *.$2 &> /dev/null
	elif [ "$2" == "docx" ]
	then
		lynx --dump "http://google.com/search?&q=site:$1+ext:$2" | grep ".docx" | cut -d "=" -f 2 | egrep -v "site|google" | sed 's/...$//' | egrep -v "/searc" > dumpArchive.txt
		for url in $(cat dumpArchive.txt);
		do
			baixa_arquivos $url
		done
		echo ""
		exiftool *.$2
		rm dumpArchive.txt &> /dev/null
		rm *.$2 &> /dev/null
	fi
fi
