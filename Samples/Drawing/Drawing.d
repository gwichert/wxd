/////////////////////////////////////////////////////////////////////////////
// Name:        samples/drawing/Drawing.d
// Purpose:     shows and tests DC features
// Author:      Robert Roebling
// Ported by:   Heromyth 2007-6-3
// Created:     04/01/98
// RCS-ID:      $Id$
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

// ============================================================================
// declarations
// ============================================================================

import wx.wx;

import std.math;

typedef int wxCoord;
typedef byte wxDash;

// ----------------------------------------------------------------------------
// ressources
// ----------------------------------------------------------------------------

// the application icon


// ----------------------------------------------------------------------------
// ants
// ----------------------------------------------------------------------------

// what do we show on screen (there are too many shapes to put them all on
// screen simultaneously)
enum ScreenToShow
{
    Show_Default,
    Show_Text,
    Show_Lines,
    Show_Brushes,
    Show_Polygons,
    Show_Mask,
    Show_Ops,
    Show_Regions,
    Show_Circles,
    Show_Splines,
    Show_Alpha,
    Show_Gradient,
    Show_Max
};


/*  Mapping modes (same values as used by Windows, don't change) */
enum MapMode
{
    wxMM_TEXT = 1,
    wxMM_LOMETRIC,
    wxMM_HIMETRIC,
    wxMM_LOENGLISH,
    wxMM_HIENGLISH,
    wxMM_TWIPS,
    wxMM_ISOTROPIC,
    wxMM_ANISOTROPIC,
    wxMM_POINTS,
    wxMM_METRIC
};

// ----------------------------------------------------------------------------
// global variables
// ----------------------------------------------------------------------------

static Bitmap gs_bmpNoMask,
                gs_bmpWithColMask,
                gs_bmpMask,
                gs_bmpWithMask,
                gs_bmp4,
                gs_bmp4_mono,
                gs_bmp36;

// ----------------------------------------------------------------------------
// private classes
// ----------------------------------------------------------------------------

// Define a new application type, each program should derive a class from App
class Drawing : public App
{
public:
    // override base class virtuals
    // ----------------------------

// `Main program' equivalent: the program execution "starts" here
    public override bool OnInit()
    {
        // Create the main application window
        MyFrame frame = new MyFrame("Drawing sample",
                                     Point(50, 50), Size(550, 340));

        // Show it and tell the application that it's our main window
        frame.Show(true);
        TopWindow(frame);

        if ( !LoadImages() )
        {
            Log temp = new Log();
            temp.LogError("Can't load one of the bitmap files needed 
            for this sample from the current or parent 
            directory, please copy them there.");

            // stop here
            DeleteBitmaps();

            return false;
        }

        // ok, continue
        return true;
    }

    public override int OnExit() { DeleteBitmaps(); return 0; }

		//---------------------------------------------------------------------

		static void Main()
		{
			Drawing app = new Drawing();
			app.Run();
		}



    protected void DeleteBitmaps()
    {
        delete gs_bmpNoMask;
        delete gs_bmpWithColMask;
        delete gs_bmpMask;
        delete gs_bmpWithMask;
        delete gs_bmp4;
        delete gs_bmp4_mono;
        delete gs_bmp36;

    }


    protected bool LoadImages()
    {
        gs_bmpNoMask = new Bitmap();
        gs_bmpWithColMask = new Bitmap();
        gs_bmpMask = new Bitmap();
        gs_bmpWithMask = new Bitmap();
        gs_bmp4 = new Bitmap();
        gs_bmp4_mono = new Bitmap();
        gs_bmp36 = new Bitmap();

/*
        wxPathList pathList;
        pathList.Add(("."));
        pathList.Add((".."));
*/

        // string path = pathList.FindValidPath(("pat4.bmp"));
        string path = "pat4.bmp";
        if ( !path )
            return false;

        /* 4 colour bitmap */
        gs_bmp4.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);
        /* turn into mono-bitmap */
        gs_bmp4_mono.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);
        Mask mask4 = new Mask(gs_bmp4_mono, Colour.wxBLACK);
        gs_bmp4_mono.mask(mask4);

        // path = pathList.FindValidPath(("pat36.bmp"));
        path = "pat36.bmp";
        if ( !path )
            return false;
        gs_bmp36.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);
        Mask mask36 = new Mask(gs_bmp36, Colour.wxBLACK);
        gs_bmp36.mask(mask36);

        // path = pathList.FindValidPath(("image.bmp"));
        path = "image.bmp";
        if ( !path )
            return false;
        gs_bmpNoMask.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);
        gs_bmpWithMask.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);
        gs_bmpWithColMask.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);

        // path = pathList.FindValidPath(("mask.bmp"));
        path = "mask.bmp";
        if ( !path )
            return false;
        gs_bmpMask.LoadFile(path, BitmapType.wxBITMAP_TYPE_BMP);

        Mask mask = new Mask(gs_bmpMask, Colour.wxBLACK);
        gs_bmpWithMask.mask(mask);

        mask = new wxMask(gs_bmpWithColMask, Colour.wxWHITE);
        gs_bmpWithColMask.mask(mask);

        return true;
    }

};

// Create a new application object: this macro will allow wxWidgets to create
// the application object during program execution (it's better than using a
// static object for many reasons) and also declares the accessor function
// wxGetApp() which will return the reference of the right type (i.e. Drawing and
// not App)
int main()
{
	Drawing.Main();
	return 0;
}




// Define a new frame type: this is going to be our main frame
class MyFrame : public Frame
{

