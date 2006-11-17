//-----------------------------------------------------------------------------
// wxD/Samples - Dnd.d
//
// wxD "Dnd" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

    public class DNDText : TextDropTarget
    {
        private ListBox myOwner;
		
	//---------------------------------------------------------------------

        public this(ListBox myOwner)
        {
            super();
            this.myOwner = myOwner;
        } 
		 
	//---------------------------------------------------------------------

        public override bool OnDropText(int x, int y, string text)
        {
            myOwner.Append(text);
            return true;
        }
    }

	//---------------------------------------------------------------------

    public class DNDFile : FileDropTarget
    {
        private ListBox myOwner;
		
		//---------------------------------------------------------------------

        public this(ListBox myOwner)
        {
            super();
            this.myOwner = myOwner;
        } 
		
		//---------------------------------------------------------------------

        public override bool OnDropFiles(int x, int y, string[] filenames)
        {
	    	string str = .toString(filenames.length) ~ " files dropped";
		myOwner.Append(str);

	    	for ( int i = 0; i < filenames.length; i++ )
	    	{
	    		myOwner.Append(filenames[i]);
	    	}
   
		return true;
        }
    }
	
	//---------------------------------------------------------------------	
		
    public class DndFrame : Frame
    {
        enum Cmd { Menu_Drag, Menu_DragMoveDef, Menu_DragMoveAllow, Menu_About, Menu_Quit,
			Menu_Clear, Menu_Help, Menu_Copy, Menu_Paste}

        private ListBox m_ctrlText = null;
	private ListBox m_ctrlFile = null;
		
	private TextCtrl m_ctrlLog = null;
		
	private Log m_pLog = null;
	private Log m_pLogPrev = null;
		
	private bool m_moveByDefault = false;
	private bool m_moveAllow = true;
	
	public string m_strText;
	
        //---------------------------------------------------------------------

        public this(string title, Point pos, Size size)
        {
            super(title, pos, size);
            // Set the window icon and status bar

            icon = new Icon("../Samples/Dnd/mondrian.png");

            CreateStatusBar();
            StatusText = "Welcome to the Dnd Sample!";						
			
            // Set up a menu

            Menu fileMenu = new Menu();
	    fileMenu.Append(Cmd.Menu_Drag, "&Test drag...");
	    fileMenu.AppendCheckItem(Cmd.Menu_DragMoveDef, "&Move by default", "");
	    fileMenu.AppendCheckItem(Cmd.Menu_DragMoveAllow, "&Allow moving", "");
	    fileMenu.AppendSeparator();
	    fileMenu.Append(Cmd.Menu_Quit, "E&xit\tCtrl-Q");
			
	    Menu logMenu = new Menu();
	    logMenu.Append(Cmd.Menu_Clear, "Clear\tCtrl-L");

            Menu helpMenu = new Menu();
	    helpMenu.Append(Cmd.Menu_Help, "&Help");
	    helpMenu.AppendSeparator();
            helpMenu.Append(Cmd.Menu_About, "&About"); 
			
	    Menu clipMenu = new Menu();
	    clipMenu.Append(Cmd.Menu_Copy, "&Copy text\tCtrl-C");
	    clipMenu.Append(Cmd.Menu_Paste, "&Paste text\tCtrl-V");

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
	    menuBar.Append(logMenu, "&Log");
	    menuBar.Append(clipMenu, "&Clipboard");
            menuBar.Append(helpMenu, "&Help");

            this.menuBar = menuBar;
			
	    Point apos = Point(0, 0);
	    Size asize = Size(300, 200); 
	    Size bsize = Size(600,100);
	    
	    const string[]  strFile = ["Drop files here!"];
	    const string[]  strText = ["Drop text on me"];
			
	    m_ctrlFile = new ListBox(this, -1, wxDefaultPosition, asize, strFile, ListBox.wxLB_HSCROLL | ListBox.wxLB_ALWAYS_SB);
			
	    m_ctrlText = new ListBox(this, -1, wxDefaultPosition, asize, strText, ListBox.wxLB_HSCROLL | ListBox.wxLB_ALWAYS_SB);
			
	    m_ctrlLog = new TextCtrl(this, -1, "", wxDefaultPosition, bsize, TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );
			
	    Log.SetActiveTarget(m_ctrlLog);  
	    Log.AddTraceMask("focus");
	    
	    m_ctrlFile.dropTarget = new DNDFile(m_ctrlFile);
	    m_ctrlText.dropTarget = new DNDText(m_ctrlText);	

	    BoxSizer main_sizer = new BoxSizer( Orientation.wxVERTICAL );
	    BoxSizer h_sizer = new BoxSizer( Orientation.wxHORIZONTAL );									
			
	    h_sizer.Add(m_ctrlFile, 1, Direction.wxALL, 5 );			
	    h_sizer.Add(m_ctrlText, 1, Direction.wxALL, 5 );
	    main_sizer.Add(h_sizer,  0, Direction.wxALL, 0);
	    main_sizer.Add(m_ctrlLog, 1, Direction.wxALL, 5);		
	    main_sizer.Add(new BoxSizer(Orientation.wxHORIZONTAL), 1, Direction.wxALL, 5);
	    
	    AutoLayout = true;
	    SetSizer( main_sizer, true );
			
            main_sizer.Fit( this );
            main_sizer.SetSizeHints( this );		
			
	    menuBar.Check( Cmd.Menu_DragMoveAllow, true );
			
            // Set up the event table

            EVT_MENU(Cmd.Menu_Quit,    &OnQuit);
            EVT_MENU(Cmd.Menu_About,   &OnAbout);
	    EVT_MENU(Cmd.Menu_Drag, &OnDrag);		
	    EVT_MENU(Cmd.Menu_DragMoveDef, &OnDragMoveByDefault);	
	    EVT_MENU(Cmd.Menu_DragMoveAllow, &OnDragMoveAllow);	
	    EVT_MENU(Cmd.Menu_Help, &OnHelp);		
	    EVT_MENU(Cmd.Menu_Clear, &OnLogClear);	
	    EVT_MENU(Cmd.Menu_Copy, &OnCopy);			
	    EVT_MENU(Cmd.Menu_Paste, &OnPaste);
	    
	    EVT_SIZE(&OnSize);
			
	    EVT_PAINT(&OnPaint);
	    
	    EVT_UPDATE_UI(Cmd.Menu_DragMoveDef, &OnUpdateUIMoveByDefault);
	    EVT_UPDATE_UI(Cmd.Menu_Paste, &OnUpdateUIPasteText);
			
	    EVT_LEFT_DOWN(&OnLeftDown);
	    EVT_RIGHT_DOWN(&OnRightDown);
			
	    Log.LogMessage("DnD sample started..");
			
	    m_strText = "wxD drag & drop works :-)";
        }

        //---------------------------------------------------------------------

        public void OnQuit(Object sender, Event e)
        {
            Close();
        }

        //---------------------------------------------------------------------


        public void OnAbout(Object sender, Event e)
        {
            string msg = "This is the About dialog of the dnd sample.";
            MessageBox(this, msg, "About Dnd", Dialog.wxOK | Dialog.wxICON_INFORMATION);
        }

        //---------------------------------------------------------------------
		
	public void OnSize(Object sender, Event e)
	{
		Refresh();
			
		e.Skip();
	}
		
	//---------------------------------------------------------------------
		
	public void OnPaint(Object sender, Event e)
	{
		Size cs = ClientSize;
		
		PaintDC dc = new PaintDC(this);
			
		dc.font = new Font( 24, FontFamily.wxDECORATIVE, FontStyle.wxNORMAL, FontWeight.wxNORMAL, false, "charter");
		dc.DrawText("Drag text from here!", 100, cs.Height - 50);
            
		dc.Dispose();
	}
		
	//---------------------------------------------------------------------
		
	public void OnUpdateUIMoveByDefault(Object sender, Event e)
	{
		UpdateUIEvent ue = cast(UpdateUIEvent) e;
		ue.Enabled = m_moveAllow;
	}
		
	//---------------------------------------------------------------------
	
	public void OnUpdateUIPasteText(Object sender, Event e)
	{
		UpdateUIEvent ue = cast(UpdateUIEvent) e;
		ue.Enabled = Clipboard.TheClipboard.IsSupported(new DataFormat(DataFormatId.wxDF_TEXT));
	}
		
	//---------------------------------------------------------------------
		
	public void OnDrag(Object sender, Event e)
	{
		string strText = GetTextFromUser(
			"After you enter text in this dialog, press any mouse\n" 
			"button in the bottom (empty) part of the frame and \n" 
			"drag it anywhere - you will be in fact dragging the\n" 
			"text Object containing this text",
         		"Please enter some text", m_strText, this);		

		if ( strText.length > 0) 
		{
			m_strText = null;
			m_strText = strText;
		}
	}
		
	//---------------------------------------------------------------------
		
	public void OnDragMoveByDefault(Object sender, Event e)
	{
		CommandEvent ce = cast(CommandEvent) e;
		m_moveByDefault = ce.IsChecked;
	}
		
	//---------------------------------------------------------------------
		
	public void OnDragMoveAllow(Object sender, Event e)
	{
		CommandEvent ce = cast(CommandEvent) e;
		m_moveAllow = ce.IsChecked;		
	}
		
	//---------------------------------------------------------------------
		
	public void OnHelp(Object sender, Event e)
	{
		MessageDialog md = new MessageDialog(this, 
			"This small program demonstrates drag & drop support in wxD. The program window\n" 
			"consists of 3 parts: the bottom pane is for debug messages, so that you can see what's\n" 
                        "going on inside. The top part is split into 2 listboxes, the left one accepts files\n" 
                        "and the right one accepts text.\n" 
                        "\n" 
                        "To test wxDropTarget: open wordpad (write.exe), select some text in it and drag it to\n" 
                        "the right listbox (you'll notice the usual visual feedback, i.e. the cursor will change).\n" 
                        "Also, try dragging some files (you can select several at once) from Windows Explorer (or \n" 
                        "File Manager) to the left pane. Hold down Ctrl/Shift keys when you drop text (doesn't \n" 
                        "work with files) and see what changes.\n" 
                        "\n" 
                        "To test wxDropSource: just press any mouse button on the empty zone of the window and drag\n"
                        "it to wordpad or any other droptarget accepting text (and of course you can just drag it\n" 
                        "to the right pane). Due to a lot of trace messages, the cursor might take some time to \n" 
                        "change, don't release the mouse button until it does. You can change the string being\n" 
                        "dragged in in \"File|Test drag...\" dialog.\n",
                        "wxDnD Help");			
			
		md.ShowModal();
	}
		
	//---------------------------------------------------------------------
		
	public void OnLogClear(Object sender, Event e)
	{
		m_ctrlLog.Clear();
		m_ctrlText.Clear();
		m_ctrlFile.Clear();
	}
		
	//---------------------------------------------------------------------
		
	public void OnLeftDown(Object sender, Event e)
	{
		if (m_strText.length > 0)
			{
				TextDataObject textData = new TextDataObject( m_strText );
				
				if (textData is null) 
				{
					return;
				}
				
				DropSource source = new DropSource(textData, this);
																
				int flags = Drag.wxDrag_CopyOnly;
				if ( m_moveByDefault )
					flags |= Drag.wxDrag_DefaultMove;
				else if ( m_moveAllow )
					flags |= Drag.wxDrag_AllowMove;
					
				string result = "";
				
				switch ( source.DoDragDrop(flags) )
				{
					case DragResult.wxDragError:	result = "Error!";  break;
					case DragResult.wxDragNone:     result = "Nothing"; break;
					case DragResult.wxDragCopy:   	result = "Copied";  break;
					case DragResult.wxDragMove:     result = "Moved";   break;
					case DragResult.wxDragCancel:	result = "Cancelled"; break;
					default:                        result = "Huh?";     break;					
				}
				
				StatusText = "Drag result: " ~ result;	
			}		
		}
		
		//---------------------------------------------------------------------
		
		public void OnRightDown(Object sender, Event e)
		{
			MouseEvent me = cast(MouseEvent) e;
		
			Menu menu = new Menu("Dnd sample menu");
			
			menu.Append(Cmd.Menu_Drag, "&Test drag");
			menu.AppendSeparator();
			menu.Append(Cmd.Menu_About, "&About");
			
			Point pos = me.Position;
			PopupMenu( menu, pos);
		}
		
		//---------------------------------------------------------------------		
		
		public void OnCopy(Object sender, Event e)
		{
			if ( !Clipboard.TheClipboard.Open() )
			{
				Log.LogError("Can't open clipboard.");
				return;
			}
			
			if ( !Clipboard.TheClipboard.AddData(new TextDataObject(m_strText)) )
			{
				Log.LogError("Can't copy data to the clipboard");
			}
			else
			{
				Log.LogMessage("Text '%s' put on the clipboard", m_strText);
			}
			
			Clipboard.TheClipboard.Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnPaste(Object sender, Event e)
		{
			if ( !Clipboard.TheClipboard.Open() )
			{
				Log.LogError("Can't open clipboard.");
				return;
			}
			
			if ( !Clipboard.TheClipboard.IsSupported(new DataFormat(DataFormatId.wxDF_TEXT)) )
			{
				Log.LogWarning("No text data on clipboard");
				Clipboard.TheClipboard.Close();
				return;
			}
			
			TextDataObject text = new TextDataObject();
			if ( !Clipboard.TheClipboard.GetData(text) )
			{
				Log.LogError("Can't paste data from the clipboard");
			}
			else
			{
				Log.LogMessage("Text '%s' pasted from the clipboard", text.Text);
			}
			
			Clipboard.TheClipboard.Close();
		}
    }   
	
	//---------------------------------------------------------------------	

    public class Dnd : App
    {
        //---------------------------------------------------------------------

        public override bool OnInit()
        {
            DndFrame frame = new DndFrame("Dnd wxWidgets App", Point(10, 100), Size(650,340));
            frame.Show(true);

            return true;
        }

        //---------------------------------------------------------------------

        
            static void Main()
            {
                Dnd app = new Dnd();
                app.Run();
            }

        //---------------------------------------------------------------------
    }


void main()
{
	Dnd.Main();
}
