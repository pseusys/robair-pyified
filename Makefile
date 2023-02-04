.ONESHELL:
.DEFAULT_GOAL := run-help

RECORD =
PACKAGE =
NODE =
CONFIG = config-laser.rviz
ROBAIR_IP = 192.168.0.174
BUILD =
SOURCES = sources_py

PATH := venv/bin:$(PATH)


help:
	@ # Print help output
	echo "Welcome to 'robair-pyified'!"
	echo "The following commands are available:"
	echo "- 'make run-test' (equal to 'make'):"
	echo "	Run system demo, without any node. Accepts following args:"
	echo "	- 'RECORD=[RECORD_NAME]' will launch ROSBAG for record 'RECORD_NAME' (required!)."
	echo "		Example: 'make run-test RECORD=2017-09-07-16-55-12.bag'"
	echo "	- 'CONFIG=[CONFIG_FILE]' will set RVIZ default configuration to 'CONFIG_FILE' (not required, default: 'config-laser.rviz')."
	echo "		Example: 'make run-test CONFIG=config-laser.rviz'"
	echo "- 'make run-node':"
	echo "	Run node in emulation, using saved record. Accepts following args:"
	echo "	- 'RECORD=[RECORD_NAME]' will launch ROSBAG for record 'RECORD_NAME' (required!)."
	echo "		Example: 'make run-node RECORD=2017-09-07-16-55-12.bag'"
	echo "	- 'PACKAGE=[PACKAGE_NAME]' will execute ROSRUN for package 'PACKAGE_NAME' (required!)."
	echo "		Example: 'make run-node PACKAGE=tutorial_ros'"
	echo "	- 'NODE=[NODE_NAME]' will execute ROSRUN for node 'NODE_NAME' (required!)."
	echo "		Example: 'make run-node NODE=laser_text_display_node'"
	echo "	- 'CONFIG=[CONFIG_FILE]' will set RVIZ default configuration to 'CONFIG_FILE' (not required, default: 'config-laser.rviz')."
	echo "		Example: 'make run-node CONFIG=config-laser.rviz'"
	echo "- 'make run-phys':"
	echo "	Run node on physical ROBAIR device. Accepts following args:"
	echo "	- 'PACKAGE=[PACKAGE_NAME]' will execute ROSRUN for package 'PACKAGE_NAME' (required!)."
	echo "		Example: 'make run-phys PACKAGE=tutorial_ros'"
	echo "	- 'NODE=[NODE_NAME]' will execute ROSRUN for node 'NODE_NAME' (required!)."
	echo "		Example: 'make run-phys NODE=laser_text_display_node.py'"
	echo "	- 'ROBAIR_IP=[IP_STRING]' will set ROS_IP to 'IP_STRING' (not required, default: '192.168.0.174')."
	echo "		Example: 'make run-phys ROBAIR_IP=192.168.0.174'"
	echo "	- 'CONFIG=[CONFIG_FILE]' will set RVIZ default configuration to 'CONFIG_FILE' (not required, default: 'config-laser.rviz')."
	echo "		Example: 'make run-phys CONFIG=config-laser.rviz'"
	echo "- 'make clean':"
	echo "	Clean all locally built docker images and remove containers and venv directory."
	echo "- 'make help':"
	echo "	Display this message again."
	echo "- 'make venv':"
	echo "	Install 'roslibpy' python package locally for linting, IDE static analysis and testing purposes (supported python versions: 3.6, 3.7, 3.8)."
	echo "Bonus content:"
	echo "Add 'BUILD=--build' argument to any command to build 'robair-pyified' image locally instead of pulling."
	echo "	Example: 'make run-test RECORD=2017-09-07-16-55-12.bag BUILD=--build'"
	echo "Add 'SOURCES=sources_cpp' argument to 'run-node' or 'run-phys' commands to use legacy C++ nodes instead of default Python."
	echo "	Example: 'make run-node RECORD=2017-09-07-16-55-12.bag PACKAGE=tutorial_ros NODE=laser_text_display_node'"
.PHONY: help


run-test:
	@ # Run test on record RECORD
	export CONFIG=$(CONFIG)
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-test.yml up --force-recreate $(BUILD)
.PHONY: run-test

run-node:
	@ # Run node NODE in directory FOLDER on record RECORD
	export CONFIG=$(CONFIG)
	export SOURCES=$(SOURCES)
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	test -n "$(PACKAGE)" || { echo "Please, specify PACKAGE env var!"; exit 1; }
	test -n "$(NODE)" || { echo "Please, specify NODE env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-node.yml up --force-recreate $(BUILD)
.PHONY: run-node

run-phys:
	@ # Run node NODE in directory FOLDER on record RECORD on actual ROBAIR_IP
	export CONFIG=$(CONFIG)
	export SOURCES=$(SOURCES)
	export ROBAIR_IP=$(ROBAIR_IP)
	test -n "$(PACKAGE)" || { echo "Please, specify PACKAGE env var!"; exit 1; }
	test -n "$(NODE)" || { echo "Please, specify NODE env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-phys.yml up --force-recreate $(BUILD)
.PHONY: run-phys


venv:
	@ # Create virtual python environment for linting purposes
	python3 -m venv venv
	pip3 install --upgrade pip
	pip3 install --extra-index-url https://rospypi.github.io/simple/ rospy
	pip3 install --extra-index-url https://rospypi.github.io/simple/ tf2_ros

clean:
	@ # Remove created docker containers and venv dir
	docker rm -f roscore-master rosrun-executable rosbag-simulation rviz-visualization 2> /dev/null || true
	docker rmi $(docker images | grep "robair-pyified-*") 2> /dev/null || true
	rm -rf venv 2> /dev/null
.PHONY: clean
