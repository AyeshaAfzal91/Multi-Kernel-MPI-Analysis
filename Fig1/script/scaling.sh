#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --job-name=scaling
#SBATCH --export=NONE
#SBATCH --partition=singlenode
#SBATCH --constraint=hwperf --exclusive
unset SLURM_EXPORT_ENV

# load modules
module unload likwid
module load intel intelmpi itac
module use ~unrz139/.modules/modulefiles
module load likwid/master-perf-mpirun

set -vx

echo 'BASERAWDATA' >> all_scaling.csv
echo 'BASECLEANDATA' >> scaling.csv

for ((i = 1; i <= 35; i ++))
do
    echo '_________' > tmp.csv
    echo ______'Number of Processors: '$((i+1)) ______ >> scaling.csv
    likwid-mpirun --debug --np $((i+1)) -g MEM_DP  -mpi slurm --mpiopts "--cpu-freq=2400000-2400000:performance" -nperdomain N:72 -O ../../build/ray-tracing-optical-flow-base 12 1 10 0.00001 4 100 0 0.625 0.0>> tmp.csv
    cat tmp.csv >> all_scaling.csv
    if [ $i == 0 ]
    then
        pattern=$(printf "TABLE,Group 1 Raw,MEM_DP,27")
        exp=$(printf "%s|Runtime \(RDTSC) \[s]|DP \[MFLOP/s]|AVX DP \[MFLOP/s]|Packed \[MUOPS/s]|Scalar \[MUOPS/s]|Memory bandwidth \[MBytes/s]|Memory data volume \[GBytes]" "$pattern")
        grep -A 51 -E "$pattern" tmp.csv | grep -E "$exp" >> scaling.csv
    else
        pattern=$(printf "TABLE,Group 1 Raw STAT,MEM_DP,26")
        exp=$(printf "%s|DP \[MFLOP/s] STAT|AVX DP \[MFLOP/s] STAT|Packed \[MUOPS/s] STAT|Scalar \[MUOPS/s] STAT|Runtime \(RDTSC) \[s] STAT|Memory bandwidth \[MBytes/s] STAT|Memory data volume \[GBytes] STAT" "$pattern")
        grep -A 71 -E "$pattern" tmp.csv | grep -E "$exp" >> scaling.csv
    fi
    rm tmp.csv
done
rm -rf .output_* .likwidscript_*
