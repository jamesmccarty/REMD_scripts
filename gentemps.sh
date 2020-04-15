#!/bin/bash
nreplicas=4
Temp=(300 400 600 1000)
mdpfile=vacuum.mdp
grofile=alanine_dipeptide.gro
topfile=topol.top
basedir=sim

for (( c=0; c<$nreplicas; c++ ))
do
	mkdir -p ${basedir}${c}
	cp ${mdpfile} ${grofile} ${topfile} ${basedir}${c}
	cd ${basedir}${c}
	sed -i "s/__T__/${Temp[c]}/g" ${mdpfile} 
	cd ..
	echo "Replica $c : Temperature ${Temp[c]}"
done
