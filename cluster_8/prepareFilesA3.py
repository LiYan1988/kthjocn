# -*- coding: utf-8 -*-
"""
Created on Sun Jan 08 09:20:59 2017

@author: celin

simulations for A3
"""

import os
from sdm import *
from shutil import copyfile
import pandas as pd

def copy_template(src, dst, replace_lines):
    destination = open(dst, 'wb')
    source = open(src, 'rU')
    for l, line in enumerate(source):
        if l in replace_lines.keys():
            destination.write(replace_lines[l])
        else:
            destination.write(line)
    source.close()
    destination.close()

np.random.seed(2016)

num_pods=200
max_pod_connected=95
min_pod_connected=15
num_cores=5
num_slots=80

data_rate_choice = [50, 400]

data_rate_probs = {}
data_rate_probs['90_10'] = [0.90, 0.10]

rootdir = os.getcwd()
num_stat = []
thp_stat = []
for k, v in data_rate_probs.items():
    # make simulation directory
    if not os.path.exists(k):
        os.mkdir(k)
    print k
    os.chdir(k)
    # make traffic matrix directory
    tm_folder = 'trafficMatrix'
    num_tmp = []
    thp_tmp = []
    num_stat.append({i:0 for i in data_rate_choice})
    thp_stat.append({i:0 for i in data_rate_choice})
    if not os.path.exists(tm_folder):
        os.mkdir(tm_folder)
    os.chdir(tm_folder)
    for i in range(20):
        t = Traffic(num_pods=num_pods, max_pod_connected=max_pod_connected, 
                    min_pod_connected=min_pod_connected, 
                    capacity_choices=data_rate_choice,
                    capacity_probs=v)
        t.generate_traffic()
        filename='traffic_matrix_{}.csv'.format(i)
        df = pd.DataFrame(t.traffic_matrix)
        df.to_csv(filename, index=False, header=False)
        t.value_count()
        num_tmp.append(t.number_count)
        thp_tmp.append(t.throughput_count)
        for j in data_rate_choice:
            num_stat[-1][j] += num_tmp[-1][j]
            thp_stat[-1][j] += thp_tmp[-1][j]
    num_sum = sum(num_stat[-1].values())
    thp_sum = sum(thp_stat[-1].values())
    num_stat[-1] = {i:1.*num_stat[-1][i]/num_sum for i in data_rate_choice}
    thp_stat[-1] = {i:1.*thp_stat[-1][i]/thp_sum for i in data_rate_choice}
    os.chdir('../')
    
    # make A1 directory
    workdir = 'A1_pod100'
    if not os.path.exists(workdir):
        os.mkdir(workdir)
    os.chdir(workdir)
    for i in range(20):
        # write .py file
        src = os.path.join(rootdir, 'templateA1.py')
        tm_name = 'traffic_matrix_{}'.format(i)
        if not os.path.exists('traffic_matrix_{}'.format(i)):
            os.mkdir(tm_name)
        os.chdir(tm_name)
        line16 = "num_cores={}\n".format(num_cores)
        line17 = "num_slots={}\n".format(num_slots)
        line19 = "mtridx = {} \n".format(i)
        line23 = "filename = 'traffic_matrix_{}.csv'\n".format(i)
        replace_lines = {16:line16, 17:line17, 19:line19, 23:line23}
        dst = 'A1_{}.py'.format(i)
        copy_template(src, dst, replace_lines)
