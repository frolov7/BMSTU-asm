#include <iostream>
using namespace std; 

int strlenasm(const char* str)
{
	int len = 0;
	__asm
	{
		mov ecx, 0 //  количество символов строки
		not ecx
		mov al, '\0' // в al конец строки
		mov edi, str // edi = str
		repne scasb // сравниваем байты edi с AL
		not ecx
		dec ecx // уменьшаем длину
		mov len, ecx // len = ecx
	}
	return len;
}
extern "C"
{
	char* strcopy(char* s1, char* s2, int len);
}

void print_out(char* str, int i)
{
	int len = strlenasm(str);
	cout << "str" << i << " : " << str << " - " << len << endl;
}

void new_line()
{
	cout << endl;
}

int main()
{
	char str1[80] = "123";
	char str2[80] = "456456";

	print_out(str1, 1);
	print_out(str2, 2);

	strcopy(str1, str2, strlenasm(str2));

	new_line();

	cout << "\nstrcopy:" << endl;
	print_out(str1, 1);
	print_out(str2, 2);


	return 0;
}