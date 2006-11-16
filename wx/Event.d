//-----------------------------------------------------------------------------
// wxD - Event.d
//
// The wxEvent wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Event;
import wx.common;

		static extern (C) int    wxEvent_GetEventType(IntPtr self);
		static extern (C) int    wxEvent_GetId(IntPtr self);
		static extern (C) bool   wxEvent_GetSkipped(IntPtr self);
		static extern (C) int    wxEvent_GetTimestamp(IntPtr self);
		static extern (C) void   wxEvent_Skip(IntPtr self, bool skip);
		static extern (C) IntPtr wxEvent_GetEventObject(IntPtr self);
	
		//---------------------------------------------------------------------
	
		static extern (C) int wxEvent_EVT_COMMAND_BUTTON_CLICKED();
		static extern (C) int wxEvent_EVT_COMMAND_CHECKBOX_CLICKED();
		static extern (C) int wxEvent_EVT_COMMAND_CHOICE_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_LISTBOX_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED();
		static extern (C) int wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED();
		static extern (C) int wxEvent_EVT_COMMAND_TEXT_UPDATED();
		static extern (C) int wxEvent_EVT_COMMAND_TEXT_ENTER();
		static extern (C) int wxEvent_EVT_COMMAND_TEXT_URL();
		static extern (C) int wxEvent_EVT_COMMAND_TEXT_MAXLEN();
		static extern (C) int wxEvent_EVT_COMMAND_MENU_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_SLIDER_UPDATED();
		static extern (C) int wxEvent_EVT_COMMAND_RADIOBOX_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED();
		static extern (C) int wxEvent_EVT_COMMAND_VLBOX_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_COMBOBOX_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_TOOL_RCLICKED();
		static extern (C) int wxEvent_EVT_COMMAND_TOOL_ENTER();
		static extern (C) int wxEvent_EVT_COMMAND_SPINCTRL_UPDATED();
		static extern (C) int wxEvent_EVT_SOCKET();
		static extern (C) int wxEvent_EVT_TIMER ();
		static extern (C) int wxEvent_EVT_LEFT_DOWN();
		static extern (C) int wxEvent_EVT_LEFT_UP();
		static extern (C) int wxEvent_EVT_MIDDLE_DOWN();
		static extern (C) int wxEvent_EVT_MIDDLE_UP();
		static extern (C) int wxEvent_EVT_RIGHT_DOWN();
		static extern (C) int wxEvent_EVT_RIGHT_UP();
		static extern (C) int wxEvent_EVT_MOTION();
		static extern (C) int wxEvent_EVT_ENTER_WINDOW();
		static extern (C) int wxEvent_EVT_LEAVE_WINDOW();
		static extern (C) int wxEvent_EVT_LEFT_DCLICK();
		static extern (C) int wxEvent_EVT_MIDDLE_DCLICK();
		static extern (C) int wxEvent_EVT_RIGHT_DCLICK();
		static extern (C) int wxEvent_EVT_SET_FOCUS();
		static extern (C) int wxEvent_EVT_KILL_FOCUS();
		static extern (C) int wxEvent_EVT_CHILD_FOCUS();
		static extern (C) int wxEvent_EVT_MOUSEWHEEL();
		static extern (C) int wxEvent_EVT_NC_LEFT_DOWN();
		static extern (C) int wxEvent_EVT_NC_LEFT_UP();
		static extern (C) int wxEvent_EVT_NC_MIDDLE_DOWN();
		static extern (C) int wxEvent_EVT_NC_MIDDLE_UP();
		static extern (C) int wxEvent_EVT_NC_RIGHT_DOWN();
		static extern (C) int wxEvent_EVT_NC_RIGHT_UP();
		static extern (C) int wxEvent_EVT_NC_MOTION();
		static extern (C) int wxEvent_EVT_NC_ENTER_WINDOW();
		static extern (C) int wxEvent_EVT_NC_LEAVE_WINDOW();
		static extern (C) int wxEvent_EVT_NC_LEFT_DCLICK();
		static extern (C) int wxEvent_EVT_NC_MIDDLE_DCLICK();
		static extern (C) int wxEvent_EVT_NC_RIGHT_DCLICK();
		static extern (C) int wxEvent_EVT_CHAR();
		static extern (C) int wxEvent_EVT_CHAR_HOOK();
		static extern (C) int wxEvent_EVT_NAVIGATION_KEY();
		static extern (C) int wxEvent_EVT_KEY_DOWN();
		static extern (C) int wxEvent_EVT_KEY_UP();
		static extern (C) int wxEvent_EVT_SET_CURSOR();
		static extern (C) int wxEvent_EVT_SCROLL_TOP();
		static extern (C) int wxEvent_EVT_SCROLL_BOTTOM();
		static extern (C) int wxEvent_EVT_SCROLL_LINEUP();
		static extern (C) int wxEvent_EVT_SCROLL_LINEDOWN();
		static extern (C) int wxEvent_EVT_SCROLL_PAGEUP();
		static extern (C) int wxEvent_EVT_SCROLL_PAGEDOWN();
		static extern (C) int wxEvent_EVT_SCROLL_THUMBTRACK();
		static extern (C) int wxEvent_EVT_SCROLL_THUMBRELEASE();
		static extern (C) int wxEvent_EVT_SCROLL_ENDSCROLL();
		static extern (C) int wxEvent_EVT_SCROLLWIN_TOP();
		static extern (C) int wxEvent_EVT_SCROLLWIN_BOTTOM();
		static extern (C) int wxEvent_EVT_SCROLLWIN_LINEUP();
		static extern (C) int wxEvent_EVT_SCROLLWIN_LINEDOWN();
		static extern (C) int wxEvent_EVT_SCROLLWIN_PAGEUP();
		static extern (C) int wxEvent_EVT_SCROLLWIN_PAGEDOWN();
		static extern (C) int wxEvent_EVT_SCROLLWIN_THUMBTRACK();
		static extern (C) int wxEvent_EVT_SCROLLWIN_THUMBRELEASE();
		static extern (C) int wxEvent_EVT_SIZE();
		static extern (C) int wxEvent_EVT_MOVE();
		static extern (C) int wxEvent_EVT_CLOSE_WINDOW();
		static extern (C) int wxEvent_EVT_END_SESSION();
		static extern (C) int wxEvent_EVT_QUERY_END_SESSION();
		static extern (C) int wxEvent_EVT_ACTIVATE_APP();
		static extern (C) int wxEvent_EVT_POWER();
		static extern (C) int wxEvent_EVT_ACTIVATE();
		static extern (C) int wxEvent_EVT_CREATE();
		static extern (C) int wxEvent_EVT_DESTROY();
		static extern (C) int wxEvent_EVT_SHOW();
		static extern (C) int wxEvent_EVT_ICONIZE();
		static extern (C) int wxEvent_EVT_MAXIMIZE();
		static extern (C) int wxEvent_EVT_MOUSE_CAPTURE_CHANGED();
		static extern (C) int wxEvent_EVT_PAINT();
		static extern (C) int wxEvent_EVT_ERASE_BACKGROUND();
		static extern (C) int wxEvent_EVT_NC_PAINT();
		static extern (C) int wxEvent_EVT_PAINT_ICON();
		static extern (C) int wxEvent_EVT_MENU_OPEN();
		static extern (C) int wxEvent_EVT_MENU_CLOSE();
		static extern (C) int wxEvent_EVT_MENU_HIGHLIGHT();
		static extern (C) int wxEvent_EVT_CONTEXT_MENU();
		static extern (C) int wxEvent_EVT_SYS_COLOUR_CHANGED();
		static extern (C) int wxEvent_EVT_DISPLAY_CHANGED();
		static extern (C) int wxEvent_EVT_SETTING_CHANGED();
		static extern (C) int wxEvent_EVT_QUERY_NEW_PALETTE();
		static extern (C) int wxEvent_EVT_PALETTE_CHANGED();
		static extern (C) int wxEvent_EVT_JOY_BUTTON_DOWN();
		static extern (C) int wxEvent_EVT_JOY_BUTTON_UP();
		static extern (C) int wxEvent_EVT_JOY_MOVE();
		static extern (C) int wxEvent_EVT_JOY_ZMOVE();
		static extern (C) int wxEvent_EVT_DROP_FILES();
		static extern (C) int wxEvent_EVT_DRAW_ITEM();
		static extern (C) int wxEvent_EVT_MEASURE_ITEM();
		static extern (C) int wxEvent_EVT_COMPARE_ITEM();
		static extern (C) int wxEvent_EVT_INIT_DIALOG();
		static extern (C) int wxEvent_EVT_IDLE();
		static extern (C) int wxEvent_EVT_UPDATE_UI();
		static extern (C) int wxEvent_EVT_SIZING();
		static extern (C) int wxEvent_EVT_MOVING();
		static extern (C) int wxEvent_EVT_COMMAND_LEFT_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_LEFT_DCLICK();
		static extern (C) int wxEvent_EVT_COMMAND_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_RIGHT_DCLICK();
		static extern (C) int wxEvent_EVT_COMMAND_SET_FOCUS();
		static extern (C) int wxEvent_EVT_COMMAND_KILL_FOCUS();
		static extern (C) int wxEvent_EVT_COMMAND_ENTER();
		static extern (C) int wxEvent_EVT_HELP();
		static extern (C) int wxEvent_EVT_DETAILED_HELP();
		static extern (C) int wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED();
		static extern (C) int wxEvent_EVT_OBJECTDELETED();
	
		static extern (C) int wxEvent_EVT_CALENDAR_SEL_CHANGED();
		static extern (C) int wxEvent_EVT_CALENDAR_DAY_CHANGED();
		static extern (C) int wxEvent_EVT_CALENDAR_MONTH_CHANGED();
		static extern (C) int wxEvent_EVT_CALENDAR_YEAR_CHANGED();
		static extern (C) int wxEvent_EVT_CALENDAR_DOUBLECLICKED();
		static extern (C) int wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED();
	
		static extern (C) int wxEvent_EVT_COMMAND_FIND();
		static extern (C) int wxEvent_EVT_COMMAND_FIND_NEXT();
		static extern (C) int wxEvent_EVT_COMMAND_FIND_REPLACE();
		static extern (C) int wxEvent_EVT_COMMAND_FIND_REPLACE_ALL();
		static extern (C) int wxEvent_EVT_COMMAND_FIND_CLOSE();
	
		static extern (C) int wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_DELETE_ITEM();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_GET_INFO();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_SET_INFO();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_SEL_CHANGED();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_SEL_CHANGING();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_KEY_DOWN();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_TREE_END_DRAG();
	
		static extern (C) int wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_DELETE_ITEM();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_GET_INFO();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_SET_INFO();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_KEY_DOWN();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_INSERT_ITEM();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_COL_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_COL_DRAGGING();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_COL_END_DRAG();
		static extern (C) int wxEvent_EVT_COMMAND_LIST_CACHE_HINT();
	
		static extern (C) int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED();
		static extern (C) int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING();
	
		static extern (C) int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED();
		static extern (C) int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING();