#        copyfile('../../../sdm.py', 'sdm.py')
#        copyfile('../../{}/traffic_matrix_{}.csv'.format(tm_folder, i), 
#                 './traffic_matrix_{}.csv'.format(i))
        # write .sh file
        src = os.path.join(rootdir, 'templateA1.sh')
        replace_lines = {}
        replace_lines[2] = "#SBATCH -p hebbe\n" # change if use hebbe
        replace_lines[3] = "#SBATCH -J A1_{}-{}\n".format(i, k)
        replace_lines[7] = "#SBATCH -o A1_{}-{}.stdout\n".format(i, k)
        replace_lines[8] = "#SBATCH -e A1_{}-{}.stderr\n".format(i, k)
        replace_lines[16] = "pdcp ../../trafficMatrix/traffic_matrix_"+str(i)+\
            ".csv $TMPDIR\n"
        replace_lines[17] = "pdcp ../../../sdm.py $TMPDIR"
        replace_lines[21] = "python A1_{}.py\n".format(i)
        dst = 'A1_{}.sh'.format(i)
        copy_template(src, dst, replace_lines)
        os.chdir('../')
        
    # make A2 directory
    os.chdir('../')
    workdir = 'A2_pod100'
    if not os.path.exists(workdir):
        os.mkdir(workdir)
    os.chdir(workdir)
    for i in range(20):
        # write .py file
        src = os.path.join(rootdir, 'templateA2.py')
        tm_name = 'traffic_matrix_{}'.format(i)
        if not os.path.exists('traffic_matrix_{}'.format(i)):
            os.mkdir(tm_name)
        os.chdir(tm_name)
        line16 = "num_cores={}\n".format(num_cores)
        line17 = "num_slots={}\n".format(num_slots)
        line19 = "mtridx = {} \n".format(i)
        line23 = "filename = 'traffic_matrix_{}.csv'\n".format(i)
        replace_lines = {16:line16, 17:line17, 19:line19, 23:line23}
        dst = 'A2_{}.py'.format(i)
        copy_template(src, dst, replace_lines)
#        copyfile('../../../sdm.py', 'sdm.py')
#        copyfile('../../{}/traffic_matrix_{}.csv'.format(tm_folder, i), 
#                 './traffic_matrix_{}.csv'.format(i))
        # write .sh file
        src = os.path.join(rootdir, 'templateA2.sh')
        replace_lines = {}
        replace_lines[2] = "#SBATCH -p hebbe\n" # change if use hebbe
        replace_lines[3] = "#SBATCH -J A2_{}-{}\n".format(i, k)
        replace_lines[7] = "#SBATCH -o A2_{}-{}.stdout\n".format(i, k)
        replace_lines[8] = "#SBATCH -e A2_{}-{}.stderr\n".format(i, k)
        replace_lines[16] = "pdcp ../../trafficMatrix/traffic_matrix_"+str(i)+\
            ".csv $TMPDIR\n"
        replace_lines[17] = "pdcp ../../../sdm.py $TMPDIR"
        replace_lines[21] = "python A2_{}.py\n".format(i)
        dst = 'A2_{}.sh'.format(i)
        copy_template(src, dst, replace_lines)
        os.chdir('../')
        
    # make A3 directory
    os.chdir('../')
    workdir = 'A3_pod100'
    if not os.path.exists(workdir):
        os.mkdir(workdir)
    os.chdir(workdir)
    for i in range(20):
        # write .py file
        src = os.path.join(rootdir, 'templateA3.py')
        tm_name = 'traffic_matrix_{}'.format(i)
        if not os.path.exists('traffic_matrix_{}'.format(i)):
            os.mkdir(tm_name)
        os.chdir(tm_name)
        line16 = "num_cores={}\n".format(num_cores)
        line17 = "num_slots={}\n".format(num_slots)
        line19 = "mtridx = {} \n".format(i)
        line23 = "filename = 'traffic_matrix_{}.csv'\n".format(i)
        replace_lines = {16:line16, 17:line17, 19:line19, 23:line23}
        dst = 'A3_{}.py'.format(i)
        copy_template(src, dst, replace_lines)
#        copyfile('../../../sdm.py', 'sdm.py')
#        copyfile('../../{}/traffic_matrix_{}.csv'.format(tm_folder, i), 
#                 './traffic_matrix_{}.csv'.format(i))
        # write .sh file
        src = os.path.join(rootdir, 'templateA3.sh')
        replace_lines = {}
        replace_lines[2] = "#SBATCH -p hebbe\n" # change if use hebbe
        replace_lines[3] = "#SBATCH -J A3_{}-{}\n".format(i, k)
        replace_lines[7] = "#SBATCH -o A3_{}-{}.stdout\n".format(i, k)
        replace_lines[8] = "#SBATCH -e A3_{}-{}.stderr\n".format(i, k)
        replace_lines[16] = "pdcp ../../trafficMatrix/traffic_matrix_"+str(i)+\
            ".csv $TMPDIR\n"
        replace_lines[17] = "pdcp ../../../sdm.py $TMPDIR"
        replace_lines[21] = "python A3_{}.py\n".format(i)
        dst = 'A3_{}.sh'.format(i)
        copy_template(src, dst, replace_lines)
        os.chdir('../')
    os.chdir('../../')