    // frame ructor
    this( string title,  Point pos,  Size size)
    {
        super(null, wxID_ANY, title, pos, size,
                     wxDEFAULT_FRAME_STYLE | wxNO_FULL_REPAINT_ON_RESIZE);
        // set the frame icon
        icon = new Icon("../Samples/Drawing/mondrian.png");

        Menu menuFile = new Menu();
        menuFile.Append(File_ShowDefault, "&Default screen\tF1");
        menuFile.Append(File_ShowText, "&Text screen\tF2");
        menuFile.Append(File_ShowLines, "&Lines screen\tF3");
        menuFile.Append(File_ShowBrushes, "&Brushes screen\tF4");
        menuFile.Append(File_ShowPolygons, "&Polygons screen\tF5");
        menuFile.Append(File_ShowMask, "&Mask screen\tF6");
        menuFile.Append(File_ShowOps, "&ROP screen\tF7");
        menuFile.Append(File_ShowRegions, "Re&gions screen\tF8");
        menuFile.Append(File_ShowCircles, "&Circles screen\tF9");

//        menuFile.Append(File_ShowAlpha, "&Alpha screen\tF10");

        menuFile.Append(File_ShowSplines, "&Splines screen\tF11");
        menuFile.Append(File_ShowGradients, "&Gradients screen\tF12");
        menuFile.AppendSeparator();
        menuFile.AppendCheckItem(File_Clip, "&Clip\tCtrl-C", "Clip/unclip drawing");

        menuFile.AppendCheckItem(File_GraphicContext, "&Use GraphicContext\tCtrl-Y", "Use GraphicContext");

        menuFile.AppendSeparator();
        menuFile.Append(File_About, "&About...\tCtrl-A", "Show about dialog");
        menuFile.AppendSeparator();
        menuFile.Append(File_Quit, "E&xit\tAlt-X", "Quit this program");

        Menu menuMapMode = new Menu();
        menuMapMode.Append( MapMode_Text, "&TEXT map mode" );
        menuMapMode.Append( MapMode_Lometric, "&LOMETRIC map mode" );
        menuMapMode.Append( MapMode_Twips, "T&WIPS map mode" );
        menuMapMode.Append( MapMode_Points, "&POINTS map mode" );
        menuMapMode.Append( MapMode_Metric, "&METRIC map mode" );

        Menu menuUserScale = new Menu();
        menuUserScale.Append( UserScale_StretchHoriz, "Stretch &horizontally\tCtrl-H" );
        menuUserScale.Append( UserScale_ShrinkHoriz, "Shrin&k horizontally\tCtrl-G" );
        menuUserScale.Append( UserScale_StretchVertic, "Stretch &vertically\tCtrl-V" );
        menuUserScale.Append( UserScale_ShrinkVertic, "&Shrink vertically\tCtrl-W" );
        menuUserScale.AppendSeparator();
        menuUserScale.Append( UserScale_Restore, "&Restore to normal\tCtrl-0" );

        Menu menuAxis = new Menu();
        menuAxis.AppendCheckItem( AxisMirror_Horiz, "Mirror horizontally\tCtrl-M" );
        menuAxis.AppendCheckItem( AxisMirror_Vertic, "Mirror vertically\tCtrl-N" );

        Menu menuLogical = new Menu();
        menuLogical.Append( LogicalOrigin_MoveDown, "Move &down\tCtrl-D" );
        menuLogical.Append( LogicalOrigin_MoveUp, "Move &up\tCtrl-U" );
        menuLogical.Append( LogicalOrigin_MoveLeft, "Move &right\tCtrl-L" );
        menuLogical.Append( LogicalOrigin_MoveRight, "Move &left\tCtrl-R" );
        menuLogical.AppendSeparator();
        menuLogical.Append( LogicalOrigin_Set, ("Set to (&100, 100)\tShift-Ctrl-1") );
        menuLogical.Append( LogicalOrigin_Restore, "&Restore to normal\tShift-Ctrl-0" );

        Menu menuColour = new Menu();

        menuColour.Append( Colour_TextForeground, "Text &foreground..." );
        menuColour.Append( Colour_TextBackground, "Text &background..." );
        menuColour.Append( Colour_Background, "Background &colour..." );

        menuColour.AppendCheckItem( Colour_BackgroundMode, "&Opaque/transparent\tCtrl-B" );
        menuColour.AppendCheckItem( Colour_TextureBackgound, "Draw textured back&ground\tCtrl-T" );

        // now append the freshly created menu to the menu bar...
        MenuBar menuBar = new MenuBar();
        menuBar.Append(menuFile, "&File");
        menuBar.Append(menuMapMode, "&Mode");
        menuBar.Append(menuUserScale, "&Scale");
        menuBar.Append(menuAxis, "&Axis");
        menuBar.Append(menuLogical, "&Origin");
        menuBar.Append(menuColour, "&Colours");

        // ... and attach this menu bar to the frame
        this.menuBar = menuBar;




        CreateStatusBar(2);
        StatusText = "Welcome to wxWidgets!";


        m_mapMode = MapMode.wxMM_TEXT;
        m_xUserScale = 1.0;
        m_yUserScale = 1.0;
        m_xLogicalOrigin = 0;
        m_yLogicalOrigin = 0;
        m_xAxisReversed = false;
        m_yAxisReversed = false;
        m_backgroundMode = FillStyle.wxSOLID;
        m_colourForeground = Colour.wxRED;
        m_colourBackground = Colour.wxBLUE;
        m_textureBackground = false;

         m_canvas = new MyCanvas( this );
        m_canvas.SetScrollbars( 10, 10, 100, 240 );

// the event tables connect the wxWidgets events with the functions (event
// handlers) which process them. It can be also done at run-time, but for the
// simple menu events like this the static method is much simpler.

    EVT_MENU      (File_Quit,     &OnQuit);
    EVT_MENU      (File_About,    &OnAbout);
    EVT_MENU      (File_Clip,     &OnClip);
    EVT_MENU      (File_GraphicContext, &OnGraphicContext);



    EVT_MENU_RANGE(MenuShow_First,   MenuShow_Last,   &OnShow);
    EVT_MENU_RANGE(MenuOption_First, MenuOption_Last, &OnOption);


    }

    // event handlers (these functions should _not_ be virtual)
    void OnQuit(Object sender, Event e)
    {
        // CommandEvent event = cast(CommandEvent) e;
        // true is to force the frame to close
        Close(true);
    }

