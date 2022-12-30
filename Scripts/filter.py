import os
import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

if len(sys.argv) != 5:
    print("Usage: python filter.py FILE_NAME COLVAR_NAME N_Frame N_Std")
    sys.exit(1)
    

FILE_NAME = sys.argv[1]
COLVAR_NAME = sys.argv[2]
N_Frame = int(sys.argv[3])
N_Std = float(sys.argv[4])


ITs = range(1, 101)

values = []
n_iters = 0
for i in ITs:
    path = f"./IT-{i}/{FILE_NAME}"
    if os.path.exists(path):
        n_iters += 1
        with open(path, 'r') as f:
            # read first line
            header = f.readline()
            column_names = header.split()[2:]
            df = pd.read_csv(f, sep='\s+', names=column_names)
            values.append(list(df[COLVAR_NAME].values[-N_Frame:]))

avg = np.mean(values, axis=1)

# plot histogram of the averages

(n, bins, patches) = plt.hist(avg, bins=20)
plt.xlabel(f"Average of the last {N_Frame} frames")
plt.ylabel("Frequency")
plt.savefig("histogram.png")

print(f"Mean: {np.mean(avg)}, STD: {np.std(avg)}")

High_threashold = np.mean(avg) + N_Std * np.std(avg)
Low_threashold = np.mean(avg) - N_Std * np.std(avg)

#print values more than threashold
print(f"High threshold: {High_threashold}",end=":  ")
for i in range(n_iters):
    if avg[i] > High_threashold:
        print(f"IT-{ITs[i+1]} ",end="")

print(f"\nLow threshold: {Low_threashold}",end=":  ")
for i in range(n_iters):
    if avg[i] < Low_threashold:
        print(f"IT-{ITs[i+1]} ",end="")
print()
