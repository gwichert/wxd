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
void wxGLContext_SetCurrent(wxGLContext* self, wxGLCanvas *canvas)
{
#if wxABI_VERSION < 20700 || (wxABI_VERSION < 20900 && defined(__WXMAC__))
	self->SetCurrent();
#else
	self->SetCurrent(*canvas);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_Update(wxGLContext* self)
{
#if wxABI_VERSION < 20900 && defined(__WXMAC__)
	// must be called after window drag/grows/zoom or clut change
	self->Update();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_SetColour(wxGLContext* self, wxc_string colour)
{
#if wxABI_VERSION < 20700 || (wxABI_VERSION < 20900 && defined(__WXMAC__))
	self->SetColour(wxstr(colour));
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLContext_SwapBuffers(wxGLContext* self)
{
#if wxABI_VERSION < 20700 || (wxABI_VERSION < 20900 && defined(__WXMAC__))
	self->SwapBuffers();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxGLContext_GetWindow(wxGLContext* self)
{
#if wxABI_VERSION < 20700 || (wxABI_VERSION < 20900 && defined(__WXMAC__))
	return self->GetWindow();
#else
	return NULL;
#endif
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
					const wxSize* size, int style, wxc_string name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, id, *pos, *size, style, wxstr(name), attribList, *palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGLCanvas* wxGLCanvas_ctor2(wxWindow *parent, const wxGLContext *shared, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, wxc_string name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, shared, id, *pos, *size, style, wxstr(name), attribList, *palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGLCanvas* wxGLCanvas_ctor3(wxWindow *parent, const wxGLCanvas *shared, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, wxc_string name, int* attribList,  const wxPalette* palette)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("GLCanvas");

	if (palette == NULL)
		palette = &wxNullPalette;

	return new _GLCanvas(parent, shared, id, *pos, *size, style, wxstr(name), attribList, *palette);
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
#if wxABI_VERSION < 20900 && defined(__WXMAC__)
	self->UpdateContext();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGLCanvas_SetColour(wxGLCanvas* self, wxc_string colour)
{
	self->SetColour(wxstr(colour));
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
