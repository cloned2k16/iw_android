#!/bin/sh
set -e

LIB_NL_URL="https://github.com/thom311/libnl/releases/download/libnl3_4_0/libnl-3.4.0.tar.gz"
IW_SRC_URL="https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/snapshot/iw-4.14.tar.gz"
BUILD_DIR="build"

LIB_NL_TGZ="${LIB_NL_URL##*/}"
IW_SRC_TGZ="${IW_SRC_URL##*/}"


[ -f "$LIB_NL_TGZ"  ]   	&&  echo "got ..			$LIB_NL_TGZ" 	||   	wget   "$LIB_NL_URL"
[ -f "$IW_SRC_TGZ" ]   		&&  echo "got ..			$IW_SRC_TGZ"   	||   	wget   "$IW_SRC_URL"

LIB_NL_DIR="${LIB_NL_TGZ%.tar*}"
IW_SRC_DIR="${IW_SRC_TGZ%.tar*}"

# unpack source files
[ -d "$LIB_NL_DIR" ] 		&&  echo "found libnl sources in	$LIB_NL_DIR"	||	echo "unTar  .. $LIB_NL_TGZ";	tar xf "${LIB_NL_TGZ}"
[ -d "$IW_SRC_DIR"    ]		&&  echo "found iw    sources in 	$IW_SRC_DIR"	|| 	echo "unTar  .. $IW_SRC_TGZ";  	tar xf "${IW_SRC_TGZ}"

# output directory
prefix="`pwd`/$BUILD_DIR"
[ -d "$prefix" ]    || mkdir $BUILD_DIR

echo "building in .. $prefix ..."


# build libnl
if ! [ -f "${prefix}/lib/libnl-3.a" ] ; then
    (
	cd "$LIB_NL_DIR"
	../android_buildenv.sh ./configure \
		--host=arm-linux-androideabi \
		--enable-static	\
		--disable-shared \
		--disable-pthreads \
		--disable-cli \
		--prefix=$prefix
	../android_buildenv.sh make
	../android_buildenv.sh make install
    )
fi

if ! [ -f "${IW_SRC_DIR}/iw" ] ; then
    (
	cd "$IW_SRC_DIR"
	if ! [ -f ".patch.applied" ] ; then
		patch <../diff_iw41_Makefile_libm.patch
		touch ".patch.applied"
	fi
	export PKG_CONFIG_PATH="${prefix}/lib/pkgconfig"
	../android_buildenv.sh make V=1
	cp iw iw.stripped
	../android_buildenv.sh sh -c "\${CROSS_COMPILE}strip -s iw.stripped"
    )
fi

echo "*** Iw has been compiled, output files are iw and iw.stripped in $iw_dir"
