#!/bin/bash

# ----------------------------------------------------------------------
#
#   Install all ROS2 workspace dependencies
#
# ----------------------------------------------------------------------

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

vcs import < "${SCRIPT_DIR}/src/ros2.repos" src --recursive

[ "$(ls -A /etc/ros/rosdep/sources.list.d)" ] || sudo rosdep init -q # Init rosdep if not happend yet
rosdep update --rosdistro=$ROS_DISTRO
rosdep install --from-paths src --ignore-src -y --rosdistro=$ROS_DISTRO
