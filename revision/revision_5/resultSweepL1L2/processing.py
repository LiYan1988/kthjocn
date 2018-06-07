# -*- coding: utf-8 -*-
"""
Created on Thu Jun  7 11:04:21 2018

@author: lyaa
"""

import numpy as np
import pandas as pd
import os
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

os.chdir('C:\\Users\\lyaa\\Desktop\\kthjocn\\revision\\revision_5\\resultSweepL1L2\\generated_data')
rootdir = os.getcwd()

def extract_traffic(traffic_matrix_folder):
    os.chdir(traffic_matrix_folder)
    file_list = os.listdir(os.getcwd())
    traffic_dict = {}
    total_connections = {}
    total_throughput = {}
    for filename in file_list:
        traffic_index = int(filename.split('.')[0].split('_')[-1])
        traffic_dict[traffic_index] = pd.read_csv(filename, header=None)
        total_connections[traffic_index] = traffic_dict[traffic_index].astype(bool).sum().sum()
        total_throughput[traffic_index] = traffic_dict[traffic_index].sum().sum()
    
    os.chdir('..')
    return traffic_dict, total_connections, total_throughput

def extract_result(folder_name):
    os.chdir(folder_name)
    folder_list = os.listdir(os.getcwd())
    connection_heuristic = {}
    connection_bound = {}
    throughput_heuristic = {}
    throughput_bound = {}
    
    connection_heuristic_average = []
    connection_bound_average = []
    throughput_heuristic_average = []
    throughput_bound_average = []
    beta = {}
    
    for folder in folder_list:
        folder_index = int(folder.split('_')[-1])
        os.chdir(folder)
        result_tmp = pd.read_csv('obj_final_{}.csv'.format(folder_index))
        beta[folder_index] = np.array(result_tmp['Unnamed: 0'])
        connection_bound[folder_index] = np.array(result_tmp['cnk_ub'])
        connection_heuristic[folder_index] = np.array(result_tmp['cnk_bh'])
        throughput_bound[folder_index] = np.array(result_tmp['thp_ub'])
        throughput_heuristic[folder_index] = np.array(result_tmp['thp_bh'])
        
        connection_heuristic_average.append(list(result_tmp['cnk_bh']))
        connection_bound_average.append(list(result_tmp['cnk_ub']))
        throughput_heuristic_average.append(list(result_tmp['thp_bh']))
        throughput_bound_average.append(list(result_tmp['thp_ub']))
        
        os.chdir('..')
        
    connection_bound_average = [np.mean(x) for x in zip(*connection_bound_average)]
    connection_heuristic_average = [np.mean(x) for x in zip(*connection_heuristic_average)]
    throughput_bound_average = [np.mean(x) for x in zip(*throughput_bound_average)]
    throughput_heuristic_average = [np.mean(x) for x in zip(*throughput_heuristic_average)]
    
    os.chdir('..')
    return beta, connection_bound, connection_heuristic, throughput_bound, \
        throughput_heuristic, connection_bound_average, connection_heuristic_average, \
        throughput_bound_average, throughput_heuristic_average
    
def calculate_blocking(result, total):
    '''result is a dict of N np.array, total is a dict of N numbers'''
    blocking = {}
    for k, v in total.items():
#        print result[k], v
        blocking[k] = 1 - result[k].astype(float)/float(v)
        
    blocking_average = [np.mean(x) for x in zip(*blocking.values())]
        
    return blocking, blocking_average

def plot_simple(x, y, x1, y1, title):
    fig = plt.figure()
    bound,  = plt.plot(x, y, 'r', label='bound')
    heuristic,  = plt.plot(x1, y1, 'b', label='heuristic')
    plt.legend(handles = [bound, heuristic])
    plt.title(title)
    plt.close(fig)
    
    return fig

#%%
traffic_matrices = {}
connections = {}
throughput = {}

beta = {}
connection_bound = {}
connection_heuristic = {}
connection_bound_average = {}
connection_heuristic_average = {}
throughput_bound = {}
throughput_heuristic = {}
throughput_bound_average = {}
throughput_heuristic_average = {}

blocking_bound = {}
blocking_heuristic = {}
blocking_bound_average = {}
blocking_heuristic_average = {}

fig_A1 = []
fig_A2 = []
fig_A3 = []

