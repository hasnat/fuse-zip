#!/bin/sh

if [ $# != 0 ]
then
    echo "usage: $0"
    echo "  generate archives for product"
    exit 1
fi

version=`grep '#define VERSION' fuse-zip.cpp | sed 's/^[^"]*"//;s/".*$//'`
[ "$version" != "" ] || (echo "Unable to determine version"; exit 1)

dir=`mktemp -d`
pwd=`pwd`

# make program tarball
id="fuse-zip-$version"
tmp="$dir/$id"

mkdir "$tmp"
cp -t "$tmp" *.cpp *.h Makefile INSTALL LICENSE README changelog fuse-zip.1

rm -f "$id.tar.gz"
cd "$dir"
tar -cvzf "$pwd/$id.tar.gz" "$id"
cd "$pwd"

# make tests tarball
id="fuse-zip-tests-r`hg log tests | head -n 1 | cut -d : -f 2 | sed 's/ //g'`"
tmp="$dir/$id"

mkdir "$tmp"
mkdir "$tmp/kio_copy"
cp -t "$tmp" tests/README tests/run-tests.tcl tests/unpackfs.config
cp -t "$tmp/kio_copy" tests/kio_copy/kio_copy.pro tests/kio_copy/main.cpp

rm -rf "$id.tar.gz"
cd "$dir"
tar -cvzf "$pwd/$id.tar.gz" "$id"
cd "$pwd"

rm -rf "$dir"

