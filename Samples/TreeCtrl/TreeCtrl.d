//-----------------------------------------------------------------------------
// wxD/Samples - TreeCtrl.d
//
// A wxD version of the wxWidgets "treectrl" sample.
//
// Written by Jason Perkins (jason@379.com)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

	public class TreeTestApp : App
	{
		static bool showImages = true;
// 		static bool showButtons = false;

		//---------------------------------------------------------------------

		
		static void Main()
		{
			TreeTestApp app = new TreeTestApp();
			app.Run();
		}

		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("TreeCtrl Test", new_Point(50,50), new_Size(450,600));
			frame.Show(true);
			return true;
		}

		//---------------------------------------------------------------------

		public static bool ShowImages() { return showImages; }
		public static void ShowImages(bool value) { showImages = value; }
		
		//---------------------------------------------------------------------

// 		public static bool ShowButtons
// 		{
// 			get { return showButtons; }
// 			set { showButtons = value; }
// 		}
	}

	//---------------------------------------------------------------------

	public class MyFrame : Frame
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

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			BackgroundColour = new Colour(255, 255, 255);
		
			icon = new Icon("../Samples/TreeCtrl/mondrian.png");

			// Set up a menu

			Menu fileMenu = new Menu();
			Menu style_menu = new Menu();
			Menu tree_menu = new Menu();
			Menu item_menu = new Menu();

			fileMenu.Append(Cmd.TreeTest_About, "&About...\tF1");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.TreeTest_Quit, "E&xit\tAlt-X");
			
			style_menu.AppendCheckItem(Cmd.TreeTest_TogButtons, "Toggle &normal buttons");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogTwist, "Toggle &twister buttons");
			style_menu.AppendCheckItem(Cmd.TreeTest_ToggleButtons, "Toggle image &buttons");
			style_menu.AppendSeparator();
			style_menu.AppendCheckItem(Cmd.TreeTest_TogLines, "Toggle &connecting lines");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogRootLines, "Toggle &lines at root");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogHideRoot, "Toggle &hidden root");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogBorder, "Toggle &item border");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogFullHighlight, "Toggle &full row highlight");
			style_menu.AppendCheckItem(Cmd.TreeTest_TogEdit, "Toggle &edit mode");
			style_menu.AppendCheckItem(Cmd.TreeTest_ToggleSel, "Toggle &selection mode");
			style_menu.AppendCheckItem(Cmd.TreeTest_ToggleImages, "Toggle show ima&ges");
			style_menu.Append(Cmd.TreeTest_SetImageSize, "Set image si&ze...");
			style_menu.AppendSeparator();
			style_menu.Append(Cmd.TreeTest_SetFgColour, "Set &foreground colour...");
			style_menu.Append(Cmd.TreeTest_SetBgColour, "Set &background colour...");
			style_menu.AppendSeparator();
			style_menu.Append(Cmd.TreeTest_ResetStyle, "&Reset to default\tF10");

			tree_menu.Append(Cmd.TreeTest_Recreate, "&Recreate the tree");
			tree_menu.Append(Cmd.TreeTest_CollapseAndReset, "C&ollapse and reset");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_AddItem, "Append a &new item");
			tree_menu.Append(Cmd.TreeTest_InsertItem, "&Insert a new item");
			tree_menu.Append(Cmd.TreeTest_Delete, "&Delete this item");
			tree_menu.Append(Cmd.TreeTest_DeleteChildren, "Delete &children");
			tree_menu.Append(Cmd.TreeTest_DeleteAll, "Delete &all items");
			tree_menu.Append(Cmd.TreeTest_SelectRoot, "Select root item");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_Count, "Count children of current item");
			tree_menu.Append(Cmd.TreeTest_CountRec, "Recursively count children of current item");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_Sort, "Sort children of current item");
			tree_menu.Append(Cmd.TreeTest_SortRev, "Sort in reversed order");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_EnsureVisible, "Make the last item &visible");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_IncIndent, "Add 5 points to indentation\tAlt-I");
			tree_menu.Append(Cmd.TreeTest_DecIndent, "Reduce indentation by 5 points\tAlt-R");
			tree_menu.AppendSeparator();
			tree_menu.Append(Cmd.TreeTest_IncSpacing, "Add 5 points to spacing\tCtrl-I");
			tree_menu.Append(Cmd.TreeTest_DecSpacing, "Reduce spacing by 5 points\tCtrl-R");

			item_menu.Append(Cmd.TreeTest_Dump, "&Dump item children");
			item_menu.Append(Cmd.TreeTest_Rename, "&Rename item...");

			item_menu.AppendSeparator();
			item_menu.Append(Cmd.TreeTest_SetBold, "Make item &bold");
			item_menu.Append(Cmd.TreeTest_ClearBold, "Make item &not bold");
			item_menu.AppendSeparator();
			item_menu.Append(Cmd.TreeTest_ToggleIcon, "Toggle the item's &icon");

			item_menu.AppendSeparator();
			item_menu.Append(Cmd.TreeTest_DumpSelected, "Dump selected items\tAlt-D");
			item_menu.Append(Cmd.TreeTest_Select, "Select current item\tAlt-S");
			item_menu.Append(Cmd.TreeTest_Unselect, "Unselect everything\tAlt-U");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(style_menu, "&Style");
			menuBar.Append(tree_menu, "&Tree");
			menuBar.Append(item_menu, "&Item");
			this.menuBar = menuBar;
			
			m_textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxSUNKEN_BORDER);

			// Set up a status bar

			CreateStatusBar(2);
			StatusText = "";

			// Create the default tree control

			CreateTreeWithDefaultStyle();
			
			menuBar.Check(Cmd.TreeTest_ToggleImages, true);
			
			Log.SetActiveTarget( m_textCtrl ); 

			// Set up the event table

			EVT_MENU(Cmd.TreeTest_Quit,  &OnQuit);
			EVT_MENU(Cmd.TreeTest_About, &OnAbout);
			
			EVT_MENU(Cmd.TreeTest_TogButtons, &OnTogButtons);
			EVT_MENU(Cmd.TreeTest_Rename, &OnRename);
			EVT_MENU(Cmd.TreeTest_Count, &OnCount);
			EVT_MENU(Cmd.TreeTest_CountRec, &OnCountRec);
			EVT_MENU(Cmd.TreeTest_Dump, &OnDump);
			EVT_MENU(Cmd.TreeTest_ToggleSel, &OnToggleSel);
			EVT_MENU(Cmd.TreeTest_DumpSelected, &OnDumpSelected);
			EVT_MENU(Cmd.TreeTest_Select, &OnSelect);
			EVT_MENU(Cmd.TreeTest_SelectRoot, &OnSelectRoot);
			EVT_MENU(Cmd.TreeTest_Unselect, &OnUnselect);
			EVT_MENU(Cmd.TreeTest_SetBold, &OnSetBold);
			EVT_MENU(Cmd.TreeTest_ClearBold, &OnClearBold);
			EVT_MENU(Cmd.TreeTest_Delete, &OnDelete);
			EVT_MENU(Cmd.TreeTest_DeleteChildren, &OnDeleteChildren);
			EVT_MENU(Cmd.TreeTest_DeleteAll, &OnDeleteAll);
			EVT_MENU(Cmd.TreeTest_Recreate, &OnRecreate);
			EVT_MENU(Cmd.TreeTest_SetImageSize, &OnSetImageSize);
			EVT_MENU(Cmd.TreeTest_ToggleImages, &OnToggleImages);
			EVT_MENU(Cmd.TreeTest_CollapseAndReset, &OnCollapseAndReset);
			EVT_MENU(Cmd.TreeTest_EnsureVisible, &OnEnsureVisible);
			EVT_MENU(Cmd.TreeTest_InsertItem, &OnInsertItem);
			EVT_MENU(Cmd.TreeTest_AddItem, &OnAddItem);
			EVT_MENU(Cmd.TreeTest_IncIndent, &OnIncIndent);
			EVT_MENU(Cmd.TreeTest_DecIndent, &OnDecIndent);
			EVT_MENU(Cmd.TreeTest_IncSpacing, &OnIncSpacing);
			EVT_MENU(Cmd.TreeTest_DecSpacing, &OnDecSpacing);
			EVT_MENU(Cmd.TreeTest_ToggleIcon, &OnToggleIcon);
			EVT_MENU(Cmd.TreeTest_SetFgColour, &OnSetFgColour);
			EVT_MENU(Cmd.TreeTest_SetBgColour, &OnSetBgColour);
			
			EVT_MENU(Cmd.TreeTest_Sort, &OnSort);
			EVT_MENU(Cmd.TreeTest_SortRev, &OnSortRev);
			
			EVT_IDLE( &OnIdle) ;
			
			EVT_SIZE( &OnSize) ;
		}
		
		//---------------------------------------------------------------------
		
		~this()
		{
			Log.SetActiveTarget(null);
		}

		//---------------------------------------------------------------------

		public void CreateTreeWithDefaultStyle()
		{
			long style = TreeCtrl.wxTR_DEFAULT_STYLE | TreeCtrl.wxTR_EDIT_LABELS;
			CreateTree(style | Border.wxBORDER_SUNKEN);
			
			MenuBar mbar = menuBar;
			
			mbar.Check(Cmd.TreeTest_TogButtons, (style & TreeCtrl.wxTR_HAS_BUTTONS) != 0);
			mbar.Check(Cmd.TreeTest_TogButtons, (style & TreeCtrl.wxTR_TWIST_BUTTONS) != 0);
			mbar.Check(Cmd.TreeTest_TogLines, (style & TreeCtrl.wxTR_NO_LINES) == 0);
			mbar.Check(Cmd.TreeTest_TogRootLines, (style & TreeCtrl.wxTR_LINES_AT_ROOT) != 0);
			mbar.Check(Cmd.TreeTest_TogHideRoot, (style & TreeCtrl.wxTR_HIDE_ROOT) != 0);
			mbar.Check(Cmd.TreeTest_TogEdit, (style & TreeCtrl.wxTR_EDIT_LABELS) != 0);
			mbar.Check(Cmd.TreeTest_TogBorder, (style & TreeCtrl.wxTR_ROW_LINES) != 0);
			mbar.Check(Cmd.TreeTest_TogFullHighlight, (style & TreeCtrl.wxTR_FULL_ROW_HIGHLIGHT) != 0);
		}

		//---------------------------------------------------------------------

		public void CreateTree(long style)
		{
			m_treeCtrl = new MyTreeCtrl(this, Cmd.TreeTest_Ctrl, wxDefaultPosition, wxDefaultSize, style);
			Resize();
		}
		
		//---------------------------------------------------------------------
		
		public void TogStyle(int id, long flag)
		{
			long style = m_treeCtrl.WindowStyle ^ flag;
			//delete m_treeCtrl;
			CreateTree(style);

			menuBar.Check(id, (style & flag) != 0);
		}

		//---------------------------------------------------------------------
		
		public void OnIdle(Object sender, Event e)
		{
			if (m_treeCtrl !== null)
			{
				TreeItemId idRoot = m_treeCtrl.RootItem;
			
				string s = "Root/last item is ";
				s ~= m_treeCtrl.IsVisible(idRoot) ? "" : "not ";
				s ~= "visible/";
				s ~= m_treeCtrl.IsVisible(m_treeCtrl.GetLastChild(idRoot)) ? "" : "not ";
				s ~= "visible";
				
				SetStatusText(s, 1);
			}
		      
			e.Skip();
		}
		
		//---------------------------------------------------------------------

		public void OnQuit(Object sender, Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnAbout(Object sender, Event e)
		{
			string msg = "Tree test sample\n(c) Julian Smart 1997, Vadim Zeitlin 1998\nPorted to wxD by Jason Perkins and Alexander Olk";
			MessageBox(this, msg, "About Tree Test", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------

		public void Resize()
		{
			Size size = ClientSize;
			m_treeCtrl.SetSize(0, 0, size.Width, size.Height * 2/3);
			m_textCtrl.SetSize(0, 2 * size.Height/3, size.Width, size.Height/3);
		}

		//---------------------------------------------------------------------
		
		public void OnTogButtons(Object sender, Event e)
		{
			TogStyle(e.ID, TreeCtrl.wxTR_HAS_BUTTONS);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSize(Object sender, Event e)
		{
			if ( m_treeCtrl !== null && m_textCtrl !== null )
			{
				Resize();
			}

			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnRename(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.EditLabel(item);
		}
		
		//---------------------------------------------------------------------
		
		public void OnCount(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			int i = m_treeCtrl.GetChildrenCount( item, false );

			Log.LogMessage(.toString(i) ~ " children");
		}
		
		//---------------------------------------------------------------------
		
		public void OnCountRec(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			int i = m_treeCtrl.GetChildrenCount( item );

			Log.LogMessage(.toString(i) ~ " children");
		}
		
		//---------------------------------------------------------------------
		
		public void OnDump(Object sender, Event e)
		{
			TreeItemId root = m_treeCtrl.Selection;
			
			CHECK_ITEM( root );

			m_treeCtrl.GetItemsRecursively(root, IntPtr.init);
		}
		
		//---------------------------------------------------------------------
		
		public void OnToggleSel(Object sender, Event e)
		{
			TogStyle(e.ID, TreeCtrl.wxTR_MULTIPLE);
		}
		
		//---------------------------------------------------------------------
		
		public void OnDumpSelected(Object sender, Event e)
		{
			TreeItemId[] array = m_treeCtrl.Selections();

			int count = array.length;
			
			Log.LogMessage(.toString(count) ~ " items selected");

			for ( int n = 0; n < count; n++ )
			{
				Log.LogMessage(m_treeCtrl.GetItemText(array[n]));
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelect(Object sender, Event e)
		{
			m_treeCtrl.SelectItem(m_treeCtrl.Selection);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectRoot(Object sender, Event e)
		{
			m_treeCtrl.SelectItem(m_treeCtrl.RootItem);
		}

		//---------------------------------------------------------------------

		public void OnUnselect(Object sender, Event e)
		{
			m_treeCtrl.UnselectAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetBold(Object sender, Event e)
		{
			DoSetBold(true);
		}
		
		//---------------------------------------------------------------------
		
		public void OnClearBold(Object sender, Event e)
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
		
		public void OnDelete(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.Delete(item);
		}

		//---------------------------------------------------------------------

		public void OnDeleteChildren(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.DeleteChildren(item);
		}

		//---------------------------------------------------------------------

		public void OnDeleteAll(Object sender, Event e)
		{
			m_treeCtrl.DeleteAllItems();
		}

		//---------------------------------------------------------------------

		public void OnRecreate(Object sender, Event e)
		{
			OnDeleteAll(this, e);
			m_treeCtrl.AddTestItemsToTree(5, 2);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetImageSize(Object sender, Event e)
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

		public void OnToggleImages(Object sender, Event e)
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
		
// 		public void OnToggleButtons(Object sender, Event e)
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
		
		public void OnCollapseAndReset(Object sender, Event e)
		{
			m_treeCtrl.CollapseAndReset(m_treeCtrl.RootItem);
		}

		//---------------------------------------------------------------------

		public void OnEnsureVisible(Object sender, Event e)
		{
			m_treeCtrl.DoEnsureVisible();
		}

		//---------------------------------------------------------------------

		public void OnInsertItem(Object sender, Event e)
		{
			int image = TreeTestApp.ShowImages ? MyTreeCtrl.TreeIcon.File : -1;
			m_treeCtrl.InsertItem(m_treeCtrl.RootItem, image, "2nd item");
		}

		//---------------------------------------------------------------------

		public void OnAddItem(Object sender, Event e)
		{
			string text = "Item #" ~ .toString(++s_num);

			m_treeCtrl.AppendItem(m_treeCtrl.RootItem, text);
		}

		//---------------------------------------------------------------------

		public void OnIncIndent(Object sender, Event e)
		{
			uint indent = m_treeCtrl.Indent;
			if (indent < 100)
				m_treeCtrl.Indent = indent + 5;
		}

		//---------------------------------------------------------------------

		public void OnDecIndent(Object sender, Event e)
		{
			uint indent = m_treeCtrl.Indent;
			if (indent > 10)
				m_treeCtrl.Indent = indent-5;
		}

		//---------------------------------------------------------------------

		public void OnIncSpacing(Object sender, Event e)
		{
			uint indent = m_treeCtrl.Spacing;
			if (indent < 100)
				m_treeCtrl.Spacing = indent + 5;
		}

		//---------------------------------------------------------------------

		public void OnDecSpacing(Object sender, Event e)
		{
			uint indent = m_treeCtrl.Spacing;
			if (indent > 10)
				m_treeCtrl.Spacing = indent - 5;
		}

		//---------------------------------------------------------------------

		public void OnToggleIcon(Object sender, Event e)
		{
			TreeItemId item = m_treeCtrl.Selection;

			CHECK_ITEM( item );

			m_treeCtrl.DoToggleIcon(item);
		}
		
		//---------------------------------------------------------------------

		public void OnSetFgColour(Object sender, Event e)
		{
			Colour col = GetColourFromUser(this, m_treeCtrl.ForegroundColour);
			if ( col.Ok() )
				m_treeCtrl.ForegroundColour = col;
		}

		//---------------------------------------------------------------------

		public void OnSetBgColour(Object sender, Event e)
		{
			Colour col = GetColourFromUser(this, m_treeCtrl.BackgroundColour);
			if ( col.Ok() )
				m_treeCtrl.BackgroundColour = col;
		}

		
		//---------------------------------------------------------------------
		
		public void OnSort(Object sender, Event e)
		{
			DoSort(false);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSortRev(Object sender, Event e)
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
				MessageBox(this, "Please select some item first!", 
						"Tree sample error",              
						Dialog.wxOK | Dialog.wxICON_EXCLAMATION);
				return;                                             
			}
		}
	}

	//---------------------------------------------------------------------

	public class MyTreeCtrl : TreeCtrl
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

		public this(Window parent, int id, Point pos, Size size, int style)
		{
			super(parent, id, pos, size, style);
			CreateImageList(16);
			AddTestItemsToTree(5, 2);
			
			EVT_TREE_BEGIN_DRAG(MyFrame.Cmd.TreeTest_Ctrl, &OnBeginDrag);
			EVT_TREE_BEGIN_RDRAG(MyFrame.Cmd.TreeTest_Ctrl, &OnBeginRDrag);
			EVT_TREE_END_DRAG(MyFrame.Cmd.TreeTest_Ctrl, &OnEndDrag);
			EVT_TREE_BEGIN_LABEL_EDIT(MyFrame.Cmd.TreeTest_Ctrl, &OnBeginLabelEdit);
			EVT_TREE_END_LABEL_EDIT(MyFrame.Cmd.TreeTest_Ctrl, &OnEndLabelEdit);
			EVT_TREE_DELETE_ITEM(MyFrame.Cmd.TreeTest_Ctrl, &OnDeleteItem);
			EVT_TREE_SET_INFO(MyFrame.Cmd.TreeTest_Ctrl, &OnSetInfo);
			EVT_TREE_ITEM_EXPANDED(MyFrame.Cmd.TreeTest_Ctrl, &OnItemExpanded);
			EVT_TREE_ITEM_EXPANDING(MyFrame.Cmd.TreeTest_Ctrl, &OnItemExpanding);
			EVT_TREE_ITEM_COLLAPSED(MyFrame.Cmd.TreeTest_Ctrl, &OnItemCollapsed);
			EVT_TREE_ITEM_COLLAPSING(MyFrame.Cmd.TreeTest_Ctrl, &OnItemCollapsing);

			EVT_CONTEXT_MENU(&OnContextMenu);
			EVT_TREE_SEL_CHANGED(MyFrame.Cmd.TreeTest_Ctrl, &OnSelChanged);
			EVT_TREE_SEL_CHANGING(MyFrame.Cmd.TreeTest_Ctrl, &OnSelChanging);
			EVT_TREE_KEY_DOWN(MyFrame.Cmd.TreeTest_Ctrl, &OnTreeKeyDown);
			EVT_TREE_ITEM_ACTIVATED(MyFrame.Cmd.TreeTest_Ctrl, &OnItemActivated);
			EVT_RIGHT_DCLICK(&OnRMouseDClick);
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

			ImageList images = new ImageList(size, size);

			for (int i = 0; i < 5; ++i)
			{
				Image image = new Image("../Samples/TreeCtrl/icon" ~ .toString(i) ~ ".png");
				images.Add(new Bitmap(image.Rescale(size, size)));
			}

			AssignImageList(images);
		}

		//---------------------------------------------------------------------

		public void AddItemsRecursively(TreeItemId idParent, int numChildren, int depth, int folder)
		{
			if (depth > 0)
			{
				bool hasChildren = depth > 1;

				for (int n = 0; n < numChildren; ++n)
				{
					string str;

					// at depth 1 elements won't have any more children
					if (hasChildren)
						str ~= format("%s child %d", "Folder", n + 1);
					else
						str ~= format("%s child %d.%d", "File", folder, n + 1);

					// here we pass to AppendItem() normal and selected item images (we
					// suppose that selected image follows the normal one in the enum)

					int image, imageSel;
					if (TreeTestApp.ShowImages)
					{
						image = (depth == 1) ? TreeIcon.File : TreeIcon.Folder;
						imageSel = image + 1;
					}
					else
					{
						image = -1;
						imageSel = -1;
					}

					TreeItemId id = AppendItem(idParent, str, image, imageSel,
						new MyTreeItemData(str));

					// and now we also set the expanded one (only for the folders)

					if (hasChildren && TreeTestApp.ShowImages)
					{
						SetItemImage(id, TreeIcon.FolderOpened, TreeItemIcon.wxTreeItemIcon_Expanded);
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
			int image = TreeTestApp.ShowImages ? TreeIcon.Folder : -1;
			TreeItemId rootId = AddRoot("Root", image, image,
				new MyTreeItemData("Root item"));
			if (image != -1)
				SetItemImage(rootId, TreeIcon.FolderOpened, TreeItemIcon.wxTreeItemIcon_Expanded);

			AddItemsRecursively(rootId, numChildren, depth, 0);
			
			SetItemFont(rootId, Font.wxITALIC_FONT);
			
			IntPtr cookie = IntPtr.init;
			TreeItemId id = GetFirstChild(rootId, cookie);
			SetItemTextColour(id, Colour.wxBLUE);

			id = GetNextChild(rootId, cookie);
			id = GetNextChild(rootId, cookie);
			SetItemTextColour(id, Colour.wxRED);
			SetItemBackgroundColour(id, Colour.wxLIGHT_GREY);
		}
		
		//---------------------------------------------------------------------
		
		public void GetItemsRecursively(TreeItemId idParent, IntPtr cookie)
		{
			TreeItemId id;

			if ( cookie == IntPtr.init )
				id = GetFirstChild(idParent, cookie);
			else
				id = GetNextChild(idParent, cookie);

			if ( !id.IsOk() )
				return;

			string text = GetItemText(id);
			Log.LogMessage(text);

			if ( ItemHasChildren(id) )
				GetItemsRecursively(id, IntPtr.init);

			GetItemsRecursively(idParent, cookie);
		}
		
		//---------------------------------------------------------------------
		
		public int ImageSize()
		{
			return imageSize;
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
			image = image == TreeIcon.Folder ? TreeIcon.File
								: TreeIcon.Folder;

			SetItemImage(item, image);
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginDrag(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
		
			if ( te.Item != RootItem )
			{
				m_draggedItem = te.Item;

				Log.LogMessage("OnBeginDrag: started dragging " ~ GetItemText(m_draggedItem));

				te.Allow();
			}
			else
			{
				Log.LogMessage("OnBeginDrag: this item can't be dragged.");
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginRDrag(Object sender, Event e)
		{
			Log.LogMessage("OnBeginRDrag");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnEndDrag(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
			
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
			Log.LogMessage("OnEndDrag: '" ~ text ~ "' copied to '" ~ GetItemText(itemDst) ~ "'.");

			int image = TreeTestApp.ShowImages ? TreeIcon.File : -1;
			AppendItem(itemDst, text, image);
		}
		
		//---------------------------------------------------------------------
		
		public void OnBeginLabelEdit(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
			
			Log.LogMessage("OnBeginLabelEdit");

			TreeItemId itemId = te.Item;
			if ( IsTestItem(itemId) )
			{
				MessageBox("You can't edit this item.");

				te.Veto();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnEndLabelEdit(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
		
			Log.LogMessage("OnEndLabelEdit");

// 			if ( !te.Label.IsWord() )
// 			{
// 				MessageBox("The new label should be a single word.");
// 
// 				te.Veto();
// 			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnDeleteItem(Object sender, Event e)
		{
// 			Log.LogMessage("OnDeleteItem");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetInfo(Object sender, Event e)
		{
			Log.LogMessage("OnSetInfo");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemExpanded(Object sender, Event e)
		{
			Log.LogMessage("OnItemExpanded");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemExpanding(Object sender, Event e)
		{
			Log.LogMessage("OnItemExpanding");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemCollapsed(Object sender, Event e)
		{
			Log.LogMessage("OnItemCollapsed");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemCollapsing(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
		
			Log.LogMessage("OnItemCollapsing");

			TreeItemId itemId = te.Item;
			if ( IsTestItem(itemId) )
			{
				MessageBox("You can't collapse this item.");

				te.Veto();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnContextMenu(Object sender, Event e)
		{
			ContextMenuEvent ce = cast(ContextMenuEvent)e;
		
			Point pt = ce.Position;
			TreeItemId item = Selection;
			Log.LogMessage("OnContextMenu at screen coords (" ~ .toString(pt.X) ~ ", " ~ .toString(pt.Y) ~ ")");

			if (pt.X==-1 && pt.Y==-1) 
			{
				if (item.IsOk())
				{
					Rectangle rect = new_Rectangle(0, 0, 0, 0);
					GetBoundingRect(item, rect, true); 
					pt = new_Point(rect.Left, rect.Top);
				}
				else
				{
					pt = new_Point(0, 0);
				}
			}
			else
			{
				pt = ScreenToClient(pt);
			}

			ShowMenu(item, pt);
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelChanged(Object sender, Event e)
		{
			Log.LogMessage("OnSelChanged");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelChanging(Object sender, Event e)
		{
			Log.LogMessage("OnSelChanging");
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnTreeKeyDown(Object sender, Event e)
		{
		}
		
		//---------------------------------------------------------------------
		
		public void OnItemActivated(Object sender, Event e)
		{
			TreeEvent te = cast(TreeEvent)e;
		
			TreeItemId itemId = te.Item;
			MyTreeItemData item = cast(MyTreeItemData)GetItemData(itemId);

			if ( item !== null )
			{
				item.ShowInfo(this);
			}

			Log.LogMessage("OnItemActivated");
		}
		
		//---------------------------------------------------------------------
		
		public void OnRMouseDClick(Object sender, Event e)
		{
			MouseEvent me = cast(MouseEvent)e;
		
			int flags = 0;
			TreeItemId id = HitTest(me.Position, flags);
			if ( id === null )
				Log.LogMessage("No item under mouse");
			else
			{
				MyTreeItemData item = cast(MyTreeItemData)GetItemData(id);
				if ( item !== null )
					Log.LogMessage("Item '" ~ item.Desc ~ "' under mouse");
			}
		}
		
		//---------------------------------------------------------------------
		
		private bool IsTestItem(TreeItemId item)
		{
			return GetItemParent(item) == RootItem && (GetPrevSibling(item) === null);
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
				title ~= "Menu for " ~ GetItemText(id);
			}
			else
			{
				title = "Menu for no particular item";
			}

			Menu menu = new Menu(title);
			menu.Append(MyFrame.Cmd.TreeTest_About, "&About...");
			menu.Append(MyFrame.Cmd.TreeTest_Dump, "&Dump");

			PopupMenu(menu, pt);
		}
		
		//---------------------------------------------------------------------
		
		public void DoSortChildren(TreeItemId item, bool reverse)
		{
			m_reverseSort = reverse;
			super.SortChildren(item);
		}
		
		//---------------------------------------------------------------------
		
		public override int OnCompareItems(TreeItemId item1, TreeItemId item2)
		{
			if ( m_reverseSort )
			{
				return super.OnCompareItems(item2, item1);
			}
			else
			{
				return super.OnCompareItems(item1, item2);
			}
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyTreeItemData : TreeItemData
	{
		private string m_desc;
		
		//---------------------------------------------------------------------
	
		public this(string desc)
		{
			super();
			m_desc = desc;
		}
		
		//---------------------------------------------------------------------
		
		public string Desc()
		{
			return m_desc;
		}
		
		protected string Bool2String(bool b)
		{
			return b ? "" : "not";
		}
		
		//---------------------------------------------------------------------
		
		public void ShowInfo(TreeCtrl tree)
		{
			string msg = "Item '" ~ m_desc ~ "': ";
			msg ~= Bool2String(tree.IsSelected(Id)) ~ "selected, ";
			msg ~= Bool2String(tree.IsExpanded(Id)) ~ "expanded, ";
			msg ~= Bool2String(tree.IsBold(Id)) ~ "bold,\n";
			msg ~= .toString(tree.GetChildrenCount(Id)) ~ " children (";
			msg ~= .toString(tree.GetChildrenCount(Id, false)) ~ " immediately under this item).";
		
			Log.LogMessage(msg);
		}
	}


void main()
{
	TreeTestApp.Main();
}
