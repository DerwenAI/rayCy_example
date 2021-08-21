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
