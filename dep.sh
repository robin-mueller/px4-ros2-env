#!/bin/bash

# ----------------------------------------------------------------------
#
#   Install all ROS2 workspace dependencies
#
# ----------------------------------------------------------------------

set -e

vcs import < "./src/ros2.repos" "./src" --recursive

if command -v rosdep &> /dev/null; then
    if [ ! -d /etc/ros/rosdep/sources.list.d ]; then
        sudo rosdep init -q # Init rosdep if not happend yet
    fi
    sudo apt update
    rosdep update
    rosdep install --from-paths "./src" --ignore-src -y
fi
