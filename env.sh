#!/bin/bash

# ----------------------------------------------------------------------

# This script configures a terminal environment 
# to run properly in interaction with this repository

# ----------------------------------------------------------------------

source ~/.bashrc
source /opt/ros/humble/setup.bash
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/humble/
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
if [ -f install/local_setup.bash ]; then source install/local_setup.bash; fi

export PX4_AUTOPILOT_DIR=~/Desktop/PX4-Autopilot
export QGROUNDCONTROL_APP=~/Desktop/QGroundControl.AppImage
export GROOT2_APP=~/Desktop/Groot2-v1.6.1-x86_64.AppImage
