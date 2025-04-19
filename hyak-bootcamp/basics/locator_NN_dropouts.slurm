#!/bin/bash

#SBATCH --job-name=dropout_sweep
#SBATCH --partition=ckpt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5G
#SBATCH --array=0-14
#SBATCH --time=10:00
#SBATCH -o log/%x_%A_%a.out


# Here we are saving the list of Populus trichocarpa test sets as a variable called FILE_LIST.
FILE_LIST=($(ls -1 data/potr_m_pred*))

# Next we are using the SLURM environment variable SLURM_ARRAY_TASK_ID, which is an index
# (in this case 0-14) or a set of consecutive numbers.

# To use the same file 3 times, once for each dropout value, we can divide the task ID by 3.
# This way for array job 0, 1, and 2 we will use file index 0, for array job 3, 4, and 5, we will
# use file index 1, etc.
FILEINDEX=$((${SLURM_ARRAY_TASK_ID}/3))

# Using the file index, we can get the name of the FILE we will use in the current array job
# from the list of FILES.
FILE=${FILE_LIST[${FILEINDEX}]}

# This time we will use a variable for the output directory where results will be saved.
# This step is optional, but it helps to make the script generalized. Only this line
# will need to change to change the output directory.
OUTDIR=($(echo out/))

# This time we will use a variable for the input genotype matrix. Another generalization method.
INPUTMATRIX=($(echo data/potr_genotypes1000.txt))

# Our list of dropout values is saved as a variable DROPOUTS.
DROPOUTS=(0.25 0.5 0.75)

# To cycle through the DROPOUTS, we can use the SLURM_ARRAY_TASK_ID and the modulus operator (%),
# which calculates the remainder of a division. In this case, when SLURM_ARRAY_TASK_ID=0 the
# remainder of 0/3 is 0, so we use the dropout in the index 0, which is 0.25. For SLURM_ARRAY_TASK_ID=1,
# we will use dropout index 1. For SLURM_ARRAY_TASK_ID=2, we will use dropout index 2.
# When we reach SLURM_ARRAY_TASK_ID=3, the modulus operator returns 0 again (3/3 = 1 with 0 remainder),
# so we go back to using dropout index 0, which is 0.25.
DROPOUT=${DROPOUTS[${SLURM_ARRAY_TASK_ID}%3]}

# Include echo commands to check variables are defined correctly suring script development.
echo "The file index for this array job is:" $FILEINDEX
echo "The test set being used for this array job is:" $FILE
echo "The dropout proportion being tested during this job is:" $DROPOUT

# command
apptainer exec --cleanenv --bind /gscratch locator.sif python /locator/scripts/locator.py --matrix ${INPUTMATRIX} --sample_data ${FILE} --dropout_prop ${DROPOUT} --out ${OUTDIR}dropout_sweep_${DROPOUT}_${FILEINDEX}





# Script explanation:

# SBATCH directives:
# The above lines starting with "#SBATCH" are sbatch directives, or flags passed to SLURM via the
# sbatch command. This is how you specify the resources we require for the job we are requesting.
# This script requests an array of 15 jobs, each a single node, single task job with 5G of RAM
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
# dropout_sweep_12345678_0.out and there will be 15 output files, one for each job in the array:
# dropout_sweep_12345678_0-14.out. In this case, we are saving the output file to a directory called log/.

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
# --matrix ${INPUTMATRIX}- --matrix is the arguement coded in locator.py that indicates
# the provided file data/potr_genotypes.txt saved as the variable INPUTMATRIX is the genotype matrix.
# --sample_data ${FILE} - --sample_data is the arguement in locator.py the provided the test
# set saved as variable FILE is the sample data (locations).
# --dropout_prop ${DROPOUT} - --dropout_prop is the arguement in locator.py the provides the value
# to be used as the dropout proportion saved as variable DROPOUT (0.25, 0.5, 0.75).
# --out ${OUTDIR}dropout_sweep_${DROPOUT}_${FILEINDEX} - --out is the arguement in locator.py
# that indicates that results should be saved into the out/ directory saved as variable OUTDIR
# and that the files should have the prefix dropout_sweep_ and the suffix should show the dropout
# value used (DROPOUT) and the FILEINDEX (0-4).
# This command will throw an error if the directory "out/" does not exist.

