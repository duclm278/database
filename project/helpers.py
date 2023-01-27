import textwrap
import time


def timeit(f):
    def wrapper(*args, **kwargs):
        ts = time.perf_counter()
        result = f(*args, **kwargs)
        te = time.perf_counter()
        tt = te - ts
        ak = textwrap.shorten(f"{args}, {kwargs}", width=50, placeholder="...")
        print(f"f: {f.__name__} a: [{ak}] t: {tt:.4f} sec")
        return result
    return wrapper
