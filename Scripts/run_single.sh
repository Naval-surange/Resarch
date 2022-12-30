#!/bin/bash
#SBATCH -A research
#SBATCH --qos=medium
#SBATCH --gres=gpu:4
#SBATCH --mincpus=39
#SBATCH -n 16
#SBATCH --mem-per-cpu=2048
#SBATCH --time=4-00:00:00
#SBATCH --mail-type=END


echo "Running on node: $SLURM_JOB_NODELIST ;;  in directory $PWD"

export PATH=/home2/naval.s/programms/gromacs-2021.4/installed/bin/:/home2/naval.s/programms/plumed-2.8.0/installed/bin/:/home2/naval.s/programms/Python-3.10.6/installed/bin/:/home2/naval.s/programms/cmake/cmake-3.24.1-linux-x86_64/bin/:/bin/:/usr/local/bin/:/usr/local/sbin/:/usr/sbin/:/usr/bin

export LD_LIBRARY_PATH=/home2/naval.s/programms/plumed-2.8.0/installed/lib/:/home2/naval.s/programms/gromacs-2021.4/installed/lib:/usr/lib/:usr/lib64/:/lib/:/lib64


#createing box of 1000 ADP moleclues 
#gmx_mpi insert-molecules -ci ADP.pdb -o box.pdb -nmol 1000 -box 10 10 10 

#converting to gmx
#gmx_mpi pdb2gmx -f box.pdb -o box.gro

#Energy minimization
gmx_mpi grompp -f em.mdp -c box.gro -p topol.top -o em.tpr
gmx_mpi mdrun -v -deffnm em -ntomp 39

#nvt -> temprature equiviblrium
gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx_mpi mdrun -v -deffnm nvt -ntomp 39

#npt -> pressure equiviblrium
gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx_mpi mdrun -v -deffnm npt -ntomp 39

#MD - unbiased
#gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_unbaised.tpr
#gmx_mpi mdrun -v -deffnm md_unbaised -ntomp 39 -nb gpu

#MD - biased
gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_biased.tpr
gmx_mpi mdrun -v -deffnm md_biased -plumed plumed.dat -ntomp 39 -nb gpu

# Restarting
#gmx_mpi mdrun -v -deffnm md_biased_2 -plumed plumed_c.dat -ntomp 38 -cpi md_biased_2.cpt -append

# testing
#module add u18/plumed2/2.8.0 
#plumed config module crystallization
