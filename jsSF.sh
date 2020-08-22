#!/bin/bash

BLU="\033[0;34m"
echo -e "${BLU}"
echo -e "   _     ____  _____  "
echo -e "  (_)___/ ___||  ___| "
echo -e "  | / __\___ \| |_    "
echo -e "  | \__ \___) |  _|   "
echo -e " _/ |___/____/|_|     "
echo -e "|__/             ${NC}"
GREEN="\033[0;32m"
RED='\033[0;31m'
NC='\033[0m'

menu(){
  echo -e "${GREEN} - JsSF estrapola file javascript da un dominio o da una lista di domini"
  echo -e " - Fa un bel fetch di tutto quanto"
  echo -e " - Usa Linkfinder per trovate endpoint all'interno del js ed estrapola ipotetiche variabili js per XSS"
  echo -e "Utilizzo:"
  echo -e "        jsSF.sh -u file.js  "
  echo -e "        jsSF.sh -f file.txt${NC}"
}
menu

print_files(){
        mkdir -p javascriptfiles
        CUR_PATH=$(pwd)
        while read domain; do
                printf "\n${RED}$domain${NC}\n"
                line=$(echo $domain | cut -f 3 -d "/")
                filename="javascriptfiles/$line"
                curl -s -X GET -L  $domain | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f  2 | sed  s~^~"$urll"~g >> "$filename"
                echo "$domain   " >> javascriptfiles/index
        done
}

print_file(){
   line1=$(echo $urll | cut -f 3 -d "/")
   curl -s -X GET -L  $line1 | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f  2  | sed  s~^~"$urll"~g



}
urll=""
domain=""
while getopts ':u:f:' flag; do
  case "${flag}" in
    u )  urll=$OPTARG
         print_file
         ;;
    f ) domain=$OPTARG
        print_files
        ;;
    \? ) echo "flag sbagliata"
         exit 1
        ;;
    : )
        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
        exit 1
        ;;
  esac
done
shift $((OPTIND -1))