    void OnAbout(Object sender, Event e)
    {
        // CommandEvent event = cast(CommandEvent) e;
        string msg;
        msg = ("This is the about dialog of the drawing sample.\n
                    This sample tests various primitive drawing functions\n
                    (without any attempts to prevent flicker).\n
                    Copyright (c) Robert Roebling 1999");


        MessageBox(msg, "About Drawing", Dialog.wxOK | Dialog.wxICON_INFORMATION, this);
    }


    void OnClip(Object sender, Event e)
    {
        CommandEvent event = cast(CommandEvent) e;
        m_canvas.Clip(event.IsChecked());
    }


    void OnGraphicContext(Object sender, Event e)
    {
        CommandEvent event = cast(CommandEvent) e;
        m_canvas.UseGraphicContext(event.IsChecked());
    }


    void OnShow(Object sender, Event e)
    {
        CommandEvent event = cast(CommandEvent) e;
        m_canvas.ToShow(cast(ScreenToShow)(event.ID() - MenuShow_First));
    }


    void OnOption(Object sender, Event e)
    {
        CommandEvent event = cast(CommandEvent) e;
        switch (event.ID())
        {
            case MapMode_Text:
                m_mapMode = MapMode.wxMM_TEXT;
                break;
            case MapMode_Lometric:
                m_mapMode = MapMode.wxMM_LOMETRIC;
                break;
            case MapMode_Twips:
                m_mapMode = MapMode.wxMM_TWIPS;
                break;
            case MapMode_Points:
                m_mapMode = MapMode.wxMM_POINTS;
                break;
            case MapMode_Metric:
                m_mapMode = MapMode.wxMM_METRIC;
                break;

            case LogicalOrigin_MoveDown:
                m_yLogicalOrigin += 10;
                break;
            case LogicalOrigin_MoveUp:
                m_yLogicalOrigin -= 10;
                break;
            case LogicalOrigin_MoveLeft:
                m_xLogicalOrigin += 10;
                break;
            case LogicalOrigin_MoveRight:
                m_xLogicalOrigin -= 10;
                break;
            case LogicalOrigin_Set:
                m_xLogicalOrigin =
                m_yLogicalOrigin = -100;
                break;
            case LogicalOrigin_Restore:
                m_xLogicalOrigin =
                m_yLogicalOrigin = 0;
                break;

            case UserScale_StretchHoriz:
                m_xUserScale *= 1.10;
                break;
            case UserScale_ShrinkHoriz:
                m_xUserScale /= 1.10;
                break;
            case UserScale_StretchVertic:
                m_yUserScale *= 1.10;
                break;
            case UserScale_ShrinkVertic:
                m_yUserScale /= 1.10;
                break;
            case UserScale_Restore:
                m_xUserScale =
                m_yUserScale = 1.0;
                break;

            case AxisMirror_Vertic:
                m_yAxisReversed = !m_yAxisReversed;
                break;
            case AxisMirror_Horiz:
                m_xAxisReversed = !m_xAxisReversed;
                break;


            case Colour_TextForeground:
                m_colourForeground = SelectColour();
                break;
            case Colour_TextBackground:
                m_colourBackground = SelectColour();
                break;
            case Colour_Background:
                {
                    Colour col = SelectColour();
//                    if ( col.Ok() )
                    if ( col !is null )
                    {
                        m_backgroundBrush.colour(col);
                    }
                }
                break;


            case Colour_BackgroundMode:
                m_backgroundMode = m_backgroundMode == FillStyle.wxSOLID ? FillStyle.wxTRANSPARENT
                                                               : FillStyle.wxSOLID;
                break;

            case Colour_TextureBackgound:
                m_textureBackground = ! m_textureBackground;
                break;

            default:
                // skip Refresh()
                return;
        }

        m_canvas.Refresh();
    }


    Colour SelectColour()
    {
        Colour col;
        ColourData data;
        ColourDialog dialog = new ColourDialog(this, data);

        if ( dialog.ShowModal() == wxID_OK )
        {
            col = dialog.colourData().colour();
        }

        return col;
    }


    void PrepareDC(DC dc)
    {
        dc.SetLogicalOrigin( m_xLogicalOrigin, m_yLogicalOrigin );
        dc.SetAxisOrientation( !m_xAxisReversed, m_yAxisReversed );
        dc.SetUserScale( m_xUserScale, m_yUserScale );
        dc.MapMode( m_mapMode );
    }

    FillStyle         m_backgroundMode;
    bool         m_textureBackground;
    int         m_mapMode;
    double      m_xUserScale;
    double      m_yUserScale;
    int         m_xLogicalOrigin;
    int         m_yLogicalOrigin;
    bool        m_xAxisReversed,
                m_yAxisReversed;
    Colour      m_colourForeground,    // these are _text_ colours
                m_colourBackground;
    Brush       m_backgroundBrush;
    MyCanvas   m_canvas;


};


// ----------------------------------------------------------------------------
// MyCanvas
// ----------------------------------------------------------------------------
// define a scrollable canvas for drawing onto
class MyCanvas: public ScrolledWindow
{

    this( MyFrame parent )
    {

    super(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize,
                           wxHSCROLL | wxVSCROLL | wxNO_FULL_REPAINT_ON_RESIZE);


    m_owner = parent;
    m_show = ScreenToShow.Show_Default;
    // m_smile_bmp = new Bitmap(smile_xpm);
    m_smile_bmp = new Bitmap("smile.xpm", BitmapType.wxBITMAP_TYPE_XPM);
    //m_smile_bmp = null;

    m_std_icon = ArtProvider.GetIcon( ArtID.wxART_INFORMATION );
    m_clip = false;

    m_useContext = false;

// the event tables connect the wxWidgets events with the functions (event
// handlers) which process them.
    EVT_PAINT  (&OnPaint);
    EVT_MOTION (&OnMouseMove);

    }

    void OnPaint(Object sender, Event e)
    {
        PaintEvent event = cast(PaintEvent) e;

        PaintDC dc = new PaintDC(this);
        PrepareDC(dc);
        m_owner.PrepareDC(dc);

        dc.BackgroundMode( m_owner.m_backgroundMode );


        if(m_owner.m_backgroundBrush !is null)
//            MessageBox("m_owner.m_backgroundBrush is null");
//        else
            dc.Background( m_owner.m_backgroundBrush );


//        if ( m_owner.m_colourForeground.Ok() )
        if ( m_owner.m_colourForeground !is null )
            dc.TextForeground( m_owner.m_colourForeground );
//        if ( m_owner.m_colourBackground.Ok() )
        if ( m_owner.m_colourBackground !is null )
            dc.TextBackground( m_owner.m_colourBackground );

        if ( m_owner.m_textureBackground) {
//            if ( ! m_owner.m_backgroundBrush.Ok() ) 
            if ( m_owner.m_backgroundBrush is null ) 
            {
                Colour clr = new Colour(0,128,0);
                Brush b = new Brush(clr, FillStyle.wxSOLID);
                dc.Background(b);
            }
        }


        if ( m_clip )
            dc.SetClippingRegion(100, 100, 100, 100);



        if ( m_owner.m_textureBackground )
        {
            dc.pen( Pen.wxMEDIUM_GREY_PEN);
            for ( int i = 0; i < 200; i++ )
                dc.DrawLine(0, i*10, i*10, 0);
        }



        switch ( m_show )
        {
            case ScreenToShow.Show_Default:
                DrawDefault(dc);
                break;

            case ScreenToShow.Show_Circles:
                DrawCircles(dc);
                break;

            case ScreenToShow.Show_Splines:
                DrawSplines(dc);
                break;

            case ScreenToShow.Show_Regions:
                DrawRegions(dc);
                break;

            case ScreenToShow.Show_Text:
                DrawText(dc);
                break;

            case ScreenToShow.Show_Lines:
                DrawTestLines( 0, 100, 0, dc );
                DrawTestLines( 0, 320, 1, dc );
                DrawTestLines( 0, 540, 2, dc );
                DrawTestLines( 0, 760, 6, dc );
                break;

            case ScreenToShow.Show_Brushes:
                DrawTestBrushes(dc);
                break;

            case ScreenToShow.Show_Polygons:
                DrawTestPoly(dc);
                break;

            case ScreenToShow.Show_Mask:
                DrawImages(dc);
                break;

            case ScreenToShow.Show_Ops:
                DrawWithLogicalOps(dc);
                break;
            

/*
            case ScreenToShow.Show_Alpha:
                 DrawAlpha(dc);
                break;
*/

            case ScreenToShow.Show_Gradient:
                DrawGradients(dc);
                break;

            default:
                break;
        }

        dc.Dispose();
    }


    void OnMouseMove(Object sender, Event e)
    {

        ClientDC dc = new ClientDC(this);
        PrepareDC(dc);
        m_owner.PrepareDC(dc);
        MouseEvent event = cast(MouseEvent) e;
        Point pos = event.Position();
        long x = dc.DeviceToLogicalX( pos.X );
        long y = dc.DeviceToLogicalY( pos.Y );

        string str = "Current mouse position: " ~ std.string.toString(x) ~ ", " ~ std.string.toString(y );
        m_owner.StatusText = str;

//        wxUnusedVar(event);

    }


