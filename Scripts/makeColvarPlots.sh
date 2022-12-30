for((i=1;i<=100;i++)) do 
    echo "plotting IT-$i" >> Progress.txt
    cd ./IT-$i
    python3 ../plotCOLVAR.py Q6_bias
    python3 ../plotCOLVAR.py Q6_value
    cd ..
    done
