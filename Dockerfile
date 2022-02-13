# GCC support can be specified at major, minor, or micro version
# (e.g. 8, 8.2 or 8.2.0).
# See https://hub.docker.com/r/library/gcc/ for all supported GCC
# tags from Docker Hub.
# See https://docs.docker.com/samples/library/gcc/ for more on how to use this image
FROM ubuntu:latest

# Get dev tools we'll need (not for this hello example though...)
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install g++ cmake clang-tidy
RUN apt-get -y install libboost-all-dev

# These commands copy your files into the specified directory in the image
# and set that as the working location
COPY . /usr/src/hellodocker
WORKDIR /usr/src/hellodocker

# This command compiles your app using GCC, adjust for your source code
RUN g++ -o hellodocker test.cpp

# This command runs your application, comment out this line to compile only
CMD ["./hellodocker"]

LABEL Name=hellodocker Version=0.0.1
