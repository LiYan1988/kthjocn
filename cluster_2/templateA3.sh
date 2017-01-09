#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J arch5_old_0
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 12:00:00
#SBATCH -o arch5_old_0.stdout
#SBATCH -e arch5_old_0.stderr
module purge 
source ~/.usr_path_grb




pdcp *.py $TMPDIR
pdcp traffic_matrix_* $TMPDIR
pdcp ../../../sdm.py $TMPDIR

cd $TMPDIR

python pareto0.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
