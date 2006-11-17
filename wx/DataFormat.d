//-----------------------------------------------------------------------------
// wxD - DataFormat.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - DataFormat.cs
// 
/// The wxDataFormat wrapper class
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.DataFormat;
import wx.common;

    public enum DataFormatId
    {
        wxDF_INVALID =          0,
        wxDF_TEXT =             1,
        wxDF_BITMAP =           2,
        wxDF_METAFILE =         3,
        wxDF_SYLK =             4,
        wxDF_DIF =              5,
        wxDF_TIFF =             6,
        wxDF_OEMTEXT =          7,
        wxDF_DIB =              8,
        wxDF_PALETTE =          9,
        wxDF_PENDATA =          10,
        wxDF_RIFF =             11,
        wxDF_WAVE =             12,
        wxDF_UNICODETEXT =      13,
        wxDF_ENHMETAFILE =      14,
        wxDF_FILENAME =         15,
        wxDF_LOCALE =           16,
        wxDF_PRIVATE =          20,
        wxDF_HTML =             30,
        wxDF_MAX
    }
 
		//! \cond EXTERN
        static extern (C) IntPtr wxDataFormat_ctor();
	static extern (C) void   wxDataFormat_dtor(IntPtr self);
        static extern (C) IntPtr wxDataFormat_ctorByType(int type);
        static extern (C) IntPtr wxDataFormat_ctorById(string id);

        static extern (C) string wxDataFormat_GetId(IntPtr self);
        static extern (C) void   wxDataFormat_SetId(IntPtr self, string id);

        static extern (C) int    wxDataFormat_GetType(IntPtr self);
        static extern (C) void   wxDataFormat_SetType(IntPtr self, int type);
		//! \endcond
	
        //-----------------------------------------------------------------------------
	
    alias DataFormat wxDataFormat;
    public class DataFormat : wxObject
    {
	public this(IntPtr wxobj)
	{ 
		super(wxobj);
	}
			
	private this(IntPtr wxobj, bool memOwn)
	{ 
		super(wxobj);
		this.memOwn = memOwn;
	}

        public  this()
            { this(wxDataFormat_ctor(), true); }

        public this(DataFormatId type)
            { this(wxDataFormat_ctorByType(cast(int)type), true); }

        public this(string id)
            { this(wxDataFormat_ctorById(id), true); }
	    
	//---------------------------------------------------------------------
	
	override private void dtor() { wxDataFormat_dtor(wxobj); }

        //-----------------------------------------------------------------------------

        public string Id() { return wxDataFormat_GetId(wxobj); }
        public void Id(string value) { wxDataFormat_SetId(wxobj, value); }

        //-----------------------------------------------------------------------------

        public DataFormatId Type() { return cast(DataFormatId)wxDataFormat_GetType(wxobj); }
        public void Type(DataFormatId value) { wxDataFormat_SetType(wxobj, cast(int)value); }
    }

