#!/bin/bash

#SBATCH --job-name=locator_array
#SBATCH --partition=ckpt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5G
#SBATCH --array=0-4
#SBATCH --time=10:00
#SBATCH -o log/%x_%A_%a.out




# Here we are saving the list of Populus trichocarpa test sets as a variable called FILE_LIST.
FILE_LIST=($(ls -1 data/potr_m_pred*))

# Next we are using the SLURM environment variable SLURM_ARRAY_TASK_ID, which is an index
# (0-4) or a set of consecutive numbers to get a file from FILE_LIST.
# For each job in the array, the variable FILE will be a single file from FILE_LIST.
FILE=${FILE_LIST[${SLURM_ARRAY_TASK_ID}]}

# This will print the file name to the log file output. Use echo commands during script development to
# verify variables are correctly defined.
echo $FILE

# command - we pass the variable FILE to the command for each job in the array
# we are also using the index variable SLURM_ARRAY_TASK_ID as a suffix to ensure that
# the results from each job are saved as separate files.
apptainer exec --cleanenv --bind /gscratch locator.sif python /locator/scripts/locator.py --matrix data/potr_genotypes1000.txt --sample_data ${FILE} --out out/array_potr_predictions${SLURM_ARRAY_TASK_ID}







# Script explanation:

# SBATCH directives:
# The above lines starting with "#SBATCH" are sbatch directives, or flags passed to SLURM via the
# sbatch command. This is how you specify the resources we require for the job we are requesting.
# This script requests an array of 5 jobs, each a single node, single task job with 5G of RAM
# for a maximum time of 10 minutes. See sbatch documentation for the full list of options.

# The job scheduler will choose an account for you by default, but an account can be specified with
# --account= and then the account name. This is not necessary if you don't belong to multiple accounts.
# Use the hyakalloc command to find which accounts are available to you.

# If you have other available partitions (for exmaple compute) you can replace "--parition=ckpt"
# with "--partition=compute". Use the hyakalloc command to find which partitions are available to you.

# -o above saves the stdout and stderr (the printed output and error messages printed to the screen
# during the job) to a file called locator_array_12345678_0.out using %x as shorthand of the job-name.
# %A as shorthand for the array-jobID that will be assigned by SLURM when the job is submitted and %a for
# the index of the job within the array. The array-jobID will replace 12345678 in the file name
# locator_array_12345678_0.out and there will be 5 output files, one for each job in the array:
# locator_array_12345678_0-4.out. In this case, we are saving the output file to a directory called log/.

# The command:
# The line above beginning with "apptainer" is the command or job that is being submitted with this
# script. The SBATCH directive contain instructions for what resources are needed for the job, but
# this line does the work. Below is a break down of this command for context, but this script can
# be used as a template for your future single-job batch scripts.

# apptainer calls the apptainer software, which is used to run containers.
# exec is the apptainer execute function and so it instructs apptainer to execute the following
# command.
# --cleanenv is an apptainer flag that instructs apptainer to execute the command in a clean
# environment, not carrying over any environment variables from the host environment. Only
# variables set within the container can be used.
# --bind /gscratch is usually required when executing a command within a container on klone.
# This ensures that the file system is mounted on the container, so files from out /gscratch
# file system are available so that commands can be executed upon them.
# python /locator/scripts/locator.py - starts python and executes the locator.py python script.
# --matrix data/potr_genotypes1000.txt- --matrix is the arguement coded in locator.py that indicates
# the provided file data/potr_genotypes.txt is the genotype matrix.
# --sample_data ${FILE} - --sample_data is the arguement in locator.py the provided the test
# set saved as variable ${FILE} is the sample data (locations).
# --out out/array_potr_predictions${SLURM_ARRAY_TASK_ID} - --out is the arguement in locator.py
# that indicates that results should be saved into the locator_out/ directory and that the files
# should have the prefix array_potr_predictions and the suffix is an index corresponding to each job (0-4).
# This command will throw an error if the directory "out/" does not exist.