    void ToShow(ScreenToShow show) { m_show = show; Refresh(); }

    // set or remove the clipping region
    void Clip(bool clip) { m_clip = clip; Refresh(); }

    void UseGraphicContext(bool use) { m_useContext = use; Refresh(); }



    void DrawTestLines( int x, int y, int width, DC dc )
    {
        dc.pen( new Pen( "black", width, FillStyle.wxSOLID) );
        dc.brush( Brush.wxRED_BRUSH );
        dc.DrawText(("Testing lines of width " ~ std.string.toString(width)), x + 10, y - 10);
        dc.DrawRectangle( x+10, y+10, 100, 190 );

        dc.DrawText(("Solid/dot/short dash/long dash/dot dash"), x + 150, y + 10);
        dc.pen( new Pen( "black", width, FillStyle.wxSOLID) );
        dc.DrawLine( x+20, y+20, 100, y+20 );
        dc.pen( new Pen( "black", width, FillStyle.wxDOT) );
        dc.DrawLine( x+20, y+30, 100, y+30 );
        dc.pen( new Pen( "black", width, FillStyle.wxSHORT_DASH) );
        dc.DrawLine( x+20, y+40, 100, y+40 );
//        dc.pen( new Pen( "black", width, FillStyle.wxLONG_DASH) );
//        dc.DrawLine( x+20, y+50, 100, y+50 );
        dc.pen( new Pen( "black", width, FillStyle.wxDOT_DASH) );
        dc.DrawLine( x+20, y+60, 100, y+60 );

        dc.DrawText(("Misc hatches"), x + 150, y + 70);
        dc.pen( new Pen( "black", width, FillStyle.wxBDIAGONAL_HATCH) );
        dc.DrawLine( x+20, y+70, 100, y+70 );
        dc.pen( new Pen( "black", width, FillStyle.wxCROSSDIAG_HATCH) );
        dc.DrawLine( x+20, y+80, 100, y+80 );
        dc.pen( new Pen( "black", width, FillStyle.wxFDIAGONAL_HATCH) );
        dc.DrawLine( x+20, y+90, 100, y+90 );
        dc.pen( new Pen( "black", width, FillStyle.wxCROSS_HATCH) );
        dc.DrawLine( x+20, y+100, 100, y+100 );
        dc.pen( new Pen( "black", width, FillStyle.wxHORIZONTAL_HATCH) );
        dc.DrawLine( x+20, y+110, 100, y+110 );
        dc.pen( new Pen( "black", width, FillStyle.wxVERTICAL_HATCH) );
        dc.DrawLine( x+20, y+120, 100, y+120 );

        dc.DrawText(("User dash"), x + 150, y + 140);
        Pen ud = new Pen( "black", width, FillStyle.wxUSER_DASH );
        wxDash dash1[6];
        dash1[0] = 8;  // Long dash  <---------+
        dash1[1] = 2;  // Short gap            |
        dash1[2] = 3;  // Short dash           |
        dash1[3] = 2;  // Short gap            |
        dash1[4] = 3;  // Short dash           |
        dash1[5] = 2;  // Short gap and repeat +
        // ud.SetDashes( 6, dash1 );
        dc.pen( ud );
        dc.DrawLine( x+20, y+140, 100, y+140 );
        dash1[0] = 5;  // Make first dash shorter
        // ud.SetDashes( 6, dash1 );
        dc.pen( ud );
        dc.DrawLine( x+20, y+150, 100, y+150 );
        dash1[2] = 5;  // Make second dash longer
        // ud.SetDashes( 6, dash1 );
        dc.pen( ud );
        dc.DrawLine( x+20, y+160, 100, y+160 );
        dash1[4] = 5;  // Make third dash longer
        // ud.SetDashes( 6, dash1 );
        dc.pen( ud );
        dc.DrawLine( x+20, y+170, 100, y+170 );
    }


    void DrawTestPoly(DC dc)
    {
        Brush brushHatch = new Brush( Colour.wxRED, FillStyle.wxFDIAGONAL_HATCH);
        dc.brush(brushHatch);

        Point[5] star;
        star[0] = Point(100, 60);
        star[1] = Point(60, 150);
        star[2] = Point(160, 100);
        star[3] = Point(40, 100);
        star[4] = Point(140, 150);

        dc.DrawText(("You should see two (irregular) stars below, the left one hatched"), 10, 10);
        dc.DrawText(("except for the central region and the right one entirely hatched"), 10, 30);
        dc.DrawText(("The third star only has a hatched outline"), 10, 50);

        dc.DrawPolygon(star.length, star, 0, 30);
        dc.DrawPolygon(star.length, star, 160, 30, FillStyle.wxWINDING_RULE);

        Point[10] star2;
        star2[0] = Point(0, 100);
        star2[1] = Point(-59, -81);
        star2[2] = Point(95, 31);
        star2[3] = Point(-95, 31);
        star2[4] = Point(59, -81);
        star2[5] = Point(0, 80);
        star2[6] = Point(-47, -64);
        star2[7] = Point(76, 24);
        star2[8] = Point(-76, 24);
        star2[9] = Point(47, -64);
        int[2] count = [5, 5];

//        dc.DrawPolyPolygon( count.length, count, star2, 450, 150);
    }


    void DrawTestBrushes(DC dc)
    {
        static  wxCoord WIDTH = 200;
        static  wxCoord HEIGHT = 80;

        wxCoord x = 10,
                y = 10;

        dc.brush( new Brush( Colour.wxGREEN, FillStyle.wxSOLID) );
        dc.DrawRectangle(x, y, WIDTH, HEIGHT);
        dc.DrawText( "Solid green", x + 10, y + 10);

        y += HEIGHT;
        dc.brush( new Brush(Colour.wxRED, FillStyle.wxCROSSDIAG_HATCH) );
        dc.DrawRectangle(x, y, WIDTH, HEIGHT);
        dc.DrawText(("Hatched red"), x + 10, y + 10);

        y += HEIGHT;
        dc.brush( new Brush(gs_bmpMask));
        dc.DrawRectangle(x, y, WIDTH, HEIGHT);
        dc.DrawText(("Stipple mono"), x + 10, y + 10);

        y += HEIGHT;
        dc.brush( new Brush(gs_bmpNoMask));
        dc.DrawRectangle(x, y, WIDTH, HEIGHT);
        dc.DrawText(("Stipple colour"), x + 10, y + 10);
    }


