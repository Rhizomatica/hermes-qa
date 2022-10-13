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


# SOURCE_DIR=${BASE_PATH}/../data-set/image
ENCODED_DIR=${BASE_PATH}/../artifacts/encoded-vvc
RECONSTRUCTED_DIR=${BASE_PATH}/../artifacts/reconstructed-vvc
PUB_DIR=${BASE_PATH}/../artifacts/pubdir-vvc

rm -r ${PUB_DIR}

mkdir -p ${PUB_DIR}
cp -a ${RECONSTRUCTED_DIR}/* ${PUB_DIR}

cd ${PUB_DIR}

echo "<html>" > ${output}

echo "<head><title>HERMES Quality Assessment - STILL IMAGE</title></head>" >> ${output}

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
