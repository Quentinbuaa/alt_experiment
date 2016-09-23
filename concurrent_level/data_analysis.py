#!/bin/python

from numpy import *

class Statistics:
    """
    The basic statistic of the experiment results
    """

    def __init__(self, result_filename,column_number):
        self.dic = {0:"minor page fault",
                1:"max usage",
                2:"cpu percentage"}

        self.result_filename = result_filename
        self.data = genfromtxt(self.result_filename)
        self.column=column_number
        self.getMean()
        self.getStd()

    def __str__(self):
        return("%s:mean:%f,\tstd:%f"%(self.dic[self.column],self.mean,self.std))

    def getMean(self):
        self.mean = mean(self.data[:,self.column])
    
    def getStd(self):
        self.std = std(self.data[:,self.column])

s1 =Statistics("env_tem.log",0)
s2 =Statistics("env_tem.log",1)
s3 =Statistics("env_tem.log",2)

print(s1)
print(s2)
print(s3)
