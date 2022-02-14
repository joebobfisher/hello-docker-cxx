FROM ubuntu:latest

LABEL Name=hellodocker Version=0.0.2 description="Development container"

# Get dev tools we'll need (not for this hello example though...)
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install g++ cmake clang-tidy
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install openssh-server

# These commands copy your files into the specified directory in the image
# and set that as the working location
COPY . /usr/src/hellodocker
WORKDIR /usr/src/hellodocker

# This command compiles your app using GCC, adjust for your source code
#RUN g++ -o hellodocker test.cpp

# This command runs your application, comment out this line to compile only
#CMD ["./hellodocker"]

# configure SSH for communication with VS Code, CLion, et al.
RUN mkdir -p /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    ssh-keygen -A

# start SSH
RUN service ssh start
RUN useradd -m -d /home/luser -s /bin/bash -G sudo luser

# expose port 22 so we can connect to SSH from a (different) outside port
EXPOSE 22