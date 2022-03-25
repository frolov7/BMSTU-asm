#ifndef PROG_64_BIT_H
#define PROG_64_BIT_H

#include <limits.h>
#include <time.h>
#include <stdio.h>
#include <chrono>
#include <iostream>

#define REPEATS 1000000

#define C_SUM   "Operation \"+\" on C++ : "
#define ASM_SUM "Operation \"+\" on ASM : "

#define C_MULT   "Operation \"*\" on C++ : "
#define ASM_MULT "Operation \"*\" on ASM : "

void print_64_bit_operations_check();

#endif