    void DrawText(DC dc)
    {
        // set underlined font for testing
        dc.font( new Font(12, FontFamily.wxMODERN, FontStyle.wxNORMAL, FontWeight.wxNORMAL, true) );
        dc.DrawText( "This is text", 110, 10 );
        dc.DrawRotatedText( "That is text", 20, 10, -45 );

        // use wxSWISS_FONT and not FontFamily.wxNORMAL_FONT as the latter can't be rotated
        // under Win9x (it is not TrueType)
        dc.font( Font.wxSWISS_FONT );

        //wxString text;
        string text;
        dc.BackgroundMode(FillStyle.wxTRANSPARENT);

        for ( int n = -180; n < 180; n += 30 )
        {
            // text.Printf(("     %d rotated text"), n);
            text = "     %d rotated text";
            dc.DrawRotatedText(text , 400, 400, n);
        }

        dc.font( new Font( 18, FontFamily.wxSWISS, FontStyle.wxNORMAL, FontWeight.wxNORMAL ) );

        dc.DrawText( "This is Swiss 18pt text.", 110, 40 );

        int length;
        int height;
        int descent;
        int externalLeading;
        dc.GetTextExtent( "This is Swiss 18pt text.", length, height, descent, externalLeading, null);
        //text.Printf( "Dimensions are length %ld, height %ld, descent %ld", length, height, descent );
        text = "Dimensions are length %ld, height %ld, descent %ld";
        dc.DrawText( text, 110, 80 );

        //text.Printf( ("CharHeight() returns: %d"), dc.CharHeight() );
        text = "CharHeight() returns: %d";
        dc.DrawText( text, 110, 120 );

        dc.DrawRectangle( 100, 40, 4, height );

        // test the logical function effect
        wxCoord y = 150;
        dc.LogicalFunction(Logic.wxINVERT);
        dc.DrawText( "There should be no text below", 110, 150 );
        dc.DrawRectangle( 110, y, 100, height );

        // twice drawn inverted should result in invisible
        y += height;
        dc.DrawText( "Invisible text", 110, y );
        dc.DrawRectangle( 110, y, 100, height );
        dc.DrawText( "Invisible text", 110, y );
        dc.DrawRectangle( 110, y, 100, height );
        dc.LogicalFunction(Logic.wxCOPY);

        y += height;
        dc.DrawRectangle( 110, y, 100, height );
        dc.DrawText( "Visible text", 110, y );
    }


    void DrawImages(DC dc)
    {
        dc.DrawText(("original image"), 0, 0);
        dc.DrawBitmap(gs_bmpNoMask, 0, 20, 0);
        dc.DrawText(("with colour mask"), 0, 100);
        dc.DrawBitmap(gs_bmpWithColMask, 0, 120, true);
        dc.DrawText(("the mask image"), 0, 200);
        dc.DrawBitmap(gs_bmpMask, 0, 220, 0);
        dc.DrawText(("masked image"), 0, 300);
        dc.DrawBitmap(gs_bmpWithMask, 0, 320, true);

        int cx = gs_bmpWithColMask.Width(),
            cy = gs_bmpWithColMask.Height();

        MemoryDC memDC;
        for ( size_t n = 0; n < rasterOperations.length; n++ )
        {
            wxCoord x = cast(wxCoord) (120 + 150*(n%4)),
                    y =  cast(wxCoord) (20 + 100*(n/4));

            dc.DrawText(rasterOperations[n].name, x, y - 20);
            memDC.SelectObject(gs_bmpWithColMask);
            dc.Blit(x, y, cx, cy, memDC, 0, 0, rasterOperations[n].rop, true);
        }
    }


    void DrawWithLogicalOps(DC dc)
    {
        static  wxCoord w = 60;
        static  wxCoord h = 60;

        // reuse the text colour here
        dc.pen( new Pen(m_owner.m_colourForeground, 1, FillStyle.wxSOLID));
        dc.brush( Brush.wxTRANSPARENT_BRUSH );

        size_t n;
        for ( n = 0; n < rasterOperations.length; n++ )
        {
            wxCoord x = cast(wxCoord) (20 + 150*(n%4)),
                    y = cast(wxCoord) (20 + 100*(n/4));

            dc.DrawText(rasterOperations[n].name, x, y - 20);
            dc.LogicalFunction(rasterOperations[n].rop);
            dc.DrawRectangle(x, y, w, h);
            dc.DrawLine(x, y, x + w, y + h);
            dc.DrawLine(x + w, y, x, y + h);
        }

        // now some filled rectangles
        dc.brush( new Brush(m_owner.m_colourForeground, FillStyle.wxSOLID));

        for ( n = 0; n < rasterOperations.length; n++ )
        {
            wxCoord x = cast(wxCoord) (20 + 150*(n%4)),
                    y = cast(wxCoord) (500 + 100*(n/4));

            dc.DrawText(rasterOperations[n].name, x, y - 20);
            dc.LogicalFunction(rasterOperations[n].rop);
            dc.DrawRectangle(x, y, w, h);
        }
    }

/+++++
    void DrawAlpha(DC dc)
    {

        GCDC dc = new GCDC( this );
        PrepareDC( dc );


        double margin = 20 ;
        double width = 180 ;
        double radius = 30 ;
        
        dc.pen( new Pen( new Colour( 128, 0, 0 ),12, FillStyle.wxSOLID));
        dc.brush( new Brush( new Colour( 255, 0, 0 ),FillStyle.wxSOLID));
        
        wx.common.Rect r = wx.common.Rect( cast(int) margin, cast(int)(margin+width*0.66), cast(int) width, cast(int)width) ;

        
        dc.DrawRoundedRectangle( r.X, r.Y, r.Width, r.Width, radius ) ;
        
        dc.pen( new Pen( new Colour( 0, 0, 128 ),12, FillStyle.wxSOLID));
        dc.brush( new Brush( new Colour( 0, 0, 255 ),FillStyle.wxSOLID));
        
        //r.Offset( width * 0.8 , - width * 0.66 ) ;
        
        dc.DrawRoundedRectangle( r.X, r.Y, r.Width, r.Width, radius ) ;
        
        dc.pen( new Pen( new Colour( 128, 128, 0 ),12, FillStyle.wxSOLID));
        dc.brush( new Brush( new Colour( 192, 192, 0 ),FillStyle.wxSOLID));

        //r.Offset( width * 0.8 , width *0.5 ) ;
        
        dc.DrawRoundedRectangle( r.X, r.Y, r.Width, r.Width, radius ) ;
        
        dc.pen( Pen.wxTRANSPARENT_PEN ) ;
        dc.brush( new Brush( new Colour( 255,255,128 ) ) );
        dc.DrawRoundedRectangle( 0 , cast(int)(margin + width / 2) , cast(int) width * 3 , 100 , radius) ;
        
        dc.TextForeground( new Colour(255,255,0 ) );
        dc.font( new Font( 40, FontFamily.wxSWISS, FontStyle.wxITALIC, FontWeight.wxNORMAL ) );
        dc.DrawText( "Hello!", 120, 80 );
    }
+++++/

    void DrawRegions(DC dc)
    {
        dc.DrawText(("You should see a red rect partly covered by a cyan one on the left"), 10, 5);
        dc.DrawText(("and 5 smileys from which 4 are partially clipped on the right"),
                    10, 5 + (cast(WindowDC)dc).CharHeight());
        dc.DrawText(("The second copy should be identical but right part of it should be offset by 10 pixels."),
                    10, 5 + 2*(cast(WindowDC)dc).CharHeight());

        DrawRegionsHelper(dc, 10, true);
        DrawRegionsHelper(dc, 350, false);
    }



