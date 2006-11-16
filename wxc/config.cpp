//-----------------------------------------------------------------------------
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
#include <wx/config.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxConfigBase* wxConfigBase_Set(wxConfigBase* pConfig)
{
    return wxConfigBase::Set(pConfig);
}

extern "C" WXEXPORT
wxConfigBase* wxConfigBase_Get(bool createOnDemand)
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
void wxConfigBase_SetPath(wxConfigBase* self, char* strPath)
{
    self->SetPath(wxString(strPath, wxConvUTF8));
}

extern "C" WXEXPORT
wxString* wxConfigBase_GetPath(wxConfigBase* self)
{
    return new wxString(self->GetPath());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_GetFirstGroup(wxConfigBase* self, wxString* str, int *lIndex)
{
    return self->GetFirstGroup(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_GetNextGroup(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextGroup(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_GetFirstEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetFirstEntry(*str, *((long*)lIndex))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_GetNextEntry(wxConfigBase* self, wxString* str, int* lIndex)
{
    return self->GetNextEntry(*str, *((long*)lIndex))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfEntries(wxConfigBase* self, bool bRecursive)
{
    return self->GetNumberOfEntries(bRecursive);
}

extern "C" WXEXPORT
int wxConfigBase_GetNumberOfGroups(wxConfigBase* self, bool bRecursive)
{
    return self->GetNumberOfGroups(bRecursive);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_HasGroup(wxConfigBase* self, char* strName)
{
    return self->HasGroup(wxString(strName, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_HasEntry(wxConfigBase* self, char* strName)
{
    return self->HasEntry(wxString(strName, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_Exists(wxConfigBase* self, char* strName)
{
    return self->Exists(wxString(strName, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxConfigBase_GetEntryType(wxConfigBase* self, char* name)
{
    return self->GetEntryType(wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_ReadStr(wxConfigBase* self, char* key, wxString* pStr)
{
    return self->Read(wxString(key, wxConvUTF8), pStr)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_ReadStrDef(wxConfigBase* self, char* key, wxString* pStr, char* defVal)
{
    return self->Read(wxString(key, wxConvUTF8), pStr, wxString(defVal, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_ReadInt(wxConfigBase* self, char* key, int* pl)
{
    return self->Read(wxString(key, wxConvUTF8), pl)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_ReadIntDef(wxConfigBase* self, char* key, int* pl, int defVal)
{
    return self->Read(wxString(key, wxConvUTF8), pl, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_ReadDbl(wxConfigBase* self, char* key, double* val)
{
    return self->Read(wxString(key, wxConvUTF8), val)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_ReadDblDef(wxConfigBase* self, char* key, double* val, double defVal)
{
    return self->Read(wxString(key, wxConvUTF8), val, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_ReadBool(wxConfigBase* self, char* key, bool* val)
{
    return self->Read(wxString(key, wxConvUTF8), val)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_ReadBoolDef(wxConfigBase* self, char* key, bool* val, bool defVal)
{
    return self->Read(wxString(key, wxConvUTF8), val, defVal)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxConfigBase_ReadStrRet(wxConfigBase* self, char* key, char* defVal)
{
    return new wxString(self->Read(wxString(key, wxConvUTF8), wxString(defVal, wxConvUTF8)));
}

extern "C" WXEXPORT
int wxConfigBase_ReadIntRet(wxConfigBase* self, char* key, int defVal)
{
    return self->Read(wxString(key, wxConvUTF8), defVal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_WriteStr(wxConfigBase* self, char* key, char* value)
{
    return self->Write(wxString(key, wxConvUTF8), wxString(value, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_WriteInt(wxConfigBase* self, char* key, int value)
{
    return self->Write(wxString(key, wxConvUTF8), value)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_WriteDbl(wxConfigBase* self, char* key, double value)
{
    return self->Write(wxString(key, wxConvUTF8), value)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_WriteBool(wxConfigBase* self, char* key, bool value)
{
    return self->Write(wxString(key, wxConvUTF8), value)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_Flush(wxConfigBase* self, bool bCurrentOnly)
{
    return self->Flush(bCurrentOnly)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_RenameEntry(wxConfigBase* self, char* oldName, char* newName)
{
    return self->RenameEntry(wxString(oldName, wxConvUTF8), wxString(newName, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_RenameGroup(wxConfigBase* self, char* oldName, char* newName)
{
    return self->RenameGroup(wxString(oldName, wxConvUTF8), wxString(newName, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_DeleteEntry(wxConfigBase* self, char* key, bool bDeleteGroupIfEmpty)
{
    return self->DeleteEntry(wxString(key, wxConvUTF8), bDeleteGroupIfEmpty)?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_DeleteGroup(wxConfigBase* self, char* key)
{
    return self->DeleteGroup(wxString(key, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
bool wxConfigBase_DeleteAll(wxConfigBase* self)
{
    return self->DeleteAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxConfigBase_IsExpandingEnvVars(wxConfigBase* self)
{
    return self->IsExpandingEnvVars()?1:0;
}

extern "C" WXEXPORT
void wxConfigBase_SetExpandEnvVars(wxConfigBase* self, bool bDoIt)
{
    self->SetExpandEnvVars(bDoIt);
}

extern "C" WXEXPORT
wxString* wxConfigBase_ExpandEnvVars(wxConfigBase* self, char* str)
{
    return new wxString(self->ExpandEnvVars(wxString(str, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxConfigBase_SetRecordDefaults(wxConfigBase* self, bool bDoIt)
{
    self->SetRecordDefaults(bDoIt);
}

extern "C" WXEXPORT
bool wxConfigBase_IsRecordingDefaults(wxConfigBase* self)
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
void wxConfigBase_SetAppName(wxConfigBase* self, char* appName)
{
    self->SetAppName(wxString(appName, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxConfigBase_GetVendorName(wxConfigBase* self)
{
    return new wxString(self->GetVendorName());
}

extern "C" WXEXPORT
void wxConfigBase_SetVendorName(wxConfigBase* self, char* vendorName)
{
    self->SetVendorName(wxString(vendorName, wxConvUTF8));
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

