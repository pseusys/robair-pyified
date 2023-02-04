cmake_minimum_required(VERSION 2.8.3)
project(tutorial_ros)

catkin_package(CATKIN_DEPENDS std_msgs sensor_msgs visualization_msgs geometry_msgs genmsg rospy)

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  ${catkin_INCLUDE_DIRS}
)

## This macro ensures modules and global scripts declared therein get installed
catkin_install_python(PROGRAMS
    src/laser_text_display_node.py
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