version(__WXMSW__){
		static extern (C) int wxEvent_EVT_COMMAND_TAB_SEL_CHANGED();
		static extern (C) int wxEvent_EVT_COMMAND_TAB_SEL_CHANGING();
}        
		static extern (C) int wxEvent_EVT_GRID_CELL_LEFT_CLICK();
		static extern (C) int wxEvent_EVT_GRID_CELL_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_GRID_CELL_LEFT_DCLICK();
		static extern (C) int wxEvent_EVT_GRID_CELL_RIGHT_DCLICK();
		static extern (C) int wxEvent_EVT_GRID_LABEL_LEFT_CLICK();
		static extern (C) int wxEvent_EVT_GRID_LABEL_RIGHT_CLICK();
		static extern (C) int wxEvent_EVT_GRID_LABEL_LEFT_DCLICK();
		static extern (C) int wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK();
		static extern (C) int wxEvent_EVT_GRID_ROW_SIZE();
		static extern (C) int wxEvent_EVT_GRID_COL_SIZE();
		static extern (C) int wxEvent_EVT_GRID_RANGE_SELECT();
		static extern (C) int wxEvent_EVT_GRID_CELL_CHANGE();
		static extern (C) int wxEvent_EVT_GRID_SELECT_CELL();
		static extern (C) int wxEvent_EVT_GRID_EDITOR_SHOWN();
		static extern (C) int wxEvent_EVT_GRID_EDITOR_HIDDEN();
		static extern (C) int wxEvent_EVT_GRID_EDITOR_CREATED();
		
		static extern (C) int wxEvent_EVT_SASH_DRAGGED();
		
		static extern (C) int wxEvent_EVT_QUERY_LAYOUT_INFO();
		static extern (C) int wxEvent_EVT_CALCULATE_LAYOUT();
	
		//---------------------------------------------------------------------
	
	public class Event : wxObject
	{
		public static /*readonly*/ int wxEVT_COMMAND_BUTTON_CLICKED;
		public static /*readonly*/ int wxEVT_COMMAND_CHECKBOX_CLICKED;
		public static /*readonly*/ int wxEVT_COMMAND_CHOICE_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_LISTBOX_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_LISTBOX_DOUBLECLICKED;
		public static /*readonly*/ int wxEVT_COMMAND_CHECKLISTBOX_TOGGLED;
		public static /*readonly*/ int wxEVT_COMMAND_TEXT_UPDATED;
		public static /*readonly*/ int wxEVT_COMMAND_TEXT_ENTER;
		public static /*readonly*/ int wxEVT_COMMAND_TEXT_URL;
		public static /*readonly*/ int wxEVT_COMMAND_TEXT_MAXLEN;
		public static /*readonly*/ int wxEVT_COMMAND_MENU_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_TOOL_CLICKED;
		public static /*readonly*/ int wxEVT_COMMAND_SLIDER_UPDATED;
		public static /*readonly*/ int wxEVT_COMMAND_RADIOBOX_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_RADIOBUTTON_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_SCROLLBAR_UPDATED;
		public static /*readonly*/ int wxEVT_COMMAND_VLBOX_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_COMBOBOX_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_TOOL_RCLICKED;
		public static /*readonly*/ int wxEVT_COMMAND_TOOL_ENTER;
		public static /*readonly*/ int wxEVT_COMMAND_SPINCTRL_UPDATED;
		public static /*readonly*/ int wxEVT_SOCKET;
		public static /*readonly*/ int wxEVT_TIMER ;
		public static /*readonly*/ int wxEVT_LEFT_DOWN;
		public static /*readonly*/ int wxEVT_LEFT_UP;
		public static /*readonly*/ int wxEVT_MIDDLE_DOWN;
		public static /*readonly*/ int wxEVT_MIDDLE_UP;
		public static /*readonly*/ int wxEVT_RIGHT_DOWN;
		public static /*readonly*/ int wxEVT_RIGHT_UP;
		public static /*readonly*/ int wxEVT_MOTION;
		public static /*readonly*/ int wxEVT_ENTER_WINDOW;
		public static /*readonly*/ int wxEVT_LEAVE_WINDOW;
		public static /*readonly*/ int wxEVT_LEFT_DCLICK;
		public static /*readonly*/ int wxEVT_MIDDLE_DCLICK;
		public static /*readonly*/ int wxEVT_RIGHT_DCLICK;
		public static /*readonly*/ int wxEVT_SET_FOCUS;
		public static /*readonly*/ int wxEVT_KILL_FOCUS;
		public static /*readonly*/ int wxEVT_CHILD_FOCUS;
		public static /*readonly*/ int wxEVT_MOUSEWHEEL;
		public static /*readonly*/ int wxEVT_NC_LEFT_DOWN;
		public static /*readonly*/ int wxEVT_NC_LEFT_UP;
		public static /*readonly*/ int wxEVT_NC_MIDDLE_DOWN;
		public static /*readonly*/ int wxEVT_NC_MIDDLE_UP;
		public static /*readonly*/ int wxEVT_NC_RIGHT_DOWN;
		public static /*readonly*/ int wxEVT_NC_RIGHT_UP;
		public static /*readonly*/ int wxEVT_NC_MOTION;
		public static /*readonly*/ int wxEVT_NC_ENTER_WINDOW;
		public static /*readonly*/ int wxEVT_NC_LEAVE_WINDOW;
		public static /*readonly*/ int wxEVT_NC_LEFT_DCLICK;
		public static /*readonly*/ int wxEVT_NC_MIDDLE_DCLICK;
		public static /*readonly*/ int wxEVT_NC_RIGHT_DCLICK;
		public static /*readonly*/ int wxEVT_CHAR;
		public static /*readonly*/ int wxEVT_CHAR_HOOK;
		public static /*readonly*/ int wxEVT_NAVIGATION_KEY;
		public static /*readonly*/ int wxEVT_KEY_DOWN;
		public static /*readonly*/ int wxEVT_KEY_UP;
		public static /*readonly*/ int wxEVT_SET_CURSOR;
		public static /*readonly*/ int wxEVT_SCROLL_TOP;
		public static /*readonly*/ int wxEVT_SCROLL_BOTTOM;
		public static /*readonly*/ int wxEVT_SCROLL_LINEUP;
		public static /*readonly*/ int wxEVT_SCROLL_LINEDOWN;
		public static /*readonly*/ int wxEVT_SCROLL_PAGEUP;
		public static /*readonly*/ int wxEVT_SCROLL_PAGEDOWN;
		public static /*readonly*/ int wxEVT_SCROLL_THUMBTRACK;
		public static /*readonly*/ int wxEVT_SCROLL_THUMBRELEASE;
		public static /*readonly*/ int wxEVT_SCROLL_ENDSCROLL;
		public static /*readonly*/ int wxEVT_SCROLLWIN_TOP;
		public static /*readonly*/ int wxEVT_SCROLLWIN_BOTTOM;
		public static /*readonly*/ int wxEVT_SCROLLWIN_LINEUP;
		public static /*readonly*/ int wxEVT_SCROLLWIN_LINEDOWN;
		public static /*readonly*/ int wxEVT_SCROLLWIN_PAGEUP;
		public static /*readonly*/ int wxEVT_SCROLLWIN_PAGEDOWN;
		public static /*readonly*/ int wxEVT_SCROLLWIN_THUMBTRACK;
		public static /*readonly*/ int wxEVT_SCROLLWIN_THUMBRELEASE;
		public static /*readonly*/ int wxEVT_SIZE;
		public static /*readonly*/ int wxEVT_MOVE;
		public static /*readonly*/ int wxEVT_CLOSE_WINDOW;
		public static /*readonly*/ int wxEVT_END_SESSION;
		public static /*readonly*/ int wxEVT_QUERY_END_SESSION;
		public static /*readonly*/ int wxEVT_ACTIVATE_APP;
		public static /*readonly*/ int wxEVT_POWER;
		public static /*readonly*/ int wxEVT_ACTIVATE;
		public static /*readonly*/ int wxEVT_CREATE;
		public static /*readonly*/ int wxEVT_DESTROY;
		public static /*readonly*/ int wxEVT_SHOW;
		public static /*readonly*/ int wxEVT_ICONIZE;
		public static /*readonly*/ int wxEVT_MAXIMIZE;
		public static /*readonly*/ int wxEVT_MOUSE_CAPTURE_CHANGED;
		public static /*readonly*/ int wxEVT_PAINT;
		public static /*readonly*/ int wxEVT_ERASE_BACKGROUND;
		public static /*readonly*/ int wxEVT_NC_PAINT;
		public static /*readonly*/ int wxEVT_PAINT_ICON;
		public static /*readonly*/ int wxEVT_MENU_OPEN;
		public static /*readonly*/ int wxEVT_MENU_CLOSE;
		public static /*readonly*/ int wxEVT_MENU_HIGHLIGHT;
		public static /*readonly*/ int wxEVT_CONTEXT_MENU;
		public static /*readonly*/ int wxEVT_SYS_COLOUR_CHANGED;
		public static /*readonly*/ int wxEVT_DISPLAY_CHANGED;
		public static /*readonly*/ int wxEVT_SETTING_CHANGED;
		public static /*readonly*/ int wxEVT_QUERY_NEW_PALETTE;
		public static /*readonly*/ int wxEVT_PALETTE_CHANGED;
		public static /*readonly*/ int wxEVT_JOY_BUTTON_DOWN;
		public static /*readonly*/ int wxEVT_JOY_BUTTON_UP;
		public static /*readonly*/ int wxEVT_JOY_MOVE;
		public static /*readonly*/ int wxEVT_JOY_ZMOVE;
		public static /*readonly*/ int wxEVT_DROP_FILES;
		public static /*readonly*/ int wxEVT_DRAW_ITEM;
		public static /*readonly*/ int wxEVT_MEASURE_ITEM;
		public static /*readonly*/ int wxEVT_COMPARE_ITEM;
		public static /*readonly*/ int wxEVT_INIT_DIALOG;
		public static /*readonly*/ int wxEVT_IDLE;
		public static /*readonly*/ int wxEVT_UPDATE_UI;
		public static /*readonly*/ int wxEVT_SIZING;
		public static /*readonly*/ int wxEVT_MOVING;
		public static /*readonly*/ int wxEVT_COMMAND_LEFT_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_LEFT_DCLICK;
		public static /*readonly*/ int wxEVT_COMMAND_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_RIGHT_DCLICK;
		public static /*readonly*/ int wxEVT_COMMAND_SET_FOCUS;
		public static /*readonly*/ int wxEVT_COMMAND_KILL_FOCUS;
		public static /*readonly*/ int wxEVT_COMMAND_ENTER;
		public static /*readonly*/ int wxEVT_HELP;
		public static /*readonly*/ int wxEVT_DETAILED_HELP;
		public static /*readonly*/ int wxEVT_COMMAND_TOGGLEBUTTON_CLICKED;
		public static /*readonly*/ int wxEVT_OBJECTDELETED;
	
		public static /*readonly*/ int wxEVT_CALENDAR_SEL_CHANGED;
		public static /*readonly*/ int wxEVT_CALENDAR_DAY_CHANGED;
		public static /*readonly*/ int wxEVT_CALENDAR_MONTH_CHANGED;
		public static /*readonly*/ int wxEVT_CALENDAR_YEAR_CHANGED;
		public static /*readonly*/ int wxEVT_CALENDAR_DOUBLECLICKED;
		public static /*readonly*/ int wxEVT_CALENDAR_WEEKDAY_CLICKED;
	
		public static /*readonly*/ int wxEVT_COMMAND_FIND;
		public static /*readonly*/ int wxEVT_COMMAND_FIND_NEXT;
		public static /*readonly*/ int wxEVT_COMMAND_FIND_REPLACE;
		public static /*readonly*/ int wxEVT_COMMAND_FIND_REPLACE_ALL;
		public static /*readonly*/ int wxEVT_COMMAND_FIND_CLOSE;
	
		public static /*readonly*/ int wxEVT_COMMAND_TREE_BEGIN_DRAG;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_BEGIN_RDRAG;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_END_LABEL_EDIT;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_DELETE_ITEM;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_GET_INFO;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_SET_INFO;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_EXPANDED;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_EXPANDING;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_COLLAPSED;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_COLLAPSING;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_SEL_CHANGED;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_SEL_CHANGING;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_KEY_DOWN;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_ACTIVATED;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_TREE_END_DRAG;
	
		public static /*readonly*/ int wxEVT_COMMAND_LIST_BEGIN_DRAG;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_BEGIN_RDRAG;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_END_LABEL_EDIT;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_DELETE_ITEM;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_GET_INFO;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_SET_INFO;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_SELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_DESELECTED;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_ACTIVATED;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_FOCUSED;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_KEY_DOWN;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_INSERT_ITEM;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_COL_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_COL_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_COL_BEGIN_DRAG;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_COL_DRAGGING;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_COL_END_DRAG;
		public static /*readonly*/ int wxEVT_COMMAND_LIST_CACHE_HINT;
	
		public static /*readonly*/ int wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED;
		public static /*readonly*/ int wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING;
	
		public static /*readonly*/ int wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED;
		public static /*readonly*/ int wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING;

version(__WXMSW__){
		public static /*readonly*/ int wxEVT_COMMAND_TAB_SEL_CHANGED;
		public static /*readonly*/ int wxEVT_COMMAND_TAB_SEL_CHANGING;
}
		public static /*readonly*/ int wxEVT_GRID_CELL_LEFT_CLICK;
		public static /*readonly*/ int wxEVT_GRID_CELL_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_GRID_CELL_LEFT_DCLICK;
		public static /*readonly*/ int wxEVT_GRID_CELL_RIGHT_DCLICK;
		public static /*readonly*/ int wxEVT_GRID_LABEL_LEFT_CLICK;
		public static /*readonly*/ int wxEVT_GRID_LABEL_RIGHT_CLICK;
		public static /*readonly*/ int wxEVT_GRID_LABEL_LEFT_DCLICK;
		public static /*readonly*/ int wxEVT_GRID_LABEL_RIGHT_DCLICK;
		public static /*readonly*/ int wxEVT_GRID_ROW_SIZE;
		public static /*readonly*/ int wxEVT_GRID_COL_SIZE;
		public static /*readonly*/ int wxEVT_GRID_RANGE_SELECT;
		public static /*readonly*/ int wxEVT_GRID_CELL_CHANGE;
		public static /*readonly*/ int wxEVT_GRID_SELECT_CELL;
		public static /*readonly*/ int wxEVT_GRID_EDITOR_SHOWN;
		public static /*readonly*/ int wxEVT_GRID_EDITOR_HIDDEN;
		public static /*readonly*/ int wxEVT_GRID_EDITOR_CREATED;
		
		public static /*readonly*/ int wxEVT_SASH_DRAGGED;
		
		public static /*readonly*/ int wxEVT_QUERY_LAYOUT_INFO;
		public static /*readonly*/ int wxEVT_CALCULATE_LAYOUT;

		static this()
		{
			wxEVT_COMMAND_BUTTON_CLICKED = wxEvent_EVT_COMMAND_BUTTON_CLICKED();
			wxEVT_COMMAND_CHECKBOX_CLICKED = wxEvent_EVT_COMMAND_CHECKBOX_CLICKED();
			wxEVT_COMMAND_CHOICE_SELECTED = wxEvent_EVT_COMMAND_CHOICE_SELECTED();
			wxEVT_COMMAND_LISTBOX_SELECTED = wxEvent_EVT_COMMAND_LISTBOX_SELECTED();
			wxEVT_COMMAND_LISTBOX_DOUBLECLICKED = wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED();
			wxEVT_COMMAND_CHECKLISTBOX_TOGGLED = wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED();
			wxEVT_COMMAND_TEXT_UPDATED = wxEvent_EVT_COMMAND_TEXT_UPDATED();
			wxEVT_COMMAND_TEXT_ENTER = wxEvent_EVT_COMMAND_TEXT_ENTER();
			wxEVT_COMMAND_TEXT_URL = wxEvent_EVT_COMMAND_TEXT_URL();
			wxEVT_COMMAND_TEXT_MAXLEN = wxEvent_EVT_COMMAND_TEXT_MAXLEN();
			wxEVT_COMMAND_MENU_SELECTED = wxEvent_EVT_COMMAND_MENU_SELECTED();
			wxEVT_COMMAND_TOOL_CLICKED = wxEVT_COMMAND_MENU_SELECTED;
			wxEVT_COMMAND_SLIDER_UPDATED = wxEvent_EVT_COMMAND_SLIDER_UPDATED();
			wxEVT_COMMAND_RADIOBOX_SELECTED = wxEvent_EVT_COMMAND_RADIOBOX_SELECTED();
			wxEVT_COMMAND_RADIOBUTTON_SELECTED = wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED();
			wxEVT_COMMAND_SCROLLBAR_UPDATED = wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED();
			wxEVT_COMMAND_VLBOX_SELECTED = wxEvent_EVT_COMMAND_VLBOX_SELECTED();
			wxEVT_COMMAND_COMBOBOX_SELECTED = wxEvent_EVT_COMMAND_COMBOBOX_SELECTED();
			wxEVT_COMMAND_TOOL_RCLICKED = wxEvent_EVT_COMMAND_TOOL_RCLICKED();
			wxEVT_COMMAND_TOOL_ENTER = wxEvent_EVT_COMMAND_TOOL_ENTER();
			wxEVT_COMMAND_SPINCTRL_UPDATED = wxEvent_EVT_COMMAND_SPINCTRL_UPDATED();
			wxEVT_SOCKET = wxEvent_EVT_SOCKET();
			wxEVT_TIMER  = wxEvent_EVT_TIMER ();
			wxEVT_LEFT_DOWN = wxEvent_EVT_LEFT_DOWN();
			wxEVT_LEFT_UP = wxEvent_EVT_LEFT_UP();
			wxEVT_MIDDLE_DOWN = wxEvent_EVT_MIDDLE_DOWN();
			wxEVT_MIDDLE_UP = wxEvent_EVT_MIDDLE_UP();
			wxEVT_RIGHT_DOWN = wxEvent_EVT_RIGHT_DOWN();
			wxEVT_RIGHT_UP = wxEvent_EVT_RIGHT_UP();
			wxEVT_MOTION = wxEvent_EVT_MOTION();
			wxEVT_ENTER_WINDOW = wxEvent_EVT_ENTER_WINDOW();
			wxEVT_LEAVE_WINDOW = wxEvent_EVT_LEAVE_WINDOW();
			wxEVT_LEFT_DCLICK = wxEvent_EVT_LEFT_DCLICK();
			wxEVT_MIDDLE_DCLICK = wxEvent_EVT_MIDDLE_DCLICK();
			wxEVT_RIGHT_DCLICK = wxEvent_EVT_RIGHT_DCLICK();
			wxEVT_SET_FOCUS = wxEvent_EVT_SET_FOCUS();
			wxEVT_KILL_FOCUS = wxEvent_EVT_KILL_FOCUS();
			wxEVT_CHILD_FOCUS = wxEvent_EVT_CHILD_FOCUS();
			wxEVT_MOUSEWHEEL = wxEvent_EVT_MOUSEWHEEL();
			wxEVT_NC_LEFT_DOWN = wxEvent_EVT_NC_LEFT_DOWN();
			wxEVT_NC_LEFT_UP = wxEvent_EVT_NC_LEFT_UP();
			wxEVT_NC_MIDDLE_DOWN = wxEvent_EVT_NC_MIDDLE_DOWN();
			wxEVT_NC_MIDDLE_UP = wxEvent_EVT_NC_MIDDLE_UP();
			wxEVT_NC_RIGHT_DOWN = wxEvent_EVT_NC_RIGHT_DOWN();
			wxEVT_NC_RIGHT_UP = wxEvent_EVT_NC_RIGHT_UP();
			wxEVT_NC_MOTION = wxEvent_EVT_NC_MOTION();
			wxEVT_NC_ENTER_WINDOW = wxEvent_EVT_NC_ENTER_WINDOW();
			wxEVT_NC_LEAVE_WINDOW = wxEvent_EVT_NC_LEAVE_WINDOW();
			wxEVT_NC_LEFT_DCLICK = wxEvent_EVT_NC_LEFT_DCLICK();
			wxEVT_NC_MIDDLE_DCLICK = wxEvent_EVT_NC_MIDDLE_DCLICK();
			wxEVT_NC_RIGHT_DCLICK = wxEvent_EVT_NC_RIGHT_DCLICK();
			wxEVT_CHAR = wxEvent_EVT_CHAR();
			wxEVT_CHAR_HOOK = wxEvent_EVT_CHAR_HOOK();
			wxEVT_NAVIGATION_KEY = wxEvent_EVT_NAVIGATION_KEY();
			wxEVT_KEY_DOWN = wxEvent_EVT_KEY_DOWN();
			wxEVT_KEY_UP = wxEvent_EVT_KEY_UP();
			wxEVT_SET_CURSOR = wxEvent_EVT_SET_CURSOR();
			wxEVT_SCROLL_TOP = wxEvent_EVT_SCROLL_TOP();
			wxEVT_SCROLL_BOTTOM = wxEvent_EVT_SCROLL_BOTTOM();
			wxEVT_SCROLL_LINEUP = wxEvent_EVT_SCROLL_LINEUP();
			wxEVT_SCROLL_LINEDOWN = wxEvent_EVT_SCROLL_LINEDOWN();
			wxEVT_SCROLL_PAGEUP = wxEvent_EVT_SCROLL_PAGEUP();
			wxEVT_SCROLL_PAGEDOWN = wxEvent_EVT_SCROLL_PAGEDOWN();
			wxEVT_SCROLL_THUMBTRACK = wxEvent_EVT_SCROLL_THUMBTRACK();
			wxEVT_SCROLL_THUMBRELEASE = wxEvent_EVT_SCROLL_THUMBRELEASE();
			wxEVT_SCROLL_ENDSCROLL = wxEvent_EVT_SCROLL_ENDSCROLL();
			wxEVT_SCROLLWIN_TOP = wxEvent_EVT_SCROLLWIN_TOP();
			wxEVT_SCROLLWIN_BOTTOM = wxEvent_EVT_SCROLLWIN_BOTTOM();
			wxEVT_SCROLLWIN_LINEUP = wxEvent_EVT_SCROLLWIN_LINEUP();
			wxEVT_SCROLLWIN_LINEDOWN = wxEvent_EVT_SCROLLWIN_LINEDOWN();
			wxEVT_SCROLLWIN_PAGEUP = wxEvent_EVT_SCROLLWIN_PAGEUP();
			wxEVT_SCROLLWIN_PAGEDOWN = wxEvent_EVT_SCROLLWIN_PAGEDOWN();
			wxEVT_SCROLLWIN_THUMBTRACK = wxEvent_EVT_SCROLLWIN_THUMBTRACK();
			wxEVT_SCROLLWIN_THUMBRELEASE = wxEvent_EVT_SCROLLWIN_THUMBRELEASE();
			wxEVT_SIZE = wxEvent_EVT_SIZE();
			wxEVT_MOVE = wxEvent_EVT_MOVE();
			wxEVT_CLOSE_WINDOW = wxEvent_EVT_CLOSE_WINDOW();
			wxEVT_END_SESSION = wxEvent_EVT_END_SESSION();
			wxEVT_QUERY_END_SESSION = wxEvent_EVT_QUERY_END_SESSION();
			wxEVT_ACTIVATE_APP = wxEvent_EVT_ACTIVATE_APP();
			wxEVT_POWER = wxEvent_EVT_POWER();
			wxEVT_ACTIVATE = wxEvent_EVT_ACTIVATE();
			wxEVT_CREATE = wxEvent_EVT_CREATE();
			wxEVT_DESTROY = wxEvent_EVT_DESTROY();
			wxEVT_SHOW = wxEvent_EVT_SHOW();
			wxEVT_ICONIZE = wxEvent_EVT_ICONIZE();
			wxEVT_MAXIMIZE = wxEvent_EVT_MAXIMIZE();
			wxEVT_MOUSE_CAPTURE_CHANGED = wxEvent_EVT_MOUSE_CAPTURE_CHANGED();
			wxEVT_PAINT = wxEvent_EVT_PAINT();
			wxEVT_ERASE_BACKGROUND = wxEvent_EVT_ERASE_BACKGROUND();
			wxEVT_NC_PAINT = wxEvent_EVT_NC_PAINT();
			wxEVT_PAINT_ICON = wxEvent_EVT_PAINT_ICON();
			wxEVT_MENU_OPEN = wxEvent_EVT_MENU_OPEN();
			wxEVT_MENU_CLOSE = wxEvent_EVT_MENU_CLOSE();
			wxEVT_MENU_HIGHLIGHT = wxEvent_EVT_MENU_HIGHLIGHT();
			wxEVT_CONTEXT_MENU = wxEvent_EVT_CONTEXT_MENU();
			wxEVT_SYS_COLOUR_CHANGED = wxEvent_EVT_SYS_COLOUR_CHANGED();
			wxEVT_DISPLAY_CHANGED = wxEvent_EVT_DISPLAY_CHANGED();
			wxEVT_SETTING_CHANGED = wxEvent_EVT_SETTING_CHANGED();
			wxEVT_QUERY_NEW_PALETTE = wxEvent_EVT_QUERY_NEW_PALETTE();
			wxEVT_PALETTE_CHANGED = wxEvent_EVT_PALETTE_CHANGED();
			wxEVT_JOY_BUTTON_DOWN = wxEvent_EVT_JOY_BUTTON_DOWN();
			wxEVT_JOY_BUTTON_UP = wxEvent_EVT_JOY_BUTTON_UP();
			wxEVT_JOY_MOVE = wxEvent_EVT_JOY_MOVE();
			wxEVT_JOY_ZMOVE = wxEvent_EVT_JOY_ZMOVE();
			wxEVT_DROP_FILES = wxEvent_EVT_DROP_FILES();
			wxEVT_DRAW_ITEM = wxEvent_EVT_DRAW_ITEM();
			wxEVT_MEASURE_ITEM = wxEvent_EVT_MEASURE_ITEM();
			wxEVT_COMPARE_ITEM = wxEvent_EVT_COMPARE_ITEM();
			wxEVT_INIT_DIALOG = wxEvent_EVT_INIT_DIALOG();
			wxEVT_IDLE = wxEvent_EVT_IDLE();
			wxEVT_UPDATE_UI = wxEvent_EVT_UPDATE_UI();
			wxEVT_SIZING = wxEvent_EVT_SIZING();
			wxEVT_MOVING = wxEvent_EVT_MOVING();
			wxEVT_COMMAND_LEFT_CLICK = wxEvent_EVT_COMMAND_LEFT_CLICK();
			wxEVT_COMMAND_LEFT_DCLICK = wxEvent_EVT_COMMAND_LEFT_DCLICK();
			wxEVT_COMMAND_RIGHT_CLICK = wxEvent_EVT_COMMAND_RIGHT_CLICK();
			wxEVT_COMMAND_RIGHT_DCLICK = wxEvent_EVT_COMMAND_RIGHT_DCLICK();
			wxEVT_COMMAND_SET_FOCUS = wxEvent_EVT_COMMAND_SET_FOCUS();
			wxEVT_COMMAND_KILL_FOCUS = wxEvent_EVT_COMMAND_KILL_FOCUS();
			wxEVT_COMMAND_ENTER = wxEvent_EVT_COMMAND_ENTER();
			wxEVT_HELP = wxEvent_EVT_HELP();
			wxEVT_DETAILED_HELP = wxEvent_EVT_DETAILED_HELP();
			wxEVT_COMMAND_TOGGLEBUTTON_CLICKED = wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED();
			wxEVT_OBJECTDELETED = wxEvent_EVT_OBJECTDELETED();
	
			wxEVT_CALENDAR_SEL_CHANGED = wxEvent_EVT_CALENDAR_SEL_CHANGED();
			wxEVT_CALENDAR_DAY_CHANGED = wxEvent_EVT_CALENDAR_DAY_CHANGED();
			wxEVT_CALENDAR_MONTH_CHANGED = wxEvent_EVT_CALENDAR_MONTH_CHANGED();
			wxEVT_CALENDAR_YEAR_CHANGED = wxEvent_EVT_CALENDAR_YEAR_CHANGED();
			wxEVT_CALENDAR_DOUBLECLICKED = wxEvent_EVT_CALENDAR_DOUBLECLICKED();
			wxEVT_CALENDAR_WEEKDAY_CLICKED = wxEvent_EVT_CALENDAR_WEEKDAY_CLICKED();
	
			wxEVT_COMMAND_FIND = wxEvent_EVT_COMMAND_FIND();
			wxEVT_COMMAND_FIND_NEXT = wxEvent_EVT_COMMAND_FIND_NEXT();
			wxEVT_COMMAND_FIND_REPLACE = wxEvent_EVT_COMMAND_FIND_REPLACE();
			wxEVT_COMMAND_FIND_REPLACE_ALL = wxEvent_EVT_COMMAND_FIND_REPLACE_ALL();
			wxEVT_COMMAND_FIND_CLOSE = wxEvent_EVT_COMMAND_FIND_CLOSE();
	
			wxEVT_COMMAND_TREE_BEGIN_DRAG = wxEvent_EVT_COMMAND_TREE_BEGIN_DRAG();
			wxEVT_COMMAND_TREE_BEGIN_RDRAG = wxEvent_EVT_COMMAND_TREE_BEGIN_RDRAG();
			wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT = wxEvent_EVT_COMMAND_TREE_BEGIN_LABEL_EDIT();
			wxEVT_COMMAND_TREE_END_LABEL_EDIT = wxEvent_EVT_COMMAND_TREE_END_LABEL_EDIT();
			wxEVT_COMMAND_TREE_DELETE_ITEM = wxEvent_EVT_COMMAND_TREE_DELETE_ITEM();
			wxEVT_COMMAND_TREE_GET_INFO = wxEvent_EVT_COMMAND_TREE_GET_INFO();
			wxEVT_COMMAND_TREE_SET_INFO = wxEvent_EVT_COMMAND_TREE_SET_INFO();
			wxEVT_COMMAND_TREE_ITEM_EXPANDED = wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDED();
			wxEVT_COMMAND_TREE_ITEM_EXPANDING = wxEvent_EVT_COMMAND_TREE_ITEM_EXPANDING();
			wxEVT_COMMAND_TREE_ITEM_COLLAPSED = wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSED();
			wxEVT_COMMAND_TREE_ITEM_COLLAPSING = wxEvent_EVT_COMMAND_TREE_ITEM_COLLAPSING();
			wxEVT_COMMAND_TREE_SEL_CHANGED = wxEvent_EVT_COMMAND_TREE_SEL_CHANGED();
			wxEVT_COMMAND_TREE_SEL_CHANGING = wxEvent_EVT_COMMAND_TREE_SEL_CHANGING();
			wxEVT_COMMAND_TREE_KEY_DOWN = wxEvent_EVT_COMMAND_TREE_KEY_DOWN();
			wxEVT_COMMAND_TREE_ITEM_ACTIVATED = wxEvent_EVT_COMMAND_TREE_ITEM_ACTIVATED();
			wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK = wxEvent_EVT_COMMAND_TREE_ITEM_RIGHT_CLICK();
			wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK = wxEvent_EVT_COMMAND_TREE_ITEM_MIDDLE_CLICK();
			wxEVT_COMMAND_TREE_END_DRAG = wxEvent_EVT_COMMAND_TREE_END_DRAG();
	
			wxEVT_COMMAND_LIST_BEGIN_DRAG = wxEvent_EVT_COMMAND_LIST_BEGIN_DRAG();
			wxEVT_COMMAND_LIST_BEGIN_RDRAG = wxEvent_EVT_COMMAND_LIST_BEGIN_RDRAG();
			wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT = wxEvent_EVT_COMMAND_LIST_BEGIN_LABEL_EDIT();
			wxEVT_COMMAND_LIST_END_LABEL_EDIT = wxEvent_EVT_COMMAND_LIST_END_LABEL_EDIT();
			wxEVT_COMMAND_LIST_DELETE_ITEM = wxEvent_EVT_COMMAND_LIST_DELETE_ITEM();
			wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS = wxEvent_EVT_COMMAND_LIST_DELETE_ALL_ITEMS();
			wxEVT_COMMAND_LIST_GET_INFO = wxEvent_EVT_COMMAND_LIST_GET_INFO();
			wxEVT_COMMAND_LIST_SET_INFO = wxEvent_EVT_COMMAND_LIST_SET_INFO();
			wxEVT_COMMAND_LIST_ITEM_SELECTED = wxEvent_EVT_COMMAND_LIST_ITEM_SELECTED();
			wxEVT_COMMAND_LIST_ITEM_DESELECTED = wxEvent_EVT_COMMAND_LIST_ITEM_DESELECTED();
			wxEVT_COMMAND_LIST_ITEM_ACTIVATED = wxEvent_EVT_COMMAND_LIST_ITEM_ACTIVATED();
			wxEVT_COMMAND_LIST_ITEM_FOCUSED = wxEvent_EVT_COMMAND_LIST_ITEM_FOCUSED();
			wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK = wxEvent_EVT_COMMAND_LIST_ITEM_MIDDLE_CLICK();
			wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK = wxEvent_EVT_COMMAND_LIST_ITEM_RIGHT_CLICK();
			wxEVT_COMMAND_LIST_KEY_DOWN = wxEvent_EVT_COMMAND_LIST_KEY_DOWN();
			wxEVT_COMMAND_LIST_INSERT_ITEM = wxEvent_EVT_COMMAND_LIST_INSERT_ITEM();
			wxEVT_COMMAND_LIST_COL_CLICK = wxEvent_EVT_COMMAND_LIST_COL_CLICK();
			wxEVT_COMMAND_LIST_COL_RIGHT_CLICK = wxEvent_EVT_COMMAND_LIST_COL_RIGHT_CLICK();
			wxEVT_COMMAND_LIST_COL_BEGIN_DRAG = wxEvent_EVT_COMMAND_LIST_COL_BEGIN_DRAG();
			wxEVT_COMMAND_LIST_COL_DRAGGING = wxEvent_EVT_COMMAND_LIST_COL_DRAGGING();
			wxEVT_COMMAND_LIST_COL_END_DRAG = wxEvent_EVT_COMMAND_LIST_COL_END_DRAG();
			wxEVT_COMMAND_LIST_CACHE_HINT = wxEvent_EVT_COMMAND_LIST_CACHE_HINT();
	
			wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED = wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED();
			wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING = wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING();
	
			wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED = wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED();
			wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING = wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING();

version(__WXMSW__){
			wxEVT_COMMAND_TAB_SEL_CHANGED = wxEvent_EVT_COMMAND_TAB_SEL_CHANGED();
			wxEVT_COMMAND_TAB_SEL_CHANGING = wxEvent_EVT_COMMAND_TAB_SEL_CHANGING();
}
			wxEVT_GRID_CELL_LEFT_CLICK = wxEvent_EVT_GRID_CELL_LEFT_CLICK();
			wxEVT_GRID_CELL_RIGHT_CLICK = wxEvent_EVT_GRID_CELL_RIGHT_CLICK();
			wxEVT_GRID_CELL_LEFT_DCLICK = wxEvent_EVT_GRID_CELL_LEFT_DCLICK();
			wxEVT_GRID_CELL_RIGHT_DCLICK = wxEvent_EVT_GRID_CELL_RIGHT_DCLICK();
			wxEVT_GRID_LABEL_LEFT_CLICK = wxEvent_EVT_GRID_LABEL_LEFT_CLICK();
			wxEVT_GRID_LABEL_RIGHT_CLICK = wxEvent_EVT_GRID_LABEL_RIGHT_CLICK();
			wxEVT_GRID_LABEL_LEFT_DCLICK = wxEvent_EVT_GRID_LABEL_LEFT_DCLICK();
			wxEVT_GRID_LABEL_RIGHT_DCLICK = wxEvent_EVT_GRID_LABEL_RIGHT_DCLICK();
			wxEVT_GRID_ROW_SIZE = wxEvent_EVT_GRID_ROW_SIZE();
			wxEVT_GRID_COL_SIZE = wxEvent_EVT_GRID_COL_SIZE();
			wxEVT_GRID_RANGE_SELECT = wxEvent_EVT_GRID_RANGE_SELECT();
			wxEVT_GRID_CELL_CHANGE = wxEvent_EVT_GRID_CELL_CHANGE();
			wxEVT_GRID_SELECT_CELL = wxEvent_EVT_GRID_SELECT_CELL();
			wxEVT_GRID_EDITOR_SHOWN = wxEvent_EVT_GRID_EDITOR_SHOWN();
			wxEVT_GRID_EDITOR_HIDDEN = wxEvent_EVT_GRID_EDITOR_HIDDEN();
			wxEVT_GRID_EDITOR_CREATED = wxEvent_EVT_GRID_EDITOR_CREATED();
		
			wxEVT_SASH_DRAGGED = wxEvent_EVT_SASH_DRAGGED();
		
			wxEVT_QUERY_LAYOUT_INFO = wxEvent_EVT_QUERY_LAYOUT_INFO();
			wxEVT_CALCULATE_LAYOUT = wxEvent_EVT_CALCULATE_LAYOUT();
		}

		//---------------------------------------------------------------------

		alias static Event function(IntPtr wxobj) newfunc;

		protected static newfunc[int] funcmap;
	
		//---------------------------------------------------------------------
		private static Event New(IntPtr obj);
	
		//---------------------------------------------------------------------

		public static void AddEventType(int evt, newfunc func)
		{
			funcmap[evt]= func;
		}

		//---------------------------------------------------------------------

		public this(IntPtr wxobj) 
			{ super(wxobj); }

		//---------------------------------------------------------------------

		private static Event CreateFrom(IntPtr wxEvent)
		{
			// Check to see if this event type is in the type map

			int evtType = wxEvent_GetEventType(wxEvent);
			newfunc* func = evtType in funcmap;

			// If so, create an instance of the specified type

			Event e;
			if (func)
				e = (*func)(wxEvent);
			else
				e = new Event(wxEvent);

			return e;
		}

		//---------------------------------------------------------------------

		public int EventType() { return wxEvent_GetEventType(wxobj); }

		//---------------------------------------------------------------------

		public int ID() { return wxEvent_GetId(wxobj); }

		//---------------------------------------------------------------------

		public void Skip()
		{ 
			Skip(true); 
		}

		public void Skip(bool skip)
		{
			wxEvent_Skip(wxobj, skip);
		}

		//---------------------------------------------------------------------

		public bool Skipped() { return wxEvent_GetSkipped(wxobj); }

		//---------------------------------------------------------------------

		public int Timestamp() { return wxEvent_GetTimestamp(wxobj); }

		//---------------------------------------------------------------------

		public wxObject EventObject() { return FindObject(wxEvent_GetEventObject(wxobj)); }

		//---------------------------------------------------------------------

		public IntPtr EventIntPtr() { return wxEvent_GetEventObject(wxobj); }
	}
