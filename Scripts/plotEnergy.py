import sys
import os
from scipy.interpolate import make_interp_spline
import numpy as np

import matplotlib.pyplot as plt

if(len(sys.argv) != 3):
    print('Usage: python plotEnergy.py <Folder Name> <FILE NAME>')
    sys.exit(1)

folderName = sys.argv[1]
fileName = sys.argv[2]

path = "./Analysis/" + folderName + "/" + fileName + ".xvg"

timeStep = []
Value = []
with open(path, 'r') as f:
    for line in f:
        if(line.startswith('#')):
            continue
        timeStep.append(float(line.split()[0]))
        Value.append(float(line.split()[1]))
        


plt.figure(figsize=(20,10))
plt.plot(timeStep,Value,label=folderName)
plt.legend()

plt.savefig(f'./Analysis/{folderName}/{fileName}.png')

#plt.show()