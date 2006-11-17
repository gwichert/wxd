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
wxConfigBase* wxConfigBase_Get(dbit createOnDemand)
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
void wxConfigBase_SetPath(wxConfigBase* self, dstr strPath)
{
    self->SetPath(wxstr(strPath));
}

extern "C" WXEXPORT
dstrret wxConfigBase_GetPath(wxConfigBase* self)
{
    return dstr_ret(self->GetPath());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_GetFirstGroup(wxConfigBase* self, wxString* str, int *lIndex)
{
    return self->GetFirstGroup(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_GetNextGroup(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextGroup(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_GetFirstEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetFirstEntry(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_GetNextEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextEntry(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfEntries(wxConfigBase* self, dbit bRecursive)
{
    return self->GetNumberOfEntries(bRecursive);
}

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfGroups(wxConfigBase* self, dbit bRecursive)
{
    return self->GetNumberOfGroups(bRecursive);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_HasGroup(wxConfigBase* self, dstr strName)
{
    return self->HasGroup(wxstr(strName))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_HasEntry(wxConfigBase* self, dstr strName)
{
    return self->HasEntry(wxstr(strName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_Exists(wxConfigBase* self, dstr strName)
{
    return self->Exists(wxstr(strName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetEntryType(wxConfigBase* self, dstr name)
{
    return self->GetEntryType(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_ReadStr(wxConfigBase* self, dstr key, wxString* pStr)
{
    return self->Read(wxstr(key), pStr)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_ReadStrDef(wxConfigBase* self, dstr key, wxString* pStr, dstr defVal)
{
    return self->Read(wxstr(key), pStr, wxstr(defVal))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_ReadInt(wxConfigBase* self, dstr key, int* pl)
{
    return self->Read(wxstr(key), pl)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_ReadIntDef(wxConfigBase* self, dstr key, int* pl, int defVal)
{
    return self->Read(wxstr(key), pl, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_ReadDbl(wxConfigBase* self, dstr key, double* val)
{
    return self->Read(wxstr(key), val)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_ReadDblDef(wxConfigBase* self, dstr key, double* val, double defVal)
{
    return self->Read(wxstr(key), val, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_ReadBool(wxConfigBase* self, dstr key, dbit* val)
{
	bool v, ret;
	if (val) v = *val;
    ret =  self->Read(wxstr(key), &v)?1:0;
	if (val) *val = v;
	return ret;
}

extern "C" WXEXPORT
dbit wxConfigBase_ReadBoolDef(wxConfigBase* self, dstr key, dbit* val, dbit defVal)
{
	bool v, ret;
	if (val) v = *val;
    ret = self->Read(wxstr(key), &v, defVal)?1:0;
	if (val) *val = v;
	return ret;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxConfigBase_ReadStrRet(wxConfigBase* self, dstr key, dstr defVal)
{
    return dstr_ret(self->Read(wxstr(key), wxstr(defVal)));
}

extern "C" WXEXPORT
int wxConfigBase_ReadIntRet(wxConfigBase* self, dstr key, int defVal)
{
    return self->Read(wxstr(key), defVal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_WriteStr(wxConfigBase* self, dstr key, dstr value)
{
    return self->Write(wxstr(key), wxstr(value))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_WriteInt(wxConfigBase* self, dstr key, int value)
{
    return self->Write(wxstr(key), value)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_WriteDbl(wxConfigBase* self, dstr key, double value)
{
    return self->Write(wxstr(key), value)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_WriteBool(wxConfigBase* self, dstr key, dbit value)
{
    return self->Write(wxstr(key), value)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_Flush(wxConfigBase* self, dbit bCurrentOnly)
{
    return self->Flush(bCurrentOnly)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_RenameEntry(wxConfigBase* self, dstr oldName, dstr newName)
{
    return self->RenameEntry(wxstr(oldName), wxstr(newName))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_RenameGroup(wxConfigBase* self, dstr oldName, dstr newName)
{
    return self->RenameGroup(wxstr(oldName), wxstr(newName))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_DeleteEntry(wxConfigBase* self, dstr key, dbit bDeleteGroupIfEmpty)
{
    return self->DeleteEntry(wxstr(key), bDeleteGroupIfEmpty)?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_DeleteGroup(wxConfigBase* self, dstr key)
{
    return self->DeleteGroup(wxstr(key))?1:0;
}

extern "C" WXEXPORT
dbit wxConfigBase_DeleteAll(wxConfigBase* self)
{
    return self->DeleteAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxConfigBase_IsExpandingEnvVars(wxConfigBase* self)
{
    return self->IsExpandingEnvVars()?1:0;
}

extern "C" WXEXPORT
void wxConfigBase_SetExpandEnvVars(wxConfigBase* self, dbit bDoIt)
{
    self->SetExpandEnvVars(bDoIt);
}

extern "C" WXEXPORT
dstrret wxConfigBase_ExpandEnvVars(wxConfigBase* self, dstr str)
{
    return dstr_ret(self->ExpandEnvVars(wxstr(str)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_SetRecordDefaults(wxConfigBase* self, dbit bDoIt)
{
    self->SetRecordDefaults(bDoIt);
}

extern "C" WXEXPORT
dbit wxConfigBase_IsRecordingDefaults(wxConfigBase* self)
{
    return self->IsRecordingDefaults()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxConfigBase_GetAppName(wxConfigBase* self)
{
    return dstr_ret(self->GetAppName());
}

extern "C" WXEXPORT
void wxConfigBase_SetAppName(wxConfigBase* self, dstr appName)
{
    self->SetAppName(wxstr(appName));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxConfigBase_GetVendorName(wxConfigBase* self)
{
    return dstr_ret(self->GetVendorName());
}

extern "C" WXEXPORT
void wxConfigBase_SetVendorName(wxConfigBase* self, dstr vendorName)
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

