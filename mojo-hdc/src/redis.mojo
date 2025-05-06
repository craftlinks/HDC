from python import Python


def main():
    redis = Python.import_module("redis")
    r = redis.Redis(host="localhost", port=6379, db=0)
    print(r.ping())
