docker run -it --rm \
--env DISPLAY=$DISPLAY \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--name agilex_limo_gazebo \
agilex_limo_gazebo bash