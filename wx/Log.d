//-----------------------------------------------------------------------------
// wx.NET - Log.cs
//
// The Log wrapper classes.
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
	public class Log: Object
	{
		enum eLogLevel : int
		{
			xLOGMESSAGE,
			xFATALERROR,
			xERROR,
			xWARNING,
			xINFO,
			xVERBOSE,
			xSTATUS,
			xSYSERROR
		}
		
		[DllImport("wx-c")] static extern IntPtr wxLog_ctor();
		[DllImport("wx-c")] static extern bool wxLog_IsEnabled();
		[DllImport("wx-c")] static extern void wxLog_FlushActive();
		[DllImport("wx-c")] static extern IntPtr wxLog_SetActiveTargetTextCtrl(IntPtr pLogger);
		[DllImport("wx-c")] static extern void wxLog_Log_Function(int what, string szFormat);
		[DllImport("wx-c")] static extern void wxLog_AddTraceMask(string tmask);
		
		public Log(IntPtr wxObject)
		    : base(wxObject) {}

		public Log()
		    : base(wxLog_ctor()) {}


		public static bool IsEnabled
		{
			get { return wxLog_IsEnabled(); }
		}

		public static void FlushActive()
		{
			wxLog_FlushActive();
		}

		// at the moment only TextCtrl
		public static void SetActiveTarget(TextCtrl pLogger)
		{
			wxLog_SetActiveTargetTextCtrl(Object.SafePtr(pLogger));
		}

		public static void AddTraceMask(string tmask)
		{
			wxLog_AddTraceMask(tmask);
		}

		public static void LogMessage(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xLOGMESSAGE, string.Format(message, param));
		}

		public static void LogFatalError(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xFATALERROR, string.Format(message, param));
		}

		public static void LogError(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xERROR, string.Format(message, param));
		}

		public static void LogWarning(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xWARNING, string.Format(message, param));
		}

		public static void LogInfo(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xINFO, string.Format(message, param));
		}

		public static void LogVerbose(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xVERBOSE, string.Format(message, param));
		}

		public static void LogStatus(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xSTATUS, string.Format(message, param));
		}

		public static void LogSysError(string message, params object[] param)
		{
			wxLog_Log_Function((int)eLogLevel.xSYSERROR, string.Format(message, param));
		}
	}
}
