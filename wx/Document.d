//-----------------------------------------------------------------------------
// wx.NET - Document.cs
//
// The wxDocument wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// 
// $Id$
//-----------------------------------------------------------------------------

#if NOT_READY_YET

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class Document : EvtHandler
    {
        [DllImport("wx-c")] static extern IntPtr wxDocument_ctor(IntPtr parent);
        [DllImport("wx-c")] static extern void   wxDocument_SetFilename(IntPtr self, string filename, bool notifyViews);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetFilename(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_SetTitle(IntPtr self, string title);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetTitle(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_SetDocumentName(IntPtr self, string name);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetDocumentName(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_GetDocumentSaved(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_SetDocumentSaved(IntPtr self, bool saved);
        [DllImport("wx-c")] static extern bool   wxDocument_Close(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_Save(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_SaveAs(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_Revert(IntPtr self);
        //[DllImport("wx-c")] static extern IntPtr wxDocument_SaveObject(IntPtr self, IntPtr stream);
        //[DllImport("wx-c")] static extern IntPtr wxDocument_LoadObject(IntPtr self, IntPtr stream);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetCommandProcessor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_SetCommandProcessor(IntPtr self, IntPtr proc);
        [DllImport("wx-c")] static extern bool   wxDocument_DeleteContents(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_Draw(IntPtr self, IntPtr wxDC);
        [DllImport("wx-c")] static extern bool   wxDocument_IsModified(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_Modify(IntPtr self, bool mod);
        [DllImport("wx-c")] static extern bool   wxDocument_AddView(IntPtr self, IntPtr view);
        [DllImport("wx-c")] static extern bool   wxDocument_RemoveView(IntPtr self, IntPtr view);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetViews(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetFirstView(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_UpdateAllViews(IntPtr self, IntPtr sender, IntPtr hint);
        [DllImport("wx-c")] static extern void   wxDocument_NotifyClosing(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxDocument_DeleteAllViews(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetDocumentManager(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetDocumentTemplate(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDocument_SetDocumentTemplate(IntPtr self, IntPtr temp);
        [DllImport("wx-c")] static extern bool   wxDocument_GetPrintableName(IntPtr self, IntPtr buf);
        [DllImport("wx-c")] static extern IntPtr wxDocument_GetDocumentWindow(IntPtr self);

        //-----------------------------------------------------------------------------

        public  Document(Document parent)
            : base(wxDocument_ctor(Object.SafePtr(parent))) { }

        //-----------------------------------------------------------------------------

        public void SetFilename(string filename, bool notifyViews)
        {
            wxDocument_SetFilename(wxObject, filename, notifyViews);
        }

        public string Filename
        {
            set { SetFilename(value, true); }
            get { return new wxString(wxDocument_GetFilename(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public string Title
        {
            set { wxDocument_SetTitle(wxObject, value); }
            get { return new wxString(wxDocument_GetTitle(wxObject), true); }
        }

        public string DocumentName
        {
            set { wxDocument_SetDocumentName(wxObject, value); }
            get { return new wxString(wxDocument_GetDocumentName(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public bool DocumentSaved
        {
            get { return wxDocument_GetDocumentSaved(wxObject); }
            set { wxDocument_SetDocumentSaved(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Close()
        {
            return wxDocument_Close(wxObject);
        }

        public bool Save()
        {
            return wxDocument_Save(wxObject);
        }

        public bool SaveAs()
        {
            return wxDocument_SaveAs(wxObject);
        }

        public bool Revert()
        {
            return wxDocument_Revert(wxObject);
        }

        //-----------------------------------------------------------------------------

        /*
        public OutputStream SaveObject(OutputStream stream)
        {
            return wxDocument_SaveObject(wxObject, Object.SafePtr(stream));
        }

        public InputStream LoadObject(InputStream stream)
        {
            return wxDocument_LoadObject(wxObject, Object.SafePtr(stream));
        }*/

        //-----------------------------------------------------------------------------

        /*public CommandProcessor CommandProcessor
        {
            get { return FindObject(wxDocument_GetCommandProcessor(wxObject)); }
            set { wxDocument_SetCommandProcessor(wxObject, Object.SafePtr(value)); }
        }*/

        //-----------------------------------------------------------------------------

        public bool DeleteContents()
        {
            return wxDocument_DeleteContents(wxObject);
        }

        //-----------------------------------------------------------------------------

        public bool Draw(DC dc)
        {
            return wxDocument_Draw(wxObject, Object.SafePtr(dc));
        }

        //-----------------------------------------------------------------------------

        public bool IsModified
        {
            get { return wxDocument_IsModified(wxObject); }
            set { Modify(value); }
        }

        public void Modify(bool mod)
        {
            wxDocument_Modify(wxObject, mod);
        }

        //-----------------------------------------------------------------------------

        /*public bool AddView(View view)
        {
            return wxDocument_AddView(wxObject, Object.SafePtr(view));
        }

        public bool RemoveView(View view)
        {
            return wxDocument_RemoveView(wxObject, Object.SafePtr(view));
        }*/

        /*
        public List GetViews()
        {
            return wxDocument_GetViews(wxObject);
        }

        public View FirstView
        {
            get { return wxDocument_GetFirstView(wxObject); }
        }

        public void UpdateAllViews(View sender, Object hint)
        {
            wxDocument_UpdateAllViews(wxObject, Object.SafePtr(sender), Object.SafePtr(hint));
        }*/

        //-----------------------------------------------------------------------------

        public void NotifyClosing()
        {
            wxDocument_NotifyClosing(wxObject);
        }

        //-----------------------------------------------------------------------------

        public bool DeleteAllViews()
        {
            return wxDocument_DeleteAllViews(wxObject);
        }

        //-----------------------------------------------------------------------------

        /*public DocManager DocumentManager
        {
            get { return (DocManager)FindObject(wxDocument_GetDocumentManager(wxObject), DocManager); }
        }

        //-----------------------------------------------------------------------------

        public DocTemplate DocumentTemplate
        {
            get { return (DocTemplate)FindObject(return wxDocument_GetDocumentTemplate(wxObject), DocTemplate);
            set { wxDocument_SetDocumentTemplate(wxObject, Object.SafePtr(value)); }
        }*/

        //-----------------------------------------------------------------------------

        public bool GetPrintableName(out string buf)
        {
            wxString name = "";
            bool ret = wxDocument_GetPrintableName(wxObject, Object.SafePtr(name));
            buf = name;

            return ret;
        }

        //-----------------------------------------------------------------------------

        public Window DocumentWindow
        {
            get { return (Window)FindObject(wxDocument_GetDocumentWindow(wxObject)); }
        }
    }
}

#endif
