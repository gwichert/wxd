//-----------------------------------------------------------------------------
// wx.NET - Menu.cs
//
// The wxMenu wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace wx
{
	public class MenuBase : EvtHandler
	{
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_ctor1(string titel, uint style);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_ctor2(uint style);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Append(IntPtr self, int id, string item, string help, ItemKind kind);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_AppendSubMenu(IntPtr self, int id, string item, IntPtr subMenu, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_AppendItem(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_AppendSeparator(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_AppendCheckItem(IntPtr self, int itemid, string text, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_AppendRadioItem(IntPtr self, int itemid, string text, string help);
		[DllImport("wx-c")] static extern int    wxMenuBase_GetMenuItemCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetMenuItem(IntPtr self, int index);
		[DllImport("wx-c")] static extern void   wxMenuBase_Break(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Insert(IntPtr self, int pos, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Insert2(IntPtr self, int pos, int itemid, string text, string help, ItemKind kind);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_InsertSeparator(IntPtr self, int pos);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_InsertCheckItem(IntPtr self, int pos, int itemid, string text, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_InsertRadioItem(IntPtr self, int pos, int itemid, string text, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_InsertSubMenu(IntPtr self, int pos, int itemid, string text, IntPtr submenu, string help);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Prepend(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Prepend2(IntPtr self, int itemid, string text, string help, ItemKind kind);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_PrependSeparator(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_PrependCheckItem(IntPtr self, int itemid, string text, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_PrependRadioItem(IntPtr self, int itemid, string text, string help);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_PrependSubMenu(IntPtr self, int itemid, string text, IntPtr submenu, string help);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Remove(IntPtr self, int itemid);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_Remove2(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern bool   wxMenuBase_Delete(IntPtr self, int itemid);
		[DllImport("wx-c")] static extern bool   wxMenuBase_Delete2(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern bool   wxMenuBase_Destroy(IntPtr self, int itemid);
		[DllImport("wx-c")] static extern bool   wxMenuBase_Destroy2(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern int    wxMenuBase_FindItem(IntPtr self, string item);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_FindItem2(IntPtr self, int itemid, ref IntPtr menu); 
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_FindItemByPosition(IntPtr self, int position);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_Enable(IntPtr self, int itemid, bool enable);
		[DllImport("wx-c")] static extern bool   wxMenuBase_IsEnabled(IntPtr self, int itemid);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_Check(IntPtr self, int id, bool check);
		[DllImport("wx-c")] static extern bool   wxMenuBase_IsChecked(IntPtr self, int itemid);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetLabel(IntPtr self, int itemid, string label);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetLabel(IntPtr self, int itemid);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetHelpString(IntPtr self, int itemid, string helpString);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetHelpString(IntPtr self, int itemid);		
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetTitle(IntPtr self, string title);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetTitle(IntPtr self);		
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetInvokingWindow(IntPtr self, IntPtr win);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetInvokingWindow(IntPtr self);
		
		[DllImport("wx-c")] static extern uint   wxMenuBase_GetStyle(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetEventHandler(IntPtr self, IntPtr handler);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetEventHandler(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_UpdateUI(IntPtr self, IntPtr source);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetMenuBar(IntPtr self);
		
		[DllImport("wx-c")] static extern bool   wxMenuBase_IsAttached(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxMenuBase_SetParent(IntPtr self, IntPtr parent);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_GetParent(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_FindChildItem(IntPtr self, int itemid, out int pos);
		[DllImport("wx-c")] static extern IntPtr wxMenuBase_FindChildItem2(IntPtr self, int itemid);
		[DllImport("wx-c")] static extern bool   wxMenuBase_SendEvent(IntPtr self, int itemid, int xchecked);
	
		public MenuBase(IntPtr wxObject)
			: base(wxObject) { }
			
		public MenuBase()
			: this(0) {}
			
		public MenuBase(long style)
			: this(wxMenuBase_ctor2((uint)style)) {}			
		
		public MenuBase(string titel)
			: this(titel, 0) {}
		
		public MenuBase(string titel, long style)
			: this(wxMenuBase_ctor1(titel, (uint)style)) { }
			
		//---------------------------------------------------------------------
		
		public MenuItem Append(int id, string item)
		{
			return this.Append(id, item, "");
		}
		
		public MenuItem Append(int id, string item, string help)
		{
			return Append(id, item, help, ItemKind.wxITEM_NORMAL);
		}		

		public MenuItem Append(int id, string item, string help, ItemKind kind)
		{
			return (MenuItem)FindObject(wxMenuBase_Append(wxObject, id, item, help, kind), typeof(MenuItem));
		}
		
		public MenuItem Append(int id, string item, Menu subMenu)
		{
			return Append(id, item, subMenu, "");
		}

		public MenuItem Append(int id, string item, Menu subMenu, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_AppendSubMenu(wxObject, id, item, Object.SafePtr(subMenu), help), typeof(MenuItem));
		}

		public MenuItem Append(MenuItem item) 
		{
			return (MenuItem)FindObject(wxMenuBase_AppendItem(wxObject, Object.SafePtr(item)), typeof(MenuItem));
		}

		//---------------------------------------------------------------------
		
		public MenuItem AppendCheckItem(int id, string item)
		{
			return AppendCheckItem(id, item, "");
		}

		public MenuItem AppendCheckItem(int id, string item, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_AppendCheckItem(wxObject, id, item, help), typeof(MenuItem));
		}

		//---------------------------------------------------------------------

		public MenuItem AppendSeparator()
		{
			return (MenuItem)FindObject(wxMenuBase_AppendSeparator(wxObject), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem AppendRadioItem(int itemid, string text)
		{
			return AppendRadioItem(itemid, text, "");
		}
		
		public MenuItem AppendRadioItem(int itemid, string text, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_AppendRadioItem(wxObject, itemid, text, help), typeof(MenuItem));
		}

		//---------------------------------------------------------------------

		public void Check(int id, bool check)
		{
			wxMenuBase_Check(wxObject, id, check);
		}

		//---------------------------------------------------------------------

		public int GetMenuItemCount()
		{
			return wxMenuBase_GetMenuItemCount(wxObject);
		}

		public MenuItem GetMenuItem(int index)
		{
			return (MenuItem)FindObject(wxMenuBase_GetMenuItem(wxObject, index), typeof(MenuItem));
		}

		//---------------------------------------------------------------------
		
		public virtual void Break()
		{
			wxMenuBase_Break(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem Insert(int pos, MenuItem item)
		{
			return (MenuItem)FindObject(wxMenuBase_Insert(wxObject, pos, Object.SafePtr(item)), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem Insert(int pos, int itemid, string text)
		{
			return Insert(pos, itemid, text, "", ItemKind.wxITEM_NORMAL);
		}
		
		public MenuItem Insert(int pos, int itemid, string text, string help)
		{
			return Insert(pos, itemid, text, help, ItemKind.wxITEM_NORMAL);
		}
		
		public MenuItem Insert(int pos, int itemid, string text, string help, ItemKind kind)
		{
			return (MenuItem)FindObject(wxMenuBase_Insert2(wxObject, pos, itemid, text, help, kind), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem InsertSeparator(int pos)
		{
			return (MenuItem)FindObject(wxMenuBase_InsertSeparator(wxObject, pos), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem InsertCheckItem(int pos, int itemid, string text)
		{
			return InsertCheckItem(pos, itemid, text, "");
		}
		
		public MenuItem InsertCheckItem(int pos, int itemid, string text, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_InsertCheckItem(wxObject, pos, itemid, text, help), typeof(MenuItem));
		}		
		
		//---------------------------------------------------------------------
		
		public MenuItem InsertRadioItem(int pos, int itemid, string text)
		{
			return InsertCheckItem(pos, itemid, text, "");
		}
		
		public MenuItem InsertRadioItem(int pos, int itemid, string text, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_InsertRadioItem(wxObject, pos, itemid, text, help), typeof(MenuItem));
		}				
		
		//---------------------------------------------------------------------

		public MenuItem Insert(int pos, int itemid, string text, Menu submenu)
		{
			return Insert(pos, itemid, text, submenu, "");
		}
		
		public MenuItem Insert(int pos, int itemid, string text, Menu submenu, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_InsertSubMenu(wxObject, pos, itemid, text, Object.SafePtr(submenu), help), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem Prepend(MenuItem item)
		{
			return (MenuItem)FindObject(wxMenuBase_Prepend(wxObject, Object.SafePtr(item)), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem Prepend(int itemid, string text)
		{
			return Prepend(itemid, text, "", ItemKind.wxITEM_NORMAL);
		}
		
		public MenuItem Prepend(int itemid, string text, string help)
		{
			return Prepend(itemid, text, help, ItemKind.wxITEM_NORMAL);
		}
		
		public MenuItem Prepend(int itemid, string text, string help, ItemKind kind)
		{
			return (MenuItem)FindObject(wxMenuBase_Prepend2(wxObject, itemid, text, help, kind), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem PrependSeparator()
		{
			return (MenuItem)FindObject(wxMenuBase_PrependSeparator(wxObject));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem PrependCheckItem(int itemid, string text)
		{
			return PrependCheckItem(itemid, text, "");
		}
		
		public MenuItem PrependCheckItem(int itemid, string text, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_PrependCheckItem(wxObject, itemid, text, help), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem PrependRadioItem(int itemid, string text)
		{
			return PrependRadioItem(itemid, text, "");
		}
		
		public MenuItem PrependRadioItem(int itemid, string text, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_PrependRadioItem(wxObject, itemid, text, help), typeof(MenuItem));
		}		
		
		//---------------------------------------------------------------------
		
		public MenuItem Prepend(int itemid, string text, Menu submenu)
		{
			return Prepend(itemid, text, submenu, "");
		}
		
		public MenuItem Prepend(int itemid, string text, Menu submenu, string help)
		{
			return (MenuItem)FindObject(wxMenuBase_PrependSubMenu(wxObject, itemid, text, Object.SafePtr(submenu), help), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem Remove(int itemid)
		{
			return (MenuItem)FindObject(wxMenuBase_Remove(wxObject, itemid), typeof(MenuItem));
		}
		
		public MenuItem Remove(MenuItem item)
		{
			return (MenuItem)FindObject(wxMenuBase_Remove2(wxObject, Object.SafePtr(item)), typeof(MenuItem));
		}		
		
		//---------------------------------------------------------------------
		
		public bool Delete(int itemid)
		{
			return wxMenuBase_Delete(wxObject, itemid);
		}
		
		public bool Delete(MenuItem item)
		{
			return wxMenuBase_Delete2(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public bool Destroy(int itemid)
		{
			return wxMenuBase_Destroy(wxObject, itemid);
		}
		
		public bool Destroy(MenuItem item)
		{
			return wxMenuBase_Destroy2(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public virtual int FindItem(string item)
		{
			return wxMenuBase_FindItem(wxObject, item);
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem FindItem(int itemid)
		{
			Menu menuRef = null;
			return FindItem(itemid, ref menuRef);
		}
		
		public MenuItem FindItem(int itemid, ref Menu menu)
		{
			IntPtr menuRef = IntPtr.Zero;
			if (menu != null) 
			{
				menuRef = Object.SafePtr(menu);
			}
			return (MenuItem)FindObject(wxMenuBase_FindItem2(wxObject, itemid, ref menuRef), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		 
		public MenuItem FindItemByPosition(int position)
		{
			return (MenuItem)FindObject(wxMenuBase_FindItemByPosition(wxObject, position), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public void Enable(int itemid, bool enable)
		{
			wxMenuBase_Enable(wxObject, itemid, enable);
		}
		
		public bool IsEnabled(int itemid)
		{
			return wxMenuBase_IsEnabled(wxObject, itemid);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsChecked(int itemid)
		{
			return wxMenuBase_IsChecked(wxObject, itemid);
		}
		
		//---------------------------------------------------------------------
		
		public void SetLabel(int itemid, string label)
		{
			wxMenuBase_SetLabel(wxObject, itemid, label);
		}
		
		public string GetLabel(int itemid)
		{
			return new wxString(wxMenuBase_GetLabel(wxObject, itemid), true);
		}
		
		//---------------------------------------------------------------------
		
		public void SetHelpString(int itemid, string helpString)
		{
			wxMenuBase_SetHelpString(wxObject, itemid, helpString);
		}
		
		public string GetHelpString(int itemid)
		{
			return new wxString(wxMenuBase_GetHelpString(wxObject, itemid), true);
		}
		
		//---------------------------------------------------------------------
		
		public string Title
		{
			get { return new wxString(wxMenuBase_GetTitle(wxObject), true); }
			set { wxMenuBase_SetTitle(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public EvtHandler EventHandler
		{
			get { return (EvtHandler)FindObject(wxMenuBase_GetEventHandler(wxObject), typeof(EvtHandler)); }
			set { wxMenuBase_SetEventHandler(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Window InvokingWindow
		{
			get { return (Window)FindObject(wxMenuBase_GetInvokingWindow(wxObject), typeof(Window)); }
			set { wxMenuBase_SetInvokingWindow(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public long Style
		{
			get { return (long)wxMenuBase_GetStyle(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public void UpdateUI()
		{
			UpdateUI(null);
		}
		
		public void UpdateUI(EvtHandler source)
		{
			wxMenuBase_UpdateUI(wxObject, Object.SafePtr(source));
		}
		
		//---------------------------------------------------------------------
		
		public MenuBar MenuBar
		{
			get { return (MenuBar)FindObject(wxMenuBase_GetMenuBar(wxObject), typeof(MenuBar)); }
		}
		
		//---------------------------------------------------------------------
		
		public bool Attached
		{
			get { return wxMenuBase_IsAttached(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public Menu Parent
		{
			get { return (Menu)FindObject(wxMenuBase_GetParent(wxObject), typeof(Menu)); }
			set { wxMenuBase_SetParent(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public MenuItem FindChildItem(int itemid)
		{
			return (MenuItem)FindObject(wxMenuBase_FindChildItem2(wxObject, itemid), typeof(MenuItem));
		}
		
		public MenuItem FindChildItem(int itemid, out int pos)
		{
			return (MenuItem)FindObject(wxMenuBase_FindChildItem(wxObject, itemid, out pos), typeof(MenuItem));
		}
		
		//---------------------------------------------------------------------
		
		public bool SendEvent(int itemid)
		{
			return SendEvent(itemid, -1);
		}
		
		public bool SendEvent(int itemid, int xchecked)
		{
			return wxMenuBase_SendEvent(wxObject, itemid, xchecked);
		}		
	}
	
	//---------------------------------------------------------------------
	// helper struct, stores added EventListeners...
	
	public struct MenuListener
	{
		public EventListener listener;
		public Object owner;
		public int id;
		
		public MenuListener( int id, EventListener listener, Object owner )
		{
			this.listener = listener;
			this.owner = owner;
			this.id = id;
		}
	}	
	
	//---------------------------------------------------------------------

	public class Menu : MenuBase
	{
		[DllImport("wx-c")] static extern IntPtr wxMenu_ctor(string titel, uint style);
		[DllImport("wx-c")] static extern IntPtr wxMenu_ctor2(uint style);
		
		//---------------------------------------------------------------------
		
		public ArrayList eventListeners = new ArrayList();

		// InvokingWindow does not work on Windows, so we 
		// need this...
		private Window parent = null;

		// if events were connected with Frame.MenuBar or Window.PopupMenu
		// that means with ConnectEvents(), we have a Invoking Window and can add 
		// the event directly to the EventHandler
		private bool eventsconnected = false; 
		
		//---------------------------------------------------------------------
		 
		public Menu()
			: this(0) {}
			
		public Menu(long style)
			: this(wxMenu_ctor2((uint)style)) {}
		
		public Menu(string titel)
			: this(titel, 0) {}
		
		public Menu(string titel, long style)
			: this(wxMenu_ctor(titel, (uint)style)) { }

		public Menu(IntPtr wxObject)
			: base(wxObject) { }
			
		//---------------------------------------------------------------------
			
		public void AddEvent(int inId, EventListener el, Object owner)
		{
			// This is the only way of handling menu selection events (maybe there is an other solution)
			// But for now we have to add the EventListener to the EventHandler of the invoking window,
			// otherwise nothing happens.
			// As long as we do not have an invoking window, which means, that for example the
			// MenuBar of this Menu isn't connected to a Frame, the EventListener gets only
			// added to the ArrayList, otherwise it gets directly added to the EventHandler of
			// the invoking window. When Frame.MenuBar is set, it will call ConnectEvents() 
			// for each Menu in MenuBar
			eventListeners.Add( new MenuListener( inId, el, owner ) );
			
			if ( eventsconnected )
				parent.AddCommandListener(Event.wxEVT_COMMAND_MENU_SELECTED, inId, el, owner);
		}	
		
		//---------------------------------------------------------------------
		// ConnectEvents gets only called from Window and Frame
		
		public void ConnectEvents(Window parent)
		{
			this.parent = parent;

			if ( eventListeners.Count > 0 )
			{
				foreach( MenuListener ml in eventListeners )
				{
					parent.AddCommandListener(Event.wxEVT_COMMAND_MENU_SELECTED, ml.id, ml.listener, ml.owner);
				}
			}
			
			eventsconnected = true;
		}
		
		//---------------------------------------------------------------------
		
		// This is for faster coding ;) and closes request on SourceForge ;))))
		// WL stands for with listener
		public MenuItem AppendWL(int id, string item, EventListener listener)
		{
			MenuItem tmpitem = Append(id, item, "");
			
			AddEvent( id, listener, tmpitem );
			
			return tmpitem;
		}
		
		public MenuItem AppendWL(int id, string item, string help, EventListener listener)
		{
			MenuItem tmpitem = Append(id, item, help, ItemKind.wxITEM_NORMAL);
			
			AddEvent( id, listener, tmpitem );
			
			return tmpitem;
		}
		
		public MenuItem AppendWL(int id, string item, string help, ItemKind kind, EventListener listener)
		{
			MenuItem tmpitem = Append(id, item, help, kind);
			
			AddEvent( id, listener, tmpitem );
			
			return tmpitem;
		}
		
		public MenuItem AppendWL(int id, string item, Menu subMenu, EventListener listener)
		{
			MenuItem tmpitem = Append(id, item, subMenu, "");
			
			AddEvent( id, listener, tmpitem );
			
			return tmpitem;
		}

		public MenuItem AppendWL(int id, string item, Menu subMenu, string help, EventListener listener)
		{
			MenuItem tmpitem = Append(id, item, subMenu, help);
			
			AddEvent( id, listener, tmpitem );
			
			return tmpitem;
		}

		public MenuItem Append(MenuItem item, EventListener listener) 
		{
			MenuItem tmpitem = Append(item);
			AddEvent(item.ID, listener, tmpitem);
			return tmpitem;
		}
	}
}
