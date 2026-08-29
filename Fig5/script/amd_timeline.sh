#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --partition=cpu
#SBATCH --ntasks=384
#SBATCH --cpus-per-task=1
#SBATCH --job-name=helma
#SBATCH --time=24:00:00
#SBATCH --exclusive
#SBATCH --constraint=hwperf
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV

module load intel intelmpi likwid

set -vx

likwid-mpirun -mpi intelmpi --debug --np 384 -nperdomain N:384 ../../../build/ray-tracing-optical-flow-base 9 2 10 0.00001 4 1000 0 0.625 0.0 > helma-best.csv
