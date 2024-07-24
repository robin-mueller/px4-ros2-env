#!/bin/bash

# ----------------------------------------------------------------------
#
#   This script configures a terminal environment 
#   to run properly in interaction with this repository
#
# ----------------------------------------------------------------------

source ~/.bashrc
source /opt/ros/humble/setup.bash
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/humble/
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
if [ -f install/local_setup.bash ]; then source install/local_setup.bash; fi

export PX4_ROS2_ENV_DEFAULT_BASE_DIR="$HOME/Desktop"

# Change these variables if necessary
export PX4_ROS2_ENV_PX4_AUTOPILOT_DIR="${PX4_ROS2_ENV_DEFAULT_BASE_DIR}/PX4-Autopilot"
export PX4_ROS2_ENV_QGROUNDCONTROL_APP="${PX4_ROS2_ENV_DEFAULT_BASE_DIR}/QGroundControl.AppImage"
export PX4_ROS2_ENV_GROOT2_APP="${PX4_ROS2_ENV_DEFAULT_BASE_DIR}/Groot2-v1.6.1-x86_64.AppImage"

if [ -f "$PX4_ROS2_ENV_QGROUNDCONTROL_APP" ] && [ $(stat -c "%a" "$PX4_ROS2_ENV_QGROUNDCONTROL_APP") -ne 755 ]; then
    chmod +x "$PX4_ROS2_ENV_QGROUNDCONTROL_APP"
fi
if [ -f "$PX4_ROS2_ENV_GROOT2_APP" ] && [ $(stat -c "%a" "$PX4_ROS2_ENV_GROOT2_APP") -ne 755 ]; then
    chmod +x "$PX4_ROS2_ENV_GROOT2_APP"
fi
