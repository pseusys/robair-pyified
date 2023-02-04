.ONESHELL:
.DEFAULT_GOAL := run-test

CONFIG = config-laser.rviz
RECORD =
FOLDER =
NODE =
ROBAIR_IP = 192.168.0.174



help:
	@ # Print help output
	echo "'robair-pyified' help"
.PHONY: help


run-test:
	@ # Run test on record RECORD
	export CONFIG=$(CONFIG)
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-test.yml up --build
.PHONY: run-test

run-node:
	@ # Run node NODE in directory FOLDER on record RECORD
	export CONFIG=$(CONFIG)
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	test -n "$(FOLDER)" || { echo "Please, specify FOLDER env var!"; exit 1; }
	test -n "$(NODE)" || { echo "Please, specify NODE env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-node.yml up --build
.PHONY: run-node

run-phys:
	@ # Run node NODE in directory FOLDER on record RECORD on actual ROBAIR_IP
	export CONFIG=$(CONFIG)
	test -n "$(RECORD)" || { echo "Please, specify RECORD env var!"; exit 1; }
	test -n "$(FOLDER)" || { echo "Please, specify FOLDER env var!"; exit 1; }
	test -n "$(NODE)" || { echo "Please, specify NODE env var!"; exit 1; }
	test -n "$(ROBAIR_IP)" || { echo "Please, specify ROBAIR_IP env var!"; exit 1; }
	xhost +local:docker
	docker-compose -f ./docker/docker-compose-phys.yml up --build
.PHONY: run-phys


clean:
	@ # Remove created docker containers
	docker rm roscore-master rosrun-executable rosbag-simulation rviz-visualization 2> /dev/null || true
.PHONY: clean
