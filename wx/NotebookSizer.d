//-----------------------------------------------------------------------------
// wx.NET - NotebookSizer.cs
//
// The wxNotebookSizer proxy interface.
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
	public class NotebookSizer : Sizer
	{
		[DllImport("wx-c")] static extern IntPtr wxNotebookSizer_ctor(IntPtr nb);
		[DllImport("wx-c")] static extern void wxNotebookSizer_RecalcSizes(IntPtr self);
		[DllImport("wx-c")] static extern void wxNotebookSizer_CalcMin(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern IntPtr wxNotebookSizer_GetNotebook(IntPtr self);

		//---------------------------------------------------------------------

		public NotebookSizer(IntPtr wxObject)
			: base(wxObject)
		{
		}

		public NotebookSizer(Notebook nb)
			: base(wxNotebookSizer_ctor(Object.SafePtr(nb)))
		{
		}

		//---------------------------------------------------------------------

		public override void RecalcSizes()
		{
			wxNotebookSizer_RecalcSizes(wxObject);
		}

		//---------------------------------------------------------------------

		public override Size CalcMin()
		{
			Size size = new Size();
			wxNotebookSizer_CalcMin(wxObject, ref size);
			return size;
		}

		//---------------------------------------------------------------------

		public Notebook Notebook
		{
			get
			{
				return (Notebook)FindObject(
                                    wxNotebookSizer_GetNotebook(wxObject)
                                );
			}
		}

		//---------------------------------------------------------------------
	}
}
