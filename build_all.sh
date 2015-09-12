#!/bin/sh
set -e

libnl_tgz="libnl-3.2.25.tar.gz"
libnl_url="http://www.infradead.org/~tgr/libnl/files/$libnl_tgz"

iw_txz="iw-4.1.tar.xz"
iw_url="https://kernel.org/pub/software/network/iw/$iw_txz"

libnl_dir="${libnl_tgz%.tar.gz}"
iw_dir="${iw_txz%.tar.xz}"
prefix="`pwd`/prefix"

# fetch all sourcecode archive
[ -f "$libnl_tgz" ] || wget $libnl_url
[ -f "$iw_txz" ]    || wget "$iw_url"

# output directory
[ -d "$prefix" ]    || mkdir prefix

# unpack source files
[ -d "$libnl_dir" ] || tar xf "${libnl_tgz}"
[ -d "$iw_dir"    ] || tar xf "${iw_txz}"

# build libnl
if ! [ -f "${prefix}/lib/libnl-3.a" ] ; then
    (
	cd "$libnl_dir"
	../android_buildenv.sh ./configure \
		--host=arm-linux-androideabi \
		--enable-static --disable-shared \
		--disable-pthreads --disable-cli \
		--prefix=$prefix
	../android_buildenv.sh make
	../android_buildenv.sh make install
    )
fi

(
	cd "$iw_dir"
	patch <../diff_iw41_Makefile_libm.patch
	export PKG_CONFIG_PATH=${prefix/lib/pkgconfig}
	../android_buildenv.sh make V=1
)
