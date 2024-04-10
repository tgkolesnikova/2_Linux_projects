CC = gcc -std=c11
FLAGS = -Wall -Werror -Wextra
CAT_FILE = s21_cat.c
CAT_EXE = ./s21_cat

OS = $(shell uname)
ifeq ($(OS), Darwin)
	LEAK_CHECK = leaks -atExit -- 
endif
ifeq ($(OS), Linux)
	LEAK_CHECK = valgrind --leak-check=full -s -q
endif


all: clean build

build: s21_cat

rebuild: clean build

s21_cat:
	$(CC) $(FLAGS) $(CAT_FILE) -o $(CAT_EXE)

clean:
	rm -rf *.o, *.gch
	rm -rf *.dSYM
	rm -rf s21_cat
	rm -rf *.out
	rm -rf log.txt

check:
	clang-format -n s21_cat.*
	cppcheck s21_cat.*

tests: clean build
	sh t_cat.sh
	
leaks: clean build
	$(LEAK_CHECK) $(CAT_EXE) test0.txt test1.txt test2.txt test3.txt