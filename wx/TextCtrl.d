//-----------------------------------------------------------------------------
// wx.NET - TextCtrl.cs
//
// The wxTextCtrl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public enum TextAttrAlignment
	{
		wxTEXT_ALIGNMENT_DEFAULT,
		wxTEXT_ALIGNMENT_LEFT,
		wxTEXT_ALIGNMENT_CENTRE,
		wxTEXT_ALIGNMENT_CENTER = wxTEXT_ALIGNMENT_CENTRE,
		wxTEXT_ALIGNMENT_RIGHT,
		wxTEXT_ALIGNMENT_JUSTIFIED
	}
	
	//---------------------------------------------------------------------
	
	public enum TextCtrlHitTestResult
	{
		wxTE_HT_UNKNOWN = -2,
		wxTE_HT_BEFORE,      
		wxTE_HT_ON_TEXT,     
		wxTE_HT_BELOW,       
		wxTE_HT_BEYOND       
	}
	
	//---------------------------------------------------------------------

	public class TextAttr : Object
	{
		public const long wxTEXT_ATTR_TEXT_COLOUR =		0x0001;
		public const long wxTEXT_ATTR_BACKGROUND_COLOUR =	0x0002;
		public const long wxTEXT_ATTR_FONT_FACE =		0x0004;
		public const long wxTEXT_ATTR_FONT_SIZE = 		0x0008;
		public const long wxTEXT_ATTR_FONT_WEIGHT =		0x0010;
		public const long wxTEXT_ATTR_FONT_ITALIC =		0x0020;
		public const long wxTEXT_ATTR_FONT_UNDERLINE =		0x0040;
		public const long wxTEXT_ATTR_FONT = wxTEXT_ATTR_FONT_FACE | wxTEXT_ATTR_FONT_SIZE | 
							wxTEXT_ATTR_FONT_WEIGHT | wxTEXT_ATTR_FONT_ITALIC | 
							wxTEXT_ATTR_FONT_UNDERLINE;
		public const long wxTEXT_ATTR_ALIGNMENT =		0x0080;
		public const long wxTEXT_ATTR_LEFT_INDENT =		0x0100;
		public const long wxTEXT_ATTR_RIGHT_INDENT =		0x0200;
		public const long wxTEXT_ATTR_TABS =			0x0400;

	
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_ctor(IntPtr colText, IntPtr colBack, IntPtr font, int alignment);
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_ctor2();
		[DllImport("wx-c")] static extern void   wxTextAttr_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_Init(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetTextColour(IntPtr self, IntPtr colText);
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_GetTextColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_GetBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_GetFont(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasTextColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasFont(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_IsDefault(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxTextAttr_SetAlignment(IntPtr self, int alignment);
		[DllImport("wx-c")] static extern int    wxTextAttr_GetAlignment(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetTabs(IntPtr self, IntPtr tabs);
		[DllImport("wx-c")] static extern IntPtr wxTextAttr_GetTabs(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetLeftIndent(IntPtr self, int indent, int subIndent);
		[DllImport("wx-c")] static extern int    wxTextAttr_GetLeftIndent(IntPtr self);
		[DllImport("wx-c")] static extern int    wxTextAttr_GetLeftSubIndent(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetRightIndent(IntPtr self, int indent);
		[DllImport("wx-c")] static extern int    wxTextAttr_GetRightIndent(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextAttr_SetFlags(IntPtr self, uint flags);
		[DllImport("wx-c")] static extern uint   wxTextAttr_GetFlags(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasAlignment(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasTabs(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasLeftIndent(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasRightIndent(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextAttr_HasFlag(IntPtr self, uint flag);
		
		//---------------------------------------------------------------------
		
		public TextAttr(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal TextAttr(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public TextAttr()
			: this(wxTextAttr_ctor2(), true) { }

		public TextAttr(Colour colText)
			: this(colText, null, null, TextAttrAlignment.wxTEXT_ALIGNMENT_DEFAULT) {}
			
		public TextAttr(Colour colText, Colour colBack)
			: this(colText, colBack, null, TextAttrAlignment.wxTEXT_ALIGNMENT_DEFAULT) {}
			
		public TextAttr(Colour colText, Colour colBack, Font font)
			: this(colText, colBack, font, TextAttrAlignment.wxTEXT_ALIGNMENT_DEFAULT) {}
			
	        public TextAttr(Colour colText, Colour colBack, Font font, TextAttrAlignment alignment)
        		: this(wxTextAttr_ctor(Object.SafePtr(colText), Object.SafePtr(colBack), Object.SafePtr(font), (int)alignment), true) { }
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxTextAttr_dtor(wxObject);
						memOwn = false;
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~TextAttr() 
		{
			Dispose();
		}
			    
		//---------------------------------------------------------------------
		
		public Colour TextColour
		{
			set { wxTextAttr_SetTextColour(wxObject, Object.SafePtr(value)); }
			get { return new Colour(wxTextAttr_GetTextColour(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour BackgroundColour
		{
			set { wxTextAttr_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
			get { return new Colour(wxTextAttr_GetBackgroundColour(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
		
		public Font Font 
		{
			set { wxTextAttr_SetFont(wxObject, Object.SafePtr(value)); }
			get { return new Font(wxTextAttr_GetFont(wxObject)); }
		}
		
		//---------------------------------------------------------------------
		
		public TextAttrAlignment Alignment
		{
			set { wxTextAttr_SetAlignment(wxObject, (int)value); }
			get { return (TextAttrAlignment)wxTextAttr_GetAlignment(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int[] Tabs
		{
			set {
				ArrayInt ai = new ArrayInt();
			
				for(int i = 0; i < value.Length; ++i)
					ai.Add(value[i]);
				
				wxTextAttr_SetTabs(wxObject, ArrayInt.SafePtr(ai));
			}
			get {
				return new ArrayInt(wxTextAttr_GetTabs(wxObject), true);
			}
		}
		
		//---------------------------------------------------------------------
		
		public void SetLeftIndent(int indent)
		{
			SetLeftIndent(indent, 0);
		}
		
		public void SetLeftIndent(int indent, int subIndent)
		{
			wxTextAttr_SetLeftIndent(wxObject, indent, subIndent);
		}
		
		public long LeftIndent
		{
			get { return wxTextAttr_GetLeftIndent(wxObject); }
		}
		
		public long LeftSubIndent
		{
			get { return wxTextAttr_GetLeftSubIndent(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int RightIndent
		{
			set { wxTextAttr_SetRightIndent(wxObject, value); }
			get { return wxTextAttr_GetRightIndent(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public long Flags
		{
			set { wxTextAttr_SetFlags(wxObject, (uint)value); }
			get { return (long)wxTextAttr_GetFlags(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasTextColour
		{
			get { return wxTextAttr_HasTextColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasBackgroundColour
		{
			get { return wxTextAttr_HasBackgroundColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasFont
		{
			get { return wxTextAttr_HasFont(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasAlignment
		{
			get { return wxTextAttr_HasAlignment(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasTabs
		{
			get { return wxTextAttr_HasTabs(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasLeftIndent
		{
			get { return wxTextAttr_HasLeftIndent(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasRightIndent
		{
			get { return wxTextAttr_HasRightIndent(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasFlag(long flag)
		{
			return wxTextAttr_HasFlag(wxObject, (uint)flag); 
		}
		
		//---------------------------------------------------------------------
		
		public bool IsDefault
		{
			get { return wxTextAttr_IsDefault(wxObject); }
		}
	}
	
	//---------------------------------------------------------------------

	public class TextCtrl : Control
	{
		public const long wxTE_NO_VSCROLL       = 0x0002;
		public const long wxTE_AUTO_SCROLL      = 0x0008;
	
		public const long wxTE_READONLY         = 0x0010;
		public const long wxTE_MULTILINE        = 0x0020;
		public const long wxTE_PROCESS_TAB      = 0x0040;
	
		public const long wxTE_LEFT             = 0x0000;
		public const long wxTE_CENTER           = Alignment.wxALIGN_CENTER;
		public const long wxTE_RIGHT            = Alignment.wxALIGN_RIGHT;
	
		public const long wxTE_RICH             = 0x0080;
		public const long wxTE_PROCESS_ENTER    = 0x0400;
		public const long wxTE_PASSWORD         = 0x0800;
	
		public const long wxTE_AUTO_URL         = 0x1000;
		public const long wxTE_NOHIDESEL        = 0x2000;
		public const long wxTE_DONTWRAP         = Window.wxHSCROLL;
		public const long wxTE_LINEWRAP         = 0x4000;
		public const long wxTE_WORDWRAP         = 0x0000;
		public const long wxTE_RICH2            = 0x8000;

		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxTextCtrl_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetValue(IntPtr self, string value);
		[DllImport("wx-c")] static extern IntPtr wxTextCtrl_GetRange(IntPtr self, uint from, uint to);
		[DllImport("wx-c")] static extern int    wxTextCtrl_GetLineLength(IntPtr self, uint lineNo);
		[DllImport("wx-c")] static extern IntPtr wxTextCtrl_GetLineText(IntPtr self, uint lineNo);
		[DllImport("wx-c")] static extern int    wxTextCtrl_GetNumberOfLines(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_IsModified(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_IsEditable(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_IsSingleLine(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_IsMultiLine(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_GetSelection(IntPtr self, out long from, out long to);
		[DllImport("wx-c")] static extern IntPtr wxTextCtrl_GetStringSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Clear(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Replace(IntPtr self, uint from, uint to, string value);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Remove(IntPtr self, uint from, uint to);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_LoadFile(IntPtr self, string file);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SaveFile(IntPtr self, string file);
		[DllImport("wx-c")] static extern void   wxTextCtrl_MarkDirty(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_DiscardEdits(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetMaxLength(IntPtr self, uint len);
		[DllImport("wx-c")] static extern void   wxTextCtrl_WriteText(IntPtr self, string text);
		[DllImport("wx-c")] static extern void   wxTextCtrl_AppendText(IntPtr self, string text);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_EmulateKeyPress(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SetStyle(IntPtr self, uint start, uint end, IntPtr style);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_GetStyle(IntPtr self, uint position, ref IntPtr style);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SetDefaultStyle(IntPtr self, IntPtr style);
		[DllImport("wx-c")] static extern IntPtr wxTextCtrl_GetDefaultStyle(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxTextCtrl_XYToPosition(IntPtr self, uint x, uint y);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_PositionToXY(IntPtr self, uint pos, out long x, out long y);
		[DllImport("wx-c")] static extern void   wxTextCtrl_ShowPosition(IntPtr self, uint pos);
		[DllImport("wx-c")] static extern int    wxTextCtrl_HitTest(IntPtr self, ref Point pt, out long pos);
		[DllImport("wx-c")] static extern int    wxTextCtrl_HitTest2(IntPtr self, ref Point pt, out long col, out long row);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Copy(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Cut(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Paste(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_CanCopy(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_CanCut(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_CanPaste(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Undo(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Redo(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_CanUndo(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_CanRedo(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetInsertionPoint(IntPtr self, uint pos);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetInsertionPointEnd(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxTextCtrl_GetInsertionPoint(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxTextCtrl_GetLastPosition(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetSelection(IntPtr self, uint from, uint to);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SelectAll(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_SetEditable(IntPtr self, bool editable);
		[DllImport("wx-c")] static extern        IntPtr wxTextCtrl_ctor();
		[DllImport("wx-c")] static extern bool   wxTextCtrl_Create(IntPtr self, IntPtr parent, int id, string value, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_Enable(IntPtr self, bool enable);
		[DllImport("wx-c")] static extern void   wxTextCtrl_OnDropFiles(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SetForegroundColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_SetBackgroundColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Freeze(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTextCtrl_Thaw(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_ScrollLines(IntPtr self, int lines);
		[DllImport("wx-c")] static extern bool   wxTextCtrl_ScrollPages(IntPtr self, int pages);

		//---------------------------------------------------------------------
        
		public TextCtrl(IntPtr wxObject)
			: base(wxObject) { }

		public TextCtrl(Window parent)
			: this(parent, Window.UniqueID, "", wxDefaultPosition, wxDefaultSize, 0, null, "") { }

		public TextCtrl(Window parent, int id)
			: this(parent, id, "", wxDefaultPosition, wxDefaultSize, 0, null, "") { }

		public TextCtrl(Window parent, int id, string value)
			: this(parent, id, value, wxDefaultPosition, wxDefaultSize, 0, null, "") { }

		public TextCtrl(Window parent, int id, string value, Point pos, Size size, long style)
			: this(parent, id, value, pos, size, style, null, "") { }

		public TextCtrl(Window parent, int id, string value, Point pos, Size size)
			: this(parent, id, value, pos, size, 0, null, "") { }

		public TextCtrl(Window parent, int id, string value, Point pos, Size size, long style, Validator validator, string name)
			: this(wxTextCtrl_ctor())
		{
			if (!wxTextCtrl_Create(wxObject, Object.SafePtr(parent), id, value, ref pos, ref size, (uint)style, Object.SafePtr(validator), name))
			{
				throw new InvalidOperationException("Failed to create TextCtrl");
			}
		}
	
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public TextCtrl(Window parent, string value)
			: this(parent, Window.UniqueID, value, wxDefaultPosition, wxDefaultSize, 0, null, "") { }
	
		public TextCtrl(Window parent, string value, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, value, pos, size, style, null, "") { }
	
		public TextCtrl(Window parent, string value, Point pos, Size size)
			: this(parent, Window.UniqueID, value, pos, size, 0, null, "") { }
	
		public TextCtrl(Window parent, string value, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, value, pos, size, 0, validator, name) {}
	
		//---------------------------------------------------------------------

		public void Clear()
		{
			wxTextCtrl_Clear(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public override Colour BackgroundColour
		{
			set
			{
				wxTextCtrl_SetBackgroundColour(wxObject, Object.SafePtr(value));
			}
		}
	
		public override Colour ForegroundColour
		{
			set
			{
				wxTextCtrl_SetForegroundColour(wxObject, Object.SafePtr(value));
			}
		}
	
		//---------------------------------------------------------------------
	
		public string Value
		{
			get
			{
				return new wxString(wxTextCtrl_GetValue(wxObject), true);
			}
			set
			{
				wxTextCtrl_SetValue(wxObject, value);
			}
		}
	
		//---------------------------------------------------------------------
	
		public string GetRange(long from, long to)
		{
			return new wxString(wxTextCtrl_GetRange(wxObject, (uint)from, (uint)to), true);
		}
	
		//---------------------------------------------------------------------
	
		public int LineLength(long lineNo)
		{
			return wxTextCtrl_GetLineLength(wxObject, (uint)lineNo);
		}
	
		public string GetLineText(long lineNo)
		{
			return new wxString(wxTextCtrl_GetLineText(wxObject, (uint)lineNo), true);
		}
	
		public int GetNumberOfLines()
		{
			return wxTextCtrl_GetNumberOfLines(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public bool IsModified
		{
			get { return wxTextCtrl_IsModified(wxObject); }
		}
	
		public bool IsEditable
		{
			get { return wxTextCtrl_IsEditable(wxObject); }
		}
	
		public bool IsSingleLine
		{
			get { return wxTextCtrl_IsSingleLine(wxObject); }
		}
	
		public bool IsMultiLine
		{
			get { return wxTextCtrl_IsMultiLine(wxObject); }
		}
	
		//---------------------------------------------------------------------
	
		public void GetSelection(out long from, out long to)
		{
			wxTextCtrl_GetSelection(wxObject, out from, out to);
		}
	
		//---------------------------------------------------------------------
	
		public void Replace(long from, long to, string value)
		{
			wxTextCtrl_Replace(wxObject, (uint)from, (uint)to, value);
		}
	
		public void Remove(long from, long to)
		{
			wxTextCtrl_Remove(wxObject, (uint)from, (uint)to);
		}
	
		//---------------------------------------------------------------------
	
		public bool LoadFile(string file)
		{
			return wxTextCtrl_LoadFile(wxObject, file);
		}
		
		// using wx.NET with wxGTK wxTextCtrl_LoadFile didn't work
		// LoadFileNET uses StreamReader
		// this should also handle encoding problems...
		public bool LoadFileNET(string file)
		{
			try
			{
				System.IO.StreamReader sr = new System.IO.StreamReader(file);
				string s = sr.ReadToEnd();
				sr.Close();
				AppendText(s);
				
				return true;
				
			} catch ( Exception e )
			{
				return false;
			}
		}
	
		public bool SaveFile(string file)
		{
			return wxTextCtrl_SaveFile(wxObject, file);
		}
		
		// counterpart of LoadFileNET
		public bool SaveFileNET(string file)
		{
			try
			{
				System.IO.StreamWriter sw = new System.IO.StreamWriter(file);
				sw.Write(Value);
				sw.Close();
				
				return true;
			} catch ( Exception e )
			{
				return false;
			}
		}
	
		//---------------------------------------------------------------------
	
		public void DiscardEdits()
		{
			wxTextCtrl_DiscardEdits(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public void MarkDirty()
		{
			wxTextCtrl_MarkDirty(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public long MaxLength
		{
			set { wxTextCtrl_SetMaxLength(wxObject, (uint)value); }
		}
	
		//---------------------------------------------------------------------
	
		public void WriteText(string text)
		{
			wxTextCtrl_WriteText(wxObject, text);
		}
		
		//---------------------------------------------------------------------
	
		public void AppendText(string text)
		{
			wxTextCtrl_AppendText(wxObject, text);
		}
		
		//---------------------------------------------------------------------
		
		public bool EmulateKeyPress(KeyEvent evt)
		{
			return wxTextCtrl_EmulateKeyPress(wxObject, Object.SafePtr(evt));
		}
	
		//---------------------------------------------------------------------
	
		public bool SetStyle(long start, long end, TextAttr style)
		{
			return wxTextCtrl_SetStyle(wxObject, (uint)start, (uint)end, Object.SafePtr(style));
		}
		
		public bool GetStyle(long position, ref TextAttr style)
		{
			IntPtr tmp = Object.SafePtr(style);
			bool retval = wxTextCtrl_GetStyle(wxObject, (uint)position, ref tmp);
			style.wxObject = tmp;
			return retval;
		}
		
		//---------------------------------------------------------------------
	
		public bool SetDefaultStyle(TextAttr style)
		{
			return wxTextCtrl_SetDefaultStyle(wxObject, Object.SafePtr(style));
		}
		
		public TextAttr GetDefaultStyle()
		{
			return (TextAttr)Object.FindObject(wxTextCtrl_GetDefaultStyle(wxObject));
		}
	
		//---------------------------------------------------------------------
	
		public long XYToPosition(long x, long y)
		{
			return wxTextCtrl_XYToPosition(wxObject, (uint)x, (uint)y);
		}
	
		public bool PositionToXY(long pos, out long x, out long y)
		{
			return wxTextCtrl_PositionToXY(wxObject, (uint)pos, out x, out y);
		}
	
		public void ShowPosition(long pos)
		{
			wxTextCtrl_ShowPosition(wxObject, (uint)pos);
		}
	
		//---------------------------------------------------------------------
		
		public TextCtrlHitTestResult HitTest(Point pt, out long pos)
		{
			return (TextCtrlHitTestResult)wxTextCtrl_HitTest(wxObject, ref pt, out pos);
		}
		
		public TextCtrlHitTestResult HitTest(Point pt, out long col, out long row)
		{
			return (TextCtrlHitTestResult)wxTextCtrl_HitTest2(wxObject, ref pt, out col, out row);
		}
		
		//---------------------------------------------------------------------
	
		public void Copy()
		{
			wxTextCtrl_Copy(wxObject);
		}
	
		public void Cut()
		{
			wxTextCtrl_Cut(wxObject);
		}
	
		public void Paste()
		{
			wxTextCtrl_Paste(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public bool CanCopy()
		{
			return wxTextCtrl_CanCopy(wxObject);
		}
	
		public bool CanCut()
		{
			return wxTextCtrl_CanCut(wxObject);
		}
	
		public bool CanPaste()
		{
			return wxTextCtrl_CanPaste(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public void Undo()
		{
			wxTextCtrl_Undo(wxObject);
		}
	
		public void Redo()
		{
			wxTextCtrl_Redo(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public bool CanUndo()
		{
			return wxTextCtrl_CanUndo(wxObject);
		}
	
		public bool CanRedo()
		{
			return wxTextCtrl_CanRedo(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public long InsertionPoint
		{
			set
			{
				wxTextCtrl_SetInsertionPoint(wxObject, (uint)value);
			}
			get
			{
				return wxTextCtrl_GetInsertionPoint(wxObject);
			}
		}
	
		public void SetInsertionPointEnd()
		{
			wxTextCtrl_SetInsertionPointEnd(wxObject);
		}
	
		public long GetLastPosition()
		{
			return (long)wxTextCtrl_GetLastPosition(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public void SetSelection(long from, long to)
		{
			wxTextCtrl_SetSelection(wxObject, (uint)from, (uint)to);
		}
	
		public void SelectAll()
		{
			wxTextCtrl_SelectAll(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public void SetEditable(bool editable)
		{
			wxTextCtrl_SetEditable(wxObject, editable);
		}
	
		//---------------------------------------------------------------------
	
		public bool Enable(bool enable)
		{
			return wxTextCtrl_Enable(wxObject, enable);
		}
	
		//---------------------------------------------------------------------
	
		public virtual void OnDropFiles(Event evt)
		{
			wxTextCtrl_OnDropFiles(wxObject, Object.SafePtr(evt));
		}
	
		//---------------------------------------------------------------------
	
		public override void Freeze()
		{
			wxTextCtrl_Freeze(wxObject);
		}
	
		public override void Thaw()
		{
			wxTextCtrl_Thaw(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public override bool ScrollLines(int lines)
		{
			return wxTextCtrl_ScrollLines(wxObject, lines);
		}
	
		public override bool ScrollPages(int pages)
		{
			return wxTextCtrl_ScrollPages(wxObject, pages);
		}
	
		//---------------------------------------------------------------------
	
		public override event EventListener UpdateUI
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TEXT_UPDATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Enter
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TEXT_ENTER, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
	
	//---------------------------------------------------------------------

	public class TextUrlEvent : CommandEvent
    	{
		[DllImport("wx-c")] static extern IntPtr wxTextUrlEvent_ctor(int id, IntPtr evtMouse, uint start, uint end);
		[DllImport("wx-c")] static extern uint   wxTextUrlEvent_GetURLStart(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxTextUrlEvent_GetURLEnd(IntPtr self);
	
		// TODO: Replace Event with EventMouse
		public TextUrlEvent(int id, Event evtMouse, long start, long end)
		: base(wxTextUrlEvent_ctor(id, Object.SafePtr(evtMouse), (uint)start, (uint)end)) {}
	}
}
