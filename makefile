# ==========================================
#   Unity Project - A Test Framework for C
#   Copyright (c) 2007 Mike Karlesky, Mark VanderVoord, Greg Williams
#   [Released under MIT License. Please refer to license.txt for details]
# ==========================================

#We try to detect the OS we are running on, and adjust commands as needed
ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
  endif
	TARGET_EXTENSION=.exe
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	TARGET_EXTENSION=.out
endif

C_COMPILER=gcc
GCCFLAGS = -g -Wall -Wfatal-errors 
ifeq ($(shell uname -s), Darwin)
C_COMPILER=clang
endif

UNITY_ROOT=Unity

CFLAGS=-std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Wpointer-arith
CFLAGS += -Wcast-align
CFLAGS += -Wwrite-strings
CFLAGS += -Wswitch-default
CFLAGS += -Wunreachable-code
CFLAGS += -Winit-self
CFLAGS += -Wmissing-field-initializers
CFLAGS += -Wno-unknown-pragmas
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wundef
CFLAGS += -Wold-style-definition
CFLAGS += -Wfatal-errors

CPPCHECK_FLAGS=--enable=all --suppress=missingIncludeSystem
VALGRIND_FLAGS=--leak-check=full --show-leak-kinds=all
SANITIZER_FLAGS=-fsanitize=address

TARGET_BASE1=all_tests
TARGET1 = $(TARGET_BASE1)$(TARGET_EXTENSION)
SRC_FILES1=\
  $(UNITY_ROOT)/src/unity.c \
  $(UNITY_ROOT)/extras/fixture/src/unity_fixture.c \
  src/identifier.c \
  test/TestIdentifier.c \
  test/test_runners/TestIdentifier_Runner.c \
  test/test_runners/all_tests.c
INC_DIRS=-Isrc -I$(UNITY_ROOT)/src -I$(UNITY_ROOT)/extras/fixture/src
SYMBOLS=




all: clean compile run

compile:
	$(C_COMPILER) $(CFLAGS) $(INC_DIRS) $(SYMBOLS) $(SRC_FILES1) -o $(TARGET1)

run:
	- ./$(TARGET1) -v

noflag:
	gcc $(INC_DIRS) $(SRC_FILES1)

run-cppcheck:
	cppcheck $(CPPCHECK_FLAGS) src/main.c

valgrd:
	$(C_COMPILER) $(INC_DIRS) $(CFLAGS) $(SRC_FILES1) -o runvalgrind
	valgrind $(VALGRIND_FLAGS) ./runvalgrind

sanitizer:
	$(C_COMPILER) $(INC_DIRS) $(CFLAGS) $(SINITAIZER_FLAGS) $(SRC_FILES1) -o runsinitaizer
	./runsinitaizer

cov:
	$(C_COMPILER) $(GCCFLAGS) -fprofile-arcs -ftest-coverage -o $@ src/main.c src/identifier.c
	
run-cov:
	./cov ABCDE
	./cov abcde
	./cov qwertyuiopasdfghjklzxcvbnm
	./cov 1BCD
	./cov AB2CD
	./cov !BCD
	./cov AB!CD
	./cov
	gcov -b cov-identifier.gcda
clean:
	$(CLEANUP) $(TARGET1)
	rm -fr $(ALL) *.o cov* *.dSYM *.gcda *.gcno *.gcov runvalgrind runsinitaizer noflag

ci: CFLAGS += -Werror
ci: compile
