#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J arch2_old_1
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 12:00:00
#SBATCH -o arch2_old_1.stdout
#SBATCH -e arch2_old_1.stderr
module purge 
source ~/.usr_path_grb_py27




pdcp *.py $TMPDIR
pdcp traffic_matrix_* $TMPDIR
pdcp ../../../../sdm.py $TMPDIR

cd $TMPDIR

python A1_1.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
