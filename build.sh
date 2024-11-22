Cyan='\033[0;36m'
Yellow='\033[1;33m'
Green='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

output=sca-binary

rm -rvf dist
printf "${Yellow}"
poetry self add poetry-plugin-export
poetry export -o requirements.txt --without-hashes
poetry run pip wheel --wheel-dir=${output} -r requirements.txt
printf "${Green}"
poetry build -f wheel

printf "${RED}###Move dist###\n"
mv -v dist/*.whl ${output}

printf "${Cyan}###Unzip whl###\n"
cd ${output}
ls . | awk '{system("unzip "$1)}'

printf "${RED}###Remove whl###\n"
rm -vf *.whl
cd -

printf "${NC}"
printf "\n${RED}###Zip###\n"
zip dist/${output}.zip -r ${output}
rm -rf ${output} requirements.txt
chmod -R 777 dist
