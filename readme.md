# UAS Gazebo Simulation

This repo offers a guide to set up UAS simulation using [Gazebo](https://gazebosim.org/home) and [PX4 Autopilot](https://px4.io/). It also implements a programming interface for commanding the vehicle using [ROS 2 (Humble Hawksbill)](https://docs.ros.org/en/humble/).

## System Requirements and Installation

Required OS is [Ubuntu 22.04 (Jammy Jellyfish)](https://www.releases.ubuntu.com/22.04/). There are a few tweaks you should apply to your Ubuntu system, to provide a stable development and simulation environment:

- Make sure your swap file is big enough if you have little amount of RAM. If too small, and the system memory on your machine is not able to handle the `colcon build` process, your system is likely to crash on big build loads. Follow [this tutorial](https://askubuntu.com/questions/178712/how-to-increase-swap-space) to increase the swap file. Usually, **16 GB of system memory** should suffice.
- Install the graphics driver of your external graphics card, if you have one. Gazebo simulation will put heavy load on you CPU, if the system is not able to utilize a graphics card. For example for nvidia graphics cards refer to [here](https://ubuntu.com/server/docs/nvidia-drivers-installation).

When your operating system is set up, follow this guide to install all software dependencies and create a working simulation environment. **Make sure to execute the following steps in the given order**.

1. Install [ROS 2 (Humble Hawksbill)](https://docs.ros.org/en/humble/Installation.html) `base` and `dev-tools`

2. Clone [PX4 Autopilot v1.15](https://github.com/PX4/PX4-Autopilot) following the steps below (Default location is `~/Desktop`)
   ```sh
   # Clone the source code at specific revision to guarantee compatibility
   cd ~/Desktop && git clone https://github.com/PX4/PX4-Autopilot.git --recursive

   # Checkout and update submodules (testing was conducted with a beta version)
   (cd ./PX4-Autopilot && exec git checkout v1.15.0-beta1 && make submodulesclean)

   # Install PX4 Autopilot dependencies on current system
   bash ./PX4-Autopilot/Tools/setup/ubuntu.sh
   ```

   If you ever find yourself switching revisions, you have to follow the steps below:
   
   ```sh
   cd ./PX4-Autopilot
   make clean
   make distclean
   git checkout v1.15.0-beta1 # Switch version/tag/revision here
   make submodulesclean
   ```

3. Download [QGroundControl v4.3.0](https://github.com/mavlink/qgroundcontrol/releases/download/v4.3.0/QGroundControl.AppImage) (Default location is `~/Desktop`) and follow the [installation guide](https://docs.qgroundcontrol.com/master/en/qgc-user-guide/getting_started/download_and_install.html#ubuntu). The [PX4-ROS2 Interface Library](https://docs.px4.io/main/en/ros2/px4_ros2_interface_lib.html#px4-ros-2-interface-library) suggests to use daily builds to make the most recent features available, but the stable version 4.3 will do just fine.

4. **Optional:** Download [Groot2 Behavior Tree IDE](https://www.behaviortree.dev/groot) (Default location is `~/Desktop`) which is used in specific packages for behavior modeling.

5. Clone this repository and run the provided setup script
   ```sh
   cd ~/Desktop && git clone https://git-ce.rwth-aachen.de/tuda-fsr/uas/uas_gazebo_simulation.git
   cd uas_gazebo_simulation

   # Make sure to source this file when working in this repo
   source env.sh

   # Run setup
   ./setup.sh
   ```

If the PX4 workspace, QGroundControl or Groot2 has been downloaded to a different location than `~/Desktop`, the respective variables in [env.sh](env.sh) need to be updated for the terminal and the automation tasks in VS Code to work properly.

## Build

Building the workspace works with `colcon build` (see this [tutorial](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#build-the-workspace)) but it is highly recommended to have a look at the provided VS Code tasks (under Terminal->Run Task...).

## Simulation worlds

The gazebo world resources are located in the directory `worlds` and need to be exported to the PX4 working directory. The script [worlds/export.sh](worlds/export.sh) is provided for that purpose. Everytime something is changed in the `.sdf` files, this script needs to be executed.

## Known Issues

- On the development system, the first message of `/fmu/out/mode_completed` was usually not received. Therefore, the first maneuver/action from the `commander` package to be performed after starting the simulation will abort when completed. After retrying once, everything works fine.