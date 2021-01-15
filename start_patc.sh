#!/bin/bash
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
        echo "** Cancelling job $JOBID"
        scancel $JOBID
}
rm -f job.out
touch job.out
output=$(sbatch jupyterjob.sh)
JOBID=`echo $output | awk '{print $4}'`
echo "********* RUNNING JOB $JOBID ********** "
sh -c 'tail -f job.out | { sed "/DEMO SUCCESSFULLY FINISHED!/ q" && kill $$ ;}'
