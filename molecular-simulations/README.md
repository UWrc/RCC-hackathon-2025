# Dynamic Particle Structure Viewer: Bridging Hyak and Real-Time Web Visualization

## Objective

Build an interactive, website-based particle structure renderer that visualizes complex particle structures in real time, with the backend calculations computed on a supercomputer (Hyak).

## Deliverables

* A backend workflow that automatically simulates molecular dynamics based on initial inputs, such as number of particles, volume fraction, particle sizes, etc. Other advanced specifications include lattice type, interacting potentials, simulation time, etc.
* A user-friendly website with an interactive particle structure renderer which enables color-coding to show the parameter values of particles like particle sizes, and an editor which allows users to change inputs and adjust graphic settings.
* Test cases for debugging the codes and showcasing the workflow
* Documentation and demo video

## Resources

* Backend simulation: 
  * [HOOMD-blue](https://hoomd-blue.readthedocs.io/en/v5.1.1/): A molecular dynamics simulation package that has a python API and simulates a broad variety of particle structures with a high customizability
  * [Freud](#https://freud.readthedocs.io/en/latest/): A python package with functions to calculate various metrics of a particle structure, like radial distribution function, order parameters, etc
  * [LAMMPS](#https://docs.lammps.org/Manual.html): A molecular dynamics simulation package available in C/C++/python/fortran
  * Mutual polarization method (MPM): A rapid solver in MATLAB that computes particle dipoles in parallel with CPU
* Frontend website: 
  * [Open Ondemand (OOD)](#https://hyak.uw.edu/docs/ood/start/): Allow to open applications installed on Hyak on a website interface. Currently supporting MATLAB, Jupyter, R, and VSCode
  * [Ovito (python package)](#https://www.ovito.org/): A molecular visualization software that has a native support of GSD files, which are the standard trajectory output type from HOOMD-blue
  * [NGL viewer](#https://nglviewer.org/ngl/api/): A web application for molecular visualization available with a python API

## Dataset

* GSD files: 1000, 8000, and 64000 particles interacting with hard-sphere and depletion potentials
* MAT files: Drude and core-shell particles with different parameters computed from above GSD configurations

## Instructions

* [What is Molecular Dynamics Simulation?](#https://www.youtube.com/watch?v=veBZYlD6AF4)
* [Connect to Hyak](#https://hyak.uw.edu/docs/setup/ssh)
* [Running jobs on Hyak](#https://hyak.uw.edu/docs/compute/scheduling-jobs)
* [Use containers on Hyak](#https://hyak.uw.edu/docs/hyak101/containers/syllabus)