    void DrawCircles(DC dc)
    {
        int x = 100,
            y = 100,
            r = 20;

        dc.pen( Pen.wxRED_PEN );
        dc.brush( Brush.wxGREEN_BRUSH );

        dc.DrawText(("Some circles"), 0, y);
        dc.DrawCircle(x, y, r);
        dc.DrawCircle(x + 2*r, y, r);
        dc.DrawCircle(x + 4*r, y, r);

        y += 2*r;
        dc.DrawText(("And ellipses"), 0, y);
        dc.DrawEllipse(x - r, y, 2*r, r);
        dc.DrawEllipse(x + r, y, 2*r, r);
        dc.DrawEllipse(x + 3*r, y, 2*r, r);

        y += 2*r;
        dc.DrawText(("And arcs"), 0, y);
        dc.DrawArc(x - r, y, x + r, y, x, y);
        dc.DrawArc(x + 4*r, y, x + 2*r, y, x + 3*r, y);
        dc.DrawArc(x + 5*r, y, x + 5*r, y, x + 6*r, y);

        y += 2*r;
        dc.DrawEllipticArc(x - r, y, 2*r, r, 0, 90);
        dc.DrawEllipticArc(x + r, y, 2*r, r, 90, 180);
        dc.DrawEllipticArc(x + 3*r, y, 2*r, r, 180, 270);
        dc.DrawEllipticArc(x + 5*r, y, 2*r, r, 270, 360);
        
        // same as above, just transparent brush
        
        dc.pen( Pen.wxRED_PEN );
        dc.brush( Brush.wxTRANSPARENT_BRUSH );

        y += 2*r;
        dc.DrawText(("Some circles"), 0, y);
        dc.DrawCircle(x, y, r);
        dc.DrawCircle(x + 2*r, y, r);
        dc.DrawCircle(x + 4*r, y, r);

        y += 2*r;
        dc.DrawText(("And ellipses"), 0, y);
        dc.DrawEllipse(x - r, y, 2*r, r);
        dc.DrawEllipse(x + r, y, 2*r, r);
        dc.DrawEllipse(x + 3*r, y, 2*r, r);

        y += 2*r;
        dc.DrawText(("And arcs"), 0, y);
        dc.DrawArc(x - r, y, x + r, y, x, y);
        dc.DrawArc(x + 4*r, y, x + 2*r, y, x + 3*r, y);
        dc.DrawArc(x + 5*r, y, x + 5*r, y, x + 6*r, y);

        y += 2*r;
        dc.DrawEllipticArc(x - r, y, 2*r, r, 0, 90);
        dc.DrawEllipticArc(x + r, y, 2*r, r, 90, 180);
        dc.DrawEllipticArc(x + 3*r, y, 2*r, r, 180, 270);
        dc.DrawEllipticArc(x + 5*r, y, 2*r, r, 270, 360);
        
    }


    void DrawSplines(DC dc)
    {

        dc.DrawText(("Some splines"), 10, 5);

        // values are hardcoded rather than randomly generated
        // so the output can be compared between native
        // implementations on platforms with different random
        // generators

         int R = 300;
         Point center = Point( R + 20, R + 20 );
         int angles[7] = [ 0, 10, 33, 77, 13, 145, 90 ];
         int radii[5] = [ 100 , 59, 85, 33, 90 ];
         const int N = 200;
        Point[N] pts;

        // background spline calculation
        uint radius_pos = 0;
        uint angle_pos = 0;
        int angle = 0;
        for ( int i = 0; i < N; i++ )
        {
            angle += angles[ angle_pos ];
            int r = R * radii[ radius_pos ] / 100;
            pts[ i ].X = center.X + cast(wxCoord)( r * cos( PI * angle / 180.0) );
            pts[ i ].Y = center.Y + cast(wxCoord)( r * sin( PI * angle / 180.0) );

            angle_pos++;
            if ( angle_pos >= angles.length ) angle_pos = 0;

            radius_pos++;
            if ( radius_pos >= radii.length ) radius_pos = 0;
        }

        // background spline drawing
        dc.pen( Pen.wxRED_PEN );
        dc.DrawSpline( pts);

        // less detailed spline calculation
        Point letters[4][5];
        // w
        letters[0][0] = Point( 0,1); //  O           O
        letters[0][1] = Point( 1,3); //   *         *
        letters[0][2] = Point( 2,2); //    *   O   *
        letters[0][3] = Point( 3,3); //     * * * *
        letters[0][4] = Point( 4,1); //      O   O
        // x1
        letters[1][0] = Point( 5,1); //  O*O
        letters[1][1] = Point( 6,1); //     *
        letters[1][2] = Point( 7,2); //      O
        letters[1][3] = Point( 8,3); //       *
        letters[1][4] = Point( 9,3); //        O*O
        // x2
        letters[2][0] = Point( 5,3); //        O*O
        letters[2][1] = Point( 6,3); //       *
        letters[2][2] = Point( 7,2); //      O
        letters[2][3] = Point( 8,1); //     *
        letters[2][4] = Point( 9,1); //  O*O
        // W
        letters[3][0] = Point(10,0); //  O           O
        letters[3][1] = Point(11,3); //   *         *
        letters[3][2] = Point(12,1); //    *   O   *
        letters[3][3] = Point(13,3); //     * * * *
        letters[3][4] = Point(14,0); //      O   O

         int dx = 2 * R / letters[3][4].X;
         int h[4] = [ -R/2, 0, R/4, R/2 ];

        for ( int m = 0; m < 4; m++ )
        {
            for ( int n = 0; n < 5; n++ )
            {
                letters[m][n].X = center.X - R + letters[m][n].X * dx;
                letters[m][n].Y = center.X + h[ letters[m][n].Y ];
            }

            dc.pen( new Pen( "blue", 1, FillStyle.wxDOT) );
            dc.DrawLines(letters[m]);
            dc.pen( new Pen( "black", 4, FillStyle.wxSOLID) );
            dc.DrawSpline(letters[m]);
        }


        dc.DrawText(("Splines not supported."), 10, 5);

    }



