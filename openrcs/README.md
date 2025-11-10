# RCS (Revision Control System)

This is OpenBSD's version of RCS. It has been modified from upsteam only
to replace the \$OpenBSD\$ keyword with \$Ragnarok\$.

This port would have been impossible without Ibara's [baseutils](https://github.com/ibara/baseutils)
repository.

# Build

On non-Ragnarok systems, make sure that [libopenbsd](https://github.com/RagnarokOS/libopenbsd)
is installed first.

By default, cc is set to clang in the Makefile. Replace with gcc if desired.
Removing the ThinLTO flags will be required in such a case, however.

**deb package**: this is a very simple package built with dpkg-deb rather
than debuild/dpkg-buildpackage. Running `make DESTDIR=openrcs_$VERSION`,
substituting *$VERSION* for the package version, will quickly build the
package. 

**Basic build/install**: simply run `make && make install`.
