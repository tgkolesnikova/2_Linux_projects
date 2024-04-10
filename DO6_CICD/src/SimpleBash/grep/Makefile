CC = gcc
CFLAGS = -Wall -Werror -Wextra -c
GREP_FILE = s21_grep.c
GREP_EXE = ./s21_grep

OS = $(shell uname)
ifeq ($(OS), Darwin)
	LEAK_CHECK = leaks -atExit -- 
endif
ifeq ($(OS), Linux)
	LEAK_CHECK = valgrind --leak-check=full -s -q
endif


all: clean s21_grep

build: s21_grep

rebuild: clean build


s21_grep: s21_grep.o
	$(CC) s21_grep.o -o $(GREP_EXE)

s21_grep.o: s21_grep.c
	$(CC) $(CFLAGS) s21_grep.c


clean:
	rm -rf *.o
	rm -rf *.gch
	rm -rf *.dSYM
	rm -rf s21_grep
	rm -rf *.out
	rm -rf log.txt


check: clean
	clang-format -n s21_grep.*
	cppcheck s21_grep.*


leaks: clean build
	$(LEAK_CHECK) $(GREP_EXE) -e f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -i f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -v f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -c f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -l f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -n f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -h f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -s f test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -f pattern.txt test0.txt
	$(LEAK_CHECK) $(GREP_EXE) -o f test0.txt


tests: clean build
	bash t_grep.sh
