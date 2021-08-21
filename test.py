import ray
import rayCy


@ray.remote
class Foo (rayCy.CyFoo):
    def __init__ (self, x:int):
        print(x)


if __name__ == "__main__":
    ray.init(ignore_reinit_error=True)

    #f = Foo(1)
    f = Foo.remote(1)

    print(f)
    print(type(f))

    ray.shutdown()
    
