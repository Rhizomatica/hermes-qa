#!/bin/sh

# put all the code inside a for() to iterate among many codecs...
CODEC=vvc

# we need absolute paths in this script!!!
BASE_PATH=$(pwd)

SOURCE_DIR=${BASE_PATH}/../data-set/image
ENCODED_DIR=${BASE_PATH}/../artifacts/encoded-vvc
RECONSTRUCTED_DIR=${BASE_PATH}/../artifacts/reconstructed-vvc

COMPRESS_IMAGE=compress_image.sh
DECOMPRESS_IMAGE=decompress_image.sh

mkdir -p ${ENCODED_DIR}/
mkdir -p ${RECONSTRUCTED_DIR}/

rm -f ${ENCODED_DIR}/*
rm -f ${RECONSTRUCTED_DIR}/*

cd ${SOURCE_DIR}

# compress data
for i in *; do

    no_extension=${i%.*}

    input_file=\"${i}\"
    output_file=\"${ENCODED_DIR}/${no_extension}.${CODEC}\"
    echo "==== INPUT: ${input_file}"
    echo "==== OUTPUT: ${output_file}"
    eval ${COMPRESS_IMAGE} \"${i}\" \"${ENCODED_DIR}/${no_extension}.${CODEC}\"

    echo "==== DONE"
done

cd ${ENCODED_DIR}

# decompress data
for i in *; do

    no_extension=${i%.*}

#    input_file=\"${i}\"
#    output_file=\"${ENCODED_DIR}/${no_extension}.${CODEC}\"
#    echo compress ${COMPRESS_IMAGE} ${input_file} ${output_file}
    eval ${DECOMPRESS_IMAGE} \"${i}\" \"${RECONSTRUCTED_DIR}/${no_extension}.jpg\"

done

# TODO
# calculate SSIM and PSNR metrics at least
