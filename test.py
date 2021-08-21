import ray
import rayCy


@ray.remote
class Foo (rayCy.CyFoo):
    def test_method ():
        print("hello")


if __name__ == "__main__":
    ray.init(ignore_reinit_error=True)

    f = Foo.remote()
    print(f)
    print(type(f))

    ray.shutdown()
    
