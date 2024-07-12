FROM ros:noetic-robot-focal

### speedup download
# https://genzouw.com/entry/2019/09/04/085135/1718/
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y git python3-catkin-tools ros-noetic-roslint ros-noetic-gazebo* ros-noetic-joint-state-publisher ros-noetic-joint-state-publisher-gui ros-noetic-rviz ros-noetic-rqt-robot-steering ros-noetic-teleop-twist-keyboard ros-noetic-ros-control ros-noetic-ros-controllers && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp &&  git clone https://github.com/agilexrobotics/ugv_gazebo_sim.git && \
    mkdir -p /limo_ws/src && cp -r /tmp/ugv_gazebo_sim/limo/* /limo_ws/src/.
RUN bash -c "source /opt/ros/noetic/setup.bash && cd /limo_ws && catkin build"
RUN echo "source /limo_ws/devel/setup.bash" >> /root/.bashrc