//-----------------------------------------------------------------------------
// D/Samples - Controls.d
//
// A D version of the wxWidgets "controls" sample.
//
// TODO: update to use sizers more (this is a straight port of the wxWidgets
// original, which also used absolute positioning in many places for unknown
// reasons). [t9mike]
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.string;
private import std.stdio;

    //-------------------------------------------------------------------------
    // Application entry class

    public class Controls : App
    {
        public override bool OnInit()
        {
            // TODO: Add command line processing for window position

            MyFrame frame = new MyFrame("Controls wxWidgets App",
                                        Point(50,50), Size(500,430));
            frame.Show(true);
            return true;
        }

        //---------------------------------------------------------------------

        
        static void Main()
        {
            Controls app = new Controls();
            app.Run();
        }
    }

    //-------------------------------------------------------------------------
    // Main application frame

    public class MyFrame : Frame
    {
        public const int ID_ABOUT       = 100;
        public const int ID_EXIT        = 101;
        public const int ID_CLEAR_LOG   = 102;
        public const int ID_SET_DELAY   = 103;
        public const int ID_TOGGLE_TIPS = 104;
        public const int ID_DISABLE_ALL = 105;

        //---------------------------------------------------------------------

        private MyPanel panel;
        private static bool tipsEnabled = true;
        private static int tipDelay = 5000;
                private static bool panelEnabled = true;

        //---------------------------------------------------------------------

        public this(string title, Point pos, Size size)
        {
            super(title, pos, size);
            // Set the window icon
            icon = new Icon("../Samples/Controls/mondrian.png");

            // Create the main panel
            panel = new MyPanel(this, 10, 10, 300, 100);

            // Set up a menu
            Menu fileMenu = new Menu();
            fileMenu.Append(ID_CLEAR_LOG, "&Clear Log\tCtrl+L",
                            "Clear the log window");
            fileMenu.AppendSeparator();
            fileMenu.Append(ID_ABOUT, "&About\tF1", "About this application");
            fileMenu.AppendSeparator();
            fileMenu.Append(ID_EXIT, "E&xit\tAlt+X", "Exit this program");

            Menu tooltipMenu = new Menu();
            tooltipMenu.Append(ID_SET_DELAY, "&Set Delay..\tCtrl+D",
                               "Set tooltip delay");
            tooltipMenu.AppendSeparator();
            tooltipMenu.Append(ID_TOGGLE_TIPS, "&Toggle Tooltips\tCtrl+T",
                               "Enable/Disable tooltips",
                               ItemKind.wxITEM_CHECK);
            tooltipMenu.Check(ID_TOGGLE_TIPS, tipsEnabled);

            Menu panelMenu = new Menu();
            panelMenu.Append(ID_DISABLE_ALL,
                             "&Disable All\tCtrl+E",
                             "Enable/Disable all panel controls",
                             ItemKind.wxITEM_CHECK);

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
            menuBar.Append(tooltipMenu, "&Tooltips");
            menuBar.Append(panelMenu, "&Panel");

            this.menuBar = menuBar;

            // Set up the event table for the menu
            EVT_MENU(ID_CLEAR_LOG,      &OnClearLog);
            EVT_MENU(ID_ABOUT,          &OnAbout);
            EVT_MENU(ID_EXIT,           &OnQuit);
            EVT_MENU(ID_SET_DELAY,      &OnSetTooltipDelay);
            EVT_MENU(ID_TOGGLE_TIPS,    &OnToggleTooltips);
            EVT_MENU(ID_DISABLE_ALL,    &OnDisableAll);

            // Set up a status bar
            CreateStatusBar(2);
            StatusText = "";
        }

        //---------------------------------------------------------------------

        public void OnClearLog(Object sender, Event e)
        {
            panel.text.Clear();
        }

        //---------------------------------------------------------------------

        public void OnAbout(Object sender, Event e)
        {
            string msg = "This is the wxWidgets controls sample written " ~
                         "in C#.";
            MessageBox(this, msg, "About Controls",
                                       Dialog.wxOK);
        }

        //---------------------------------------------------------------------

        public void OnQuit(Object sender, Event e)
        {
            Close(true);
        }

        //---------------------------------------------------------------------

        public void OnSetTooltipDelay(Object sender, Event e)
        {
            int input;
            input = GetNumberFromUser("Enter delay (in milliseconds)",
                                      "Set tooltip delay", "ToolTip Delay",
                                      tipDelay, 0, 10000, this);

            if (input != -1) {
                tipDelay = input;
                ToolTip.Delay = tipDelay;
            }

            Log.LogStatus("Tooltip delay set to %d milliseconds", input);
        }

        //---------------------------------------------------------------------

        public void OnToggleTooltips(Object sender, Event e)
        {
            tipsEnabled = !tipsEnabled;
            ToolTip.Enabled = tipsEnabled;

            Log.LogStatus("Tooltips {0}abled", tipsEnabled ? "en" : "dis" );
        }

        //---------------------------------------------------------------------

        public void OnDisableAll(Object sender, Event e)
        {
            panelEnabled = !panelEnabled;
            panel.Enabled = panelEnabled;
        }
    }

    //-------------------------------------------------------------------------
    // Main content panel

    public class MyPanel : Panel
    {
        private const int ID_NOTEBOOK         = 1;

        private const int ID_LISTBOX          = 2;
        private const int ID_LISTBOX_SORTED   = 3;
        private const int ID_LISTBOX_SEL_NUM  = 4;
        private const int ID_LISTBOX_SEL_STR  = 5;
        private const int ID_LISTBOX_APPEND   = 6;
        private const int ID_LISTBOX_DELETE   = 7;
        private const int ID_LISTBOX_FONT     = 8;
        private const int ID_LISTBOX_ENABLE   = 9;
        private const int ID_LISTBOX_CLEAR    = 10;
        private const int ID_LISTBOX_COLOUR   = 11;

        private const int ID_CHOICE           = 20;
        private const int ID_CHOICE_SORTED    = 21;
        private const int ID_CHOICE_SEL_NUM   = 22;
        private const int ID_CHOICE_SEL_STR   = 23;
        private const int ID_CHOICE_APPEND    = 24;
        private const int ID_CHOICE_DELETE    = 25;
        private const int ID_CHOICE_FONT      = 26;
        private const int ID_CHOICE_ENABLE    = 27;
        private const int ID_CHOICE_CLEAR     = 28;

        private const int ID_COMBO            = 40;
        private const int ID_COMBO_SEL_NUM    = 41;
        private const int ID_COMBO_SEL_STR    = 42;
        private const int ID_COMBO_APPEND     = 43;
        private const int ID_COMBO_DELETE     = 44;
        private const int ID_COMBO_FONT       = 45;
        private const int ID_COMBO_ENABLE     = 46;
        private const int ID_COMBO_CLEAR      = 47;

        private const int ID_RADIO            = 60;
        private const int ID_RADIO_SEL_NUM    = 61;
        private const int ID_RADIO_SEL_STR    = 62;
        private const int ID_RADIO_FONT       = 63;
        private const int ID_RADIO_ENABLE     = 64;
        private const int ID_RADIO_BUTTON1    = 65;
        private const int ID_RADIO_BUTTON2    = 66;

        private const int ID_SLIDER           = 80;
        private const int ID_SPINCTRL         = 81;
        private const int ID_SPIN             = 82;
        private const int ID_BTNPROGRESS      = 83;
		
		private const int ID_BITMAP_BTN = 84;
		private const int ID_BUTTON_LABEL = 85;
		
		private const int ID_SIZER_CHECK1 = 90;
		private const int ID_SIZER_CHECK2 = 91;
		private const int ID_SIZER_CHECK3 = 92;
		private const int ID_SIZER_CHECK4 = 93;
		private const int ID_SIZER_CHECK14 = 94;
		private const int ID_SIZER_CHECKBIG = 95;

        private const int ID_SETFONT          = 100;

        enum Images { List = 0, Choice, Combo, Text, Radio, Gauge, Max }

        //---------------------------------------------------------------------

        private Notebook notebook;
        public  TextCtrl text;

        // ListBox sample members
        private ListBox     listbox, listboxSorted;
        private Button      selectNum, selectStr;
        private CheckBox    checkbox;
        private bool        oldColour;
        private RadioBox    radiobox;

        // Choice sample members
        private Choice choice, choiceSorted;

        // Combo sample members
        private ComboBox combo;

        // Gauge/Slider sample members
        private Gauge gauge, gaugeVert;
        private Slider slider;
        private SpinCtrl spinctrl;
        private SpinButton spinbutton;
        private TextCtrl spintext;
        private int initialSpinValue;
        private Button btnProgress;
		
		private Button fontButton;
		
		private StaticText m_label;
		
		private BoxSizer m_buttonSizer;
		private Button m_sizerBtn1;
		private Button m_sizerBtn2;
		private Button m_sizerBtn3;
		private Button m_sizerBtn4;
		private BoxSizer m_hsizer;
		private Button m_bigBtn;

        //---------------------------------------------------------------------

        public this(Frame frame, int x, int y, int w, int h)
        {
            super(frame, -1, Point(x, y), Size(w, h));
            const string[] choices = [
                "This", "is", "one of my", "wonderful", "examples"
            ];

            const string[] choices2 = [
                    "First", "Second"
            ];

            oldColour = false;

            // Create the log text view
            text = new TextCtrl(this, -1, "This is the log window.\n",
                                Point(0, 250), Size(100, 50),
                                TextCtrl.wxTE_MULTILINE);
            text.BackgroundColour = new Colour("wheat");

            Log.AddTraceMask("focus");
            Log.SetActiveTarget( text ); 

            // Create the notebook
            notebook = new Notebook(this, ID_NOTEBOOK);

            // Create the image list for the notebook
            string imgPath = "../Samples/Controls/Icons/";
            ImageList imagelist = new ImageList(16, 16, false,
                                                Images.Max);

            imagelist.Add(new Bitmap(imgPath ~ "list.xpm"));
            imagelist.Add(new Bitmap(imgPath ~ "choice.xpm"));
            imagelist.Add(new Bitmap(imgPath ~ "combo.xpm"));
            imagelist.Add(new Bitmap(imgPath ~ "text.xpm"));
            imagelist.Add(new Bitmap(imgPath ~ "radio.xpm"));
            imagelist.Add(new Bitmap(imgPath ~ "gauge.xpm"));

            notebook.Images = imagelist;

            // Add some panels

            // wxListBox sample panel
            Panel panel = new Panel(notebook);
            notebook.AddPage(panel, "wxListBox", true, Images.List);

            listbox = new ListBox(panel, ID_LISTBOX,
                                  Point(10, 10), Size(120, 70),
                                  choices, ListBox.wxLB_ALWAYS_SB);
            listboxSorted = new ListBox(panel, ID_LISTBOX_SORTED,
                                        Point(10, 90), Size(120, 70),
                                        choices, ListBox.wxLB_SORT);

            // TODO: Add in ClientData

            listbox.toolTip = "This is a List Box.";
            listboxSorted.toolTip = "This is a sorted List Box.";

            selectNum = new Button(panel, -1,
                                   "Select #&2", Point(180, 30),
                                   Size(150, -1));
            selectStr = new Button(panel, ID_LISTBOX_SEL_STR,
                                   "&Select 'This'", Point(340, 30),
                                   Size(150, -1));

            new Button(panel, ID_LISTBOX_CLEAR, "&Clear",
                       Point(180, 80), Size(150, -1));
            new Button(panel, ID_LISTBOX_APPEND, "&Append 'Hi!'",
                       Point(340, 80), Size(150, -1));
            new Button(panel, ID_LISTBOX_DELETE,
                       "Delete selected item",
                       Point(180, 130), Size(150, -1));

            Button button = new Button(panel, ID_LISTBOX_FONT,
                                       "Set &Italic font",
                                       Point(340, 130),
                                       Size(150, -1));
            button.SetDefault();
            button.ForegroundColour = new Colour("blue");
            button.toolTip = "Click here to set Italic font";

            checkbox = new CheckBox(panel, ID_LISTBOX_ENABLE,
                                    "&Disable", Point(20, 170));
            checkbox.Value = false;
            checkbox.toolTip = "Click to disable listbox";

            new CheckBox(panel, ID_LISTBOX_COLOUR,
                         "&Toggle colour", Point(110, 170));

            panel.cursor = new Cursor(StockCursor.wxCURSOR_HAND);

            // wxChoice sample panel
            panel = new Panel(notebook);
            notebook.AddPage(panel, "wxChoice", false, Images.Choice);

            choice = new Choice(panel, ID_CHOICE, Point(10, 10),
                                Size(120, -1), choices);
            choiceSorted = new Choice(panel, ID_CHOICE_SORTED,
                                      Point(10, 70), Size(120, -1),
                                      choices, ComboBox.wxCB_SORT);

            // TODO: Add in client data

            choice.Selection = 2;
            choice.BackgroundColour = new Colour("red");

            new Button(panel, ID_CHOICE_SEL_NUM, "Select #&2",
                       Point(180, 30), Size(150, -1));
            new Button(panel, ID_CHOICE_SEL_STR, "&Select 'This'",
                       Point(340, 30), Size(150, -1));
            new Button(panel, ID_CHOICE_CLEAR, "&Clear",
                       Point(180, 80), Size(150, -1));
            new Button(panel, ID_CHOICE_APPEND, "&Append 'Hi!'",
                       Point(340, 80), Size(150, -1));
            new Button(panel, ID_CHOICE_DELETE, "D&elete selected item",
                       Point(180, 130), Size(150, -1));
            new Button(panel, ID_CHOICE_FONT, "Set &Italic font",
                       Point(340, 130), Size(150, -1));
            new CheckBox(panel, ID_CHOICE_ENABLE, "&Disable",
                         Point(20, 130));

            // wxComboBox sample panel
            panel = new Panel(notebook);
            notebook.AddPage(panel, "wxComboBox", false, Images.Combo);

            new StaticBox(panel, -1, "&Box around combobox",
                          Point(5, 5), Size(150, 100));
            combo = new ComboBox(panel, ID_COMBO, "This",
                                 Point(20, 25), Size(120, -1),
                                 choices);
            combo.toolTip = "This is a natural\ncombobox - unbelievable";

            new Button(panel, ID_COMBO_SEL_NUM, "Select #&2",
                       Point(180, 30), Size(150, -1));
            new Button(panel, ID_COMBO_SEL_STR, "&Select 'This'",
                       Point(340, 30), Size(150, -1));
            new Button(panel, ID_COMBO_CLEAR, "&Clear",
                       Point(180, 80), Size(150, -1));
            new Button(panel, ID_COMBO_APPEND, "&Append 'Hi!'",
                       Point(340, 80), Size(150, -1));
            new Button(panel, ID_COMBO_DELETE, "D&elete selected item",
                       Point(180, 130), Size(150, -1));
            new Button(panel, ID_COMBO_FONT, "Set &Italic font",
                       Point(340, 130), Size(150, -1));
            new CheckBox(panel, ID_COMBO_ENABLE, "&Disable",
                         Point(20, 130));

            // wxRadioBox sample panel
            panel = new Panel(notebook);
            notebook.AddPage(panel, "wxRadioBox", false, Images.Radio);

                        new RadioBox(panel, ID_RADIO, "&That",
                         Point(10, 160), wxDefaultSize, choices2, 1,
                         RadioBox.wxRA_SPECIFY_ROWS);
            radiobox = new RadioBox(panel, ID_RADIO,
                                    "T&his", Point(10, 10),
                                    wxDefaultSize, choices, 1,
                                    RadioBox.wxRA_SPECIFY_COLS);
            radiobox.toolTip = "Ever seen a radiobox?";
            radiobox.ForegroundColour = new Colour("Red");

            new Button(panel, ID_RADIO_SEL_NUM, "Select #&2",
                       Point(180, 30), Size(150, -1));
            fontButton = new Button(panel, ID_SETFONT, "Set &more Italic font",
                       Point(340, 30), Size(150, -1));
            new Button(panel, ID_RADIO_SEL_STR, "&Select 'This'",
                       Point(180, 80), Size(150, -1));
            new Button(panel, ID_RADIO_FONT, "Set &Italic Font",
                       Point(340, 80), Size(150, -1));
            new CheckBox(panel, ID_RADIO_ENABLE, "&Disable",
                         Point(340, 130));

                        (new RadioButton(panel, ID_RADIO_BUTTON1, "Radiobutton1",
                                                        Point(210, 170), wxDefaultSize,
                                                        RadioButton.wxRB_GROUP)).Value = false;
                        new RadioButton(panel, ID_RADIO_BUTTON2, "Radiobutton2",
                                                        Point(340, 170));

            // wxGauge sample panel
            panel = new Panel(notebook);
            notebook.AddPage(panel, "wxGauge", false, Images.Gauge);

            new StaticBox(panel, -1, "&wxGauge and wxSlider", 
                          Point(10, 10), Size(222, 130));
            gauge = new Gauge(panel, -1, 200, 
                              Point(18, 50), Size(155, 30), 
                              Gauge.wxGA_HORIZONTAL | /*Border.*/wxNO_BORDER);
            gauge.BackgroundColour = new Colour("Green");
            gauge.ForegroundColour = new Colour("Red");

            gaugeVert = new Gauge(panel, -1, 200, 
                                  Point(195, 35), Size(30, 90),
                                  Gauge.wxGA_VERTICAL | Gauge.wxGA_SMOOTH |
                                  /*Border.*/wxNO_BORDER);

            slider = new Slider(panel, ID_SLIDER, 0, 0, 200, 
                                Point(18, 90), Size(155, -1),
                                Slider.wxSL_AUTOTICKS | Slider.wxSL_LABELS);
            slider.SetTickFreq(40, 0);
            slider.toolTip = "This is a sliding slider!";

            new StaticBox(panel, -1, "&Explanation", Point(230, 10),
                          Size(270, 130), Alignment.wxALIGN_CENTER);
            new StaticText(panel, -1, 
                           "In order to see the gauge (aka progress \n" ~
                           "bar) control do something, drag the \n" ~
                           "handle of the slider to the right\n" ~
                           "\n" ~
                           "This is also supposed to demonstrate\n" ~
                           "how to use static controls.",
                           Point(250, 25), Size(240, 110));

            spinctrl = new SpinCtrl(panel, ID_SPINCTRL, "",
                                    Point(200, 160), Size(80, -1));
            spinctrl.SetRange(10, 30);
            spinctrl.Value = 15;

            initialSpinValue = -5;
            spintext = new TextCtrl(panel, -1, "" ~ .toString(initialSpinValue),
                                    Point(20, 160), Size(80, -1));
            spinbutton = new SpinButton(panel, ID_SPIN, 
                                        Point(103, 160), Size(80, -1));
            spinbutton.SetRange(-40, 30);
            spinbutton.Value = initialSpinValue;

            btnProgress = new Button(panel, ID_BTNPROGRESS, 
                                     "&Show progress dialog",
                                     Point(300, 160)); 
									 
			// wxBitmapXXX sampel panel
			panel = new Panel(notebook);
			notebook.AddPage(panel, "wxBitmapXXX", false );
			
			Icon icon = ArtProvider.GetIcon( ArtID.wxART_INFORMATION );
			new StaticBitmap( panel, -1, icon, Point(10, 10) );
			
			Bitmap bitmap = new Bitmap( 100, 100 );
			MemoryDC dc = new MemoryDC();
			dc.SelectObject( bitmap );
			dc.pen = Pen.wxGREEN_PEN;
			dc.Clear();
			dc.DrawEllipse( 5, 5, 90, 90 );
			dc.DrawText( "Bitmap", 30, 40 );
			dc.SelectObject( Bitmap.wxNullBitmap );
			
			new BitmapButton( panel, ID_BITMAP_BTN, bitmap, Point( 100, 20 ) );
			
			Bitmap bmp1 = ArtProvider.GetBitmap( ArtID.wxART_INFORMATION );
			Bitmap bmp2 = ArtProvider.GetBitmap( ArtID.wxART_WARNING );
			Bitmap bmp3 = ArtProvider.GetBitmap( ArtID.wxART_QUESTION );
			
//			BitmapButton bmpBtn = new BitmapButton( panel, -1, bmp1, Point( 30, 70 ) );
			
//			bmpBtn.BitmapSelected = bmp2;
//			bmpBtn.BitmapFocus = bmp3;
			
			new ToggleButton( panel, ID_BUTTON_LABEL, "&Toggle label", Point( 250, 20 ) );
			
			m_label = new StaticText( panel, -1, "Label with some long text", 
									Point ( 250, 60 ), wxDefaultSize, Alignment.wxALIGN_RIGHT );
			m_label.ForegroundColour = Colour.wxBLUE;
			
			// wxSizer sampel panel
            panel = new Panel(notebook);
            notebook.AddPage(panel, "wxSizer", false );
			panel.AutoLayout = true;	

			BoxSizer sizer = new BoxSizer( Orientation.wxVERTICAL );
			StaticBoxSizer csizer = new StaticBoxSizer( new StaticBox( panel, -1, "Show Buttons" ), 
															Orientation.wxHORIZONTAL );
														
			CheckBox check1 = new CheckBox( panel, ID_SIZER_CHECK1, "1" );
			check1.Value = true;
			csizer.Add( check1 );
			
			CheckBox check2 = new CheckBox( panel, ID_SIZER_CHECK2, "2" );
			check2.Value = true;
			csizer.Add( check2 );
			
			CheckBox check3 = new CheckBox( panel, ID_SIZER_CHECK3, "3" );
			check3.Value = true;
			csizer.Add( check3 );
			
			CheckBox check4 = new CheckBox( panel, ID_SIZER_CHECK4, "4" );
			check4.Value = true;
			csizer.Add( check4 );
			
			CheckBox check14 = new CheckBox( panel, ID_SIZER_CHECK14, "14" );
			check14.Value = true;
			csizer.Add( check14 );
			
			CheckBox checkBig = new CheckBox( panel, ID_SIZER_CHECKBIG, "Big" );
			checkBig.Value = true;
			csizer.Add( checkBig );
			
			sizer.Add( csizer );
			
			m_hsizer = new BoxSizer( Orientation.wxHORIZONTAL );
			
			m_buttonSizer = new BoxSizer( Orientation.wxVERTICAL );
			
			m_sizerBtn1 = new Button( panel, -1, "Test Button &1" );
			m_buttonSizer.Add( m_sizerBtn1, 0, Direction.wxALL, 10 );
			m_sizerBtn2 = new Button( panel, -1, "Test Button &2" );
			m_buttonSizer.Add( m_sizerBtn2, 0, Direction.wxALL, 10 );
			m_sizerBtn3 = new Button( panel, -1, "Test Button &3" );
			m_buttonSizer.Add( m_sizerBtn3, 0, Direction.wxALL, 10 );			
			m_sizerBtn4 = new Button( panel, -1, "Test Button &4" );
			m_buttonSizer.Add( m_sizerBtn4, 0, Direction.wxALL, 10 );	

			m_hsizer.Add( m_buttonSizer );
			m_hsizer.Add( new BoxSizer( Orientation.wxHORIZONTAL ), 1, Stretch.wxEXPAND, 0 );
			
			m_bigBtn = new Button( panel, -1, "Multiline\nbutton" );
			m_hsizer.Add( m_bigBtn, 3, Stretch.wxEXPAND | Direction.wxALL, 10 );
			
			sizer.Add( m_hsizer, 1, Stretch.wxEXPAND );
			
			panel.sizer = sizer;

            // Set event listeners

            EVT_SIZE(&OnSize);

            EVT_LISTBOX     (ID_LISTBOX,            &OnListBox);
            EVT_LISTBOX     (ID_LISTBOX_SORTED,     &OnListBox);
            EVT_LISTBOX_DCLICK(-1,                  &OnListBoxDoubleClick);
	    selectNum.Click_Add(& OnListBoxButtons );
	    selectNum.Click_Add(& OnClicked2 );
	    EVT_BUTTON      (-1,/*ID_LISTBOX_SEL_NUM,*/    &OnListBoxButtons);
            //EVT_BUTTON      (ID_LISTBOX_SEL_STR,    &OnListBoxButtons);
	    selectStr.Click_Add(& OnListBoxButtons );
            EVT_BUTTON      (ID_LISTBOX_CLEAR,      &OnListBoxButtons);
            EVT_BUTTON      (ID_LISTBOX_APPEND,     &OnListBoxButtons);
            EVT_BUTTON      (ID_LISTBOX_DELETE,     &OnListBoxButtons);
            //EVT_BUTTON      (ID_LISTBOX_FONT,       &OnListBoxButtons);
	    button.Click_Add(& OnListBoxButtons );
            EVT_CHECKBOX    (ID_LISTBOX_ENABLE,     &OnListBoxButtons);
            EVT_CHECKBOX    (ID_LISTBOX_COLOUR,     &OnChangeColour);

            EVT_CHOICE      (ID_CHOICE,             &OnChoice);
            EVT_CHOICE      (ID_CHOICE_SORTED,      &OnChoice);
            EVT_BUTTON      (ID_CHOICE_SEL_NUM,     &OnChoiceButtons);
            EVT_BUTTON      (ID_CHOICE_SEL_STR,     &OnChoiceButtons);
            EVT_BUTTON      (ID_CHOICE_FONT,        &OnChoiceButtons);
            EVT_BUTTON      (ID_CHOICE_DELETE,      &OnChoiceButtons);
            EVT_BUTTON      (ID_CHOICE_APPEND,      &OnChoiceButtons);
            EVT_BUTTON      (ID_CHOICE_CLEAR,       &OnChoiceButtons);
            EVT_CHECKBOX    (ID_CHOICE_ENABLE,      &OnChoiceButtons);

            EVT_COMBOBOX    (ID_COMBO,              &OnCombo);
            EVT_TEXT        (ID_COMBO,              &OnComboTextChanged);
            EVT_TEXT_ENTER  (ID_COMBO,              &OnComboTextEnter);
            EVT_BUTTON      (ID_COMBO_SEL_NUM,      &OnComboButtons);
            EVT_BUTTON      (ID_COMBO_SEL_STR,      &OnComboButtons);
            EVT_BUTTON      (ID_COMBO_FONT,         &OnComboButtons);
            EVT_BUTTON      (ID_COMBO_DELETE,       &OnComboButtons);
            EVT_BUTTON      (ID_COMBO_APPEND,       &OnComboButtons);
            EVT_BUTTON      (ID_COMBO_CLEAR,        &OnComboButtons);
            EVT_CHECKBOX    (ID_COMBO_ENABLE,       &OnComboButtons);

            EVT_RADIOBOX    (ID_RADIO,              &OnRadio);
            EVT_BUTTON      (ID_RADIO_SEL_NUM,      &OnRadioButtons);
            EVT_BUTTON      (ID_RADIO_SEL_STR,      &OnRadioButtons);
            EVT_BUTTON      (ID_RADIO_FONT,         &OnRadioButtons);
            EVT_CHECKBOX    (ID_RADIO_ENABLE,       &OnRadioButtons);
            EVT_BUTTON      (ID_SETFONT,            &OnSetFont);

            EVT_SLIDER      (ID_SLIDER,             &OnSliderUpdate);
            EVT_SPINCTRL    (ID_SPINCTRL,           &OnSpinCtrl);
            EVT_SPIN_UP     (ID_SPINCTRL,           &OnSpinCtrlUp);
            EVT_SPIN_DOWN   (ID_SPINCTRL,           &OnSpinCtrlDown);
            EVT_TEXT        (ID_SPINCTRL,           &OnSpinCtrlText);
            EVT_SPIN        (ID_SPIN,               &OnSpinUpdate);
            EVT_SPIN_UP     (ID_SPIN,               &OnSpinUp);
            EVT_SPIN_DOWN   (ID_SPIN,               &OnSpinDown);
            EVT_UPDATE_UI   (ID_BTNPROGRESS,        &OnUpdateShowProgress);
            EVT_BUTTON      (ID_BTNPROGRESS,        &OnShowProgress);
			
			EVT_TOGGLEBUTTON(ID_BUTTON_LABEL,       &OnUpdateLabel);
			EVT_BUTTON(ID_BITMAP_BTN,               &OnBmpButton);
			
			EVT_CHECKBOX(ID_SIZER_CHECK1,           &OnSizerCheck);
			EVT_CHECKBOX(ID_SIZER_CHECK2,           &OnSizerCheck);
			EVT_CHECKBOX(ID_SIZER_CHECK3,           &OnSizerCheck);
			EVT_CHECKBOX(ID_SIZER_CHECK4,           &OnSizerCheck);
			EVT_CHECKBOX(ID_SIZER_CHECK14,          &OnSizerCheck);
			EVT_CHECKBOX(ID_SIZER_CHECKBIG,         &OnSizerCheck);
			
			EVT_NOTEBOOK_PAGE_CHANGING(ID_NOTEBOOK, &OnPageChanging);
			EVT_NOTEBOOK_PAGE_CHANGED(ID_NOTEBOOK,  &OnPageChanged);
        }
	
	public void OnClicked2( Object sender, Event e )
	{
		writefln( "OnClicked2");
	}

        //---------------------------------------------------------------------

        public void OnSize(Object sender, Event e)
        {
            notebook.SetSize(2, 2, ClientSize.Width - 4,
                             ClientSize.Height * 2 / 3 - 4);
            text.SetSize(2, ClientSize.Height * 2 / 3 + 2,
                         ClientSize.Width - 4, ClientSize.Height / 3 - 4);
        }

        //---------------------------------------------------------------------

        public void OnListBox(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

            if (ce.ID == -1)
            {
                text.AppendText("ListBox has no selections anymore.\n");
                return;
            }

            ListBox lb =
                ce.ID == ID_LISTBOX ? listbox : listboxSorted;
            text.AppendText("ListBox event selection string is: '" ~
                            ce.String ~ "'\n" ~
                            "ListBox control selection string is: '" ~
                            lb.StringSelection ~ "'\n");
        }

        public void OnListBoxDoubleClick(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("ListBox event selection string is: '" ~
                            ce.String ~ "'\n");
        }

        public void OnListBoxButtons(Object sender, Event e)
        {
            switch(e.ID)
            {
            case ID_LISTBOX_SEL_NUM:
	    	writefln( "OnListBoxButtons");
                listbox.Selection = 2;
                listboxSorted.Selection = 2;
                break;

            case ID_LISTBOX_SEL_STR:
		if ( listbox.Count > 0 )
		{
			for ( int i = 0; i < listbox.Count; i++ )
			{
				if ( listbox.GetString( i ) == "This" )
				{
					listbox.StringSelection = "This";
					listboxSorted.StringSelection = "This";
				}
			}
		}
                break;

            case ID_LISTBOX_DELETE:
                if (listbox.Selection != -1)
                    listbox.Delete(listbox.Selection);
                if (listboxSorted.Selection != -1)
                    listboxSorted.Delete(listboxSorted.Selection);
                break;

            case ID_LISTBOX_ENABLE:
                text.AppendText("CheckBox clicked.\n");

                CommandEvent ce = cast(CommandEvent)e;

                CheckBox cb = cast(CheckBox)e.EventObject;

                if (ce.Int == 1)
                    cb.toolTip = "Click to enable listbox";
                else
                    cb.toolTip = "Click to disable listbox";

                listbox.Enabled = (ce.Int == 0);
                listboxSorted.Enabled = (ce.Int == 0);
                selectStr.Enabled = (ce.Int == 0);
                selectNum.Enabled = (ce.Int == 0);
                break;

            case ID_LISTBOX_CLEAR:
                listbox.Clear();
                listboxSorted.Clear();
                break; 

            case ID_LISTBOX_APPEND:
                listbox.Append("Hi!");
                listboxSorted.Append("Hi!");
                break;

            case ID_LISTBOX_FONT:
                listbox.font = Font.wxITALIC_FONT;
                listboxSorted.font = Font.wxITALIC_FONT;
                break;
            }
        }

        //---------------------------------------------------------------------

        public void OnChangeColour(Object sender, Event e)
        {
            if(oldColour)
            {
                BackgroundColour = new Colour("red");
                selectStr.ForegroundColour = new Colour("red");
                selectStr.BackgroundColour = new Colour("white");
                oldColour = false;
            }
            else
            {
                BackgroundColour = new Colour("white");
                selectStr.ForegroundColour = new Colour("white");
                selectStr.BackgroundColour = new Colour("red");
                oldColour = true;
            }
        }

        //---------------------------------------------------------------------

        public void OnChoiceButtons(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

            switch(ce.ID)
            {
            case ID_CHOICE_SEL_NUM:
                choice.Selection = 2;
                choiceSorted.Selection = 2;
                break;

            case ID_CHOICE_SEL_STR:  
                choice.StringSelection = "This";
                choiceSorted.StringSelection = "This";
                break;

            case ID_CHOICE_CLEAR:
                choice.Clear();
                choiceSorted.Clear();
                break;

            case ID_CHOICE_APPEND:
                choice.Append("Hi!");
                choiceSorted.Append("Hi!");
                break;

            case ID_CHOICE_DELETE:
                if(choice.Selection != -1)
                    choice.Delete(choice.Selection);
                if(choiceSorted.Selection != -1)
                    choiceSorted.Delete(choiceSorted.Selection);
                break;

            case ID_CHOICE_FONT:
                choice.font = Font.wxITALIC_FONT;
                choiceSorted.font = Font.wxITALIC_FONT;
                break;

            case ID_CHOICE_ENABLE:
                choice.Enabled = (ce.Int == 0);  
                choiceSorted.Enabled = (ce.Int == 0);
                break;
            }
        }

        public void OnChoice(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            Choice c = e.ID == ID_CHOICE ? choice : choiceSorted;

            text.AppendText("Choice event selection is: '" ~
                            ce.String ~ "'\n" ~
                            "Choice control selection is: '" ~
                            c.StringSelection ~ "'\n");
        }

        //---------------------------------------------------------------------

        public void OnComboButtons(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

            switch(ce.ID)
            {
            case ID_COMBO_SEL_NUM:
                combo.Selection = 2;
                break;

            case ID_COMBO_SEL_STR:
                combo.StringSelection = "This";
                break;

            case ID_COMBO_CLEAR:
                combo.Clear();
                break;

            case ID_COMBO_APPEND:
                combo.Append("Hi!");
                break;

            case ID_COMBO_DELETE:
                if(combo.Selection != -1)
                    combo.Delete(combo.Selection);
                break;

            case ID_COMBO_FONT:
                combo.font = Font.wxITALIC_FONT;
                combo.font = Font.wxITALIC_FONT;
                break;

            case ID_COMBO_ENABLE:
                combo.Enabled = (ce.Int == 0);
                break;
            }
        }

        public void OnCombo(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

            text.AppendText("Combo event selection is: '" ~
                            ce.String ~ "'\n" ~
                            "Combo control selection is: '" ~
                            combo.StringSelection ~ "'\n");
        }

        public void OnComboTextChanged(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

	    	writefln( ce.String );

            Log.LogMessage( "Text in the combobox changed: now is '{0}'", ce.String);
        }

        public void OnComboTextEnter(Object sender, Event e)
        {
            Log.LogMessage("Enter pressed in the combobox: value is: '{0}'", combo.Value);
        }

        //---------------------------------------------------------------------

        public void OnRadio(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("Radio selection string is: '" ~
                            ce.String ~ "'.\n");
        }

        public void OnRadioButtons(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;

            switch(ce.ID)
            {
            case ID_RADIO_ENABLE:
                radiobox.Enabled = (ce.Int == 0);
                break;

            case ID_RADIO_SEL_NUM:
                radiobox.Selection = 2;
                break;

            case ID_RADIO_SEL_STR:
                radiobox.StringSelection = "This";
                break;

            case ID_RADIO_FONT:
                radiobox.ForegroundColour = new Colour("Green");
                radiobox.font = Font.wxITALIC_FONT;
                break;
            }
        }

        //---------------------------------------------------------------------

        public void OnSetFont(Object sender, Event e)
        {
			fontButton.font = Font.wxITALIC_FONT;
			text.font = Font.wxITALIC_FONT;
        }
		
		public void OnUpdateLabel(Object sender, Event e)
		{
			CommandEvent ce = cast(CommandEvent) e;
			m_label.Label = ce.Int == 0 ? "Very very very very very long text." : "Shorter text.";
		}
		
		public void OnBmpButton(Object sender, Event e)
		{
			Log.LogMessage("Bitmap button clicked.");
		}
		
		public void OnSizerCheck(Object sender, Event e)
		{
			CommandEvent ce = cast(CommandEvent) e;
			switch( e.ID )
			{
				case ID_SIZER_CHECK1:
					m_buttonSizer.Show( m_sizerBtn1, ce.IsChecked );
					m_buttonSizer.Layout();
				break;
				case ID_SIZER_CHECK2:
    				m_buttonSizer.Show ( m_sizerBtn2, ce.IsChecked );
    				m_buttonSizer.Layout ();
    			break;		
 				case ID_SIZER_CHECK3:
    				m_buttonSizer.Show ( m_sizerBtn3, ce.IsChecked );
    				m_buttonSizer.Layout();
    			break;	
  				case ID_SIZER_CHECK4:
    				m_buttonSizer.Show ( m_sizerBtn4, ce.IsChecked );
    				m_buttonSizer.Layout();
    			break;	
				case ID_SIZER_CHECK14:
    				m_hsizer.Show ( m_buttonSizer, ce.IsChecked );
    				m_hsizer.Layout();
    			break;
  				case ID_SIZER_CHECKBIG:
    				m_hsizer.Show ( m_bigBtn, ce.IsChecked );
    				m_hsizer.Layout ();
    			break;				
			}
		}

        //---------------------------------------------------------------------
        
        public void OnSliderUpdate(Object sender, Event e)
        {
            gauge.Value = slider.Value;
            gaugeVert.Value = slider.Value;
        }

        public void OnSpinCtrl(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("SpinCtrl changed: now " ~ .toString(spinctrl.Value) ~ 
                            " (from event: " ~ .toString(ce.Int) ~ ")\n");
        }

        public void OnSpinCtrlUp(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("SpinCtrl up: now " ~ .toString(spinctrl.Value) ~ 
                            " (from event: " ~ .toString(ce.Int) ~ ")\n");
        }

        public void OnSpinCtrlDown(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("SpinCtrl down: now " ~ .toString(spinctrl.Value) ~ 
                            " (from event: " ~ .toString(ce.Int) ~ ")\n");
        }

        public void OnSpinCtrlText(Object sender, Event e)
        {
            CommandEvent ce = cast(CommandEvent)e;
            text.AppendText("SpinCtrl text changed: now " ~ .toString(spinctrl.Value) ~ 
                            " (from event: " ~ ce.String ~ ")\n");
        } 

        public void OnSpinUpdate(Object sender, Event e) 
        {
			SpinEvent se = cast(SpinEvent) e;
            spintext.Value = "" ~ .toString(se.Position);

            text.AppendText("Spin conntrol range: (" ~ .toString(spinbutton.Min) ~ ", " ~ 
					.toString(spinbutton.Max) ~ "), current = " ~ .toString(spinbutton.Value) ~ "\n");

        }

        public void OnSpinUp(Object sender, Event e)
        {
			SpinEvent se = cast(SpinEvent) e;
            string str = "Spin button up: current = " ~ .toString(spinbutton.Value) ~ "\n";

            if (se.Position > 17) {
                str ~= "Preventing spin button from going above 17.\n";

				se.Veto();
			}

			Log.LogMessage(str);
        }
        
        public void OnSpinDown(Object sender, Event e)
        {
            SpinEvent se = cast(SpinEvent) e;
            string str = "Spin button down: current = " ~ .toString(spinbutton.Value) ~ "\n";

            if (se.Position < -17) {
                str ~= "Preventing spin button from going below -17.\n";

				se.Veto();
            }

			Log.LogMessage(str);
        }

        public void OnUpdateShowProgress(Object sender, Event e)
        {
            btnProgress.Enabled = spinbutton.Value > 0;
        }

        public void OnShowProgress(Object sender, Event e)
        {
			int max = spinbutton.Value;
			
			if ( max <= 0 )
			{
				Log.LogError("You must set positive range!");
				return;
			}
			
			ProgressDialog pd = new ProgressDialog("Progress dialog example",
													"An informative message",
													max,
													this,
													ProgressDialog.wxPD_CAN_ABORT |
													ProgressDialog.wxPD_AUTO_HIDE |
													ProgressDialog.wxPD_APP_MODAL |
													ProgressDialog.wxPD_ELAPSED_TIME |
													ProgressDialog.wxPD_ESTIMATED_TIME |
													ProgressDialog.wxPD_REMAINING_TIME );
													
			bool cont = true;
			for ( int i = 0; i <= max; i++ )
			{
				wxSleep(1);
				if ( i == max )
				{
					cont = pd.Update(i, "That's all, folks!");
				}
				else if ( i == max / 2 )
				{
					cont = pd.Update(i, "Only a half left (very long message)!");
				}
				else
				{
					cont = pd.Update(i);
				}
				if ( !cont ) break;
			}
			
			if ( !cont )
			{
				text.AppendText("Progress dialog aborted!\n");
				
				// use Dispose() or Show(false) to close the ProgressDialog
				// otherwise the dialog won't get closed and the app hangs
				//pd.Dispose();
				pd.Show(false);
			}
			else
			{
				text.AppendText("Countdown from " ~ .toString(max) ~ " finished.\n");
			}
        }
		
		public void OnPageChanging(Object sender, Event e)
		{
			NotebookEvent ne = cast(NotebookEvent) e;
			int selOld = ne.OldSelection;
			if ( selOld == 2 )
			{
				MessageDialog md = new MessageDialog(this, "This demonstrates how a program may prevent the\n" ~
									"page change from taking place - if you select\n" ~
									"[No] the current page will stay the third one\n",
									"Control sample", Dialog.wxNO_DEFAULT|Dialog.wxICON_QUESTION | Dialog.wxYES_NO);
				
				if ( md.ShowModal() != wxID_YES )
				{					
					ne.Veto();
					return;
				}	
			}
			
			text.AppendText("Notebook selection is being changed from " ~ .toString(selOld) ~
							" to " ~  .toString(ne.Selection) ~
							" (current page from notebook is " ~
							.toString(notebook.Selection) ~ ")\n");
		}
		
		public void OnPageChanged(Object sender, Event e)
		{
			NotebookEvent ne = cast(NotebookEvent) e;
			text.AppendText("Notebook selection is now " ~ .toString(ne.Selection) ~
							" (from notebook: " ~ .toString(notebook.Selection) ~ ")\n");
		}

        //---------------------------------------------------------------------
    }


void main()
{
	Controls.Main();
}
