# RobAIR-TP-Sources

Fichiers sources pour les projets de robotique autour de RobAIR https://github.com/fabMSTICLig/RobAIR dans le cadre des cours d'Olivier Aycard https://lig-membres.imag.fr/aycard/index.php?&slt=enseignement

Same as before but rewritten for python3 use.  
Also, Docker support added.

Use this by running following commands:
- To test the system: `make RECORD=2017-09-07-16-55-12.bag`
- To run locally: `make run-node RECORD=2017-09-07-16-55-12.bag PACKAGE=tutorial_ros NODE=laser_text_display_node`
- To run on actual robair: `make run-phys RECORD=2017-09-07-16-55-12.bag PACKAGE=tutorial_ros NODE=laser_text_display_node`

## assets/data
Data for perception

## assets/map
Map of UFR IM2AG

## sources/tutorial_ros
Tutorial on ROS

## sources/teleoperation
Lab on teleoperation

## sources/follow_me
Lab on "follow me" behavior: detection part

## sources/localization
Lab on localization
