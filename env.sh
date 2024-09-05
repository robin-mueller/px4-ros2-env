#!/bin/bash

# ----------------------------------------------------------------------
#
#   This script configures a terminal environment 
#   to run properly in interaction with this repository
#
# ----------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ~/.bashrc

# ROS2 specific environment
if [ -d /opt/ros ]; then
    source /opt/ros/humble/setup.bash
fi
if [ -d /usr/share/colcon_cd ]; then
    source /usr/share/colcon_cd/function/colcon_cd.sh
    export _colcon_cd_root=/opt/ros/humble/
fi
if [ -d /usr/share/colcon_argcomplete ]; then
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
fi
if [ -f "${SCRIPT_DIR}/install/local_setup.bash" ]; then 
    source "${SCRIPT_DIR}/install/local_setup.bash"
fi

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
