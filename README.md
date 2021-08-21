# rayCy_example

Demo / test harness for resolving a code conflict in the use of
Cython-based Python classes as Ray actors.


## Background

Here's what the Cython docs provide as example of wrapping a C++
object in Python:

  * <https://cython.readthedocs.io/en/latest/src/userguide/wrapping_CPlusPlus.html>

Getting that example to run is a bit of a challenge, especially when
your use case uses argument types other than simple integers:

  * <https://stackoverflow.com/questions/29168575/wrap-c-class-with-cython-getting-the-basic-example-to-work>

Using the `@ray.remote` decorator on Python classes provides a way to
define *remote classes*, i.e., to implement *actor pattern* in Python
for distributed applications:

  * <https://github.com/DerwenAI/ray_tutorial>

The documentation for Ray has some limited discussion about Cython
integration, which describe the use of *remote function* but not about
using *remote classes*:

  * <https://docs.ray.io/en/stable/example-cython.html>

Throughout much of the history of the [Ray Project](https:://ray.io/)
portions of its documentation have been wildly out of sync with the
code releases.  In general, larger production use cases for Ray do not
use the latest releases, and unfortunately people do not trust the
documentation.  However, notably since Ray Summit 2021 this situation
has begun to improve.


To illustrate the central issue here, if you use Cython extensions as
base classes in Python and then attempt to use Ray decorators on those
Python subclasses, Ray will throw exceptions about the constructors:

  * <https://discuss.ray.io/t/errors-using-ray-remote-decorator-on-a-python-subclass-from-a-cython-wrapper/3303>

This code conflict has been explored in more detail, with many thanks
to [@astrophysaxist](https://github.com/astrophysaxist):

  * <https://stackoverflow.com/questions/57928257/cython-class-initialization-in-ray>
  * <https://github.com/astrophysaxist/cython_test>

Note that those other "answers" on StackOverflow (including one of the
Ray committers) really missed the point.


This repo shows a working example of how integrate Cython and Ray
usage, albeit with the understanding that this is specifically not
supported by Ray.


## Evaluation

Note that this example uses `make` to compile the C++ and then invokes
command line Cython to handle the build.
This is in lieu of using `setup.py` due to other external requirements
for building the target use case.

Run this example code via:

  1. `pip install -r requirements.txt`
  2. `make`

Pytest will report whether it ran successfully.
