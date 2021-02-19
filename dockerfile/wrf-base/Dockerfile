# Base image for WRF build and run
#

FROM debian:latest

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Common packages to build and run WRF (Weather Research and Forecasting) model
RUN echo "deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y m4 make patch gfortran file \
                          csh libnetcdf-dev libmpich-dev mpich \
                          libjasper-dev libpng12-dev zlib1g-dev
