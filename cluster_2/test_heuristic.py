# -*- coding: utf-8 -*-
"""
Created on Wed Dec 28 04:10:10 2016

@author: celin
"""

from sdm import *
import pandas as pd

#%% generate traffic
num_pods=50
max_pod_connected=300
min_pod_connected=150
mean_capacity=200
variance_capacity=100
num_cores=3
num_slots=30
t = Traffic(num_pods=num_pods, max_pod_connected=max_pod_connected, 
            min_pod_connected=min_pod_connected, 
            capacity_probs=[0.1875, 0.1875, 0.1875, 0.1875, 0.1250, 0.1250])
t.generate_traffic()
tm = t.traffic_matrix

#%% arch1    
m = Arch1_decompose(tm, num_slots=num_slots, num_cores=num_cores, alpha=1, beta=0.0)
m.create_model_routing(mipfocus=1,timelimit=100,mipgap=0.1,method=2) # Method=2 or 3
m.heuristic()
m.write_result_csv('test.csv',m.cnklist_heuristic_)
print m.obj_ub_
print m.obj_heuristic_
