//-----------------------------------------------------------------------------
// wx.NET - dnd.cxx
//
// The wxDND proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/dnd.h>
#include <wx/dataobj.h>
#include "local_events.h"

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

//-----------------------------------------------------------------------------

typedef wxDragResult (CALLBACK* Virtual_DoDragDrop) (int);

class _DropSource : public wxDropSource
{
public:
	_DropSource(wxWindow* win)
		: wxDropSource(win) {}
		
	_DropSource(wxDataObject& data, wxWindow* win)
		: wxDropSource(data, win) {}	

	wxDragResult DoDragDrop(int flags) 
        { return m_DoDragDrop(flags); }
        
	void RegisterVirtual(Virtual_DoDragDrop doDragDrop)
	{
		m_DoDragDrop = doDragDrop;
	}
	
private:
	Virtual_DoDragDrop m_DoDragDrop;
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDropSource* wxDropSource_Win_ctor(wxWindow *win)
{
    return new _DropSource(win);
}

extern "C" WXEXPORT
wxDropSource* wxDropSource_DataObject_ctor(wxDataObject *dataObject, wxWindow *win)
{
    return new _DropSource(*dataObject, win);
}

extern "C" WXEXPORT
void wxDropSource_dtor(_DropSource* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropSource_RegisterVirtual(_DropSource* self, Virtual_DoDragDrop doDragDrop)
{
	self->RegisterVirtual(doDragDrop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDropSource_DoDragDrop(_DropSource* self, int flags)
{
	return self->wxDropSource::DoDragDrop(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropSource_SetData(_DropSource* self, wxDataObject* data)
{
	self->SetData(*data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDataObject* wxDropSource_GetDataObject(_DropSource* self)
{
	return self->GetDataObject();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropSource_SetCursor(_DropSource* self, wxDragResult* res, const wxCursor* cursor)
{
	self->SetCursor(*res, *cursor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDropSource_GiveFeedback(_DropSource* self, wxDragResult *effect)
{
	return self->GiveFeedback(*effect)?1:0;
}

//-----------------------------------------------------------------------------

typedef wxDragResult (CALLBACK* Virtual_OnDragOver) (wxCoord, wxCoord, wxDragResult);
typedef bool (CALLBACK* Virtual_OnDrop) (wxCoord, wxCoord);
typedef wxDragResult (CALLBACK* Virtual_OnData3) (wxCoord, wxCoord, wxDragResult);
typedef bool (CALLBACK* Virtual_GetData) ();
typedef void (CALLBACK* Virtual_OnLeave) ();
typedef wxDragResult (CALLBACK* Virtual_OnEnter) (wxCoord, wxCoord, wxDragResult);

class _DropTarget : public wxDropTarget
{
public:
	_DropTarget(wxDataObject* dataObject  = (wxDataObject*) NULL)
		: wxDropTarget(dataObject) {}

	wxDragResult OnDragOver(wxCoord x, wxCoord y, wxDragResult def) 
        { return m_OnDragOver(x, y, def); }
        
    bool OnDrop(wxCoord x, wxCoord y)
    	{ return m_OnDrop(x, y); }
    
    wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def)
    	{ return m_OnData(x, y, def); }
    	
    bool GetData()
    	{ return m_GetData(); }
    	
    void OnLeave()
    	{ return m_OnLeave(); }
    	
    wxDragResult OnEnter(wxCoord x, wxCoord y, wxDragResult def)
    	{ return m_OnEnter(x, y, def); }

	void RegisterVirtual(Virtual_OnDragOver onDragOver,
						Virtual_OnDrop onDrop,
						Virtual_OnData3 onData,
						Virtual_GetData getData,
						Virtual_OnLeave onLeave,
						Virtual_OnEnter onEnter)
	{
		m_OnDragOver = onDragOver;
		m_OnDrop = onDrop;
		m_OnData = onData;
		m_GetData = getData;
		m_OnLeave = onLeave;
		m_OnEnter = onEnter;
	}

private:
	Virtual_OnDragOver m_OnDragOver;
	Virtual_OnDrop     m_OnDrop;
	Virtual_OnData3    m_OnData;
	Virtual_GetData    m_GetData;
	Virtual_OnLeave    m_OnLeave;
	Virtual_OnEnter    m_OnEnter;
	
public:
	DECLARE_DISPOSABLE(_DropTarget)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDropTarget* wxDropTarget_ctor(wxDataObject *dataObject)
{
	if ( dataObject == NULL )
		dataObject = (wxDataObject*)NULL;
	
    return new _DropTarget(dataObject);
}

extern "C" WXEXPORT
void wxDropTarget_dtor(_DropTarget* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropTarget_RegisterVirtual(_DropTarget* self, Virtual_OnDragOver onDragOver,
						Virtual_OnDrop onDrop,
						Virtual_OnData3 onData,
						Virtual_GetData getData,
						Virtual_OnLeave onLeave,
						Virtual_OnEnter onEnter)
{
	self->RegisterVirtual(onDragOver, onDrop, onData, getData, onLeave, onEnter);
}

extern "C" WXEXPORT
void wxDropTarget_RegisterDisposable(_DropTarget* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxDataObject* wxDropTarget_GetDataObject(_DropTarget* self)
{
	return self->GetDataObject();
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropTarget_SetDataObject(_DropTarget* self, wxDataObject *dataObject)
{
	self->SetDataObject(dataObject);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDragResult wxDropTarget_OnEnter(_DropTarget* self, wxCoord x, wxCoord y, wxDragResult def)
{
	return self->wxDropTarget::OnEnter(x, y, def);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDragResult wxDropTarget_OnDragOver(_DropTarget* self, wxCoord x, wxCoord y, wxDragResult def)
{
	return self->wxDropTarget::OnDragOver(x, y, def);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDropTarget_OnLeave(_DropTarget* self)
{
	self->wxDropTarget::OnLeave();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDropTarget_OnDrop(_DropTarget* self, wxCoord x, wxCoord y)
{
	return self->wxDropTarget::OnDrop(x, y)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDropTarget_GetData(_DropTarget* self)
{
	return self->wxDropTarget::GetData()?1:0;
}

//----------------------------------------------------------------------------

typedef bool (CALLBACK* Virtual_OnDropText) (wxCoord, wxCoord, wxString*);
typedef wxDragResult (CALLBACK* Virtual_OnData)(wxCoord, wxCoord, wxDragResult);

class _TextDropTarget : public wxTextDropTarget
{
public:
	_TextDropTarget()
		: wxTextDropTarget() {}

	bool OnDropText(wxCoord x, wxCoord y, const wxString& text) 
        { return m_OnDropText(x, y, new wxString(text)); }
	wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def) 
        { return m_OnData(x, y, def); }

	void RegisterVirtual(Virtual_OnDropText onDropText, Virtual_OnData onData)
	{
		m_OnDropText = onDropText;
		m_OnData = onData;
	}

private:
	Virtual_OnDropText m_OnDropText;
	Virtual_OnData m_OnData;
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextDropTarget* wxTextDropTarget_ctor()
{
	return new _TextDropTarget();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTextDropTarget_RegisterVirtual(_TextDropTarget *self,
			Virtual_OnDropText onDropText,
			Virtual_OnData onData)
{
	self->RegisterVirtual(onDropText, onData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDragResult wxTextDropTarget_OnData(_TextDropTarget * self, wxCoord x, wxCoord y, wxDragResult def)
{
	return self->wxTextDropTarget::OnData(x, y, def);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTextDropTarget_OnDrop(_TextDropTarget * self, int x, int y)
{
	return self->wxTextDropTarget::OnDrop(x, y)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTextDropTarget_GetData(_TextDropTarget * self)
{
	return self->wxTextDropTarget::GetData()?1:0;
}

//----------------------------------------------------------------------------

typedef bool (CALLBACK* Virtual_OnDropFiles) (wxCoord, wxCoord, wxArrayString*);
typedef wxDragResult (CALLBACK* Virtual_OnData2)(wxCoord, wxCoord, wxDragResult);


class _FileDropTarget : public wxFileDropTarget
{
public:
	_FileDropTarget()
		: wxFileDropTarget() {}

	bool OnDropFiles(wxCoord x, wxCoord y, const wxArrayString& filenames) { return m_OnDropFiles(x, y, new wxArrayString(filenames)); }
	wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def) { return m_OnData(x, y, def); }

	void RegisterVirtual( Virtual_OnDropFiles onDropFiles,
				Virtual_OnData2 onData)
	{
		m_OnDropFiles = onDropFiles;
		m_OnData = onData;
	}

private:
	Virtual_OnDropFiles m_OnDropFiles;
	Virtual_OnData2 m_OnData;
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFileDropTarget* wxFileDropTarget_ctor()
{
	return new _FileDropTarget();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFileDropTarget_RegisterVirtual(_FileDropTarget *self,
			Virtual_OnDropFiles onDropFiles,
			Virtual_OnData2 onData)
{
	self->RegisterVirtual(onDropFiles, onData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDragResult wxFileDropTarget_OnData(_FileDropTarget *self, wxCoord x, wxCoord y, wxDragResult def)
{
	return self->wxFileDropTarget::OnData(x, y, def);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFileDropTarget_OnDrop(_FileDropTarget * self, int x, int y)
{
	return self->wxFileDropTarget::OnDrop(x, y)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFileDropTarget_GetData(_FileDropTarget * self)
{
	return self->wxFileDropTarget::GetData()?1:0;
}

//----------------------------------------------------------------------------
