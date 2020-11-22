gen:
	clang -Og -S a.c -o a.s
	as a.s -g -o a.o
	ld a.o -o a.out -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
