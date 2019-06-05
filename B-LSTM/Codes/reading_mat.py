import numpy as np
import scipy.io as sio

def normalize_data(fileNameTraining_in,fileNameTraining_out):
    matrix1 = sio.loadmat(fileNameTraining_in)
    matrix1 = matrix1['inx']
    matrix_1 = (matrix1 - np.min(matrix1))/(np.max(matrix1) - np.min(matrix1))-0.5

    matrix12 = sio.loadmat(fileNameTraining_out)
    matrix12 = matrix12['ydx']
    matrix_12 = (matrix12 - np.min(matrix12))/(np.max(matrix12) - np.min(matrix12))-0.5

    size = len(matrix1)
    matrix = [[0 for x in range(2)] for y in range(size)]

    for j in range(2):
        for i in range(size):
            if (j==0):
                matrix[i][j] = matrix_1[i][0]
            else:
                matrix[i][j] = matrix_12[i][0]

    matrix_out = np.array(matrix)

    return matrix_out
