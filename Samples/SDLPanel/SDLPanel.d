//-----------------------------------------------------------------------------
// wxD/Samples - SDL.d
//
// A wxD version of the wx/SDL tutorial.
// http://code.technoplaza.net/wx-sdl/
//
// wx-sdl tutorial v1.0
// Copyright (C) 2005 John David Ratliff
//
// wx-sdl is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// wx-sdl is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with wx-sdl; if not, write to the Free Software Foundation, Inc.,
// 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//
// $Id$
//-----------------------------------------------------------------------------

private import std.stdio;
private import std.string;

import wx.wx;

import wx.MemoryDC;
import wx.Image;

import sdl.sdl;

/*******************************************************************************
// Global Declarations
*******************************************************************************/

enum {
    ID_FRAME = 10000,
    ID_PANEL,
    IDM_FILE_EXIT,
    IDM_HELP_ABOUT = MenuIDs.wxID_ABOUT
}

/*******************************************************************************
// SDLPanel Class
*******************************************************************************/

public class SDLPanel : wxPanel
{
private:
    SDL_Surface *screen;

    /**
     * Called to paint the panel.
     *
     * @param event The triggering wxPaintEvent (unused).
     */
    void onPaint(Object sender, Event event)
    {
     // can't draw if the screen doesn't exist yet
    if (screen == null) {
        return;
    }
    
    // lock the surface if necessary
    if (SDL_MUSTLOCK(screen)) {
        if (SDL_LockSurface(screen) < 0) {
            return;
        }
    }
    
    // create a bitmap from our pixel data
    wxBitmap bmp = new wxBitmap(new Image(screen.w, screen.h, 
                    cast(ubyte *)(screen.pixels), true));
    
    // unlock the screen
    if (SDL_MUSTLOCK(screen)) {
        SDL_UnlockSurface(screen);
    }
    
    // paint the screen
    auto wxBufferedPaintDC dc = new wxBufferedPaintDC(this, bmp);
	}
    
    /**
     * Called to erase the background.
     *
     * @param event The triggering wxEraseEvent (unused).
     */
    void onEraseBackground(Object sender, Event event) {}
    
    /**
     * Called to update the panel.
     *
     * @param event The triggering wxIdleEvent (unused).
     */
    void onIdle(Object sender, Event event)
    {
    // create the SDL_Surface
    createScreen();
    
    // Lock surface if needed
    if (SDL_MUSTLOCK(screen)) {
        if (SDL_LockSurface(screen) < 0) {
            return;
        }
    }
    
    // Ask SDL for the time in milliseconds
    int tick = SDL_GetTicks();
    
    for (int y = 0; y < 480; y++) {
        for (int x = 0; x < 640; x++) {
            uint color = (y * y) + (x * x) + tick;
            ubyte *pixels = cast(ubyte *)(screen.pixels) + 
                              (y * screen.pitch) +
                              (x * screen.format.BytesPerPixel);

            version (BigEndian)
            {
                pixels[0] = color & 0xFF;
                pixels[1] = (color >> 8) & 0xFF;
                pixels[2] = (color >> 16) & 0xFF;
            }
            else
            {
                pixels[0] = (color >> 16) & 0xFF;
                pixels[1] = (color >> 8) & 0xFF;
                pixels[2] = color & 0xFF;
            }
        }
    }
    
    // Unlock if needed
    if (SDL_MUSTLOCK(screen)) {
        SDL_UnlockSurface(screen);
    }
    
    // refresh the panel
    Refresh(false);
    
    // throttle to keep from flooding the event queue
    wxMilliSleep(33);
    }
    
    /**
     * Creates the SDL_Surface used by this SDLPanel.
     */
    void createScreen()
    {
    if (screen == null) {
        Size size = size();
        
        screen = SDL_CreateRGBSurface(SDL_SWSURFACE, size.Width, size.Height, 
                                      24, 0, 0, 0, 0);     
    }
    }
   
public:
    /**
     * Creates a new SDLPanel.
     *
     * @param parent The wxWindow parent.
     */
    this(wxWindow parent)
    {
    super(parent, ID_PANEL);
    screen = null;
    
    // ensure the size of the wxPanel
    wxSize size = wxSize(640, 480);
    
    MinSize = size;
    MaxSize = size;

    EVT_PAINT(&onPaint);
    EVT_ERASE_BACKGROUND(&onEraseBackground);
    EVT_IDLE(&onIdle);
	}
    
