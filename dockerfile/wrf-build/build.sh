#!/bin/bash

# The choice numbers vary with WRF version and Platform
# WPS and WRF should be built with the same type of compiler,
# e.g. both use Intel or gfortran compiler
#
DEFAULT_WRF_CHOICES="11,1" # Intel compiler, mpi, basic nesting
DEFAULT_WPS_CHOICES="2" # Intel compiler, serial, grib2
#DEFAULT_WRF_CHOICES="15,1" # gfortran compiler, mpi, basic nesting
#DEFAULT_WPS_CHOICES="6" # gfortran compiler, serial, grib2

PATCH="/usr/bin/patch -p1"

export NETCDF=/usr
export JASPERLIB=/usr/lib/x86_64-linux-gnu
export JASPERINC=/usr/include
INTEL_ENV=/opt/intel/composerxe/bin/compilervars.sh
INTEL_ARCH=intel64

[ -e "$INTEL_ENV" ] && source "$INTEL_ENV" $INTEL_ARCH

case "$1" in
WRF)
    source_dir=/data/src/WRF
    build() {
        [ -z "$CHOICES" ] && CHOICES="$DEFAULT_WRF_CHOICES"
        echo "$CHOICES" | sed 's/,/\n/g' | ./configure 2>&1 | tee config.log
        ./compile em_real 2>&1 | tee compile.log
    }
    ;;
WPS)
    source_dir=/data/src/WPS
    build() {
        [ -z "$CHOICES" ] && CHOICES="$DEFAULT_WPS_CHOICES"
        echo "$CHOICES" | sed 's/,/\n/g' | ./configure 2>&1 | tee config.log
        sed -i -e "s#\(COMPRESSION_INC.*=\).*#\1 -I$JASPERINC#" \
               -e "s#\(COMPRESSION_LIBS.*=\).*#\1 -L$JASPERLIB -ljasper -lpng -lz#" \
               -e "s#\(WRF_DIR.*=\).*#\1 ../WRF#" \
               configure.wps
        ./compile 2>&1 | tee compile.log
    }
    ;;
*)
    echo "Unknown option '$1'" >&2
    exit 127
    ;;
esac

CHOICES=`echo "$2" | sed -n '/^choices=/ s/^choices=//p'`

patch_dir=/data/src/patch

cd "$source_dir" || exit 1

if [ -d "$patch_dir" ]
then
    for patch_file in "$patch_dir"/*.patch
    do
        $PATCH <"$patch_file"
    done
fi

build

# Apply UID/GID of the source directory recursively
chown -R `stat -c '%u:%g' .` .
