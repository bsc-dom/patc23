#!/bin/bash

source `dirname "$0"`/source_common.sh

module load python/3.7.4

cat << EOF
------------------
 Restart dataClay
------------------
EOF

dataclaysrv restart --cleandeploy --hosts "$HOSTS $HOSTS $HOSTS" --available-ports "${PORT_BASE}1 ${PORT_BASE}2 ${PORT_BASE}3"

cat << EOF

--------------------
 dataClay restarted
--------------------

You can proceed with the notebook.

EOF
