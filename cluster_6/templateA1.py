# -*- coding: utf-8 -*-
"""
Created on Thu Aug  4 15:15:10 2016

@author: li

optimize both throughput and connections
"""

#import sys
#sys.path.insert(0, '/home/li/Dropbox/KTH/numerical_analysis/ILPs')
from sdm import *
from gurobipy import *
import pandas as pd
np.random.seed(2010)

num_cores=5
num_slots=80

mtridx = 0
time_limit_routing = 1800 # 1000
time_limit_sa = 108 # 10800

filename = 'traffic_matrix_'+str(mtridx)+'.csv'
#    print filename
tm = []
with open(filename) as f:
    reader = csv.reader(f)
    for idx, row in enumerate(reader):
        row = [float(u) for u in row]
        tm.append(row)

tm = np.array(tm)

betav = np.array([0, 
    1e-5, 2e-5, 4e-5, 8e-5, 
    1e-4, 2e-4, 4e-4, 8e-4, 
    1e-3, 2e-3, 4e-3, 8e-3, 
    1e-2, 2e-2, 4e-2, 8e-2, 
    1e-1, 2e-1, 4e-1, 1, 10])
#betav = np.array([1e-3, 2e-3, 4e-3, 8e-3])
results = {}
obj_results = {}
cnk_results = {}
thp_results = {}
obj_ub = {}
cnk_ub = {}
thp_ub = {}

for beta in betav:        
    m = Arch1_decompose(tm, num_slots=num_slots, num_cores=num_cores, 
        alpha=1,beta=beta)
    m.create_model_routing(mipfocus=1,timelimit=time_limit_routing,mipgap=0.05, method=2)
    m.multiple_heuristic()

    results[beta] = pd.DataFrame(m.heuristics_results)
    obj_results[beta] = results[beta].iloc[0, :]
    cnk_results[beta] = results[beta].iloc[1, :]
    thp_results[beta] = results[beta].iloc[2, :]
    obj_ub[beta] = m.obj_ub_
    cnk_ub[beta] = m.connection_ub_
    thp_ub[beta] = m.throughput_ub_

    # write results
    m.write_result_csv('cnklist_heuristic_%d_%.2e.csv'%(mtridx,beta), m.cnklist_)


obj_results = pd.DataFrame(obj_results)
cnk_results = pd.DataFrame(cnk_results)
thp_results = pd.DataFrame(thp_results)
obj_ub = pd.Series(obj_ub)
cnk_ub = pd.Series(cnk_ub)
thp_ub = pd.Series(thp_ub)
argmax = {betav[i]:obj_results.iloc[:, i].argmax() for i in range(len(betav))}
objmax = {betav[i]:obj_results.iloc[:, i].max() for i in range(len(betav))}
cnk_bh = {betav[i]:cnk_results.loc[argmax[betav[i]], betav[i]] 
              for i in range(len(betav))}
thp_bh = {betav[i]:thp_results.loc[argmax[betav[i]], betav[i]] 
              for i in range(len(betav))}
obj_final = pd.DataFrame({'ub':obj_ub, 'best_heuristic':objmax, 
                          'best_method':argmax, 'cnk_bh':cnk_bh, 
                          'thp_bh':thp_bh, 'cnk_ub':cnk_ub, 'thp_ub':thp_ub})
obj_final['optimality'] = obj_final['best_heuristic']/obj_final['ub']

obj_results.to_csv('obj_results_{}.csv'.format(mtridx))
cnk_results.to_csv('cnk_results_{}.csv'.format(mtridx))
thp_results.to_csv('thp_results_{}.csv'.format(mtridx))
obj_final.to_csv('obj_final_{}.csv'.format(mtridx))