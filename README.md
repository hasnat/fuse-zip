# ABOUT #

fuse-zip is a FUSE file system to navigate, extract, create and modify ZIP and
ZIP64 archives based on libzip implemented in C++.

With fuse-zip you really can work with ZIP archives as real directories.
Unlike KIO or Gnome VFS, it can be used in any application without
modifications.

Since version 0.3.0 fuse-zip has support for absolute and parent-relative paths
in file names, but only in read-only mode (-r command line switch). Absolute
paths are displayed under "ROOT" directory, every ".." in path replaced by "UP"
in directory name and "normal" files are placed under "CUR" directory.

Unlike other FUSE filesystems, _only_ fuse-zip provides write support to ZIP
archives. Also, fuse-zip is faster than all known implementations on large
archives with many files.

You can download fuse-zip at https://bitbucket.org/agalanin/fuse-zip

Repository mirror: http://galanin.nnov.ru/hg/fuse-zip

# AUTHOR #

Alexander Galanin

  * E-mail:     al@galanin.nnov.ru
  * Home page:  http://galanin.nnov.ru/~al/

# LICENSE #

fuse-zip are licensed under GNU GPL v3 or later.

# USAGE #

```
$ mkdir /tmp/zipArchive
$ fuse-zip foobar.zip /tmp/zipArchive
(do something with the mounted file system)
$ fusermount -u /tmp/zipArchive
```

If ZIP file does not exists, it will be created after filesystem unmounting.

Be patient. Wait for fuse-zip process finish after unmounting especially on
a big archives.

If you want to specify character set conversion for file names in archive,
use the following fusermount options:

    -omodules=iconv,from_code=$charset1,to_code=$charset2

Those Russian who uses archives from the "other OS" should use CP866 as
'charset1' and locale charset as 'charset2'.

See FUSE documentation for details.

Look at /var/log/user.log in case of any errors.
# BUILD #
To build install following and run `make`

`g++ make pkgconfig libzip-dev fuse-dev`

# DOCKER BUILD #
`docker build -t fuse-zip .`

or COPY it from built image here https://hub.docker.com/r/hasnat/fuse-zip

`COPY --from=hasnat/fuse-zip /usr/local/bin/fuse-zip /usr/local/bin/fuse-zip`
# PERFORMANCE #

On a small archives fuse-zip have the same performance with commonly used
virtual filesystems like KIO, Gnome GVFS, mc vfs, unpackfs, avfs, fuse-j-zip.
But on large archives with many file (like zipped Linux kernel sources)
fuse-zip have the greatest speed.
You can download test suite from the web-site and make sure that it is true.

# PERMISSIONS #

Support for UNIX file permissions and owner information has been added in
version 0.4. Note that access check will not be performed unless
'-o default_permissions' mount option is given.

# HINTS #

* Added/changed files resides into memory until you unmount file system.
* Adding/unpacking very big files(more than one half of available memory) may
  cause your system swapping. It is a good idea to use zip/unzip in that case
  :)
* After adding/modifying files in archive it will be repacked at filesystem
  unmount. Hence, your file system must have enough space to keep temporary
  files.
* Wait until fuse-zip process is finished after unmount before using archive
  file.
