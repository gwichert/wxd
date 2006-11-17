// //-----------------------------------------------------------------------------
// wxD - textctrl.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - textctrl.cxx
//
// The wxTextCtrl proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/textctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

/*class _TextAttr : public wxTextAttr
{
public:
	_TextAttr(const wxColour& colText, const wxColour& colBack, const wxFont& font, wxTextAttrAlignment alignment)
		: wxTextAttr(colText, colBack, font, alignment) {}
		
	_TextAttr()
		: wxTextAttr() {}

	DECLARE_DISPOSABLE(_TextAttr)
};*/

extern "C" WXEXPORT
wxTextAttr* wxTextAttr_ctor(const wxColour* colText, const wxColour* colBack, const wxFont* font, wxTextAttrAlignment alignment)
{
	if (colBack == NULL)
		colBack = &wxNullColour;

	if (font == NULL)
		font = &wxNullFont;

	return new wxTextAttr(*colText, *colBack, *font, alignment);
}

extern "C" WXEXPORT
wxTextAttr* wxTextAttr_ctor2()
{
	return new wxTextAttr();
}

extern "C" WXEXPORT
void wxTextAttr_dtor(wxTextAttr* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_Init(wxTextAttr* self)
{
	self->Init();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetTextColour(wxTextAttr* self, const wxColour* colText)
{
	self->SetTextColour(*colText);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTextAttr_GetTextColour(wxTextAttr* self)
{
	return new wxColour(self->GetTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetBackgroundColour(wxTextAttr* self, wxColour *colBack)
{
	self->SetBackgroundColour(*colBack);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetFont(wxTextAttr* self, const wxFont* font)
{
	self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasTextColour(wxTextAttr* self)
{
	return self->HasTextColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasBackgroundColour(wxTextAttr* self)
{
	return self->HasBackgroundColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasFont(wxTextAttr* self)
{
	return self->HasFont()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasAlignment(wxTextAttr* self)
{
	return self->HasAlignment()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasTabs(wxTextAttr* self)
{
	return self->HasTabs()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasLeftIndent(wxTextAttr* self)
{
	return self->HasLeftIndent()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasRightIndent(wxTextAttr* self)
{
	return self->HasRightIndent()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_HasFlag(wxTextAttr* self, long flag)
{
	return self->HasFlag(flag)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextAttr_IsDefault(wxTextAttr* self)
{
	return self->IsDefault()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetAlignment(wxTextAttr* self, wxTextAttrAlignment alignment)
{
	self->SetAlignment(alignment);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextAttrAlignment wxTextAttr_GetAlignment(wxTextAttr* self)
{
	return self->GetAlignment();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTextAttr_GetBackgroundColour(wxTextAttr* self)
{
	return new wxColour(self->GetBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxTextAttr_GetFont(wxTextAttr* self)
{
	return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextAttr_GetLeftIndent(wxTextAttr* self)
{
	return self->GetLeftIndent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextAttr_GetLeftSubIndent(wxTextAttr* self)
{
	return self->GetLeftSubIndent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetTabs(wxTextAttr* self, wxArrayInt* tabs)
{
	self->SetTabs(*tabs);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxArrayInt* wxTextAttr_GetTabs(wxTextAttr* self)
{
	wxArrayInt *ari = new wxArrayInt();
	*ari = self->GetTabs();
    	return ari;	
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetLeftIndent(wxTextAttr* self, int indent, int subIndent)
{
	self->SetLeftIndent(indent, subIndent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetRightIndent(wxTextAttr* self, int indent)
{
	self->SetRightIndent(indent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextAttr_GetRightIndent(wxTextAttr* self)
{
	return self->GetRightIndent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextAttr_SetFlags(wxTextAttr* self, long flags)
{
	self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextAttr_GetFlags(wxTextAttr* self)
{
	return self->GetFlags();
}

//-----------------------------------------------------------------------------
// wxTextCtrl

class _TextCtrl : public wxTextCtrl
{
public:
    DECLARE_OBJECTDELETED(_TextCtrl)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxTextCtrl_GetValue(wxTextCtrl* self)
{
	return dstr_ret(self->GetValue().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetValue(wxTextCtrl* self, dstr value)
{
	self->SetValue(wxstr(value));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxTextCtrl_GetRange(wxTextCtrl* self, long from, long to)
{
	return dstr_ret(self->GetRange(from, to).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextCtrl_GetLineLength(wxTextCtrl* self, long lineNo)
{
	return self->GetLineLength(lineNo);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxTextCtrl_GetLineText(wxTextCtrl* self, long lineNo)
{
	return dstr_ret(self->GetLineText(lineNo).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTextCtrl_GetNumberOfLines(wxTextCtrl* self)
{
	return self->GetNumberOfLines();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_IsModified(wxTextCtrl* self)
{
	return self->IsModified()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_IsEditable(wxTextCtrl* self)
{
	return self->IsEditable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_IsSingleLine(wxTextCtrl* self)
{
	return self->IsSingleLine()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_IsMultiLine(wxTextCtrl* self)
{
	return self->IsMultiLine()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_GetSelection(wxTextCtrl* self, long* from, long* to)
{
	self->GetSelection(from, to);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxTextCtrl_GetStringSelection(wxTextCtrl* self)
{
	return dstr_ret(self->GetStringSelection().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Clear(wxTextCtrl* self)
{
	self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Replace(wxTextCtrl* self, long from, long to, dstr value)
{
	self->Replace(from, to, wxstr(value));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Remove(wxTextCtrl* self, long from, long to)
{
	self->Remove(from, to);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_LoadFile(wxTextCtrl* self, dstr file)
{
	return self->LoadFile(wxstr(file))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SaveFile(wxTextCtrl* self, dstr file)
{
	return self->SaveFile(wxstr(file))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_DiscardEdits(wxTextCtrl* self)
{
	self->DiscardEdits();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetMaxLength(wxTextCtrl* self, unsigned long len)
{
	self->SetMaxLength(len);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_WriteText(wxTextCtrl* self, dstr text)
{
	self->WriteText(wxstr(text));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_AppendText(wxTextCtrl* self, dstr text)
{
	self->AppendText(wxstr(text));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_EmulateKeyPress(wxTextCtrl* self, const wxKeyEvent* event)
{
	return self->EmulateKeyPress(*event)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SetStyle(wxTextCtrl* self, long start, long end, const wxTextAttr* style)
{
	return self->SetStyle(start, end, *style)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_GetStyle(wxTextCtrl* self, long position, wxTextAttr* style)
{
	return self->GetStyle(position, *style)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SetDefaultStyle(wxTextCtrl* self, const wxTextAttr* style)
{
	return self->SetDefaultStyle(*style)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextAttr* wxTextCtrl_GetDefaultStyle(wxTextCtrl* self)
{
	return new wxTextAttr(self->GetDefaultStyle());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextCtrl_XYToPosition(wxTextCtrl* self, long x, long y)
{
	return self->XYToPosition(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_PositionToXY(wxTextCtrl* self, long pos, long *x, long *y)
{
	return self->PositionToXY(pos, x, y)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_ShowPosition(wxTextCtrl* self, long pos)
{
	self->ShowPosition(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Copy(wxTextCtrl* self)
{
	self->Copy();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Cut(wxTextCtrl* self)
{
	self->Cut();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Paste(wxTextCtrl* self)
{
	self->Paste();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_CanCopy(wxTextCtrl* self)
{
	return self->CanCopy()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_CanCut(wxTextCtrl* self)
{
	return self->CanCut()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_CanPaste(wxTextCtrl* self)
{
	return self->CanPaste()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Undo(wxTextCtrl* self)
{
	self->Undo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Redo(wxTextCtrl* self)
{
	self->Redo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_CanUndo(wxTextCtrl* self)
{
	return self->CanUndo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_CanRedo(wxTextCtrl* self)
{
	return self->CanRedo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetInsertionPoint(wxTextCtrl* self, long pos)
{
	self->SetInsertionPoint(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetInsertionPointEnd(wxTextCtrl* self)
{
	self->SetInsertionPointEnd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextCtrl_GetInsertionPoint(wxTextCtrl* self)
{
	return self->GetInsertionPoint();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextCtrl_GetLastPosition(wxTextCtrl* self)
{
	return self->GetLastPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetSelection(wxTextCtrl* self, long from, long to)
{
	self->SetSelection(from, to);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SelectAll(wxTextCtrl* self)
{
	self->SelectAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_SetEditable(wxTextCtrl* self, dbit editable)
{
	self->SetEditable(editable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextUrlEvent* wxTextUrlEvent_ctor(int id, const wxMouseEvent* evtMouse, long start, long end)
{
	return new wxTextUrlEvent(id, *evtMouse, start, end);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextUrlEvent_GetURLStart(wxTextUrlEvent* self)
{
	return self->GetURLStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxTextUrlEvent_GetURLEnd(wxTextUrlEvent* self)
{
	return self->GetURLEnd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextCtrl* wxTextCtrl_ctor()
{
	return new _TextCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_Create(wxTextCtrl* self, wxWindow *parent, wxWindowID id, dstr value, const wxPoint *pos, const wxSize *size, long style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	return self->Create(parent, id, wxstr(value), *pos, *size, style, *validator, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_Enable(wxTextCtrl* self, dbit enable)
{
	return self->Enable(enable)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_OnDropFiles(wxTextCtrl* self, wxDropFilesEvent *event)
{
	self->OnDropFiles(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SetFont(wxTextCtrl* self, const wxFont* font)
{
	return self->SetFont(*font)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SetForegroundColour(wxTextCtrl* self, const wxColour* colour)
{
	return self->SetForegroundColour(*colour)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_SetBackgroundColour(wxTextCtrl* self, const wxColour* colour)
{
	return self->SetBackgroundColour(*colour)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Freeze(wxTextCtrl* self)
{
	self->Freeze();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_Thaw(wxTextCtrl* self)
{
	self->Thaw();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_ScrollLines(wxTextCtrl* self, int lines)
{
	return self->ScrollLines(lines)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxTextCtrl_ScrollPages(wxTextCtrl* self, int pages)
{
	return self->ScrollPages(pages)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextCtrl_MarkDirty(wxTextCtrl* self)
{
	self->MarkDirty();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextCtrlHitTestResult wxTextCtrl_HitTest(wxTextCtrl* self, wxPoint* pt, long* pos)
{
	return self->HitTest(*pt, pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextCtrlHitTestResult wxTextCtrl_HitTest2(wxTextCtrl* self, wxPoint* pt, wxTextCoord *col, wxTextCoord *row)
{
	return self->HitTest(*pt, col, row);
}

