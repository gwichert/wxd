//-----------------------------------------------------------------------------
// wxD - glcanvas.cpp
// (C) 2006 afb <afb@users.sourceforge.net>
//
// wxGLCanvas, for OpenGL windows
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/glcanvas.h>
#include <wx/window.h>
#include "local_events.h"

#if wxUSE_GLCANVAS

//-----------------------------------------------------------------------------
// wxGLContext

extern "C" WXEXPORT
void wxGLContext_SetCurrent(wxGLContext* self)
{
	self->SetCurrent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_Update(wxGLContext* self)
{
#ifndef __WXGTK__
	// must be called after window drag/grows/zoom or clut change
	self->Update();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_SetColour(wxGLContext* self, dstr colour)
{
	self->SetColour(wxString(colour.data, wxConvUTF8, colour.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_SwapBuffers(wxGLContext* self)
{
	self->SwapBuffers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGLContext_GetWindow(wxGLContext* self)
{
	return self->GetWindow();
}

//-----------------------------------------------------------------------------
// wxGLCanvas

class _GLCanvas : public wxGLCanvas
{
public:
	_GLCanvas(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxChar* name,
		int* attribList, const wxPalette& palette)
		: wxGLCanvas(parent, id, pos, size, style, name, attribList, palette)
	{
	}
	_GLCanvas(wxWindow* parent, const wxGLContext *shared, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxChar* name,
		int* attribList, const wxPalette& palette)
		: wxGLCanvas(parent, shared, id, pos, size, style, name, attribList, palette)
	{
	}
	_GLCanvas(wxWindow* parent, const wxGLCanvas *shared, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxChar* name,
		int* attribList, const wxPalette& palette)
		: wxGLCanvas(parent, shared, id, pos, size, style, name, attribList, palette)
	{
	}

    DECLARE_OBJECTDELETED(_GLCanvas)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxGLCanvas* wxGLCanvas_ctor(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, dstr name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length), attribList, *palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGLCanvas* wxGLCanvas_ctor2(wxWindow *parent, const wxGLContext *shared, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, dstr name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, shared, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length), attribList, *palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGLCanvas* wxGLCanvas_ctor3(wxWindow *parent, const wxGLCanvas *shared, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, dstr name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, shared, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length), attribList, *palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLCanvas_SetCurrent(wxGLCanvas* self)
{
	self->SetCurrent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLCanvas_UpdateContext(wxGLCanvas* self)
{
#ifndef __WXGTK__
	self->UpdateContext();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLCanvas_SetColour(wxGLCanvas* self, dstr colour)
{
	self->SetColour(wxString(colour.data, wxConvUTF8, colour.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLCanvas_SwapBuffers(wxGLCanvas* self)
{
	self->SwapBuffers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGLContext* wxGLCanvas_GetContext(wxGLCanvas* self)
{
	return self->GetContext();
}

#else
#ifdef __GNUC__
#warning "wxUSE_GLCANVAS is not set"
#endif
#endif