    void DrawDefault(DC dc)
    {
        // mark the origin
        dc.DrawCircle(0, 0, 10);


        // GetPixel and FloodFill not supported by Mac OS X CoreGraphics
        // (FloodFill uses Blit from a non-MemoryDC)
        //flood fill using brush, starting at 1,1 and replacing whatever colour we find there
        dc.brush( new Brush(new Colour(128,128,0), FillStyle.wxSOLID));

        Colour tmpColour = new Colour();
        dc.GetPixel(1,1, tmpColour);
        dc.FloodFill(1,1, tmpColour, FloodStyle.wxFLOOD_SURFACE);


        dc.DrawCheckMark(5, 80, 15, 15);
        dc.DrawCheckMark(25, 80, 30, 30);
        dc.DrawCheckMark(60, 80, 60, 60);

        // this is the test for "blitting bitmap into DC damages selected brush" bug
        wxCoord rectSize =cast(wxCoord)( m_std_icon.Width() + 10);

        wxCoord x = 100;
        dc.pen( Pen.wxTRANSPARENT_PEN);

        dc.brush( Brush.wxGREEN_BRUSH );
        dc.DrawRectangle(x, 10, rectSize, rectSize);

        dc.DrawBitmap(m_smile_bmp, x + 5, 15, true);
        x += rectSize + 10;
        dc.DrawRectangle(x, 10, rectSize, rectSize);

        dc.DrawIcon(m_std_icon, x + 5, 15);
        x += rectSize + 10;
        dc.DrawRectangle(x, 10, rectSize, rectSize);

        // test for "transparent" bitmap drawing (it intersects with the last
        // rectangle above)
        //dc.brush( Brush.wxTRANSPARENT_BRUSH );

        if (m_smile_bmp.Ok())
            dc.DrawBitmap(m_smile_bmp, x + rectSize - 20, rectSize - 10, true);

        dc.brush( Brush.wxBLACK_BRUSH );
        dc.DrawRectangle( 0, 160, 1000, 300 );

        // draw lines
        Bitmap bitmap = new Bitmap(20,70);
        MemoryDC memdc = new MemoryDC();
        memdc.SelectObject( bitmap );
        memdc.brush( Brush.wxBLACK_BRUSH );
        memdc.pen( Pen.wxWHITE_PEN );
        memdc.DrawRectangle(0,0,20,70);
        memdc.DrawLine( 10,0,10,70 );

        // to the right
        Pen pen = Pen.wxRED_PEN;
        memdc.pen(pen);
        memdc.DrawLine( 10, 5,10, 5 );
        memdc.DrawLine( 10,10,11,10 );
        memdc.DrawLine( 10,15,12,15 );
        memdc.DrawLine( 10,20,13,20 );

    /*
        memdc.pen( Pen.wxRED_PEN );
        memdc.DrawLine( 12, 5,12, 5 );
        memdc.DrawLine( 12,10,13,10 );
        memdc.DrawLine( 12,15,14,15 );
        memdc.DrawLine( 12,20,15,20 );
    */

        // same to the left
        memdc.DrawLine( 10,25,10,25 );
        memdc.DrawLine( 10,30, 9,30 );
        memdc.DrawLine( 10,35, 8,35 );
        memdc.DrawLine( 10,40, 7,40 );

        // XOR draw lines
        dc.pen( Pen.wxWHITE_PEN );
        memdc.LogicalFunction( Logic.wxINVERT );
        memdc.pen( Pen.wxWHITE_PEN );
        memdc.DrawLine( 10,50,10,50 );
        memdc.DrawLine( 10,55,11,55 );
        memdc.DrawLine( 10,60,12,60 );
        memdc.DrawLine( 10,65,13,65 );

        memdc.DrawLine( 12,50,12,50 );
        memdc.DrawLine( 12,55,13,55 );
        memdc.DrawLine( 12,60,14,60 );
        memdc.DrawLine( 12,65,15,65 );

        memdc.SelectObject( Bitmap.wxNullBitmap );
        dc.DrawBitmap( bitmap, 10, 170 );
        wxImage image = bitmap.ConvertToImage();
        image.Rescale( 60,210 );
        bitmap = new Bitmap(image);
        dc.DrawBitmap( bitmap, 50, 170 );

        // test the rectangle outline drawing - there should be one pixel between
        // the rect and the lines
        dc.pen( Pen.wxWHITE_PEN);
        dc.brush( Brush.wxTRANSPARENT_BRUSH );
        dc.DrawRectangle(150, 170, 49, 29);
        dc.DrawRectangle(200, 170, 49, 29);
        dc.pen( Pen.wxWHITE_PEN );
        dc.DrawLine(250, 210, 250, 170);
        dc.DrawLine(260, 200, 150, 200);

        // test the rectangle filled drawing - there should be one pixel between
        // the rect and the lines
        dc.pen(Pen.wxTRANSPARENT_PEN);
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.DrawRectangle(300, 170, 49, 29);
        dc.DrawRectangle(350, 170, 49, 29);
        dc.pen( Pen.wxWHITE_PEN );
        dc.DrawLine(400, 170, 400, 210);
        dc.DrawLine(300, 200, 410, 200);

        // a few more tests of this kind
        dc.pen( Pen.wxRED_PEN );
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.DrawRectangle(300, 220, 1, 1);
        dc.DrawRectangle(310, 220, 2, 2);
        dc.DrawRectangle(320, 220, 3, 3);
        dc.DrawRectangle(330, 220, 4, 4);

        dc.pen(Pen.wxTRANSPARENT_PEN);
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.DrawRectangle(300, 230, 1, 1);
        dc.DrawRectangle(310, 230, 2, 2);
        dc.DrawRectangle(320, 230, 3, 3);
        dc.DrawRectangle(330, 230, 4, 4);

        // and now for filled rect with outline
        dc.pen( Pen.wxRED_PEN );
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.DrawRectangle(500, 170, 49, 29);
        dc.DrawRectangle(550, 170, 49, 29);
        dc.pen( Pen.wxWHITE_PEN );
        dc.DrawLine(600, 170, 600, 210);
        dc.DrawLine(500, 200, 610, 200);

        // test the rectangle outline drawing - there should be one pixel between
        // the rect and the lines
        dc.pen( Pen.wxWHITE_PEN );
        dc.brush( Brush.wxTRANSPARENT_BRUSH );
        dc.DrawRoundedRectangle(150, 270, 49, 29, 6);
        dc.DrawRoundedRectangle(200, 270, 49, 29, 6);
        dc.pen( Pen.wxWHITE_PEN );
        dc.DrawLine(250, 270, 250, 310);
        dc.DrawLine(150, 300, 260, 300);

        // test the rectangle filled drawing - there should be one pixel between
        // the rect and the lines
        dc.pen(Pen.wxTRANSPARENT_PEN);
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.DrawRoundedRectangle(300, 270, 49, 29, 6);
        dc.DrawRoundedRectangle(350, 270, 49, 29, 6);
        dc.pen( Pen.wxWHITE_PEN );
        dc.DrawLine(400, 270, 400, 310);
        dc.DrawLine(300, 300, 410, 300);

        // Added by JACS to demonstrate bizarre behaviour.
        // With a size of 70, we get a missing red RHS,
        // and the height is too small, so we get yellow
        // showing. With a size of 40, it draws as expected:
        // it just shows a white rectangle with red outline.
        int totalWidth = 70;
        int totalHeight = 70;
        Bitmap bitmap2 = new Bitmap(totalWidth, totalHeight);

        MemoryDC memdc2 = new MemoryDC();
        memdc2.SelectObject(bitmap2);

        Colour clr = new Colour(255, 255, 0);
        Brush yellowBrush = new Brush(clr, FillStyle.wxSOLID);
        memdc2.Background( yellowBrush );
        memdc2.Clear();



        Pen yellowPen = new Pen(clr, 1, FillStyle.wxSOLID);

        // Now draw a white rectangle with red outline. It should
        // entirely eclipse the yellow background.
        memdc2.pen( Pen.wxRED_PEN );
        memdc2.brush(Brush.wxWHITE_BRUSH);

        memdc2.DrawRectangle(0, 0, totalWidth, totalHeight);

        memdc2.pen( Pen.wxNullPen );
        memdc2.brush( Brush.wxNullBrush );
        memdc2.SelectObject( Bitmap.wxNullBitmap );

        dc.DrawBitmap(bitmap2, 500, 270);

        // Repeat, but draw directly on dc
        // Draw a yellow rectangle filling the bitmap

        x = 600; int y = 270;
        dc.pen(yellowPen);
        dc.brush( yellowBrush );
        dc.DrawRectangle(x, y, totalWidth, totalHeight);

        // Now draw a white rectangle with red outline. It should
        // entirely eclipse the yellow background.
        dc.pen( Pen.wxRED_PEN );
        dc.brush(Brush.wxWHITE_BRUSH);

        dc.DrawRectangle(x, y, totalWidth, totalHeight);

    }


