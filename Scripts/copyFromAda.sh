for((i=1;i<=100;i++))
do
	scp naval.s@ada.iiit.ac.in:/home2/naval.s/Research/Seeding/IT-$i/\{md_biased.edr,Q6_bias,Q6_value,HILLS\} "/home/naval/Research/Paracetamol/Seeding/V-2/Analysis/IT-$i" >> scpOUT.txt
	echo "Done IT-$i"
done
