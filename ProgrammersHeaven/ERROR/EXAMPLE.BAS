option base 1:defint a-z:on error goto oops



main:
'                        Body of program



oops:
num = err
reset                        'close open files
open "R",#1,"error.dat",40   'open random access file with length of 40
field #1, 40 as text$        'allocate 40 for buffer
get #1,num                   'get record number which is same as error number
Print "Error #";num          'print the error number
print text$                  'and explanation
close #1
resume main                  'return to main body of program
