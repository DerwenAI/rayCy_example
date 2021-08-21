# rayCy_bug

Demo / test harness for a code conflict in the use of Ray actors with
Cython-based classes.

---
## Requirements

A solution must compile and run on Ubuntu Linux using a makefile with:

  * g++ 9.3+
  * Cython 0.29+
  * Python 3.8+
  * Ray 1.5.2+


## Error Description

The `libraycy.hpp` C++ header file:

```
namespace raycy {
  class Foo {
  public:
    int x;

    Foo ();
    Foo (int x);
    ~Foo ();
  };
}
```


The `libraycy.cpp` C++ source file:

```
#include "libraycy.hpp"

using namespace raycy;

// default constructor
Foo::Foo () {}

// overloaded constructor
Foo::Foo (int x) {
  this->x = x;
}

// destructor
Foo::~Foo () {}
```


The `rayCy.pyx` Cython extension file:

```
cdef extern from "libraycy.hpp" namespace "raycy":
    cdef cppclass Foo:
        Foo (int) except +
        int x

cdef class CyFoo:
    cdef Foo *cpp_obj

    def __cinit__ (self, int x):
        self.cpp_obj = new Foo(x)
```


The `test.py` Python source file used for testing:

```
import ray
import rayCy

@ray.remote
class Foo (rayCy.CyFoo):
    def test_method ():
        print("hello")
```

## Error

Then the error traceback is:

```
python test.py
Traceback (most recent call last):
  File "test.py", line 6, in <module>
    class Foo (rayCy.CyFoo):
  File "/home/paco/anaconda3/lib/python3.8/site-packages/ray/worker.py", line 1990, in remote
    return make_decorator(worker=worker)(args[0])
  File "/home/paco/anaconda3/lib/python3.8/site-packages/ray/worker.py", line 1868, in decorator
    return ray.actor.make_actor(function_or_class, num_cpus, num_gpus,
  File "/home/paco/anaconda3/lib/python3.8/site-packages/ray/actor.py", line 1069, in make_actor
    return ActorClass._ray_from_modified_class(
  File "/home/paco/anaconda3/lib/python3.8/site-packages/ray/actor.py", line 383, in _ray_from_modified_class
    self = DerivedActorClass.__new__(DerivedActorClass)
  File "rayCy.pyx", line 9, in rayCy.CyFoo.__cinit__
    def __cinit__ (self, int x):
TypeError: __cinit__() takes exactly 1 positional argument (0 given)
make: *** [makefile:14: default] Error 1
```
