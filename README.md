# RobAIR-TP-Sources Pyified

Based on the [sources](https://gricad-gitlab.univ-grenoble-alpes.fr/boulayen/robair-tp-sources) and [configurations](https://gricad-gitlab.univ-grenoble-alpes.fr/boulayen/robair-tp-config) repositories.  
Source files for robotics projects around [RobAIR](https://github.com/fabMSTICLig/RobAIR) as part of [Olivier Aycard's courses](https://lig-membres.imag.fr/aycard/index.php?&slt=enseignement).

Now rewritten for use with Python3 instead of C++ and moved to Docker not to be dependent on dedicated laptops.  
Project also optionally requires the [rospy for pure Python](https://github.com/rospypi/simple) library.
It might be useful in case of static analysers or linters usage.

## Build & run

Use this by running following commands:
- To run locally (`laser_text_display_node` node, `2017-09-07-16-55-12` record, defined in `.conf.env`):  
  ```shell
  make run-node ENV=.conf.env
  ```
- To run on actual RobAIR (`laser_text_display_node` node, `2017-09-07-16-55-12` record, defined in `.conf.env`):  
  ```shell
  make run-phys ENV=.conf.env
  ```

## Params and args

There are currently three different ways to run the project:
1. `run-node` - runs nodes in emulation.  
   Launches with: `roscore` (emulation root, automatically), `rosbag` (recorded simulation), `rviz` graphical user interface; using `roslaunch`.
2. `run-phys` - runs nodes on actual RobAIR.  
   Launches with: `roslaunch` (running nodes), `rviz` graphical user interface; using `roslaunch`.

The following configuration options are supported:
1. `RECORD` (required for `run-node`) - name of the file, containing recorded data to launch `rosbag` tool.  
   Records should be placed in the `assets/data` directory.  
   _Example:_ `make run-node ENV=.conf.env RECORD=2017-09-07-16-55-12.bag`
2. `TARGET` (required for `run-node` and `run-phys`) - description of nodes to launch with `roslaunch` tool. The nodes can be described in two ways:  
   1. As a string, formatted like: `PROJECT_1/NODE_1[:PROJECT_2/NODE_2...]`.  
      Example of such string to launch two nodes (`laser_text_display_node` and `laser_graphical_display_node`):
      ```text
      tutorial_ros/laser_text_display_node.py:tutorial_ros/laser_graphical_display_node.py
      ```
   2. Path to [roslaunch file](http://wiki.ros.org/roslaunch/XML), located under one of the source roots and relative to it. NB! File has to have '.launch' extension.  
      Example of file to launch two nodes (`laser_text_display_node` and `laser_graphical_display_node`, file location: `./sources_py/nodes.launch`):
      ```xml
      <launch>
	      <node name="laser_text_display_node" pkg="tutorial_ros" type="laser_text_display_node.py" output="screen" />
	      <node name="laser_graphical_display_node" pkg="tutorial_ros" type="laser_graphical_display_node.py" output="screen" />
      </launch>
      ```
   _Example:_ `make run-node ENV=.conf.env TARGET=tutorial_ros/laser_text_display_node.py`
3. `CONFIG` (required, default value: `config-laser.rviz`) - initial configuration file for `rviz` tool.  
   The file should be placed in the `config` directory.  
   _Example:_ `make run-node ENV=.conf.env CONFIG=config-laser.rviz`
4. `ROBAIR_IP` (required for `run-phys`, default value: `192.168.0.174`) - IP address of RobAIR to connect.
   _Example:_ `make run-phys ENV=.conf.env ROBAIR_IP=192.168.0.174`

The following convenience configuration options are also might be handy:
1. `BUILD=--build` might be added to any target to rebuild Docker image locally.  
   _Example:_ `make run-node ENV=.conf.env BUILD=--build`
2. `SOURCES` (for `run-node` and `run-phys`, default value: `sources_py`) nodes source directory, might be set to legacy `sources_cpp` - C++ sources directory.
   Note that C++ node names do not include file extensions.
   _Example:_ `make run-node ENV=.conf.env SOURCES=sources_cpp TARGET=tutorial_ros/laser_text_display_node`
3. `ENV` path to configuration file that can contain default values for all the configuration options above.
   There's a sample configuration file named `.conf.env`.  
   _Example:_ `make run-node ENV=.conf.env`

See `make help` command output for detailed info with examples and other targets description.

## Structure

- `assets/data`  
  Data for perception
- `assets/map`  
  Map of UFR IM2AG
- `sources_*/tutorial_ros`  
  Tutorial on ROS
- `sources_*/teleoperation`  
  Lab on teleoperation
- `sources_*/follow_me`  
  Lab on "follow me" behavior: detection part
- `sources_*/localization`  
  Lab on localization

## Roadmap

1. Finish rewriting nodes in Python3.
2. Clean `CMakeLists.txt` and `package.xml` for each project.
3. Test on actual RobAIR.
4. Add `gazebo` configuration and target.

## Requirements

All of this *should* be available on every Linux + WSL:
- `Docker` version 20+
- `docker-compose` version 2+
- `make` version 3+

For Python linting and static analysis:
- `python3` version 3.6-3.8
