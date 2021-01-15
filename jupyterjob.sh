#!/bin/bash -e
#SBATCH --job-name=dataclaydemo
#SBATCH --output=job.out
#SBATCH --error=job.out
#SBATCH --nodes=1
#SBATCH --time=00:20:00
#SBATCH --qos=debug
##########################################

module load DATACLAY
module load python

source source_common.sh

rm -rf cfgfiles
ln -s $HOME/.dataClay/$DATACLAY_JOBID/client/cfgfiles cfgfiles

# Some basic info for the user
cat <<EOF

*****************************************************************************

        Starting Jupyter Notebook

Note that you will need to perform a port forwarding
in order to connect to it. If you have the ssh command
(likely to happen in Windows 10, Linux and Mac operating systems)
this can be done with the following command:

    $ ssh -N -L ${PORT_BASE}0:$HOSTNAME:${PORT_BASE}0 $USER@mn1.bsc.es

After this, you will be able to use the URL given by the Notebook.
I.e. the one that starts with http://127.0.0.1:${PORT_BASE}0/?token=(...)

*****************************************************************************

EOF


# Start notebook
/gpfs/apps/MN4/DATACLAY/2.5/venv/bin/python -m notebook --no-browser --ip=0.0.0.0 --port ${PORT_BASE}0

echo "Done."
