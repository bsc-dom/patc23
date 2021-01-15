#!/bin/bash

source `dirname "$0"`/source_common.sh

module load python/3.7.4

cat << EOF
----------------
 Start dataClay
----------------
EOF

# Deploy dataClay
dataclaysrv start --hosts "$HOSTS $HOSTS $HOSTS" --available-ports "${PORT_BASE}1 ${PORT_BASE}2 ${PORT_BASE}3"

cat << EOF

------------------
 dataClay started
------------------

You can proceed with the notebook.

EOF
