#ifndef LIBRAYCY_HPP
#define LIBRAYCY_HPP

#include <string>

namespace raycy {
  class Foo {
  public:
    int x;
    std::string name;

    Foo ();
    ~Foo ();

    int initialize (int x, std::string name);
    int test_method (int val);
    std::string get_name ();
  };
}

#endif
