#ifndef SRC_CAT_S21_CAT_H_
#define SRC_CAT_S21_CAT_H_

#include <getopt.h>
#include <stdio.h>

/* Структуры данных для парсера командной строки */
#if __APPLE__
#define OPTS
const char *short_opts = "bevnst";
const struct option long_opts[] = {{NULL, 0, NULL, 0}};
#elif __linux__
#define OPTS
const char *short_opts = "bevnstET";
const struct option long_opts[] = {{"number-nonblank", 0, NULL, 'b'},
                                   {"number", 0, NULL, 'n'},
                                   {"squeeze-blank", 0, NULL, 's'},
                                   {"show-nonprinting", 0, NULL, 'v'},
                                   {NULL, 0, NULL, 0}};
#endif

/* Нумерация строк - на линуксе сквозная, на маке - каждый файл заново */
#if __APPLE__
#define NCASE(n) n = 0;
#elif __linux__
#define NCASE(n)
#endif

/* Непечатаемые знаки для линукса */
#if __APPLE__
#define VCASE
#elif __linux__
#define VCASE                          \
  }                                    \
  else if (c >= 160 && c <= 254) {     \
    printf("M-%c", '!' - 1 + c - 160); \
  }                                    \
  else if (c == 255) {                 \
    printf("M-^?");
#endif

void scanfile(int argc, char *argv[], int res);
void scanparams(int res, char c, int *flag, int *newfile);
void case_b(char c, int *flag, int *strcount,
            int *newfile);  // нумерует только непустые строки
void case_n(char c, int *flag, int *newfile);  // нумерует все выходные строки
void case_e(unsigned char c);  // непечатаемые символы, и $ в конце строк
void case_v(unsigned char c);  // непечатаемые символы
void case_s(unsigned char c,
            int *flag);  // сжимает несколько смежных пустых строк
void case_t(unsigned char c);  // непечатаемые символы и знак  ^I вместо \t
void case_E(unsigned char c);  // знак $ в конце каждой строки (GNU only)
void case_T(unsigned char c);  // знак  ^I вместо табов (GNU only)

#endif  // SCR_CAT_S21_CAT_H_
