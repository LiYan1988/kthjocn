#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J A1_18-0.00_0.90
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 12:00:00
#SBATCH -o A1_18-0.00_0.90.stdout
#SBATCH -e A1_18-0.00_0.90.stderr
module purge 
source ~/.usr_path_grb_py27




pdcp *.py $TMPDIR
pdcp ../../trafficMatrix/traffic_matrix_18.csv $TMPDIR
pdcp ../../../../sdm.py $TMPDIR

cd $TMPDIR

python A1_18.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
