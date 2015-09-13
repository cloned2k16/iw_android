#!/bin/sh
NDK="/usr/opt/android-ndk-r10e-linux-x86_64"
CC_DIR="$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin"
SYSROOT="$NDK/platforms/android-21/arch-arm"

CROSS_COMPILE="$CC_DIR/arm-linux-androideabi-"
CC="${CROSS_COMPILE}gcc"
CXX="${CROSS_COMPILE}g++"
LD="${CROSS_COMPILE}ld"

CFLAGS="-Os -ggdb -fPIE --sysroot=$SYSROOT"
CXXFLAGS="$CFLAGS"
CPPFLAGS="--sysroot=$SYSROOT"
LDFLAGS="--sysroot=$SYSROOT -pie"

export CC CXX LD CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
exec "$@"

