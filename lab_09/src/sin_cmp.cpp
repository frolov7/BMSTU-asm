#include "sin_cmp.h"

void sin_cmp() 
{
	double fpu_sin = 0.0;

	std::cout << "\tCheck sin(pi)" << std::endl;

	std::cout << "sin(3.14) = " << sin(3.14) << std::endl;
	std::cout << "sin(3.141596) = " << sin(3.141596) << std::endl;

	asm("fldpi\n" 
		"fsin\n" 
		"fstp %0\n"
		: "=m"(fpu_sin)
	);

	std::cout << "asm (pi) = " << fpu_sin << std::endl;
	std::cout << std::endl;

	std::cout << "\tCheck sin(pi / 2)" << std::endl;

	std::cout << "sin(3.14 / 2) = " << sin(3.14 / 2) << std::endl;
	std::cout << "sin(3.141596 / 2) = " << sin(3.141596 / 2) << std::endl;

	fpu_sin = 0;

	asm("fldpi\n"
		"fld1\n" 
		"fld1\n" 
		"faddp\n"
		"fdiv\n" 
		"fsin\n" 
		"fstp %0\n"
		: "=m"(fpu_sin)
	);

	std::cout << "asm sin(pi / 2) = " << fpu_sin << std::endl;

	std::cout << "\n" << std::endl;
}