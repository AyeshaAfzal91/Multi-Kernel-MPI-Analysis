#!/bin/bash -l
#SBATCH --nodes=5
#SBATCH --job-name=async-progress
#SBATCH --time=24:00:00
#SBATCH --exclusive
#SBATCH --constraint=hwperf
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV

module purge
module load intel intelmpi likwid


NODES=$(scontrol show hostnames $SLURM_JOB_NODELIST)

for node in $NODES; do
        ssh -f "$node" "bash -lc 'cd $PWD && module load likwid && likwid-perfctr -c 0-71 -g MEM_DP -t 200ms -O &> timeline_${node}.csv &'"
done


sleep 10


export I_MPI_ASYNC_PROGRESS=1
export I_MPI_ASYNC_PROGRESS_THREADS=1


likwid-mpirun -mpi slurm --debug --np 360 -nperdomain N:72 --mpiopts "--cpu-freq=2400000-2400000:performance" ../../build/ray-tracing-optical-flow-base 9 2 10 0.00001 4 1000 0 0.625 0.0 > ./async-progress.csv
