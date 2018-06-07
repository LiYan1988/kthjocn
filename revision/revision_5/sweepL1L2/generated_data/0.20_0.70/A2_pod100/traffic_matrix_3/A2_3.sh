#!/usr/bin/env bash
#SBATCH -A C3SE407-15-3
#SBATCH -p hebbe
#SBATCH -J A2_3-0.20_0.70
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 2:00:00
#SBATCH -o A2_3-0.20_0.70.stdout
#SBATCH -e A2_3-0.20_0.70.stderr
module purge 
source ~/.usr_path_grb_py27




pdcp *.py $TMPDIR
pdcp ../../trafficMatrix/traffic_matrix_3.csv $TMPDIR
pdcp ../../../../sdm.py $TMPDIR

cd $TMPDIR

python A2_3.py

cp *.csv $SLURM_SUBMIT_DIR

# End script
