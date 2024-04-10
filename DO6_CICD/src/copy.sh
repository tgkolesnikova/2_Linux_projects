#!/bin/bash

#ROOT="/home/student/DO6_CICD-1/src/SimpleBash"
ROOT=$CI_PROJECT_DIR

# scp $ROOT/cat/s21_cat $ROOT/grep/s21_grep student@10.10.0.2:/usr/local/bin/
scp $ROOT/build/* student@10.10.0.2:/usr/local/bin/

echo "copy ok"
