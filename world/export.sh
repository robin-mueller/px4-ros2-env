#!/bin/bash

# ----------------------------------------------------------------------
#
#   Scirpt that exports the world files defined in this directory 
#   so that they can be used in the PX4 simulation environment.
#
# ----------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -e
source ${SCRIPT_DIR}/../env.sh

# Copy the .sdf file to the resource directory
echo "Exporting worlds to PX4 ($PX4_ROS2_ENV_PX4_AUTOPILOT_DIR)"
cp -v ${SCRIPT_DIR}/*.sdf "${PX4_ROS2_ENV_PX4_AUTOPILOT_DIR}/Tools/simulation/gz/worlds"
