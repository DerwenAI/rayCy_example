cdef extern from "libraycy.hpp" namespace "raycy":
    cdef cppclass Foo:
        Foo (int) except +
        int x

cdef class CyFoo:
    cdef Foo *cpp_obj

    def __cinit__ (self, int x):
        self.cpp_obj = new Foo(x)
