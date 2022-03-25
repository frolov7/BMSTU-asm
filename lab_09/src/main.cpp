#include <stdio.h>

#include "32_bit.h"
#include "64_bit.h"
#include "80_bit.h"
#include "sin_cmp.h"


int main()
{
  sin_cmp();

  print_32_bit_operations_check();

  print_64_bit_operations_check();

  print_80_bit_operations_check();

  return 0;
}
