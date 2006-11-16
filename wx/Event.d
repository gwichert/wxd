//-----------------------------------------------------------------------------
// wx.NET - Event.cs
//
// The wxEvent wrapper class.
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
	public class Event : Object
	{
		[DllImport("wx-c")] static extern int    wxEvent_GetEventType(IntPtr self);
		[DllImport("wx-c")] static extern int    wxEvent_GetId(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxEvent_GetSkipped(IntPtr self);
		[DllImport("wx-c")] static extern int    wxEvent_GetTimestamp(IntPtr self);
		[DllImport("wx-c")] static extern void   wxEvent_Skip(IntPtr self, bool skip);
		[DllImport("wx-c")] static extern IntPtr wxEvent_GetEventObject(IntPtr self);
	
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_BUTTON_CLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_CHECKBOX_CLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_CHOICE_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LISTBOX_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TEXT_UPDATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TEXT_ENTER();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TEXT_URL();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TEXT_MAXLEN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_MENU_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_SLIDER_UPDATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_RADIOBOX_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_VLBOX_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_COMBOBOX_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TOOL_RCLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TOOL_ENTER();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_SPINCTRL_UPDATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SOCKET();
		[DllImport("wx-c")] static extern int wxEvent_EVT_TIMER ();
		[DllImport("wx-c")] static extern int wxEvent_EVT_LEFT_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_LEFT_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MIDDLE_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MIDDLE_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_RIGHT_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_RIGHT_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MOTION();
		[DllImport("wx-c")] static extern int wxEvent_EVT_ENTER_WINDOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_LEAVE_WINDOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_LEFT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MIDDLE_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_RIGHT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SET_FOCUS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_KILL_FOCUS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CHILD_FOCUS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MOUSEWHEEL();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_LEFT_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_LEFT_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_MIDDLE_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_MIDDLE_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_RIGHT_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_RIGHT_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_MOTION();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_ENTER_WINDOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_LEAVE_WINDOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_LEFT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_MIDDLE_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_RIGHT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CHAR();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CHAR_HOOK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NAVIGATION_KEY();
		[DllImport("wx-c")] static extern int wxEvent_EVT_KEY_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_KEY_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SET_CURSOR();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_TOP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_BOTTOM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_LINEUP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_LINEDOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_PAGEUP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_PAGEDOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_THUMBTRACK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_THUMBRELEASE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLL_ENDSCROLL();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_TOP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_BOTTOM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_LINEUP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_LINEDOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_PAGEUP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_PAGEDOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_THUMBTRACK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SCROLLWIN_THUMBRELEASE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SIZE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MOVE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CLOSE_WINDOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_END_SESSION();
		[DllImport("wx-c")] static extern int wxEvent_EVT_QUERY_END_SESSION();
		[DllImport("wx-c")] static extern int wxEvent_EVT_ACTIVATE_APP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_POWER();
		[DllImport("wx-c")] static extern int wxEvent_EVT_ACTIVATE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CREATE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_DESTROY();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SHOW();
		[DllImport("wx-c")] static extern int wxEvent_EVT_ICONIZE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MAXIMIZE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MOUSE_CAPTURE_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_PAINT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_ERASE_BACKGROUND();
		[DllImport("wx-c")] static extern int wxEvent_EVT_NC_PAINT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_PAINT_ICON();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MENU_OPEN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MENU_CLOSE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MENU_HIGHLIGHT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CONTEXT_MENU();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SYS_COLOUR_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_DISPLAY_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SETTING_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_QUERY_NEW_PALETTE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_PALETTE_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_JOY_BUTTON_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_JOY_BUTTON_UP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_JOY_MOVE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_JOY_ZMOVE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_DROP_FILES();
		[DllImport("wx-c")] static extern int wxEvent_EVT_DRAW_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MEASURE_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMPARE_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_INIT_DIALOG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_IDLE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_UPDATE_UI();
		[DllImport("wx-c")] static extern int wxEvent_EVT_SIZING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_MOVING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LEFT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LEFT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_RIGHT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_SET_FOCUS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_KILL_FOCUS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_ENTER();
		[DllImport("wx-c")] static extern int wxEvent_EVT_HELP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_DETAILED_HELP();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_OBJECTDELETED();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_SEL_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_DAY_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_MONTH_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_YEAR_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_DOUBLECLICKED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_FIND();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_FIND_NEXT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_FIND_REPLACE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_FIND_REPLACE_ALL();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_FIND_CLOSE();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_DELETE_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_GET_INFO();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_SET_INFO();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_SEL_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_SEL_CHANGING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_KEY_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TREE_END_DRAG();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_DELETE_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_GET_INFO();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_SET_INFO();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_KEY_DOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_INSERT_ITEM();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_COL_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_COL_DRAGGING();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_COL_END_DRAG();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LIST_CACHE_HINT();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING();
	
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING();

#if __WXMSW__
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TAB_SEL_CHANGED();
		[DllImport("wx-c")] static extern int wxEvent_EVT_COMMAND_TAB_SEL_CHANGING();
#endif
        
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_CELL_LEFT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_CELL_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_CELL_LEFT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_CELL_RIGHT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_LABEL_LEFT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_LABEL_RIGHT_CLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_LABEL_LEFT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_ROW_SIZE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_COL_SIZE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_RANGE_SELECT();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_CELL_CHANGE();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_SELECT_CELL();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_EDITOR_SHOWN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_EDITOR_HIDDEN();
		[DllImport("wx-c")] static extern int wxEvent_EVT_GRID_EDITOR_CREATED();
		
		[DllImport("wx-c")] static extern int wxEvent_EVT_SASH_DRAGGED();
		
		[DllImport("wx-c")] static extern int wxEvent_EVT_QUERY_LAYOUT_INFO();
		[DllImport("wx-c")] static extern int wxEvent_EVT_CALCULATE_LAYOUT();
	
		//---------------------------------------------------------------------
	
		public static readonly int wxEVT_COMMAND_BUTTON_CLICKED = wxEvent_EVT_COMMAND_BUTTON_CLICKED();
		public static readonly int wxEVT_COMMAND_CHECKBOX_CLICKED = wxEvent_EVT_COMMAND_CHECKBOX_CLICKED();
		public static readonly int wxEVT_COMMAND_CHOICE_SELECTED = wxEvent_EVT_COMMAND_CHOICE_SELECTED();
		public static readonly int wxEVT_COMMAND_LISTBOX_SELECTED = wxEvent_EVT_COMMAND_LISTBOX_SELECTED();
		public static readonly int wxEVT_COMMAND_LISTBOX_DOUBLECLICKED = wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED();
		public static readonly int wxEVT_COMMAND_CHECKLISTBOX_TOGGLED = wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED();
		public static readonly int wxEVT_COMMAND_TEXT_UPDATED = wxEvent_EVT_COMMAND_TEXT_UPDATED();
		public static readonly int wxEVT_COMMAND_TEXT_ENTER = wxEvent_EVT_COMMAND_TEXT_ENTER();
		public static readonly int wxEVT_COMMAND_TEXT_URL = wxEvent_EVT_COMMAND_TEXT_URL();
		public static readonly int wxEVT_COMMAND_TEXT_MAXLEN = wxEvent_EVT_COMMAND_TEXT_MAXLEN();
		public static readonly int wxEVT_COMMAND_MENU_SELECTED = wxEvent_EVT_COMMAND_MENU_SELECTED();
		public static readonly int wxEVT_COMMAND_TOOL_CLICKED = wxEVT_COMMAND_MENU_SELECTED;
		public static readonly int wxEVT_COMMAND_SLIDER_UPDATED = wxEvent_EVT_COMMAND_SLIDER_UPDATED();
		public static readonly int wxEVT_COMMAND_RADIOBOX_SELECTED = wxEvent_EVT_COMMAND_RADIOBOX_SELECTED();
		public static readonly int wxEVT_COMMAND_RADIOBUTTON_SELECTED = wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED();
		public static readonly int wxEVT_COMMAND_SCROLLBAR_UPDATED = wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED();
		public static readonly int wxEVT_COMMAND_VLBOX_SELECTED = wxEvent_EVT_COMMAND_VLBOX_SELECTED();
		public static readonly int wxEVT_COMMAND_COMBOBOX_SELECTED = wxEvent_EVT_COMMAND_COMBOBOX_SELECTED();
		public static readonly int wxEVT_COMMAND_TOOL_RCLICKED = wxEvent_EVT_COMMAND_TOOL_RCLICKED();
		public static readonly int wxEVT_COMMAND_TOOL_ENTER = wxEvent_EVT_COMMAND_TOOL_ENTER();
		public static readonly int wxEVT_COMMAND_SPINCTRL_UPDATED = wxEvent_EVT_COMMAND_SPINCTRL_UPDATED();
		public static readonly int wxEVT_SOCKET = wxEvent_EVT_SOCKET();
		public static readonly int wxEVT_TIMER  = wxEvent_EVT_TIMER ();
		public static readonly int wxEVT_LEFT_DOWN = wxEvent_EVT_LEFT_DOWN();
		public static readonly int wxEVT_LEFT_UP = wxEvent_EVT_LEFT_UP();
		public static readonly int wxEVT_MIDDLE_DOWN = wxEvent_EVT_MIDDLE_DOWN();
		public static readonly int wxEVT_MIDDLE_UP = wxEvent_EVT_MIDDLE_UP();
		public static readonly int wxEVT_RIGHT_DOWN = wxEvent_EVT_RIGHT_DOWN();
		public static readonly int wxEVT_RIGHT_UP = wxEvent_EVT_RIGHT_UP();
		public static readonly int wxEVT_MOTION = wxEvent_EVT_MOTION();
		public static readonly int wxEVT_ENTER_WINDOW = wxEvent_EVT_ENTER_WINDOW();
		public static readonly int wxEVT_LEAVE_WINDOW = wxEvent_EVT_LEAVE_WINDOW();
		public static readonly int wxEVT_LEFT_DCLICK = wxEvent_EVT_LEFT_DCLICK();
		public static readonly int wxEVT_MIDDLE_DCLICK = wxEvent_EVT_MIDDLE_DCLICK();
		public static readonly int wxEVT_RIGHT_DCLICK = wxEvent_EVT_RIGHT_DCLICK();
		public static readonly int wxEVT_SET_FOCUS = wxEvent_EVT_SET_FOCUS();
		public static readonly int wxEVT_KILL_FOCUS = wxEvent_EVT_KILL_FOCUS();
		public static readonly int wxEVT_CHILD_FOCUS = wxEvent_EVT_CHILD_FOCUS();
		public static readonly int wxEVT_MOUSEWHEEL = wxEvent_EVT_MOUSEWHEEL();
		public static readonly int wxEVT_NC_LEFT_DOWN = wxEvent_EVT_NC_LEFT_DOWN();
		public static readonly int wxEVT_NC_LEFT_UP = wxEvent_EVT_NC_LEFT_UP();
		public static readonly int wxEVT_NC_MIDDLE_DOWN = wxEvent_EVT_NC_MIDDLE_DOWN();
		public static readonly int wxEVT_NC_MIDDLE_UP = wxEvent_EVT_NC_MIDDLE_UP();
		public static readonly int wxEVT_NC_RIGHT_DOWN = wxEvent_EVT_NC_RIGHT_DOWN();
		public static readonly int wxEVT_NC_RIGHT_UP = wxEvent_EVT_NC_RIGHT_UP();
		public static readonly int wxEVT_NC_MOTION = wxEvent_EVT_NC_MOTION();
		public static readonly int wxEVT_NC_ENTER_WINDOW = wxEvent_EVT_NC_ENTER_WINDOW();
		public static readonly int wxEVT_NC_LEAVE_WINDOW = wxEvent_EVT_NC_LEAVE_WINDOW();
		public static readonly int wxEVT_NC_LEFT_DCLICK = wxEvent_EVT_NC_LEFT_DCLICK();
		public static readonly int wxEVT_NC_MIDDLE_DCLICK = wxEvent_EVT_NC_MIDDLE_DCLICK();
		public static readonly int wxEVT_NC_RIGHT_DCLICK = wxEvent_EVT_NC_RIGHT_DCLICK();
		public static readonly int wxEVT_CHAR = wxEvent_EVT_CHAR();
		public static readonly int wxEVT_CHAR_HOOK = wxEvent_EVT_CHAR_HOOK();
		public static readonly int wxEVT_NAVIGATION_KEY = wxEvent_EVT_NAVIGATION_KEY();
		public static readonly int wxEVT_KEY_DOWN = wxEvent_EVT_KEY_DOWN();
		public static readonly int wxEVT_KEY_UP = wxEvent_EVT_KEY_UP();
		public static readonly int wxEVT_SET_CURSOR = wxEvent_EVT_SET_CURSOR();
		public static readonly int wxEVT_SCROLL_TOP = wxEvent_EVT_SCROLL_TOP();
		public static readonly int wxEVT_SCROLL_BOTTOM = wxEvent_EVT_SCROLL_BOTTOM();
		public static readonly int wxEVT_SCROLL_LINEUP = wxEvent_EVT_SCROLL_LINEUP();
		public static readonly int wxEVT_SCROLL_LINEDOWN = wxEvent_EVT_SCROLL_LINEDOWN();
		public static readonly int wxEVT_SCROLL_PAGEUP = wxEvent_EVT_SCROLL_PAGEUP();
		public static readonly int wxEVT_SCROLL_PAGEDOWN = wxEvent_EVT_SCROLL_PAGEDOWN();
		public static readonly int wxEVT_SCROLL_THUMBTRACK = wxEvent_EVT_SCROLL_THUMBTRACK();
		public static readonly int wxEVT_SCROLL_THUMBRELEASE = wxEvent_EVT_SCROLL_THUMBRELEASE();
		public static readonly int wxEVT_SCROLL_ENDSCROLL = wxEvent_EVT_SCROLL_ENDSCROLL();
		public static readonly int wxEVT_SCROLLWIN_TOP = wxEvent_EVT_SCROLLWIN_TOP();
		public static readonly int wxEVT_SCROLLWIN_BOTTOM = wxEvent_EVT_SCROLLWIN_BOTTOM();
		public static readonly int wxEVT_SCROLLWIN_LINEUP = wxEvent_EVT_SCROLLWIN_LINEUP();
		public static readonly int wxEVT_SCROLLWIN_LINEDOWN = wxEvent_EVT_SCROLLWIN_LINEDOWN();
		public static readonly int wxEVT_SCROLLWIN_PAGEUP = wxEvent_EVT_SCROLLWIN_PAGEUP();
		public static readonly int wxEVT_SCROLLWIN_PAGEDOWN = wxEvent_EVT_SCROLLWIN_PAGEDOWN();
		public static readonly int wxEVT_SCROLLWIN_THUMBTRACK = wxEvent_EVT_SCROLLWIN_THUMBTRACK();
		public static readonly int wxEVT_SCROLLWIN_THUMBRELEASE = wxEvent_EVT_SCROLLWIN_THUMBRELEASE();
		public static readonly int wxEVT_SIZE = wxEvent_EVT_SIZE();
		public static readonly int wxEVT_MOVE = wxEvent_EVT_MOVE();
		public static readonly int wxEVT_CLOSE_WINDOW = wxEvent_EVT_CLOSE_WINDOW();
		public static readonly int wxEVT_END_SESSION = wxEvent_EVT_END_SESSION();
		public static readonly int wxEVT_QUERY_END_SESSION = wxEvent_EVT_QUERY_END_SESSION();
		public static readonly int wxEVT_ACTIVATE_APP = wxEvent_EVT_ACTIVATE_APP();
		public static readonly int wxEVT_POWER = wxEvent_EVT_POWER();
		public static readonly int wxEVT_ACTIVATE = wxEvent_EVT_ACTIVATE();
		public static readonly int wxEVT_CREATE = wxEvent_EVT_CREATE();
		public static readonly int wxEVT_DESTROY = wxEvent_EVT_DESTROY();
		public static readonly int wxEVT_SHOW = wxEvent_EVT_SHOW();
		public static readonly int wxEVT_ICONIZE = wxEvent_EVT_ICONIZE();
		public static readonly int wxEVT_MAXIMIZE = wxEvent_EVT_MAXIMIZE();
		public static readonly int wxEVT_MOUSE_CAPTURE_CHANGED = wxEvent_EVT_MOUSE_CAPTURE_CHANGED();
		public static readonly int wxEVT_PAINT = wxEvent_EVT_PAINT();
		public static readonly int wxEVT_ERASE_BACKGROUND = wxEvent_EVT_ERASE_BACKGROUND();
		public static readonly int wxEVT_NC_PAINT = wxEvent_EVT_NC_PAINT();
		public static readonly int wxEVT_PAINT_ICON = wxEvent_EVT_PAINT_ICON();
		public static readonly int wxEVT_MENU_OPEN = wxEvent_EVT_MENU_OPEN();
		public static readonly int wxEVT_MENU_CLOSE = wxEvent_EVT_MENU_CLOSE();
		public static readonly int wxEVT_MENU_HIGHLIGHT = wxEvent_EVT_MENU_HIGHLIGHT();
		public static readonly int wxEVT_CONTEXT_MENU = wxEvent_EVT_CONTEXT_MENU();
		public static readonly int wxEVT_SYS_COLOUR_CHANGED = wxEvent_EVT_SYS_COLOUR_CHANGED();
		public static readonly int wxEVT_DISPLAY_CHANGED = wxEvent_EVT_DISPLAY_CHANGED();
		public static readonly int wxEVT_SETTING_CHANGED = wxEvent_EVT_SETTING_CHANGED();
		public static readonly int wxEVT_QUERY_NEW_PALETTE = wxEvent_EVT_QUERY_NEW_PALETTE();
		public static readonly int wxEVT_PALETTE_CHANGED = wxEvent_EVT_PALETTE_CHANGED();
		public static readonly int wxEVT_JOY_BUTTON_DOWN = wxEvent_EVT_JOY_BUTTON_DOWN();
		public static readonly int wxEVT_JOY_BUTTON_UP = wxEvent_EVT_JOY_BUTTON_UP();
		public static readonly int wxEVT_JOY_MOVE = wxEvent_EVT_JOY_MOVE();
		public static readonly int wxEVT_JOY_ZMOVE = wxEvent_EVT_JOY_ZMOVE();
		public static readonly int wxEVT_DROP_FILES = wxEvent_EVT_DROP_FILES();
		public static readonly int wxEVT_DRAW_ITEM = wxEvent_EVT_DRAW_ITEM();
		public static readonly int wxEVT_MEASURE_ITEM = wxEvent_EVT_MEASURE_ITEM();
		public static readonly int wxEVT_COMPARE_ITEM = wxEvent_EVT_COMPARE_ITEM();
		public static readonly int wxEVT_INIT_DIALOG = wxEvent_EVT_INIT_DIALOG();
		public static readonly int wxEVT_IDLE = wxEvent_EVT_IDLE();
		public static readonly int wxEVT_UPDATE_UI = wxEvent_EVT_UPDATE_UI();
		public static readonly int wxEVT_SIZING = wxEvent_EVT_SIZING();
		public static readonly int wxEVT_MOVING = wxEvent_EVT_MOVING();
		public static readonly int wxEVT_COMMAND_LEFT_CLICK = wxEvent_EVT_COMMAND_LEFT_CLICK();
		public static readonly int wxEVT_COMMAND_LEFT_DCLICK = wxEvent_EVT_COMMAND_LEFT_DCLICK();
		public static readonly int wxEVT_COMMAND_RIGHT_CLICK = wxEvent_EVT_COMMAND_RIGHT_CLICK();
		public static readonly int wxEVT_COMMAND_RIGHT_DCLICK = wxEvent_EVT_COMMAND_RIGHT_DCLICK();
		public static readonly int wxEVT_COMMAND_SET_FOCUS = wxEvent_EVT_COMMAND_SET_FOCUS();
		public static readonly int wxEVT_COMMAND_KILL_FOCUS = wxEvent_EVT_COMMAND_KILL_FOCUS();
		public static readonly int wxEVT_COMMAND_ENTER = wxEvent_EVT_COMMAND_ENTER();
		public static readonly int wxEVT_HELP = wxEvent_EVT_HELP();
		public static readonly int wxEVT_DETAILED_HELP = wxEvent_EVT_DETAILED_HELP();
		public static readonly int wxEVT_COMMAND_TOGGLEBUTTON_CLICKED = wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED();
		public static readonly int wxEVT_OBJECTDELETED = wxEvent_EVT_OBJECTDELETED();
	
		public static readonly int wxEVT_CALENDAR_SEL_CHANGED = wxEvent_EVT_CALENDAR_SEL_CHANGED();
		public static readonly int wxEVT_CALENDAR_DAY_CHANGED = wxEvent_EVT_CALENDAR_DAY_CHANGED();
		public static readonly int wxEVT_CALENDAR_MONTH_CHANGED = wxEvent_EVT_CALENDAR_MONTH_CHANGED();
		public static readonly int wxEVT_CALENDAR_YEAR_CHANGED = wxEvent_EVT_CALENDAR_YEAR_CHANGED();
		public static readonly int wxEVT_CALENDAR_DOUBLECLICKED = wxEvent_EVT_CALENDAR_DOUBLECLICKED();
		public static readonly int wxEVT_CALENDAR_WEEKDAY_CLICKED = wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED();
	
		public static readonly int wxEVT_COMMAND_FIND = wxEvent_EVT_COMMAND_FIND();
		public static readonly int wxEVT_COMMAND_FIND_NEXT = wxEvent_EVT_COMMAND_FIND_NEXT();
		public static readonly int wxEVT_COMMAND_FIND_REPLACE = wxEvent_EVT_COMMAND_FIND_REPLACE();
		public static readonly int wxEVT_COMMAND_FIND_REPLACE_ALL = wxEvent_EVT_COMMAND_FIND_REPLACE_ALL();
		public static readonly int wxEVT_COMMAND_FIND_CLOSE = wxEvent_EVT_COMMAND_FIND_CLOSE();
	
		public static readonly int wxEVT_COMMAND_TREE_BEGIN_DRAG = wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG();
		public static readonly int wxEVT_COMMAND_TREE_BEGIN_RDRAG = wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG();
		public static readonly int wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT = wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT();
		public static readonly int wxEVT_COMMAND_TREE_END_LABEL_EDIT = wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT();
		public static readonly int wxEVT_COMMAND_TREE_DELETE_ITEM = wxEvent_EVT_COMMAND_TREE_DELETE_ITEM();
		public static readonly int wxEVT_COMMAND_TREE_GET_INFO = wxEvent_EVT_COMMAND_TREE_GET_INFO();
		public static readonly int wxEVT_COMMAND_TREE_SET_INFO = wxEvent_EVT_COMMAND_TREE_SET_INFO();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_EXPANDED = wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_EXPANDING = wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_COLLAPSED = wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_COLLAPSING = wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING();
		public static readonly int wxEVT_COMMAND_TREE_SEL_CHANGED = wxEvent_EVT_COMMAND_TREE_SEL_CHANGED();
		public static readonly int wxEVT_COMMAND_TREE_SEL_CHANGING = wxEvent_EVT_COMMAND_TREE_SEL_CHANGING();
		public static readonly int wxEVT_COMMAND_TREE_KEY_DOWN = wxEvent_EVT_COMMAND_TREE_KEY_DOWN();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_ACTIVATED = wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK = wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK();
		public static readonly int wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK = wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK();
		public static readonly int wxEVT_COMMAND_TREE_END_DRAG = wxEvent_EVT_COMMAND_TREE_END_DRAG();
	
		public static readonly int wxEVT_COMMAND_LIST_BEGIN_DRAG = wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG();
		public static readonly int wxEVT_COMMAND_LIST_BEGIN_RDRAG = wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG();
		public static readonly int wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT = wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT();
		public static readonly int wxEVT_COMMAND_LIST_END_LABEL_EDIT = wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT();
		public static readonly int wxEVT_COMMAND_LIST_DELETE_ITEM = wxEvent_EVT_COMMAND_LIST_DELETE_ITEM();
		public static readonly int wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS = wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS();
		public static readonly int wxEVT_COMMAND_LIST_GET_INFO = wxEvent_EVT_COMMAND_LIST_GET_INFO();
		public static readonly int wxEVT_COMMAND_LIST_SET_INFO = wxEvent_EVT_COMMAND_LIST_SET_INFO();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_SELECTED = wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_DESELECTED = wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_ACTIVATED = wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_FOCUSED = wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK = wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK();
		public static readonly int wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK = wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK();
		public static readonly int wxEVT_COMMAND_LIST_KEY_DOWN = wxEvent_EVT_COMMAND_LIST_KEY_DOWN();
		public static readonly int wxEVT_COMMAND_LIST_INSERT_ITEM = wxEvent_EVT_COMMAND_LIST_INSERT_ITEM();
		public static readonly int wxEVT_COMMAND_LIST_COL_CLICK = wxEvent_EVT_COMMAND_LIST_COL_CLICK();
		public static readonly int wxEVT_COMMAND_LIST_COL_RIGHT_CLICK = wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK();
		public static readonly int wxEVT_COMMAND_LIST_COL_BEGIN_DRAG = wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG();
		public static readonly int wxEVT_COMMAND_LIST_COL_DRAGGING = wxEvent_EVT_COMMAND_LIST_COL_DRAGGING();
		public static readonly int wxEVT_COMMAND_LIST_COL_END_DRAG = wxEvent_EVT_COMMAND_LIST_COL_END_DRAG();
		public static readonly int wxEVT_COMMAND_LIST_CACHE_HINT = wxEvent_EVT_COMMAND_LIST_CACHE_HINT();
	
		public static readonly int wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED = wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED();
		public static readonly int wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING = wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING();
	
		public static readonly int wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED = wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED();
		public static readonly int wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING = wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING();

#if __WXMSW__
		public static readonly int wxEVT_COMMAND_TAB_SEL_CHANGED = wxEvent_EVT_COMMAND_TAB_SEL_CHANGED();
		public static readonly int wxEVT_COMMAND_TAB_SEL_CHANGING = wxEvent_EVT_COMMAND_TAB_SEL_CHANGING();
#endif

		public static readonly int wxEVT_GRID_CELL_LEFT_CLICK = wxEvent_EVT_GRID_CELL_LEFT_CLICK();
		public static readonly int wxEVT_GRID_CELL_RIGHT_CLICK = wxEvent_EVT_GRID_CELL_RIGHT_CLICK();
		public static readonly int wxEVT_GRID_CELL_LEFT_DCLICK = wxEvent_EVT_GRID_CELL_LEFT_DCLICK();
		public static readonly int wxEVT_GRID_CELL_RIGHT_DCLICK = wxEvent_EVT_GRID_CELL_RIGHT_DCLICK();
		public static readonly int wxEVT_GRID_LABEL_LEFT_CLICK = wxEvent_EVT_GRID_LABEL_LEFT_CLICK();
		public static readonly int wxEVT_GRID_LABEL_RIGHT_CLICK = wxEvent_EVT_GRID_LABEL_RIGHT_CLICK();
		public static readonly int wxEVT_GRID_LABEL_LEFT_DCLICK = wxEvent_EVT_GRID_LABEL_LEFT_DCLICK();
		public static readonly int wxEVT_GRID_LABEL_RIGHT_DCLICK = wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK();
		public static readonly int wxEVT_GRID_ROW_SIZE = wxEvent_EVT_GRID_ROW_SIZE();
		public static readonly int wxEVT_GRID_COL_SIZE = wxEvent_EVT_GRID_COL_SIZE();
		public static readonly int wxEVT_GRID_RANGE_SELECT = wxEvent_EVT_GRID_RANGE_SELECT();
		public static readonly int wxEVT_GRID_CELL_CHANGE = wxEvent_EVT_GRID_CELL_CHANGE();
		public static readonly int wxEVT_GRID_SELECT_CELL = wxEvent_EVT_GRID_SELECT_CELL();
		public static readonly int wxEVT_GRID_EDITOR_SHOWN = wxEvent_EVT_GRID_EDITOR_SHOWN();
		public static readonly int wxEVT_GRID_EDITOR_HIDDEN = wxEvent_EVT_GRID_EDITOR_HIDDEN();
		public static readonly int wxEVT_GRID_EDITOR_CREATED = wxEvent_EVT_GRID_EDITOR_CREATED();
		
		public static readonly int wxEVT_SASH_DRAGGED = wxEvent_EVT_SASH_DRAGGED();
		
		public static readonly int wxEVT_QUERY_LAYOUT_INFO = wxEvent_EVT_QUERY_LAYOUT_INFO();
		public static readonly int wxEVT_CALCULATE_LAYOUT = wxEvent_EVT_CALCULATE_LAYOUT();
		
		//---------------------------------------------------------------------
	
		protected static Hashtable typemap = new Hashtable();
	
		//---------------------------------------------------------------------
	
		static Event()
		{
			AddEventType(wxEVT_COMMAND_BUTTON_CLICKED,          typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_MENU_SELECTED,           typeof(CommandEvent));
		
			AddEventType(wxEVT_COMMAND_CHECKBOX_CLICKED,        typeof(CommandEvent));
		
			AddEventType(wxEVT_COMMAND_LISTBOX_SELECTED,        typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_LISTBOX_DOUBLECLICKED,   typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_CHOICE_SELECTED,         typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_COMBOBOX_SELECTED,       typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_TEXT_UPDATED,            typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_TEXT_ENTER,              typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_RADIOBOX_SELECTED,       typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_RADIOBUTTON_SELECTED,    typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_SLIDER_UPDATED,          typeof(CommandEvent));
			AddEventType(wxEVT_COMMAND_SPINCTRL_UPDATED,        typeof(CommandEvent));
		
			AddEventType(wxEVT_LEFT_UP,                         typeof(MouseEvent));
			AddEventType(wxEVT_RIGHT_UP,                        typeof(MouseEvent));
			AddEventType(wxEVT_MIDDLE_UP,                       typeof(MouseEvent));
			AddEventType(wxEVT_ENTER_WINDOW,                    typeof(MouseEvent));
			AddEventType(wxEVT_LEAVE_WINDOW,                    typeof(MouseEvent));
			AddEventType(wxEVT_LEFT_DOWN,                       typeof(MouseEvent));
			AddEventType(wxEVT_MIDDLE_DOWN,                     typeof(MouseEvent));
			AddEventType(wxEVT_RIGHT_DOWN,                      typeof(MouseEvent));
			AddEventType(wxEVT_LEFT_DCLICK,                     typeof(MouseEvent));
			AddEventType(wxEVT_RIGHT_DCLICK,                    typeof(MouseEvent));
			AddEventType(wxEVT_MIDDLE_DCLICK,                   typeof(MouseEvent));
			AddEventType(wxEVT_MOTION,                              typeof(MouseEvent));        
			
			AddEventType(wxEVT_SCROLL_THUMBTRACK,               typeof(SpinEvent));
			AddEventType(wxEVT_SCROLL_LINEUP,                   typeof(SpinEvent));
			AddEventType(wxEVT_SCROLL_LINEDOWN,                 typeof(SpinEvent));         
			
			AddEventType(wxEVT_UPDATE_UI,                       typeof(UpdateUIEvent));
		
			AddEventType(wxEVT_KEY_DOWN,                        typeof(KeyEvent));
			AddEventType(wxEVT_KEY_UP,                          typeof(KeyEvent));
			AddEventType(wxEVT_CHAR,                            typeof(KeyEvent));
			AddEventType(wxEVT_CHAR_HOOK,                       typeof(KeyEvent));
		
			AddEventType(wxEVT_CALENDAR_SEL_CHANGED,            typeof(CalendarEvent));
			AddEventType(wxEVT_CALENDAR_DAY_CHANGED,            typeof(CalendarEvent));
			AddEventType(wxEVT_CALENDAR_MONTH_CHANGED,          typeof(CalendarEvent));
			AddEventType(wxEVT_CALENDAR_YEAR_CHANGED,           typeof(CalendarEvent));
			AddEventType(wxEVT_CALENDAR_DOUBLECLICKED,          typeof(CalendarEvent));
			AddEventType(wxEVT_CALENDAR_WEEKDAY_CLICKED,        typeof(CalendarEvent));
		
			AddEventType(wxEVT_COMMAND_FIND,                    typeof(FindDialogEvent));
			AddEventType(wxEVT_COMMAND_FIND_NEXT,               typeof(FindDialogEvent));
			AddEventType(wxEVT_COMMAND_FIND_REPLACE,            typeof(FindDialogEvent));
			AddEventType(wxEVT_COMMAND_FIND_REPLACE_ALL,        typeof(FindDialogEvent));
			AddEventType(wxEVT_COMMAND_FIND_CLOSE,              typeof(FindDialogEvent));
		
			AddEventType(wxEVT_COMMAND_TREE_BEGIN_DRAG,         typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_BEGIN_RDRAG,        typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT,   typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_END_LABEL_EDIT,     typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_DELETE_ITEM,        typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_GET_INFO,           typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_SET_INFO,           typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_EXPANDED,      typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_EXPANDING,     typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_COLLAPSED,     typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_COLLAPSING,    typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_SEL_CHANGED,        typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_SEL_CHANGING,       typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_KEY_DOWN,           typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_ACTIVATED,     typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK,   typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK,  typeof(TreeEvent));
			AddEventType(wxEVT_COMMAND_TREE_END_DRAG,           typeof(TreeEvent));
			
			AddEventType(wxEVT_COMMAND_LIST_BEGIN_DRAG,         typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_BEGIN_RDRAG,        typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT,   typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_END_LABEL_EDIT,     typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_DELETE_ITEM,        typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS,   typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_GET_INFO, 	typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_SET_INFO,		typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_SELECTED,      typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_DESELECTED,    typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_ACTIVATED,     typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_FOCUSED,       typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK,  typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK,   typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_KEY_DOWN,           typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_INSERT_ITEM,        typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_COL_CLICK,          typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_COL_RIGHT_CLICK,    typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_COL_BEGIN_DRAG,     typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_COL_DRAGGING,       typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_COL_END_DRAG,       typeof(ListEvent));
			AddEventType(wxEVT_COMMAND_LIST_CACHE_HINT,         typeof(ListEvent));
		
			AddEventType(wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED,   typeof(NotebookEvent));
			AddEventType(wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING,  typeof(NotebookEvent));
		
			AddEventType(wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED,   typeof(ListbookEvent));
			AddEventType(wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING,  typeof(ListbookEvent));

#if __WXMSW__
			AddEventType(wxEVT_COMMAND_TAB_SEL_CHANGED,   typeof(TabEvent));
			AddEventType(wxEVT_COMMAND_TAB_SEL_CHANGING,  typeof(TabEvent));
#endif

			AddEventType(wxEVT_GRID_CELL_LEFT_CLICK,            typeof(GridEvent));
			AddEventType(wxEVT_GRID_CELL_RIGHT_CLICK,           typeof(GridEvent));
			AddEventType(wxEVT_GRID_CELL_LEFT_DCLICK,           typeof(GridEvent));
			AddEventType(wxEVT_GRID_CELL_RIGHT_DCLICK,          typeof(GridEvent));
			AddEventType(wxEVT_GRID_LABEL_LEFT_CLICK,           typeof(GridEvent));
			AddEventType(wxEVT_GRID_LABEL_RIGHT_CLICK,          typeof(GridEvent));
			AddEventType(wxEVT_GRID_LABEL_LEFT_DCLICK,          typeof(GridEvent));
			AddEventType(wxEVT_GRID_LABEL_RIGHT_DCLICK,         typeof(GridEvent));
			AddEventType(wxEVT_GRID_ROW_SIZE,                   typeof(GridSizeEvent));
			AddEventType(wxEVT_GRID_COL_SIZE,                   typeof(GridSizeEvent));
			AddEventType(wxEVT_GRID_RANGE_SELECT,               typeof(GridRangeSelectEvent));
			AddEventType(wxEVT_GRID_CELL_CHANGE,                typeof(GridEvent));
			AddEventType(wxEVT_GRID_SELECT_CELL,                typeof(GridEvent));
			AddEventType(wxEVT_GRID_EDITOR_SHOWN,               typeof(GridEvent));
			AddEventType(wxEVT_GRID_EDITOR_HIDDEN,              typeof(GridEvent));
			AddEventType(wxEVT_GRID_EDITOR_CREATED,             typeof(GridEditorCreatedEvent));        
			
			AddEventType(wxEVT_COMMAND_TOGGLEBUTTON_CLICKED,    typeof(CommandEvent));
			AddEventType(wxEVT_CLOSE_WINDOW,                    typeof(CloseEvent));
			AddEventType(wxEVT_END_SESSION,                     typeof(CloseEvent));
			AddEventType(wxEVT_QUERY_END_SESSION,               typeof(CloseEvent));
			AddEventType(wxEVT_ACTIVATE,                        typeof(ActivateEvent));
			AddEventType(wxEVT_MOVE,                            typeof(MoveEvent));
			AddEventType(wxEVT_SIZE,                            typeof(SizeEvent));
			
			AddEventType(wxEVT_SASH_DRAGGED,                    typeof(SashEvent));
			
			AddEventType(wxEVT_QUERY_LAYOUT_INFO,               typeof(QueryLayoutInfoEvent));
			AddEventType(wxEVT_CALCULATE_LAYOUT,                typeof(CalculateLayoutEvent));
			
			AddEventType(wxEVT_COMMAND_CHECKLISTBOX_TOGGLED,	typeof(CommandEvent));
			
			AddEventType(wxEVT_IDLE, 				typeof(IdleEvent));
			
			AddEventType(wxEVT_CHILD_FOCUS,				typeof(ChildFocusEvent));
			
			AddEventType(wxEVT_CONTEXT_MENU,			typeof(ContextMenuEvent));
			
			AddEventType(wxEVT_DISPLAY_CHANGED,			typeof(DisplayChangedEvent));
			
			AddEventType(wxEVT_ERASE_BACKGROUND,			typeof(EraseEvent));
			
			AddEventType(wxEVT_SET_FOCUS,				typeof(FocusEvent));
			AddEventType(wxEVT_KILL_FOCUS,				typeof(FocusEvent));
			
			AddEventType(wxEVT_HELP,				typeof(HelpEvent));
			AddEventType(wxEVT_DETAILED_HELP,			typeof(HelpEvent));
			
			AddEventType(wxEVT_ICONIZE,				typeof(IconizeEvent));
			
			AddEventType(wxEVT_INIT_DIALOG,				typeof(InitDialogEvent));
			
			AddEventType(wxEVT_MAXIMIZE,				typeof(MaximizeEvent));
			
			AddEventType(wxEVT_MOUSE_CAPTURE_CHANGED,		typeof(MouseCaptureChangedEvent));
			
			AddEventType(wxEVT_NAVIGATION_KEY,			typeof(NavigationKeyEvent));
			
			AddEventType(wxEVT_NC_PAINT,				typeof(NCPaintEvent));
			
			AddEventType(wxEVT_PALETTE_CHANGED,			typeof(PaletteChangedEvent));
			
			AddEventType(wxEVT_QUERY_NEW_PALETTE,			typeof(QueryNewPaletteEvent));
			
			AddEventType(wxEVT_SET_CURSOR,				typeof(SetCursorEvent));
			
			AddEventType(wxEVT_SHOW,				typeof(ShowEvent));
			
			AddEventType(wxEVT_SYS_COLOUR_CHANGED,			typeof(SysColourChangedEvent));
			
			AddEventType(wxEVT_CREATE,				typeof(WindowCreateEvent));
			AddEventType(wxEVT_DESTROY,				typeof(WindowDestroyEvent));
		}

		//---------------------------------------------------------------------

		public static void AddEventType(int evt, Type type)
		{
			typemap.Add(evt, type);
		}

		//---------------------------------------------------------------------

		public Event(IntPtr wxObject) 
			: base(wxObject) { }

		//---------------------------------------------------------------------

		internal static Event CreateFrom(IntPtr wxEvent)
		{
			// Check to see if this event type is in the type map

			int evtType = wxEvent_GetEventType(wxEvent);
			Type type = (Type)typemap[evtType];

			// If so, create an instance of the specified type

			Event e;
			if (type != null)
				e = (Event)Activator.CreateInstance(type, new object[]{wxEvent});
			else
				e = new Event(wxEvent);

			return e;
		}

		//---------------------------------------------------------------------

		public int EventType
		{
			get { return wxEvent_GetEventType(wxObject); }
		}

		//---------------------------------------------------------------------

		public int ID
		{
			get { return wxEvent_GetId(wxObject); }
		}

		//---------------------------------------------------------------------

		public void Skip()
		{ 
			Skip(true); 
		}

		public void Skip(bool skip)
		{
			wxEvent_Skip(wxObject, skip);
		}

		//---------------------------------------------------------------------

		public bool Skipped
		{
			get { return wxEvent_GetSkipped(wxObject); }
		}

		//---------------------------------------------------------------------

		public int Timestamp
		{
			get { return wxEvent_GetTimestamp(wxObject); }
		}

		//---------------------------------------------------------------------

		public Object EventObject
		{
			get { return FindObject(wxEvent_GetEventObject(wxObject)); }
		}

		//---------------------------------------------------------------------

		internal IntPtr EventIntPtr
		{
			get { return wxEvent_GetEventObject(wxObject); }
		}
	}
}