for folder_name in os.listdir(rootdir):
    if not os.path.isdir(folder_name):
        continue
    l1 = float(folder_name.split('_')[0])
    l2 = float(folder_name.split('_')[1])
    print os.getcwd()
    os.chdir(folder_name)
    print os.getcwd()
    
    traffic_matrices[l1, l2], connections[l1, l2], throughput[l1, l2] = \
        extract_traffic('trafficMatrix')
        
    beta, connection_bound['A1', l1, l2], connection_heuristic['A1', l1, l2], \
        throughput_bound['A1', l1, l2], throughput_heuristic['A1', l1, l2], \
        connection_bound_average['A1', l1, l2], connection_heuristic_average['A1', l1, l2], \
        throughput_bound_average['A1', l1, l2], throughput_heuristic_average['A1', l1, l2] = \
        extract_result('A1_pod100')
    
    blocking_bound['A1', l1, l2], blocking_bound_average['A1', l1, l2] = \
        calculate_blocking(connection_bound['A1', l1, l2], connections[l1, l2])
    blocking_heuristic['A1', l1, l2], blocking_heuristic_average['A1', l1, l2] = \
        calculate_blocking(connection_heuristic['A1', l1, l2], connections[l1, l2])

    fig_A1.append(plot_simple(blocking_bound_average['A1', l1, l2], 
                              throughput_bound_average['A1', l1, l2],
                              blocking_heuristic_average['A1', l1, l2], 
                              throughput_heuristic_average['A1', l1, l2],
                              'A1, L1={}, L2={}'.format(l1, l2)))
        
    beta, connection_bound['A2', l1, l2], connection_heuristic['A2', l1, l2], \
        throughput_bound['A2', l1, l2], throughput_heuristic['A2', l1, l2], \
        connection_bound_average['A2', l1, l2], connection_heuristic_average['A2', l1, l2], \
        throughput_bound_average['A2', l1, l2], throughput_heuristic_average['A2', l1, l2] = \
        extract_result('A2_pod100')
    
    blocking_bound['A2', l1, l2], blocking_bound_average['A2', l1, l2] = \
        calculate_blocking(connection_bound['A2', l1, l2], connections[l1, l2])
    blocking_heuristic['A2', l1, l2], blocking_heuristic_average['A2', l1, l2] = \
        calculate_blocking(connection_heuristic['A2', l1, l2], connections[l1, l2])
   
    fig_A2.append(plot_simple(blocking_bound_average['A2', l1, l2], 
                              throughput_bound_average['A2', l1, l2],
                              blocking_heuristic_average['A2', l1, l2], 
                              throughput_heuristic_average['A2', l1, l2],
                              'A2, L1={}, L2={}'.format(l1, l2)))
     
    beta, connection_bound['A3', l1, l2], connection_heuristic['A3', l1, l2], \
        throughput_bound['A3', l1, l2], throughput_heuristic['A3', l1, l2], \
        connection_bound_average['A3', l1, l2], connection_heuristic_average['A3', l1, l2], \
        throughput_bound_average['A3', l1, l2], throughput_heuristic_average['A3', l1, l2] = \
        extract_result('A3_pod100')

    blocking_bound['A3', l1, l2], blocking_bound_average['A3', l1, l2] = \
        calculate_blocking(connection_bound['A3', l1, l2], connections[l1, l2])
    blocking_heuristic['A3', l1, l2], blocking_heuristic_average['A3', l1, l2] = \
        calculate_blocking(connection_heuristic['A3', l1, l2], connections[l1, l2])

    fig_A3.append(plot_simple(blocking_bound_average['A3', l1, l2], 
                              throughput_bound_average['A3', l1, l2],
                              blocking_heuristic_average['A3', l1, l2], 
                              throughput_heuristic_average['A3', l1, l2],
                              'A3, L1={}, L2={}'.format(l1, l2)))

    os.chdir('..')

if os.path.isfile('A1.pdf'):
    os.remove('A1.pdf')
pp = PdfPages('A1.pdf')
for fig in fig_A1:
    pp.savefig(fig)
pp.close()

if os.path.isfile('A2.pdf'):
    os.remove('A2.pdf')
pp = PdfPages('A2.pdf')
for fig in fig_A2:
    pp.savefig(fig)
pp.close()

if os.path.isfile('A3.pdf'):
    os.remove('A3.pdf')
pp = PdfPages('A3.pdf')
for fig in fig_A3:
    pp.savefig(fig)
pp.close()

beta = beta[0]