# from samples

#include $(WXDIR)/build/msw/config.dmc
CXX = dmc
DMD = dmd
DFLAGS =$(DFLAGS) -I$(TOPDIR) -g

WX_RELEASE_NODOT = 25
OBJS = dmc_mswd$(CFG)
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)
SETUPHDIR = $(LIBDIRNAME)\mswd
CXXFLAGS = -g -o+none -D__WXMSW__ -D__WXDEBUG__ -I$(WXDIR)\include \
	-I$(SETUPHDIR) -w- -I. -WA -DNOPCH -Ar -Ae $(CPPFLAGS) \
	$(CXXFLAGS)

.cpp.obj: 
	$(CXX) -mn -c $(CXXFLAGS) $< -o$@

.d.obj:
	dmd -c $(DFLAGS) $<

WXLIBS = \
	$(LIBDIRNAME)\wxbase$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR).lib \
	$(LIBDIRNAME)\wxbase$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_xml.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_core.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_adv.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_html.lib \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_xrc.lib \
	$(LIBDIRNAME)\wxtiffd.lib \
	$(LIBDIRNAME)\wxjpegd.lib \
	$(LIBDIRNAME)\wxpngd.lib \
	$(LIBDIRNAME)\wxzlibd.lib \
	$(LIBDIRNAME)\wxregexd.lib \
	$(LIBDIRNAME)\wxexpatd.lib  \
	kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib odbc32.lib

$(TARGET) : $(OBJECTS)
#	link /NOLOGO /SILENT /NOI /DELEXECUTABLE /EXETYPE:NT $(LDFLAGS) /DEBUG /CODEVIEW  /su:windows $(OBJECTS),$@,$(TARGET).map, $(TOPDIR)\wxc.lib $(TOPDIR)\wxd.lib $(LIBDIRNAME)\  ,, $(RES)
	dmd -g -of$(TARGET) $(OBJECTS) $(TOPDIR)\wxd.lib $(TOPDIR)\wxc.lib $(WXLIBS)

clean:
	-del *.obj
	-del *.map
	-del $(TARGET)

