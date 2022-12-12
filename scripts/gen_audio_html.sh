#!/bin/sh

# usage:
# create_html.sh index.html

# we need absolute paths in this script!!!
BASE_PATH=$(pwd)

if [ -z "$1" ]
then
  output="${BASE_PATH}/index.html"
else
  output="${BASE_PATH}/$1"
fi


SOURCE_DIR=${BASE_PATH}/../data-set/audio
ENCODED_DIR1=${BASE_PATH}/../artifacts/encoded-nesc
ENCODED_DIR2=${BASE_PATH}/../artifacts/encoded-lpcnet
RECONSTRUCTED_DIR1=${BASE_PATH}/../artifacts/reconstructed-lpcnet
RECONSTRUCTED_DIR2=${BASE_PATH}/../artifacts/reconstructed-nesc
PUB_DIR=${BASE_PATH}/../artifacts/pubdir-audio

rm -r ${PUB_DIR}

mkdir -p ${PUB_DIR}

cd ${PUB_DIR}

echo "<html>" > ${output}

echo "<head><title>HERMES Quality Assessment - AUDIO</title></head>" >> ${output}

echo "<body>" >> ${output}

for i in *; do

  input_file=\"${i}\"
  no_extension=${i%.*}

  size=$(stat -c%s "${ENCODED_DIR}/${no_extension}.vvc")

  echo "Name: ${no_extension}<br /> Size: ${size}<br /><img src=${input_file} /> <br /> <br />" >> ${output}

done

echo "</body>" >> ${output}
echo "</html>" >> ${output}

mv ${output} ${PUB_DIR}
