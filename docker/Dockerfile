FROM ros:noetic-ros-base-focal

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install --no-install-recommends -y ros-noetic-desktop python3-catkin-tools
RUN rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN mkdir -p /~/catkin_ws/src
WORKDIR /~/catkin_ws

COPY docker/entrypoint.sh ./
COPY docker/generate_launch_config.py ./

RUN source /opt/ros/noetic/setup.bash && catkin_make

ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["rosversion", "ros"]
