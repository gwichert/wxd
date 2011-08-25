//-----------------------------------------------------------------------------
// wxD - Validator.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Validator.cs
//
/// The wxValidator wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Validator;
public import wx.common;
public import wx.EvtHandler;

		//! \cond EXTERN
		static extern (C) IntPtr wxValidator_ctor();
		static extern (C) IntPtr wxDefaultValidator_Get();
		//! \endcond
		
		//---------------------------------------------------------------------
		
	alias Validator wxValidator;
	public class Validator : EvtHandler
	{
		private static Validator DefaultValidator;
		
		static Validator wxDefaultValidator()
		{
			if (!DefaultValidator)
				DefaultValidator = new Validator(wxDefaultValidator_Get());
			return DefaultValidator;
		}
	
		public this()
			{ super(wxValidator_ctor());}

		public this(IntPtr wxobj) 
			{ super(wxobj);}

		//---------------------------------------------------------------------
	}
