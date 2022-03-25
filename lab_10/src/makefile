m: m.exe
	./$^

mno: mno.exe
	./$^

m.exe: main.cpp
	g++ -S $^
	g++ -c -ggdb $^ -o m.o
	g++ -o $@ m.o

mno.exe: main.cpp
	g++ -S $^
	g++  -ggdb $^ -o mno.o
	g++ -o $@ mno.o

clear:
	rm -f *.exe *.o *.s *.exe