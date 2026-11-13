# Multi-Kernel-MPI-Analysis

Performance artifact for *Exploiting the Interplay of Compute- and Memory-Bound kernels in MPI Applications* (Afzal, Manda, Hager; PMBS; [arXiv:2610.01587](https://arxiv.org/abs/2610.01587)).

Organized by figure number: each directory holds raw results, plotting data, runtime logs, input files, and scripts to reproduce that figure. Hardware/software environments are documented in the repo.

- **Systems:** Fritz (Intel Xeon 8360Y, Ice Lake), Helma (AMD EPYC 9965, Zen5c)
- **Software:** Intel oneAPI 2025.2, Intel MPI 2021.16, LIKWID, ITAC/Vampir, [DisCostiC](https://github.com/RRZE-HPC/DisCostiC-Sim)
- **Codes:** [Optical Flow Solver](https://github.com/SebastianKuckuk/ray-tracing-optical-flow), Pisolver-Triad benchmark

Short link: https://go-nhr.de/Multi-Kernel-MPI-Analysis

## Acknowledgments

Supported by the German Research Foundation (DFG), project number 545776403, FOR 5880: *Holistic Energy and Performance Modeling for Sustainable Computing* (Mod4Comp). Compute resources were provided by the Erlangen National High Performance Computing Center (NHR@FAU). NHR funding is provided by the German Federal Ministry of Education and Research and the participating state governments; the NHR@FAU hardware is partially funded by the DFG, grant number 440719683.
