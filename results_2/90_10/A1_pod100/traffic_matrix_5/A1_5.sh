#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J A1_5-90_10
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 4:00:00
#SBATCH -o A1_5-90_10.stdout
#SBATCH -e A1_5-90_10.stderr
module purge 
source ~/.usr_path_grb




pdcp *.py $TMPDIR
pdcp ../../trafficMatrix/traffic_matrix_5.csv $TMPDIR
pdcp ../../../sdm.py $TMPDIR
cd $TMPDIR

python A1_5.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
