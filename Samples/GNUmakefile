MAKE?=make
export COMPILER LIBRARY PLATFORM ENCODING STC OGL

all:
	$(MAKE) -C Controls
	$(MAKE) -C Dialogs
#	$(MAKE) -C Display
ifeq ("$(Library)","Phobos")
	$(MAKE) -C Dnd
endif
	$(MAKE) -C EventDemo
ifeq ("$(Library)","Phobos")
	$(MAKE) -C Font
endif
#	$(MAKE) -C GLCube
ifeq ("$(Library)","Phobos")
	$(MAKE) -C Grid
endif
	$(MAKE) -C Hello
	$(MAKE) -C HTML
	$(MAKE) -C HtmlHelp
ifeq ("$(Library)","Phobos")
	$(MAKE) -C HtmlListBox
	$(MAKE) -C Internat
	$(MAKE) -C Launcher
	$(MAKE) -C ListCtrl
	$(MAKE) -C ListView
	$(MAKE) -C Listbook
	$(MAKE) -C Mdi
endif
	$(MAKE) -C Minimal
ifeq ("$(Library)","Phobos")
	$(MAKE) -C Notebook
endif
	$(MAKE) -C Platform
	$(MAKE) -C Printing
ifeq ("$(Library)","Phobos")
	$(MAKE) -C SashWindow
endif
#	$(MAKE) -C SDLPanel
#	$(MAKE) -C Sound
	$(MAKE) -C Splitter
ifeq ("$(STC)","1")
	$(MAKE) -C StyledText
endif
#	$(MAKE) -C TaskBar
ifeq ("$(Library)","Phobos")
	$(MAKE) -C TreeCtrl
endif
#	$(MAKE) -C Tutorial
	$(MAKE) -C Wizard
	$(MAKE) -C Xrc
#	$(MAKE) -C Aui

clean:
	$(MAKE) clean -C Controls
	$(MAKE) clean -C Dialogs
	$(MAKE) clean -C Display
	$(MAKE) clean -C Dnd
	$(MAKE) clean -C EventDemo
	$(MAKE) clean -C Font
	$(MAKE) clean -C Grid
	$(MAKE) clean -C GLCube
	$(MAKE) clean -C Hello
	$(MAKE) clean -C HTML
	$(MAKE) clean -C HtmlHelp
	$(MAKE) clean -C HtmlListBox
	$(MAKE) clean -C Internat
	$(MAKE) clean -C Launcher
	$(MAKE) clean -C ListCtrl
	$(MAKE) clean -C ListView
	$(MAKE) clean -C Listbook
	$(MAKE) clean -C Mdi
	$(MAKE) clean -C Minimal
	$(MAKE) clean -C Notebook
	$(MAKE) clean -C Platform
	$(MAKE) clean -C Printing
	$(MAKE) clean -C SashWindow
	$(MAKE) clean -C SDLPanel
	$(MAKE) clean -C Sound
	$(MAKE) clean -C Splitter
	$(MAKE) clean -C StyledText
	$(MAKE) clean -C TaskBar
	$(MAKE) clean -C TreeCtrl
	$(MAKE) clean -C Tutorial
	$(MAKE) clean -C Wizard
	$(MAKE) clean -C Xrc
	$(MAKE) clean -C Aui
