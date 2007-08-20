# from samples

# the regular Digital Mars Makefile

# hardcoded: DEBUG
PLATFORM = WXMSW
DEBUG_FLAG = -D__WXDEBUG__
WXDEBUGFLAG = d

# hardcoded: ANSI
ENCODING = ANSI
UNICODE_FLAG =
WXUNICODEFLAG =

include $(TOPDIR)/config.mak

CXX = dmc
DC = dmd
DFLAGS = $(DFLAGS) -version=__$(PLATFORM)__ -version=$(ENCODING) -I$(TOPDIR)

include $(WXDIR)/build/msw/config.dmc

OBJS = dmc_msw$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(CFG)
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)
SETUPHDIR = $(LIBDIRNAME)\msw$(WXUNICODEFLAG)$(WXDEBUGFLAG)
CXXFLAGS = -g -o+none -D__$(PLATFORM)__ $(DEBUG_FLAG) $(UNICODE_FLAG) -I$(WXDIR)\include \
	-I$(SETUPHDIR) -w- -I. -WA -DNOPCH -Ar -Ae $(CPPFLAGS) \
	$(CXXFLAGS)

.cpp.obj: 
	$(CXX) -mn -c $(CXXFLAGS) $< -o$@

.d.obj:
	$(DC) -c $(DFLAGS) $<

WXLIBS = \
	$(LIBDIRNAME)\wxbase$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR).lib \
	$(LIBDIRNAME)\wxbase$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_xml.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_core.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_adv.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_html.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_xrc.lib \
	$(LIBDIRNAME)\wxtiff$(WXDEBUGFLAG).lib \
	$(LIBDIRNAME)\wxjpeg$(WXDEBUGFLAG).lib \
	$(LIBDIRNAME)\wxpng$(WXDEBUGFLAG).lib \
	$(LIBDIRNAME)\wxzlib$(WXDEBUGFLAG).lib \
	$(LIBDIRNAME)\wxregex$(WXDEBUGFLAG).lib \
	$(LIBDIRNAME)\wxexpat$(WXDEBUGFLAG).lib  \
	kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib

all: $(TARGET)

$(TARGET) : $(OBJECTS)
#	link /NOLOGO /SILENT /NOI /DELEXECUTABLE /EXETYPE:NT $(LDFLAGS) /DEBUG /CODEVIEW  /su:windows $(OBJECTS),$@,$(TARGET).map, $(TOPDIR)\wxc.lib $(TOPDIR)\wxd.lib $(LIBDIRNAME)\  ,, $(RES)
	dmd -g -of$(TARGET) $(OBJECTS) $(TOPDIR)\wxd.lib $(TOPDIR)\wxc.lib $(WXLIBS) $(STCLIBS) $(GLLIBS) $(SDLLIBS) -L/EXETYPE:NT -L/SU:WINDOWS:4.0

clean:
	-del *.obj
	-del *.map
	-del $(TARGET)

