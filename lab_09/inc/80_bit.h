#ifndef PROG_80_BIT_H
#define PROG_80_BIT_H

#include <limits.h>
#include <time.h>
#include <stdio.h>
#include <math.h>
#include <chrono>
#include <iostream>

typedef long double FLOAT_80;

#define REPEATS 10000000

#define C_SUM   "Operation \"+\" on C++ : "
#define ASM_SUM "Operation \"+\" on ASM : "

#define C_MULT   "Operation \"*\" on C++ : "
#define ASM_MULT "Operation \"*\" on ASM : "

void print_80_bit_operations_check();

#endif
