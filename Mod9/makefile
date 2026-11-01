


all: main

main: main.o libFunctions.o
	gcc main.o libFunctions.o -g -o main

main.o: main.s
	gcc -c main.s -g -o main.o

libFunctions.o: libFunctions.s
	gcc -c libFunctions.s -g -o libFunctions.o

clean:
	rm -f *.o main




