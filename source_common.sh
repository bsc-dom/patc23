NETWORK_SUFFIX="-ib0"

# --- SLURM ---- 
JOB_HOSTS=$(scontrol show hostname $SBATCH_JOB_NODELIST)
# Get hosts and add infiniband suffix if needed
for HOST in $JOB_HOSTS; do
        HOSTS="$HOSTS ${HOST}${NETWORK_SUFFIX}"
done
export DATACLAY_JOBID=$SLURM_JOBID
export DATACLAYSESSIONCONFIG=$HOME/.dataClay/$DATACLAY_JOBID/client/cfgfiles/session.properties

# Use the three last digits of the username to build the port prefix
USER_ID=${USER: -3}
PORT_BASE="2${USER_ID}"
# If the user is something like nxx01321
# the port prefix will be 2321 and the ports used will be
# 23210, 23211, 23212, 23213.
#
# The choice of it being in the range of 20000 is arbitrary.
#
# If those ports are resulting in some conflict, you can overwrite PORT_BASE
# to a prefix of your choice.
# Take care to avoid conflicts with your colleagues!
