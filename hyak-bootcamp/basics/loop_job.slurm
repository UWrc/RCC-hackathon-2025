#!/bin/bash

#SBATCH --job-name=loop_job
#SBATCH --partition=ckpt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=1G
#SBATCH --time=5:00
#SBATCH -o log/%x_%j.out




# command
time ./loop_script.sh 0 1000000


# Script explanation:

# SBATCH directives:
# The above lines starting with "#SBATCH" are sbatch directives, or flags passed to SLURM via the
# sbatch command. This is how you specify the resources we require for the job we are requesting.
# This script requests a single node, single task job with 1G of RAM for a maximum time of 5 minutes
# see sbatch documentation for the full list of options.

# The job scheduler will choose an account for you by default, but an account can be specified with
# --account= and then the account name. This is not necessary if you don't belong to multiple accounts.
# Use the hyakalloc command to find which accounts are available to you.

# If you have other available partitions (for exmaple compute) you can replace "--parition=ckpt"
# with "--partition=compute", for example. Use the hyakalloc command to find which partitions are
# available to you.

# -o above saves the stdout and stderr (the printed output and error messages printed to the screen
# during the job) to a file called loop_job_12345678.out using %x as shorthand of the job-name and
# %j as shorthand for the jobID that will be assigned by SLURM when the job is submitted.
# The jobID will replace 12345678 in loop_job_12345678.out. In this case, we are saving the output
# file to a directory called log/.

# The command:
# This script submits a job that executes the loop_script.sh. To execute a script in Linux "./" is
# required. loop_script.sh requires two arguments, the starting and ending point in a range of numbers.
# The for loop in the script simply iterates through the numbers in that range. The time command is also
# used to provide the time the command required. The purpose of this is to provide a simple template
# with which to submit a single batch job.
