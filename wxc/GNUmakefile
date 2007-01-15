LIBTARGET=../libwxc.a

OBJECTS = \
	accel.o \
	activateevent.o \
	app.o \
	artprovider.o \
	bitmap.o \
	bitmapbutton.o \
	boxsizer.o \
	brush.o \
	button.o \
	calendarctrl.o \
	caret.o \
	checkbox.o \
	childfocusevent.o \
	choice.o \
	choicedialog.o \
	clientdata.o \
	clipboard.o \
	closeevent.o \
	colour.o \
	colourdialog.o \
	combobox.o \
	commandevent.o \
	config.o \
	contextmenuevent.o \
	control.o \
	cursor.o \
	dataformat.o \
	dataobject.o \
	dc.o \
	dialog.o \
	dirdialog.o \
	display.o \
	displaychangedevent.o \
	dnd.o \
	docmanager.o \
	doctemplate.o \
	document.o \
	eraseevent.o \
	event.o \
	evthandler.o \
	filedialog.o \
	findreplacedialog.o \
	flexgridsizer.o \
	focusevent.o \
	font.o \
	fontdialog.o \
	fontmisc.o \
	frame.o \
	gauge.o \
	gdicmn.o \
	gdiobject.o \
	glcanvas.o \
	global.o \
	grid.o \
	gridbagsizer.o \
	gridctrl.o \
	gridsizer.o \
	helpevent.o \
	html.o \
	htmlhelpctrl.o \
	htmllbox.o \
	icon.o \
	iconizeevent.o \
	idleevent.o \
	image.o \
	imagelist.o \
	imghandler.o \
	initdialogevent.o \
	keyevent.o \
	laywin.o \
	listbook.o \
	listbox.o \
	listctrl.o \
	locale.o \
	log.o \
	maximizeevent.o \
	mdi.o \
	memorydc.o \
	menu.o \
	menubar.o \
	menuitem.o \
	messagedialog.o \
	miniframe.o \
	mousecapturechangedevent.o \
	mouseevent.o \
	moveevent.o \
	navigationkeyevent.o \
	ncpaintevent.o \
	notebook.o \
	notebooksizer.o \
	object.o \
	paintevent.o \
	palette.o \
	palettechangedevent.o \
	panel.o \
	pen.o \
	printdata.o \
	printdialog.o \
	printer.o \
	printpreview.o \
	progdlg.o \
	querynewpaletteevent.o \
	radiobox.o \
	radiobutton.o \
	region.o \
	sashwindow.o \
	scrollbar.o \
	scrolledwindow.o \
	setcursorevent.o \
	showevent.o \
	sizeevent.o \
	sizer.o \
	sizeritem.o \
	slider.o \
	sound.o \
	spinbutton.o \
	spinctrl.o \
	splashscreen.o \
	splitterwindow.o \
	staticbitmap.o \
	staticbox.o \
	staticboxsizer.o \
	staticline.o \
	statictext.o \
	statusbar.o \
	styledtextctrl.o \
	syscolourchangedevent.o \
	systemsettings.o \
	tabctrl.o \
	textctrl.o \
	textdialog.o \
	tipdialog.o \
	tipwindow.o \
	togglebutton.o \
	toolbar.o \
	tooltip.o \
	treectrl.o \
	updateuievent.o \
	validator.o \
	view.o \
	vlbox.o \
	vscroll.o \
	window.o \
	windowcreateevent.o \
	windowdestroyevent.o \
	wizard.o \
	wxdatetime.o \
	wxstring.o \
	wxversion.o \
	wxplatform.o \
	xmlresource.o \
	numdialog.o \
	manager.o \
	wxaui.o
	
#	notifyevent.o
	

all:  PLATFORM ENCODING $(LIBTARGET)

WX_CONFIG ?= wx-config

CXX ?= $(shell $(WX_CONFIG) --cxx)
CXXFLAGS ?= -O2 -Wall

# Note: -g debugging symbols are off for "libwxc",
#       since it makes it bigger for no good reason
#       (the code in the C++ wrappers is "trivial",
#       so it should be enough to debug the D layer)

OS=$(shell uname)

ifeq ("$(OS)","FreeBSD")
CXXFLAGS += -fno-strict-aliasing
CXXFLAGS += -I/usr/X11R6/include
endif

ifeq ("$(STC)","1")
STCFLAGS = -DWXD_STYLEDTEXTCTRL
endif

WXFLAGS = `$(WX_CONFIG) --cxxflags`

prefix=/usr/local
exec_prefix=$(prefix)
includedir=$(prefix)/include
libdir=$(exec_prefix)/lib

INSTALL = install
RANLIB = ranlib

INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = ${INSTALL} -m 644

install: $(LIBTARGET)
	$(INSTALL) -d $(DESTDIR)$(libdir)
	$(INSTALL_DATA) -p $(LIBTARGET) $(DESTDIR)$(libdir)
	-$(RANLIB) $(DESTDIR)$(libdir)/`basename $(LIBTARGET)`

PLATFORM: wx-platform$(EXEEXT)
	WX_CONFIG=$(WX_CONFIG) ./wx-platform.sh > $@

ENCODING: wx-encoding$(EXEEXT)
	WX_CONFIG=$(WX_CONFIG) ./wx-encoding.sh > $@

$(LIBTARGET) : $(OBJECTS)
	ar rcs $@ $^

%.o:%.cpp
	$(CXX) -D__$(COMPILER)__ $(STCFLAGS) $(WXFLAGS) $(CXXFLAGS) -c -o $@ $<

wx-platform$(EXEEXT): wx-platform.o
	$(CXX) $(LDFLAGS) -o $@ $<
	
wx-encoding$(EXEEXT): wx-encoding.o
	$(CXX) $(LDFLAGS) -o $@ $<

clean:
	-rm *.o
	-rm wx-platform$(EXEEXT)
	-rm wx-encoding$(EXEEXT)
	-rm $(LIBTARGET)

