LIBTARGET = ../libwxd.a

OBJECTS = \
	Accelerator.o  \
	ActivateEvent.o  \
	App.o  \
	ArtProvider.o  \
	Bitmap.o  \
	BitmapButton.o  \
	BoxSizer.o  \
	Brush.o  \
	Button.o  \
	CalendarCtrl.o  \
	Caret.o  \
	CheckBox.o  \
	ChildFocusEvent.o  \
	Choice.o  \
	ChoiceDialog.o  \
	ClientData.o  \
	Clipboard.o  \
	CloseEvent.o  \
	Colour.o  \
	ColourDialog.o  \
	ComboBox.o  \
	CommandEvent.o  \
	Config.o  \
	ContextMenuEvent.o  \
	Control.o  \
	Cursor.o  \
	DC.o  \
	DND.o  \
	DataFormat.o  \
	DataObject.o  \
	Defs.o  \
	Dialog.o  \
	DirDialog.o  \
	Display.o  \
	DisplayChangedEvent.o  \
	Document.o  \
	EraseEvent.o  \
	Event.o  \
	EvtHandler.o  \
	FileDialog.o  \
	FindReplaceDialog.o  \
	FlexGridSizer.o  \
	FocusEvent.o  \
	Font.o  \
	FontDialog.o  \
	FontMisc.o  \
	Frame.o  \
	GDIObject.o  \
	Gauge.o  \
	GdiCommon.o  \
	GridBagSizer.o  \
	GridSizer.o  \
	HelpEvent.o  \
	HTML.o  \
	HtmlHelpController.o  \
	HtmlListBox.o  \
	IControlWithItems.o  \
	Icon.o  \
	IconizeEvent.o  \
	IdleEvent.o  \
	Image.o  \
	ImageList.o  \
	ImageHandlers.o  \
	InitDialogEvent.o  \
	KeyEvent.o  \
	LayoutWin.o  \
	ListBox.o  \
	ListCtrl.o  \
	Listbook.o  \
	Locale.o  \
	Log.o  \
	MDI.o  \
	MaximizeEvent.o  \
	MemoryDC.o  \
	Menu.o  \
	MenuBar.o  \
	MenuItem.o  \
	MessageDialog.o  \
	MiniFrame.o  \
	MouseCaptureChangedEvent.o  \
	MouseEvent.o  \
	MoveEvent.o  \
	NavigationKeyEvent.o  \
	NcPaintEvent.o  \
	Notebook.o  \
	NotebookSizer.o  \
	PaintEvent.o  \
	Palette.o  \
	PaletteChangedEvent.o  \
	Panel.o  \
	Pen.o  \
	PrintData.o  \
	PrintDialog.o  \
	PrintPreview.o  \
	Printer.o  \
	ProgressDialog.o  \
	QueryNewPaletteEvent.o  \
	RadioBox.o  \
	RadioButton.o  \
	Region.o  \
	SashWindow.o  \
	ScrollBar.o  \
	ScrolledWindow.o  \
	SetCursorEvent.o  \
	ShowEvent.o  \
	SizeEvent.o  \
	Sizer.o  \
	SizerItem.o  \
	Slider.o  \
	SpinButton.o  \
	SpinCtrl.o  \
	SplashScreen.o  \
	SplitterWindow.o  \
	StaticBitmap.o  \
	StaticBox.o  \
	StaticBoxSizer.o  \
	StaticLine.o  \
	StaticText.o  \
	StatusBar.o  \
	StyledTextCtrl.o  \
	SysColourChangedEvent.o  \
	SystemSettings.o  \
	TabCtrl.o  \
	TextCtrl.o  \
	TextDialog.o  \
	TipDialog.o  \
	TipWindow.o  \
	ToggleButton.o  \
	ToolBar.o  \
	ToolTip.o  \
	TreeCtrl.o  \
	UpdateUIEvent.o  \
	Utils.o  \
	VLBox.o  \
	VScroll.o  \
	Validator.o  \
	VideoMode.o  \
	View.o  \
	Window.o  \
	WindowCreateEvent.o  \
	WindowDestroyEvent.o  \
	Wizard.o  \
	WizardPage.o  \
	WizardPageSimple.o  \
	wxDateTime.o  \
	wxObject.o  \
	wxString.o  \
	wxVersion.o  \
	Grid.o  \
	GridCtrl.o  \
	common.o  \
	ArrayInt.o  \
	ArrayString.o  \
	XmlResource.o  \
	NumberDialog.o \
	wx.o

#	DbGrid.o  \

all:  $(LIBTARGET)

DMD = dmd
DFLAGS = -O -I..

prefix=/usr/local
exec_prefix=$(prefix)
includedir=$(prefix)/include
libdir=$(exec_prefix)/lib

INSTALL = install
RANLIB = ranlib

install: $(LIBTARGET)
	$(INSTALL) -d $(DESTDIR)$(libdir)
	$(INSTALL) -p $(LIBTARGET) $(DESTDIR)$(libdir)
	$(INSTALL) -d $(DESTDIR)$(includedir)/d/wx
	$(INSTALL) -p *.d $(DESTDIR)$(libdir)/d/wx
	-$(RANLIB) $(DESTDIR)$(libdir)/`basename $(LIBTARGET)`

clean:
	-rm *.o
	-rm $(LIBTARGET)

$(LIBTARGET): $(OBJECTS)
	ar rcs $@ $(OBJECTS)


%.o:%.d
	$(DMD) -c $(DFLAGS) $<

