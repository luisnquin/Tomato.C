#         .             .              .		  
#         |             |              |           .	  
# ,-. ,-. |-. ,-. . ,-. |  ,_, ,-. ,-. |-. ,-,-. . |- ,_, 
# | | ,-| | | |   | |-' |   /  `-. |   | | | | | | |   /  
# `-| `-^ ^-' '   ' `-' `' '"' `-' `-' ' ' ' ' ' ' `' '"' 
#  ,|							  
#  `'							  
# config.mk

PREFIX  = /opt/local
APPPREFIX = $(PREFIX)/share/applications
LOGPREFIX = .local/share/tomato

# To remove mpv as a dependencie
# comment this line below,
# and toggle off the sound and noise
# at config.h
MPVTOGGLE = 1

DFLAGS = -D_POSIX_C_SOURCE -DTOMATONOISE=\"$(PREFIX)/bin/tomatonoise\" -DLOGPREFIX=\"$(LOGPREFIX)\" -DLOGFILE=\"$(LOGPREFIX)/tomato.log\" -DTMPFILE=\"$(LOGPREFIX)/tmp.log\" -DTIMERFILE=\"$(LOGPREFIX)/time.log\" -DNOTEPADFILE=\"$(LOGPREFIX)/notepad.log\"
CPPFLAGS = -I/opt/local/include
CFLAGS  = -std=c99 -Wall -Wextra -pedantic -Wunused-result -Wno-unused-variable -Os ${DFLAGS}
LDFLAGS = -L/opt/local/lib

ifdef __APPLE__
	ifdef MPVTOGGLE
		LDLIBS  = -lncurses -lmpv
	else
		LDLIBS  = -lncurses
	endif
else
	ifdef MPVTOGGLE
		LDLIBS  = `pkg-config --libs ncursesw mpv`
	else
		LDLIBS  = `pkg-config --libs ncursesw`
	endif
endif

