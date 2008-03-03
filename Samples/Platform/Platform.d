version (Tango)
{
import tango.io.Console;

char[] FORMAT(char[] str, ...) { return "Tango"; }
void PRINT(char[] str) { Cout(str).newline; }
}
else // Phobos
{
private import std.stdio;
private import std.string;

alias format FORMAT;
alias writefln PRINT;
}

import wx.wx;

public class MyFrame : wxFrame
{
	public this(string title)
	{
		super(title, wxDefaultPosition, wxDefaultSize);

		int p, major, minor;
		string platform;
		
		p = wxGetOsVersion(major, minor);
		if (p == OS_WINDOWS_9X || p == OS_WINDOWS_NT)
			platform = "Windows";
		else if (p == OS_MAC_OS || p == OS_DARWIN)
			platform = "Macintosh";
		else if (p == OS_LINUX)
			platform = "GNU/Linux";
		else if (p == OS_FREEBSD)
			platform = "FreeBSD";
		else
			platform = "???";

		CreateStatusBar();
		SetStatusText(FORMAT("%s-%0x%s%0x", platform, major,".",minor));

		wxStaticText text = new wxStaticText(this, wxGetOsDescription()
			~ " " ~ (UNICODE ? "Unicode" : (ANSI ? "ANSI" : "Unknown")),
			wxDefaultPosition, wxDefaultSize, Alignment.wxALIGN_CENTRE);
  	}
}

class MyApp : wxApp
{
	public override bool OnInit()
	{
       MyFrame frame = new MyFrame("wxPlatform");
       frame.Show(true);
       return true;
	}
}

int main()
{
	version(__WXMSW__)
		PRINT("__WXMSW__");
	version(__WXGTK__)
		PRINT("__WXGTK__");
	version(__WXMAC__)
		PRINT("__WXMAC__");
	version(__WXX11__)
		PRINT("__WXX11__");

	MyApp app = new MyApp();
	app.Run();
	return 0;
}
