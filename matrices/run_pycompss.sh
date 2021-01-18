#!/bin/bash

  module load gcc/8.1.0
  export COMPSS_PYTHON_VERSION=3-ML
  module load COMPSs/2.8.1
  module load mkl/2018.1
  module load impi/2018.1
  module load opencv/4.1.2
  module load DATACLAY/2.5

enqueue_compss \
	--num_nodes=2 \
	--qos=debug \
	--exec_time=30 \
	--job_name=patc_matmul \
	--max_tasks_per_node=8 \
	--worker_in_master_cpus=0 \
	--summary \
	--graph \
	--lang=python \
	--classpath=${DATACLAY_JAR} \
	--pythonpath=$PWD:${PYCLAY_PATH} \
	--storage_home=$COMPSS_STORAGE_HOME \
	--storage_props="$PWD/execution_values" \
	--prolog="$DATACLAY_HOME/bin/dataclayprepare,$PWD/model/,$PWD,model,python" \
		$PWD/matmul_main.py


###### Remember update the reservation
#	--reservation=PATC20-DATA \
