.ONESHELL:
.EXPORT_ALL_VARIABLES:
.DEFAULT_GOAL := help

CONFIG = config-laser.rviz
ROBAIR_IP = 192.168.0.175
SOURCES = sources_py
ENV = .conf.env
include $(ENV)

SHELL = /bin/bash
PATH := venv/bin:$(PATH)


help:
	@ # Print help output
	echo "Welcome to 'robair-pyified'!"
	echo "The following commands are available:"
	echo "- 'make run-node':"
	echo "	Run node in emulation, using saved record."
	echo "- 'make run-phys':"
	echo "	Run node on physical RobAIR device."
	echo "- 'make clean':"
	echo "	Clean all locally built docker images and remove containers and venv directory."
	echo "- 'make venv':"
	echo "	Install 'roslibpy' python package locally for linting, IDE static analysis and testing purposes."
	echo "- 'make help' (equal to 'make'):"
	echo "	Display this message again."
	echo "Bonus content:"
	echo "- Add 'BUILD=--build' argument to any command to build 'robair-pyified' image locally instead of pulling."
	echo "- Add 'SOURCES=sources_cpp' argument to 'run-node' or 'run-phys' commands to use legacy C++ nodes instead of default Python."
	echo "- Any of the arguments can be read from .ENV file using 'ENV=<ENV_FILE_NAME>' parameter."
	echo "See the argument description in the 'README.md' file!"
.PHONY: help


run-node:
	@ # Run target TARGET on record RECORD
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	test -n "$(TARGET)" || { echo "Please, specify TARGET env var!"; exit 1; }
	xhost +local:docker
	export LAUNCH=config/ros-node.launch
	docker-compose -f ./docker/docker-compose.yml up --force-recreate $(BUILD)
.PHONY: run-node

run-phys:
	@ # Run target TARGET on actual RobAIR with ROBAIR_IP
	test -n "$(TARGET)" || { echo "Please, specify TARGET env var!"; exit 1; }
	xhost +local:docker
	export LAUNCH=config/ros-phys.launch
	docker-compose -f ./docker/docker-compose.yml up --force-recreate $(BUILD)
.PHONY: run-phys


venv:
	@ # Create virtual python environment for linting purposes
	python3 -m venv venv
	pip3 install --upgrade pip
	pip3 install --extra-index-url https://rospypi.github.io/simple/ rospy
	pip3 install --extra-index-url https://rospypi.github.io/simple/ tf2_ros

clean:
	@ # Remove created docker containers and venv dir
	docker rm -f roslaunch-combined-environment 2> /dev/null || true
	docker rmi ghcr.io/pseusys/robair-pyified/ros-launch:main 2> /dev/null || true
	rm -rf venv 2> /dev/null
.PHONY: clean
