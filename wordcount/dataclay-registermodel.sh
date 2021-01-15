#!/bin/bash

source ../source_common.sh

module load python/3.7.4

dataclayprepare $(pwd)/model/ $(pwd)/ model python

cat << EOF

------------------
 Model registered
------------------

Now you can import the registered classes 
--i.e. after calling storage.api.init()

EOF
