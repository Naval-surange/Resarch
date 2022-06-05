#!/bin/bash
#SBATCH -A research
#SBATCH --qos=medium
#SBATCH --gres=gpu:2
#SBATCH -n 8 
#SBATCH --mem-per-cpu=1024
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=END

module add gromacs/2016.3-plumed

export ODIR=$PWD
export DIR=/scratch/unbiased.$SLURM_JOB_ID

echo "Starting in directory $ODIR"
echo "Submit directory $SLURM_SUBMIT_DIR"
mkdir $DIR; cd $DIR
echo "Now in direcoty $PWD"
echo "SLURM_NTASKS = $SLURM_NTASKS"

cp $ODIR/prod* .
cp $ODIR/plumed.dat .

echo "Running on node: $SLURM_JOB_NODELIST ;;  in directory $PWD" 

gmx_mpi mdrun -v -ntomp 1 -s prod.tpr   -deffnm unbiased -plumed plumed.dat  -nsteps 5000000
#gmx_mpi mdrun -s prod.tpr   -deffnm unbiased -plumed plumed.dat  -nsteps 50000
echo ${dir}

rsync -avz $DIR ada:/share2/prabhakar/.

