import textwrap
import time


def timeit(f):
    def wrapper(*args, **kwargs):
        st = time.perf_counter()
        result = f(*args, **kwargs)
        et = time.perf_counter()
        tt = et - st
        ak = textwrap.shorten(f"{args}, {kwargs}", width=50, placeholder="...")
        print(f"f: {f.__name__} a: [{ak}] t: {tt:.4f} sec")
        return result
    return wrapper
