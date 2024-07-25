#!/bin/bash

# ----------------------------------------------------------------------
#
#   Install all required programs for the development environment
#
# ----------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -e
source ${SCRIPT_DIR}/env.sh

# ROS2 Humble Hawksbill
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade -y
sudo apt install ros-humble-ros-base -y
sudo apt install ros-dev-tools -y

# PX4 Autopilot
PX4_VERSION="v1.15.0-beta2"

if [ ! -d "$PX4_ROS2_ENV_PX4_AUTOPILOT_DIR" ]; then
    echo -e "\e[1;33m--- PX4 Autopilot not found. Installing...\e[0m"
    git clone https://github.com/PX4/PX4-Autopilot.git "$PX4_ROS2_ENV_PX4_AUTOPILOT_DIR" --recursive
    (cd "$PX4_ROS2_ENV_PX4_AUTOPILOT_DIR" && git checkout $PX4_VERSION && make submodulesclean)
    bash "$PX4_ROS2_ENV_PX4_AUTOPILOT_DIR/Tools/setup/ubuntu.sh"
else 
    echo -e "\033[1;33m--- PX4 Autopilot already installed.\e[0m"
fi

# QGroundControl
QGC_VERSION="v4.4.0"

if [ ! -f "${PX4_ROS2_ENV_QGROUNDCONTROL_APP}" ]; then
    echo -e "\033[1;33m--- QGroundControl not found. Installing...\e[0m"
    sudo usermod -a -G dialout $USER
    sudo apt-get remove modemmanager -y
    sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y
    sudo apt install libfuse2 -y
    sudo apt install libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor0 -y
    wget -P "$PX4_ROS2_ENV_DEFAULT_BASE_DIR" https://github.com/mavlink/qgroundcontrol/releases/download/${QGC_VERSION}/QGroundControl.AppImage
else 
    echo -e "\033[1;33m--- QGroundControl already installed.\e[0m"
fi

# Groot2
INSTALL_GROOT=true

if $INSTALL_GROOT && [ ! -f "${PX4_ROS2_ENV_GROOT2_APP}" ]; then
    echo -e "\033[1;33m--- Groot2 not found. Installing...\e[0m"
    wget -P "$PX4_ROS2_ENV_DEFAULT_BASE_DIR" https://s3.us-west-1.amazonaws.com/download.behaviortree.dev/groot2_linux_installer/Groot2-v1.6.1-x86_64.AppImage
else 
    echo -e "\033[1;33m--- Groot2 already installed.\e[0m"
fi

# source again after major installations
source ${SCRIPT_DIR}/env.sh

${SCRIPT_DIR}/world/export.sh
${SCRIPT_DIR}/dep.sh
