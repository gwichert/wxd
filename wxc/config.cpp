//-----------------------------------------------------------------------------
// wxD - config.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - config.cxx
// 
// The wxConfig proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/config.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxConfigBase* wxConfigBase_Set(wxConfigBase* pConfig)
{
    return wxConfigBase::Set(pConfig);
}

extern "C" WXEXPORT
wxConfigBase* wxConfigBase_Get(wxc_bool createOnDemand)
{
    return wxConfigBase::Get(createOnDemand);
}

extern "C" WXEXPORT
wxConfigBase* wxConfigBase_Create()
{
    return wxConfigBase::Create();
}

extern "C" WXEXPORT
void wxConfigBase_DontCreateOnDemand()
{
    wxConfigBase::DontCreateOnDemand();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_dtor(wxConfigBase* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_SetPath(wxConfigBase* self, wxc_string strPath)
{
    self->SetPath(wxstr(strPath));
}

extern "C" WXEXPORT
wxString* wxConfigBase_GetPath(wxConfigBase* self)
{
    return new wxString(self->GetPath());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_GetFirstGroup(wxConfigBase* self, wxString* str, int *lIndex)
{
    return self->GetFirstGroup(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_GetNextGroup(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextGroup(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_GetFirstEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetFirstEntry(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_GetNextEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextEntry(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfEntries(wxConfigBase* self, wxc_bool bRecursive)
{
    return self->GetNumberOfEntries(bRecursive);
}

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfGroups(wxConfigBase* self, wxc_bool bRecursive)
{
    return self->GetNumberOfGroups(bRecursive);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_HasGroup(wxConfigBase* self, wxc_string strName)
{
    return self->HasGroup(wxstr(strName))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_HasEntry(wxConfigBase* self, wxc_string strName)
{
    return self->HasEntry(wxstr(strName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_Exists(wxConfigBase* self, wxc_string strName)
{
    return self->Exists(wxstr(strName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetEntryType(wxConfigBase* self, wxc_string name)
{
    return self->GetEntryType(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadStr(wxConfigBase* self, wxc_string key, wxString* pStr)
{
    return self->Read(wxstr(key), pStr)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadStrDef(wxConfigBase* self, wxc_string key, wxString* pStr, wxc_string defVal)
{
    return self->Read(wxstr(key), pStr, wxstr(defVal))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadInt(wxConfigBase* self, wxc_string key, int* pl)
{
    return self->Read(wxstr(key), pl)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadIntDef(wxConfigBase* self, wxc_string key, int* pl, int defVal)
{
    return self->Read(wxstr(key), pl, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadDbl(wxConfigBase* self, wxc_string key, double* val)
{
    return self->Read(wxstr(key), val)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadDblDef(wxConfigBase* self, wxc_string key, double* val, double defVal)
{
    return self->Read(wxstr(key), val, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadBool(wxConfigBase* self, wxc_string key, wxc_bool* val)
{
	bool v, ret;
	if (val) v = *val;
    ret =  self->Read(wxstr(key), &v)?1:0;
	if (val) *val = v;
	return ret;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_ReadBoolDef(wxConfigBase* self, wxc_string key, wxc_bool* val, wxc_bool defVal)
{
	bool v, ret;
	if (val) v = *val;
    ret = self->Read(wxstr(key), &v, defVal)?1:0;
	if (val) *val = v;
	return ret;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxConfigBase_ReadStrRet(wxConfigBase* self, wxc_string key, wxc_string defVal)
{
    return new wxString(self->Read(wxstr(key), wxstr(defVal)));
}

extern "C" WXEXPORT
int wxConfigBase_ReadIntRet(wxConfigBase* self, wxc_string key, int defVal)
{
    return self->Read(wxstr(key), defVal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_WriteStr(wxConfigBase* self, wxc_string key, wxc_string value)
{
    return self->Write(wxstr(key), wxstr(value))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_WriteInt(wxConfigBase* self, wxc_string key, int value)
{
    return self->Write(wxstr(key), value)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_WriteDbl(wxConfigBase* self, wxc_string key, double value)
{
    return self->Write(wxstr(key), value)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_WriteBool(wxConfigBase* self, wxc_string key, wxc_bool value)
{
    return self->Write(wxstr(key), value)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_Flush(wxConfigBase* self, wxc_bool bCurrentOnly)
{
    return self->Flush(bCurrentOnly)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_RenameEntry(wxConfigBase* self, wxc_string oldName, wxc_string newName)
{
    return self->RenameEntry(wxstr(oldName), wxstr(newName))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_RenameGroup(wxConfigBase* self, wxc_string oldName, wxc_string newName)
{
    return self->RenameGroup(wxstr(oldName), wxstr(newName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_DeleteEntry(wxConfigBase* self, wxc_string key, wxc_bool bDeleteGroupIfEmpty)
{
    return self->DeleteEntry(wxstr(key), bDeleteGroupIfEmpty)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_DeleteGroup(wxConfigBase* self, wxc_string key)
{
    return self->DeleteGroup(wxstr(key))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_DeleteAll(wxConfigBase* self)
{
    return self->DeleteAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxConfigBase_IsExpandingEnvVars(wxConfigBase* self)
{
    return self->IsExpandingEnvVars()?1:0;
}

extern "C" WXEXPORT
void wxConfigBase_SetExpandEnvVars(wxConfigBase* self, wxc_bool bDoIt)
{
    self->SetExpandEnvVars(bDoIt);
}

extern "C" WXEXPORT
wxString* wxConfigBase_ExpandEnvVars(wxConfigBase* self, wxc_string str)
{
    return new wxString(self->ExpandEnvVars(wxstr(str)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_SetRecordDefaults(wxConfigBase* self, wxc_bool bDoIt)
{
    self->SetRecordDefaults(bDoIt);
}

extern "C" WXEXPORT
wxc_bool wxConfigBase_IsRecordingDefaults(wxConfigBase* self)
{
    return self->IsRecordingDefaults()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxConfigBase_GetAppName(wxConfigBase* self)
{
    return new wxString(self->GetAppName());
}

extern "C" WXEXPORT
void wxConfigBase_SetAppName(wxConfigBase* self, wxc_string appName)
{
    self->SetAppName(wxstr(appName));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxConfigBase_GetVendorName(wxConfigBase* self)
{
    return new wxString(self->GetVendorName());
}

extern "C" WXEXPORT
void wxConfigBase_SetVendorName(wxConfigBase* self, wxc_string vendorName)
{
    self->SetVendorName(wxstr(vendorName));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_SetStyle(wxConfigBase* self, int style)
{
    self->SetStyle(style);
}

extern "C" WXEXPORT
int wxConfigBase_GetStyle(wxConfigBase* self)
{
    return self->GetStyle();
}

//-----------------------------------------------------------------------------

