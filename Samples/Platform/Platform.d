import std.stdio;
import std.string;

import wx.wx;

public class MyFrame : wxFrame
{
	public this(string title)
	{
		super(title, wxDefaultPosition, wxDefaultSize);

		int p, major, minor;
		char[] platform;
		
		p = wxGetOsVersion(major, minor);
		if (p == wxWIN95 || p == wxWINDOWS_NT)
			platform = "Win";
		else if (p == wxGTK || p == wxGTK_WIN32)
			platform = "GTK";
		else if (p == wxMAC || p == wxMAC_DARWIN)
			platform = "Mac";
		else
			platform = "???";

		CreateStatusBar();
		SetStatusText(format("%s-%0x%s%0x", platform, major,".",minor));

		wxStaticText text = new wxStaticText(this, wxGetOsDescription(),
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
		writefln("__WXMSW__");
	version(__WXGTK__)
		writefln("__WXGTK__");
	version(__WXMAC__)
		writefln("__WXMAC__");

	MyApp app = new MyApp();
	app.Run();
	return 0;
}
