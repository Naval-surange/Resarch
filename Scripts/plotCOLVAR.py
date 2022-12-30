import sys
from scipy.interpolate import make_interp_spline
import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

if(len(sys.argv) != 2 and len(sys.argv) != 3):
    print('Usage: python plot_COLVAR.py <COLVAR_FILE> <SMOOTHNESS>')
    sys.exit(1)
if(len(sys.argv) == 3):
    smoothness = int(sys.argv[2])
    smoothness = smoothness + 1 if smoothness % 2 == 0 else smoothness
else:
    smoothness = 51

fName = sys.argv[1]


with open(fName, 'r') as f:
    # read first line
    header = f.readline()
    column_names = header.split()[2:]
    df = pd.read_csv(f, sep='\s+', names=column_names)
        
# plot Data

plt.figure(figsize=(10, 5*len(df.columns)))
for i, col in enumerate(df.columns[1:]):
    # smootheen the data
    x = np.linspace(0, len(df[col]),len(df[col]))
    spl = make_interp_spline(x, df[col], k=smoothness)
    xnew = np.linspace(0, len(df[col]),len(df[col]))
    df[col] = spl(xnew)


    plt.subplot(len(df.columns), 1, i+1)
    plt.plot(df[col])
    plt.ylabel(col)
    plt.xlabel('time')

plt.tight_layout()
plt.savefig('COLVAR.png', dpi=300)
plt.show()
