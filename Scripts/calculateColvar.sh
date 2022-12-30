#!/bin/bash
#SBATCH -A research
#SBATCH --qos=medium
#SBATCH --gres=gpu:0
#SBATCH --mincpus=1
#SBATCH -n 16
#SBATCH --mem-per-cpu=2048
#SBATCH --time=4-00:00:00
#SBATCH --mail-type=END


echo "Running on node: $SLURM_JOB_NODELIST ;;  in directory $PWD"

export PATH=/home2/naval.s/programms/gromacs-2021.4/installed/bin/:/home2/naval.s/programms/plumed-2.8.0/installed/bin/:/home2/naval.s/programms/Python-3.10.6/installed/bin/:/home2/naval.s/programms/cmake/cmake-3.24.1-linux-x86_64/bin/:/bin/:/usr/local/bin/:/usr/local/sbin/:/usr/sbin/:/usr/bin

export LD_LIBRARY_PATH=/home2/naval.s/programms/plumed-2.8.0/installed/lib/:/home2/naval.s/programms/gromacs-2021.4/installed/lib:/usr/lib/:usr/lib64/:/lib/:/lib64


touch progress.txt
for((i=1;i<=100;i++))
do	
	echo "At IT-$i" >> progress.txt
	cd ./IT-$i;
	plumed driver --plumed ../plumed.dat --ixtc md_biased.xtc
	cd ..
done
