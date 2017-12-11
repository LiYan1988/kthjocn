#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Dec 10 15:37:04 2017

@author: li
"""

#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Dec 10 15:18:36 2017

@author: li
"""

import numpy as np
from math import pi
import matplotlib.pyplot as plt
import pandas as pd

df_pdf = {}
meanv1 = [50, 75, 100, 125]
meanv2 = [400, 425, 450, 475]
column_names = []

for n in range(4): 

    mu_1 = meanv1[n]
    mu_2 = meanv2[n]
    sigma_1 = 25
    sigma_2 = 25
    n_samples = 100
    num_repetition = 20
    
    mu_1 = float(mu_1)
    mu_2 = float(mu_2)
    sigma_1 = float(sigma_1)
    sigma_2 = float(sigma_2)
    
    data_samples_1_min = float(max(mu_1-2*sigma_1,0)+4*sigma_1/n_samples)
    data_samples_1_max = float(mu_1+2*sigma_1)
    data_samples_1_step = float((data_samples_1_max-data_samples_1_min)/n_samples)
    data_samples_1 = np.arange(data_samples_1_min, data_samples_1_max, data_samples_1_step, dtype=np.float)
    prob_1 = 1/np.sqrt(2*pi*sigma_1**2)*np.exp(-(data_samples_1-mu_1)**2/(2*sigma_1**2))
    prob_1 = prob_1/np.sum(prob_1)
    
    data_samples_2_min = float(mu_2-2*sigma_2+4*sigma_2/n_samples)
    data_samples_2_max = float(mu_2+2*sigma_2)
    if data_samples_1_max>data_samples_2_min:
        print('high')
        data_samples_2_max = float(mu_2+2*sigma_2)+data_samples_1_max-data_samples_2_min
        data_samples_2_min = data_samples_1_max
    data_samples_2_step = float(4*sigma_2/n_samples)
    data_samples_2 = np.arange(data_samples_2_min, data_samples_2_max, data_samples_2_step, dtype=np.float)
    prob_2 = 1/np.sqrt(2*pi*sigma_2**2)*np.exp(-(data_samples_2-mu_2)**2/(2*sigma_2**2))
    prob_2 = prob_2/np.sum(prob_2)
    
    plt.plot(data_samples_1, prob_1)
    plt.plot(data_samples_2, prob_2)
    plt.show()
    
    data_samples = np.concatenate((data_samples_1, data_samples_2), axis=0)
    prob = np.concatenate((0.9*prob_1, 0.1*prob_2), axis=0)
    plt.stem(data_samples, prob)
    plt.show()
    
    print(data_samples_1.mean())
    print(data_samples_2.mean())
    
    data_rate_choice = np.concatenate((data_samples_1, data_samples_2), axis=0)
    
    data_rate_probs = np.concatenate((0.9*prob_1, 0.1*prob_2), axis=0)
    
    plt.plot(data_rate_choice, data_rate_probs)
    plt.show()
    
    str1 = 'x_{}'.format(n)
    str2 = 'y_{}'.format(n)
    column_names.extend([str1, str2])
    df_pdf[str1] = data_rate_choice
    df_pdf[str2] = data_rate_probs
    
x = pd.DataFrame(df_pdf)
x.to_csv('traffic-distribution-fix-std.csv', index=None, columns=column_names)