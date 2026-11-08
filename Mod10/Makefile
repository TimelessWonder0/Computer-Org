# Makefile for the two guessing programs (ARM 32-bit, pure assembly)
#   make                 builds both programs
#   make userGuess       builds only the "user guesses" program
#   make computerGuess   builds only the "computer guesses" program
#   make clean           removes the built programs
#
# Each .s file defines its own main, so no C file is needed.

all: userGuess computerGuess

userGuess: UserGuess.s
	gcc -g -no-pie -o userGuess UserGuess.s

computerGuess: ComputerGuess.s
	gcc -g -no-pie -o computerGuess ComputerGuess.s

clean:
	rm -f userGuess computerGuess

