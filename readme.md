# PX4/ROS2 Development Setup

This repo offers a **VS Code workspace template for developing software extensions** for the [PX4 Autopilot](https://px4.io/) using [ROS 2](https://docs.ros.org/en/humble/) (preferably Humble Hawksbill). There are many automated tasks that you can make use of:
- **Setup environment**: Setup the development environment by installing all required programs
- **Update ROS2 dependencies**: Update/install packages specified in `src/ros2.repos` and run rosdep
- **Build all/package/packages up to**: Build packages using `colcon`
- **Clean**: Clean the workspace
- **Purge**: Remove `build`, `install` and `log`
- **New ament_cmake/ament_python package**: Create a new ROS2 package
- **Export worlds**: Export custom worlds to become available for simulation
- **Run (...)**: Application shortcuts

The repository is inspired by the [VS Code ROS 2 workspace template](https://github.com/athackst/vscode_ros2_workspace) and tries to integrate common PX4 workflows to facilitate the troublesome development process of real-time ROS2 applications.

Use this template and create your workspace/repository by either pressing the button *Use this template* in the top right corner on GitHub or simply downloading the zip file. You should only clone this repo if you plan to make contributions.

## System Requirements and Setup

Required OS is [Ubuntu 22.04 (Jammy Jellyfish)](https://www.releases.ubuntu.com/22.04/). There are a few tweaks you should apply to your Ubuntu system, to provide a stable development and simulation environment:

- Make sure your swap file is big enough if you have little amount of RAM. If too small, and the system memory on your machine is not able to handle the `colcon build` process, your system is likely to crash on big build loads. Follow [this tutorial](https://askubuntu.com/questions/178712/how-to-increase-swap-space) to increase the swap file. Usually, **16 GB of system memory** should suffice.
- Install the graphics driver of your external graphics card, if you have one. Gazebo simulation will put heavy load on you CPU, if the system is not able to utilize a graphics card. For example for nvidia graphics cards refer to [here](https://ubuntu.com/server/docs/nvidia-drivers-installation).

To automatically install all programs for developing with PX4 and ROS2, run `setup.sh`. The default install location is `~/Desktop`. If either the PX4 workspace, QGroundControl or Groot2 have already been cloned/downloaded to a different location than the default one, the respective variables in [env.sh](env.sh) need to be updated for the terminal environment and the automation tasks in VS Code to work properly. The setup script will only install the components that have not been found.

## Integrate with AutoAPMS
This workspace template is strongly connected with the [AutoAPMS package](https://github.com/robin-mueller/auto-apms) and offers the recommended development setup. Please visit [the Getting Started](https://robin-mueller.github.io/auto-apms-guide/build-auto-apms) for learning about setting up the workspace.

## Build

After installing the required ROS 2 packages, they need to be built. Building the workspace works with `colcon build` (see this [tutorial](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#build-the-workspace)) but it is highly recommended to have a look at the provided VS Code tasks (under Terminal->Run Task...).
