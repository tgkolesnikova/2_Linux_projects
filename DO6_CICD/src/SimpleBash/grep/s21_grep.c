#include "s21_grep.h"

int main(int argc, char *argv[]) {
  int p_count = 0, f_count = 0;

  char **pattern = NULL;
  char **files = NULL;

  char flag[GREP_FLAGS_COUNT] = {0};
  struct flags grep_flags[GREP_FLAGS_COUNT] = {GREP_FLAGS};

  pars(argc, argv, grep_flags, flag, &p_count, &pattern, &f_count, &files);

  grep_main(&f_count, &p_count, flag, &pattern, &files);

  for (int i = 0; i < p_count; i++) {
    free(pattern[i]);
  }
  free(pattern);

  for (int i = 0; i < f_count; i++) {
    free(files[i]);
  }
  free(files);
}

void grep_main(int *f_count, int *p_count, char flag[], char ***pattern,
               char ***files) {
  regex_t re[100];
  regmatch_t rem[1];
  int match_count = 0, match = 0, str_count = 0;
  char str[BUFSIZE];
  FILE *file;
  for (int i = 0; i < *p_count; i++) {
    regcomp(&re[i], (*pattern)[i], strchr(flag, 'i') ? REG_ICASE : 0);
  }
  for (int i = 0; i < *f_count; i++) {
    match_count = 0;
    file = fopen((*files)[i], "r");
    if (file != NULL) {
      str_count = 0;
      while (fgets(str, sizeof(str), file) != NULL) {
        match = 0;
        str_count++;
        for (int j = 0; j < *p_count; j++) {
          if (regexec(&re[j], str, 1, rem, 0) == 0) {
            if (!match) {
              if (!strchr(flag, 'v'))
                str_pr_file_num(*f_count, (*files)[i], flag, str_count);
              match_count++;
            }
            match = 1;
            if (!strchr(flag, 'v')) {
              if (strchr(flag, 'o'))
                flag_o(str, flag, rem, re[j]);
              else {
                str_pr(str, flag);
                break;
              }
            }
          }
        }
        if (match == 0 && strchr(flag, 'v')) {
          str_pr_file_num(*f_count, (*files)[i], flag, str_count);
          str_pr(str, flag);
          match = 1;
        }
      }
      if (strchr(flag, 'c')) {
        if (strchr(flag, 'v')) match_count = str_count - match_count;
        str_pr_file(*f_count, (*files)[i], flag);
        printf(match_count > 1 && strchr(flag, 'l') ? "1\n" : "%d\n",
               match_count);
      }
      if (strchr(flag, 'l') && match_count > 0) {
        printf("%s\n", (*files)[i]);
      }
    } else if (!strchr(flag, 's'))
      fprintf(stderr, "grep: %s: No such file or directory\n", (*files)[i]);
  }
  for (int i = 0; i < *p_count; i++) {
    regfree(&re[i]);
  }
}

void pars(int argc, char *argv[], struct flags grep_flags[], char flag[],
          int *p_count, char ***pattern, int *f_count, char ***files) {
  int fk = 0, ar = 1;
  while (ar < argc) {
    if (argv[ar][0] == '-' && argv[ar][1] != '-') {
      for (int i = 1; i < (int)strlen(argv[ar]); i++) {
        if (argv[ar][i] == 'e') {
          ar = pars_flag_e(i, argv, ar, p_count, pattern);
          break;
        } else if (argv[ar][i] == 'f') {
          ar = pars_flag_f(i, argv, ar, p_count, pattern);
          break;
        }
        for (int j = 0; j < GREP_FLAGS_COUNT; j++) {
          if (grep_flags[j].fl[0] == argv[ar][i]) {
            fk = pars_flag(grep_flags[j].fl[0], flag, fk);
          }
        }
      }
    } else if (argv[ar][0] == '-' && argv[ar][1] == '-') {
      if (strstr(argv[ar], "--regexp=") != NULL) {
        ar = pars_flag_e(8, argv, ar, p_count, pattern) + 1;
        continue;
      } else if (strstr(argv[ar], "--file=") != NULL) {
        ar = pars_flag_f(6, argv, ar, p_count, pattern) + 1;
        continue;
      }
      for (int j = 0; j < GREP_FLAGS_COUNT; j++) {
        if (!strcmp(grep_flags[j].gnu_fl, argv[ar])) {
          fk = pars_flag(grep_flags[j].fl[0], flag, fk);
        }
      }
    } else {
      if (*pattern == NULL)
        ar = pars_flag_e((int)strlen(argv[ar - 1]) - 1, argv, ar - 1, p_count,
                         pattern);
      else
        din_arr(argv[ar], f_count, files);
    }
    ar++;
    if (argc == ar) break;
  }
}

