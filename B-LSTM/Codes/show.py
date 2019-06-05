#!/usr/bin/python
# -*- coding: latin-1 -*-
"""function to load image from picle """
import pickle as pkl
import matplotlib.pyplot as plt
import sys

name = 'targetVsPrediction.pickle'

#def showPickle(name):
ax = pkl.load(open(name,'rb'))
plt.show(ax)
	#input("Press Enter to continue...")

if __name__ == '__main__':
	print ('sys.argv: ', sys.argv)
	if len(sys.argv) > 1:
		showPickle(sys.argv[1])
	else:
		print ("no argument")
