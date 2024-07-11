FROM ros:noetic-robot-focal 
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y git python3-catkin-tools ros-noetic-roslint ros-noetic-gazebo* ros-noetic-joint-state-publisher ros-noetic-joint-state-publisher-gui ros-noetic-rviz ros-noetic-rqt-robot-steering ros-noetic-teleop-twist-keyboard && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp &&  git clone https://github.com/agilexrobotics/ugv_gazebo_sim.git
RUN mkdir -p /limo_ws/src
RUN cp -r /tmp/ugv_gazebo_sim/limo/* /limo_ws/src/.
RUN cd /limo_ws/src && \
    git clone https://github.com/ros-controls/urdf_geometry_parser.git && \
    git clone https://github.com/ros-controls/ros_control.git && \
    git clone https://github.com/ros-drivers/four_wheel_steering_msgs.git && \
    git clone https://github.com/ros-controls/ros_controllers.git  && \
    cd ros_controllers && git checkout 7df8be7eaf8c6b90d35f477c5cea0669d78d8f3b
RUN bash -c "source /opt/ros/noetic/setup.bash && cd /limo_ws && catkin build"
# ## rosdep install --from-paths src --ignore-src -r -y 

RUN "source /limo_ws/devel/setup.bash" >> /root/.bashrc