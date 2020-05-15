#!/bin/bash

nreplicas=4
mdpfile=TEMPLATE_md.mdp
grofile=alanine_dipeptide_water.gro
topfile=topol.top
basedir=sim

T1=300.0
T2=400.0


for((i=0;i<nreplicas;i++))
do 
 ii=$(($i+1))
 temp=`echo " e( ( ${i} / ( ${nreplicas} - 1 ) ) * l( $T2 / $T1 )) * $T1 " | bc -l | awk '{printf "%6.3f",$1}' `
 #echo $i  $temp
 mkdir -p ${basedir}${i}
 sed -e "s/__T__/${temp}/g" ${mdpfile} > md.mdp 
 cp md.mdp ${grofile} ${topfile} ${basedir}${i}
 cd ${basedir}${i}
 gmx_mpi grompp -f md.mdp -c ${grofile} -p ${topfile}  
 cd ..
 rm md*.mdp
 echo "Replica $ii : Temperature ${temp}"
done
