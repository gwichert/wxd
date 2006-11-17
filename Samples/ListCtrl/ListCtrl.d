//-----------------------------------------------------------------------------
// wxD/Samples - ListCtrl.d
//
// A wxD version of the wxWidgets "listctrl" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import std.stdio;

	public enum Cmd
	{
		LIST_ABOUT,
		LIST_QUIT,
		
		LIST_LIST_VIEW,
		LIST_ICON_VIEW,
		LIST_ICON_TEXT_VIEW,
		LIST_SMALL_ICON_VIEW,
		LIST_SMALL_ICON_TEXT_VIEW,
		LIST_REPORT_VIEW,
		LIST_VIRTUAL_VIEW,
		
		LIST_DESELECT_ALL,
		LIST_SELECT_ALL,
		LIST_DELETE_ALL,
		LIST_DELETE,
		LIST_ADD,
		LIST_EDIT,
		LIST_SORT,
		LIST_SET_FG_COL,
		LIST_SET_BG_COL,
		LIST_TOGGLE_MULTI_SEL,
		LIST_TOGGLE_FIRST,
		LIST_SHOW_COL_INFO,
		LIST_SHOW_SEL_INFO,
		LIST_FOCUS_LAST,
		LIST_FREEZE,
		LIST_THAW,
		LIST_TOGGLE_LINES,
		
		LIST_CTRL                   = 1000
	};
	
	//---------------------------------------------------------------------

	public class MyFrame : Frame
	{
		public ImageList m_imageListNormal;
		public ImageList m_imageListSmall;

		public TextCtrl m_logWindow;
		public MyListCtrl m_listCtrl;
		public Panel m_panel;
		
		public static int NUM_ITEMS = 30;
		
		public static int NUM_ICONS = 9;

		//---------------------------------------------------------------------

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			// Set the window icon and status bar

			icon = new Icon("../Samples/ListCtrl/mondrian.png");
			
			// Make an image list containing large icons
			m_imageListNormal = new ImageList(32, 32, true);
			m_imageListSmall = new ImageList(16, 16, true);
			
			Bitmap bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolbrai.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolchar.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/tooldata.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolnote.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/tooltodo.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolchec.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolgame.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/tooltime.xpm" );
			m_imageListNormal.Add( bmp );
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/toolword.xpm" );
			m_imageListNormal.Add( bmp );
			
			bmp = new Bitmap( "../Samples/ListCtrl/bitmaps/small1.xpm" );
			m_imageListSmall.Add( bmp );

			// Make a menubar
			Menu menuFile = new Menu();
			menuFile.Append(Cmd.LIST_ABOUT, _("&About"));
			menuFile.AppendSeparator();
			menuFile.Append(Cmd.LIST_QUIT, _("E&xit\tAlt-X"));

			Menu menuView = new Menu();
			menuView.Append(Cmd.LIST_LIST_VIEW, _("&List view\tF1"));
			menuView.Append(Cmd.LIST_REPORT_VIEW, _("&Report view\tF2"));
			menuView.Append(Cmd.LIST_ICON_VIEW, _("&Icon view\tF3"));
			menuView.Append(Cmd.LIST_ICON_TEXT_VIEW, _("Icon view with &text\tF4"));
			menuView.Append(Cmd.LIST_SMALL_ICON_VIEW, _("&Small icon view\tF5"));
			menuView.Append(Cmd.LIST_SMALL_ICON_TEXT_VIEW, _("Small icon &view with text\tF6"));
			menuView.Append(Cmd.LIST_VIRTUAL_VIEW, _("Virtual view\tF7"));

			Menu menuList = new Menu();
			menuList.Append(Cmd.LIST_FOCUS_LAST, _("&Make last item current\tCtrl-L"));
			menuList.Append(Cmd.LIST_TOGGLE_FIRST, _("To&ggle first item\tCtrl-G"));
			menuList.Append(Cmd.LIST_DESELECT_ALL, _("&Deselect All\tCtrl-D"));
			menuList.Append(Cmd.LIST_SELECT_ALL, _("S&elect All\tCtrl-A"));
			menuList.AppendSeparator();
			menuList.Append(Cmd.LIST_SHOW_COL_INFO, _("Show &column info\tCtrl-C"));
			menuList.Append(Cmd.LIST_SHOW_SEL_INFO, _("Show &selected items\tCtrl-S"));
			menuList.AppendSeparator();
			menuList.Append(Cmd.LIST_SORT, _("&Sort\tCtrl-S"));
			menuList.AppendSeparator();
			menuList.Append(Cmd.LIST_ADD, _("&Append an item\tCtrl-P"));
			menuList.Append(Cmd.LIST_EDIT, _("&Edit the item\tCtrl-E"));
			menuList.Append(Cmd.LIST_DELETE, _("&Delete first item\tCtrl-X"));
			menuList.Append(Cmd.LIST_DELETE_ALL, _("Delete &all items"));
			menuList.AppendSeparator();
			menuList.Append(Cmd.LIST_FREEZE, _("Free&ze\tCtrl-Z"));
			menuList.Append(Cmd.LIST_THAW, _("Tha&w\tCtrl-W"));
			menuList.AppendSeparator();
			menuList.AppendCheckItem(Cmd.LIST_TOGGLE_LINES, _("Toggle &lines\tCtrl-I"));
			menuList.AppendCheckItem(Cmd.LIST_TOGGLE_MULTI_SEL, _("&Multiple selection\tCtrl-M"), _("Toggle multiple selection"));

			Menu menuCol = new Menu();
			menuCol.Append(Cmd.LIST_SET_FG_COL, _("&Foreground colour..."));
			menuCol.Append(Cmd.LIST_SET_BG_COL, _("&Background colour..."));

			MenuBar menubar = new MenuBar();
			menubar.Append(menuFile, _("&File"));
			menubar.Append(menuView, _("&View"));
			menubar.Append(menuList, _("&List"));
			menubar.Append(menuCol, _("&Colour"));
			
			this.menuBar = menubar;

			m_panel = new Panel(this, wxID_ANY);
			m_logWindow = new TextCtrl(m_panel, wxID_ANY, "",
					wxDefaultPosition, wxDefaultSize,
					TextCtrl.wxTE_MULTILINE | Window.wxSUNKEN_BORDER);

			Log.SetActiveTarget(m_logWindow);

			RecreateList(ListCtrl.wxLC_REPORT | ListCtrl.wxLC_SINGLE_SEL);

			CreateStatusBar(3);
			
			EVT_SIZE(&OnSize);

			EVT_MENU(Cmd.LIST_QUIT, &OnQuit);
			EVT_MENU(Cmd.LIST_ABOUT, &OnAbout);
			EVT_MENU(Cmd.LIST_LIST_VIEW, &OnListView);
			EVT_MENU(Cmd.LIST_REPORT_VIEW, &OnReportView);
			EVT_MENU(Cmd.LIST_ICON_VIEW, &OnIconView);
			EVT_MENU(Cmd.LIST_ICON_TEXT_VIEW, &OnIconTextView);
			EVT_MENU(Cmd.LIST_SMALL_ICON_VIEW, &OnSmallIconView);
			EVT_MENU(Cmd.LIST_SMALL_ICON_TEXT_VIEW, &OnSmallIconTextView);
			EVT_MENU(Cmd.LIST_VIRTUAL_VIEW, &OnVirtualView);
			
			EVT_MENU(Cmd.LIST_FOCUS_LAST, &OnFocusLast);
			EVT_MENU(Cmd.LIST_TOGGLE_FIRST, &OnToggleFirstSel);
			EVT_MENU(Cmd.LIST_DESELECT_ALL, &OnDeselectAll);
			EVT_MENU(Cmd.LIST_SELECT_ALL, &OnSelectAll);
			EVT_MENU(Cmd.LIST_DELETE, &OnDelete);
			EVT_MENU(Cmd.LIST_ADD, &OnAdd);
			EVT_MENU(Cmd.LIST_EDIT, &OnEdit);
			EVT_MENU(Cmd.LIST_DELETE_ALL, &OnDeleteAll);
			EVT_MENU(Cmd.LIST_SORT, &OnSort);
			EVT_MENU(Cmd.LIST_SET_FG_COL, &OnSetFgColour);
			EVT_MENU(Cmd.LIST_SET_BG_COL, &OnSetBgColour);
			EVT_MENU(Cmd.LIST_TOGGLE_MULTI_SEL, &OnToggleMultiSel);
			EVT_MENU(Cmd.LIST_SHOW_COL_INFO, &OnShowColInfo);
			EVT_MENU(Cmd.LIST_SHOW_SEL_INFO, &OnShowSelInfo);
			EVT_MENU(Cmd.LIST_FREEZE, &OnFreeze);
			EVT_MENU(Cmd.LIST_THAW, &OnThaw);
			EVT_MENU(Cmd.LIST_TOGGLE_LINES, &OnToggleLines);
			
			EVT_UPDATE_UI(Cmd.LIST_SHOW_COL_INFO, &OnUpdateShowColInfo);
			EVT_UPDATE_UI(Cmd.LIST_TOGGLE_MULTI_SEL, &OnUpdateToggleMultiSel);
			
			Closing_Add(&OnClosing);
		}
		
		//---------------------------------------------------------------------	
		
		public void OnClosing(Object sender, Event e)
		{
			Log.SetActiveTarget(null);
			e.Skip();
		}

		//---------------------------------------------------------------------	

		public void OnAbout( Object sender, Event e )
		{
			MessageBox( "List test sample\nJulian Smart (c) 1997\nPorted to wxD by BERO", "About",
				Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}

		//---------------------------------------------------------------------	

		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnSize( Object sender, Event e )
		{
			DoSize();

			e.Skip();
		}
		
		//---------------------------------------------------------------------	

		public void DoSize()
		{
			if ( m_logWindow == null ) return;

			Size size = ClientSize;
			int y = (2*size.Height)/3;
			m_listCtrl.SetSize(0, 0, size.Width, y);
			m_logWindow.SetSize(0, y + 1, size.Width, size.Height - y);
		}
		
		//---------------------------------------------------------------------	
		
		public void OnFreeze( Object sender, Event e )
		{
			Log.LogMessage(_("Freezing the control"));

			m_listCtrl.Freeze();
		}

		//---------------------------------------------------------------------	

		public void OnThaw( Object sender, Event e )
		{
			Log.LogMessage(_("Thawing the control"));

			m_listCtrl.Thaw();
		}

		//---------------------------------------------------------------------	

		public void OnToggleLines( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent)e;
		
			m_listCtrl.SetSingleStyle(ListCtrl.wxLC_HRULES | ListCtrl.wxLC_VRULES, ce.IsChecked);
		}

		//---------------------------------------------------------------------	

		public void OnFocusLast( Object sender, Event e )
		{
			long index = m_listCtrl.ItemCount - 1;
			if ( index == -1 )
			{
				return;
			}

			m_listCtrl.SetItemState(index, ListCtrl.wxLIST_STATE_FOCUSED, ListCtrl.wxLIST_STATE_FOCUSED);
			m_listCtrl.EnsureVisible(index);
		}

		//---------------------------------------------------------------------	

		public void OnToggleFirstSel( Object sender, Event e )
		{
			m_listCtrl.SetItemState(0, (~m_listCtrl.GetItemState(0, ListCtrl.wxLIST_STATE_SELECTED) ) & ListCtrl.wxLIST_STATE_SELECTED, ListCtrl.wxLIST_STATE_SELECTED);
		}

		//---------------------------------------------------------------------	

		public void OnDeselectAll( Object sender, Event e )
		{
			if ( !CheckNonVirtual() )
				return;

			int n = m_listCtrl.ItemCount;
			for (int i = 0; i < n; i++)
				m_listCtrl.SetItemState(i,0,ListCtrl.wxLIST_STATE_SELECTED);
		}

		//---------------------------------------------------------------------	

		public void OnSelectAll( Object sender, Event e )
		{
			if ( !CheckNonVirtual() )
				return;

			int n = m_listCtrl.ItemCount;
			for (int i = 0; i < n; i++)
				m_listCtrl.SetItemState(i,ListCtrl.wxLIST_STATE_SELECTED, ListCtrl.wxLIST_STATE_SELECTED);
		}

		//---------------------------------------------------------------------	

		public bool CheckNonVirtual()
		{
			if ( !m_listCtrl.HasFlag(ListCtrl.wxLC_VIRTUAL) )
				return true;

			Log.LogWarning("Can't do this in virtual view, sorry.");

			return false;
		}
		
		//---------------------------------------------------------------------	
		
		public void RecreateList(long flags)
		{
			RecreateList(flags, true);
		}
		
		public void RecreateList(long flags, bool withText)
		{
			//delete m_listCtrl;

			m_listCtrl = new MyListCtrl(m_panel, Cmd.LIST_CTRL,
					wxDefaultPosition, wxDefaultSize,
					flags |
					wxSUNKEN_BORDER | ListCtrl.wxLC_EDIT_LABELS);

			switch ( flags & ListCtrl.wxLC_MASK_TYPE )
			{
				case ListCtrl.wxLC_LIST:
					InitWithListItems();
				break;

				case ListCtrl.wxLC_ICON:
					InitWithIconItems(withText);
				break;

				case ListCtrl.wxLC_SMALL_ICON:
					InitWithIconItems(withText, true);
				break;

				case ListCtrl.wxLC_REPORT:
					if ( (flags & ListCtrl.wxLC_VIRTUAL) > 0 )
						InitWithVirtualItems();
					else
						InitWithReportItems();
				break;

				default:
					writefln("unknown listctrl mode");
				break;
			}

			DoSize();

			m_logWindow.Clear();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnListView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_LIST);
		}
		
		//---------------------------------------------------------------------	

		public void InitWithListItems()
		{
			for ( int i = 0; i < NUM_ITEMS; i++ )
			{
				m_listCtrl.InsertItem(i, "Item " ~ .toString(i));
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnReportView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_REPORT);
		}
		
		//---------------------------------------------------------------------	

		public void InitWithReportItems()
		{
			m_listCtrl.SetImageList(m_imageListSmall, wxIMAGE_LIST_SMALL);

			ListItem itemCol = new ListItem();
			itemCol.Text = "Column 1";
			itemCol.Image = -1;
			m_listCtrl.InsertColumn(0, itemCol);
			
			itemCol.Text = "Column 2";
			itemCol.Align = ListCtrl.wxLIST_FORMAT_CENTRE;
			m_listCtrl.InsertColumn(1, itemCol);
			
			itemCol.Text = "Column 3";
			itemCol.Align = ListCtrl.wxLIST_FORMAT_RIGHT;
			m_listCtrl.InsertColumn(2, itemCol);
			
			m_listCtrl.Hide();
			
			for ( int i = 0; i < NUM_ITEMS; i++ )
			{
				m_listCtrl.InsertItemInReportView(i);
			}
			
			m_logWindow.WriteText(.toString(NUM_ITEMS) ~ " items inserted");
			m_listCtrl.Show();
			
			ListItem item = new ListItem();
			item.Id = 0;
			item.TextColour = Colour.wxRED;
			m_listCtrl.SetItem( item );
			
			item.Id = 2;
			item.TextColour = Colour.wxGREEN;
			m_listCtrl.SetItem( item );
			item.Id = 4;
			item.TextColour = Colour.wxLIGHT_GREY;
			item.font = Font.wxITALIC_FONT;
			item.BackgroundColour = Colour.wxRED;
			m_listCtrl.SetItem( item );
			
			m_listCtrl.TextColour = Colour.wxBLUE;
			m_listCtrl.BackgroundColour = Colour.wxLIGHT_GREY;
			
			m_listCtrl.SetColumnWidth( 0, ListCtrl.wxLIST_AUTOSIZE );
			m_listCtrl.SetColumnWidth( 1, ListCtrl.wxLIST_AUTOSIZE );
			m_listCtrl.SetColumnWidth( 2, ListCtrl.wxLIST_AUTOSIZE );
		}
		
		//---------------------------------------------------------------------	
		
		public void InitWithIconItems(bool withText)
		{
			InitWithIconItems(withText, false);
		}

		public void InitWithIconItems(bool withText, bool sameIcon)
		{
			m_listCtrl.SetImageList(m_imageListNormal, wxIMAGE_LIST_NORMAL);
			m_listCtrl.SetImageList(m_imageListSmall, wxIMAGE_LIST_SMALL);

			for ( int i = 0; i < NUM_ICONS; i++ )
			{
				int image = sameIcon ? 0 : i;

				if ( withText )
				{
					m_listCtrl.InsertItem(i, "Label " ~ .toString(i), image);
				}
				else
				{
					m_listCtrl.InsertItem(i, image);
				}
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnIconView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_ICON, false);
		}
		
		//---------------------------------------------------------------------	

		public void OnIconTextView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_ICON);
		}
		
		//---------------------------------------------------------------------	

		public void OnSmallIconView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_SMALL_ICON, false);
		}
		
		//---------------------------------------------------------------------	

		public void OnSmallIconTextView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_SMALL_ICON);
		}
		
		//---------------------------------------------------------------------	

		public void OnVirtualView(Object sender, Event e)
		{
			RecreateList(ListCtrl.wxLC_REPORT | ListCtrl.wxLC_VIRTUAL);
		}
		
		//---------------------------------------------------------------------	

		public void InitWithVirtualItems()
		{
			m_listCtrl.SetImageList(m_imageListSmall, wxIMAGE_LIST_SMALL);

			m_listCtrl.InsertColumn(0, _("First Column"));
			m_listCtrl.InsertColumn(1, _("Second Column"));
			m_listCtrl.SetColumnWidth(0, 150);
			m_listCtrl.SetColumnWidth(1, 150);

			m_listCtrl.ItemCount = 1000000;
		}
		
		//---------------------------------------------------------------------	
		
		public static extern(C) int MyCompareFunction(int item1, int item2, int sortData)
		{
			// inverse the order
			if (item1 < item2)
				return -1;
			if (item1 > item2)
				return 1;

			return 0;
		}
		
		//---------------------------------------------------------------------	

		public void OnSort(Object sender, Event e)
		{
			m_listCtrl.SortItems(&MyCompareFunction,0);
 
			m_logWindow.WriteText("Sorting " ~ .toString(m_listCtrl.ItemCount) ~ " items");
		}
		
		//---------------------------------------------------------------------	

		public void OnShowSelInfo(Object sender, Event e)
		{
			int selCount = m_listCtrl.SelectedItemCount;
			Log.LogMessage(.toString(selCount) ~" items selected:");

			int shownCount = 0;

			int item = m_listCtrl.GetNextItem(-1, ListCtrl.wxLIST_NEXT_ALL,
						ListCtrl.wxLIST_STATE_SELECTED);
			while ( item != -1 )
			{
				Log.LogMessage("\t" ~ .toString(item) ~ "d (" ~ m_listCtrl.GetItemText(item) ~ ")");

				if ( ++shownCount > 10 )
				{
					Log.LogMessage(_("\t... more selected items snipped..."));
					break;
				}

				item = m_listCtrl.GetNextItem(item, ListCtrl.wxLIST_NEXT_ALL,
					ListCtrl.wxLIST_STATE_SELECTED);
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnShowColInfo(Object sender, Event e)
		{
			int count = m_listCtrl.ColumnCount;
			Log.LogMessage(.toString(count) ~ " columns:");
			for ( int c = 0; c < count; c++ )
			{
				Log.LogMessage("\tcolumn " ~ .toString(c) ~ " has width " ~ .toString(m_listCtrl.GetColumnWidth(c)));
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnUpdateShowColInfo(Object sender, Event e)
		{
			UpdateUIEvent ue = cast(UpdateUIEvent)e;
		
			ue.Enabled =(m_listCtrl.StyleFlags & ListCtrl.wxLC_REPORT) != 0;
		}
		
		//---------------------------------------------------------------------	

		public void OnToggleMultiSel(Object sender, Event e)
		{
			long flags = m_listCtrl.StyleFlags;
			if ( (flags & ListCtrl.wxLC_SINGLE_SEL) > 0 )
				flags &= ~ListCtrl.wxLC_SINGLE_SEL;
			else
				flags |= ListCtrl.wxLC_SINGLE_SEL;

			m_logWindow.WriteText("Current selection mode: " ~ 
				( ( (flags & ListCtrl.wxLC_SINGLE_SEL) > 0 ) ? "sing" : "multip" ) ~ "le\n");

			RecreateList(flags);
		}
		
		//---------------------------------------------------------------------	

		public void OnUpdateToggleMultiSel(Object sender, Event e)
		{
			UpdateUIEvent ue = cast(UpdateUIEvent)e;
			
			ue.Check = (m_listCtrl.StyleFlags & ListCtrl.wxLC_SINGLE_SEL) == 0;
		}
		
		//---------------------------------------------------------------------	

		public void OnSetFgColour(Object sender, Event e)
		{
			m_listCtrl.ForegroundColour = GetColourFromUser(this);
			m_listCtrl.Refresh();
		}
		
		//---------------------------------------------------------------------	

		public void OnSetBgColour(Object sender, Event e)
		{
			m_listCtrl.BackgroundColour = GetColourFromUser(this);
			m_listCtrl.Refresh();
		}
		
		//---------------------------------------------------------------------	

		public void OnAdd(Object sender, Event e)
		{
			m_listCtrl.InsertItem(m_listCtrl.ItemCount, _("Appended item"));
		}
		
		//---------------------------------------------------------------------	

		public void OnEdit(Object sender, Event e)
		{
			int itemCur = m_listCtrl.GetNextItem(-1, ListCtrl.wxLIST_NEXT_ALL,
						ListCtrl.wxLIST_STATE_FOCUSED);

			if ( itemCur != -1 )
			{
				m_listCtrl.EditLabel(itemCur);
			}
			else
			{
				m_logWindow.WriteText(_("No item to edit"));
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnDelete(Object sender, Event e)
		{
			if ( m_listCtrl.ItemCount > 0 )
			{
				m_listCtrl.DeleteItem(0);
			}
			else
			{
				m_logWindow.WriteText(_("Nothing to delete"));
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnDeleteAll(Object sender, Event e)
		{

			m_listCtrl.DeleteAllItems();

			m_logWindow.WriteText("Deleted " ~ .toString(m_listCtrl.ItemCount) ~ " items\n");
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class MyListCtrl : ListCtrl
	{
		private ListItemAttr m_attr;
		
		//---------------------------------------------------------------------
		
		public this( Window parent, int id, Point pos, Size size, long style )
		{
			super( parent, id, pos, size, style );
			EVT_LIST_BEGIN_DRAG(Cmd.LIST_CTRL, &OnBeginDrag);
			EVT_LIST_BEGIN_RDRAG(Cmd.LIST_CTRL, &OnBeginRDrag);
			EVT_LIST_BEGIN_LABEL_EDIT(Cmd.LIST_CTRL, &OnBeginLabelEdit);
			EVT_LIST_END_LABEL_EDIT(Cmd.LIST_CTRL, &OnEndLabelEdit);
			EVT_LIST_DELETE_ITEM(Cmd.LIST_CTRL, &OnDeleteItem);
			EVT_LIST_DELETE_ALL_ITEMS(Cmd.LIST_CTRL, &OnDeleteAllItems);
			EVT_LIST_ITEM_SELECTED(Cmd.LIST_CTRL, &OnSelected);
			EVT_LIST_ITEM_DESELECTED(Cmd.LIST_CTRL, &OnDeselected);
			EVT_LIST_KEY_DOWN(Cmd.LIST_CTRL, &OnListKeyDown);
			EVT_LIST_ITEM_ACTIVATED(Cmd.LIST_CTRL, &OnActivated);
			EVT_LIST_ITEM_FOCUSED(Cmd.LIST_CTRL, &OnFocused);
			
			EVT_LIST_COL_CLICK(Cmd.LIST_CTRL, &OnColClick);
			EVT_LIST_COL_RIGHT_CLICK(Cmd.LIST_CTRL, &OnColRightClick);
			EVT_LIST_COL_BEGIN_DRAG(Cmd.LIST_CTRL, &OnColBeginDrag);
			EVT_LIST_COL_DRAGGING(Cmd.LIST_CTRL, &OnColDragging);
			EVT_LIST_COL_END_DRAG(Cmd.LIST_CTRL, &OnColEndDrag);
			
			EVT_LIST_CACHE_HINT(Cmd.LIST_CTRL, &OnCacheHint);
			
			EVT_CHAR(&OnChar);
		}
		
		//---------------------------------------------------------------------	
		
		public void OnCacheHint(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
			
			Log.LogMessage( "OnCacheHint: cache items " ~ .toString(le.CacheFrom) ~ ".." ~ .toString(le.CacheTo) );
		}
		
		//---------------------------------------------------------------------	

		public void SetColumnImage(int col, int image)
		{
			ListItem item = new ListItem();
			item.Mask = ListCtrl.wxLIST_MASK_IMAGE;
			item.Image = image;
			SetColumn(col, item);
		}
		
		//---------------------------------------------------------------------	

		public void OnColClick(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
			
			int col = le.Column;
			SetColumnImage(col, 0);

			Log.LogMessage( "OnColumnClick at " ~ .toString(col) ~ "." );
		}
		
		//---------------------------------------------------------------------	

		public void OnColRightClick(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
		
			int col = le.Column;
			if ( col != -1 )
			{
				SetColumnImage(col, -1);
			}

			Menu menu = new Menu("Test");
			menu.Append(Cmd.LIST_ABOUT, _("&About"));
			PopupMenu(menu, le.point); 

			Log.LogMessage( "OnColumnRightClick at " ~ .toString(le.Column) ~ "." );
		}
		
		//---------------------------------------------------------------------	

		public void LogColEvent(Object sender, Event e, string name)
		{
			ListEvent le = cast(ListEvent)e;
		
			int col = le.Column;
			
			string msg = name ~ ": column ";
			msg ~= .toString(col) ~ "(width = ";
			msg ~= .toString(le.Item.Width) ~ " or ";
			msg ~= .toString(GetColumnWidth(col)) ~ ".";

			Log.LogMessage( msg );
		}
		
		//---------------------------------------------------------------------	

		public void OnColBeginDrag(Object sender, Event e)
		{
			LogColEvent( sender, e, "OnColBeginDrag" );
			
			ListEvent le = cast(ListEvent)e;

			if ( le.Column == 0 )
			{
				Log.LogMessage("Resizing this column shouldn't work.");

				le.Veto();
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnColDragging(Object sender, Event e)
		{
			LogColEvent( sender, e, "OnColDragging" );
		}
		
		//---------------------------------------------------------------------	

		public void OnColEndDrag(Object sender, Event e)
		{
			LogColEvent( sender, e, "OnColEndDrag" );
		}
		
		//---------------------------------------------------------------------	

		public void OnBeginDrag(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
		
			Point pt = le.point;

			int flags = 0;
			Log.LogMessage( "OnBeginDrag at (" ~ .toString(pt.X) ~ ", " ~ .toString(pt.Y) ~ "), item " ~ .toString(HitTest(pt, flags)) ~ ".");
		}
		
		//---------------------------------------------------------------------	

		public void OnBeginRDrag(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
		
			Log.LogMessage( "OnBeginRDrag at " ~ .toString(le.point.X) ~ "," ~ .toString(le.point.Y) ~ ".");
		}
		
		//---------------------------------------------------------------------	

		public void OnBeginLabelEdit(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
				
			Log.LogMessage( "OnBeginLabelEdit: " ~ le.Item.Text);
		}
		
		//---------------------------------------------------------------------	

		public void OnEndLabelEdit(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
		
			Log.LogMessage( "OnEndLabelEdit: " ~
				(le.EditCancelled ? "[cancelled]" : le.Item.Text) );
		}
		
		//---------------------------------------------------------------------	

		public void OnDeleteItem(Object sender, Event e)
		{
			LogEvent(sender, e, "OnDeleteItem");
		}
		
		//---------------------------------------------------------------------	

		public void OnDeleteAllItems(Object sender, Event e)
		{
			LogEvent(sender, e, "OnDeleteAllItems");
		}
	
		//---------------------------------------------------------------------	

		public void OnSelected(Object sender, Event e)
		{
			LogEvent(sender, e, "OnSelected");
			
			ListEvent le = cast(ListEvent)e;

			if ( (StyleFlags & ListCtrl.wxLC_REPORT) > 0 )
			{
				ListItem info = new ListItem();
				info.Id = le.Index;
				info.Column = 1;
				info.Mask = ListCtrl.wxLIST_MASK_TEXT;
				if ( GetItem(info) )
				{
					Log.LogMessage("Value of the 2nd field of the selected item: " ~
						info.Text);
				}
				else
				{
					writefln("wxListCtrl::GetItem() failed");
				}
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnDeselected(Object sender, Event e)
		{
			LogEvent(sender, e, "OnDeselected");
		}
		
		//---------------------------------------------------------------------	

		public void OnActivated(Object sender, Event e)
		{
			LogEvent(sender, e, "OnActivated");
		}
		
		//---------------------------------------------------------------------	

		public void OnFocused(Object sender, Event e)
		{
			LogEvent(sender, e, "OnFocused");

			e.Skip();
		}
		
		//---------------------------------------------------------------------	

		public void OnListKeyDown(Object sender, Event e)
		{
			ListEvent le = cast(ListEvent)e;
		
			switch ( le.KeyCode )
			{
				case 'c': // colorize
				case 'C':
				{
					ListItem info = new ListItem();
					info.Id = le.Index;
					GetItem(info);

					ListItemAttr attr = info.Attributes;
					if ( attr == null || !attr.HasTextColour )
					{
						info.TextColour = Colour.wxCYAN;

						SetItem(info);

						RefreshItem(info.Id);
					}
				}
				break;

				case 'n': // next
				case 'N':
				{
					int item = GetNextItem(-1,
						ListCtrl.wxLIST_NEXT_ALL, ListCtrl.wxLIST_STATE_FOCUSED);
					if ( item++ == ItemCount - 1 )
					{
						item = 0;
					}

					Log.LogMessage("Focusing item " ~ .toString(item));

					SetItemState(item, ListCtrl.wxLIST_STATE_FOCUSED, ListCtrl.wxLIST_STATE_FOCUSED);
					EnsureVisible(item);
				}
				break;

				case KeyCode.WXK_DELETE:
				{
					int item = GetNextItem(-1,
						ListCtrl.wxLIST_NEXT_ALL, ListCtrl.wxLIST_STATE_SELECTED);
					while ( item != -1 )
					{
						DeleteItem(item);

						Log.LogMessage("Item " ~ .toString(item) ~ " deleted");

						// -1 because the indices were shifted by DeleteItem()
						item = GetNextItem(item - 1,
							ListCtrl.wxLIST_NEXT_ALL, ListCtrl.wxLIST_STATE_SELECTED);
					}
				}
				break;

				case KeyCode.WXK_INSERT:
					if ( (StyleFlags & ListCtrl.wxLC_REPORT) > 0 )
					{
						if ( (StyleFlags & ListCtrl.wxLC_VIRTUAL) > 0 )
						{
							ItemCount = ItemCount + 1;
						}
						else // !virtual
						{
							InsertItemInReportView(le.Index);
						}
					}
					//else: fall through
				break; //???

				default:
					LogEvent(sender, e, "OnListKeyDown");

					le.Skip();
				break;
			}
		}
		
		//---------------------------------------------------------------------	

		public void OnChar(Object sender, Event e)
		{
			KeyEvent ke = cast(KeyEvent)e;
		
			Log.LogMessage("Got char event.");
	
			switch ( ke.KeyCode )
			{
				case 'n':
				case 'N':
				case 'c':
				case 'C':
				// these are the keys we process ourselves
				break;

				default:
					e.Skip();
				break;
			}
		}
	
		//---------------------------------------------------------------------	

		public void LogEvent(Object sender, Event e, string eventName)
		{
			ListEvent le = cast(ListEvent)e;
		
			Log.LogMessage("Item " ~ .toString(le.Index) ~ ": " ~ eventName ~ " (item text = " ~ le.Text ~
				 ", data = " ~ .toString(le.Data) ~ ")");
		}
		
		//---------------------------------------------------------------------	

		public string OnGetItemText(long item, long column)
		{
			string s = "Column " ~ .toString(column) ~ " of item " ~ .toString(item);
			return s;
		}
		
		//---------------------------------------------------------------------	

		public int OnGetItemImage(long item)
		{
			return 0;
		}
		
		//---------------------------------------------------------------------	

		public ListItemAttr OnGetItemAttr(long item)
		{
			return (item % 2) > 0 ? null : m_attr;
		}
		
		//---------------------------------------------------------------------	
		
		public void InsertItemInReportView(int i)
		{
			string buf = "This is item " ~ .toString(i);
			int tmp = InsertItem(i, buf, 0);
			SetItemData(tmp, i);

			buf = "Col 1, item " ~ .toString(i);
			SetItem(i, 1, buf);

			buf = "Item " ~ .toString(i) ~ " in column 2";
			SetItem(i, 2, buf);
		}
	}
	
	//---------------------------------------------------------------------	

	public class ListCtrlApp : App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("ListCtrl Test", Point(50, 50), Size(450,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			ListCtrlApp app = new ListCtrlApp();
			app.Run();
		}
	}


void main()
{
	ListCtrlApp.Main();
}
