import numpy as np

# Real PyCOMPSs imports are available from within PyCOMPSs executions
from dataclay.contrib.dummy_pycompss import task, INOUT, IN, CONCURRENT

from dataclay import DataClayObject, dclayMethod


class Block(DataClayObject):
    """
    @dclayImport numpy as np

    @ClassField submatrix numpy.ndarray
    """
    @dclayMethod(submatrix="numpy.ndarray")
    def __init__(self, submatrix):
        self.submatrix = submatrix
    
    @task(target_direction=INOUT)
    @dclayMethod(a="model.matrix.Block", b="model.matrix.Block")
    def imuladd(self, a, b):
        """Perform an in-place fused multiply-addition operation.
        
        This FMA operation can be described as: self += a * b.
        """
        self.submatrix += a.submatrix @ b.submatrix


class Matrix(DataClayObject):
    """
    @dclayImport numpy as np

    # Total number of blocks is this number squared
    @ClassField num_blocks int
    # The size of a block (size of the block, which also is a square matrix)
    @ClassField blocksize int
    # The total side size of the matrix
    @ClassField size int
    # Internally, store the blocks in a two-dimensional structure
    @ClassField blocks list<list<model.matrix.Block>>
    """

    @dclayMethod(n="int")
    def __init__(self, n):
        # 1024 will be our blocksize
        self.blocksize = 1024
        self.num_blocks = n // 1024
        self.size = n

        # Start uninitialized
        self.blocks = list()
    
    @dclayMethod()
    def random(self):
        for i in range(self.num_blocks):
            row = list()
            self.blocks.append(row)
            for j in range(self.num_blocks):
                row.append(Block(np.random.random((self.blocksize, self.blocksize))))

    @dclayMethod()
    def zeros(self):
        for i in range(self.num_blocks):
            row = list()
            self.blocks.append(row)
            for j in range(self.num_blocks):
                row.append(Block(np.zeros((self.blocksize, self.blocksize))))

    @dclayMethod()
    def ones(self):
        for i in range(self.num_blocks):
            row = list()
            self.blocks.append(row)
            for j in range(self.num_blocks):
                row.append(Block(np.ones((self.blocksize, self.blocksize))))

    @dclayMethod(_local=True, other="model.matrix.Matrix", return_="model.matrix.Matrix")
    def __matmul__(self, other):
        # Initialize the output matrix with zeros
        result = Matrix(self.size)
        result.make_persistent()
        result.zeros()

        result_blocks = result.blocks
        
        # Evaluate the output by doing fused multiply-add operations on result
        for i in range(self.num_blocks):
            for k in range(self.num_blocks):
                for j in range(self.num_blocks):
                    result_blocks[i][j].imuladd(self.blocks[i][k], other.blocks[k][j])

        # Wait for consolidation on all blocks
        from pycompss.api.api import compss_wait_on
        for i in range(self.num_blocks):
            for j in range(self.num_blocks):
                result_blocks[i][j] = compss_wait_on(result_blocks[i][j])
        # Update the result blocks
        result.blocks = result_blocks
        return result
