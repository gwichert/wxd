//-----------------------------------------------------------------------------
// wxD/Samples - GLCube.d
//
// A wxD version of the wxWidgets "opengl/cube" sample.
//
// wxGLCanvas demo program
// (c) 1998 Julian Smart
//
// (C) 2006 afb <afb.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

import wx.GLCanvas;

import gl.gl;

	public class TestGLCanvas : GLCanvas
	{
		public this(Window parent, TestGLCanvas other, int id, Point pos=wxDefaultPosition, Size size=wxDefaultSize, int style=0, string name="TestGLCanvas")
		{
			super(parent, other ? other.context : null, id, pos, size, style, name);

			EVT_SIZE(&OnSize);
			EVT_PAINT(&OnPaint);
			EVT_ERASE_BACKGROUND(&OnEraseBackground);
			EVT_ENTER_WINDOW(&OnEnterWindow);
		}

		public this(Window parent, int id, Point pos=wxDefaultPosition, Size size=wxDefaultSize, int style=0, string name="TestGLCanvas")
		{
			this(parent, null, id, pos, size, style, name);
		}

		private uint gllist = 0;

		private void Render()
		{
		    if (!context()) return;

			// This is a dummy, to avoid an endless succession of paint messages.
			// OnPaint handlers must always create a wxPaintDC.
			auto wxPaintDC dc = new wxPaintDC(this);

			SetCurrent();

			// Init OpenGL once, but after SetCurrent
			if (!init)
			{
				InitGL();
				init = true;
			}

			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			glFrustum(-0.5f, 0.5f, -0.5f, 0.5f, 1.0f, 3.0f);
			glMatrixMode(GL_MODELVIEW);
		
			/* clear color and depth buffers */
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		
			if( gllist == 0 )
			{
				gllist = glGenLists( 1 );
				glNewList(gllist, GL_COMPILE_AND_EXECUTE );
				/* draw six faces of a cube */
				glBegin(GL_QUADS);
				glNormal3f( 0.0f, 0.0f, 1.0f);
				glVertex3f( 0.5f, 0.5f, 0.5f); glVertex3f(-0.5f, 0.5f, 0.5f);
				glVertex3f(-0.5f,-0.5f, 0.5f); glVertex3f( 0.5f,-0.5f, 0.5f);
		
				glNormal3f( 0.0f, 0.0f,-1.0f);
				glVertex3f(-0.5f,-0.5f,-0.5f); glVertex3f(-0.5f, 0.5f,-0.5f);
				glVertex3f( 0.5f, 0.5f,-0.5f); glVertex3f( 0.5f,-0.5f,-0.5f);
		
				glNormal3f( 0.0f, 1.0f, 0.0f);
				glVertex3f( 0.5f, 0.5f, 0.5f); glVertex3f( 0.5f, 0.5f,-0.5f);
				glVertex3f(-0.5f, 0.5f,-0.5f); glVertex3f(-0.5f, 0.5f, 0.5f);
		
				glNormal3f( 0.0f,-1.0f, 0.0f);
				glVertex3f(-0.5f,-0.5f,-0.5f); glVertex3f( 0.5f,-0.5f,-0.5f);
				glVertex3f( 0.5f,-0.5f, 0.5f); glVertex3f(-0.5f,-0.5f, 0.5f);
		
				glNormal3f( 1.0f, 0.0f, 0.0f);
				glVertex3f( 0.5f, 0.5f, 0.5f); glVertex3f( 0.5f,-0.5f, 0.5f);
				glVertex3f( 0.5f,-0.5f,-0.5f); glVertex3f( 0.5f, 0.5f,-0.5f);
		
				glNormal3f(-1.0f, 0.0f, 0.0f);
				glVertex3f(-0.5f,-0.5f,-0.5f); glVertex3f(-0.5f,-0.5f, 0.5f);
				glVertex3f(-0.5f, 0.5f, 0.5f); glVertex3f(-0.5f, 0.5f,-0.5f);
				glEnd();
		
				glEndList();
			}
			else
			{
				glCallList(gllist);
			}
		
	   		glFlush();
	    	SwapBuffers();
		}
		
		private bool init = false;

		private void InitGL()
		{
		    SetCurrent();
		
			/* set viewing projection */
			glMatrixMode(GL_PROJECTION);
			glFrustum(-0.5f, 0.5f, -0.5f, 0.5f, 1.0f, 3.0f);
		
			/* position viewer */
			glMatrixMode(GL_MODELVIEW);
			glTranslatef(0.0f, 0.0f, -2.0f);
		
			/* position object */
			glRotatef(30.0f, 1.0f, 0.0f, 0.0f);
			glRotatef(30.0f, 0.0f, 1.0f, 0.0f);
		
			glEnable(GL_DEPTH_TEST);
			glEnable(GL_LIGHTING);
			glEnable(GL_LIGHT0);
		}

		void OnEnterWindow(Object sender, Event e)
		{
    		SetFocus();
		}

		void OnPaint(Object sender, Event e)
		{
    		e.Skip();
    		Render();
		}

		void OnSize(Object sender, Event e)
		{
			// set GL viewport (not called by wxGLCanvas::OnSize on all platforms...)
			Size size = ClientSize();
		
			if (context())
			{
				SetCurrent();
				glViewport(0, 0, cast(GLint) size.Width, cast(GLint) size.Height);
			}
		}

		void OnEraseBackground(Object sender, Event e)
		{
 		  // Do nothing, to avoid flashing.
		}
    }

	public class MyFrame : Frame
	{
		enum Cmd { Quit = 1 }

		//---------------------------------------------------------------------

		public this(Window parent, string title, Point pos, Size size, int style=wxDEFAULT_FRAME_STYLE)
		{
			super(parent, wxID_ANY, title, pos, size, style);
			canvas = null;

			// Set the window icon

			icon = new Icon("../Samples/GLCube/mondrian.png");

			// Set up the event table

    		EVT_MENU( MenuIDs.wxID_EXIT, &OnExit);
    		EVT_MENU( Cmd.Quit, &OnExit);
    		EVT_MENU( MenuIDs.wxID_NEW, &OnNewWindow);
		}
		
		public static MyFrame CreateWindow(MyFrame parentFrame = null, bool isCloneWindow = false)
		{
			string str = "wxWidgets OpenGL Cube Sample";
   			if (isCloneWindow) str ~= " - Clone";
 
 		    MyFrame frame = new MyFrame(null, str, wxDefaultPosition,
 		    	/* Size(400, 300) */ wxDefaultSize);

			// Make a menubar
			Menu winMenu = new Menu();
			winMenu.Append(MenuIDs.wxID_EXIT, "&Close");
			winMenu.Append(MenuIDs.wxID_NEW, "&New");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(winMenu, "&Window");

			frame.menuBar = menuBar;

			if (parentFrame)
			{
				frame.canvas = new TestGLCanvas(frame, parentFrame.canvas,
					wxID_ANY, wxDefaultPosition, wxDefaultSize );
			}
			else
			{
				frame.canvas = new TestGLCanvas(frame, wxID_ANY,
					wxDefaultPosition, wxDefaultSize);
			}
   
			// moved the Frame sizing to after canvas was added,
			// since otherwise the frame showed empty on wxMac ?
			frame.size = Size(400, 300);

   			// Show the frame
    		frame.Show(true);

			return frame;
		}

		//---------------------------------------------------------------------

		public void OnExit(Object sender, Event e)
		{
    		// true is to force the frame to close
			Close();
		}

		//---------------------------------------------------------------------

		public void OnNewWindow(Object sender, Event e)
		{
			CreateWindow(this, true);
		}

		//---------------------------------------------------------------------
	
	
		TestGLCanvas canvas;
	}

	public class GLCube : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
   			 // Create the main frame window
			MyFrame.CreateWindow(null);

			return true;
		}

		//---------------------------------------------------------------------

		static void Main()
		{
			GLCube app = new GLCube();
			app.Run();
		}

		//---------------------------------------------------------------------
	}

int main()
{
	GLCube.Main();
	return 0;
}
