#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J A1_17-90_10
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 12:00:00
#SBATCH -o A1_17-90_10.stdout
#SBATCH -e A1_17-90_10.stderr
module purge 
source ~/.usr_path_grb




pdcp *.py $TMPDIR
pdcp ../../trafficMatrix/traffic_matrix_17.csv $TMPDIR
pdcp ../../../sdm.py $TMPDIR
cd $TMPDIR

python A1_17.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
