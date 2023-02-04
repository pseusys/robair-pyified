# RobAIR-TP-Sources Pyified

Based on the [sources](https://gricad-gitlab.univ-grenoble-alpes.fr/boulayen/robair-tp-config) and [configurations](https://gricad-gitlab.univ-grenoble-alpes.fr/boulayen/robair-tp-sources) repositories.  
Source files for robotics projects around [RobAIR](https://github.com/fabMSTICLig/RobAIR) as part of [Olivier Aycard's courses](https://lig-membres.imag.fr/aycard/index.php?&slt=enseignement).

Now rewritten for use with Python3 instead of C++ and moved toDocker not to be dependent on dedicated laptops.  
Project also optionally requires the [rospy for pure Python](https://github.com/rospypi/simple) project.
It might be useful in case of static analysers or linters usage.

## Build & run
Use this by running following commands:
- To test the system:  
  ```shell
    make run-test RECORD=2017-09-07-16-55-12.bag
  ```
- To run locally (`laser_text_display_node` node, `2017-09-07-16-55-12` record):  
  ```shell
    make run-node RECORD=2017-09-07-16-55-12.bag PACKAGE=tutorial_ros NODE=laser_text_display_node.py
  ```
- To run on actual robair (`laser_text_display_node` node, `2017-09-07-16-55-12` record):  
  ```shell
    make run-phys RECORD=2017-09-07-16-55-12.bag PACKAGE=tutorial_ros NODE=laser_text_display_node.py
  ```

## Structure
- `assets/data`  
  Data for perception
- `assets/map`  
  Map of UFR IM2AG
- `sources/tutorial_ros`  
  Tutorial on ROS
- `sources/teleoperation`  
  Lab on teleoperation
- `sources/follow_me`  
  Lab on "follow me" behavior: detection part
- `sources/localization`  
  Lab on localization

## Roadmap
1. Finish rewriting nodes in Python3.
2. Clean `CMakeLists.txt` and `package.xml` for each project.
3. Test on actual robair.
