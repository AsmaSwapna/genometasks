#!/usr/bin/env python
import sys
import re
import numpy as np
import math

# Bruteforce method to find the overlaps
# Improvement can be made in the algorithm
def overlap(a,b, count):
    score = 0
    new_start = max(a[0], b[0])
    new_end = min(a[1], b[1])
    if new_end >= new_start:
        score = count
        #print("Overlap # %d" % count)
    # else:
        #print("No overlap for combination%d" % count)
    return score

# Read input files
def read_files(filestoprocess): 
    assert filestoprocess
    k = 1
    for input in filestoprocess:
        print("Processing %s" % input)
        with open(input,'r') as afile:
            w, h = [int(x) for x in next(afile).split()]
            array = [[int(x) for x in line.split()] for line in afile]

            # # store data 
            if k == 1:
                fx = array
            
            if k == 2:
                fy = array
            k = k+1 
    
    return fx,fy

if __name__ == '__main__':
    x,y = read_files(sys.argv[1:])
    print("Counting overlap")
    # x = [[1,2],[3,6]]
    # y = [[0,1],[1,5]]
    xlength = len(x)
    ylength = len(y)
    print(x)
    count = 1
    for idx in range(xlength):
        for idy in range(ylength):
            
            overlap_count = overlap([x[idx][0], x[idx][1]], [y[idy][0], y[idy][1]], count) 
            count= count +1
    print("Total number of overlaps %d" % overlap_count)
    
    