import os
import sys
import pandas as pd

Targets = ["EM", "NVT", "NPT", "MD"]

dfEM = pd.DataFrame()
dfNVT = pd.DataFrame()
dfNPT = pd.DataFrame()
dfMD = pd.DataFrame()

dfs = [dfEM, dfNVT, dfNPT, dfMD]

ITs = range(1, 101)

for Target in Targets:
    for i in ITs:
        path = f"./IT-{i}/Analysis/{Target}/"
        for file in os.listdir(path):
            if file.endswith(".xvg"):
                df = pd.read_csv(path+file, sep='\s+', header=None)
                df.columns = ["Time", file.split(".")[0]+f"{i}"]
                dfs[Targets.index(Target)] = pd.concat(
                    [dfs[Targets.index(Target)], df], axis=1)

for i in range(len(Targets)):
    dfs[i] = dfs[i].loc[:, ~dfs[i].columns.duplicated()]
    dfs[i].to_csv(f"./{Targets[i]}.csv", index=False)

