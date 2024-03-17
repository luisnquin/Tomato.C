#         .             .              .		  
#         |             |              |           .	  
# ,-. ,-. |-. ,-. . ,-. |  ,_, ,-. ,-. |-. ,-,-. . |- ,_, 
# | | ,-| | | |   | |-' |   /  `-. |   | | | | | | |   /  
# `-| `-^ ^-' '   ' `-' `' '"' `-' `-' ' ' ' ' ' ' `' '"' 
#  ,|							  
#  `'							  
# Makefile

include config.mk

ifdef MPVTOGGLE
all: tomatonoise tomato
else
all: tomato
endif

ifdef MPVTOGGLE
tomatonoise: tomatonoise.c
endif

tomato: tomato.o anim.o draw.o input.o notify.o update.o util.o

tomato.o: tomato.c tomato.h anim.c draw.c input.c notify.c update.c util.c config.h

anim.o: anim.h

draw.o: draw.h

input.o: input.h

ifdef MPVTOGGLE
notify.o: notify.h
endif

update.o: update.h

util.o: util.h

clean:
	rm -rf tomato tomatonoise *.o

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f tomato ${DESTDIR}${PREFIX}/bin
ifdef MPVTOGGLE
	cp -f tomatonoise ${DESTDIR}${PREFIX}/bin
endif
	mkdir -p ${DESTDIR}${APPPREFIX}
	cp -f tomato.desktop ${DESTDIR}${APPPREFIX}
	mkdir -p ${DESTDIR}${PREFIX}/share/tomato
	mkdir -p ${DESTDIR}${PREFIX}/share/tomato/sounds
	mkdir -p ${DESTDIR}${PREFIX}/share/tomato/icons
	cp -rf sounds ${DESTDIR}${PREFIX}/share/tomato/
	sed -i "" "s|Icon=.*|Icon=/opt/local/share/tomato/icons/tomato.svg|" tomato.desktop
	sudo cp -f icons/tomato.svg ${DESTDIR}${PREFIX}/share/tomato/icons
	chmod 755 ${DESTDIR}${PREFIX}/bin/tomato
ifdef MPVTOGGLE
	chmod 755 ${DESTDIR}${PREFIX}/bin/tomatonoise
endif

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/tomato
ifdef MPVTOGGLE
	rm -f ${DESTDIR}${PREFIX}/bin/tomatonoise
endif
	rm -rf ${DESTDIR}${PREFIX}/share/tomato
	rm -f ${DESTDIR}${APPPREFIX}/tomato.desktop

nix-try:
	nix build
	./result/bin/tomato