    void DrawGradients(DC dc)
    {
        static  int TEXT_HEIGHT = 15;
        Log tempLog = new Log();
        tempLog.LogMessage("Sorry! This function has not been implemented by wxD.");

/+++++
        // LHS: linear
        Rect r = {10, 10, 50, 50};
        dc.DrawText(("wxRIGHT"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillLinear(r, wxWHITE, wxBLUE, wxRIGHT);

        r.Offset(0, r.Height + 10);
        dc.DrawText(("wxLEFT"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillLinear(r, *wxWHITE, *wxBLUE, wxLEFT);

        r.Offset(0, r.Height + 10);
        dc.DrawText(("wxDOWN"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillLinear(r, *wxWHITE, *wxBLUE, wxDOWN);

        r.Offset(0, r.Height + 10);
        dc.DrawText(("wxUP"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillLinear(r, *wxWHITE, *wxBLUE, wxUP);


        // RHS: concentric
        r = new Rect(200, 10, 50, 50);
        dc.DrawText(("Blue inside"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillConcentric(r, *wxBLUE, *wxWHITE);

        r.Offset(0, r.Height + 10);
        dc.DrawText(("White inside"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillConcentric(r, *wxWHITE, *wxBLUE);

        r.Offset(0, r.Height + 10);
        dc.DrawText(("Blue in top left corner"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillConcentric(r, *wxBLUE, *wxWHITE, Point(0, 0));

        r.Offset(0, r.Height + 10);
        dc.DrawText(("Blue in bottom right corner"), r.X, r.Y);
        r.Offset(0, TEXT_HEIGHT);
        //dc.GradientFillConcentric(r, *wxBLUE, *wxWHITE, Point(r.Width, r.Height));
+++++/
    }

    void DrawRegionsHelper(DC dc, wxCoord x, bool firstTime)
    {
        wxCoord y = 100;

        dc.DestroyClippingRegion();
        dc.brush( Brush.wxWHITE_BRUSH );
        dc.pen( Pen.wxTRANSPARENT_PEN );
        dc.DrawRectangle( x, y, 310, 310 );

        dc.SetClippingRegion( x + 10, y + 10, 100, 270 );

        dc.brush( Brush.wxRED_BRUSH );
        dc.DrawRectangle( x, y, 310, 310 );

        dc.SetClippingRegion( x + 10, y + 10, 100, 100 );

        dc.brush( Brush.wxCYAN_BRUSH );
        dc.DrawRectangle( x, y, 310, 310 );

        dc.DestroyClippingRegion();

        Region region = new Region(x + 110, y + 20, 100, 270);

  version(__WXMAC__) {} else
  {
        if ( !firstTime )
            region.Offset(10, 10);
  }

        dc.SetClippingRegion(region);

        dc.brush( Brush.wxGREY_BRUSH );
        dc.DrawRectangle( x, y, 310, 310 );

        if (m_smile_bmp.Ok())
        {
            dc.DrawBitmap( m_smile_bmp, x + 150, y + 150, true );
            dc.DrawBitmap( m_smile_bmp, x + 130, y + 10,  true );
            dc.DrawBitmap( m_smile_bmp, x + 130, y + 280, true );
            dc.DrawBitmap( m_smile_bmp, x + 100, y + 70,  true );
            dc.DrawBitmap( m_smile_bmp, x + 200, y + 70,  true );
        }
    }


private
    {
    MyFrame m_owner;

    ScreenToShow m_show;
    Bitmap     m_smile_bmp;
    Icon       m_std_icon;
    bool         m_clip;

    bool         m_useContext ;


    }
};

// ----------------------------------------------------------------------------
// ants
// ----------------------------------------------------------------------------

// IDs for the controls and the menu commands
enum
{
    // menu items
    File_Quit = MenuIDs.wxID_EXIT,
    File_About = MenuIDs.wxID_ABOUT,

    MenuShow_First = wxID_HIGHEST,
    File_ShowDefault = MenuShow_First,
    File_ShowText,
    File_ShowLines,
    File_ShowBrushes,
    File_ShowPolygons,
    File_ShowMask,
    File_ShowOps,
    File_ShowRegions,
    File_ShowCircles,
    File_ShowSplines,

    File_ShowAlpha,

    File_ShowGradients,
    MenuShow_Last = File_ShowGradients,

    File_Clip,

    File_GraphicContext,


    MenuOption_First,

    MapMode_Text = MenuOption_First,
    MapMode_Lometric,
    MapMode_Twips,
    MapMode_Points,
    MapMode_Metric,

    UserScale_StretchHoriz,
    UserScale_ShrinkHoriz,
    UserScale_StretchVertic,
    UserScale_ShrinkVertic,
    UserScale_Restore,

    AxisMirror_Horiz,
    AxisMirror_Vertic,

    LogicalOrigin_MoveDown,
    LogicalOrigin_MoveUp,
    LogicalOrigin_MoveLeft,
    LogicalOrigin_MoveRight,
    LogicalOrigin_Set,
    LogicalOrigin_Restore,


    Colour_TextForeground,
    Colour_TextBackground,
    Colour_Background,

    Colour_BackgroundMode,
    Colour_TextureBackgound,

    MenuOption_Last = Colour_TextureBackgound
};



struct rasterOp
{
     string name;
    Logic           rop;
};

static rasterOp[] rasterOperations =
[
    { "wxAND",          Logic.wxAND           },
    { "wxAND_INVERT",   Logic.wxAND_INVERT    },
    { "wxAND_REVERSE",  Logic.wxAND_REVERSE   },
    { "wxCLEAR",        Logic.wxCLEAR         },
    { "wxCOPY",         Logic.wxCOPY          },
    { "wxEQUIV",        Logic.wxEQUIV         },
    { "Logic.wxINVERT", Logic.wxINVERT        },
    { "wxNAND",         Logic.wxNAND          },
    { "wxNO_OP",        Logic.wxNO_OP         },
    { "wxOR",           Logic.wxOR            },
    { "wxOR_INVERT",    Logic.wxOR_INVERT     },
    { "wxOR_REVERSE",   Logic.wxOR_REVERSE    },
    { "wxSET",          Logic.wxSET           },
    { "wxSRC_INVERT",   Logic.wxSRC_INVERT    },
    { "wxXOR",          Logic.wxXOR           },
];


 