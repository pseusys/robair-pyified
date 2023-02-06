FROM ros:noetic-ros-base-focal as ros-desktop

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
ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["rosversion", "ros"]


FROM ros-desktop as ros-launcher

COPY docker/launch_config.py ./


FROM ros-desktop as ros-gazebo

ADD https://packages.osrfoundation.org/gazebo.key /tmp
RUN cat /tmp/gazebo.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/gazebo-stable.gpg
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list

RUN apt-get update && apt-get install --no-install-recommends -y gazebo11 libgazebo11-dev ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control && rm -rf /var/lib/apt/lists/*
