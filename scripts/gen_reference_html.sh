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


SOURCE_DIR=${BASE_PATH}/../data-set/image
PUB_DIR=${BASE_PATH}/../artifacts/pubdir-reference

rm -r ${PUB_DIR}

mkdir -p ${PUB_DIR}
cp -a ${SOURCE_DIR}/* ${PUB_DIR}

cd ${PUB_DIR}

echo "<html>" > ${output}

echo "<head><title>HERMES Quality Assessment - REFERENCE STILL IMAGE</title></head>" >> ${output}

echo "<body>" >> ${output}

for i in *; do

  input_file=\"${i}\"
  no_extension=${i%.*}

  size=$(stat -c%s "${SOURCE_DIR}/${i}")

  echo "Name: ${no_extension}<br /> Size: ${size}<br /><img src=${input_file} /> <br /> <br />" >> ${output}

done

echo "</body>" >> ${output}
echo "</html>" >> ${output}

mv ${output} ${PUB_DIR}
