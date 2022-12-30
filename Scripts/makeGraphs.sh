for((i=1;i<=100;i++)) do 
    echo "plotting IT-$i" >> Progress.txt
    cd ./IT-$i
    #mkdir Analysis
    #mkdir Analysis/EM ; mkdir Analysis/NVT ; mkdir Analysis/NPT ; mkdir Analysis/MD 
    

    # EM
    #echo -e "\tRunning for EM" >> ../Progress.txt

    #printf "7" | gmx energy -f em.edr -o ./Analysis/EM/LJ.xvg -xvg none
    #printf "10" | gmx energy -f em.edr -o ./Analysis/EM/Potential.xvg -xvg none
    #printf "11" | gmx energy -f em.edr -o ./Analysis/EM/Pressure.xvg -xvg none
    #python3 ../plotEnergy.py EM LJ
    #python3 ../plotEnergy.py EM Potential
    #python3 ../plotEnergy.py EM Pressure


    # NVT
    #echo -e "\tRunning for NVT" >> ../Progress.txt
    #printf "7" | gmx energy -f nvt.edr -o ./Analysis/NVT/LJ.xvg -xvg none
    #printf "9" | gmx energy -f nvt.edr -o ./Analysis/NVT/Coulomb.xvg -xvg none
    #printf "11" | gmx energy -f nvt.edr -o ./Analysis/NVT/Potential.xvg -xvg none
    #printf "12" | gmx energy -f nvt.edr -o ./Analysis/NVT/Kinetic.xvg -xvg none
    #printf "13" | gmx energy -f nvt.edr -o ./Analysis/NVT/Total.xvg -xvg none
    #printf "15" | gmx energy -f nvt.edr -o ./Analysis/NVT/Temp.xvg -xvg none
    #printf "17" | gmx energy -f nvt.edr -o ./Analysis/NVT/Pressure.xvg -xvg none
    
    #python3 ../plotEnergy.py NVT LJ
    #python3 ../plotEnergy.py NVT Coulomb
    #python3 ../plotEnergy.py NVT Potential
    #python3 ../plotEnergy.py NVT Kinetic
    #python3 ../plotEnergy.py NVT Total
    #python3 ../plotEnergy.py NVT Temp
    #python3 ../plotEnergy.py NVT Pressure



    # NPT
    #echo -e "\tRunning for NPT" >> ../Progress.txt
    #printf "7" | gmx energy -f npt.edr -o ./Analysis/NPT/LJ.xvg -xvg none
    #printf "9" | gmx energy -f npt.edr -o ./Analysis/NPT/Coulomb.xvg -xvg none
    #printf "11" | gmx energy -f npt.edr -o ./Analysis/NPT/Potential.xvg -xvg none
    #printf "12" | gmx energy -f npt.edr -o ./Analysis/NPT/Kinetic.xvg -xvg none
    #printf "13" | gmx energy -f npt.edr -o ./Analysis/NPT/Total.xvg -xvg none
    #printf "15" | gmx energy -f npt.edr -o ./Analysis/NPT/Temp.xvg -xvg none
    #printf "17" | gmx energy -f npt.edr -o ./Analysis/NPT/Pressure.xvg -xvg none
    #printf "23" | gmx energy -f npt.edr -o ./Analysis/NPT/Density.xvg -xvg none

    #python3 ../plotEnergy.py NPT LJ
    #python3 ../plotEnergy.py NPT Coulomb
    #python3 ../plotEnergy.py NPT Potential
    #python3 ../plotEnergy.py NPT Kinetic
    #python3 ../plotEnergy.py NPT Total
    #python3 ../plotEnergy.py NPT Temp
    #python3 ../plotEnergy.py NPT Pressure
    #python3 ../plotEnergy.py NPT Density


    # MD
    mkdir Analysis/MD 
    echo -e "\tRunning for MD" >> ../Progress.txt
    printf "7" | gmx energy -f md_biased.edr -o ./Analysis/MD/LJ.xvg -xvg none
    printf "9" | gmx energy -f md_biased.edr -o ./Analysis/MD/Coulomb.xvg -xvg none
    printf "11" | gmx energy -f md_biased.edr -o ./Analysis/MD/Potential.xvg -xvg none
    printf "12" | gmx energy -f md_biased.edr -o ./Analysis/MD/Kinetic.xvg -xvg none
    printf "13" | gmx energy -f md_biased.edr -o ./Analysis/MD/Total.xvg -xvg none
    printf "15" | gmx energy -f md_biased.edr -o ./Analysis/MD/Temp.xvg -xvg none
    printf "17" | gmx energy -f md_biased.edr -o ./Analysis/MD/Pressure.xvg -xvg none
    printf "23" | gmx energy -f md_biased.edr -o ./Analysis/MD/Density.xvg -xvg none

    python3 ../plotEnergy.py MD LJ
    python3 ../plotEnergy.py MD Coulomb
    python3 ../plotEnergy.py MD Potential
    python3 ../plotEnergy.py MD Kinetic
    python3 ../plotEnergy.py MD Total
    python3 ../plotEnergy.py MD Temp
    python3 ../plotEnergy.py MD Pressure
    python3 ../plotEnergy.py MD Density
    

    cd ..
    done
