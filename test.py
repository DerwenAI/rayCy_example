#!/usr/bin/env python
# -*- coding: utf-8 -*-
# type: ignore

"""
Unit tests for rayCy_example
"""

import ray  # pylint: disable=E0401
import rayCy  # pylint: disable=E0401


@ray.remote
class SubFoo (rayCy.CyFoo):  # pylint: disable=I1101,R0903
    """
    example subclassing from a Cython extension
    """
    def test_method2 (self, _val:int) -> int:
        """
        example call into the Cython extension;
        not used in test -- rename to `test_method` to override
        """
        return super().test_method(_val)


def test_raycy () -> None:
    """
    exercise how Ray creates actors in Python from Cython extensions
    """
    ray.init(ignore_reinit_error=True)

    test_foo = SubFoo.remote()
    print(test_foo)
    print(type(test_foo))

    x = 23  # pylint: disable=C0103
    name = "xyzzy"

    obj_id = test_foo.initialize.remote(x, name.encode("utf-8"))
    ret_val = ray.get(obj_id)

    obj_id = test_foo.test_method.remote(x)
    ret_val = ray.get(obj_id)
    print(ret_val)
    assert ret_val == (x ** 2)

    obj_id = test_foo.get_name.remote()
    ret_val = ray.get(obj_id)
    print(ret_val)
    assert ret_val.decode("utf-8") == name

    ray.shutdown()


if __name__ == "__main__":
    # not part of test; used for rapid dev/test cycle
    test_raycy()
