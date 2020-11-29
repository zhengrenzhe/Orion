gen:
	clang -Og -S calc.c -o calc.s
	clang -Og -S ./add/add.c -o add.s
	clang -Og -S ./division/division.c -o division.s
	clang -Og -S ./multiplication/multiplication.c -o multiplication.s
	clang -Og -S ./sub/sub.c -o sub.s

	as calc.s -g -o calc.o
	as add.s -g -o add.o
	as sub.s -g -o sub.o
	as multiplication.s -g -o multiplication.o
	as division.s -g -o division.o

	ld calc.o add.o sub.o multiplication.o division.o -o calc.out -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`

clean:
	rm *.s
	rm *.o
	rm *.out
