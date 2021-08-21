#include "libraycy.hpp"

using namespace raycy;

// constructor
Foo::Foo () {}

// destructor
Foo::~Foo () {}


// workaround: initializer
int
Foo::initialize (int x, std::string name) {
  this->x = x;
  this->name = name;

  // Ray requires a returned value
  return 0;
}


int
Foo::test_method (int val) {
  return this->x * val;
}


std::string
Foo::get_name () {
  return this->name;
}
