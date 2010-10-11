LIBTARGET = ..\wxc.lib

MAKESTUB=..\config.mak
BUD_LIBS=..\wx\libs.d

OBJECTS = \
	accel.obj \
	activateevent.obj \
	app.obj \
	artprovider.obj \
	bitmap.obj \
	bitmapbutton.obj \
	boxsizer.obj \
	brush.obj \
	button.obj \
	calendarctrl.obj \
	caret.obj \
	checkbox.obj \
	childfocusevent.obj \
	choice.obj \
	choicedialog.obj \
	clientdata.obj \
	clipboard.obj \
	closeevent.obj \
	colour.obj \
	colourdialog.obj \
	combobox.obj \
	commandevent.obj \
	config.obj \
	contextmenuevent.obj \
	control.obj \
	cursor.obj \
	dataformat.obj \
	dataobject.obj \
	dc.obj \
	dialog.obj \
	dirdialog.obj \
	display.obj \
	displaychangedevent.obj \
	dnd.obj \
	docmanager.obj \
	doctemplate.obj \
	document.obj \
	eraseevent.obj \
	event.obj \
	evthandler.obj \
	filedialog.obj \
	findreplacedialog.obj \
	flexgridsizer.obj \
	focusevent.obj \
	font.obj \
	fontdialog.obj \
	fontmisc.obj \
	frame.obj \
	gauge.obj \
	gdicmn.obj \
	gdiobject.obj \
	glcanvas.obj \
	global.obj \
	grid.obj \
	gridbagsizer.obj \
	gridctrl.obj \
	gridsizer.obj \
	helpevent.obj \
	html.obj \
	htmlhelpctrl.obj \
	htmllbox.obj \
	icon.obj \
	iconizeevent.obj \
	idleevent.obj \
	image.obj \
	imagelist.obj \
	imghandler.obj \
	initdialogevent.obj \
	keyevent.obj \
	laywin.obj \
	listbook.obj \
	listbox.obj \
	listctrl.obj \
	locale.obj \
	log.obj \
	maximizeevent.obj \
	mdi.obj \
	memorydc.obj \
	menu.obj \
	menubar.obj \
	menuitem.obj \
	messagedialog.obj \
	miniframe.obj \
	mousecapturechangedevent.obj \
	mouseevent.obj \
	moveevent.obj \
	navigationkeyevent.obj \
	ncpaintevent.obj \
	notebook.obj \
	notebooksizer.obj \
	notifyevent.obj \
	object.obj \
	paintevent.obj \
	palette.obj \
	palettechangedevent.obj \
	panel.obj \
	pen.obj \
	printdata.obj \
	printdialog.obj \
	printer.obj \
	printpreview.obj \
	progdlg.obj \
	querynewpaletteevent.obj \
	radiobox.obj \
	radiobutton.obj \
	region.obj \
	sashwindow.obj \
	scrollbar.obj \
	scrolledwindow.obj \
	setcursorevent.obj \
	showevent.obj \
	sizeevent.obj \
	sizer.obj \
	sizeritem.obj \
	slider.obj \
	sound.obj \
	spinbutton.obj \
	spinctrl.obj \
	splashscreen.obj \
	splitterwindow.obj \
	staticbitmap.obj \
	staticbox.obj \
	staticboxsizer.obj \
	staticline.obj \
	statictext.obj \
	statusbar.obj \
	styledtextctrl.obj \
	syscolourchangedevent.obj \
	systemsettings.obj \
	tabctrl.obj \
	taskbaricon.obj \
	textctrl.obj \
	textdialog.obj \
	thread.obj \
	timer.obj \
	tipdialog.obj \
	tipwindow.obj \
	togglebutton.obj \
	toolbar.obj \
	tooltip.obj \
	treectrl.obj \
	updateuievent.obj \
	validator.obj \
	view.obj \
	vlbox.obj \
	vscroll.obj \
	window.obj \
	windowcreateevent.obj \
	windowdestroyevent.obj \
	wizard.obj \
	wxdatetime.obj \
	wxstring.obj \
	wxversion.obj \
	wxplatform.obj \
	xmlresource.obj \
	numdialog.obj \
	manager.obj \
	wxaui.obj
	

all:  $(MAKESTUB) $(LIBTARGET)
build:  $(BUD_LIBS)
helpers: wx-libraries.exe wx-platform.exe wx-encoding.exe wx-release.exe

# hardcoded: DEBUG
DEBUG_FLAG = -D__WXDEBUG__
WXDEBUGFLAG = d

# hardcoded: ANSI
UNICODE_FLAG =
WXUNICODEFLAG =

include $(WXDIR)/build/msw/config.dmc
CXX = dmc

COMPILER = DMD

WX_CONFIG = wx-config.exe

OBJS = dmc_msw$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(CFG)
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)
SETUPHDIR = $(LIBDIRNAME)\msw$(WXUNICODEFLAG)$(WXDEBUGFLAG)
CXXFLAGS = -g -o+none -D__$(PLATFORM)__ $(DEBUG_FLAG) $(UNICODE_FLAG) -I$(WXDIR)\include \
	-I$(SETUPHDIR) -w- -I. -WA -DNOPCH -HP90 -Ar -Ae $(CPPFLAGS) \
	$(CXXFLAGS)

$(LIBTARGET) : $(OBJECTS)
	lib -p512 -c -n $@ $(OBJECTS)

# If wx-config.exe refuses to build, you can download a binary:
# http://wx-config-win.googlecode.com/svn/binary/wx-config.exe

wx-config.exe: wx-config-win.obj
	$(CXX) $(LDFLAGS) wx-config-win.obj $@

wx-libs.mak: wx-config.exe
	+$(WX_CONFIG) --libs base >$@

wx-libs.exe: wx-libs.mak wx-libs.obj 
	$(CXX) $(LDFLAGS) wx-libs.obj @wx-libs.mak $@

wx-libraries.exe: wx-libs.mak wx-libs.obj 
	$(CXX) $(LDFLAGS) wx-libs.obj @wx-libs.mak $@

wx-release.exe: wx-release.obj
	$(CXX) $(LDFLAGS) wx-release.obj $@

wx-version.exe: wx-version.obj
	$(CXX) $(LDFLAGS) wx-version.obj $@

wx-platform.exe: wx-platform.obj
	$(CXX) $(LDFLAGS) wx-platform.obj $@

wx-encoding.exe: wx-encoding.obj
	$(CXX) $(LDFLAGS) wx-encoding.obj $@
	

$(BUD_LIBS): wx-config.exe wx-libs.exe wx-platform.exe wx-encoding.exe
	+wx-libs.exe > $@

$(MAKESTUB): wx-release.exe wx-version.exe wx-platform.exe wx-encoding.exe
	+wx-release.exe -v >$@
	+wx-version.exe -v >>$@
	+wx-platform.exe -v >>$@
	+wx-encoding.exe -v >>$@

WX_RELEASE: wx-release.exe
	wx-release.exe >$@

WX_VERSION: wx-version.exe
	wx-version.exe >$@

PLATFORM: wx-platform.exe
	wx-platform.exe >$@

ENCODING: wx-encoding.exe
	wx-encoding.exe >$@

.cpp.obj:
	$(CXX) -D__$(COMPILER)__ -mn $(CXXFLAGS) -c -o$@ $<

clean:
	-del *.obj
	-del *.exe
	-del $(MAKESTUB)
	-del $(LIBTARGET)
	-del $(TARGET)

