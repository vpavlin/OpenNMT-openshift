#!/usr/bin/bash

mkdir -p data jabberwocky models
[ -z "${SOURCE_TRAIN}" ] && SOURCE_TRAIN="https://raw.githubusercontent.com/OpenNMT/OpenNMT-py/master/data/src-train.txt"
SOURCE_TRAIN_FILE="src-train.txt"
[ -z "${TARGET_TRAIN}" ] && TARGET_TRAIN="https://raw.githubusercontent.com/OpenNMT/OpenNMT-py/master/data/tgt-train.txt"
TARGET_TRAIN_FILE="tgt-train.txt"
[ -z "${SOURCE_VAL}" ] && SOURCE_VAL="https://raw.githubusercontent.com/OpenNMT/OpenNMT-py/master/data/src-val.txt"
SOURCE_VAL_FILE="src-val.txt"
[ -z "${TARGET_VAL}" ] && TARGET_VAL="https://raw.githubusercontent.com/OpenNMT/OpenNMT-py/master/data/tgt-val.txt"
TARGET_VAL_FILE="tgt-val.txt"
[ -z "${SOURCE_VOCAB_FILE}" ] && SOURCE_VOCAB_FILE="src-vocab.txt"
[ -z "${TARGET_VOCAB_FILE}" ] && TARGET_VOCAB_FILE="tgt-vocab.txt"
DATA_DIR="data"

function get_file() {
    local train=$1
    local name=$2

    curl -o ${name} ${train}
    echo ${name}
}


[ -f "${DATA_DIR}/${SOURCE_TRAIN_FILE}" ] || get_file ${SOURCE_TRAIN} ${DATA_DIR}/${SOURCE_TRAIN_FILE}
[ -f "${DATA_DIR}/${TARGET_TRAIN_FILE}" ] || get_file ${TARGET_TRAIN} ${DATA_DIR}/${TARGET_TRAIN_FILE}
[ -f "${DATA_DIR}/${SOURCE_VAL_FILE}" ] || get_file ${SOURCE_VAL} ${DATA_DIR}/${SOURCE_VAL_FILE}
[ -f "${DATA_DIR}/${TARGET_VAL_FILE}" ] || get_file ${TARGET_VAL} ${DATA_DIR}/${TARGET_VAL_FILE}

[ -f "${DATA_DIR}/${SOURCE_VOCAB_FILE}" ] || onmt-build-vocab ${DATA_DIR}/${SOURCE_TRAIN_FILE} --save_vocab ${DATA_DIR}/${SOURCE_VOCAB_FILE}
[ -f "${DATA_DIR}/${TARGET_VOCAB_FILE}" ] || onmt-build-vocab ${DATA_DIR}/${TARGET_TRAIN_FILE} --save_vocab ${DATA_DIR}/${TARGET_VOCAB_FILE}

onmt-main train_and_eval --model_type Transformer --config reference-config.yaml --auto_config
onmt-main export --export_dir_base models --config reference-config.yaml --auto_config
ls jabberwocky
ls models
ls -R