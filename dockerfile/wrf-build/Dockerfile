# Build WRF model from source
#
# Usage:
#   docker run --rm --name <container> \
#              [-v <patch_dir>:/data/src/patch] \
#              [-v <WPS_dir>:/data/src/WPS] \
#              [-v /opt/intel:/opt/intel] \
#              -v <WRF_dir>:/data/src/WRF \
#              -it <image> WPS|WRF [options]
#
# Options:
#   choices=<choice_no1>,<choice_no2>,...
#
#   * Since docker-run failed to display selections before the user
#     enter the choice, choices are predefined with the "choices="
#     option, if no choices are provided, the build script will use
#     a default value
#
# Note:
#
#   * The WRF source directory must be mounted
#
#   * The WPS source directory should be mounted if building WPS
#
#   * The Intel compiler root directory is hard coded as /opt/intel
#
#   * The patches to be applied to the source directory should be
#     available in /data/src/patch with file suffix ".patch"

FROM wrf-base

MAINTAINER Li Jiapeng "lijpbasin@126.com"

# Replace cpp program with a wrapped scripts which will remove
# any "-C" options and ensure "-traditional" is used, it would
# be necessary and sufficient to build WRF model
ADD cpp /usr/bin/cpp.wrapper
RUN chmod 755 /usr/bin/cpp.wrapper && chown root.root /usr/bin/cpp.wrapper && \
    ln -s -f /usr/bin/cpp.wrapper /usr/bin/cpp

ADD build.sh /data/build.sh

ENTRYPOINT ["/bin/bash", "/data/build.sh"]
