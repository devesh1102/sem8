export CMUBDDHOME=$(pwd)
sed -i 's@\/home\/madhav\/courses\/ee709\/cmu_bdd@'"$CMUBDDHOME"'@' $CMUBDDHOME/bddlib/dependencies

sed -i 's@\/home\/madhav\/courses\/ee709\/cmu_bdd@'"$CMUBDDHOME"'@' $CMUBDDHOME/mem/dependencies


sed -i 's@\/home\/madhav\/courses\/ee709\/cmu_bdd@'"$CMUBDDHOME"'@' $CMUBDDHOME/boole/dependencies


sed -i 's@\/home\/madhav\/courses\/ee709\/cmu_bdd@'"$CMUBDDHOME"'@' $CMUBDDHOME/trlib/dependencies
