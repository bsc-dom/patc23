#!/usr/bin/env python3

# This file should be used with PyCOMPSs
# (typically, through an enqueue_compss command)

from model.matrix import Matrix

from pycompss.api.api import compss_barrier


if __name__ == "__main__":
    # Random generation of 3072 x 3072 matrices
    a = Matrix(3072)
    b = Matrix(3072)
    # Make them persistent
    a.make_persistent()
    b.make_persistent()
    # Initialize the two matrices with random numbers
    a.random()
    b.random()

    print("""
*****************************************************
Ready to start the multiplication
*****************************************************
""")

    c = a @ b

    print("""
*****************************************************
Multiplication finished
*****************************************************
""")
