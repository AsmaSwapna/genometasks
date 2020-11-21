#!/usr/bin/env python
import sys
import re
import pearsonr

import math

def mean(x):
    assert len(x) > 0
    return float(sum(x)) / len(x)

def pearson_def(x, y):
    #assert len(x) == len(y)
    n = len(x)
    assert n > 0
    avg_x = mean(x)
    avg_y = mean(y)
    diffprod = 0
    xdiff2 = 0
    ydiff2 = 0
    for idx in range(n):
        xdiff = x[idx] - avg_x
        ydiff = y[idx] - avg_y
        diffprod += xdiff * ydiff # calculate numerator
        xdiff2 += xdiff * xdiff
        ydiff2 += ydiff * ydiff

    return diffprod / math.sqrt(xdiff2 * ydiff2) # return pearson correlation co-efficient 


def read_files(filestoprocess): 
    assert filestoprocess
    k = 1
    for input in filestoprocess:
        print "Processing %s" % input
        with open(input,'r') as afile:
            read_data = afile.read()
            n = len(read_data)  
            read_data_parsed = read_data
            for idx in range(n):  
                # Parsing the data           
                a =re.findall('[0-9]+\.[0-9]+', read_data[idx])
                if len(a) >0:
                    read_data_parsed[idx] = float(a)
            # store data 
            if k == 1:
                fa = read_data_parsed
            
            if k == 2:
                fb = read_data_parsed
            
            k = k+1 
    
    return fa,fb

if __name__ == '__main__':
    fa,fb = read_files(sys.argv[1:])
    print "Pearson coeeficient of the lists %f" % pearson_def(function_files(sys.argv[1:]))
   