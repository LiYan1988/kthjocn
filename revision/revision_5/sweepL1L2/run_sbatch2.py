# -*- coding: utf-8 -*-
"""
Created on Sat Dec 03 14:17:28 2016

@author: celin
"""

import os
from subprocess import call
import re
import shutil

rootdir = os.getcwd()
#subdir = [name for name in os.listdir(rootdir) 
#        if os.path.isdir(os.path.join(rootdir, name))]

for root, dirs, files in os.walk(".", topdown=False):
    bashfile = [i for i in files if i.split('.')[-1]=='sh']
    flag = True
    for filename in files:
        if re.match('obj_final_[0-9]+\.csv', filename):
            flag = False
            break
    if flag and (len(bashfile)>0):
        for b in bashfile:
            os.chdir(root)
            call(['sbatch', b])
#            print os.path.join(root, b)
#            print os.getcwd()
            os.chdir(rootdir)
        