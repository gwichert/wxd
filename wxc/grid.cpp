//-----------------------------------------------------------------------------
// wx.NET - grid.cxx
// 
// The wxGrid proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/grid.h>
#include <wx/generic/gridctrl.h>
#include "local_events.h"

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif


//-----------------------------------------------------------------------------
// wxGridEvent

extern "C" WXEXPORT
wxGridEvent* wxGridEvent_ctor(int id, wxEventType type, wxObject* obj, int row, int col, int x, int y, bool sel, bool control, bool shift, bool alt, bool meta)
{
    return new wxGridEvent(id, type, obj, row, col, x, y, sel, control, shift, alt, meta);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridEvent_GetRow(wxGridEvent* self)
{
    return self->GetRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridEvent_GetCol(wxGridEvent* self)
{
    return self->GetCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridEvent_GetPosition(wxGridEvent* self, wxPoint* pt)
{
    *pt = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridEvent_Selecting(wxGridEvent* self)
{
    return self->Selecting()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridEvent_ControlDown(wxGridEvent* self)
{
    return self->ControlDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridEvent_MetaDown(wxGridEvent* self)
{
    return self->MetaDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridEvent_ShiftDown(wxGridEvent* self)
{
    return self->ShiftDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridEvent_AltDown(wxGridEvent* self)
{
    return self->AltDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridEvent_Veto(wxGridEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxGridEvent_Allow(wxGridEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
bool wxGridEvent_IsAllowed(wxGridEvent* self)
{
    return self->IsAllowed()?1:0;
}

//-----------------------------------------------------------------------------
// wxGridRangeSelectEvent

extern "C" WXEXPORT
wxGridRangeSelectEvent* wxGridRangeSelectEvent_ctor(int id, wxEventType type, wxObject* obj, wxGridCellCoords* topLeft, wxGridCellCoords* bottomRight, bool sel, bool control, bool shift, bool alt, bool meta)
{
    return new wxGridRangeSelectEvent(id, type, obj, *topLeft, *bottomRight, sel, control, shift, alt, meta);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellCoords* wxGridRangeSelectEvent_GetTopLeftCoords(wxGridRangeSelectEvent* self)
{
    return new wxGridCellCoords(self->GetTopLeftCoords());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellCoords* wxGridRangeSelectEvent_GetBottomRightCoords(wxGridRangeSelectEvent* self)
{
    return new wxGridCellCoords(self->GetBottomRightCoords());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridRangeSelectEvent_GetTopRow(wxGridRangeSelectEvent* self)
{
    return self->GetTopRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridRangeSelectEvent_GetBottomRow(wxGridRangeSelectEvent* self)
{
    return self->GetBottomRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridRangeSelectEvent_GetLeftCol(wxGridRangeSelectEvent* self)
{
    return self->GetLeftCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridRangeSelectEvent_GetRightCol(wxGridRangeSelectEvent* self)
{
    return self->GetRightCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_Selecting(wxGridRangeSelectEvent* self)
{
    return self->Selecting()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_ControlDown(wxGridRangeSelectEvent* self)
{
    return self->ControlDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_MetaDown(wxGridRangeSelectEvent* self)
{
    return self->MetaDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_ShiftDown(wxGridRangeSelectEvent* self)
{
    return self->ShiftDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_AltDown(wxGridRangeSelectEvent* self)
{
    return self->AltDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridRangeSelectEvent_Veto(wxGridRangeSelectEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxGridRangeSelectEvent_Allow(wxGridRangeSelectEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
bool wxGridRangeSelectEvent_IsAllowed(wxGridRangeSelectEvent* self)
{
    return self->IsAllowed()?1:0;
}

//-----------------------------------------------------------------------------
// wxGridCellWorker

typedef void (CALLBACK* Virtual_SetParameters) (wxString*);

class _GridCellWorker : public wxGridCellWorker
{
public:
    _GridCellWorker()
        : wxGridCellWorker() {}

    void SetParameters(const wxString& params)
        {
            return m_SetParameters(new wxString(params));
        }

    void RegisterVirtual(Virtual_SetParameters setParameters)
        {
            m_SetParameters = setParameters;
        }

private:
    Virtual_SetParameters m_SetParameters;
};

extern "C" WXEXPORT
wxGridCellWorker* wxGridCellWorker_ctor()
{
    return new _GridCellWorker();
}

extern "C" WXEXPORT
void wxGridCellWorker_RegisterVirtual(_GridCellWorker* self, Virtual_SetParameters setParameters)
{
    self->RegisterVirtual(setParameters);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellWorker_IncRef(_GridCellWorker* self)
{
    self->IncRef();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellWorker_DecRef(_GridCellWorker* self)
{
    self->DecRef();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellWorker_SetParameters(_GridCellWorker* self, const char* params)
{
    self->wxGridCellWorker::SetParameters(wxString(params, wxConvUTF8));
}

//-----------------------------------------------------------------------------
// wxGridEditorCreatedEvent

extern "C" WXEXPORT
wxGridEditorCreatedEvent* wxGridEditorCreatedEvent_ctor(int id, wxEventType type, wxObject* obj, int row, int col, wxControl* ctrl)
{
    return new wxGridEditorCreatedEvent(id, type, obj, row, col, ctrl);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridEditorCreatedEvent_GetRow(wxGridEditorCreatedEvent* self)
{
    return self->GetRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridEditorCreatedEvent_GetCol(wxGridEditorCreatedEvent* self)
{
    return self->GetCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxControl* wxGridEditorCreatedEvent_GetControl(wxGridEditorCreatedEvent* self)
{
    return self->GetControl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridEditorCreatedEvent_SetRow(wxGridEditorCreatedEvent* self, int row)
{
    self->SetRow(row);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridEditorCreatedEvent_SetCol(wxGridEditorCreatedEvent* self, int col)
{
    self->SetCol(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridEditorCreatedEvent_SetControl(wxGridEditorCreatedEvent* self, wxControl* ctrl)
{
    self->SetControl(ctrl);
}

//-----------------------------------------------------------------------------
// wxGrid

class _Grid : public wxGrid
{
public:
	_Grid()
		: wxGrid() {}
		
	_Grid(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name)
		: wxGrid(parent, id, pos, size, style, name) {}

	DECLARE_OBJECTDELETED(_Grid)
};

extern "C" WXEXPORT
wxGrid* wxGrid_ctor()
{
    return new _Grid();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGrid* wxGrid_ctorFull(wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, int style, const char* name)
{
    return new _Grid(parent, id, *pos, *size, style, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_dtor(wxGrid* self)   
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_CreateGrid(wxGrid* self, int numRows, int numCols, wxGrid::wxGridSelectionModes selmode)
{
    return self->CreateGrid(numRows, numCols, selmode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetSelectionMode(wxGrid* self, wxGrid::wxGridSelectionModes selmode)
{
    self->SetSelectionMode(selmode);
}

extern "C" WXEXPORT
wxGrid::wxGridSelectionModes wxGrid_GetSelectionMode(wxGrid* self)
{
    return self->GetSelectionMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetNumberRows(wxGrid* self)
{
    return self->GetNumberRows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetNumberCols(wxGrid* self)
{
    return self->GetNumberCols();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ProcessRowLabelMouseEvent(wxGrid* self, wxMouseEvent* event)
{
    self->ProcessRowLabelMouseEvent(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ProcessColLabelMouseEvent(wxGrid* self, wxMouseEvent* event)
{
    self->ProcessColLabelMouseEvent(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ProcessCornerLabelMouseEvent(wxGrid* self, wxMouseEvent* event)
{
    self->ProcessCornerLabelMouseEvent(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ProcessGridCellMouseEvent(wxGrid* self, wxMouseEvent* event)
{
    self->ProcessGridCellMouseEvent(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridTableBase* wxGrid_GetTable(wxGrid* self)
{
    return self->GetTable();
}

extern "C" WXEXPORT
bool wxGrid_SetTable(wxGrid* self, wxGridTableBase* table, bool takeOwnership, wxGrid::wxGridSelectionModes selmode)
{
    return self->SetTable(table, takeOwnership, selmode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ClearGrid(wxGrid* self)
{
    self->ClearGrid();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_InsertRows(wxGrid* self, int pos, int numRows, bool updateLabels)
{
    return self->InsertRows(pos, numRows, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_AppendRows(wxGrid* self, int numRows, bool updateLabels)
{
    return self->AppendRows(numRows, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_DeleteRows(wxGrid* self, int pos, int numRows, bool updateLabels)
{
    return self->DeleteRows(pos, numRows, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_InsertCols(wxGrid* self, int pos, int numCols, bool updateLabels)
{
    return self->InsertCols(pos, numCols, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_AppendCols(wxGrid* self, int numCols, bool updateLabels)
{
    return self->AppendCols(numCols, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_DeleteCols(wxGrid* self, int pos, int numCols, bool updateLabels)
{
    return self->DeleteCols(pos, numCols, updateLabels)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DrawGridCellArea(wxGrid* self, wxDC* dc, wxGridCellCoordsArray* cells)
{
    self->DrawGridCellArea(*dc, *cells);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DrawGridSpace(wxGrid* self, wxDC* dc)
{
    self->DrawGridSpace(*dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_BeginBatch(wxGrid* self)
{
    self->BeginBatch();
}

extern "C" WXEXPORT
void wxGrid_EndBatch(wxGrid* self)
{
    self->EndBatch();
}

extern "C" WXEXPORT
int wxGrid_GetBatchCount(wxGrid* self)
{
    return self->GetBatchCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ForceRefresh(wxGrid* self)
{
    self->ForceRefresh();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsEditable(wxGrid* self)
{
    return self->IsEditable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableEditing(wxGrid* self, bool edit)
{
    self->EnableEditing(edit);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableCellEditControl(wxGrid* self, bool enable)
{
    self->EnableCellEditControl(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DisableCellEditControl(wxGrid* self)
{
    self->DisableCellEditControl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_CanEnableCellControl(wxGrid* self)
{
    return self->CanEnableCellControl()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsCellEditControlEnabled(wxGrid* self)
{
    return self->IsCellEditControlEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsCellEditControlShown(wxGrid* self)
{
    return self->IsCellEditControlShown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsCurrentCellReadOnly(wxGrid* self)
{
    return self->IsCurrentCellReadOnly()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ShowCellEditControl(wxGrid* self)
{
    self->ShowCellEditControl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_HideCellEditControl(wxGrid* self)
{
    self->HideCellEditControl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SaveEditControlValue(wxGrid* self)
{
    self->SaveEditControlValue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_YToRow(wxGrid* self, int y)
{
    return self->YToRow(y);
}

extern "C" WXEXPORT
int wxGrid_XToCol(wxGrid* self, int x)
{
    return self->XToCol(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_YToEdgeOfRow(wxGrid* self, int y)
{
    return self->YToEdgeOfRow(y);
}

extern "C" WXEXPORT
int wxGrid_XToEdgeOfCol(wxGrid* self, int x)
{
    return self->XToEdgeOfCol(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_CellToRect(wxGrid* self, int row, int col, wxRect* rc)
{
    *rc = self->CellToRect(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetGridCursorRow(wxGrid* self)
{
    return self->GetGridCursorRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetGridCursorCol(wxGrid* self)
{
    return self->GetGridCursorCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsVisible(wxGrid* self, int row, int col, bool wholeCellVisible)
{
    return self->IsVisible(row, col, wholeCellVisible)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_MakeCellVisible(wxGrid* self, int row, int col)
{
    self->MakeCellVisible(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetGridCursor(wxGrid* self, int row, int col)
{
    self->SetGridCursor(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorUp(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorUp(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorDown(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorDown(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorLeft(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorLeft(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorRight(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorRight(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MovePageDown(wxGrid* self)
{
    return self->MovePageDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MovePageUp(wxGrid* self)
{
    return self->MovePageUp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorUpBlock(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorUpBlock(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorDownBlock(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorDownBlock(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorLeftBlock(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorLeftBlock(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_MoveCursorRightBlock(wxGrid* self, bool expandSelection)
{
    return self->MoveCursorRightBlock(expandSelection)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetDefaultRowLabelSize(wxGrid* self)
{
    return self->GetDefaultRowLabelSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetRowLabelSize(wxGrid* self)
{
    return self->GetRowLabelSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetDefaultColLabelSize(wxGrid* self)
{
    return self->GetDefaultColLabelSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetColLabelSize(wxGrid* self)
{
    return self->GetColLabelSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetLabelBackgroundColour(wxGrid* self)
{
    return new wxColour(self->GetLabelBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetLabelTextColour(wxGrid* self)
{
    return new wxColour(self->GetLabelTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxGrid_GetLabelFont(wxGrid* self)
{
    return new wxFont(self->GetLabelFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_GetRowLabelAlignment(wxGrid* self, int* horiz, int* vert)
{
    self->GetRowLabelAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_GetColLabelAlignment(wxGrid* self, int* horiz, int* vert)
{
    self->GetColLabelAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGrid_GetRowLabelValue(wxGrid* self, int row)
{
    return new wxString(self->GetRowLabelValue(row).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGrid_GetColLabelValue(wxGrid* self, int col)
{
    return new wxString(self->GetColLabelValue(col).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetGridLineColour(wxGrid* self)
{
    return new wxColour(self->GetGridLineColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetCellHighlightColour(wxGrid* self)
{
    return new wxColour(self->GetCellHighlightColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetCellHighlightPenWidth(wxGrid* self)
{
    return self->GetCellHighlightPenWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetCellHighlightROPenWidth(wxGrid* self)
{
    return self->GetCellHighlightROPenWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowLabelSize(wxGrid* self, int width)
{
    self->SetRowLabelSize(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColLabelSize(wxGrid* self, int height)
{
    self->SetColLabelSize(height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelBackgroundColour(wxGrid* self, wxColour* col)
{
    self->SetLabelBackgroundColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelTextColour(wxGrid* self, wxColour* col)
{
    self->SetLabelTextColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelFont(wxGrid* self, wxFont* font)
{
    self->SetLabelFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowLabelAlignment(wxGrid* self, int horiz, int vert)
{
    self->SetRowLabelAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColLabelAlignment(wxGrid* self, int horiz, int vert)
{
    self->SetColLabelAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowLabelValue(wxGrid* self, int row, const char* val)
{
    self->SetRowLabelValue(row, wxString(val, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColLabelValue(wxGrid* self, int col, const char* val)
{
    self->SetColLabelValue(col, wxString(val, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetGridLineColour(wxGrid* self, wxColour* col)
{
    self->SetGridLineColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellHighlightColour(wxGrid* self, wxColour* col)
{
    self->SetCellHighlightColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellHighlightPenWidth(wxGrid* self, int width)
{
    self->SetCellHighlightPenWidth(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellHighlightROPenWidth(wxGrid* self, int width)
{
    self->SetCellHighlightROPenWidth(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableDragRowSize(wxGrid* self, bool enable)
{
    self->EnableDragRowSize(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DisableDragRowSize(wxGrid* self)
{
    self->DisableDragRowSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_CanDragRowSize(wxGrid* self)
{
    return self->CanDragRowSize()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableDragColSize(wxGrid* self, bool enable)
{
    self->EnableDragColSize(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DisableDragColSize(wxGrid* self)
{
    self->DisableDragColSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_CanDragColSize(wxGrid* self)
{
    return self->CanDragColSize()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableDragGridSize(wxGrid* self, bool enable)
{
    self->EnableDragGridSize(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DisableDragGridSize(wxGrid* self)
{
    self->DisableDragGridSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_CanDragGridSize(wxGrid* self)
{
    return self->CanDragGridSize()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetAttr(wxGrid* self, int row, int col, wxGridCellAttr* attr)
{
    self->SetAttr(row, col, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowAttr(wxGrid* self, int row, wxGridCellAttr* attr)
{
    self->SetRowAttr(row, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColAttr(wxGrid* self, int col, wxGridCellAttr* attr)
{
    self->SetColAttr(col, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColFormatBool(wxGrid* self, int col)
{
    self->SetColFormatBool(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColFormatNumber(wxGrid* self, int col)
{
    self->SetColFormatNumber(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColFormatFloat(wxGrid* self, int col, int width, int precision)
{
    self->SetColFormatFloat(col, width, precision);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColFormatCustom(wxGrid* self, int col, const char* typeName)
{
    self->SetColFormatCustom(col, wxString(typeName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_EnableGridLines(wxGrid* self, bool enable)
{
    self->EnableGridLines(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_GridLinesEnabled(wxGrid* self)
{
    return self->GridLinesEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetDefaultRowSize(wxGrid* self)
{
    return self->GetDefaultRowSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetRowSize(wxGrid* self, int row)
{
    return self->GetRowSize(row);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetDefaultColSize(wxGrid* self)
{
    return self->GetDefaultColSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetColSize(wxGrid* self, int col)
{
    return self->GetColSize(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetDefaultCellBackgroundColour(wxGrid* self)
{
    return new wxColour(self->GetDefaultCellBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetCellBackgroundColour(wxGrid* self, int row, int col)
{
    return new wxColour(self->GetCellBackgroundColour(row, col));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetDefaultCellTextColour(wxGrid* self)
{
    return new wxColour(self->GetDefaultCellTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetCellTextColour(wxGrid* self, int row, int col)
{
    return new wxColour(self->GetCellTextColour(row, col));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxGrid_GetDefaultCellFont(wxGrid* self)
{
    return new wxFont(self->GetDefaultCellFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxGrid_GetCellFont(wxGrid* self, int row, int col)
{
    return new wxFont(self->GetCellFont(row, col));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_GetDefaultCellAlignment(wxGrid* self, int* horiz, int* vert)
{
    self->GetDefaultCellAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_GetCellAlignment(wxGrid* self, int row, int col, int* horiz, int* vert)
{
    self->GetCellAlignment(row, col, horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_GetDefaultCellOverflow(wxGrid* self)
{
    return self->GetDefaultCellOverflow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_GetCellOverflow(wxGrid* self, int row, int col)
{
    return self->GetCellOverflow(row, col)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_GetCellSize(wxGrid* self, int row, int col, int* num_rows, int* num_cols)
{
    self->GetCellSize(row, col, num_rows, num_cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultRowSize(wxGrid* self, int height, bool resizeExistingRows)
{
    self->SetDefaultRowSize(height, resizeExistingRows);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowSize(wxGrid* self, int row, int height)
{
    self->SetRowSize(row, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultColSize(wxGrid* self, int width, bool resizeExistingCols)
{
    self->SetDefaultColSize(width, resizeExistingCols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColSize(wxGrid* self, int col, int width)
{
    self->SetColSize(col, width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_AutoSizeColumn(wxGrid* self, int col, bool setAsMin)
{
    self->AutoSizeColumn(col, setAsMin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_AutoSizeRow(wxGrid* self, int row, bool setAsMin)
{
    self->AutoSizeRow(row, setAsMin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_AutoSizeColumns(wxGrid* self, bool setAsMin)
{
    self->AutoSizeColumns(setAsMin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_AutoSizeRows(wxGrid* self, bool setAsMin)
{
    self->AutoSizeRows(setAsMin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_AutoSize(wxGrid* self)
{
    self->AutoSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColMinimalWidth(wxGrid* self, int col, int width)
{
    self->SetColMinimalWidth(col, width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowMinimalHeight(wxGrid* self, int row, int width)
{
    self->SetRowMinimalHeight(row, width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColMinimalAcceptableWidth(wxGrid* self, int width)
{
    self->SetColMinimalAcceptableWidth(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowMinimalAcceptableHeight(wxGrid* self, int width)
{
    self->SetRowMinimalAcceptableHeight(width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetColMinimalAcceptableWidth(wxGrid* self)
{
    return self->GetColMinimalAcceptableWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetRowMinimalAcceptableHeight(wxGrid* self)
{
    return self->GetRowMinimalAcceptableHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultCellBackgroundColour(wxGrid* self, wxColour* col)
{
    self->SetDefaultCellBackgroundColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultCellTextColour(wxGrid* self, wxColour* col)
{
    self->SetDefaultCellTextColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultCellFont(wxGrid* self, wxFont* font)
{
    self->SetDefaultCellFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellFont(wxGrid* self, int row, int col, wxFont* font)
{
    self->SetCellFont(row, col, *font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultCellAlignment(wxGrid* self, int horiz, int vert)
{
    self->SetDefaultCellAlignment(horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellAlignmentHV(wxGrid* self, int row, int col, int horiz, int vert)
{
    self->SetCellAlignment(row, col, horiz, vert);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultCellOverflow(wxGrid* self, bool allow)
{
    self->SetDefaultCellOverflow(allow);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellOverflow(wxGrid* self, int row, int col, bool allow)
{
    self->SetCellOverflow(row, col, allow);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellSize(wxGrid* self, int row, int col, int num_rows, int num_cols)
{
    self->SetCellSize(row, col, num_rows, num_cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultRenderer(wxGrid* self, wxGridCellRenderer* renderer)
{
    self->SetDefaultRenderer(renderer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellRenderer(wxGrid* self, int row, int col, wxGridCellRenderer* renderer)
{
    self->SetCellRenderer(row, col, renderer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellRenderer* wxGrid_GetDefaultRenderer(wxGrid* self)
{
    return self->GetDefaultRenderer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellRenderer* wxGrid_GetCellRenderer(wxGrid* self, int row, int col)
{
    return self->GetCellRenderer(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDefaultEditor(wxGrid* self, wxGridCellEditor* editor)
{
    self->SetDefaultEditor(editor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellEditor(wxGrid* self, int row, int col, wxGridCellEditor* editor)
{
    self->SetCellEditor(row, col, editor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellEditor* wxGrid_GetDefaultEditor(wxGrid* self)
{
    return self->GetDefaultEditor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellEditor* wxGrid_GetCellEditor(wxGrid* self, int row, int col)
{
    return self->GetCellEditor(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGrid_GetCellValue(wxGrid* self, int row, int col)
{
    return new wxString(self->GetCellValue(row, col));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellValue(wxGrid* self, int row, int col, const char* s)
{
    self->SetCellValue(row, col, wxString(s, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsReadOnly(wxGrid* self, int row, int col)
{
    return self->IsReadOnly(row, col)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetReadOnly(wxGrid* self, int row, int col, bool isReadOnly)
{
    self->SetReadOnly(row, col, isReadOnly);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SelectRow(wxGrid* self, int row, bool addToSelected)
{
    self->SelectRow(row, addToSelected);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SelectCol(wxGrid* self, int col, bool addToSelected)
{
    self->SelectCol(col, addToSelected);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SelectBlock(wxGrid* self, int topRow, int leftCol, int bottomRow, int rightCol, bool addToSelected)
{
    self->SelectBlock(topRow, leftCol, bottomRow, rightCol, addToSelected);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SelectAll(wxGrid* self)
{
    self->SelectAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsSelection(wxGrid* self)
{
    return self->IsSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DeselectRow(wxGrid* self, int row)
{
    self->DeselectRow(row);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DeselectCol(wxGrid* self, int col)
{
    self->DeselectCol(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_DeselectCell(wxGrid* self, int row, int col)
{
    self->DeselectCell(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_ClearSelection(wxGrid* self)
{
    self->ClearSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_IsInSelection(wxGrid* self, int row, int col)
{
    return self->IsInSelection(row, col)?1:0;
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
wxGridCellCoordsArray* wxGrid_GetSelectedCells(wxGrid* self)
{
    return self->GetSelectedCells();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellCoordsArray* wxGrid_GetSelectionBlockTopLeft(wxGrid* self)
{
    return self->GetSelectionBlockTopLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellCoordsArray* wxGrid_GetSelectionBlockBottomRight(wxGrid* self)
{
    return self->GetSelectionBlockBottomRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxArrayInt* wxGrid_GetSelectedRows(wxGrid* self)
{
    return self->GetSelectedRows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxArrayInt* wxGrid_GetSelectedCols(wxGrid* self)
{
    return self->GetSelectedCols();
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_BlockToDeviceRect(wxGrid* self, wxGridCellCoords * topLeft, wxGridCellCoords * bottomRight, wxRect* rc)
{
    *rc = self->BlockToDeviceRect(*topLeft, *bottomRight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetSelectionBackground(wxGrid* self)
{
    return new wxColour(self->GetSelectionBackground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGrid_GetSelectionForeground(wxGrid* self)
{
    return new wxColour(self->GetSelectionForeground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetSelectionBackground(wxGrid* self, wxColour* c)
{
    self->SetSelectionBackground(*c);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetSelectionForeground(wxGrid* self, wxColour* c)
{
    self->SetSelectionForeground(*c);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_RegisterDataType(wxGrid* self, const char* typeName, wxGridCellRenderer* renderer, wxGridCellEditor* editor)
{
    self->RegisterDataType(wxString(typeName, wxConvUTF8), renderer, editor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellEditor* wxGrid_GetDefaultEditorForCell(wxGrid* self, int row, int col)
{
    return self->GetDefaultEditorForCell(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellRenderer* wxGrid_GetDefaultRendererForCell(wxGrid* self, int row, int col)
{
    return self->GetDefaultRendererForCell(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellEditor* wxGrid_GetDefaultEditorForType(wxGrid* self, const char* typeName)
{
    return self->GetDefaultEditorForType(wxString(typeName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellRenderer* wxGrid_GetDefaultRendererForType(wxGrid* self, const char* typeName)
{
    return self->GetDefaultRendererForType(wxString(typeName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetMargins(wxGrid* self, int extraWidth, int extraHeight)
{
    self->SetMargins(extraWidth, extraHeight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGrid_GetGridWindow(wxGrid* self)
{
    return self->GetGridWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGrid_GetGridRowLabelWindow(wxGrid* self)
{
    return self->GetGridRowLabelWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGrid_GetGridColLabelWindow(wxGrid* self)
{
    return self->GetGridColLabelWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGrid_GetGridCornerLabelWindow(wxGrid* self)
{
    return self->GetGridCornerLabelWindow();
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
wxGrid* wxGrid_ctor(wxWindow* parent, int x, int y, int w, int h, int style, char* name)
{
    if (name == NULL)
        name = &wxPanelNameStr;

    return new wxGrid(parent, x, y, w, h, style, wxString(name, wxConvUTF8));
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_UpdateDimensions(wxGrid* self)
{
    self->UpdateDimensions();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetRows(wxGrid* self)
{
    return self->GetRows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetCols(wxGrid* self)
{
    return self->GetCols();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetCursorRow(wxGrid* self)
{
    return self->GetCursorRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetCursorColumn(wxGrid* self)
{
    return self->GetCursorColumn();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetScrollPosX(wxGrid* self)
{
    return self->GetScrollPosX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetScrollPosY(wxGrid* self)
{
    return self->GetScrollPosY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetScrollX(wxGrid* self, int x)
{
    self->SetScrollX(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetScrollY(wxGrid* self, int y)
{
    self->SetScrollY(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetColumnWidth(wxGrid* self, int col, int width)
{
    self->SetColumnWidth(col, width);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetColumnWidth(wxGrid* self, int col)
{
    return self->GetColumnWidth(col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetRowHeight(wxGrid* self, int row, int height)
{
    self->SetRowHeight(row, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetViewHeight(wxGrid* self)
{
    return self->GetViewHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetViewWidth(wxGrid* self)
{
    return self->GetViewWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelSize(wxGrid* self, int orientation, int sz)
{
    self->SetLabelSize(orientation, sz);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetLabelSize(wxGrid* self, int orientation)
{
    return self->GetLabelSize(orientation);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelAlignment(wxGrid* self, int orientation, int align)
{
    self->SetLabelAlignment(orientation, align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetLabelAlignment(wxGrid* self, int orientation, int align)
{
    return self->GetLabelAlignment(orientation, align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetLabelValue(wxGrid* self, int orientation, const char* val, int pos)
{
    self->SetLabelValue(orientation, wxString(val, wxConvUTF8), pos);
}

extern "C" WXEXPORT
wxString* wxGrid_GetLabelValue(wxGrid* self, int orientation, int pos)
{
    return new wxString(self->GetLabelValue(orientation, pos));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxGrid_GetCellTextFontGrid(wxGrid* self)
{
    return new wxFont(self->GetCellTextFont());
}

extern "C" WXEXPORT
wxFont* wxGrid_GetCellTextFont(wxGrid* self, int row, int col)
{
    return new wxFont(self->GetCellTextFont(row, col));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellTextFontGrid(wxGrid* self, wxFont* fnt)
{
    self->SetCellTextFont(*fnt);
}

extern "C" WXEXPORT
void wxGrid_SetCellTextFont(wxGrid* self, wxFont* fnt, int row, int col)
{
    self->SetCellTextFont(*fnt, row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellTextColour(wxGrid* self, int row, int col, wxColour* val)
{
    self->SetCellTextColour(row, col, *val);
}

extern "C" WXEXPORT
void wxGrid_SetCellTextColourGrid(wxGrid* self, wxColour* col)
{
    self->SetCellTextColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellBackgroundColourGrid(wxGrid* self, wxColour* col)
{
    self->SetCellBackgroundColour(*col);
}

extern "C" WXEXPORT
void wxGrid_SetCellBackgroundColour(wxGrid* self, int row, int col, wxColour* colour)
{
    self->SetCellBackgroundColour(row, col, *colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_GetEditable(wxGrid* self)
{
    return self->GetEditable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetEditable(wxGrid* self, bool edit)
{
    self->SetEditable(edit);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGrid_GetEditInPlace(wxGrid* self)
{
    return self->GetEditInPlace()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellAlignment(wxGrid* self, int align, int row, int col)
{
    self->SetCellAlignment(align, row, col);
}

extern "C" WXEXPORT
void wxGrid_SetCellAlignmentGrid(wxGrid* self, int align)
{
    self->SetCellAlignment(align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetCellBitmap(wxGrid* self, wxBitmap* bitmap, int row, int col)
{
    self->SetCellBitmap(bitmap, row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_SetDividerPen(wxGrid* self, wxPen* pen)
{
    self->SetDividerPen(*pen);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPen* wxGrid_GetDividerPen(wxGrid* self)
{
    return &(self->GetDividerPen());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGrid_OnActivate(wxGrid* self, bool active)
{
    self->OnActivate(active);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGrid_GetRowHeight(wxGrid* self, int row)
{
    return self->GetRowHeight(row);
}

//-----------------------------------------------------------------------------
// wxGridCellCoords

extern "C" WXEXPORT
wxGridCellCoords* wxGridCellCoords_ctor()
{
    return new wxGridCellCoords();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellCoords_dtor(wxGridCellCoords* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridCellCoords_GetRow(wxGridCellCoords* self)
{
    return self->GetRow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellCoords_SetRow(wxGridCellCoords* self, int n)
{
    self->SetRow(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridCellCoords_GetCol(wxGridCellCoords* self)
{
    return self->GetCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellCoords_SetCol(wxGridCellCoords* self, int n)
{
    self->SetCol(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellCoords_Set(wxGridCellCoords* self, int row, int col)
{
    self->Set(row, col);
}

//-----------------------------------------------------------------------------
// wxGridCellAttr

extern "C" WXEXPORT
wxGridCellAttr* wxGridCellAttr_ctor(wxColour* colText, wxColour* colBack, wxFont* font, int hAlign, int vAlign)
{
    return new wxGridCellAttr(*colText, *colBack, *font, hAlign, vAlign);
}

extern "C" WXEXPORT
wxGridCellAttr* wxGridCellAttr_ctor2()
{
    return new wxGridCellAttr();
}

extern "C" WXEXPORT
wxGridCellAttr* wxGridCellAttr_ctor3(wxGridCellAttr* attrDefault)
{
    return new wxGridCellAttr(attrDefault);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellAttr* wxGridCellAttr_Clone(wxGridCellAttr* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_MergeWith(wxGridCellAttr* self, wxGridCellAttr* mergefrom)
{
    self->MergeWith(mergefrom);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_IncRef(wxGridCellAttr* self)
{
    self->IncRef();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_DecRef(wxGridCellAttr* self)
{
    self->DecRef();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetTextColour(wxGridCellAttr* self, wxColour* colText)
{
    self->SetTextColour(*colText);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetBackgroundColour(wxGridCellAttr* self, wxColour* colBack)
{
    self->SetBackgroundColour(*colBack);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetFont(wxGridCellAttr* self, wxFont* font)
{
    self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetAlignment(wxGridCellAttr* self, int hAlign, int vAlign)
{
    self->SetAlignment(hAlign, vAlign);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetSize(wxGridCellAttr* self, int num_rows, int num_cols)
{
    self->SetSize(num_rows, num_cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetOverflow(wxGridCellAttr* self, bool allow)
{
    self->SetOverflow(allow);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetReadOnly(wxGridCellAttr* self, bool isReadOnly)
{
    self->SetReadOnly(isReadOnly);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetRenderer(wxGridCellAttr* self, wxGridCellRenderer* renderer)
{
    self->SetRenderer(renderer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetEditor(wxGridCellAttr* self, wxGridCellEditor* editor)
{
    self->SetEditor(editor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasTextColour(wxGridCellAttr* self)
{
    return self->HasTextColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasBackgroundColour(wxGridCellAttr* self)
{
    return self->HasBackgroundColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasFont(wxGridCellAttr* self)
{
    return self->HasFont()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasAlignment(wxGridCellAttr* self)
{
    return self->HasAlignment()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasRenderer(wxGridCellAttr* self)
{
    return self->HasRenderer()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasEditor(wxGridCellAttr* self)
{
    return self->HasEditor()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_HasReadWriteMode(wxGridCellAttr* self)
{
    return self->HasReadWriteMode()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGridCellAttr_GetTextColour(wxGridCellAttr* self)
{
    return new wxColour(self->GetTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxGridCellAttr_GetBackgroundColour(wxGridCellAttr* self)
{
    return new wxColour(self->GetBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxGridCellAttr_GetFont(wxGridCellAttr* self)
{
    return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_GetAlignment(wxGridCellAttr* self, int* hAlign, int* vAlign)
{
    self->GetAlignment(hAlign, vAlign);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_GetSize(wxGridCellAttr* self, int* num_rows, int* num_cols)
{
    self->GetSize(num_rows, num_cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_GetOverflow(wxGridCellAttr* self)
{
    return self->GetOverflow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellAttr_GetRenderer(wxGridCellAttr* self, wxGrid* grid, int row, int col)
{
    return self->GetRenderer(grid, row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellAttr_GetEditor(wxGridCellAttr* self, wxGrid* grid, int row, int col)
{
    return self->GetEditor(grid, row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridCellAttr_IsReadOnly(wxGridCellAttr* self)
{
    return self->IsReadOnly()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellAttr_SetDefAttr(wxGridCellAttr* self, wxGridCellAttr* defAttr)
{
    self->SetDefAttr(defAttr);
}

//-----------------------------------------------------------------------------
// wxGridSizeEvent

extern "C" WXEXPORT
wxGridSizeEvent* wxGridSizeEvent_ctor()
{
    return new wxGridSizeEvent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridSizeEvent* wxGridSizeEvent_ctorParam(int id, wxEventType type, wxObject* obj, int rowOrCol, int x, int y, bool control, bool shift, bool alt, bool meta)
{
    return new wxGridSizeEvent(id, type, obj, rowOrCol, x, y, control, shift, alt, meta);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridSizeEvent_GetRowOrCol(wxGridSizeEvent* self)
{
    return self->GetRowOrCol();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizeEvent_GetPosition(wxGridSizeEvent* self, wxPoint* pt)
{
    *pt = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridSizeEvent_ControlDown(wxGridSizeEvent* self)
{
    return self->ControlDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridSizeEvent_MetaDown(wxGridSizeEvent* self)
{
    return self->MetaDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridSizeEvent_ShiftDown(wxGridSizeEvent* self)
{
    return self->ShiftDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridSizeEvent_AltDown(wxGridSizeEvent* self)
{
    return self->AltDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizeEvent_Veto(wxGridSizeEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxGridSizeEvent_Allow(wxGridSizeEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
bool wxGridSizeEvent_IsAllowed(wxGridSizeEvent* self)
{
    return self->IsAllowed()?1:0;
}

//-----------------------------------------------------------------------------
// wxGridCellEditor

typedef void (CALLBACK* Virtual_Create) (wxWindow*, wxWindowID id, wxEvtHandler*);
typedef void (CALLBACK* Virtual_BeginEdit) (int, int, wxGrid*);
typedef bool (CALLBACK* Virtual_EndEdit) (int, int, wxGrid*);
typedef void (CALLBACK* Virtual_Reset) ();
typedef wxGridCellEditor* (CALLBACK* Virtual_Clone) ();
typedef void (CALLBACK* Virtual_SetSize) (wxRect*);
typedef void (CALLBACK* Virtual_Show) (bool, wxGridCellAttr*);
typedef void (CALLBACK* Virtual_PaintBackground) (wxRect*, wxGridCellAttr*);
typedef bool (CALLBACK* Virtual_IsAcceptedKey) (wxKeyEvent*);
typedef void (CALLBACK* Virtual_StartingKey) (wxKeyEvent*);
typedef void (CALLBACK* Virtual_StartingClick) ();
typedef void (CALLBACK* Virtual_HandleReturn) (wxKeyEvent*);
typedef void (CALLBACK* Virtual_Destroy) ();
typedef char* (CALLBACK* Virtual_GetValue) ();

class _GridCellEditor : public wxGridCellEditor
{
public:
    _GridCellEditor()
        : wxGridCellEditor() {}
        
    void Create(wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
        { return m_Create(parent, id, evtHandler); }

    void BeginEdit(int row, int col, wxGrid* grid)
        { return m_BeginEdit(row, col, grid); }
        
    bool EndEdit(int row, int col, wxGrid* grid)
        { return m_EndEdit(row, col, grid); }
            
    void Reset()
        { return m_Reset(); }
        
    wxGridCellEditor* Clone() const
        { return m_Clone(); }
    
    void SetSize(const wxRect& rect)
        { return m_SetSize(new wxRect(rect));}
    
    void Show(bool show, wxGridCellAttr* attr)
        { return m_Show(show, attr);}
    
    void PaintBackground(const wxRect& rectCell, wxGridCellAttr* attr)
        { return m_PaintBackground(new wxRect(rectCell), attr);}
    
    bool IsAcceptedKey(wxKeyEvent& event)
        { return m_IsAcceptedKey(new wxKeyEvent(event));}
    
    void StartingKey(wxKeyEvent& event)
        { return m_StartingKey(new wxKeyEvent(event));}
    
    void StartingClick()
        { return m_StartingClick();}
    
    void HandleReturn(wxKeyEvent& event)
        { return m_HandleReturn(new wxKeyEvent(event));}
    
    void Destroy()
        { return m_Destroy();}
        
    wxString GetValue() const
        { return wxString(m_GetValue(), wxConvUTF8);}

    void RegisterVirtual(Virtual_Create create,
                            Virtual_BeginEdit beginEdit,
                            Virtual_EndEdit endEdit,
                            Virtual_Reset reset,
                            Virtual_Clone clone,
                            Virtual_SetSize setSize,
                            Virtual_Show show,
                            Virtual_PaintBackground paintBackground,
                            Virtual_IsAcceptedKey isAcceptedKey,
                            Virtual_StartingKey startingKey,
                            Virtual_StartingClick startingClick,
                            Virtual_HandleReturn handleReturn,
                            Virtual_Destroy destroy,
                            Virtual_GetValue getValue)
    {
        m_Create = create;
        m_BeginEdit = beginEdit;
        m_EndEdit = endEdit;
        m_Reset = reset;
        m_Clone = clone;
        m_SetSize = setSize;
        m_Show = show;
        m_PaintBackground = paintBackground;
        m_IsAcceptedKey = isAcceptedKey;
        m_StartingKey = startingKey;
        m_StartingClick = startingClick;
        m_HandleReturn = handleReturn;
        m_Destroy = destroy;
        m_GetValue = getValue;
    }
    
private:
    Virtual_Create m_Create;
    Virtual_BeginEdit m_BeginEdit;
    Virtual_EndEdit m_EndEdit;
    Virtual_Reset m_Reset;
    Virtual_Clone m_Clone;
    Virtual_SetSize m_SetSize;
    Virtual_Show m_Show;
    Virtual_PaintBackground m_PaintBackground;
    Virtual_IsAcceptedKey m_IsAcceptedKey;
    Virtual_StartingKey m_StartingKey;
    Virtual_StartingClick m_StartingClick;
    Virtual_HandleReturn m_HandleReturn;
    Virtual_Destroy m_Destroy;
    Virtual_GetValue m_GetValue;
};

extern "C" WXEXPORT
void wxGridCellEditor_RegisterVirtual(_GridCellEditor* self, Virtual_Create create,
                        Virtual_BeginEdit beginEdit,
                        Virtual_EndEdit endEdit,
                        Virtual_Reset reset,
                        Virtual_Clone clone,
                        Virtual_SetSize setSize,
                        Virtual_Show show,
                        Virtual_PaintBackground paintBackground,
                        Virtual_IsAcceptedKey isAcceptedKey,
                        Virtual_StartingKey startingKey,
                        Virtual_StartingClick startingClick,
                        Virtual_HandleReturn handleReturn,
                        Virtual_Destroy destroy,
                        Virtual_GetValue getvalue)
{
    self->RegisterVirtual(create, beginEdit, endEdit, reset, clone,
                setSize, show, paintBackground, isAcceptedKey, startingKey,
                startingClick, handleReturn, destroy, getvalue);
}


extern "C" WXEXPORT
wxGridCellEditor* wxGridCellEditor_ctor()
{
    return new _GridCellEditor();
}

extern "C" WXEXPORT
void wxGridCellEditor_dtor(_GridCellEditor* self)
{
    if (self != NULL)
    	delete self;
}

extern "C" WXEXPORT
void wxGridCellEditor_Create(_GridCellEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    return self->wxGridCellEditor::Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
bool wxGridCellEditor_IsCreated(_GridCellEditor* self)
{
    return self->IsCreated()?1:0;
}

extern "C" WXEXPORT
bool wxGridCellEditor_IsAcceptedKey(_GridCellEditor* self, wxKeyEvent* event)
{
    return self->wxGridCellEditor::IsAcceptedKey(*event)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_SetSize(_GridCellEditor* self, wxRect* rect)
{
    self->wxGridCellEditor::SetSize(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_Show(_GridCellEditor* self, bool show, wxGridCellAttr* attr)
{
    self->wxGridCellEditor::Show(show, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_PaintBackground(_GridCellEditor* self, wxRect* rectCell, wxGridCellAttr* attr)
{
    self->wxGridCellEditor::PaintBackground(*rectCell, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_StartingKey(_GridCellEditor* self, wxKeyEvent* event)
{
    self->wxGridCellEditor::StartingKey(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_StartingClick(_GridCellEditor* self)
{
    self->wxGridCellEditor::StartingClick();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_HandleReturn(_GridCellEditor* self, wxKeyEvent* event)
{
    self->wxGridCellEditor::HandleReturn(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridCellEditor_Destroy(_GridCellEditor* self)
{
    self->wxGridCellEditor::Destroy();
}

//-----------------------------------------------------------------------------
// wxGridTableBase...

typedef int (CALLBACK* Virtual_GetNumberRows) ();
typedef int (CALLBACK* Virtual_GetNumberCols) ();
typedef bool (CALLBACK* Virtual_IsEmptyCell) (int, int);
typedef char* (CALLBACK* Virtual_GetValue2) (int, int);
typedef void (CALLBACK* Virtual_SetValue) (int, int, wxString*);
typedef bool (CALLBACK* Virtual_CanGetValueAs) (int, int, wxString*);
typedef long (CALLBACK* Virtual_GetValueAsLong) (int, int);
typedef double (CALLBACK* Virtual_GetValueAsDouble) (int, int);
typedef void (CALLBACK* Virtual_SetValueAsLong) (int, int, long);
typedef void (CALLBACK* Virtual_SetValueAsDouble) (int, int, double);
typedef void (CALLBACK* Virtual_SetValueAsBool) (int, int, bool);
typedef void* (CALLBACK* Virtual_GetValueAsCustom) (int, int, wxString*);
typedef void (CALLBACK* Virtual_SetValueAsCustom) (int, int, wxString*, void*);
typedef char* (CALLBACK* Virtual_GetColLabelValue) (int);
typedef void (CALLBACK* Virtual_SetView) (wxGrid*);
typedef wxGrid* (CALLBACK* Virtual_GetView) ();
typedef void (CALLBACK* Virtual_Clear) ();
typedef bool (CALLBACK* Virtual_InsertRows) (int, int);
typedef bool (CALLBACK* Virtual_AppendRows) (int);
typedef void (CALLBACK* Virtual_SetRowLabelValue) (int, wxString*);
typedef void (CALLBACK* Virtual_SetAttrProvider) (wxGridCellAttrProvider*);
typedef wxGridCellAttrProvider* (CALLBACK* Virtual_GetAttrProvider) ();
typedef bool (CALLBACK* Virtual_CanHaveAttributes) ();
typedef wxGridCellAttr* (CALLBACK* Virtual_GetAttr) (int, int, wxGridCellAttr::wxAttrKind);
typedef void (CALLBACK* Virtual_SetAttr) (wxGridCellAttr*, int, int);
typedef void (CALLBACK* Virtual_SetRowAttr) (wxGridCellAttr*, int);

class _GridTableBase : public wxGridTableBase
{
public:
    _GridTableBase()
        : wxGridTableBase() {}

    int GetNumberRows()
        { return m_GetNumberRows();}

    int GetNumberCols()
        { return m_GetNumberCols();}

    bool IsEmptyCell(int row, int col)
        { return m_IsEmptyCell(row, col);}

    wxString GetValue(int row, int col)
        { return wxString(m_GetValue(row, col), wxConvUTF8);}

    void SetValue(int row, int col, const wxString& value)
        { m_SetValue(row, col, new wxString(value));}
    
    wxString GetTypeName(int row, int col)
        { return wxString(m_GetTypeName(row, col), wxConvUTF8);}
    
    bool CanGetValueAs(int row, int col, const wxString& typeName)
        { return m_CanGetValueAs(row, col, new wxString(typeName)); }
    
    bool CanSetValueAs(int row, int col, const wxString& typeName)
        { return m_CanSetValueAs(row, col, new wxString(typeName)); }
    
    long GetValueAsLong(int row, int col)
        { return m_GetValueAsLong(row, col);}
    
    double GetValueAsDouble(int row, int col)
        { return m_GetValueAsDouble(row, col); }
    
    bool GetValueAsBool(int row, int col)
        { return m_GetValueAsBool(row, col);}
    
    void SetValueAsLong(int row, int col, long value)
        { return m_SetValueAsLong(row, col, value);}
    
    void SetValueAsDouble(int row, int col, double value)
        { return m_SetValueAsDouble(row, col, value);}
    
    void SetValueAsBool(int row, int col, bool value)
        { return m_SetValueAsBool(row, col, value);}
    
    void* GetValueAsCustom(int row, int col, const wxString& typeName)
        { return m_GetValueAsCustom(row, col, new wxString(typeName));}
    
    void SetValueAsCustom(int row, int col, const wxString& typeName, void* value)
        { return m_SetValueAsCustom(row, col, new wxString(typeName), value);}
    
    void SetView(wxGrid* grid)
        { return m_SetView(grid);}
    
    wxGrid* GetView()
        { return m_GetView();}
    
    void Clear()
        { return m_Clear();}
    
    bool InsertRows(size_t pos, size_t numRows)
        { return m_InsertRows(pos, numRows);}
    
    bool AppendRows(size_t numRows)
        { return m_AppendRows(numRows);}
    
    bool DeleteRows(size_t pos, size_t numRows)
        { return m_DeleteRows(pos, numRows);}
    
    bool InsertCols(size_t pos, size_t numCols)
        { return m_InsertCols(pos, numCols);}
    
    bool AppendCols(size_t numCols)
        { return m_AppendCols(numCols);}
    
    bool DeleteCols(size_t pos, size_t numCols)
        { return m_DeleteCols(pos, numCols);}
    
    wxString GetRowLabelValue(int col)
        { return wxString(m_GetRowLabelValue(col), wxConvUTF8);}
    
    wxString GetColLabelValue(int col)
        { return wxString(m_GetColLabelValue(col), wxConvUTF8);}
    
    void SetRowLabelValue(int row, const wxString& value)
        { return m_SetRowLabelValue(row, new wxString(value));}
    
    void SetColLabelValue(int row, const wxString& value)
        { return m_SetColLabelValue(row, new wxString(value));}
    
    void SetAttrProvider(wxGridCellAttrProvider* attrProvider)
        { return m_SetAttrProvider(attrProvider);}
    
    wxGridCellAttrProvider* GetAttrProvider()
        { return m_GetAttrProvider(); }
    
    bool CanHaveAttributes()
        { return m_CanHaveAttributes();}
    
    wxGridCellAttr* GetAttr(int row, int col, wxGridCellAttr::wxAttrKind kind)
        { return m_GetAttr(row, col, kind);}
    
    void SetAttr(wxGridCellAttr* attr, int row, int col)
        { return m_SetAttr(attr, row, col); }
    
    void SetRowAttr(wxGridCellAttr* attr, int row)
        { return m_SetRowAttr(attr, row); }
    
    void SetColAttr(wxGridCellAttr* attr, int col)
        { return m_SetColAttr(attr, col); }

    void RegisterVirtual(Virtual_GetNumberRows getNumberRows,
            Virtual_GetNumberCols getNumberCols,
            Virtual_IsEmptyCell isEmptyCell,
            Virtual_GetValue2 getValue,
            Virtual_SetValue setValue,
            Virtual_GetValue2 getTypeName,
            Virtual_CanGetValueAs canGetValueAs,
            Virtual_CanGetValueAs canSetValueAs,
            Virtual_GetValueAsLong getValueAsLong,
            Virtual_GetValueAsDouble getValueAsDouble,
            Virtual_IsEmptyCell getValueAsBool,
            Virtual_SetValueAsLong setValueAsLong,
            Virtual_SetValueAsDouble setValueAsDouble,
            Virtual_SetValueAsBool setValueAsBool,
            Virtual_GetValueAsCustom getValueAsCustom,
            Virtual_SetValueAsCustom setValueAsCustom,
            Virtual_SetView setView,
            Virtual_GetView getView,
            Virtual_Clear clear,
            Virtual_InsertRows insertRows,
            Virtual_AppendRows appendRows,
            Virtual_InsertRows deleteRows,
            Virtual_InsertRows insertCols,
            Virtual_AppendRows appendCols,
            Virtual_InsertRows deleteCols,
            Virtual_GetColLabelValue getRowLabelValue,
            Virtual_GetColLabelValue getColLabelValue,
            Virtual_SetRowLabelValue setRowLabelValue,
            Virtual_SetRowLabelValue setColLabelValue,
            Virtual_SetAttrProvider setAttrProvider,
            Virtual_GetAttrProvider getAttrProvider,
            Virtual_CanHaveAttributes canHaveAttributes,
            Virtual_GetAttr getAttr,
            Virtual_SetAttr setAttr,
            Virtual_SetRowAttr setRowAttr,
            Virtual_SetRowAttr setColAttr)
        {
            m_GetNumberRows = getNumberRows;
            m_GetNumberCols = getNumberCols;
            m_IsEmptyCell = isEmptyCell;
            m_GetValue = getValue;
            m_SetValue = setValue;
            m_GetTypeName = getTypeName;
            m_CanGetValueAs = canGetValueAs;
            m_CanSetValueAs = canSetValueAs;
            m_GetValueAsLong = getValueAsLong;
            m_GetValueAsDouble = getValueAsDouble;
            m_GetValueAsBool = getValueAsBool;
            m_SetValueAsLong = setValueAsLong;
            m_SetValueAsDouble = setValueAsDouble;
            m_SetValueAsBool = setValueAsBool;
            m_GetValueAsCustom = getValueAsCustom;
            m_SetValueAsCustom = setValueAsCustom;
            m_GetColLabelValue = getColLabelValue;
            m_SetView = setView;
            m_GetView = getView;
            m_Clear = clear;
            m_InsertRows = insertRows;
            m_AppendRows = appendRows;
            m_DeleteRows = deleteRows;
            m_InsertCols = insertCols;
            m_AppendCols = appendCols;
            m_DeleteCols = deleteCols;
            m_GetRowLabelValue = getRowLabelValue;
            m_SetRowLabelValue = setRowLabelValue;
            m_SetColLabelValue = setColLabelValue;
            m_SetAttrProvider = setAttrProvider;
            m_GetAttrProvider = getAttrProvider;
            m_CanHaveAttributes = canHaveAttributes;
            m_GetAttr = getAttr;
            m_SetAttr = setAttr;
            m_SetRowAttr = setRowAttr;
            m_SetColAttr = setColAttr;
        }

private:
    Virtual_GetNumberRows m_GetNumberRows;
    Virtual_GetNumberCols m_GetNumberCols;
    Virtual_IsEmptyCell m_IsEmptyCell;
    Virtual_GetValue2 m_GetValue;
    Virtual_SetValue m_SetValue;
    Virtual_GetValue2 m_GetTypeName;
    Virtual_CanGetValueAs m_CanGetValueAs;
    Virtual_CanGetValueAs m_CanSetValueAs;
    Virtual_GetValueAsLong m_GetValueAsLong;
    Virtual_GetValueAsDouble m_GetValueAsDouble;
    Virtual_IsEmptyCell m_GetValueAsBool;
    Virtual_SetValueAsLong m_SetValueAsLong;
    Virtual_SetValueAsDouble m_SetValueAsDouble;
    Virtual_SetValueAsBool m_SetValueAsBool;
    Virtual_GetValueAsCustom m_GetValueAsCustom;
    Virtual_SetValueAsCustom m_SetValueAsCustom;
    Virtual_GetColLabelValue m_GetColLabelValue;
    Virtual_SetView m_SetView;
    Virtual_GetView m_GetView;
    Virtual_Clear m_Clear;
    Virtual_InsertRows m_InsertRows;
    Virtual_AppendRows m_AppendRows;
    Virtual_InsertRows m_DeleteRows;
    Virtual_InsertRows m_InsertCols;
    Virtual_AppendRows m_AppendCols;
    Virtual_InsertRows m_DeleteCols;
    Virtual_GetColLabelValue m_GetRowLabelValue;
    Virtual_SetRowLabelValue m_SetRowLabelValue;
    Virtual_SetRowLabelValue m_SetColLabelValue;
    Virtual_SetAttrProvider m_SetAttrProvider;
    Virtual_GetAttrProvider m_GetAttrProvider;
    Virtual_CanHaveAttributes m_CanHaveAttributes;
    Virtual_GetAttr m_GetAttr;
    Virtual_SetAttr m_SetAttr;
    Virtual_SetRowAttr m_SetRowAttr;
    Virtual_SetRowAttr m_SetColAttr;
};

extern "C" WXEXPORT
wxGridTableBase* wxGridTableBase_ctor()
{
    return new _GridTableBase();
}

extern "C" WXEXPORT
void wxGridTableBase_RegisterVirtual(_GridTableBase* self, Virtual_GetNumberRows getNumberRows,
            Virtual_GetNumberCols getNumberCols,
            Virtual_IsEmptyCell isEmptyCell,
            Virtual_GetValue2 getValue,
            Virtual_SetValue setValue,
            Virtual_GetValue2 getTypeName,
            Virtual_CanGetValueAs canGetValueAs,
            Virtual_CanGetValueAs canSetValueAs,
            Virtual_GetValueAsLong getValueAsLong,
            Virtual_GetValueAsDouble getValueAsDouble,
            Virtual_IsEmptyCell getValueAsBool,
            Virtual_SetValueAsLong setValueAsLong,
            Virtual_SetValueAsDouble setValueAsDouble,
            Virtual_SetValueAsBool setValueAsBool,
            Virtual_GetValueAsCustom getValueAsCustom,
            Virtual_SetValueAsCustom setValueAsCustom,
            Virtual_SetView setView,
            Virtual_GetView getView,
            Virtual_Clear clear,
            Virtual_InsertRows insertRows,
            Virtual_AppendRows appendRows,
            Virtual_InsertRows deleteRows,
            Virtual_InsertRows insertCols,
            Virtual_AppendRows appendCols,
            Virtual_InsertRows deleteCols,
            Virtual_GetColLabelValue getRowLabelValue,
            Virtual_GetColLabelValue getColLabelValue,
            Virtual_SetRowLabelValue setRowLabelValue,
            Virtual_SetRowLabelValue setColLabelValue,
            Virtual_SetAttrProvider setAttrProvider,
            Virtual_GetAttrProvider getAttrProvider,
            Virtual_CanHaveAttributes canHaveAttributes,
            Virtual_GetAttr getAttr,
            Virtual_SetAttr setAttr,
            Virtual_SetRowAttr setRowAttr,
            Virtual_SetRowAttr setColAttr)
{
    self->RegisterVirtual(getNumberRows, getNumberCols, isEmptyCell, getValue, setValue, getTypeName,
        canGetValueAs, canSetValueAs, getValueAsLong, getValueAsDouble, getValueAsBool,
        setValueAsLong, setValueAsDouble, setValueAsBool, getValueAsCustom, setValueAsCustom,
        setView, getView, clear, insertRows, appendRows, deleteRows,
        insertCols, appendCols, deleteCols, getRowLabelValue, getColLabelValue, setRowLabelValue,
        setColLabelValue, setAttrProvider, getAttrProvider, canHaveAttributes, getAttr,
        setAttr, setRowAttr, setColAttr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGridTableBase_GetTypeName(_GridTableBase* self, int row, int col)
{
    return new wxString(self->wxGridTableBase::GetTypeName(row, col).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_CanGetValueAs(_GridTableBase* self, int row, int col, const char* typeName)
{
    return self->wxGridTableBase::CanGetValueAs(row, col, wxString(typeName, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_CanSetValueAs(_GridTableBase* self, int row, int col, const char* typeName)
{
    return self->wxGridTableBase::CanSetValueAs(row, col, wxString(typeName, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxGridTableBase_GetValueAsLong(_GridTableBase* self, int row, int col)
{
    return self->wxGridTableBase::GetValueAsLong(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxGridTableBase_GetValueAsDouble(_GridTableBase* self, int row, int col)
{
    return self->wxGridTableBase::GetValueAsDouble(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_GetValueAsBool(_GridTableBase* self, int row, int col)
{
    return self->wxGridTableBase::GetValueAsBool(row, col)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetValueAsLong(_GridTableBase* self, int row, int col, long value)
{
    self->wxGridTableBase::SetValueAsLong(row, col, value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetValueAsDouble(_GridTableBase* self, int row, int col, double value)
{
    self->wxGridTableBase::SetValueAsDouble(row, col, value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetValueAsBool(_GridTableBase* self, int row, int col, bool value)
{
    self->wxGridTableBase::SetValueAsBool(row, col, value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void* wxGridTableBase_GetValueAsCustom(_GridTableBase* self, int row, int col, const char* typeName)
{
    return self->wxGridTableBase::GetValueAsCustom(row, col, wxString(typeName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetValueAsCustom(_GridTableBase* self, int row, int col, const char* typeName, void* value)
{
    self->wxGridTableBase::SetValueAsCustom(row, col, wxString(typeName, wxConvUTF8), value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetView(_GridTableBase* self, wxGrid* grid)
{
    self->wxGridTableBase::SetView(grid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGrid* wxGridTableBase_GetView(_GridTableBase* self)
{
    return self->wxGridTableBase::GetView();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_Clear(_GridTableBase* self)
{
    self->wxGridTableBase::Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_InsertRows(_GridTableBase* self, int pos, int numRows)
{
    return self->wxGridTableBase::InsertRows(pos, numRows)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_AppendRows(_GridTableBase* self, int numRows)
{
    return self->wxGridTableBase::AppendRows(numRows)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_DeleteRows(_GridTableBase* self, int pos, int numRows)
{
    return self->wxGridTableBase::DeleteRows(pos, numRows)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_InsertCols(_GridTableBase* self, int pos, int numCols)
{
    return self->wxGridTableBase::InsertCols(pos, numCols)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_AppendCols(_GridTableBase* self, int numCols)
{
    return self->wxGridTableBase::AppendCols(numCols)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_DeleteCols(_GridTableBase* self, int pos, int numCols)
{
    return self->wxGridTableBase::DeleteCols(pos, numCols)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGridTableBase_GetRowLabelValue(_GridTableBase* self, int row)
{
    return new wxString(self->wxGridTableBase::GetRowLabelValue(row).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGridTableBase_GetColLabelValue(_GridTableBase* self, int col)
{
    return new wxString(self->wxGridTableBase::GetColLabelValue(col).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetRowLabelValue(_GridTableBase* self, int row, const char* value)
{
    self->wxGridTableBase::SetRowLabelValue(row,  wxString(value, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetColLabelValue(_GridTableBase* self, int col, const char* value)
{
    self->wxGridTableBase::SetColLabelValue(col,  wxString(value, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetAttrProvider(_GridTableBase* self, wxGridCellAttrProvider* attrProvider)
{
    self->wxGridTableBase::SetAttrProvider(attrProvider);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellAttrProvider* wxGridTableBase_GetAttrProvider(_GridTableBase* self)
{
    return self->wxGridTableBase::GetAttrProvider();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxGridTableBase_CanHaveAttributes(_GridTableBase* self)
{
    return self->wxGridTableBase::CanHaveAttributes()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridCellAttr* wxGridTableBase_GetAttr(_GridTableBase* self, int row, int col, wxGridCellAttr::wxAttrKind kind)
{
    return self->wxGridTableBase::GetAttr(row, col, kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetAttr(_GridTableBase* self, wxGridCellAttr* attr, int row, int col)
{
    self->wxGridTableBase::SetAttr(attr, row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetRowAttr(_GridTableBase* self, wxGridCellAttr* attr, int row)
{
    self->wxGridTableBase::SetRowAttr(attr, row);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridTableBase_SetColAttr(_GridTableBase* self, wxGridCellAttr* attr, int col)
{
    self->wxGridTableBase::SetColAttr(attr, col);
}

//-----------------------------------------------------------------------------
// wxGridCellTextEditor

extern "C" WXEXPORT
wxGridCellTextEditor* wxGridCellTextEditor_ctor()
{
    return new wxGridCellTextEditor();
}

extern "C" WXEXPORT
void wxGridCellTextEditor_dtor(wxGridCellTextEditor* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellTextEditor_Create(wxGridCellTextEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
void wxGridCellTextEditor_SetSize(wxGridCellTextEditor* self, wxRect* rect)
{
    self->SetSize(*rect);
}

extern "C" WXEXPORT
void wxGridCellTextEditor_PaintBackground(wxGridCellTextEditor* self, wxRect* rectCell, wxGridCellAttr* attr)
{
    self->PaintBackground(*rectCell, attr);
}

extern "C" WXEXPORT
bool wxGridCellTextEditor_IsAcceptedKey(wxGridCellTextEditor* self, wxKeyEvent* event)
{
    return self->IsAcceptedKey(*event)?1:0;
}

extern "C" WXEXPORT
void wxGridCellTextEditor_BeginEdit(wxGridCellTextEditor* self, int row, int col, wxGrid* grid)
{
    return self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellTextEditor_EndEdit(wxGridCellTextEditor* self, int row, int col, wxGrid* grid)
{
    return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
void wxGridCellTextEditor_Reset(wxGridCellTextEditor* self)
{
    return self->Reset();
}

extern "C" WXEXPORT
void wxGridCellTextEditor_StartingKey(wxGridCellTextEditor* self, wxKeyEvent* event)
{
    return self->StartingKey(*event);
}

extern "C" WXEXPORT
void wxGridCellTextEditor_SetParameters(wxGridCellTextEditor* self, const char * params)
{
    self->SetParameters(wxString(params, wxConvUTF8));
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellTextEditor_Clone(wxGridCellTextEditor* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellAttrProvider

class _GridCellAttrProvider : public wxGridCellAttrProvider
{
public:
    _GridCellAttrProvider()
        : wxGridCellAttrProvider() {}
        
    wxGridCellAttr* GetAttr(int row, int col, wxGridCellAttr::wxAttrKind kind)
        { return m_GetAttr(row, col, kind);}
    
    void SetAttr(wxGridCellAttr* attr, int row, int col)
        { return m_SetAttr(attr, row, col); }
    
    void SetRowAttr(wxGridCellAttr* attr, int row)
        { return m_SetRowAttr(attr, row); }
    
    void SetColAttr(wxGridCellAttr* attr, int col)
        { return m_SetColAttr(attr, col); } 

    void RegisterVirtual(Virtual_GetAttr getAttr,
        Virtual_SetAttr setAttr,
        Virtual_SetRowAttr setRowAttr,
        Virtual_SetRowAttr setColAttr)
        {
            m_GetAttr = getAttr;
            m_SetAttr = setAttr;
            m_SetRowAttr = setRowAttr;
            m_SetColAttr = setColAttr;
        }

private:
    Virtual_GetAttr m_GetAttr;
    Virtual_SetAttr m_SetAttr;
    Virtual_SetRowAttr m_SetRowAttr;
    Virtual_SetRowAttr m_SetColAttr;
};

extern "C" WXEXPORT
wxGridCellAttrProvider* wxGridCellAttrProvider_ctor()
{
    return new _GridCellAttrProvider();
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_dtor(_GridCellAttrProvider* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_RegisterVirtual(_GridCellAttrProvider* self, 
    Virtual_GetAttr getAttr,
    Virtual_SetAttr setAttr,
    Virtual_SetRowAttr setRowAttr,
    Virtual_SetRowAttr setColAttr)
{
    self->RegisterVirtual(getAttr, setAttr, setRowAttr, setColAttr);
}

extern "C" WXEXPORT
wxGridCellAttr* wxGridCellAttrProvider_GetAttr(_GridCellAttrProvider* self, int row, int col, wxGridCellAttr::wxAttrKind kind)
{
    return self->wxGridCellAttrProvider::GetAttr(row, col, kind);
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_SetAttr(_GridCellAttrProvider* self, wxGridCellAttr* attr, int row, int col)
{
    self->wxGridCellAttrProvider::SetAttr(attr, row, col);
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_SetRowAttr(_GridCellAttrProvider* self, wxGridCellAttr* attr, int row)
{
    self->wxGridCellAttrProvider::SetRowAttr(attr, row);
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_SetColAttr(_GridCellAttrProvider* self, wxGridCellAttr* attr, int col)
{
    self->wxGridCellAttrProvider::SetColAttr(attr, col);
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_UpdateAttrRows(_GridCellAttrProvider* self, int pos, int numRows)
{
    self->UpdateAttrRows(pos, numRows);
}

extern "C" WXEXPORT
void wxGridCellAttrProvider_UpdateAttrCols(_GridCellAttrProvider* self, int pos, int numCols)
{
    self->UpdateAttrCols(pos, numCols);
}

//-----------------------------------------------------------------------------
// wxGridCellNumberEditor

class _GridCellNumberEditor : public wxGridCellNumberEditor
{
public:
	_GridCellNumberEditor(int min, int max)
		: wxGridCellNumberEditor(min, max) {}

	DECLARE_DISPOSABLE(_GridCellNumberEditor)
};

extern "C" WXEXPORT
wxGridCellNumberEditor* wxGridCellNumberEditor_ctor(int min, int max)
{
    return new _GridCellNumberEditor(min, max);
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_dtor(wxGridCellNumberEditor* self)
{
    if (self != NULL)
    	delete self;
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_RegisterDisposable(_GridCellNumberEditor* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_Create(wxGridCellNumberEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
bool wxGridCellNumberEditor_IsAcceptedKey(wxGridCellNumberEditor* self, wxKeyEvent* event)
{
    return self->IsAcceptedKey(*event)?1:0;
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_BeginEdit(wxGridCellNumberEditor* self, int row, int col, wxGrid* grid)
{
    return self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellNumberEditor_EndEdit(wxGridCellNumberEditor* self, int row, int col, wxGrid* grid)
{
    return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_Reset(wxGridCellNumberEditor* self)
{
    return self->Reset();
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_StartingKey(wxGridCellNumberEditor* self, wxKeyEvent* event)
{
    return self->StartingKey(*event);
}

extern "C" WXEXPORT
void wxGridCellNumberEditor_SetParameters(wxGridCellNumberEditor* self, const char * params)
{
    self->SetParameters(wxString(params, wxConvUTF8));
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellNumberEditor_Clone(wxGridCellNumberEditor* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellFloatEditor

extern "C" WXEXPORT
wxGridCellFloatEditor* wxGridCellFloatEditor_ctor(int width, int precision)
{
    return new wxGridCellFloatEditor(width, precision);
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_dtor(wxGridCellFloatEditor* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_Create(wxGridCellFloatEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
bool wxGridCellFloatEditor_IsAcceptedKey(wxGridCellFloatEditor* self, wxKeyEvent* event)
{
    return self->IsAcceptedKey(*event)?1:0;
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_BeginEdit(wxGridCellFloatEditor* self, int row, int col, wxGrid* grid)
{
    return self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellFloatEditor_EndEdit(wxGridCellFloatEditor* self, int row, int col, wxGrid* grid)
{
    return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_Reset(wxGridCellFloatEditor* self)
{
    return self->Reset();
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_StartingKey(wxGridCellFloatEditor* self, wxKeyEvent* event)
{
    return self->StartingKey(*event);
}

extern "C" WXEXPORT
void wxGridCellFloatEditor_SetParameters(wxGridCellFloatEditor* self, const char * params)
{
    self->SetParameters(wxString(params, wxConvUTF8));
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellFloatEditor_Clone(wxGridCellFloatEditor* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellBoolEditor

class _GridCellBoolEditor : public wxGridCellBoolEditor
{
public:
	_GridCellBoolEditor()
		: wxGridCellBoolEditor() {}

	DECLARE_DISPOSABLE(_GridCellBoolEditor)
};

extern "C" WXEXPORT
wxGridCellBoolEditor* wxGridCellBoolEditor_ctor()
{
    return new _GridCellBoolEditor();
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_dtor(wxGridCellBoolEditor* self)
{
    if (self != NULL)
    	delete self;
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_RegisterDisposable(_GridCellBoolEditor* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_Create(wxGridCellBoolEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_SetSize(wxGridCellBoolEditor* self, wxRect* rect)
{
    self->SetSize(*rect);
}

extern "C" WXEXPORT
bool wxGridCellBoolEditor_IsAcceptedKey(wxGridCellBoolEditor* self, wxKeyEvent* event)
{
    return self->IsAcceptedKey(*event)?1:0;
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_BeginEdit(wxGridCellBoolEditor* self, int row, int col, wxGrid* grid)
{
    self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellBoolEditor_EndEdit(wxGridCellBoolEditor* self, int row, int col, wxGrid* grid)
{
    return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_Reset(wxGridCellBoolEditor* self)
{
    return self->Reset();
}

extern "C" WXEXPORT
void wxGridCellBoolEditor_StartingClick(wxGridCellFloatEditor* self)
{
    return self->StartingClick();
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellBoolEditor_Clone(wxGridCellBoolEditor* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellChoiceEditor

class _GridCellChoiceEditor : public wxGridCellChoiceEditor
{
public:
	_GridCellChoiceEditor(size_t count, const wxString choices[], bool allowOthers)
		: wxGridCellChoiceEditor(count, choices, allowOthers) {}

	DECLARE_DISPOSABLE(_GridCellChoiceEditor)
};

extern "C" WXEXPORT
wxGridCellChoiceEditor* wxGridCellChoiceEditor_ctor(int n, char* choices[], bool allowOthers)
{
    wxString *pchoices = new wxString[n];
    for (int i = 0; i < n; ++i)
    {
        pchoices[i] = wxString(choices[i], wxConvUTF8);
        }

    return new _GridCellChoiceEditor(n, pchoices, allowOthers);
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_dtor(wxGridCellChoiceEditor* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_RegisterDisposable(_GridCellChoiceEditor* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_Create(wxGridCellChoiceEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
    self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_PaintBackground(wxGridCellChoiceEditor* self, wxRect* rect, wxGridCellAttr* attr)
{
    self->PaintBackground(*rect, attr);
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_BeginEdit(wxGridCellChoiceEditor* self, int row, int col, wxGrid* grid)
{
    return self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellChoiceEditor_EndEdit(wxGridCellChoiceEditor* self, int row, int col, wxGrid* grid)
{
    return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_Reset(wxGridCellChoiceEditor* self)
{
    return self->Reset();
}

extern "C" WXEXPORT
void wxGridCellChoiceEditor_SetParameters(wxGridCellChoiceEditor* self, const char * params)
{
    self->SetParameters(wxString(params, wxConvUTF8));
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellChoiceEditor_Clone(wxGridCellChoiceEditor* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellStringRenderer

class _GridCellStringRenderer : public wxGridCellStringRenderer
{
public:
	_GridCellStringRenderer()
		: wxGridCellStringRenderer() {}

	DECLARE_DISPOSABLE(_GridCellStringRenderer)
};

extern "C" WXEXPORT
wxGridCellStringRenderer* wxGridCellStringRenderer_ctor()
{
    return new _GridCellStringRenderer();
}

extern "C" WXEXPORT
void wxGridCellStringRenderer_dtor(wxGridCellStringRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellStringRenderer_RegisterDisposable(_GridCellStringRenderer* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellStringRenderer_Draw(wxGridCellStringRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
                wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
    self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellStringRenderer_GetBestSize(wxGridCellStringRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
                wxDC* dc, int row, int col, wxSize* size)
{
    *size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellStringRenderer_Clone(wxGridCellStringRenderer* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellNumberRenderer

extern "C" WXEXPORT
wxGridCellNumberRenderer* wxGridCellNumberRenderer_ctor()
{
    return new wxGridCellNumberRenderer();
}

extern "C" WXEXPORT
void wxGridCellNumberRenderer_dtor(wxGridCellNumberRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellNumberRenderer_Draw(wxGridCellNumberRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
                wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
    self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellNumberRenderer_GetBestSize(wxGridCellNumberRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
                wxDC* dc, int row, int col, wxSize* size)
{
    *size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellNumberRenderer_Clone(wxGridCellNumberRenderer* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellFloatRenderer

extern "C" WXEXPORT
wxGridCellFloatRenderer* wxGridCellFloatRenderer_ctor(int width, int precision)
{
    return new wxGridCellFloatRenderer(width, precision);
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_dtor(wxGridCellFloatRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_Draw(wxGridCellFloatRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
                wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
    self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_GetBestSize(wxGridCellFloatRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
                wxDC* dc, int row, int col, wxSize* size)
{
    *size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellFloatRenderer_Clone(wxGridCellFloatRenderer* self)
{
    return self->Clone();
}

extern "C" WXEXPORT
int wxGridCellFloatRenderer_GetWidth(wxGridCellFloatRenderer* self)
{
    return self->GetWidth();
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_SetWidth(wxGridCellFloatRenderer* self, int width)
{
    self->SetWidth(width);
}

extern "C" WXEXPORT
int wxGridCellFloatRenderer_GetPrecision(wxGridCellFloatRenderer* self)
{
    return self->GetPrecision();
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_SetPrecision(wxGridCellFloatRenderer* self, int precision)
{
    self->SetPrecision(precision);
}

extern "C" WXEXPORT
void wxGridCellFloatRenderer_SetParameters(wxGridCellFloatRenderer* self, const char* params)
{
    self->SetParameters(wxString(params, wxConvUTF8));
}

//-----------------------------------------------------------------------------
// wxGridCellBoolRenderer

class _GridCellBoolRenderer : public wxGridCellBoolRenderer
{
public:
	_GridCellBoolRenderer()
		: wxGridCellBoolRenderer() {}

	DECLARE_DISPOSABLE(_GridCellBoolRenderer)
};

extern "C" WXEXPORT
wxGridCellBoolRenderer* wxGridCellBoolRenderer_ctor()
{
    return new _GridCellBoolRenderer();
}

extern "C" WXEXPORT
void wxGridCellBoolRenderer_dtor(wxGridCellBoolRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellBoolRenderer_RegisterDisposable(_GridCellBoolRenderer* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellBoolRenderer_Draw(wxGridCellBoolRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
                wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
    self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellBoolRenderer_GetBestSize(wxGridCellBoolRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
                wxDC* dc, int row, int col, wxSize* size)
{
    *size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellBoolRenderer_Clone(wxGridCellBoolRenderer* self)
{
    return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellRenderer

typedef void (CALLBACK* Virtual_Draw) (wxGrid*, wxGridCellAttr*, wxDC*, wxRect*, int, int, bool);
typedef wxSize* (CALLBACK* Virtual_GetBestSize) (wxGrid*, wxGridCellAttr*, wxDC*, int, int);
typedef wxGridCellRenderer* (CALLBACK* Virtual_RendererClone) ();

class _GridCellRenderer : public wxGridCellRenderer
{
public:
    _GridCellRenderer()
        : wxGridCellRenderer() {}
        
    void Draw(wxGrid& grid, wxGridCellAttr& attr, wxDC& dc, const wxRect& rect, int row, int col, bool isSelected)
        { 
            return m_Draw(&grid, &attr, &dc, new wxRect(rect), row, col, isSelected);
        }
    
    wxSize GetBestSize(wxGrid& grid, wxGridCellAttr& attr, wxDC& dc, int row, int col)
        { return wxSize(*m_GetBestSize(&grid, &attr, &dc, row, col));}
    
    wxGridCellRenderer* Clone() const
        { return m_Clone();}

    void RegisterVirtual(Virtual_Draw draw,
        Virtual_GetBestSize getBestSize,
        Virtual_RendererClone clone)
        {
            m_Draw = draw;
            m_GetBestSize = getBestSize;
            m_Clone = clone;
        }

private:
    Virtual_Draw m_Draw;
    Virtual_GetBestSize m_GetBestSize;
    Virtual_RendererClone m_Clone;
};

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellRenderer_ctor()
{
    return new _GridCellRenderer();
}

extern "C" WXEXPORT
void wxGridCellRenderer_dtor(_GridCellRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellRenderer_RegisterVirtual(_GridCellRenderer* self, 
        Virtual_Draw draw,
        Virtual_GetBestSize getBestSize,
        Virtual_RendererClone clone)
{
    self->RegisterVirtual(draw, getBestSize, clone);
}
