LIBTARGET=..\wxc.lib

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
	textctrl.obj \
	textdialog.obj \
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
	xmlresource.obj \
	numdialog.obj
	
#	notifyevent.obj
	

all:  $(LIBTARGET) 

include $(WXDIR)/build/msw/config.dmc
CXX = dmc

WX_RELEASE_NODOT = 26
OBJS = dmc_mswd$(CFG)
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)
SETUPHDIR = $(LIBDIRNAME)\mswd
CXXFLAGS = -g -o+none -D__WXMSW__ -D__WXDEBUG__ -I$(WXDIR)\include \
	-I$(SETUPHDIR) -w- -I. -WA -DNOPCH -Ar -Ae $(CPPFLAGS) \
	$(CXXFLAGS)

$(LIBTARGET) : $(OBJECTS)
	lib -p512 -c -n $@ $(OBJECTS)


.cpp.obj:
	$(CXX) -mn -c $(CXXFLAGS) $< -o$@

clean:
	-del *.obj
	-del $(LIBTARGET)
	-del $(TARGET)

