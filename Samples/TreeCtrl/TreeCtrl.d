//-----------------------------------------------------------------------------
// wx.NET/Samples - TreeCtrl.cs
//
// A wx.NET version of the wxWidgets "treectrl" sample.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Text;

namespace wx.Samples
{
	public class TreeTestApp : wx.App
	{
		static bool showImages = true;
// 		static bool showButtons = false;

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			TreeTestApp app = new TreeTestApp();
			app.Run();
		}

		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("TreeCtrl Test", new Point(50,50), new Size(450,600));
			frame.Show(true);
			return true;
		}

		//---------------------------------------------------------------------

		public static bool ShowImages
		{
			get { return showImages; }
			set { showImages = value; }
		}
		
		//---------------------------------------------------------------------

// 		public static bool ShowButtons
// 		{
// 			get { return showButtons; }
// 			set { showButtons = value; }
// 		}
	}

	//---------------------------------------------------------------------

	public class MyFrame : wx.Frame
	{
		public enum Cmd 
		{
			TreeTest_Quit,
			TreeTest_About,
			TreeTest_TogButtons,
			TreeTest_TogTwist,
			TreeTest_TogLines,
			TreeTest_TogEdit,
			TreeTest_TogHideRoot,
			TreeTest_TogRootLines,
			TreeTest_TogBorder,
			TreeTest_TogFullHighlight,
			TreeTest_SetFgColour,
			TreeTest_SetBgColour,
			TreeTest_ResetStyle,
			TreeTest_Dump,
			TreeTest_DumpSelected,
			TreeTest_Count,
			TreeTest_CountRec,
			TreeTest_Sort,
			TreeTest_SortRev,
			TreeTest_SetBold,
			TreeTest_ClearBold,
			TreeTest_Rename,
			TreeTest_Delete,
			TreeTest_DeleteChildren,
			TreeTest_DeleteAll,
			TreeTest_Recreate,
			TreeTest_ToggleImages,
			TreeTest_ToggleButtons,
			TreeTest_SetImageSize,
			TreeTest_ToggleSel,
			TreeTest_CollapseAndReset,
			TreeTest_EnsureVisible,
			TreeTest_AddItem,
			TreeTest_InsertItem,
			TreeTest_IncIndent,
			TreeTest_DecIndent,
			TreeTest_IncSpacing,
			TreeTest_DecSpacing,
			TreeTest_ToggleIcon,
			TreeTest_Select,
			TreeTest_Unselect,
			TreeTest_SelectRoot,
			TreeTest_Ctrl = 1000
		}

		private MyTreeCtrl m_treeCtrl;
		
		public TextCtrl m_textCtrl;
		
		public static int s_num = 0;

		//---------------------------------------------------------------------

		public MyFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			BackgroundColour = new Colour(255, 255, 255);
		
			Icon = new wx.Icon("../Samples/TreeCtrl/mondrian.png");

			// Set up a menu

			wx.Menu fileMenu = new wx.Menu();
			wx.Menu style_menu = new wx.Menu();
			wx.Menu tree_menu = new wx.Menu();
			wx.Menu item_menu = new wx.Menu();

			fileMenu.Append((int)Cmd.TreeTest_About, "&About...\tF1");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.TreeTest_Quit, "E&xit\tAlt-X");
			
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogButtons, "Toggle &normal buttons");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogTwist, "Toggle &twister buttons");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_ToggleButtons, "Toggle image &buttons");
			style_menu.AppendSeparator();
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogLines, "Toggle &connecting lines");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogRootLines, "Toggle &lines at root");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogHideRoot, "Toggle &hidden root");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogBorder, "Toggle &item border");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogFullHighlight, "Toggle &full row highlight");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_TogEdit, "Toggle &edit mode");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_ToggleSel, "Toggle &selection mode");
			style_menu.AppendCheckItem((int)Cmd.TreeTest_ToggleImages, "Toggle show ima&ges");
			style_menu.Append((int)Cmd.TreeTest_SetImageSize, "Set image si&ze...");
			style_menu.AppendSeparator();
			style_menu.Append((int)Cmd.TreeTest_SetFgColour, "Set &foreground colour...");
			style_menu.Append((int)Cmd.TreeTest_SetBgColour, "Set &background colour...");
			style_menu.AppendSeparator();
			style_menu.Append((int)Cmd.TreeTest_ResetStyle, "&Reset to default\tF10");

			tree_menu.Append((int)Cmd.TreeTest_Recreate, "&Recreate the tree");
			tree_menu.Append((int)Cmd.TreeTest_CollapseAndReset, "C&ollapse and reset");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_AddItem, "Append a &new item");
			tree_menu.Append((int)Cmd.TreeTest_InsertItem, "&Insert a new item");
			tree_menu.Append((int)Cmd.TreeTest_Delete, "&Delete this item");
			tree_menu.Append((int)Cmd.TreeTest_DeleteChildren, "Delete &children");
			tree_menu.Append((int)Cmd.TreeTest_DeleteAll, "Delete &all items");
			tree_menu.Append((int)Cmd.TreeTest_SelectRoot, "Select root item");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_Count, "Count children of current item");
			tree_menu.Append((int)Cmd.TreeTest_CountRec, "Recursively count children of current item");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_Sort, "Sort children of current item");
			tree_menu.Append((int)Cmd.TreeTest_SortRev, "Sort in reversed order");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_EnsureVisible, "Make the last item &visible");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_IncIndent, "Add 5 points to indentation\tAlt-I");
			tree_menu.Append((int)Cmd.TreeTest_DecIndent, "Reduce indentation by 5 points\tAlt-R");
			tree_menu.AppendSeparator();
			tree_menu.Append((int)Cmd.TreeTest_IncSpacing, "Add 5 points to spacing\tCtrl-I");
			tree_menu.Append((int)Cmd.TreeTest_DecSpacing, "Reduce spacing by 5 points\tCtrl-R");

			item_menu.Append((int)Cmd.TreeTest_Dump, "&Dump item children");
			item_menu.Append((int)Cmd.TreeTest_Rename, "&Rename item...");

			item_menu.AppendSeparator();
			item_menu.Append((int)Cmd.TreeTest_SetBold, "Make item &bold");
			item_menu.Append((int)Cmd.TreeTest_ClearBold, "Make item &not bold");
			item_menu.AppendSeparator();
			item_menu.Append((int)Cmd.TreeTest_ToggleIcon, "Toggle the item's &icon");

			item_menu.AppendSeparator();
			item_menu.Append((int)Cmd.TreeTest_DumpSelected, "Dump selected items\tAlt-D");
			item_menu.Append((int)Cmd.TreeTest_Select, "Select current item\tAlt-S");
			item_menu.Append((int)Cmd.TreeTest_Unselect, "Unselect everything\tAlt-U");

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(style_menu, "&Style");
			menuBar.Append(tree_menu, "&Tree");
			menuBar.Append(item_menu, "&Item");
			MenuBar = menuBar;
			
			m_textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxSUNKEN_BORDER);

			// Set up a status bar

			CreateStatusBar(2);
			StatusText = "";

			// Create the default tree control

			CreateTreeWithDefaultStyle();
			
			menuBar.Check((int)Cmd.TreeTest_ToggleImages, true);
			
			Log.SetActiveTarget( m_textCtrl ); 

			// Set up the event table

			EVT_MENU((int)Cmd.TreeTest_Quit,  new EventListener(OnQuit));
			EVT_MENU((int)Cmd.TreeTest_About, new EventListener(OnAbout));
			
			EVT_MENU((int)Cmd.TreeTest_TogButtons, new EventListener(OnTogButtons));
			EVT_MENU((int)Cmd.TreeTest_Rename, new EventListener(OnRename));
			EVT_MENU((int)Cmd.TreeTest_Count, new EventListener(OnCount));
			EVT_MENU((int)Cmd.TreeTest_CountRec, new EventListener(OnCountRec));
			EVT_MENU((int)Cmd.TreeTest_Dump, new EventListener(OnDump));
			EVT_MENU((int)Cmd.TreeTest_ToggleSel, new EventListener(OnToggleSel));
			EVT_MENU((int)Cmd.TreeTest_DumpSelected, new EventListener(OnDumpSelected));
			EVT_MENU((int)Cmd.TreeTest_Select, new EventListener(OnSelect));
			EVT_MENU((int)Cmd.TreeTest_SelectRoot, new EventListener(OnSelectRoot));
			EVT_MENU((int)Cmd.TreeTest_Unselect, new EventListener(OnUnselect));
			EVT_MENU((int)Cmd.TreeTest_SetBold, new EventListener(OnSetBold));
			EVT_MENU((int)Cmd.TreeTest_ClearBold, new EventListener(OnClearBold));
			EVT_MENU((int)Cmd.TreeTest_Delete, new EventListener(OnDelete));
			EVT_MENU((int)Cmd.TreeTest_DeleteChildren, new EventListener(OnDeleteChildren));
			EVT_MENU((int)Cmd.TreeTest_DeleteAll, new EventListener(OnDeleteAll));
			EVT_MENU((int)Cmd.TreeTest_Recreate, new EventListener(OnRecreate));
			EVT_MENU((int)Cmd.TreeTest_SetImageSize, new EventListener(OnSetImageSize));
			EVT_MENU((int)Cmd.TreeTest_ToggleImages, new EventListener(OnToggleImages));
			EVT_MENU((int)Cmd.TreeTest_CollapseAndReset, new EventListener(OnCollapseAndReset));
			EVT_MENU((int)Cmd.TreeTest_EnsureVisible, new EventListener(OnEnsureVisible));
			EVT_MENU((int)Cmd.TreeTest_InsertItem, new EventListener(OnInsertItem));
			EVT_MENU((int)Cmd.TreeTest_AddItem, new EventListener(OnAddItem));
			EVT_MENU((int)Cmd.TreeTest_IncIndent, new EventListener(OnIncIndent));
			EVT_MENU((int)Cmd.TreeTest_DecIndent, new EventListener(OnDecIndent));
			EVT_MENU((int)Cmd.TreeTest_IncSpacing, new EventListener(OnIncSpacing));
			EVT_MENU((int)Cmd.TreeTest_DecSpacing, new EventListener(OnDecSpacing));
			EVT_MENU((int)Cmd.TreeTest_ToggleIcon, new EventListener(OnToggleIcon));
			EVT_MENU((int)Cmd.TreeTest_SetFgColour, new EventListener(OnSetFgColour));
			EVT_MENU((int)Cmd.TreeTest_SetBgColour, new EventListener(OnSetBgColour));
			
			EVT_MENU((int)Cmd.TreeTest_Sort, new EventListener(OnSort));
			EVT_MENU((int)Cmd.TreeTest_SortRev, new EventListener(OnSortRev));
			
			EVT_IDLE( new EventListener(OnIdle) );
			
			EVT_SIZE( new EventListener(OnSize) );
		}
		
		//---------------------------------------------------------------------
		
		~MyFrame()
		{
			Log.SetActiveTarget(null);
		}

		//---------------------------------------------------------------------

		public void CreateTreeWithDefaultStyle()
		{
			long style = TreeCtrl.wxTR_DEFAULT_STYLE | TreeCtrl.wxTR_EDIT_LABELS;
			CreateTree(style | (long) Border.wxBORDER_SUNKEN);
			
			MenuBar mbar = MenuBar;
			
			mbar.Check((int)Cmd.TreeTest_TogButtons, (style & TreeCtrl.wxTR_HAS_BUTTONS) != 0);
			mbar.Check((int)Cmd.TreeTest_TogButtons, (style & TreeCtrl.wxTR_TWIST_BUTTONS) != 0);
			mbar.Check((int)Cmd.TreeTest_TogLines, (style & TreeCtrl.wxTR_NO_LINES) == 0);
			mbar.Check((int)Cmd.TreeTest_TogRootLines, (style & TreeCtrl.wxTR_LINES_AT_ROOT) != 0);
			mbar.Check((int)Cmd.TreeTest_TogHideRoot, (style & TreeCtrl.wxTR_HIDE_ROOT) != 0);
			mbar.Check((int)Cmd.TreeTest_TogEdit, (style & TreeCtrl.wxTR_EDIT_LABELS) != 0);
			mbar.Check((int)Cmd.TreeTest_TogBorder, (style & TreeCtrl.wxTR_ROW_LINES) != 0);
			mbar.Check((int)Cmd.TreeTest_TogFullHighlight, (style & TreeCtrl.wxTR_FULL_ROW_HIGHLIGHT) != 0);
		}

		//---------------------------------------------------------------------

		public void CreateTree(long style)
		{
			m_treeCtrl = new MyTreeCtrl(this, (int)Cmd.TreeTest_Ctrl, wxDefaultPosition, wxDefaultSize, style);
			Resize();
		}
		
		//---------------------------------------------------------------------
		
		public void TogStyle(int id, long flag)
		{
			long style = m_treeCtrl.WindowStyle ^ flag;
			//delete m_treeCtrl;
			CreateTree(style);

			MenuBar.Check(id, (style & flag) != 0);
		}

		//---------------------------------------------------------------------
		
		public void OnIdle(object sender, Event e)
		{
			if (m_treeCtrl != null)
			{
				TreeItemId idRoot = m_treeCtrl.RootItem;
			
				string s = "Root/last item is ";
				s += m_treeCtrl.IsVisible(idRoot) ? "" : "not ";
				s += "visible/";
				s += m_treeCtrl.IsVisible(m_treeCtrl.GetLastChild(idRoot)) ? "" : "not ";
				s += "visible";
				
				SetStatusText(s, 1);
			}
		      
			e.Skip();
		}
		
		//---------------------------------------------------------------------

		public void OnQuit(object sender, wx.Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnAbout(object sender, wx.Event e)
		{
			string msg = "Tree test sample\n(c) Julian Smart 1997, Vadim Zeitlin 1998\nPorted to wx.NET by Jason Perkins and Alexander Olk";
			wx.MessageDialog.ShowModal(this, msg, "About Tree Test", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------

		public void Resize()
		{
			Size size = ClientSize;
			m_treeCtrl.SetSize(0, 0, size.Width, size.Height * 2/3);
			m_textCtrl.SetSize(0, 2 * size.Height/3, size.Width, size.Height/3);
		}

		//---------------------------------------------------------------------
		
		public void OnTogButtons(object sender, Event e)
		{
			TogStyle(e.ID, TreeCtrl.wxTR_HAS_BUTTONS);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSize(object sender, Event e)
		{
			if ( m_treeCtrl != null && m_textCtrl != null )
			{
				Resize();
			}

			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnRename(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.EditLabel(item);
		}
		
		//---------------------------------------------------------------------
		
		public void OnCount(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			int i = m_treeCtrl.GetChildrenCount( item, false );

			Log.LogMessage(i + " children");
		}
		
		//---------------------------------------------------------------------
		
		public void OnCountRec(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			int i = m_treeCtrl.GetChildrenCount( item );

			Log.LogMessage(i + " children");
		}
		
		//---------------------------------------------------------------------
		
		public void OnDump(object sender, Event e)
		{
			TreeItemId root = m_treeCtrl.Selection;
			
			CHECK_ITEM( root );

			m_treeCtrl.GetItemsRecursively(root, IntPtr.Zero);
		}
		
		//---------------------------------------------------------------------
		
		public void OnToggleSel(object sender, Event e)
		{
			TogStyle(e.ID, TreeCtrl.wxTR_MULTIPLE);
		}
		
		//---------------------------------------------------------------------
		
		public void OnDumpSelected(object sender, Event e)
		{
			TreeItemId[] array = m_treeCtrl.Selections();

			int count = array.Length;
			
			Log.LogMessage(count +" items selected");

			for ( int n = 0; n < count; n++ )
			{
				Log.LogMessage(m_treeCtrl.GetItemText(array[n]));
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelect(object sender, Event e)
		{
			m_treeCtrl.SelectItem(m_treeCtrl.Selection);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectRoot(object sender, Event e)
		{
			m_treeCtrl.SelectItem(m_treeCtrl.RootItem);
		}

		//---------------------------------------------------------------------

		public void OnUnselect(object sender, Event e)
		{
			m_treeCtrl.UnselectAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetBold(object sender, Event e)
		{
			DoSetBold(true);
		}
		
		//---------------------------------------------------------------------
		
		public void OnClearBold(object sender, Event e)
		{
			DoSetBold(false);
		}
		
		//---------------------------------------------------------------------
		
		public void DoSetBold(bool bold)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.SetItemBold(item, bold);
		}
		
		//---------------------------------------------------------------------
		
		public void OnDelete(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.Delete(item);
		}

		//---------------------------------------------------------------------

		public void OnDeleteChildren(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.DeleteChildren(item);
		}

		//---------------------------------------------------------------------

		public void OnDeleteAll(object sender, Event e)
		{
			m_treeCtrl.DeleteAllItems();
		}

		//---------------------------------------------------------------------

		public void OnRecreate(object sender, Event e)
		{
			OnDeleteAll(this, e);
			m_treeCtrl.AddTestItemsToTree(5, 2);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetImageSize(object sender, Event e)
		{
			int size = GetNumberFromUser("Enter the size for the images to use",
					"Size: ",
					"TreeCtrl sample",
					m_treeCtrl.ImageSize);
			if ( size == -1 )
				return;

			m_treeCtrl.CreateImageList(size);
			TreeTestApp.ShowImages = true;
		}
		
		//---------------------------------------------------------------------

		public void OnToggleImages(object sender, Event e)
		{
			if ( TreeTestApp.ShowImages )
			{
				m_treeCtrl.CreateImageList(-1);
				TreeTestApp.ShowImages = false;
			}
			else
			{
				m_treeCtrl.CreateImageList(0);
				TreeTestApp.ShowImages = true;
			}
		}
		
		//---------------------------------------------------------------------
		
// 		public void OnToggleButtons(object sender, Event e)
// 		{
// 			if ( TreeTestApp.ShowButtons )
// 			{
// 				m_treeCtrl.CreateButtonsImageList(-1);
// 				TreeTestApp.ShowButtons = false;
// 			}
// 			else
// 			{
// 				m_treeCtrl.CreateButtonsImageList(15);
// 				TreeTestApp.ShowButtons = true;
// 			}
// 		}

		//---------------------------------------------------------------------
		
		public void OnCollapseAndReset(object sender, Event e)
		{
			m_treeCtrl.CollapseAndReset(m_treeCtrl.RootItem);
		}

		//---------------------------------------------------------------------

		public void OnEnsureVisible(object sender, Event e)
		{
			m_treeCtrl.DoEnsureVisible();
		}

		//---------------------------------------------------------------------

		public void OnInsertItem(object sender, Event e)
		{
			int image = TreeTestApp.ShowImages ? (int)MyTreeCtrl.TreeIcon.File : -1;
			m_treeCtrl.InsertItem(m_treeCtrl.RootItem, image, "2nd item");
		}

		//---------------------------------------------------------------------

		public void OnAddItem(object sender, Event e)
		{
			string text = "Item #" + (++s_num);

			m_treeCtrl.AppendItem(m_treeCtrl.RootItem, text);
		}

		//---------------------------------------------------------------------

		public void OnIncIndent(object sender, Event e)
		{
			uint indent = m_treeCtrl.Indent;
			if (indent < 100)
				m_treeCtrl.Indent = indent + 5;
		}

		//---------------------------------------------------------------------

		public void OnDecIndent(object sender, Event e)
		{
			uint indent = m_treeCtrl.Indent;
			if (indent > 10)
				m_treeCtrl.Indent = indent-5;
		}

		//---------------------------------------------------------------------

		public void OnIncSpacing(object sender, Event e)
		{
			uint indent = m_treeCtrl.Spacing;
			if (indent < 100)
				m_treeCtrl.Spacing = indent + 5;
		}

		//---------------------------------------------------------------------

		public void OnDecSpacing(object sender, Event e)
		{
			uint indent = m_treeCtrl.Spacing;
			if (indent > 10)
				m_treeCtrl.Spacing = indent - 5;
		}

		//---------------------------------------------------------------------

		public void OnToggleIcon(object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.DoToggleIcon(item);
		}
		
		//---------------------------------------------------------------------

		public void OnSetFgColour(object sender, Event e)
		{
			Colour col = ColourDialog.GetColourFromUser(this, m_treeCtrl.ForegroundColour);
			if ( col.Ok() )
				m_treeCtrl.ForegroundColour = col;
		}

		//---------------------------------------------------------------------

		public void OnSetBgColour(object sender, Event e)
		{
			Colour col = ColourDialog.GetColourFromUser(this, m_treeCtrl.BackgroundColour);
			if ( col.Ok() )
				m_treeCtrl.BackgroundColour = col;
		}

		
		//---------------------------------------------------------------------
		
		public void OnSort(object sender, Event e)
		{
			DoSort(false);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSortRev(object sender, Event e)
		{
			DoSort(true);
		}
		
		//---------------------------------------------------------------------
		
		public void DoSort(bool reverse)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.DoSortChildren(item, reverse);
		}
		
		//---------------------------------------------------------------------
		
		public void CHECK_ITEM(TreeItemId item)
		{
			if ( !item.IsOk() ) 
			{                                 
				MessageDialog.ShowModal(this, "Please select some item first!", 
						"Tree sample error",              
						Dialog.wxOK | Dialog.wxICON_EXCLAMATION);
				return;                                             
			}
		}
	}

	//---------------------------------------------------------------------

	public class MyTreeCtrl : wx.TreeCtrl
	{
		public enum TreeIcon
		{
			File,
			FileSelected,
			Folder,
			FolderSelected,
			FolderOpened
		};

		TreeItemId m_lastItem;
		TreeItemId m_draggedItem;
		int        imageSize;
		
		bool m_reverseSort;

		//---------------------------------------------------------------------

		public MyTreeCtrl(Window parent, int id, Point pos, Size size, long style)
			: base(parent, id, pos, size, style)
		{
			CreateImageList(16);
			AddTestItemsToTree(5, 2);
			
			EVT_TREE_BEGIN_DRAG((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnBeginDrag));
			EVT_TREE_BEGIN_RDRAG((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnBeginRDrag));
			EVT_TREE_END_DRAG((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnEndDrag));
			EVT_TREE_BEGIN_LABEL_EDIT((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnBeginLabelEdit));
			EVT_TREE_END_LABEL_EDIT((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnEndLabelEdit));
			EVT_TREE_DELETE_ITEM((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnDeleteItem));
			EVT_TREE_SET_INFO((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnSetInfo));
			EVT_TREE_ITEM_EXPANDED((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnItemExpanded));
			EVT_TREE_ITEM_EXPANDING((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnItemExpanding));
			EVT_TREE_ITEM_COLLAPSED((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnItemCollapsed));
			EVT_TREE_ITEM_COLLAPSING((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnItemCollapsing));

			EVT_CONTEXT_MENU(new EventListener(OnContextMenu));
			EVT_TREE_SEL_CHANGED((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnSelChanged));
			EVT_TREE_SEL_CHANGING((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnSelChanging));
			EVT_TREE_KEY_DOWN((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnTreeKeyDown));
			EVT_TREE_ITEM_ACTIVATED((int)MyFrame.Cmd.TreeTest_Ctrl, new EventListener(OnItemActivated));
			EVT_RIGHT_DCLICK(new EventListener(OnRMouseDClick));
		}

		//---------------------------------------------------------------------

		public void CreateImageList(int size)
		{
			if (size == -1)      // signal to turn off images
			{
				SetImageList(null);
				return;
			}

			if (size == 0)       // signal to turn on images
				size = imageSize;
			else
				imageSize = size;

			/* wxBusyCursor wait; */

			wx.ImageList images = new wx.ImageList(size, size);

			for (int i = 0; i < 5; ++i)
			{
				Image image = new wx.Image("../Samples/TreeCtrl/icon" + i + ".png");
				images.Add(new wx.Bitmap(image.Rescale(size, size)));
			}

			AssignImageList(images);
		}

		//---------------------------------------------------------------------

		public void AddItemsRecursively(TreeItemId idParent, int numChildren, int depth, int folder)
		{
			if (depth > 0)
			{
				bool hasChildren = depth > 1;

				StringBuilder str = new StringBuilder();
				for (int n = 0; n < numChildren; ++n)
				{
					str.Length = 0;

					// at depth 1 elements won't have any more children
					if (hasChildren)
						str.AppendFormat("{0} child {1}", "Folder", n + 1);
					else
						str.AppendFormat("{0} child {1}.{2}", "File", folder, n + 1);

					// here we pass to AppendItem() normal and selected item images (we
					// suppose that selected image follows the normal one in the enum)

					int image, imageSel;
					if (TreeTestApp.ShowImages)
					{
						image = (depth == 1) ? (int)TreeIcon.File : (int)TreeIcon.Folder;
						imageSel = image + 1;
					}
					else
					{
						image = -1;
						imageSel = -1;
					}

					TreeItemId id = AppendItem(idParent, str.ToString(), image, imageSel,
						new MyTreeItemData(str.ToString()));

					// and now we also set the expanded one (only for the folders)

					if (hasChildren && TreeTestApp.ShowImages)
					{
						SetItemImage(id, (int)TreeIcon.FolderOpened, TreeItemIcon.wxTreeItemIcon_Expanded);
					}

					// remember the last child for OnEnsureVisible()

					if (!hasChildren && n == numChildren - 1)
					{
						m_lastItem = id;
					}

					AddItemsRecursively(id, numChildren, depth - 1, n + 1);
				}
			}
		}

		//---------------------------------------------------------------------

		public void AddTestItemsToTree(int numChildren, int depth)
		{
			int image = TreeTestApp.ShowImages ? (int)TreeIcon.Folder : -1;
			TreeItemId rootId = AddRoot("Root", image, image,
				new MyTreeItemData("Root item"));
			if (image != -1)
				SetItemImage(rootId, (int)TreeIcon.FolderOpened, wx.TreeItemIcon.wxTreeItemIcon_Expanded);

			AddItemsRecursively(rootId, numChildren, depth, 0);
			
			SetItemFont(rootId, Font.wxITALIC_FONT);
			
			IntPtr cookie = IntPtr.Zero;
			TreeItemId id = GetFirstChild(rootId, ref cookie);
			SetItemTextColour(id, Colour.wxBLUE);

			id = GetNextChild(rootId, ref cookie);
			id = GetNextChild(rootId, ref cookie);
			SetItemTextColour(id, Colour.wxRED);
			SetItemBackgroundColour(id, Colour.wxLIGHT_GREY);
		}
		
		//---------------------------------------------------------------------
		
		public void GetItemsRecursively(TreeItemId idParent, IntPtr cookie)
		{
			TreeItemId id;

			if ( cookie == IntPtr.Zero )
				id = GetFirstChild(idParent, ref cookie);
			else
				id = GetNextChild(idParent, ref cookie);

			if ( !id.IsOk() )
				return;

			string text = GetItemText(id);
			Log.LogMessage(text);

			if ( ItemHasChildren(id) )
				GetItemsRecursively(id, IntPtr.Zero);

			GetItemsRecursively(idParent, cookie);
		}
		
		//---------------------------------------------------------------------
		
		public int ImageSize
		{
			get { return imageSize; }
		}
		
		//---------------------------------------------------------------------
		
		public void DoEnsureVisible()
		{
			if (m_lastItem.IsOk()) 
				EnsureVisible(m_lastItem);
		}
		
		//---------------------------------------------------------------------
		
		public void DoToggleIcon(TreeItemId item)
		{
			int image = GetItemImage(item);
			image = image == (int)TreeIcon.Folder ? (int)TreeIcon.File
								: (int)TreeIcon.Folder;

			SetItemImage(item, image);
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginDrag(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
		
			if ( te.Item != RootItem )
			{
				m_draggedItem = te.Item;

				Log.LogMessage("OnBeginDrag: started dragging " + GetItemText(m_draggedItem));

				te.Allow();
			}
			else
			{
				Log.LogMessage("OnBeginDrag: this item can't be dragged.");
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginRDrag(object sender, Event e)
		{
			Log.LogMessage("OnBeginRDrag");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnEndDrag(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
			
			TreeItemId itemSrc = m_draggedItem;
			TreeItemId itemDst = te.Item;
			//m_draggedItem = (wxTreeItemId)0l;

			if ( itemDst.IsOk() && !ItemHasChildren(itemDst) )
			{
				itemDst = GetItemParent(itemDst);
			}

			if ( !itemDst.IsOk() )
			{
				Log.LogMessage("OnEndDrag: can't drop here.");

				return;
			}

			string text = GetItemText(itemSrc);
			Log.LogMessage("OnEndDrag: '" + text + "' copied to '" + GetItemText(itemDst) + "'.");

			int image = TreeTestApp.ShowImages ? (int)TreeIcon.File : -1;
			AppendItem(itemDst, text, image);
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginLabelEdit(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
			
			Log.LogMessage("OnBeginLabelEdit");

			TreeItemId itemId = te.Item;
			if ( IsTestItem(itemId) )
			{
				MessageDialog.MessageBox("You can't edit this item.");

				te.Veto();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnEndLabelEdit(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
		
			Log.LogMessage("OnEndLabelEdit");

// 			if ( !te.Label.IsWord() )
// 			{
// 				MessageDialog.MessageBox("The new label should be a single word.");
// 
// 				te.Veto();
// 			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnDeleteItem(object sender, Event e)
		{
// 			Log.LogMessage("OnDeleteItem");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetInfo(object sender, Event e)
		{
			Log.LogMessage("OnSetInfo");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemExpanded(object sender, Event e)
		{
			Log.LogMessage("OnItemExpanded");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemExpanding(object sender, Event e)
		{
			Log.LogMessage("OnItemExpanding");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemCollapsed(object sender, Event e)
		{
			Log.LogMessage("OnItemCollapsed");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemCollapsing(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
		
			Log.LogMessage("OnItemCollapsing");

			TreeItemId itemId = te.Item;
			if ( IsTestItem(itemId) )
			{
				MessageDialog.MessageBox("You can't collapse this item.");

				te.Veto();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnContextMenu(object sender, Event e)
		{
			ContextMenuEvent ce = e as ContextMenuEvent;
		
			Point pt = ce.Position;
			TreeItemId item = Selection;
			Log.LogMessage("OnContextMenu at screen coords (" + pt.X + ", " + pt.Y + ")");

			if (pt.X==-1 && pt.Y==-1) 
			{
				if (item.IsOk())
				{
					Rectangle rect = new Rectangle(0, 0, 0, 0);
					GetBoundingRect(item, ref rect, true); 
					pt = new Point(rect.Right, rect.Top);
				}
				else
				{
					pt = new Point(0, 0);
				}
			}
			else
			{
				pt = ScreenToClient(pt);
			}

			ShowMenu(item, pt);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelChanged(object sender, Event e)
		{
			Log.LogMessage("OnSelChanged");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelChanging(object sender, Event e)
		{
			Log.LogMessage("OnSelChanging");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnTreeKeyDown(object sender, Event e)
		{
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemActivated(object sender, Event e)
		{
			TreeEvent te = e as TreeEvent;
		
			TreeItemId itemId = te.Item;
			MyTreeItemData item = (MyTreeItemData)GetItemData(itemId);

			if ( item != null )
			{
				item.ShowInfo(this);
			}

			Log.LogMessage("OnItemActivated");
		}
		
		//---------------------------------------------------------------------
		
		public void OnRMouseDClick(object sender, Event e)
		{
			MouseEvent me = e as MouseEvent;
		
			int flags = 0;
			TreeItemId id = HitTest(me.Position, out flags);
			if ( id == null )
				Log.LogMessage("No item under mouse");
			else
			{
				MyTreeItemData item = (MyTreeItemData)GetItemData(id);
				if ( item != null )
					Log.LogMessage("Item '" + item.Desc + "' under mouse");
			}
		}
		
		//---------------------------------------------------------------------
		
		private bool IsTestItem(TreeItemId item)
		{
			return GetItemParent(item) == RootItem && (GetPrevSibling(item) == null);
		}
		
		//---------------------------------------------------------------------
		
		public void SetLastItem(TreeItemId id)
		{
			m_lastItem = id;
		}
		
		//---------------------------------------------------------------------
		
		public void ShowMenu(TreeItemId id, Point pt)
		{
			string title = "";
			if ( id.IsOk() )
			{
				title += "Menu for " + GetItemText(id);
			}
			else
			{
				title = "Menu for no particular item";
			}

			Menu menu = new Menu(title);
			menu.Append((int)MyFrame.Cmd.TreeTest_About, "&About...");
			menu.Append((int)MyFrame.Cmd.TreeTest_Dump, "&Dump");

			PopupMenu(menu, pt);
		}
		
		//---------------------------------------------------------------------
		
		public void DoSortChildren(TreeItemId item, bool reverse)
		{
			m_reverseSort = reverse;
			base.SortChildren(item);
		}
		
		//---------------------------------------------------------------------
		
		public override int OnCompareItems(TreeItemId item1, TreeItemId item2)
		{
			if ( m_reverseSort )
			{
				return base.OnCompareItems(item2, item1);
			}
			else
			{
				return base.OnCompareItems(item1, item2);
			}
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyTreeItemData : TreeItemData
	{
		private string m_desc;
		
		//---------------------------------------------------------------------
	
		public MyTreeItemData(string desc)
			: base()
		{
			m_desc = desc;
		}
		
		//---------------------------------------------------------------------
		
		public string Desc
		{
			get { return m_desc; }
		}
		
		protected string Bool2String(bool b)
		{
			return b ? "" : "not";
		}
		
		//---------------------------------------------------------------------
		
		public void ShowInfo(TreeCtrl tree)
		{
			string msg = "Item '" + m_desc +"': ";
			msg += Bool2String(tree.IsSelected(Id)) + "selected, ";
			msg += Bool2String(tree.IsExpanded(Id)) + "expanded, ";
			msg += Bool2String(tree.IsBold(Id)) + "bold,\n";
			msg += tree.GetChildrenCount(Id) + " children (";
			msg += tree.GetChildrenCount(Id, false) + " immediately under this item).";
		
			Log.LogMessage(msg);
		}
	}
}
