#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=360
#SBATCH --cpus-per-task=1
#SBATCH --job-name=cer
#SBATCH --time=24:00:00
#SBATCH --exclusive
#SBATCH --constraint=hwperf
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV
module load intel intelmpi likwid

for s in 1 2 3 4 5
do
    likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 11 $s 10 0.00001 4 1 0 0.625 0.0 >> ./mg11/tmp_$s.csv

    likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 10 $s 10 0.00001 4 1 0 0.625 0.0 >> ./mg10/tmp_$s.csv

    likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 9 $s 10 0.00001 4 1 0 0.625 0.0 >> ./mg9/tmp_$s.csv

done
