//-----------------------------------------------------------------------------
// wx.NET - styledtextctrl.h
// 
// The wxStyledTextCtrl proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#ifdef WXNET_STYLEDTEXTCTRL

#include <wx/wx.h>
#include <wx/stc/stc.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

// Event types

extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_CHANGE()             { return wxEVT_STC_CHANGE; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_STYLENEEDED()        { return wxEVT_STC_STYLENEEDED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_CHARADDED()          { return wxEVT_STC_CHARADDED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED()   { return wxEVT_STC_SAVEPOINTREACHED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT()      { return wxEVT_STC_SAVEPOINTLEFT; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT()    { return wxEVT_STC_ROMODIFYATTEMPT; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_KEY()                { return wxEVT_STC_KEY; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_DOUBLECLICK()        { return wxEVT_STC_DOUBLECLICK; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_UPDATEUI()           { return wxEVT_STC_UPDATEUI; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_MODIFIED()           { return wxEVT_STC_MODIFIED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_MACRORECORD()        { return wxEVT_STC_MACRORECORD; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_MARGINCLICK()        { return wxEVT_STC_MARGINCLICK; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_NEEDSHOWN()          { return wxEVT_STC_NEEDSHOWN; }
//extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_POSCHANGED()         { return wxEVT_STC_POSCHANGED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_PAINTED()            { return wxEVT_STC_PAINTED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_USERLISTSELECTION()  { return wxEVT_STC_USERLISTSELECTION; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_URIDROPPED()         { return wxEVT_STC_URIDROPPED; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_DWELLSTART()         { return wxEVT_STC_DWELLSTART; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_DWELLEND()           { return wxEVT_STC_DWELLEND; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_START_DRAG()         { return wxEVT_STC_START_DRAG; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_DRAG_OVER()          { return wxEVT_STC_DRAG_OVER; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_DO_DROP()            { return wxEVT_STC_DO_DROP; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_ZOOM()               { return wxEVT_STC_ZOOM; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK()      { return wxEVT_STC_HOTSPOT_CLICK; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK()     { return wxEVT_STC_HOTSPOT_DCLICK; }
extern "C" WXEXPORT int wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK()      { return wxEVT_STC_CALLTIP_CLICK; }

//-----------------------------------------------------------------------------

class _StyledTextCtrl : public wxStyledTextCtrl
{
public:
    _StyledTextCtrl(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name)
        : wxStyledTextCtrl(parent, id, pos, size, style, name)
    {
    }

    DECLARE_OBJECTDELETED(_StyledTextCtrl)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStyledTextCtrl* wxStyledTextCtrl_ctor(wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, long style, char* name)
{
    if (name == NULL)
        name = "styledtextctrl";

    return new _StyledTextCtrl(parent, id, *pos, *size, style, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AddText(wxStyledTextCtrl* self, char* text)
{
    self->AddText(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AddStyledText(wxStyledTextCtrl* self, wxMemoryBuffer* data)
{
    self->AddStyledText(*data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_InsertText(wxStyledTextCtrl* self, int pos, char* text)
{
    self->InsertText(pos, wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ClearAll(wxStyledTextCtrl* self)
{
    self->ClearAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ClearDocumentStyle(wxStyledTextCtrl* self)
{
    self->ClearDocumentStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLength(wxStyledTextCtrl* self)
{
    return self->GetLength();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCharAt(wxStyledTextCtrl* self, int pos)
{
    return self->GetCharAt(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCurrentPos(wxStyledTextCtrl* self)
{
    return self->GetCurrentPos();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetAnchor(wxStyledTextCtrl* self)
{
    return self->GetAnchor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetStyleAt(wxStyledTextCtrl* self, int pos)
{
    return self->GetStyleAt(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Redo(wxStyledTextCtrl* self)
{
    self->Redo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetUndoCollection(wxStyledTextCtrl* self, bool collectUndo)
{
    self->SetUndoCollection(collectUndo);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SelectAll(wxStyledTextCtrl* self)
{
    self->SelectAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSavePoint(wxStyledTextCtrl* self)
{
    self->SetSavePoint();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMemoryBuffer* wxStyledTextCtrl_GetStyledText(wxStyledTextCtrl* self, int startPos, int endPos)
{
    return new wxMemoryBuffer(self->GetStyledText(startPos, endPos));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_CanRedo(wxStyledTextCtrl* self)
{
    return self->CanRedo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_MarkerLineFromHandle(wxStyledTextCtrl* self, int handle)
{
    return self->MarkerLineFromHandle(handle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerDeleteHandle(wxStyledTextCtrl* self, int handle)
{
    self->MarkerDeleteHandle(handle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetUndoCollection(wxStyledTextCtrl* self)
{
    return self->GetUndoCollection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetViewWhiteSpace(wxStyledTextCtrl* self)
{
    return self->GetViewWhiteSpace();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetViewWhiteSpace(wxStyledTextCtrl* self, int viewWS)
{
    self->SetViewWhiteSpace(viewWS);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_PositionFromPoint(wxStyledTextCtrl* self, wxPoint pt)
{
    return self->PositionFromPoint(pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_PositionFromPointClose(wxStyledTextCtrl* self, int x, int y)
{
    return self->PositionFromPointClose(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_GotoLine(wxStyledTextCtrl* self, int line)
{
    self->GotoLine(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_GotoPos(wxStyledTextCtrl* self, int pos)
{
    self->GotoPos(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetAnchor(wxStyledTextCtrl* self, int posAnchor)
{
    self->SetAnchor(posAnchor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextCtrl_GetCurLine(wxStyledTextCtrl* self, int* linePos)
{
    return new wxString(self->GetCurLine(linePos));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetEndStyled(wxStyledTextCtrl* self)
{
    return self->GetEndStyled();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ConvertEOLs(wxStyledTextCtrl* self, int eolMode)
{
    self->ConvertEOLs(eolMode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetEOLMode(wxStyledTextCtrl* self)
{
    return self->GetEOLMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetEOLMode(wxStyledTextCtrl* self, int eolMode)
{
    self->SetEOLMode(eolMode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StartStyling(wxStyledTextCtrl* self, int pos, int mask)
{
    self->StartStyling(pos, mask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetStyling(wxStyledTextCtrl* self, int length, int style)
{
    self->SetStyling(length, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetBufferedDraw(wxStyledTextCtrl* self)
{
    return self->GetBufferedDraw()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetBufferedDraw(wxStyledTextCtrl* self, bool buffered)
{
    self->SetBufferedDraw(buffered);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetTabWidth(wxStyledTextCtrl* self, int tabWidth)
{
    self->SetTabWidth(tabWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetTabWidth(wxStyledTextCtrl* self)
{
    return self->GetTabWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCodePage(wxStyledTextCtrl* self, int codePage)
{
    self->SetCodePage(codePage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerDefine(wxStyledTextCtrl* self, int markerNumber, int markerSymbol, wxColour* foreground, wxColour* background)
{
    if (background == NULL)
        background = background;

    self->MarkerDefine(markerNumber, markerSymbol, *foreground, *background);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerSetForeground(wxStyledTextCtrl* self, int markerNumber, wxColour* fore)
{
    self->MarkerSetForeground(markerNumber, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerSetBackground(wxStyledTextCtrl* self, int markerNumber, wxColour* back)
{
    self->MarkerSetBackground(markerNumber, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_MarkerAdd(wxStyledTextCtrl* self, int line, int markerNumber)
{
    return self->MarkerAdd(line, markerNumber);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerDelete(wxStyledTextCtrl* self, int line, int markerNumber)
{
    self->MarkerDelete(line, markerNumber);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerDeleteAll(wxStyledTextCtrl* self, int markerNumber)
{
    self->MarkerDeleteAll(markerNumber);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_MarkerGet(wxStyledTextCtrl* self, int line)
{
    return self->MarkerGet(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_MarkerNext(wxStyledTextCtrl* self, int lineStart, int markerMask)
{
    return self->MarkerNext(lineStart, markerMask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_MarkerPrevious(wxStyledTextCtrl* self, int lineStart, int markerMask)
{
    return self->MarkerPrevious(lineStart, markerMask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MarkerDefineBitmap(wxStyledTextCtrl* self, int markerNumber, wxBitmap* bmp)
{
    self->MarkerDefineBitmap(markerNumber, *bmp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginType(wxStyledTextCtrl* self, int margin, int marginType)
{
    self->SetMarginType(margin, marginType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMarginType(wxStyledTextCtrl* self, int margin)
{
    return self->GetMarginType(margin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginWidth(wxStyledTextCtrl* self, int margin, int pixelWidth)
{
    self->SetMarginWidth(margin, pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMarginWidth(wxStyledTextCtrl* self, int margin)
{
    return self->GetMarginWidth(margin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginMask(wxStyledTextCtrl* self, int margin, int mask)
{
    self->SetMarginMask(margin, mask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMarginMask(wxStyledTextCtrl* self, int margin)
{
    return self->GetMarginMask(margin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginSensitive(wxStyledTextCtrl* self, int margin, bool sensitive)
{
    self->SetMarginSensitive(margin, sensitive);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetMarginSensitive(wxStyledTextCtrl* self, int margin)
{
    return self->GetMarginSensitive(margin)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleClearAll(wxStyledTextCtrl* self)
{
    self->StyleClearAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetForeground(wxStyledTextCtrl* self, int style, wxColour* fore)
{
    self->StyleSetForeground(style, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetBackground(wxStyledTextCtrl* self, int style, wxColour* back)
{
    self->StyleSetBackground(style, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetBold(wxStyledTextCtrl* self, int style, bool bold)
{
    self->StyleSetBold(style, bold);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetItalic(wxStyledTextCtrl* self, int style, bool italic)
{
    self->StyleSetItalic(style, italic);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetSize(wxStyledTextCtrl* self, int style, int sizePoints)
{
    self->StyleSetSize(style, sizePoints);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetFaceName(wxStyledTextCtrl* self, int style, char* fontName)
{
    self->StyleSetFaceName(style, wxString(fontName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetEOLFilled(wxStyledTextCtrl* self, int style, bool filled)
{
    self->StyleSetEOLFilled(style, filled);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleResetDefault(wxStyledTextCtrl* self)
{
    self->StyleResetDefault();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetUnderline(wxStyledTextCtrl* self, int style, bool underline)
{
    self->StyleSetUnderline(style, underline);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetCase(wxStyledTextCtrl* self, int style, int caseForce)
{
    self->StyleSetCase(style, caseForce);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetCharacterSet(wxStyledTextCtrl* self, int style, int characterSet)
{
    self->StyleSetCharacterSet(style, characterSet);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetHotSpot(wxStyledTextCtrl* self, int style, bool hotspot)
{
    self->StyleSetHotSpot(style, hotspot);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSelForeground(wxStyledTextCtrl* self, bool useSetting, wxColour* fore)
{
    self->SetSelForeground(useSetting, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSelBackground(wxStyledTextCtrl* self, bool useSetting, wxColour* back)
{
    self->SetSelBackground(useSetting, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCaretForeground(wxStyledTextCtrl* self, wxColour* fore)
{
    self->SetCaretForeground(*fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CmdKeyAssign(wxStyledTextCtrl* self, int key, int modifiers, int cmd)
{
    self->CmdKeyAssign(key, modifiers, cmd);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CmdKeyClear(wxStyledTextCtrl* self, int key, int modifiers)
{
    self->CmdKeyClear(key, modifiers);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CmdKeyClearAll(wxStyledTextCtrl* self)
{
    self->CmdKeyClearAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetStyleBytes(wxStyledTextCtrl* self, int length, char* styleBytes)
{
    self->SetStyleBytes(length, styleBytes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetVisible(wxStyledTextCtrl* self, int style, bool visible)
{
    self->StyleSetVisible(style, visible);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCaretPeriod(wxStyledTextCtrl* self)
{
    return self->GetCaretPeriod();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCaretPeriod(wxStyledTextCtrl* self, int periodMilliseconds)
{
    self->SetCaretPeriod(periodMilliseconds);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetWordChars(wxStyledTextCtrl* self, char* characters)
{
    self->SetWordChars(wxString(characters, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_BeginUndoAction(wxStyledTextCtrl* self)
{
    self->BeginUndoAction();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_EndUndoAction(wxStyledTextCtrl* self)
{
    self->EndUndoAction();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_IndicatorSetStyle(wxStyledTextCtrl* self, int indic, int style)
{
    self->IndicatorSetStyle(indic, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_IndicatorGetStyle(wxStyledTextCtrl* self, int indic)
{
    return self->IndicatorGetStyle(indic);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_IndicatorSetForeground(wxStyledTextCtrl* self, int indic, wxColour* fore)
{
    self->IndicatorSetForeground(indic, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxStyledTextCtrl_IndicatorGetForeground(wxStyledTextCtrl* self, int indic)
{
    return new wxColour(self->IndicatorGetForeground(indic));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetWhitespaceForeground(wxStyledTextCtrl* self, bool useSetting, wxColour* fore)
{
    self->SetWhitespaceForeground(useSetting, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetWhitespaceBackground(wxStyledTextCtrl* self, bool useSetting, wxColour* back)
{
    self->SetWhitespaceBackground(useSetting, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetStyleBits(wxStyledTextCtrl* self, int bits)
{
    self->SetStyleBits(bits);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetStyleBits(wxStyledTextCtrl* self)
{
    return self->GetStyleBits();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLineState(wxStyledTextCtrl* self, int line, int state)
{
    self->SetLineState(line, state);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLineState(wxStyledTextCtrl* self, int line)
{
    return self->GetLineState(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMaxLineState(wxStyledTextCtrl* self)
{
    return self->GetMaxLineState();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetCaretLineVisible(wxStyledTextCtrl* self)
{
    return self->GetCaretLineVisible()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCaretLineVisible(wxStyledTextCtrl* self, bool show)
{
    self->SetCaretLineVisible(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxStyledTextCtrl_GetCaretLineBack(wxStyledTextCtrl* self)
{
    return new wxColour(self->GetCaretLineBack());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCaretLineBack(wxStyledTextCtrl* self, wxColour* back)
{
    self->SetCaretLineBack(*back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetChangeable(wxStyledTextCtrl* self, int style, bool changeable)
{
    self->StyleSetChangeable(style, changeable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompShow(wxStyledTextCtrl* self, int lenEntered, char* itemList)
{
    self->AutoCompShow(lenEntered, wxString(itemList, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompCancel(wxStyledTextCtrl* self)
{
    self->AutoCompCancel();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompActive(wxStyledTextCtrl* self)
{
    return self->AutoCompActive()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_AutoCompPosStart(wxStyledTextCtrl* self)
{
    return self->AutoCompPosStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompComplete(wxStyledTextCtrl* self)
{
    self->AutoCompComplete();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompStops(wxStyledTextCtrl* self, char* characterSet)
{
    self->AutoCompStops(wxString(characterSet, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetSeparator(wxStyledTextCtrl* self, int separatorCharacter)
{
    self->AutoCompSetSeparator(separatorCharacter);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_AutoCompGetSeparator(wxStyledTextCtrl* self)
{
    return self->AutoCompGetSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSelect(wxStyledTextCtrl* self, char* text)
{
    self->AutoCompSelect(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetCancelAtStart(wxStyledTextCtrl* self, bool cancel)
{
    self->AutoCompSetCancelAtStart(cancel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompGetCancelAtStart(wxStyledTextCtrl* self)
{
    return self->AutoCompGetCancelAtStart()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetFillUps(wxStyledTextCtrl* self, char* characterSet)
{
    self->AutoCompSetFillUps(wxString(characterSet, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetChooseSingle(wxStyledTextCtrl* self, bool chooseSingle)
{
    self->AutoCompSetChooseSingle(chooseSingle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompGetChooseSingle(wxStyledTextCtrl* self)
{
    return self->AutoCompGetChooseSingle()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetIgnoreCase(wxStyledTextCtrl* self, bool ignoreCase)
{
    self->AutoCompSetIgnoreCase(ignoreCase);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompGetIgnoreCase(wxStyledTextCtrl* self)
{
    return self->AutoCompGetIgnoreCase()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_UserListShow(wxStyledTextCtrl* self, int listType, char* itemList)
{
    self->UserListShow(listType, wxString(itemList, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetAutoHide(wxStyledTextCtrl* self, bool autoHide)
{
    self->AutoCompSetAutoHide(autoHide);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompGetAutoHide(wxStyledTextCtrl* self)
{
    return self->AutoCompGetAutoHide()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetDropRestOfWord(wxStyledTextCtrl* self, bool dropRestOfWord)
{
    self->AutoCompSetDropRestOfWord(dropRestOfWord);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_AutoCompGetDropRestOfWord(wxStyledTextCtrl* self)
{
    return self->AutoCompGetDropRestOfWord()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_RegisterImage(wxStyledTextCtrl* self, int type, wxBitmap* bmp)
{
    self->RegisterImage(type, *bmp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ClearRegisteredImages(wxStyledTextCtrl* self)
{
    self->ClearRegisteredImages();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_AutoCompGetTypeSeparator(wxStyledTextCtrl* self)
{
    return self->AutoCompGetTypeSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AutoCompSetTypeSeparator(wxStyledTextCtrl* self, int separatorCharacter)
{
    self->AutoCompSetTypeSeparator(separatorCharacter);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetIndent(wxStyledTextCtrl* self, int indentSize)
{
    self->SetIndent(indentSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetIndent(wxStyledTextCtrl* self)
{
    return self->GetIndent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetUseTabs(wxStyledTextCtrl* self, bool useTabs)
{
    self->SetUseTabs(useTabs);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetUseTabs(wxStyledTextCtrl* self)
{
    return self->GetUseTabs()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLineIndentation(wxStyledTextCtrl* self, int line, int indentSize)
{
    self->SetLineIndentation(line, indentSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLineIndentation(wxStyledTextCtrl* self, int line)
{
    return self->GetLineIndentation(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLineIndentPosition(wxStyledTextCtrl* self, int line)
{
    return self->GetLineIndentPosition(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetColumn(wxStyledTextCtrl* self, int pos)
{
    return self->GetColumn(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetUseHorizontalScrollBar(wxStyledTextCtrl* self, bool show)
{
    self->SetUseHorizontalScrollBar(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetUseHorizontalScrollBar(wxStyledTextCtrl* self)
{
    return self->GetUseHorizontalScrollBar()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetIndentationGuides(wxStyledTextCtrl* self, bool show)
{
    self->SetIndentationGuides(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetIndentationGuides(wxStyledTextCtrl* self)
{
    return self->GetIndentationGuides()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetHighlightGuide(wxStyledTextCtrl* self, int column)
{
    self->SetHighlightGuide(column);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetHighlightGuide(wxStyledTextCtrl* self)
{
    return self->GetHighlightGuide();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLineEndPosition(wxStyledTextCtrl* self, int line)
{
    return self->GetLineEndPosition(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCodePage(wxStyledTextCtrl* self)
{
    return self->GetCodePage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxStyledTextCtrl_GetCaretForeground(wxStyledTextCtrl* self)
{
    return new wxColour(self->GetCaretForeground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetReadOnly(wxStyledTextCtrl* self)
{
    return self->GetReadOnly()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCurrentPos(wxStyledTextCtrl* self, int pos)
{
    self->SetCurrentPos(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSelectionStart(wxStyledTextCtrl* self, int pos)
{
    self->SetSelectionStart(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetSelectionStart(wxStyledTextCtrl* self)
{
    return self->GetSelectionStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSelectionEnd(wxStyledTextCtrl* self, int pos)
{
    self->SetSelectionEnd(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetSelectionEnd(wxStyledTextCtrl* self)
{
    return self->GetSelectionEnd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetPrintMagnification(wxStyledTextCtrl* self, int magnification)
{
    self->SetPrintMagnification(magnification);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetPrintMagnification(wxStyledTextCtrl* self)
{
    return self->GetPrintMagnification();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetPrintColourMode(wxStyledTextCtrl* self, int mode)
{
    self->SetPrintColourMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetPrintColourMode(wxStyledTextCtrl* self)
{
    return self->GetPrintColourMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_FindText(wxStyledTextCtrl* self, int minPos, int maxPos, char* text, int flags)
{
    return self->FindText(minPos, maxPos, wxString(text, wxConvUTF8), flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_FormatRange(wxStyledTextCtrl* self, bool doDraw, int startPos, int endPos, wxDC* draw, wxDC* target, wxRect renderRect, wxRect pageRect)
{
    return self->FormatRange(doDraw, startPos, endPos, draw, target, renderRect, pageRect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetFirstVisibleLine(wxStyledTextCtrl* self)
{
    return self->GetFirstVisibleLine();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextCtrl_GetLine(wxStyledTextCtrl* self, int line)
{
    return new wxString(self->GetLine(line));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLineCount(wxStyledTextCtrl* self)
{
    return self->GetLineCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginLeft(wxStyledTextCtrl* self, int pixelWidth)
{
    self->SetMarginLeft(pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMarginLeft(wxStyledTextCtrl* self)
{
    return self->GetMarginLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMarginRight(wxStyledTextCtrl* self, int pixelWidth)
{
    self->SetMarginRight(pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMarginRight(wxStyledTextCtrl* self)
{
    return self->GetMarginRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetModify(wxStyledTextCtrl* self)
{
    return self->GetModify()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSelection(wxStyledTextCtrl* self, int start, int end)
{
    self->SetSelection(start, end);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextCtrl_GetSelectedText(wxStyledTextCtrl* self)
{
    return new wxString(self->GetSelectedText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextCtrl_GetTextRange(wxStyledTextCtrl* self, int startPos, int endPos)
{
    return new wxString(self->GetTextRange(startPos, endPos));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_HideSelection(wxStyledTextCtrl* self, bool normal)
{
    self->HideSelection(normal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_LineFromPosition(wxStyledTextCtrl* self, int pos)
{
    return self->LineFromPosition(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_PositionFromLine(wxStyledTextCtrl* self, int line)
{
    return self->PositionFromLine(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LineScroll(wxStyledTextCtrl* self, int columns, int lines)
{
    self->LineScroll(columns, lines);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_EnsureCaretVisible(wxStyledTextCtrl* self)
{
    self->EnsureCaretVisible();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ReplaceSelection(wxStyledTextCtrl* self, char* text)
{
    self->ReplaceSelection(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetReadOnly(wxStyledTextCtrl* self, bool readOnly)
{
    self->SetReadOnly(readOnly);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_CanPaste(wxStyledTextCtrl* self)
{
    return self->CanPaste()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_CanUndo(wxStyledTextCtrl* self)
{
    return self->CanUndo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_EmptyUndoBuffer(wxStyledTextCtrl* self)
{
    self->EmptyUndoBuffer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Undo(wxStyledTextCtrl* self)
{
    self->Undo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Cut(wxStyledTextCtrl* self)
{
    self->Cut();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Copy(wxStyledTextCtrl* self)
{
    self->Copy();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Paste(wxStyledTextCtrl* self)
{
    self->Paste();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Clear(wxStyledTextCtrl* self)
{
    self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetText(wxStyledTextCtrl* self, char* text)
{
    self->SetText(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextCtrl_GetText(wxStyledTextCtrl* self)
{
    return new wxString(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetTextLength(wxStyledTextCtrl* self)
{
    return self->GetTextLength();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetOvertype(wxStyledTextCtrl* self, bool overtype)
{
    self->SetOvertype(overtype);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetOvertype(wxStyledTextCtrl* self)
{
    return self->GetOvertype()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetCaretWidth(wxStyledTextCtrl* self, int pixelWidth)
{
    self->SetCaretWidth(pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCaretWidth(wxStyledTextCtrl* self)
{
    return self->GetCaretWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetTargetStart(wxStyledTextCtrl* self, int pos)
{
    self->SetTargetStart(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetTargetStart(wxStyledTextCtrl* self)
{
    return self->GetTargetStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetTargetEnd(wxStyledTextCtrl* self, int pos)
{
    self->SetTargetEnd(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetTargetEnd(wxStyledTextCtrl* self)
{
    return self->GetTargetEnd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_ReplaceTarget(wxStyledTextCtrl* self, char* text)
{
    return self->ReplaceTarget(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_ReplaceTargetRE(wxStyledTextCtrl* self, char* text)
{
    return self->ReplaceTargetRE(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_SearchInTarget(wxStyledTextCtrl* self, char* text)
{
    return self->SearchInTarget(wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSearchFlags(wxStyledTextCtrl* self, int flags)
{
    self->SetSearchFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetSearchFlags(wxStyledTextCtrl* self)
{
    return self->GetSearchFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipShow(wxStyledTextCtrl* self, int pos, char* definition)
{
    self->CallTipShow(pos, wxString(definition, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipCancel(wxStyledTextCtrl* self)
{
    self->CallTipCancel();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_CallTipActive(wxStyledTextCtrl* self)
{
    return self->CallTipActive()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_CallTipPosAtStart(wxStyledTextCtrl* self)
{
    return self->CallTipPosAtStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipSetHighlight(wxStyledTextCtrl* self, int start, int end)
{
    self->CallTipSetHighlight(start, end);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipSetBackground(wxStyledTextCtrl* self, wxColour* back)
{
    self->CallTipSetBackground(*back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipSetForeground(wxStyledTextCtrl* self, wxColour* fore)
{
    self->CallTipSetForeground(*fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CallTipSetForegroundHighlight(wxStyledTextCtrl* self, wxColour* fore)
{
    self->CallTipSetForegroundHighlight(*fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_VisibleFromDocLine(wxStyledTextCtrl* self, int line)
{
    return self->VisibleFromDocLine(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_DocLineFromVisible(wxStyledTextCtrl* self, int lineDisplay)
{
    return self->DocLineFromVisible(lineDisplay);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetFoldLevel(wxStyledTextCtrl* self, int line, int level)
{
    self->SetFoldLevel(line, level);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetFoldLevel(wxStyledTextCtrl* self, int line)
{
    return self->GetFoldLevel(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLastChild(wxStyledTextCtrl* self, int line, int level)
{
    return self->GetLastChild(line, level);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetFoldParent(wxStyledTextCtrl* self, int line)
{
    return self->GetFoldParent(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ShowLines(wxStyledTextCtrl* self, int lineStart, int lineEnd)
{
    self->ShowLines(lineStart, lineEnd);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_HideLines(wxStyledTextCtrl* self, int lineStart, int lineEnd)
{
    self->HideLines(lineStart, lineEnd);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetLineVisible(wxStyledTextCtrl* self, int line)
{
    return self->GetLineVisible(line)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetFoldExpanded(wxStyledTextCtrl* self, int line, bool expanded)
{
    self->SetFoldExpanded(line, expanded);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetFoldExpanded(wxStyledTextCtrl* self, int line)
{
    return self->GetFoldExpanded(line)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ToggleFold(wxStyledTextCtrl* self, int line)
{
    self->ToggleFold(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_EnsureVisible(wxStyledTextCtrl* self, int line)
{
    self->EnsureVisible(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetFoldFlags(wxStyledTextCtrl* self, int flags)
{
    self->SetFoldFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_EnsureVisibleEnforcePolicy(wxStyledTextCtrl* self, int line)
{
    self->EnsureVisibleEnforcePolicy(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetTabIndents(wxStyledTextCtrl* self, bool tabIndents)
{
    self->SetTabIndents(tabIndents);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetTabIndents(wxStyledTextCtrl* self)
{
    return self->GetTabIndents()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetBackSpaceUnIndents(wxStyledTextCtrl* self, bool bsUnIndents)
{
    self->SetBackSpaceUnIndents(bsUnIndents);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetBackSpaceUnIndents(wxStyledTextCtrl* self)
{
    return self->GetBackSpaceUnIndents()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMouseDwellTime(wxStyledTextCtrl* self, int periodMilliseconds)
{
    self->SetMouseDwellTime(periodMilliseconds);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetMouseDwellTime(wxStyledTextCtrl* self)
{
    return self->GetMouseDwellTime();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_WordStartPosition(wxStyledTextCtrl* self, int pos, bool onlyWordCharacters)
{
    return self->WordStartPosition(pos, onlyWordCharacters);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_WordEndPosition(wxStyledTextCtrl* self, int pos, bool onlyWordCharacters)
{
    return self->WordEndPosition(pos, onlyWordCharacters);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetWrapMode(wxStyledTextCtrl* self, int mode)
{
    self->SetWrapMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetWrapMode(wxStyledTextCtrl* self)
{
    return self->GetWrapMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLayoutCache(wxStyledTextCtrl* self, int mode)
{
    self->SetLayoutCache(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLayoutCache(wxStyledTextCtrl* self)
{
    return self->GetLayoutCache();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetScrollWidth(wxStyledTextCtrl* self, int pixelWidth)
{
    self->SetScrollWidth(pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetScrollWidth(wxStyledTextCtrl* self)
{
    return self->GetScrollWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_TextWidth(wxStyledTextCtrl* self, int style, char* text)
{
    return self->TextWidth(style, wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetEndAtLastLine(wxStyledTextCtrl* self, bool endAtLastLine)
{
    self->SetEndAtLastLine(endAtLastLine);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetEndAtLastLine(wxStyledTextCtrl* self)
{
    return (bool)self->GetEndAtLastLine()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_TextHeight(wxStyledTextCtrl* self, int line)
{
    return self->TextHeight(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetUseVerticalScrollBar(wxStyledTextCtrl* self, bool show)
{
    self->SetUseVerticalScrollBar(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetUseVerticalScrollBar(wxStyledTextCtrl* self)
{
    return self->GetUseVerticalScrollBar()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AppendText(wxStyledTextCtrl* self, int length, char* text)
{
    self->AppendText(length, wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetTwoPhaseDraw(wxStyledTextCtrl* self)
{
    return self->GetTwoPhaseDraw()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetTwoPhaseDraw(wxStyledTextCtrl* self, bool twoPhase)
{
    self->SetTwoPhaseDraw(twoPhase);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_TargetFromSelection(wxStyledTextCtrl* self)
{
    self->TargetFromSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LinesJoin(wxStyledTextCtrl* self)
{
    self->LinesJoin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LinesSplit(wxStyledTextCtrl* self, int pixelWidth)
{
    self->LinesSplit(pixelWidth);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetFoldMarginColour(wxStyledTextCtrl* self, bool useSetting, wxColour* back)
{
    self->SetFoldMarginColour(useSetting, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetFoldMarginHiColour(wxStyledTextCtrl* self, bool useSetting, wxColour* fore)
{
    self->SetFoldMarginHiColour(useSetting, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LineDuplicate(wxStyledTextCtrl* self)
{
    self->LineDuplicate();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_HomeDisplay(wxStyledTextCtrl* self)
{
    self->HomeDisplay();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_HomeDisplayExtend(wxStyledTextCtrl* self)
{
    self->HomeDisplayExtend();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LineEndDisplay(wxStyledTextCtrl* self)
{
    self->LineEndDisplay();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_LineEndDisplayExtend(wxStyledTextCtrl* self)
{
    self->LineEndDisplayExtend();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_MoveCaretInsideView(wxStyledTextCtrl* self)
{
    self->MoveCaretInsideView();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_LineLength(wxStyledTextCtrl* self, int line)
{
    return self->LineLength(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_BraceHighlight(wxStyledTextCtrl* self, int pos1, int pos2)
{
    self->BraceHighlight(pos1, pos2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_BraceBadLight(wxStyledTextCtrl* self, int pos)
{
    self->BraceBadLight(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_BraceMatch(wxStyledTextCtrl* self, int pos)
{
    return self->BraceMatch(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetViewEOL(wxStyledTextCtrl* self)
{
    return self->GetViewEOL()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetViewEOL(wxStyledTextCtrl* self, bool visible)
{
    self->SetViewEOL(visible);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_GetDocPointer(wxStyledTextCtrl* self)
{
    self->GetDocPointer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetDocPointer(wxStyledTextCtrl* self, void* docPointer)
{
    self->SetDocPointer(docPointer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetModEventMask(wxStyledTextCtrl* self, int mask)
{
    self->SetModEventMask(mask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetEdgeColumn(wxStyledTextCtrl* self)
{
    return self->GetEdgeColumn();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetEdgeColumn(wxStyledTextCtrl* self, int column)
{
    self->SetEdgeColumn(column);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetEdgeMode(wxStyledTextCtrl* self)
{
    return self->GetEdgeMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetEdgeMode(wxStyledTextCtrl* self, int mode)
{
    self->SetEdgeMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxStyledTextCtrl_GetEdgeColour(wxStyledTextCtrl* self)
{
    return new wxColour(self->GetEdgeColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetEdgeColour(wxStyledTextCtrl* self, wxColour* edgeColour)
{
    self->SetEdgeColour(*edgeColour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SearchAnchor(wxStyledTextCtrl* self)
{
    self->SearchAnchor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_SearchNext(wxStyledTextCtrl* self, int flags, char* text)
{
    return self->SearchNext(flags, wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_SearchPrev(wxStyledTextCtrl* self, int flags, char* text)
{
    return self->SearchPrev(flags, wxString(text, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_LinesOnScreen(wxStyledTextCtrl* self)
{
    return self->LinesOnScreen();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_UsePopUp(wxStyledTextCtrl* self, bool allowPopUp)
{
    self->UsePopUp(allowPopUp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_SelectionIsRectangle(wxStyledTextCtrl* self)
{
    return self->SelectionIsRectangle()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetZoom(wxStyledTextCtrl* self, int zoom)
{
    self->SetZoom(zoom);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetZoom(wxStyledTextCtrl* self)
{
    return self->GetZoom();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CreateDocument(wxStyledTextCtrl* self)
{
    self->CreateDocument();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_AddRefDocument(wxStyledTextCtrl* self, void* docPointer)
{
    self->AddRefDocument(docPointer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ReleaseDocument(wxStyledTextCtrl* self, void* docPointer)
{
    self->ReleaseDocument(docPointer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetModEventMask(wxStyledTextCtrl* self)
{
    return self->GetModEventMask();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSTCFocus(wxStyledTextCtrl* self, bool focus)
{
    self->SetSTCFocus(focus);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetSTCFocus(wxStyledTextCtrl* self)
{
    return self->GetSTCFocus()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetStatus(wxStyledTextCtrl* self, int statusCode)
{
    self->SetStatus(statusCode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetStatus(wxStyledTextCtrl* self)
{
    return self->GetStatus();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMouseDownCaptures(wxStyledTextCtrl* self, bool captures)
{
    self->SetMouseDownCaptures(captures);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetMouseDownCaptures(wxStyledTextCtrl* self)
{
    return self->GetMouseDownCaptures()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetSTCCursor(wxStyledTextCtrl* self, int cursorType)
{
    self->SetSTCCursor(cursorType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetSTCCursor(wxStyledTextCtrl* self)
{
    return self->GetSTCCursor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetControlCharSymbol(wxStyledTextCtrl* self, int symbol)
{
    self->SetControlCharSymbol(symbol);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetControlCharSymbol(wxStyledTextCtrl* self)
{
    return self->GetControlCharSymbol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_WordPartLeft(wxStyledTextCtrl* self)
{
    self->WordPartLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_WordPartLeftExtend(wxStyledTextCtrl* self)
{
    self->WordPartLeftExtend();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_WordPartRight(wxStyledTextCtrl* self)
{
    self->WordPartRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_WordPartRightExtend(wxStyledTextCtrl* self)
{
    self->WordPartRightExtend();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetVisiblePolicy(wxStyledTextCtrl* self, int visiblePolicy, int visibleSlop)
{
    self->SetVisiblePolicy(visiblePolicy, visibleSlop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_DelLineLeft(wxStyledTextCtrl* self)
{
    self->DelLineLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_DelLineRight(wxStyledTextCtrl* self)
{
    self->DelLineRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetXOffset(wxStyledTextCtrl* self, int newOffset)
{
    self->SetXOffset(newOffset);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetXOffset(wxStyledTextCtrl* self)
{
    return self->GetXOffset();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ChooseCaretX(wxStyledTextCtrl* self)
{
    self->ChooseCaretX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetXCaretPolicy(wxStyledTextCtrl* self, int caretPolicy, int caretSlop)
{
    self->SetXCaretPolicy(caretPolicy, caretSlop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetYCaretPolicy(wxStyledTextCtrl* self, int caretPolicy, int caretSlop)
{
    self->SetYCaretPolicy(caretPolicy, caretSlop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetPrintWrapMode(wxStyledTextCtrl* self, int mode)
{
    self->SetPrintWrapMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetPrintWrapMode(wxStyledTextCtrl* self)
{
    return self->GetPrintWrapMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetHotspotActiveForeground(wxStyledTextCtrl* self, bool useSetting, wxColour* fore)
{
    self->SetHotspotActiveForeground(useSetting, *fore);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetHotspotActiveBackground(wxStyledTextCtrl* self, bool useSetting, wxColour* back)
{
    self->SetHotspotActiveBackground(useSetting, *back);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetHotspotActiveUnderline(wxStyledTextCtrl* self, bool underline)
{
    self->SetHotspotActiveUnderline(underline);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StartRecord(wxStyledTextCtrl* self)
{
    self->StartRecord();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StopRecord(wxStyledTextCtrl* self)
{
    self->StopRecord();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLexer(wxStyledTextCtrl* self, int lexer)
{
    self->SetLexer(lexer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetLexer(wxStyledTextCtrl* self)
{
    return self->GetLexer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_Colourise(wxStyledTextCtrl* self, int start, int end)
{
    self->Colourise(start, end);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetProperty(wxStyledTextCtrl* self, char* key, char* value)
{
    self->SetProperty(wxString(key, wxConvUTF8), wxString(value, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetKeyWords(wxStyledTextCtrl* self, int keywordSet, char* keyWords)
{
    self->SetKeyWords(keywordSet, wxString(keyWords, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLexerLanguage(wxStyledTextCtrl* self, char* language)
{
    self->SetLexerLanguage(wxString(language, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextCtrl_GetCurrentLine(wxStyledTextCtrl* self)
{
    return self->GetCurrentLine();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetSpec(wxStyledTextCtrl* self, int styleNum, char* spec)
{
    self->StyleSetSpec(styleNum, wxString(spec, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetFont(wxStyledTextCtrl* self, int styleNum, wxFont* font)
{
    self->StyleSetFont(styleNum, *font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_StyleSetFontAttr(wxStyledTextCtrl* self, int styleNum, int size, char* faceName, bool bold, bool italic, bool underline)
{
    self->StyleSetFontAttr(styleNum, size, wxString(faceName, wxConvUTF8), bold, italic, underline);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_CmdKeyExecute(wxStyledTextCtrl* self, int cmd)
{
    self->CmdKeyExecute(cmd);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetMargins(wxStyledTextCtrl* self, int left, int right)
{
    self->SetMargins(left, right);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_GetSelection(wxStyledTextCtrl* self, int* startPos, int* endPos)
{
    self->GetSelection(startPos, endPos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_PointFromPosition(wxStyledTextCtrl* self, int pos, wxPoint* pt)
{
    *pt = self->PointFromPosition(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ScrollToLine(wxStyledTextCtrl* self, int line)
{
    self->ScrollToLine(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_ScrollToColumn(wxStyledTextCtrl* self, int column)
{
    self->ScrollToColumn(column);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxStyledTextCtrl_SendMsg(wxStyledTextCtrl* self, int msg, long wp, long lp)
{
    return self->SendMsg(msg, wp, lp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetVScrollBar(wxStyledTextCtrl* self, wxScrollBar* bar)
{
    self->SetVScrollBar(bar);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetHScrollBar(wxStyledTextCtrl* self, wxScrollBar* bar)
{
    self->SetHScrollBar(bar);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_GetLastKeydownProcessed(wxStyledTextCtrl* self)
{
    return self->GetLastKeydownProcessed()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextCtrl_SetLastKeydownProcessed(wxStyledTextCtrl* self, bool val)
{
    self->SetLastKeydownProcessed(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_SaveFile(wxStyledTextCtrl* self, char* filename)
{
    return self->SaveFile(wxString(filename, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextCtrl_LoadFile(wxStyledTextCtrl* self, char* filename)
{
    return self->LoadFile(wxString(filename, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStyledTextEvent* wxStyledTextEvent_ctor(wxEventType commandType, int id)
{
    return new wxStyledTextEvent(commandType, id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetPosition(wxStyledTextEvent* self, int pos)
{
    self->SetPosition(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetKey(wxStyledTextEvent* self, int k)
{
    self->SetKey(k);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetModifiers(wxStyledTextEvent* self, int m)
{
    self->SetModifiers(m);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetModificationType(wxStyledTextEvent* self, int t)
{
    self->SetModificationType(t);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetText(wxStyledTextEvent* self, char* t)
{
    self->SetText(wxString(t, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetLength(wxStyledTextEvent* self, int len)
{
    self->SetLength(len);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetLinesAdded(wxStyledTextEvent* self, int num)
{
    self->SetLinesAdded(num);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetLine(wxStyledTextEvent* self, int val)
{
    self->SetLine(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetFoldLevelNow(wxStyledTextEvent* self, int val)
{
    self->SetFoldLevelNow(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetFoldLevelPrev(wxStyledTextEvent* self, int val)
{
    self->SetFoldLevelPrev(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetMargin(wxStyledTextEvent* self, int val)
{
    self->SetMargin(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetMessage(wxStyledTextEvent* self, int val)
{
    self->SetMessage(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetWParam(wxStyledTextEvent* self, int val)
{
    self->SetWParam(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetLParam(wxStyledTextEvent* self, int val)
{
    self->SetLParam(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetListType(wxStyledTextEvent* self, int val)
{
    self->SetListType(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetX(wxStyledTextEvent* self, int val)
{
    self->SetX(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetY(wxStyledTextEvent* self, int val)
{
    self->SetY(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetDragText(wxStyledTextEvent* self, char* val)
{
    self->SetDragText(wxString(val, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetDragAllowMove(wxStyledTextEvent* self, bool val)
{
    self->SetDragAllowMove(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStyledTextEvent_SetDragResult(wxStyledTextEvent* self, wxDragResult val)
{
    self->SetDragResult(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetPosition(wxStyledTextEvent* self)
{
    return self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetKey(wxStyledTextEvent* self)
{
    return self->GetKey();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetModifiers(wxStyledTextEvent* self)
{
    return self->GetModifiers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetModificationType(wxStyledTextEvent* self)
{
    return self->GetModificationType();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextEvent_GetText(wxStyledTextEvent* self)
{
    return new wxString(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetLength(wxStyledTextEvent* self)
{
    return self->GetLength();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetLinesAdded(wxStyledTextEvent* self)
{
    return self->GetLinesAdded();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetLine(wxStyledTextEvent* self)
{
    return self->GetLine();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetFoldLevelNow(wxStyledTextEvent* self)
{
    return self->GetFoldLevelNow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetFoldLevelPrev(wxStyledTextEvent* self)
{
    return self->GetFoldLevelPrev();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetMargin(wxStyledTextEvent* self)
{
    return self->GetMargin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetMessage(wxStyledTextEvent* self)
{
    return self->GetMessage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetWParam(wxStyledTextEvent* self)
{
    return self->GetWParam();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetLParam(wxStyledTextEvent* self)
{
    return self->GetLParam();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetListType(wxStyledTextEvent* self)
{
    return self->GetListType();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetX(wxStyledTextEvent* self)
{
    return self->GetX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStyledTextEvent_GetY(wxStyledTextEvent* self)
{
    return self->GetY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStyledTextEvent_GetDragText(wxStyledTextEvent* self)
{
    return new wxString(self->GetDragText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextEvent_GetDragAllowMove(wxStyledTextEvent* self)
{
    return self->GetDragAllowMove()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDragResult* wxStyledTextEvent_GetDragResult(wxStyledTextEvent* self)
{
    return new wxDragResult(self->GetDragResult());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextEvent_GetShift(wxStyledTextEvent* self)
{
    return self->GetShift()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextEvent_GetControl(wxStyledTextEvent* self)
{
    return self->GetControl()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStyledTextEvent_GetAlt(wxStyledTextEvent* self)
{
    return self->GetAlt()?1:0;
}

#endif

