CC = g++
CFLAGS = -g -Wall -DNDEBUG

# change this location based on your installation
ANA = /home/paco/anaconda3
CY_INCL = -I$(ANA)/include/python3.8
CY_FLAGS = $(CFLAGS) -Wl,--sysroot=/ -pthread -B $(ANA)/compiler_compat -Wsign-compare -fwrapv -O3 -fPIC
CY_LIBS = -L$(ANA)/lib -Wl,-rpath=$(ANA)/lib -Wl,--no-as-needed

GEN = rayCy.cpp


default: rayCy.so
	mypy test.py
	pylint test.py
	pytest test.py

rayCy.so: rayCy.pyx libraycy.o
#	python setup.py build_ext --inplace
	cython --cplus $<
	$(CC) $(CY_FLAGS) $(CY_INCL) -c rayCy.cpp -o rayCy.o
	$(CC) $(CY_FLAGS) $(CY_LIBS) -shared rayCy.o libraycy.o -o $@

libraycy.o: libraycy.cpp libraycy.hpp
	$(CC) $(CY_FLAGS) $(CY_INCL) -c $< -o $@

clean:
	rm -f $(GEN) *.o *.so a.out *~
	rm -rf build

.PHONY: clean
