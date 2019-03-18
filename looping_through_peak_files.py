
# coding: utf-8

# In[26]:



import os
directory = '/Users/weihan/Desktop/Winter_2019/computation_for_biologist/Final_project'
import subprocess


# In[27]:


cd /Users/weihan/Desktop/Winter_2019/computation_for_biologist/Final_project


# In[28]:


for file in os.listdir(directory):
    print(file)
    subprocess.check_call(['/Library/Frameworks/R.framework/Versions/3.5/Resources/Rscript', '/Users/weihan/Desktop/Winter_2019/computation_for_biologist/Weihan_final_project.R',file], shell=False)
    

