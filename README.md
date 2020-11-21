# Genometasks
Given two types of text files of genomic information, using the SEGMENT format
and the FUNCTION format carry out the given 3 tasks.

## Task Execution
Initial environement setup using the Makefile
`make` 

## Task 1 - 2 SEGMENT files
### Overview:
Calculate the overlap (in number of positions) of the
regions from file X.s with regions from file Y.s.

Command to execute the task-
`python overlapcount.py *.s`

## Task 2 - 2 FUNCTION files:
### Overview:
Calculate the sample Pearson correlation coefficient of
the two number lists:

Command to execute the task-
`python pearsonvalue.py *.f`

## Task 3 - 1 SEGMENT and one FUNCTION file: :
### Overview:
CThe mean of the numbers in the
FUNCTION file whose positions are covered by the regions in the SEGMENT
file. That is, the regions in the SEGMENT file refer to positions on the
genome and hence to the index of the lines in the FUNCTION file.

INCOMPLETE

