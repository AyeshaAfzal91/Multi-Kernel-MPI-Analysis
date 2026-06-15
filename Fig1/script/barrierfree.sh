#!/bin/bash -l
#SBATCH --nodes=5
#SBATCH --job-name=P_async
#SBATCH --time=24:00:00
#SBATCH --exclusive
#SBATCH --constraint=hwperf

module load intel intelmpi itac
module use ~unrz139/.modules/modulefiles
module load likwid/master-perf-mpirun


for s in 1 2 3 4 5
do
    likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 7 $s 10 0.00001 4 100 0 0.625 0.0 >> ./mg7/tmp_$s.csv

    likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 6 $s 10 0.00001 4 100 0 0.625 0.0 >> ./mg6/tmp_$s.csv

done
