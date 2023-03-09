FROM ros:noetic-ros-base-focal

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y ros-noetic-desktop python3-catkin-tools && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN mkdir -p /~/catkin_ws/src
RUN cd /~/catkin_ws/src && source /opt/ros/noetic/setup.bash && catkin_init_workspace
RUN cd /~/catkin_ws && source /opt/ros/noetic/setup.bash && catkin_make
WORKDIR /~/catkin_ws

COPY docker/entrypoint.sh ./
COPY docker/launch_config.py ./
ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["rosversion", "ros"]
