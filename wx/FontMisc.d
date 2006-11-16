//-----------------------------------------------------------------------------
// wx.NET - FontMapper.cs
//
// The wxFontMapper wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class FontMapper : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxFontMapper_ctor();
		[DllImport("wx-c")] static extern void   wxFontMapper_dtor(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxFontMapper_Get();
		[DllImport("wx-c")] static extern IntPtr wxFontMapper_Set(IntPtr mapper);
		[DllImport("wx-c")] static extern int    wxFontMapper_GetSupportedEncodingsCount();
		[DllImport("wx-c")] static extern int    wxFontMapper_GetEncoding(int n);
		[DllImport("wx-c")] static extern IntPtr wxFontMapper_GetEncodingName(int encoding);
		[DllImport("wx-c")] static extern IntPtr wxFontMapper_GetEncodingDescription(int encoding);
		[DllImport("wx-c")] static extern int    wxFontMapper_GetEncodingFromName(string name);
		
		[DllImport("wx-c")] static extern int    wxFontMapper_CharsetToEncoding(IntPtr self, string charset, bool interactive);
		[DllImport("wx-c")] static extern bool   wxFontMapper_IsEncodingAvailable(IntPtr self, int encoding, string facename);
		[DllImport("wx-c")] static extern bool   wxFontMapper_GetAltForEncoding(IntPtr self, int encoding, out int alt_encoding, string facename, bool interactive);
		
		[DllImport("wx-c")] static extern void   wxFontMapper_SetDialogParent(IntPtr self, IntPtr parent);
		[DllImport("wx-c")] static extern void   wxFontMapper_SetDialogTitle(IntPtr self, string title);
		
		//---------------------------------------------------------------------
		
		private static FontMapper staticFontMapper = new FontMapper(wxFontMapper_Get());
		
		//---------------------------------------------------------------------
		
		public FontMapper(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
			
		internal FontMapper(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public FontMapper()
			: this(wxFontMapper_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxFontMapper_dtor(wxObject);
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
		
		~FontMapper() 
		{
			Dispose();
		}
			
		//---------------------------------------------------------------------
		
		public static FontMapper Get
		{
			get { return staticFontMapper; }
		}
		
		//---------------------------------------------------------------------
		
		public static FontMapper Set(FontMapper mapper)
		{
			return new FontMapper(wxFontMapper_Set(Object.SafePtr(mapper)));
		}
		
		//---------------------------------------------------------------------
		
		public static int SupportedEncodingsCount
		{
			get { return wxFontMapper_GetSupportedEncodingsCount(); }
		}
		
		//---------------------------------------------------------------------
		
		public static FontEncoding GetEncoding(int n)
		{
			return (FontEncoding)wxFontMapper_GetEncoding(n);
		}
		
		//---------------------------------------------------------------------
		
		public static string GetEncodingName(FontEncoding encoding)
		{
			return new wxString(wxFontMapper_GetEncodingName((int)encoding), true);
		}
		
		//---------------------------------------------------------------------
		
		public static FontEncoding GetEncodingFromName(string name)
		{
			return (FontEncoding)wxFontMapper_GetEncodingFromName(name);
		}
		
		//---------------------------------------------------------------------
		
		public FontEncoding CharsetToEncoding(string charset)
		{
			return (FontEncoding)CharsetToEncoding(charset, true);
		}
		
		public FontEncoding CharsetToEncoding(string charset, bool interactive)
		{
			return (FontEncoding)wxFontMapper_CharsetToEncoding(wxObject, charset, interactive);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsEncodingAvailable(FontEncoding encoding)
		{
			return IsEncodingAvailable(encoding, "");
		}
		
		public bool IsEncodingAvailable(FontEncoding encoding, string facename)
		{
			return wxFontMapper_IsEncodingAvailable(wxObject, (int)encoding, facename);
		}
		
		//---------------------------------------------------------------------
		
		public bool GetAltForEncoding(FontEncoding encoding, out FontEncoding alt_encoding)
		{
			return GetAltForEncoding(encoding, out alt_encoding, "", true);
		}
		
		public bool GetAltForEncoding(FontEncoding encoding, out FontEncoding alt_encoding, string facename)
		{
			return GetAltForEncoding(encoding, out alt_encoding, facename, true);
		}
		
		public bool GetAltForEncoding(FontEncoding encoding, out FontEncoding alt_encoding, string facename, bool interactive)
		{
			int alt_tmp;
			bool result = wxFontMapper_GetAltForEncoding(wxObject, (int)encoding, out alt_tmp, facename, interactive);
			alt_encoding = (FontEncoding)alt_tmp;
			return result;
		}
		
		//---------------------------------------------------------------------
		
		public static string GetEncodingDescription(FontEncoding encoding)
		{
			return new wxString(wxFontMapper_GetEncodingDescription((int)encoding), true);
		}
		
		//---------------------------------------------------------------------
		
		public void SetDialogParent(Window parent)
		{
			wxFontMapper_SetDialogParent(wxObject, Object.SafePtr(parent));
		}
		
		//---------------------------------------------------------------------
		
		public void SetDialogTitle(string title)
		{
			wxFontMapper_SetDialogTitle(wxObject, title);
		}
	}
	
	//---------------------------------------------------------------------
	
	public class EncodingConverter : Object
	{
		enum CONVERT
		{
			 wxCONVERT_STRICT,
			 wxCONVERT_SUBSTITUTE
		}
		
		[DllImport("wx-c")] static extern IntPtr wxEncodingConverter_ctor();
		[DllImport("wx-c")] static extern bool wxEncodingConverter_Init(IntPtr self, int input_enc, int output_enc, int method);
		[DllImport("wx-c")] static extern IntPtr wxEncodingConverter_Convert(IntPtr self, string input);
		
		//---------------------------------------------------------------------
		
		public EncodingConverter(IntPtr wxObject)
			: base(wxObject) {}
			
		public EncodingConverter()
			: base(wxEncodingConverter_ctor()) {}
			
		//---------------------------------------------------------------------
		
		public bool Init(FontEncoding input_enc, FontEncoding output_enc)
		{
			return Init(input_enc, output_enc, (int)CONVERT.wxCONVERT_STRICT);
		}
		
		public bool Init(FontEncoding input_enc, FontEncoding output_enc, int method)
		{
			return wxEncodingConverter_Init(wxObject, (int)input_enc, (int)output_enc, method);
		}
		
		//---------------------------------------------------------------------
		
		public string Convert(string input)
		{
			return new wxString(wxEncodingConverter_Convert(wxObject, input), true);
		}
	}
	
	//---------------------------------------------------------------------
	
	public class FontEnumerator : Object
	{
		private delegate bool Virtual_EnumerateFacenames(int encoding, bool fixedWidthOnly);
		private delegate bool Virtual_EnumerateEncodings(IntPtr facename);
		private delegate bool Virtual_OnFacename(IntPtr facename);
		private delegate bool Virtual_OnFontEncoding(IntPtr facename, IntPtr encoding);

		private Virtual_EnumerateFacenames virtual_EnumerateFacenames;
		private Virtual_EnumerateEncodings virtual_EnumerateEncodings;
		private Virtual_OnFacename virtual_OnFacename;
		private Virtual_OnFontEncoding virtual_OnFontEncoding;
		
		[DllImport("wx-c")] static extern IntPtr wxFontEnumerator_ctor();
		[DllImport("wx-c")] static extern void wxFontEnumerator_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxFontEnumerator_RegisterVirtual(IntPtr self, Virtual_EnumerateFacenames enumerateFacenames, Virtual_EnumerateEncodings enumerateEncodings, Virtual_OnFacename onFacename, Virtual_OnFontEncoding onFontEncoding);
		[DllImport("wx-c")] static extern IntPtr wxFontEnumerator_GetFacenames(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFontEnumerator_GetEncodings(IntPtr self);
		[DllImport("wx-c")] static extern bool wxFontEnumerator_OnFacename(IntPtr self, string facename);
		[DllImport("wx.c")] static extern bool wxFontEnumerator_OnFontEncoding(IntPtr self, string facename, string encoding);
		[DllImport("wx-c")] static extern bool wxFontEnumerator_EnumerateFacenames(IntPtr self, int encoding, bool fixedWidthOnly);
		[DllImport("wx-c")] static extern bool wxFontEnumerator_EnumerateEncodings(IntPtr self, string facename);
		
		//---------------------------------------------------------------------
		
		public FontEnumerator()
			: this(wxFontEnumerator_ctor(), true) 
		{
			virtual_EnumerateFacenames = new Virtual_EnumerateFacenames(DoEnumerateFacenames);
			virtual_EnumerateEncodings = new Virtual_EnumerateEncodings(DoEnumerateEncodings);
			virtual_OnFacename = new Virtual_OnFacename(DoOnFacename);
			virtual_OnFontEncoding = new Virtual_OnFontEncoding(DoOnFontEncoding);

			wxFontEnumerator_RegisterVirtual(wxObject,
				virtual_EnumerateFacenames,
				virtual_EnumerateEncodings,
				virtual_OnFacename,
				virtual_OnFontEncoding);			
		}
		
		public FontEnumerator(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal FontEnumerator(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
		
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxFontEnumerator_dtor(wxObject);
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
		
		~FontEnumerator() 
		{
			Dispose();
		}
			
		//---------------------------------------------------------------------
		
		public string[] Facenames
		{
			get { return new ArrayString(wxFontEnumerator_GetFacenames(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
		
		public string[] Encodings
		{
			get { return new ArrayString(wxFontEnumerator_GetEncodings(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool OnFacename(string facename)
		{
			return wxFontEnumerator_OnFacename(wxObject, facename);
		}
		
		private bool DoOnFacename(IntPtr facename)
		{
			return OnFacename(new wxString(facename));
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool OnFontEncoding(string facename, string encoding)
		{
			return wxFontEnumerator_OnFontEncoding(wxObject, facename, encoding);
		}
		
		private bool DoOnFontEncoding(IntPtr facename, IntPtr encoding)
		{
			return OnFontEncoding(new wxString(facename), new wxString(encoding));
		}
		
		//---------------------------------------------------------------------
		
		/*public virtual bool EnumerateFacenames()
		{
			return EnumerateFacenames((int)FontEncoding.wxFONTENCODING_SYSTEM, false);
		}
		
		public virtual bool EnumerateFacenames(FontEncoding encoding)
		{
			return EnumerateFacenames((int)encoding, false);
		}*/
		
		public virtual bool EnumerateFacenames(FontEncoding encoding, bool fixedWidthOnly)
		{
			return wxFontEnumerator_EnumerateFacenames(wxObject, (int)encoding, fixedWidthOnly);
		}
		
		private bool DoEnumerateFacenames(int encoding, bool fixedWidthOnly)
		{
			return EnumerateFacenames((FontEncoding)encoding, fixedWidthOnly);
		}
		
		//---------------------------------------------------------------------
		
		/*public virtual bool EnumerateEncodings()
		{
			return EnumerateEncodings(IntPtr.Zero);
		}*/
		
		public virtual bool EnumerateEncodings(string facename)
		{
			return wxFontEnumerator_EnumerateEncodings(wxObject, facename);
		}
		
		private bool DoEnumerateEncodings(IntPtr facename)
		{
			return EnumerateEncodings(new wxString(facename));
		}
	}
}
