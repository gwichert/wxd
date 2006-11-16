
//-----------------------------------------------------------------------------
// wxD - treectrl.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - treectrl.cxx
//
// The wxTreeCtrl proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/treectrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// wxTreeCtrl

typedef int (CALLBACK* Virtual_OnCompareItems) (dobj, wxTreeItemId*, wxTreeItemId*);

class _TreeCtrl : public wxTreeCtrl
{
public:
	_TreeCtrl()
		: wxTreeCtrl() {}
		
	void RegisterVirtual(dobj obj, Virtual_OnCompareItems onCompareItems)
	{
		m_dobj = obj;
		m_OnCompareItems = onCompareItems;
	}
	
	virtual int OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2)
	{ 
		return m_OnCompareItems(m_dobj, new wxTreeItemId(item1), new wxTreeItemId(item2)); 
	}

public:
    void* my_cookie;
    
private:
	Virtual_OnCompareItems m_OnCompareItems;
	dobj m_dobj;

public:
    DECLARE_OBJECTDELETED(_TreeCtrl)

#include "control.inc"
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeCtrl* wxTreeCtrl_ctor()
{
    return new _TreeCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_RegisterVirtual(_TreeCtrl* self, dobj obj, Virtual_OnCompareItems onCompareItems)
{
	self->RegisterVirtual(obj, onCompareItems);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTreeCtrl_OnCompareItems(_TreeCtrl* self, wxTreeItemId* item1, wxTreeItemId* item2)
{
	return self->wxTreeCtrl::OnCompareItems(*item1, *item2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SortChildren(wxTreeCtrl* self, wxTreeItemId* item)
{
	self->SortChildren(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_AddRoot(wxTreeCtrl* self, dstr text, int image, int selImage, wxTreeItemData* data)
{
    return new wxTreeItemId(self->AddRoot(wxString(text.data, wxConvUTF8, text.length), image, selImage, data));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_AppendItem(wxTreeCtrl* self, wxTreeItemId* parent, dstr text, int image, int selImage, wxTreeItemData* data)
{
    return new wxTreeItemId(self->AppendItem(*parent, wxString(text.data, wxConvUTF8, text.length), image, selImage, data));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_AssignImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->AssignImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_AssignStateImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->AssignStateImageList(imageList);
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
void wxTreeCtrl_AssignButtonsImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->AssignButtonsImageList(imageList);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_Create(wxTreeCtrl* self, wxWindow* parent, int id, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("treectrl",sizeof("treectrl")-1);

    if (val == NULL)
        val = &wxDefaultValidator;

    return self->Create(parent, id, *pos, *size, style, *val, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTreeCtrl_GetDefaultStyle()
{
    // This value depends on the current platform. Rather than expose the
    // platform dependencies in wx.NET, I'll just hide it in here.

    return wxTR_DEFAULT_STYLE;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned int wxTreeCtrl_GetIndent(wxTreeCtrl* self)
{
	return self->GetIndent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetIndent(wxTreeCtrl* self, unsigned int indent)
{
	self->SetIndent(indent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned int wxTreeCtrl_GetSpacing(wxTreeCtrl* self)
{
	return self->GetSpacing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetSpacing(wxTreeCtrl* self, unsigned int indent)
{
	self->SetSpacing(indent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxTreeCtrl_GetStateImageList(wxTreeCtrl* self)
{
    return self->GetStateImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetStateImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->SetStateImageList(imageList);
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxImageList* wxTreeCtrl_GetButtonsImageList(wxTreeCtrl* self)
{
    return self->GetButtonsImageList();
}*/

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
void wxTreeCtrl_SetButtonsImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->SetButtonsImageList(imageList);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxTreeCtrl_GetImageList(wxTreeCtrl* self)
{
    return self->GetImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetImageList(wxTreeCtrl* self, wxImageList* imageList)
{
    self->SetImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemImage(wxTreeCtrl* self, wxTreeItemId* item, int image, wxTreeItemIcon which)
{
    self->SetItemImage(*item, image, which);
}
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTreeCtrl_GetItemImage(wxTreeCtrl* self, wxTreeItemId* item, wxTreeItemIcon which)
{
    return self->GetItemImage(*item, which);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_DeleteAllItems(wxTreeCtrl* self)
{
    self->DeleteAllItems();
}

extern "C" WXEXPORT
void wxTreeCtrl_DeleteChildren(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->DeleteChildren(*item);
}

extern "C" WXEXPORT
void wxTreeCtrl_Delete(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->Delete(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_Unselect(wxTreeCtrl* self)
{
    self->Unselect();
}

extern "C" WXEXPORT
void wxTreeCtrl_UnselectAll(wxTreeCtrl* self)
{
    self->UnselectAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SelectItem(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->SelectItem(*item);
}

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetSelection(wxTreeCtrl* self)
{
    return new wxTreeItemId(self->GetSelection());
}

extern "C" WXEXPORT
bool wxTreeCtrl_IsSelected(wxTreeCtrl* self, wxTreeItemId* item)
{
    return self->IsSelected(*item)?1:0;
}

extern "C" WXEXPORT
wxArrayTreeItemIds* wxTreeCtrl_GetSelections(wxTreeCtrl* self)
{
	wxArrayTreeItemIds *array = new wxArrayTreeItemIds();
	self->GetSelections(*array);
	return array;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemText(wxTreeCtrl* self, wxTreeItemId* item, dstr text)
{
    self->SetItemText(*item, wxString(text.data, wxConvUTF8, text.length));
}

extern "C" WXEXPORT
dstr wxTreeCtrl_GetItemText(wxTreeCtrl* self, wxTreeItemId* item)
{
    return dstr(self->GetItemText(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemData(wxTreeCtrl* self, wxTreeItemId* item, wxTreeItemData* data)
{
    self->SetItemData(*item, data);
}

extern "C" WXEXPORT
wxTreeItemData* wxTreeCtrl_GetItemData(wxTreeCtrl* self, wxTreeItemId* item)
{
    return self->GetItemData(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemHasChildren(wxTreeCtrl* self, wxTreeItemId* item, bool has)
{
	self->SetItemHasChildren(*item, has);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_HitTest(wxTreeCtrl* self, wxPoint* pt, int* flags)
{
    return new wxTreeItemId(self->HitTest(*pt, *flags));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetItemParent(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetItemParent(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void* wxTreeCtrl_GetMyCookie(_TreeCtrl* self)
{
	return self->my_cookie;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetMyCookie(_TreeCtrl* self, void* newval)
{
	self->my_cookie = newval;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetFirstChild(_TreeCtrl* self, wxTreeItemId* item)
{
	self->my_cookie = 0;
	return new wxTreeItemId(self->GetFirstChild(*item, self->my_cookie));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetNextChild(_TreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetNextChild(*item, self->my_cookie));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetLastChild(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetLastChild(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetNextSibling(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetNextSibling(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetPrevSibling(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetPrevSibling(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetFirstVisibleItem(wxTreeCtrl* self)
{
    return new wxTreeItemId(self->GetFirstVisibleItem());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetNextVisible(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetNextVisible(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetPrevVisible(wxTreeCtrl* self, wxTreeItemId* item)
{
    return new wxTreeItemId(self->GetPrevVisible(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_PrependItem(wxTreeCtrl* self, wxTreeItemId* parent, dstr text, int image, int selectedImage, wxTreeItemData* data)
{
    return new wxTreeItemId(self->PrependItem(*parent, wxString(text.data, wxConvUTF8, text.length), image, selectedImage, data));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_InsertItem(wxTreeCtrl* self, wxTreeItemId* parent, wxTreeItemId* idPrevious, dstr text, int image, int selectedImage, wxTreeItemData* data)
{
    return new wxTreeItemId(self->InsertItem(*parent, *idPrevious, wxString(text.data, wxConvUTF8, text.length), image, selectedImage, data));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_InsertItem2(wxTreeCtrl* self, wxTreeItemId* parent, size_t before, dstr text, int image, int selectedImage, wxTreeItemData* data)
{
    return new wxTreeItemId(self->InsertItem(*parent, before, wxString(text.data, wxConvUTF8, text.length), image, selectedImage, data));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_Expand(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->Expand(*item);
}

extern "C" WXEXPORT
void wxTreeCtrl_Collapse(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->Collapse(*item);
}

extern "C" WXEXPORT
void wxTreeCtrl_CollapseAndReset(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->CollapseAndReset(*item);
}

extern "C" WXEXPORT
void wxTreeCtrl_Toggle(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->Toggle(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_EnsureVisible(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->EnsureVisible(*item);
}

extern "C" WXEXPORT
void wxTreeCtrl_ScrollTo(wxTreeCtrl* self, wxTreeItemId* item)
{
    self->ScrollTo(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTreeCtrl_GetChildrenCount(wxTreeCtrl* self, wxTreeItemId* item, bool recursively)
{
    return self->GetChildrenCount(*item, recursively);
}

extern "C" WXEXPORT
int wxTreeCtrl_GetCount(wxTreeCtrl* self)
{
    return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_IsVisible(wxTreeCtrl* self, wxTreeItemId* item)
{
    return self->IsVisible(*item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_ItemHasChildren(wxTreeCtrl* self, wxTreeItemId* item)
{
    return self->ItemHasChildren(*item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_IsExpanded(wxTreeCtrl* self, wxTreeItemId* item)
{
    return self->IsExpanded(*item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeCtrl_GetRootItem(wxTreeCtrl* self)
{
    return new wxTreeItemId(self->GetRootItem());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTreeCtrl_GetItemTextColour(wxTreeCtrl* self, wxTreeItemId* item)
{
	return new wxColour(self->GetItemTextColour(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTreeCtrl_GetItemBackgroundColour(wxTreeCtrl* self, wxTreeItemId* item)
{
	return new wxColour(self->GetItemBackgroundColour(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxTreeCtrl_GetItemFont(wxTreeCtrl* self, wxTreeItemId* item)
{
	return new wxFont(self->GetItemFont(*item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemBold(wxTreeCtrl* self, wxTreeItemId* item, bool bold)
{
	self->SetItemBold(*item, bold);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemTextColour(wxTreeCtrl* self, wxTreeItemId* item, wxColour* col)
{
	self->SetItemTextColour(*item, *col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemBackgroundColour(wxTreeCtrl* self, wxTreeItemId* item, wxColour* col)
{
	self->SetItemBackgroundColour(*item, *col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemFont(wxTreeCtrl* self, wxTreeItemId* item, wxFont* font)
{
	self->SetItemFont(*item, *font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_EditLabel(wxTreeCtrl* self, wxTreeItemId* item)
{
	self->EditLabel(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_GetBoundingRect(wxTreeCtrl* self, wxTreeItemId* item, wxRect* rect, bool textOnly)
{
	return self->GetBoundingRect(*item, *rect, textOnly);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeCtrl_IsBold(wxTreeCtrl* self, wxTreeItemId* item)
{
	return self->IsBold(*item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_SetItemSelectedImage(wxTreeCtrl* self, wxTreeItemId* item, int selImage)
{
	self->SetItemSelectedImage(*item, selImage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_ToggleItemSelection(wxTreeCtrl* self, wxTreeItemId* item)
{
	self->ToggleItemSelection(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeCtrl_UnselectItem(wxTreeCtrl* self, wxTreeItemId* item)
{
	self->UnselectItem(*item);
}

//-----------------------------------------------------------------------------
// wxTreeItemId

class _TreeItemId : public wxTreeItemId
{
public:
	_TreeItemId()
		: wxTreeItemId() {}
		
	_TreeItemId(void* pItem)
		: wxTreeItemId(pItem) {}

	DECLARE_DISPOSABLE(_TreeItemId)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeItemId_ctor()
{
	return new _TreeItemId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeItemId_ctor2(void* pItem)
{
	return new _TreeItemId(pItem);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemId_dtor(wxTreeItemId* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemId_RegisterDisposable(_TreeItemId* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeItemId_Equal(wxTreeItemId* item1, wxTreeItemId* item2)
{
	return (item1 == item2)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeItemId_IsOk(wxTreeItemId* self)
{
	return self->IsOk()?1:0;
}

//-----------------------------------------------------------------------------
// wxTreeEvent

extern "C" WXEXPORT
wxTreeEvent* wxTreeEvent_ctor(wxEventType commandType, int id)
{
    return new wxTreeEvent(commandType, id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeEvent_GetItem(wxTreeEvent* self)
{
	return new wxTreeItemId(self->GetItem());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetItem(wxTreeEvent* self, wxTreeItemId* item)
{
    self->SetItem(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemId* wxTreeEvent_GetOldItem(wxTreeEvent* self)
{
    return new wxTreeItemId(self->GetOldItem());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetOldItem(wxTreeEvent* self, wxTreeItemId* item)
{
    self->SetOldItem(*item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_GetPoint(wxTreeEvent* self, wxPoint* pt)
{
    *pt = self->GetPoint();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetPoint(wxTreeEvent* self, wxPoint* pt)
{
    self->SetPoint(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxKeyEvent* wxTreeEvent_GetKeyEvent(wxTreeEvent* self)
{
    return &(self->GetKeyEvent());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTreeEvent_GetKeyCode(wxTreeEvent* self)
{
    return self->GetKeyCode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetKeyEvent(wxTreeEvent* self, wxKeyEvent* evt)
{
    self->SetKeyEvent(*evt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxTreeEvent_GetLabel(wxTreeEvent* self)
{
    return dstr(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetLabel(wxTreeEvent* self, dstr label)
{
    self->SetLabel(wxString(label.data, wxConvUTF8, label.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeEvent_IsEditCancelled(wxTreeEvent* self)
{
    return self->IsEditCancelled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetEditCanceled(wxTreeEvent* self, bool editCancelled)
{
    self->SetEditCanceled(editCancelled);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void  wxTreeEvent_Veto( wxTreeEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void  wxTreeEvent_Allow( wxTreeEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
bool  wxTreeEvent_IsAllowed( wxTreeEvent* self)
{
    return self->IsAllowed()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeEvent_SetToolTip(wxTreeEvent* self, dstr toolTip)
{
	self->SetToolTip(wxString(toolTip.data, wxConvUTF8, toolTip.length));
}

//-----------------------------------------------------------------------------
// wxTreeItemData

class _TreeItemData : public wxTreeItemData
{
public:
	_TreeItemData()
		: wxTreeItemData() {}

	DECLARE_DISPOSABLE(_TreeItemData)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemData* wxTreeItemData_ctor()
{
    return new _TreeItemData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemData_dtor(wxTreeItemData* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemData_RegisterDisposable(_TreeItemData* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxTreeItemId* wxTreeItemData_GetId(wxTreeItemData* self)
{
	return new wxTreeItemId(self->GetId());
}

extern "C" WXEXPORT
void wxTreeItemData_SetId(wxTreeItemData* self, wxTreeItemId* param)
{
    self->SetId(*param);
}

//-----------------------------------------------------------------------------
// wxTreeItemAttr

class _TreeItemAttr : public wxTreeItemAttr
{
public:
	_TreeItemAttr()
		: wxTreeItemAttr() {}
		
	_TreeItemAttr(const wxColour& colText, const wxColour& colBack, const wxFont& font)
		: wxTreeItemAttr(colText, colBack, font) {}

	DECLARE_DISPOSABLE(_TreeItemAttr)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemAttr* wxTreeItemAttr_ctor()
{
	return new _TreeItemAttr();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTreeItemAttr* wxTreeItemAttr_ctor2(wxColour* colText, wxColour* colBack, wxFont* font)
{
	return new _TreeItemAttr(*colText, *colBack, *font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemAttr_dtor(wxTreeItemAttr* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemAttr_RegisterDisposable(_TreeItemAttr* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemAttr_SetTextColour(wxTreeItemAttr* self, wxColour* colText)
{
	self->SetTextColour(*colText);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemAttr_SetBackgroundColour(wxTreeItemAttr* self, wxColour* colBack)
{
	self->SetBackgroundColour(*colBack);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTreeItemAttr_SetFont(wxTreeItemAttr* self, wxFont* font)
{
	self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeItemAttr_HasTextColour(wxTreeItemAttr* self)
{
	return self->HasTextColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeItemAttr_HasBackgroundColour(wxTreeItemAttr* self)
{
	return self->HasBackgroundColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTreeItemAttr_HasFont(wxTreeItemAttr* self)
{
	return self->HasFont()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTreeItemAttr_GetTextColour(wxTreeItemAttr* self)
{
	return new wxColour(self->GetTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxTreeItemAttr_GetBackgroundColour(wxTreeItemAttr* self)
{
	return new wxColour(self->GetBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxTreeItemAttr_GetFont(wxTreeItemAttr* self)
{
	return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------
// wxArrayTreeItemIds

class _ArrayTreeItemIds : public wxArrayTreeItemIds
{
public:
	_ArrayTreeItemIds()
		: wxArrayTreeItemIds() {}
		
	DECLARE_DISPOSABLE(_ArrayTreeItemIds)
};

extern "C" WXEXPORT
wxArrayTreeItemIds* wxArrayTreeItemIds_ctor()
{
	return new _ArrayTreeItemIds();
}

extern "C" WXEXPORT
void wxArrayTreeItemIds_dtor(wxArrayTreeItemIds* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxArrayTreeItemIds_RegisterDisposable(_ArrayTreeItemIds* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxArrayTreeItemIds_Add(wxArrayTreeItemIds* self, wxTreeItemId* toadd)
{
	self->Add(toadd);
}

extern "C" WXEXPORT
wxTreeItemId* wxArrayTreeItemIds_Item(wxArrayTreeItemIds* self, size_t num)
{
	return new wxTreeItemId(self->Item(num));
}

extern "C" WXEXPORT
int wxArrayTreeItemIds_GetCount(wxArrayTreeItemIds* self)
{
	return self->GetCount();
}

