
# coding: utf-8

# In[1]:

import numpy as np
from pandas import Series,DataFrame
import pandas as pd
import json
import glob as gb


# In[35]:

dframe1 = pd.read_table('/home/jaafar/testbed/monitoring/prometheus/pluginjaafar/data/file1.csv',sep=' ',header=None)


# In[36]:

dframe = dframe1.T


# In[37]:

dframe


# In[ ]:




# In[61]:

pathnames=gb.glob("/home/jaafar/testbed/monitoring/prometheus/pluginjaafar/data/*.csv")


# In[103]:

dframe = pd.read_table('/home/jaafar/testbed/monitoring/prometheus/pluginjaafar/data/file1.csv',sep=' ')
L = list()
L2 = list()
i=0


# In[109]:

for pathname in pathnames:
    dfs = pd.read_table(pathname,sep=' ')
    L.append(dfs)
    L2.append(dfs)
    #L2.extend(dfs)
    i=i+1


# In[110]:

result = pd.concat(L)
result2 = pd.concat(L2, ignore_index= True)


# In[111]:

R=result.T
R2=result2.T


# In[112]:

result2


# In[ ]:




# In[ ]:




# In[120]:

result2.to_excel("/home/jaafar/testbed/monitoring/prometheus/pluginjaafar/data/My_excel_file1.xls")


# In[ ]:




# In[ ]:



