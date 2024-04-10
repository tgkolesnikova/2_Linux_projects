#!/bin/bash

COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
TEST_FILE="test0.txt test1.txt test2.txt test3.txt bytes.txt"
# echo "" > log.txt

for var in "" -b -e -n -s -t -v -E -T # --number-nonblank --number --squeeze-blank
do
    TEST1="$var $TEST_FILE"
    echo "\n------------ $TEST1 -----------"
    ./s21_cat $TEST1 > s21_cat.txt
    cat $TEST1 > cat.txt
    DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
    echo "DIFF_RES: $DIFF_RES"
    if [ "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" ]
      then
        COUNTER_SUCCESS=$(( COUNTER_SUCCESS+1 ))
        # echo "$TEST1 identical COUNTER_SUCCESS=$COUNTER_SUCCESS" >> log.txt
      else
        COUNTER_FAIL=$(( COUNTER_FAIL+1 ))
        # echo "$TEST1 not identical COUNTER_FAIL=$COUNTER_FAIL" >> log.txt
    fi
    rm s21_cat.txt cat.txt
done

echo "\n\nSUCCESS - $COUNTER_SUCCESS"
echo "FAIL - $COUNTER_FAIL"

if [ $COUNTER_FAIL -eq 0 ]
then
    exit 0
else
    exit 1
fi
