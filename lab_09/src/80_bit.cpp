#include "80_bit.h"

void get_80_bit_c_sum(FLOAT_80 a, FLOAT_80 b)
{
	FLOAT_80 result = 0;

	for (size_t i = 0; i < REPEATS; ++i)
		result = a + b;
}


void get_80_bit_asm_sum(FLOAT_80 a, FLOAT_80 b)
{
	FLOAT_80 result = 0;

	for (size_t i = 0; i < REPEATS; ++i)
		asm("fld %1\n"
			"fld %2\n"
			"faddp\n" 
			"fstp %0\n"
			: "=m"(result)
			: "m"(a), "m"(b)
		);
}

void get_80_bit_c_mult(FLOAT_80 a, FLOAT_80 b)
{
	FLOAT_80 result = 0;

	for (size_t i = 0; i < REPEATS; ++i)
		result = a * b;
}


void get_80_bit_asm_mult(FLOAT_80 a, FLOAT_80 b)
{
	FLOAT_80 result = 0;

	for (size_t i = 0; i < REPEATS; ++i)
		asm("fld %1\n"
			"fld %2\n"
			"fmulp\n" 
			"fstp %0\n"
			: "=m"(result)
			: "m"(a), "m"(b)
		);
}

void print_80_bit_operations_check()
{
	printf("\tType: \"__float80\", size = %zu bites\n", sizeof(FLOAT_80) * CHAR_BIT);

	FLOAT_80 a = 5e23, b = 7e31;

	// C
	auto begin = std::chrono::steady_clock::now();
	get_80_bit_c_sum(a, b);
	auto end = std::chrono::steady_clock::now();

	long int time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	std::cout << C_SUM; 
	std::cout.width(9);
	std::cout << time << "  ns" << std::endl;

	// Asm
	begin = std::chrono::steady_clock::now();
	get_80_bit_asm_sum(a, b);
	end = std::chrono::steady_clock::now();

	time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	std::cout << ASM_SUM; 
	std::cout.width(9);
	std::cout << time << "  ns" << std::endl;

	// C
	begin = std::chrono::steady_clock::now();
	get_80_bit_c_mult(a, b);
	end = std::chrono::steady_clock::now();

	time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	std::cout << C_MULT; 
	std::cout.width(9);
	std::cout << time << "  ns" << std::endl;

	// Asm
	begin = std::chrono::steady_clock::now();
	get_80_bit_asm_mult(a, b);
	end = std::chrono::steady_clock::now();

	time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	std::cout << ASM_MULT; 
	std::cout.width(9);
	std::cout << time << "  ns" << std::endl;

	std::cout << std::endl;
}
