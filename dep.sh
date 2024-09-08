#!/bin/bash

# ----------------------------------------------------------------------
#
#   Install all ROS2 workspace dependencies
#
# ----------------------------------------------------------------------

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

vcs import < "${SCRIPT_DIR}/src/ros2.repos" "${SCRIPT_DIR}/src" --recursive

if command -v rosdep &> /dev/null; then
    if [ ! -d /etc/ros/rosdep/sources.list.d ]; then
        sudo rosdep init -q # Init rosdep if not happend yet
    fi
    rosdep update
    rosdep install --from-paths "${SCRIPT_DIR}/src" --ignore-src -y
fi
