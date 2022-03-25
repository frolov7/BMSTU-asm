#include <stdlib.h>
#include <stdio.h>
#include <chrono>
#include <iostream>

#define REPEAT 100000
#define GET_RND ((double)rand() / (double)(RAND_MAX))
#define C_SCALAR_TEXT   "Operation \"Scalar mult\" on C++ : "
#define ASM_SCALAR_TEXT "Operation \"Scalar mult\" on ASM : "
using namespace std;

/*
ax в стек
ax в xmm0
ax в стек
ax в xmm1
умножили 0 на 1
так 2 раза
умножили 
*/
struct vector
{
	float a;
	float b;
	float c;
	float d;
};

void cpp_multiplication(vector *vec1, vector *vec2)
{
	float result = 0;
	for (int i = 0; i < REPEAT; i++)
		result = vec1->a * vec2->a + vec1->b * vec2->b + vec1->c * vec2->c + vec1->d * vec2->d; // a1 * a2 + b1 * b2 + c1 * c2 + d1 * d2
	
}

void asm_multiplication(vector *vec1, vector *vec2)
{
	float result = 0;
	for (int i = 0; i < REPEAT; i++)
		asm
		(    // rsi - vec1, rdi - vec2
			"movups (%%rsi), %%xmm0\n" // 4 упаконных флоат числа из rsi в xmm
			"mulps (%%rdi), %%xmm0\n" 
			"haddps %%xmm0, %%xmm0\n" 
			"haddps %%xmm0, %%xmm0\n" 
			:"=Yz"(result)
			:"S"(vec1), "D"(vec2)
		);
}

int main(void)
{
	//vector vec1{GET_RND, GET_RND, GET_RND}, vec2{GET_RND, GET_RND, GET_RND};
	vector vec1{2, 2, 2, 2}, vec2{1, 1, 1, 1};

	auto begin = std::chrono::steady_clock::now();
	cpp_multiplication(&vec1, &vec2);
	auto end = std::chrono::steady_clock::now();
	long int time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	
	std::cout << C_SCALAR_TEXT; 
	std::cout.width(4);
	std::cout << time << "  ns" << std::endl;
	
	begin = std::chrono::steady_clock::now();
	asm_multiplication(&vec1, &vec2);
	end = std::chrono::steady_clock::now();
	time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin)).count();
	
	std::cout << ASM_SCALAR_TEXT; 
	std::cout.width(4);
	std::cout << time << "  ns" << std::endl;   

	return 0;
}