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


rm -rf bias_*

for bias in 1 2 4 8 16 32 64
do
	cur_dir="bias_$bias"

	mkdir $cur_dir 
	cp ./initial_files/* $cur_dir

	cd $cur_dir 

	plumed_file="q6: Q6 SPECIESA=1 SPECIESB=21:14000:20 R_0=1.63800 NN=12 MEAN \nrestraint: METAD ARG=q6.mean SIGMA=0.03 HEIGHT=1BIASFACTOR=$bias PACE=500  \nPRINT ARG=restraint.bias STRIDE=100 FILE=Q6_COLVAR \n" 
			
	echo -e $plumed_file > "plumed.dat"

	gmx_mpi grompp -f em.mdp -c box.gro -p topol.top -o em.tpr
	gmx_mpi mdrun -v -deffnm em -ntomp 39

	#nvt -> temprature equiviblrium
	gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
	gmx_mpi mdrun -v -deffnm nvt -ntomp 39

	#npt -> pressure equiviblrium
	gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
	gmx_mpi mdrun -v -deffnm npt -ntomp 39

	#MD - unbiased
	gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_unbiased.tpr
	gmx_mpi mdrun -v -deffnm md_unbiased -ntomp 39 -nb gpu

	#MD - biased
	gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_biased.tpr
	gmx_mpi mdrun -v -deffnm md_biased -plumed plumed.dat -ntomp 39 -nb gpu
	
	
	cd ..
done
