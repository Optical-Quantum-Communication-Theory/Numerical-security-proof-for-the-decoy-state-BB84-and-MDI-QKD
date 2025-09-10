# Numerical security proof for the decoy-state BB84 protocol and measurement-device-independent quantum key distribution resistant against large basis misalignment

This is a public version of the code used in *[Numerical security proof for the decoy-state BB84 protocol and measurement-device-independent quantum key distribution resistant against large basis misalignment](https://journals.aps.org/prresearch/abstract/10.1103/PhysRevResearch.4.043097)* \[[arXiv](https://arxiv.org/abs/2108.10844)\]. This was built for [v1.0.0](https://github.com/Optical-Quantum-Communication-Theory/openQKDsecurity/releases/tag/v1.0.0) of the Open QKD Security package.

The code here will largely reproduce the decoy state BB84 and MDI-QKD key rate plots in the paper, with the exception that the original decoy state analysis used a compiled C++ MEX library (which directly calls Gurobi C++ API). For simplicity, this version uses MATLAB with CVX (with the SDP solvers or optionally with Gurobi as the backend) to achieve it instead with slightly less precision. As a result, the key rates fall off faster at longer distances for the decoy state protocols.

> [!CAUTION]
> This code uses parallel computing to reduce run time, however CVX is known to be unstable when run in parallel. If you encounter instabilities when running the code, we recommend changing the `parfor` loop to `for` loops in the function `MDIBB84WCPChannel.m`.

## Installation instructions
> [!CAUTION]
> This repository is for archival and transparency purposes. This will only work with v1.0.0 of the Open QKD Security package.


In addition to MATLAB 2020b+, also install MATLAB's Parallel Computing Toolbox.

### As zip
1. Download the linked version of the code from above and follow all [installation instructions](https://github.com/Optical-Quantum-Communication-Theory/openQKDsecurity/tree/24e5dc7d7f57d711def11aa39d541e0c089ab288), 
2. Download the latest release on the side bar and unzip in your preferred directory and add this folder to the Matlab path.
3. Also follow the additional Mosek install instructions and install [GUROBI](https://www.gurobi.com/downloads/) for a closer match.
4.  Due to a bug in the v1.0 solver `step1SolverAsymptoticInequality.m`, we have provided a patched version in this repository. Replace the old version in the folder `openQKDsecurity/Solvers/AsymptoticInequality_Solver/`.


### with git
1. Clone this repository and its exact submodules navigate to your desired directory and run,
```
git clone --recurse-submodules https://github.com/Optical-Quantum-Communication-Theory/Numerical-security-proof-for-the-decoy-state-BB84-and-MDI-QKD
```
2. Follow all further [installation instructions](https://github.com/Optical-Quantum-Communication-Theory/openQKDsecurity/tree/24e5dc7d7f57d711def11aa39d541e0c089ab288).
3. Also follow the additional Mosek install instructions and install [GUROBI](https://www.gurobi.com/downloads/) for a closer match.
4.  Due to a bug in the v1.0 solver `step1SolverAsymptoticInequality.m`, we have provided a patched version in this repository. Replace the old version in the folder `openQKDsecurity/Solvers/AsymptoticInequality_Solver/`.


## Reproducing the plots

To reproduce the plots run:
* `Main_distance_MDI.m`
* `Main_distance_BB84.m`
* `Main_alignment_MDI.m`
* `Main_alignment_BB84.m`
