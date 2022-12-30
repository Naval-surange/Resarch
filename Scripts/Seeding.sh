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



N=100

#rm -rf IT-*
#touch progress.txt
for ((i=68;i<=N;i++))
do 
	stdbuf -oL echo -e "At iteration $i at \t\t\t $(date)" >> progress.txt
	folder_name="IT-$i"
	mkdir $folder_name
	cp ./initial_files/* "./$folder_name/" ; cd $folder_name

	
	gmx_mpi editconf -f seed.pdb -o translated_seed.pdb -translate $(($RANDOM%6+2)) $(($RANDOM%6+2)) $(($RANDOM%6+2))
	gmx_mpi insert-molecules -f translated_seed.pdb  -ci paracetamol.pdb -nmol 1000 -box 10 10 10 -o box.gro
	
	stdbuf -oL echo -e "\tGenerated initial config at \t $(date)"  >> ../progress.txt
	
	echo -e "\tRunning EM \t\t\t $(date)" >> ../progress.txt
	gmx_mpi grompp -f em.mdp -c box.gro -p topol.top -o em.tpr 
	gmx_mpi mdrun -v -deffnm em -ntomp 39 

	#nvt -> temprature equiviblrium
	echo -e "\tRunning NVT \t\t\t $(date)" >> ../progress.txt
	gmx_mpi grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr 
	gmx_mpi mdrun -v -deffnm nvt -ntomp 39 

	#npt -> pressure equiviblrium
	echo -e "\tRunning NPT \t\t\t $(date)" >> ../progress.txt
	gmx_mpi grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr 
	gmx_mpi mdrun -v -deffnm npt -ntomp 39

	#MD - unbiased
	#gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_unbiased.tpr
	#gmx mdrun -v -deffnm md_unbiased -ntomp 39 -nb gpu

	#MD - biased
	echo -e "\tRunning MD \t\t\t $(date)" >> ../progress.txt
	gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_biased.tpr
	gmx_mpi mdrun -v -deffnm md_biased -plumed plumed.dat -ntomp 39 -nb gpu 
	
	cd ..
done	
