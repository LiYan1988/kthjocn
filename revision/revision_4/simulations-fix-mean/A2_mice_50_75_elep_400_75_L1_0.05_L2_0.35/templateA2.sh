#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J arch4_old_0
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 2:00:00
#SBATCH -o arch4_old_0.stdout
#SBATCH -e arch4_old_0.stderr
module purge 
source ~/.usr_path_grb_py27




pdcp *.py $TMPDIR
pdcp traffic_matrix_* $TMPDIR
pdcp ../../../sdm.py $TMPDIR

cd $TMPDIR

python A2_1.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
