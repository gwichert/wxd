//-----------------------------------------------------------------------------
// wx.NET - Config.cs
//
// The wxConfig wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public enum EntryType 
    {
        Unknown,
        String,
        Boolean,
        Integer,
        Float
    }
    
    // Style flags for constructor style parameter
    public enum ConfigStyleFlags
    {
    	wxCONFIG_USE_LOCAL_FILE = 1,
    	wxCONFIG_USE_GLOBAL_FILE = 2,
    	wxCONFIG_USE_RELATIVE_PATH = 4,
    	wxCONFIG_USE_NO_ESCAPE_CHARACTERS = 8
    }


    // although it wxConfig is not derived from wxObject we do not change it.
    // Use Config.Get() to get an instance.
    public class Config : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_Set(IntPtr pConfig);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_Get(bool createOnDemand);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_Create();
        [DllImport("wx-c")] static extern void   wxConfigBase_DontCreateOnDemand();
        [DllImport("wx-c")] static extern void   wxConfigBase_SetPath(IntPtr self, string strPath);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_GetPath(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxConfigBase_GetFirstGroup(IntPtr self, IntPtr str, ref int lIndex);
        [DllImport("wx-c")] static extern bool   wxConfigBase_GetNextGroup(IntPtr self, IntPtr str, ref int lIndex);
        [DllImport("wx-c")] static extern bool   wxConfigBase_GetFirstEntry(IntPtr self, IntPtr str, ref int lIndex);
        [DllImport("wx-c")] static extern bool   wxConfigBase_GetNextEntry(IntPtr self, IntPtr str, ref int lIndex);
        [DllImport("wx-c")] static extern int    wxConfigBase_GetNumberOfEntries(IntPtr self, bool bRecursive);
        [DllImport("wx-c")] static extern int    wxConfigBase_GetNumberOfGroups(IntPtr self, bool bRecursive);
        [DllImport("wx-c")] static extern bool   wxConfigBase_HasGroup(IntPtr self, string strName);
        [DllImport("wx-c")] static extern bool   wxConfigBase_HasEntry(IntPtr self, string strName);
        [DllImport("wx-c")] static extern bool   wxConfigBase_Exists(IntPtr self, string strName);
        [DllImport("wx-c")] static extern int    wxConfigBase_GetEntryType(IntPtr self, string name);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadStr(IntPtr self, string key, IntPtr pStr);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadStrDef(IntPtr self, string key, IntPtr pStr, string defVal);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadInt(IntPtr self, string key, ref int pl);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadIntDef(IntPtr self, string key, ref int pl, int defVal);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadDbl(IntPtr self, string key, ref double val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadDblDef(IntPtr self, string key, ref double val, double defVal);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadBool(IntPtr self, string key, ref bool val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_ReadBoolDef(IntPtr self, string key, ref bool val, bool defVal);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_ReadStrRet(IntPtr self, string key, string defVal);
        [DllImport("wx-c")] static extern int    wxConfigBase_ReadIntRet(IntPtr self, string key, int defVal);
        [DllImport("wx-c")] static extern bool   wxConfigBase_WriteStr(IntPtr self, string key, string val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_WriteInt(IntPtr self, string key, int val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_WriteDbl(IntPtr self, string key, double val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_WriteBool(IntPtr self, string key, bool val);
        [DllImport("wx-c")] static extern bool   wxConfigBase_Flush(IntPtr self, bool bCurrentOnly);
        [DllImport("wx-c")] static extern bool   wxConfigBase_RenameEntry(IntPtr self, string oldName, string newName);
        [DllImport("wx-c")] static extern bool   wxConfigBase_RenameGroup(IntPtr self, string oldName, string newName);
        [DllImport("wx-c")] static extern bool   wxConfigBase_DeleteEntry(IntPtr self, string key, bool bDeleteGroupIfEmpty);
        [DllImport("wx-c")] static extern bool   wxConfigBase_DeleteGroup(IntPtr self, string key);
        [DllImport("wx-c")] static extern bool   wxConfigBase_DeleteAll(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxConfigBase_IsExpandingEnvVars(IntPtr self);
        [DllImport("wx-c")] static extern void   wxConfigBase_SetExpandEnvVars(IntPtr self, bool bDoIt);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_ExpandEnvVars(IntPtr self, string str);
        [DllImport("wx-c")] static extern void   wxConfigBase_SetRecordDefaults(IntPtr self, bool bDoIt);
        [DllImport("wx-c")] static extern bool   wxConfigBase_IsRecordingDefaults(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_GetAppName(IntPtr self);
        [DllImport("wx-c")] static extern void   wxConfigBase_SetAppName(IntPtr self, string appName);
        [DllImport("wx-c")] static extern IntPtr wxConfigBase_GetVendorName(IntPtr self);
        [DllImport("wx-c")] static extern void   wxConfigBase_SetVendorName(IntPtr self, string vendorName);
        [DllImport("wx-c")] static extern void   wxConfigBase_SetStyle(IntPtr self, int style);
        [DllImport("wx-c")] static extern int    wxConfigBase_GetStyle(IntPtr self);

		//---------------------------------------------------------------------

        public Config(IntPtr wxObject)
            : base(wxObject) { }
	    
        public static Config Set(Config config)
        {
            return (Config)FindObject(wxConfigBase_Set(Object.SafePtr(config)), typeof(Config));
        }

        public static Config Get(bool createOnDemand)
        {
            return (Config)FindObject(wxConfigBase_Get(createOnDemand), typeof(Config));
        }
	
	public static Config Get()
        {
            return (Config)FindObject(wxConfigBase_Get(true), typeof(Config));
        }

        public static Config Create()
        {
            return new Config(wxConfigBase_Create());
        }

		//---------------------------------------------------------------------

        public void DontCreateOnDemand()
        {
            wxConfigBase_DontCreateOnDemand();
        }

		//---------------------------------------------------------------------

        public string Path
        {
            set { wxConfigBase_SetPath(wxObject, value); }
            get { return new wxString(wxConfigBase_GetPath(wxObject), true); }
        }

		//---------------------------------------------------------------------

        public bool GetFirstGroup(ref string str, ref int lIndex)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_GetFirstGroup(wxObject, wxString.SafePtr(wstr), ref lIndex);
            str = wstr;

            return ret;
        }

        public bool GetNextGroup(ref string str, ref int lIndex)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_GetNextGroup(wxObject, wxString.SafePtr(wstr), ref lIndex);
            str = wstr;

            return ret;
        }

		//---------------------------------------------------------------------

        public bool GetFirstEntry(ref string str, ref int lIndex)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_GetFirstEntry(wxObject, wxString.SafePtr(wstr), ref lIndex);
            str = wstr;

            return ret;
        }

        public bool GetNextEntry(ref string str, ref int lIndex)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_GetNextEntry(wxObject, wxString.SafePtr(wstr), ref lIndex);
            str = wstr;

            return ret;
        }

		//---------------------------------------------------------------------

        public int GetNumberOfEntries(bool bRecursive)
        {
            return wxConfigBase_GetNumberOfEntries(wxObject, bRecursive);
        }

        public int GetNumberOfGroups(bool bRecursive)
        {
            return wxConfigBase_GetNumberOfGroups(wxObject, bRecursive);
        }

		//---------------------------------------------------------------------

        public bool HasGroup(string strName)
        {
            return wxConfigBase_HasGroup(wxObject, strName);
        }

        public bool HasEntry(string strName)
        {
            return wxConfigBase_HasEntry(wxObject, strName);
        }

		//---------------------------------------------------------------------

        public bool Exists(string strName)
        {
            return wxConfigBase_Exists(wxObject, strName);
        }

        public EntryType GetEntryType(string name)
        {
            return (EntryType)wxConfigBase_GetEntryType(wxObject, name);
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref string str)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_ReadStr(wxObject, key, wxString.SafePtr(wstr));
            str = wstr;

            return ret;
        }

        public bool Read(string key, ref string str, string defVal)
        {
            bool ret;
            wxString wstr = new wxString(str);

            ret = wxConfigBase_ReadStrDef(wxObject, key, wxString.SafePtr(wstr), defVal);
            str = wstr;

            return ret;
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref int pl)
        {
            return wxConfigBase_ReadInt(wxObject, key, ref pl);
        }

        public bool Read(string key, ref int pl, int defVal)
        {
            return wxConfigBase_ReadIntDef(wxObject, key, ref pl, defVal);
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref double val)
        {
            return wxConfigBase_ReadDbl(wxObject, key, ref val);
        }

        public bool Read(string key, ref double val, double defVal)
        {
            return wxConfigBase_ReadDblDef(wxObject, key, ref val, defVal);
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref bool val)
        {
            return wxConfigBase_ReadBool(wxObject, key, ref val);
        }

        public bool Read(string key, ref bool val, bool defVal)
        {
            return wxConfigBase_ReadBoolDef(wxObject, key, ref val, defVal);
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref Font val)
        {
            return Read(key, ref val, Font.wxNORMAL_FONT);
        }

        public bool Read(string key, ref Font val, Font defVal)
        {
            bool ret = true;

            int pointSize = 0, family = 0, style = 0, weight = 0, encoding = 0;
            bool underline = false;
            string faceName = "";

            ret &= Read(key + "/PointSize", ref pointSize,  (int)defVal.PointSize);
            ret &= Read(key + "/Family",    ref family,     (int)defVal.Family);
            ret &= Read(key + "/Style",     ref style,      (int)defVal.Style);
            ret &= Read(key + "/Weight",    ref weight,     (int)defVal.Weight);
            ret &= Read(key + "/Underline", ref underline,  (bool)defVal.Underlined);
            ret &= Read(key + "/FaceName",  ref faceName,   defVal.FaceName);
            ret &= Read(key + "/Encoding",  ref encoding,   (int)defVal.Encoding);

            val.PointSize   = pointSize;
            val.Family      = (FontFamily)family;
            val.Style       = (FontStyle)style;
            val.Weight      = (FontWeight)weight;
            val.Underlined  = underline;
            val.FaceName    = faceName;
            val.Encoding    = (FontEncoding)encoding;

            return ret;
        }

		//---------------------------------------------------------------------

        public bool Read(string key, ref Colour val)
        {
            Colour def = new Colour(0, 0, 0);
            return Read(key, ref val, def);
        }

        public bool Read(string key, ref Colour val, Colour defVal)
        {
            bool ret = true;
            int r = 0, b = 0, g = 0;

            ret &= Read(key + "/Red",   ref r, defVal.Red);
            ret &= Read(key + "/Blue",  ref b, defVal.Blue);
            ret &= Read(key + "/Green", ref g, defVal.Green);

            val = new Colour((byte)r, (byte)g, (byte)b);

            return ret;
        }

		//---------------------------------------------------------------------

        public string Read(string key, string defVal)
        {
            return new wxString(wxConfigBase_ReadStrRet(wxObject, key, defVal), true);
        }

        public int Read(string key, int defVal)
        {
            return wxConfigBase_ReadIntRet(wxObject, key, defVal);
        }

        public bool Read(string key, bool defVal) {
            bool val = false;
            Read(key, ref val, defVal);
            return val;
        }

        public Colour Read(string key, Colour defVal)
        {
            Colour col = new Colour();
            Read(key, ref col, defVal);
            return col;
        }

        public Font Read(string key, Font defVal)
        {
            Font fnt = new Font();
            Read(key, ref fnt, defVal);
            return fnt;
        }

		//---------------------------------------------------------------------

        public bool Write(string key, string val)
        {
            return wxConfigBase_WriteStr(wxObject, key, val);
        }

        public bool Write(string key, int val)
        {
            return wxConfigBase_WriteInt(wxObject, key, val);
        }

        public bool Write(string key, double val)
        {
            return wxConfigBase_WriteDbl(wxObject, key, val);
        }

        public bool Write(string key, bool val)
        {
            return wxConfigBase_WriteBool(wxObject, key, val);
        }

        public bool Write(string key, Colour col)
        {
            bool ret = true;

            ret &= Write(key + "/Red",   col.Red);
            ret &= Write(key + "/Blue",  col.Blue);
            ret &= Write(key + "/Green", col.Green);

            return ret;
        }

        public bool Write(string key, Font val)
        {
            bool ret = true;

            ret &= Write(key + "/PointSize", (int)val.PointSize);
            ret &= Write(key + "/Family",    (int)val.Family);
            ret &= Write(key + "/Style",     (int)val.Style);
            ret &= Write(key + "/Weight",    (int)val.Weight);
            ret &= Write(key + "/Underline", (bool)val.Underlined);
            ret &= Write(key + "/FaceName",  val.FaceName);
            ret &= Write(key + "/Encoding",  (int)val.Encoding);

            return ret;
        }

		//---------------------------------------------------------------------

        public bool Flush(bool bCurrentOnly)
        {
            return wxConfigBase_Flush(wxObject, bCurrentOnly);
        }

		//---------------------------------------------------------------------

        public bool RenameEntry(string oldName, string newName)
        {
            return wxConfigBase_RenameEntry(wxObject, oldName, newName);
        }

        public bool RenameGroup(string oldName, string newName)
        {
            return wxConfigBase_RenameGroup(wxObject, oldName, newName);
        }

		//---------------------------------------------------------------------

        public bool DeleteEntry(string key, bool bDeleteGroupIfEmpty)
        {
            return wxConfigBase_DeleteEntry(wxObject, key, bDeleteGroupIfEmpty);
        }

        public bool DeleteGroup(string key)
        {
            return wxConfigBase_DeleteGroup(wxObject, key);
        }

        public bool DeleteAll()
        {
            return wxConfigBase_DeleteAll(wxObject);
        }

		//---------------------------------------------------------------------

        public bool ExpandEnvVars
        {
            get { return wxConfigBase_IsExpandingEnvVars(wxObject); }
            set { wxConfigBase_SetExpandEnvVars(wxObject, value); }
        }

        /*public string ExpandEnvVars(string str)
        {
            return new wxString(wxConfigBase_ExpandEnvVars(wxObject, str));
        }*/

		//---------------------------------------------------------------------

        public bool RecordDefaults
        {
            set { wxConfigBase_SetRecordDefaults(wxObject, value); }
            get { return wxConfigBase_IsRecordingDefaults(wxObject); }
        }

		//---------------------------------------------------------------------

        public string AppName
        {
            get { return new wxString(wxConfigBase_GetAppName(wxObject), true); }
            set { wxConfigBase_SetAppName(wxObject, value); }
        }

		//---------------------------------------------------------------------

        public string VendorName
        {
            get { return new wxString(wxConfigBase_GetVendorName(wxObject), true); }
            set { wxConfigBase_SetVendorName(wxObject, value); }
        }

		//---------------------------------------------------------------------

        public int Style
        {
            set { wxConfigBase_SetStyle(wxObject, value); }
            get { return wxConfigBase_GetStyle(wxObject); }
        }

		//---------------------------------------------------------------------
    }
}