    /**
     * Destructs this SDLPanel.
     */
    ~this()
    {
    if (screen != null) {
        SDL_FreeSurface(screen);
    }
 	}
}

/*******************************************************************************
// SDLFrame Class
*******************************************************************************/

public class SDLFrame : wxFrame
{
private:
    SDLPanel panel;
    
    /**
     * Called when exit from the file menu is selected.
     *
     * @param event The associated wxCommandEvent (unused).
     */
    void onFileExit(Object sender, Event event) { Close(); }
    
    /**
     * Called when about from the help menu is selected.
     *
     * @param event The associated wxCommandEvent (unused).
     */
    void onHelpAbout(Object sender, Event event)
    {
    MessageBox("wx-sdl tutorial\nCopyright (C) 2005 John Ratliff",
                 "about wx-sdl tutorial", Dialog.wxOK | Dialog.wxICON_INFORMATION);
    }
    
public:
    /**
     * Creates a new SDLFrame.
     */
//    this(Point pos=wxDefaultPosition, Size size=wxDefaultSize)
    this()
    {
    Point pos=wxDefaultPosition;
    Size size=wxDefaultSize;
 
         // Create the SDLFrame
    Create(null, ID_FRAME, "Frame Title", pos,
           size, wxCAPTION | wxSYSTEM_MENU | 
           wxMINIMIZE_BOX | wxCLOSE_BOX, "");

    // create the main menubar
    wxMenuBar mb = new wxMenuBar;
    
    // create the file menu
    wxMenu fileMenu = new wxMenu;
    fileMenu.Append(IDM_FILE_EXIT, "E&xit");
    
    // add the file menu to the menu bar
    mb.Append(fileMenu, "&File");
    
    // create the help menu
    wxMenu helpMenu = new wxMenu;
    helpMenu.Append(IDM_HELP_ABOUT, "About");
    
    // add the help menu to the menu bar
    mb.Append(helpMenu, "&Help");
    
    // add the menu bar to the SDLFrame
    this.menuBar = mb;
    
    // create the SDLPanel
    panel = new SDLPanel(this);

    EVT_MENU(IDM_FILE_EXIT, &onFileExit);
    EVT_MENU(IDM_HELP_ABOUT, &onHelpAbout);
    }
    
    /**
     * Gets the SDLPanel within this SDLFrame.
     *
     * @return The SDLPanel.
     */
    SDLPanel getPanel() { return panel; }
}

/*******************************************************************************
// SDLApp Class
*******************************************************************************/

public class SDLApp : wxApp
{
private:
    SDLFrame frame;
    
public:
    /**
     * Called to initialize this SDLApp.
     *
     * @return true if initialization succeeded; false otherwise.
     */
    public override bool OnInit()
    {
     // create the SDLFrame
    frame = new SDLFrame;
    frame.ClientSize = Size(640, 480);
    frame.Centre();
    frame.Show();
    
    // initialization should always succeed
    return true;
    }
   
    /**
     * Called to run this SDLApp.
     *
     * @return The status code (0 if good, non-0 if bad).
     */
    public override int OnRun()
    {
        // initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        fwritefln(stderr, "unable to init SDL: ", std.string.toString(SDL_GetError()));
        
        return -1;
    }
    
version (__WXMAC__) {} else {
    // Setup video mode, but don't create a window
    SDL_SetVideoMode(0, 0, 0, SDL_SWSURFACE);
}
    
    // generate an initial idle event to start things
    wxIdleEvent event = new wxIdleEvent;
    event.EventObject = frame.getPanel();
    frame.getPanel().AddPendingEvent(event);
 
    // start the main loop
    return super.OnRun();
    }
    
    /**
     * Called when this SDLApp is ready to exit.
     *
     * @return The exit code.
     */
    public override int OnExit()
    {
    // cleanup SDL
    SDL_Quit();
    
    // return the standard exit code
    return super.OnExit();
	}

	static void Main(char[][] args)
	{
		SDLApp app = new SDLApp();
		app.Run(args);
	}

}

int main(char[][] args)
{
	SDLApp.Main(args);
	return 0;
}
