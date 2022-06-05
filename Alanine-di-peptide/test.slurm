#!/bin/bash
#SBATCH -A research
#SBATCH --qos=medium
#SBATCH --gres=gpu:2
#SBATCH -n 8
#SBATCH --mem-per-cpu=1024
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=END

module add gromacs/2016.3-plumed

echo "Running on node: $SLURM_JOB_NODELIST ;;  in directory $PWD"

gmx_mpi mdrun -v -ntomp 1 -s prod.tpr   -deffnm unbiased -plumed plumed.dat  -nsteps 100000