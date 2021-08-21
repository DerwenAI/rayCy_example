#!python
# cython: embedsignature=True, binding=True

from libcpp.string cimport string


cdef extern from "libraycy.hpp" namespace "raycy":
    cdef cppclass Foo:
        int x
        string name

        Foo () except +

        int initialize (int, string)
        int test_method (int)
        string get_name()


cdef class CyFoo:
    cdef Foo *cpp_obj

    def __cinit__ (self):
        self.cpp_obj = new Foo()

    def initialize (self, x, name):
        return self.cpp_obj.initialize(x, name)

    def test_method (self, val):
        return self.cpp_obj.test_method(val)

    def get_name (self):
        return self.cpp_obj.get_name()
