
# coding: utf-8

# In[32]:



import os
directory = '/Users/weihan/Desktop/Winter_2019/computation_for_biologist/Final_project'
import subprocess


# In[33]:


cd /Users/weihan/Desktop/Winter_2019/computation_for_biologist/Final_project


# In[35]:


for file in os.listdir(directory):
    print(file)
    os.system(" ".join(['/Library/Frameworks/R.framework/Versions/3.5/Resources/Rscript', '/Users/weihan/Desktop/Winter_2019/computation_for_biologist/Weihan_final_project.R',file]))
    

