# Makefile for OpenBSD's version of RCS (Revision Control System)
# $Ragnarok: Makefile,v 1.8 2025/03/06 00:30:42 lecorbeau Exp $

CC ?=		cc
CFLAGS ?=	-O2 -pipe
CFLAGS +=	-I/lib/libopenbsd -include openbsd.h -I. -D_GNU_SOURCE
CPPFLAGS +=	
LDFLAGS +=	

LIBS =		/lib/libopenbsd/libopenbsd.a

# Define which yacc to use. Default: OpenBSD's yacc.
YACC	=	/usr/bin/oyacc

BINDIR =	/usr/bin
MANDIR =	/usr/share/man

PROG =	rcs
OBJS =	ci.o co.o ident.o merge.o rcsclean.o rcsdiff.o rcsmerge.o rcsparse.o \
	rcsprog.o rlog.o rcsutil.o buf.o date.o diff.o diff3.o rcs.o rcsnum.o \
	rcstime.o worklist.o xmalloc.o

all: ${OBJS}
	${CC} ${LDFLAGS} -o ${PROG} ${OBJS} ${LIBS}

date.c: date.y
	${YACC} date.y
	mv y.tab.c date.c

install:
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MANDIR}/man1
	install -d ${DESTDIR}${MANDIR}/man5
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/${PROG}
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/ci
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/co
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/ident
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/merge
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/rcsclean
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/rcsdiff
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/rcsmerge
	install -c -m 555 ${PROG} ${DESTDIR}${BINDIR}/rlog
	install -c -m 444 ${PROG}.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 ci.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 co.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 ident.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 merge.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rcs.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rcsclean.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rcsdiff.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rcsmerge.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rlog.1 ${DESTDIR}${MANDIR}/man1
	install -c -m 444 rcsfile.5 ${DESTDIR}${MANDIR}/man5

test:
	@echo "No tests"

clean:
	rm -f ${PROG} ${OBJS} date.c
