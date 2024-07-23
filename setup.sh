#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

vcs import < ${SCRIPT_DIR}/src/ros2.repos src --recursive

sudo apt-get update

[ "$(ls -A /etc/ros/rosdep/sources.list.d)" ] || sudo rosdep init -q # Init rosdep if not happend yet
rosdep update --rosdistro=$ROS_DISTRO
rosdep install --from-paths src --ignore-src -y --rosdistro=$ROS_DISTRO

# Make applications executable
chmod +x ${QGROUNDCONTROL_APP}
chmod +x ${GROOT2_APP}
