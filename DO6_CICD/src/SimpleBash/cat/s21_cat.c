#include "s21_cat.h"

int main(int argc, char **argv) {
  OPTS; /*  define  */

  opterr = 0; /* подавление автосообщения getopt_long() об ошибке */
  int result = getopt_long(argc, argv, short_opts, long_opts, NULL);
  if (argc > 2 && result != '?' && result > 0) {
    scanfile(argc, argv, result);
  } else if (argc == 1) {
    /*  argc == 1, argv[] = {} --> просто повторяем ввод */
    for (;;) {
      char s[1000];
      fgets(s, 1000, stdin);
      printf("%s", s);
    }
  } else if (result == '?') {
    fprintf(stderr, "s21_cat: illegal option -- %c\n", argv[1][1]);
  } else if (result == -1) {
    for (int i = 1; i < argc; i++) {
      FILE *fp = fopen(argv[i], "r");
      if (fp == NULL) {
        fprintf(stderr, "s21_cat: %s: No such file or directory\n", argv[i]);
      } else {
        while (!feof(fp)) {
          char c = fgetc(fp);
          if (c != -1) {
            printf("%c", c);
          }
        }
        fclose(fp);
      }
    }
  }
  // } else if (result > 0) {
  //   int flag = 2;
  //   for (;;) {
  //     char s[1000];
  //     fgets(s, 1000, stdin);
  //     int i = 0;
  //     while (s[i] != '\0') {
  //       scanparams(result, s[i], &flag, 0);
  //       i++;
  //     }
  //   }
  // }
  return 0;
}

void scanfile(int argc, char *argv[], int res) {
  char c;
  argc -= optind;
  argv += optind;
  int newfile = 0;
  for (int i = 0; i < argc; i++) {
    FILE *fp;
    fp = fopen(argv[i], "r");
    if (fp == NULL) {
      fprintf(stderr, "s21_cat: %s: No such file or directory\n", argv[i]);
    } else {
      int flag = 2;
      while (!feof(fp)) {
        c = fgetc(fp);
        if (c != -1) {
          scanparams(res, c, &flag, &newfile);
        } else {
          newfile = 1;
        }
      }
      fclose(fp);
    }
  }
}

void scanparams(int res, char c, int *flag, int *newfile) {
  // bevnst(ET)
  static int strcount = 0;
  switch (res) {
    case 'b':
      case_b(c, flag, &strcount, newfile);
      break;
    case 'e':
      case_e(c);
      break;
    case 'v':
      case_v(c);
      break;
    case 'n':
      case_n(c, flag, newfile);
      break;
    case 's':
      case_s(c, flag);
      break;
    case 't':
      case_t(c);
      break;
    case 'E':
      case_E(c);
      break;
    case 'T':
      case_T(c);
      break;
    default:
      printf("s21_cat: illegal option -- %c", c);
      break;
  }
}

void case_b(char c, int *flag, int *strcount, int *newfile) {
  if (*flag == 2) {
    NCASE(*strcount);
    *flag = 0;
  }
  if (*newfile == 1) {
    printf("%c", c);
    if (c == '\n') {
      *newfile = 0;
    }
  } else {  // то есть newfile = 0
    if (c != '\n' && *flag == 0) {
      printf("%6d\t%c", ++(*strcount), c);
      *flag = 1;
    } else if (c != '\n' && *flag == 1) {
      printf("%c", c);
    } else if (c == '\n') {
      *flag = 0;
      printf("\n");
    }
  }
}

void case_n(char c, int *flag, int *newfile) {
  static int strcount = 0;
  static int newline = 0;
  if (*newfile == 1) {
    printf("%c", c);
    if (c == '\n') {
      *newfile = 0;
    }
  } else {
    if (*flag == 2) {
      NCASE(strcount);
      *flag = 3;
      printf("%6d\t", ++strcount);
      newline = 0;
    }
    if (c != '\n' && newline == 0) {
      printf("%c", c);
    } else if (c == '\n' && newline == 0) {
      printf("%c", c);
      newline = 1;
    } else if (c != '\n' && newline == 1) {
      printf("%6d\t%c", ++strcount, c);
      newline = 0;
    } else {
      printf("%6d\t\n", ++strcount);
    }
  }
}

void case_e(unsigned char c) {
  if (c == '\n') {
    printf("$\n");
  } else if (c == '\0') {
  } else {
    case_v(c);
  }
}

void case_v(unsigned char c) {
  if (c <= 31 && c != '\n' && c != '\t') {
    printf("^%c", '@' + c);
  } else if (c == 127) {
    printf("^?");
  } else if (c >= 128 && c <= 159) {
    printf("M-^%c", '@' + c - 128);
    VCASE;
  } else {
    printf("%c", c);
  }
}

void case_s(unsigned char c, int *flag) {
  if (*flag == -1) {
    *flag = 0;
  }
  if (c == '\n' && *flag < 2) {
    printf("\n");
    *flag += 1;
  } else if (c != '\n') {
    printf("%c", c);
    *flag = 0;
  }
}

void case_t(unsigned char c) {
  if (c == '\t') {
    printf("^I");
  } else {
    case_v(c);
  }
}

void case_E(unsigned char c) {
  if (c == '\n') {
    printf("$\n");
  } else {
    printf("%c", c);
  }
}

void case_T(unsigned char c) {
  if (c == '\t') {
    printf("^I");
  } else {
    printf("%c", c);
  }
}
