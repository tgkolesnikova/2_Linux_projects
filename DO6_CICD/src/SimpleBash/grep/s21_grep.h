#ifndef GREP
#define GREP

#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define GREP_FLAGS                                                   \
  {"i", "--ignore-case"}, {"v", "--invert-match"}, {"c", "--count"}, \
      {"l", "--files-with-matches"}, {"n", "--line-number"},         \
      {"h", "--no-filename"}, {"s", "--file="}, {"f", "--file="}, {  \
    "o", "--only-matching"                                           \
  }

#define GREP_FLAGS_COUNT 9
#define BUFSIZE 2000

struct flags {
  char *fl;
  char *gnu_fl;
};

void pars(int argc, char *argv[], struct flags grep_flags[], char flag[],
          int *p_count, char ***pattern, int *f_count, char ***files);
int pars_flag(char grep_flag, char flag[], int fk);
int pars_flag_e(int i, char *argv[], int ar, int *p_count, char ***pattern);
int pars_flag_f(int i, char *argv[], int ar, int *p_count, char ***pattern);
int doubl_pat_find(char str[], char ***pattern, int *p_count);
void din_arr(char str[], int *count, char ***arr);
void str_pr(char str[], char flag[]);
void str_pr_file(int f_count, char file[], char flag[]);
void str_pr_file_num(int f_count, char file[], char flag[], int str_count);
void flag_o(char str[], char flag[], regmatch_t rem[], regex_t re);
void grep_main(int *f_count, int *p_count, char flag[], char ***pattern,
               char ***files);

#endif