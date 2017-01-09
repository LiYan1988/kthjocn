# -*- coding: utf-8 -*-
"""
Created on Sun Jan 01 07:37:45 2017

@author: celin
"""

from sdm import *
import pandas as pd
import matplotlib.pyplot as plt
import copy

#x = np.random.choice([50, 400], size=(100,), p=[0.8, 0.2], replace=True)
#beta = 0.02
#prob = (400*beta+1)/(450*beta+2)
#x = sorted(x)
#tmp = copy.deepcopy(x)
#x_final = []
#while len(tmp)>0:
#    rndtmp = np.random.choice([0, 1], p=[1-prob, prob], size=1)
#    if rndtmp==0:
#        # output a small connection, then delete it
#        x_final.append(tmp.pop(0))
#    else:
#        # output a large connection, then delete it
#        x_final.append(tmp.pop(-1))
        
#%% generate traffic
np.random.seed(2017)
num_pods=100
max_pod_connected=95
min_pod_connected=15
num_cores=5
num_slots=80
t = Traffic(num_pods=num_pods, max_pod_connected=max_pod_connected, 
            min_pod_connected=min_pod_connected, 
            capacity_choices=[50, 400],
            capacity_probs=[0.9, 0.1])
t.generate_traffic()
tm = t.traffic_matrix

#%% arch1    
results = {}
obj_results = {}
cnk_results = {}
thp_results = {}
obj_ub = {}
cnk_ub = {}
thp_ub = {}
#betav = np.array([0, 
##    1e-5, 2e-5, 4e-5, 8e-5, 
#    1e-4, 2e-4, 4e-4, 8e-4, 
#    1e-3, 2e-3, 4e-3, 8e-3, 
#    1e-2, 2e-2, 4e-2, 8e-2, 
#    1e-1, 2e-1, 4e-1, 1, 10])
betav = np.array([0.01, 0.02, 0.04, 0.08])
#betav = np.array([0.01])
for beta in betav:
    m = Arch2_decompose(tm, num_slots=num_slots, num_cores=num_cores, 
                        alpha=1, beta=beta)
    m.create_model_routing(mipfocus=1,timelimit=3600,mipgap=0.05,method=2) # Method=2 or 3
    
    m.multiple_heuristic()
    results[beta] = pd.DataFrame(m.heuristics_results)
#    m.create_model_sa(mipfocus=1,timelimit=200,mipgap=0.1)
    obj_results[beta] = results[beta].iloc[0, :]
    cnk_results[beta] = results[beta].iloc[1, :]
    thp_results[beta] = results[beta].iloc[2, :]
    obj_ub[beta] = m.obj_ub_
    cnk_ub[beta] = m.connection_ub_
    thp_ub[beta] = m.throughput_ub_

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

x = obj_final['cnk_ub']
y = obj_final['thp_ub']
x1 = obj_final['cnk_bh']
y1 = obj_final['thp_bh']
plt.plot(x1, y1, 'sb', x, y, 'or')

#obj_final.to_csv('')
