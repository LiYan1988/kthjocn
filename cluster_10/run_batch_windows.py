# -*- coding: utf-8 -*-
"""
Created on Sat Dec 03 14:17:28 2016

@author: celin
"""

import os
from subprocess import call
from shutil import copyfile

rootdir = os.getcwd()
#subdir = [name for name in os.listdir(rootdir) 
#        if os.path.isdir(os.path.join(rootdir, name))]

for root, dirs, files in os.walk(".", topdown=False):
    bashfile = [i for i in files if i.split('.')[1]=='py']
    if len(bashfile)>0:
        for b in bashfile:
        	try:
        		os.chdir(root)
        		idx = b.split('.')[0].split('_')[1]
        		copyfile('../../../sdm.py', 'sdm.py')
        		copyfile('../../trafficMatrix/traffic_matrix_{}.csv'.format(idx), 
        			'./traffic_matrix_{}.csv'.format(idx))
        		call(['python', b])
        		print os.path.join(root, b)
        		print 'current directory: {}'.format(os.getcwd())
        		print b
        		os.chdir(rootdir)
        	except:
        		continue