//-----------------------------------------------------------------------------
// wx.NET/Samples - Dnd.cs
//
// wx.NET "Dnd" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

using wx;

namespace wx.Samples
{
    public class DNDText : TextDropTarget
    {
        private ListBox myOwner;
		
	//---------------------------------------------------------------------

        public DNDText(ListBox myOwner)
            : base()
        {
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

        public DNDFile(ListBox myOwner)
            : base()
        {
            this.myOwner = myOwner;
        } 
		
		//---------------------------------------------------------------------

        public override bool OnDropFiles(int x, int y, string[] filenames)
        {
	    	string str = filenames.Length + " files dropped";
		myOwner.Append(str);

	    	for ( int i = 0; i < filenames.Length; i++ )
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

        public DndFrame(string title, Point pos, Size size)
            : base(title, pos, size)
        {
            // Set the window icon and status bar

            Icon = new wx.Icon("../Samples/Dnd/mondrian.png");

            CreateStatusBar();
            StatusText = "Welcome to the Dnd Sample!";						
			
            // Set up a menu

            Menu fileMenu = new Menu();
	    fileMenu.Append((int)Cmd.Menu_Drag, "&Test drag...");
	    fileMenu.AppendCheckItem((int)Cmd.Menu_DragMoveDef, "&Move by default", "");
	    fileMenu.AppendCheckItem((int)Cmd.Menu_DragMoveAllow, "&Allow moving", "");
	    fileMenu.AppendSeparator();
	    fileMenu.Append((int)Cmd.Menu_Quit, "E&xit\tCtrl-Q");
			
	    Menu logMenu = new Menu();
	    logMenu.Append((int)Cmd.Menu_Clear, "Clear\tCtrl-L");

            Menu helpMenu = new Menu();
	    helpMenu.Append((int)Cmd.Menu_Help, "&Help");
	    helpMenu.AppendSeparator();
            helpMenu.Append((int)Cmd.Menu_About, "&About"); 
			
	    Menu clipMenu = new Menu();
	    clipMenu.Append((int)Cmd.Menu_Copy, "&Copy text\tCtrl-C");
	    clipMenu.Append((int)Cmd.Menu_Paste, "&Paste text\tCtrl-V");

            wx.MenuBar menuBar = new wx.MenuBar();
            menuBar.Append(fileMenu, "&File");
	    menuBar.Append(logMenu, "&Log");
	    menuBar.Append(clipMenu, "&Clipboard");
            menuBar.Append(helpMenu, "&Help");

            MenuBar = menuBar;
			
	    Point apos = new Point(0, 0);
	    Size asize = new Size(300, 200); 
	    Size bsize = new Size(600,100);
	    
	    string[]  strFile = {"Drop files here!"};
	    string[]  strText = {"Drop text on me"};
			
	    m_ctrlFile = new ListBox(this, -1, wxDefaultPosition, asize, 1, strFile, ListBox.wxLB_HSCROLL | ListBox.wxLB_ALWAYS_SB);
			
	    m_ctrlText = new ListBox(this, -1, wxDefaultPosition, asize, 1, strText, ListBox.wxLB_HSCROLL | ListBox.wxLB_ALWAYS_SB);
			
	    m_ctrlLog = new TextCtrl(this, -1, "", wxDefaultPosition, bsize, TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );
			
	    Log.SetActiveTarget(m_ctrlLog);  
	    Log.AddTraceMask("focus");
	    
	    m_ctrlFile.DropTarget = new DNDFile(m_ctrlFile);
	    m_ctrlText.DropTarget = new DNDText(m_ctrlText);	

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
			
	    menuBar.Check( (int)Cmd.Menu_DragMoveAllow, true );
			
            // Set up the event table

            EVT_MENU((int)Cmd.Menu_Quit,    new EventListener(OnQuit));
            EVT_MENU((int)Cmd.Menu_About,   new EventListener(OnAbout));
	    EVT_MENU((int)Cmd.Menu_Drag, new EventListener(OnDrag));		
	    EVT_MENU((int)Cmd.Menu_DragMoveDef, new EventListener(OnDragMoveByDefault));	
	    EVT_MENU((int)Cmd.Menu_DragMoveAllow, new EventListener(OnDragMoveAllow));	
	    EVT_MENU((int)Cmd.Menu_Help, new EventListener(OnHelp));		
	    EVT_MENU((int)Cmd.Menu_Clear, new EventListener(OnLogClear));	
	    EVT_MENU((int)Cmd.Menu_Copy, new EventListener(OnCopy));			
	    EVT_MENU((int)Cmd.Menu_Paste, new EventListener(OnPaste));
	    
	    EVT_SIZE(new EventListener(OnSize));
			
	    EVT_PAINT(new EventListener(OnPaint));
	    
	    EVT_UPDATE_UI((int)Cmd.Menu_DragMoveDef, new EventListener(OnUpdateUIMoveByDefault));
	    EVT_UPDATE_UI((int)Cmd.Menu_Paste, new EventListener(OnUpdateUIPasteText));
			
	    EVT_LEFT_DOWN(new EventListener(OnLeftDown));
	    EVT_RIGHT_DOWN(new EventListener(OnRightDown));
			
	    Log.LogMessage("DnD sample started..");
			
	    m_strText = "wx.NET drag & drop works :-)";
        }

        //---------------------------------------------------------------------

        public void OnQuit(object sender, wx.Event e)
        {
            Close();
        }

        //---------------------------------------------------------------------


        public void OnAbout(object sender, wx.Event e)
        {
            string msg = "This is the About dialog of the dnd sample.";
            wx.MessageDialog.ShowModal(this, msg, "About Dnd", Dialog.wxOK | Dialog.wxICON_INFORMATION);
        }

        //---------------------------------------------------------------------
		
	public void OnSize(object sender, Event e)
	{
		Refresh();
			
		e.Skip();
	}
		
	//---------------------------------------------------------------------
		
	public void OnPaint(object sender, Event e)
	{
		Size cs = ClientSize;
		
		PaintDC dc = new PaintDC(this);
			
		dc.Font = new Font( 24, FontFamily.wxDECORATIVE, FontStyle.wxNORMAL, FontWeight.wxNORMAL, false, "charter");
		dc.DrawText("Drag text from here!", 100, cs.Height - 50);
            
		dc.Dispose();
	}
		
	//---------------------------------------------------------------------
		
	public void OnUpdateUIMoveByDefault(object sender, Event e)
	{
		UpdateUIEvent ue = (UpdateUIEvent) e;
		ue.Enabled = m_moveAllow;
	}
		
	//---------------------------------------------------------------------
	
	public void OnUpdateUIPasteText(object sender, Event e)
	{
		UpdateUIEvent ue = (UpdateUIEvent) e;
		ue.Enabled = CTheClipboard.TheClipboard.IsSupported(new DataFormat(DataFormatId.wxDF_TEXT));
	}
		
	//---------------------------------------------------------------------
		
	public void OnDrag(object sender, Event e)
	{
		string strText = new GetTextFromUser(
			"After you enter text in this dialog, press any mouse\n" +
			"button in the bottom (empty) part of the frame and \n" +
			"drag it anywhere - you will be in fact dragging the\n" +
			"text object containing this text",
         		"Please enter some text", m_strText, this);		

		if ( strText.Length > 0) 
		{
			m_strText = null;
			m_strText = strText;
		}
	}
		
	//---------------------------------------------------------------------
		
	public void OnDragMoveByDefault(object sender, Event e)
	{
		CommandEvent ce = (CommandEvent) e;
		m_moveByDefault = ce.IsChecked;
	}
		
	//---------------------------------------------------------------------
		
	public void OnDragMoveAllow(object sender, Event e)
	{
		CommandEvent ce = (CommandEvent) e;
		m_moveAllow = ce.IsChecked;		
	}
		
	//---------------------------------------------------------------------
		
	public void OnHelp(object sender, Event e)
	{
		MessageDialog md = new MessageDialog(this, 
			"This small program demonstrates drag & drop support in wx.NET. The program window\n" +
			"consists of 3 parts: the bottom pane is for debug messages, so that you can see what's\n" +
                        "going on inside. The top part is split into 2 listboxes, the left one accepts files\n" +
                        "and the right one accepts text.\n" +
                        "\n" +
                        "To test wxDropTarget: open wordpad (write.exe), select some text in it and drag it to\n" +
                        "the right listbox (you'll notice the usual visual feedback, i.e. the cursor will change).\n" +
                        "Also, try dragging some files (you can select several at once) from Windows Explorer (or \n" +
                        "File Manager) to the left pane. Hold down Ctrl/Shift keys when you drop text (doesn't \n" +
                        "work with files) and see what changes.\n" +
                        "\n" +
                        "To test wxDropSource: just press any mouse button on the empty zone of the window and drag\n" +
                        "it to wordpad or any other droptarget accepting text (and of course you can just drag it\n" +
                        "to the right pane). Due to a lot of trace messages, the cursor might take some time to \n" +
                        "change, don't release the mouse button until it does. You can change the string being\n" +
                        "dragged in in \"File|Test drag...\" dialog.\n",
                        "wxDnD Help");			
			
		md.ShowModal();
	}
		
	//---------------------------------------------------------------------
		
	public void OnLogClear(object sender, Event e)
	{
		m_ctrlLog.Clear();
		m_ctrlText.Clear();
		m_ctrlFile.Clear();
	}
		
	//---------------------------------------------------------------------
		
	public void OnLeftDown(object sender, Event e)
	{
		if (m_strText.Length > 0)
			{
				TextDataObject textData = new TextDataObject( m_strText );
				
				if (textData == null) 
				{
					return;
				}
				
				DropSource source = new DropSource(textData, this);
																
				int flags = (int)Drag.wxDrag_CopyOnly;
				if ( m_moveByDefault )
					flags |= (int)Drag.wxDrag_DefaultMove;
				else if ( m_moveAllow )
					flags |= (int)Drag.wxDrag_AllowMove;
					
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
				
				StatusText = "Drag result: " + result;	
			}		
		}
		
		//---------------------------------------------------------------------
		
		public void OnRightDown(object sender, Event e)
		{
			MouseEvent me = (MouseEvent) e;
		
			Menu menu = new Menu("Dnd sample menu");
			
			menu.Append((int)Cmd.Menu_Drag, "&Test drag");
			menu.AppendSeparator();
			menu.Append((int)Cmd.Menu_About, "&About");
			
			PopupMenu( menu, me.Position);
		}
		
		//---------------------------------------------------------------------		
		
		public void OnCopy(object sender, Event e)
		{
			if ( !CTheClipboard.TheClipboard.Open() )
			{
				Log.LogError("Can't open clipboard.");
				return;
			}
			
			if ( !CTheClipboard.TheClipboard.AddData(new TextDataObject(m_strText)) )
			{
				Log.LogError("Can't copy data to the clipboard");
			}
			else
			{
				Log.LogMessage("Text '{0}' put on the clipboard", m_strText);
			}
			
			CTheClipboard.TheClipboard.Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnPaste(object sender, Event e)
		{
			if ( !CTheClipboard.TheClipboard.Open() )
			{
				Log.LogError("Can't open clipboard.");
				return;
			}
			
			if ( !CTheClipboard.TheClipboard.IsSupported(new DataFormat(DataFormatId.wxDF_TEXT)) )
			{
				Log.LogWarning("No text data on clipboard");
				CTheClipboard.TheClipboard.Close();
				return;
			}
			
			TextDataObject text = new TextDataObject();
			if ( !CTheClipboard.TheClipboard.GetData(text) )
			{
				Log.LogError("Can't paste data from the clipboard");
			}
			else
			{
				Log.LogMessage("Text '{0}' pasted from the clipboard", text.Text);
			}
			
			CTheClipboard.TheClipboard.Close();
		}
    }   
	
	//---------------------------------------------------------------------	

    public class Dnd : wx.App
    {
        //---------------------------------------------------------------------

        public override bool OnInit()
        {
            DndFrame frame = new DndFrame("Dnd wxWidgets App", new Point(10, 100), new Size(650,340));
            frame.Show(true);

            return true;
        }

        //---------------------------------------------------------------------

        [STAThread]
            static void Main()
            {
                Dnd app = new Dnd();
                app.Run();
            }

        //---------------------------------------------------------------------
    }
}
