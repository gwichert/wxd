//-----------------------------------------------------------------------------
// wx.NET - DataFormat.cs
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
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
 
    public class DataFormat : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxDataFormat_ctor();
	[DllImport("wx-c")] static extern void   wxDataFormat_dtor(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxDataFormat_ctorByType(int type);
        [DllImport("wx-c")] static extern IntPtr wxDataFormat_ctorById(string id);

        [DllImport("wx-c")] static extern string wxDataFormat_GetId(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDataFormat_SetId(IntPtr self, string id);

        [DllImport("wx-c")] static extern int    wxDataFormat_GetType(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDataFormat_SetType(IntPtr self, int type);
	
        //-----------------------------------------------------------------------------
	
	public DataFormat(IntPtr wxObject)
		: base(wxObject)
	{ 
		this.wxObject = wxObject;
	}
			
	internal DataFormat(IntPtr wxObject, bool memOwn)
		: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}

        public  DataFormat()
            : this(wxDataFormat_ctor(), true) { }

        public DataFormat(DataFormatId type)
            : this(wxDataFormat_ctorByType((int)type), true) { }

        public DataFormat(string id)
            : this(wxDataFormat_ctorById(id), true) { }
	    
	//---------------------------------------------------------------------
				
	public override void Dispose()
	{
		if (!disposed)
		{
			if (wxObject != IntPtr.Zero)
			{
				if (memOwn)
				{
					wxDataFormat_dtor(wxObject);
					memOwn = false;
				}
			}
			RemoveObject(wxObject);
			wxObject = IntPtr.Zero;
			disposed= true;
		}
		
		base.Dispose();
		GC.SuppressFinalize(this);
	}
	
	//---------------------------------------------------------------------
	
	~DataFormat() 
	{
		Dispose();
	}

        //-----------------------------------------------------------------------------

        public string Id
        {
            get { return wxDataFormat_GetId(wxObject); }
            set { wxDataFormat_SetId(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public DataFormatId Type
        {
            get { return (DataFormatId)wxDataFormat_GetType(wxObject); }
            set { wxDataFormat_SetType(wxObject, (int)value); }
        }
    }
}

