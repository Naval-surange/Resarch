for((i=1;i<=100;i++))
do 
	cd IT-$i
	rm *.mdp box.pdb paracetamol.pdb seed.pdb plumed.dat paracetamol_GMX.itp seed_diff_res_id.pdb topol.top Template.cif
	cd ..
done