int pars_flag(char grep_flag, char flag[], int fk) {
  for (int f = 0; f < GREP_FLAGS_COUNT; f++) {
    if (grep_flag == flag[f]) break;
    if (f == GREP_FLAGS_COUNT - 1) {
      flag[fk] = grep_flag;
      fk++;
    }
  }
  return fk;
}

int pars_flag_e(int i, char *argv[], int ar, int *p_count, char ***pattern) {
  char tmp_str[BUFSIZE] = {0};
  if (i == (int)strlen(argv[ar]) - 1) {
    ar++;
    strcat(tmp_str, argv[ar]);
  } else {
    int k_fe = 0;
    while (i + 1 + k_fe <= (int)strlen(argv[ar]) - 1) {
      tmp_str[k_fe] = argv[ar][i + 1 + k_fe];
      k_fe++;
    }
    tmp_str[strlen(tmp_str) + 1] = '\0';
  }
  if (doubl_pat_find(tmp_str, pattern, p_count))
    din_arr(tmp_str, p_count, pattern);
  return ar;
}

int pars_flag_f(int i, char *argv[], int ar, int *p_count, char ***pattern) {
  char tmp_file[BUFSIZE] = {0};
  FILE *f_file;
  char p_str[BUFSIZE];
  if (i == (int)strlen(argv[ar]) - 1) {
    ar++;
    strcat(tmp_file, argv[ar]);
  } else {
    int k_ff = 0;
    while (i + 1 + k_ff <= (int)strlen(argv[ar]) - 1) {
      tmp_file[k_ff] = argv[ar][i + 1 + k_ff];
      k_ff++;
    }
  }

  f_file = fopen(tmp_file, "r");
  while (fgets(p_str, sizeof(p_str), f_file) != NULL) {
    if (p_str[strlen(p_str) - 1] == '\n') {
      p_str[strlen(p_str) - 1] = '\0';
    }
    if (doubl_pat_find(p_str, pattern, p_count))
      din_arr(p_str, p_count, pattern);
  }
  return ar;
}

int doubl_pat_find(char str[], char ***pattern, int *p_count) {
  int d = 1;
  for (int i = 0; i < *p_count; i++) {
    if (!strcmp(str, (*pattern)[i])) {
      d = 0;
      break;
    }
  }
  return d;
}

void din_arr(char str[], int *count, char ***arr) {
  *arr = (char **)realloc(*arr, (*count + 1) * sizeof(char *));
  (*arr)[*count] = strdup(str);
  *count += 1;
}

void str_pr(char str[], char flag[]) {
  if (!strchr(flag, 'c') && !strchr(flag, 'l')) {
    printf("%s", str);
    if (str[strlen(str) - 1] != '\n') printf("\n");
  }
}

void flag_o(char str[], char flag[], regmatch_t rem[], regex_t re) {
  if (!strchr(flag, 'c') && !strchr(flag, 'l')) {
    char *tmp_str = str;
    int end_sum = 0;
    while (regexec(&re, tmp_str, 1, rem, 0) == 0) {
      for (int i = rem[0].rm_so; i < rem[0].rm_eo; i++) {
        printf("%c", tmp_str[i]);
      }
      end_sum += rem[0].rm_eo;
      tmp_str = &str[end_sum];
      printf("\n");
    }
    if (str[strlen(str) - 1] != '\n' && end_sum == 0) printf("\n");
  }
}

void str_pr_file(int f_count, char file[], char flag[]) {
  if (f_count > 1 && !strchr(flag, 'h')) printf("%s:", file);
}

void str_pr_file_num(int f_count, char file[], char flag[], int str_count) {
  if (!strchr(flag, 'c') && !strchr(flag, 'l')) {
    str_pr_file(f_count, file, flag);
    if (strchr(flag, 'n')) printf("%d:", str_count);
  }
}