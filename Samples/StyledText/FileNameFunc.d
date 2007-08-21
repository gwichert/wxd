//-----------------------------------------------------------------------------
// wxD/Samples - FileNameFunc.d
//
// absPath replaces wxFileName.Normalize() and wxFileName.GetFullPath()
// these functions are from: http://www.digitalmars.com/d/archives/digitalmars/D/announce/4363.html
//
// (C) 2006 Joe Zuccarello
// License: Public domain.
//
// $Id$
//-----------------------------------------------------------------------------


module FileNameFunc;

version (Tango)
{
static assert(0);
}
else // Phobos
{
import std.file;
import std.path;
import std.regexp;
import std.string;
}

private static const char[] wSep = r"\",
                            lSep = "/",
                            rSeps = "[\\\\/]";  // For regexp use

version(DigitalMars)
	version(linux)
		version=Unix;

/**
  * Returns a normalized absolutized path.
  *
  * If the path is not absolute, it will be joined with the current working directory.  If it is an
  * absolute path, nothing will be joined with it.  In either case, the path will also be checked to
  * see if it is normalized.  If it's not, it will be normalized.
  *
  * Note: This function does not handle UNC paths.
  *
  * Authors: Joe Zuccarello
  *
  * Date: February 15, 2006
  *
  * Returns: A normalized absolutized path.
  *
  * Version:
  *
  * License: Public domain.
  *
  * Examples:
  * ---------
  * version(Windows)
  * {
  *	// Assume c:\ is the current working directory
  *	absPath(r"file") => "c:\file"
  *	absPath(r"c:\d/src\project") => "c:\d\src\project"
  *	absPath(r".\dir\file\..\dir2\file2") => "c:\dir\dir2\file2"
  * }
  * version(linux)
  * {
  *	// Assume /usr is the current working directory
  *	absPath("d/bin") => "/usr/d/bin"
  *	absPath("/d/lib") => "/d/lib"
  *	absPath("d/src/../file") => "/usr/d/file"
  * }
  * ---------
  */
char[] absPath(char[] path)
out(result)
{
	assert(isNormPath(result));
}
body
{
	bool changed;

	version(Windows)
	{
		// Path is not absolute
		//if (std.regexp.find(path, "^[a-zA-Z]*:\\\\") == -1)
		if (isabs(path) == false)
		{
			path = std.path.join(getcwd(), path);
			changed = true;
		}
	}
	else version(Unix)
	{
		// Path is not absolute
		//if (path[0..1] != r"\" && path[0..1] != "/")
		if (isabs(path) == false)
		{
			path = std.path.join(getcwd(), path);
			changed = true;
		}
	}
	else
	{
		pragma(msg, "Unsupported OS");
		static assert(0);
	}

	// Normalize the path
	if (isNormPath(path) == false)
	{
		path = normPath(path);
		changed = true;
	}

	if (changed == true)
	{
		return path.dup;
	}
	else
	{
		return path;
	}
}

/**
  * Test whether a path is normalized.
  *
  * Use this to test whether a path is normalized.
  *
  * Note: This function does not handle UNC paths.
  *
  * Authors: Joe Zuccarello
  *
  * Date: February 15, 2006
  *
  * Returns: true/false whether a path is normalized.
  *
  * Version:
  *
  * License: Public domain.
  *
  * Examples:
  * ---------
  * version(Windows)
  * {
  *	 isNormPath(r"directory1\..\directory2\file\.") => false
  *	 // This one returns true, because there's no parent directory to collapse to.
  *	 isNormPath(r"..\directory\file") => true
  * }
  * version(linux)
  * {
  *	 isNormPath("/dir/../file") => false
  *	 isNormPath("/file") => true
  * }
  * ---------
  */
bool isNormPath(char[] path)
{
	RegExp re;

	version(Windows)
	{
	 	// Special cases
		if (path == "." || path == ".." || (path == r"\" || path == "/") ||
	     std.regexp.find(path, "^\\.\\." ~ "(" ~ rSeps ~ "\\.\\.)+") != -1 ||
	     std.regexp.find(path, "^[a-zA-Z]*:" ~ rSeps ~ "$") != -1)
		{
			return true;
		}
		else
		{
			// Look for the following.  If found, then this is not a normalized path
			if (std.regexp.find(path, rSeps ~ "$") != -1 ||
			    std.regexp.find(path, rSeps ~ "\\.\\." ~ "(" ~ rSeps ~ "|$)") != -1 ||
			    std.regexp.find(path, rSeps ~ "\\." ~ "(" ~ rSeps ~ "|$)") != -1 ||
			    std.regexp.find(path, "^\\." ~ rSeps) != -1 || std.regexp.find(path, rSeps ~ "{2,}") != -1)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
	else version(Unix)
	{
		// Special cases
		if (path == "." || path == ".." || (path == r"\" || path == "/") ||
		    std.regexp.find(path, "^\\.\\." ~ "(" ~ rSeps ~ "\\.\\.)+") != -1)
		{
			return true;
		}
		else
		{
			// Look for the following.  If found, then this is not a normalized path
			if (std.regexp.find(path, lSep ~ "$") != -1 ||
			    std.regexp.find(path, lSep ~ "\\.\\." ~ "(" ~ lSep ~ "|$)") != -1 ||
			    std.regexp.find(path, lSep ~ "\\." ~ "(" ~ lSep ~ "|$)") != -1 ||
			    std.regexp.find(path, "^\\." ~ lSep) != -1 || std.regexp.find(path, lSep ~ "{2,}") != -1)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
	else
	{
		pragma(msg, "Unsupported OS");
		static assert(0);
	}
}

/**
  * Normalizes a path.
  *
  * This will normalize a path by collapsing redundant separators and parent/current directory
  * references.  It will also remove any trailing separators and normalize separators as appropriate
  * for the OS.
  *
  * Inspired by the Python v2.4.2 implementation.
  *
  * Note: This function does not handle UNC paths.
  *
  * Authors: Joe Zuccarello
  *
  * Date: February 15, 2006
  *
  * Returns: A normalized path.
  *
  * Version:
  *
  * License: Public domain.
  *
  * Examples:
  * ---------
  * normPath("/dir1/../dir2/./file/") => "/dir2/file"
  * normPath("/dir..../file/./") => "/dir..../file"
  * ---------
  */
char[] normPath(char[] path)
out(result)
{
	assert(isNormPath(result));
}
body
{
	int pcIdx, pcIdx2;
	char[][] pathComps;  // path components after splitting
	char[] result, drive;

	// Normalize the separators for the os
	path = normSep(path);

	// Sanity check.  No need to process a separator, curdir or pardir reference.
	if (path != sep && path != curdir && path != pardir)
	{
		// Remove the drive from the path
		version(Windows)
		{
			int idx = std.string.find(path, ":");
			drive ~= idx != -1 ? path[0..(idx + 1)] : "";
			if (idx != -1)
			{
				if ((idx + 1) < path.length)
				{
					path = path[(idx + 1)..$];
				}
				else
				{
					path = "";
				}
			}
		}

		// Remove repeating separators
		path = std.string.squeeze(path, sep);

		// If there's an initial separator even after a drive, save it off
		if (path != "")
		{
			if (path[0..1] == sep)
			{
				drive ~= sep;
			}
		}

		// Split the path components
		pathComps = std.string.split(path, sep);

		while (pcIdx < pathComps.length)
		{
			// Current directory
			if (pathComps[pcIdx] == curdir)
			{
				if (pathComps.length == 1)
				{
					pathComps.length = 0;
				}
				else if (pathComps.length > 1)
				{
					// At the beginning
					if (pcIdx == 0)
					{
						pathComps = pathComps[1..$];
					}
					// At the end
					else if ((pcIdx + 1) == pathComps.length)
					{
						pathComps = pathComps[0..pcIdx];
					}
					// In the middle
					else
					{
						pathComps = pathComps[0..pcIdx] ~ pathComps[(pcIdx + 1)..$];
					}
				}
			}
			// Parent directory reference
			else if (pathComps[pcIdx] == pardir)
			{
				if (pathComps.length == 1)
				{
					pcIdx++;
				}
				else if (pathComps.length > 1)
				{
					// At the beginning
					if (pcIdx == 0)
					{
						// We don't know what to do with this, so move on
						pcIdx++;
					}
					// Found a reference but there was a separator before it.  Need
					// to remove this reference.
					else if (pcIdx == 1 && pathComps[(pcIdx - 1)] == "")
					{
						// Delete the reference
						if ((pcIdx + 1) < pathComps.length)
						{
							pathComps = pathComps[0..pcIdx] ~ pathComps[(pcIdx + 1)..$];
							pcIdx--;
						}
						else
						{
							pathComps = pathComps[0..pcIdx];
						}
					}
					else
					{
						if (pathComps[(pcIdx - 1)] != pardir)
						{
							if ((pcIdx + 1) < pathComps.length)
							{
								// Delete the reference and the preceding entry
								pathComps = pathComps[0..(pcIdx - 1)] ~ pathComps[(pcIdx + 1)..$];
								pcIdx--;
							}
							// End of line
							else
							{
								pathComps = pathComps[0..(pcIdx - 1)];
							}
						}
						else
						{
							pcIdx++;
						}
					}
				}
			}
			// Something else
			else
			{
				pcIdx++;
			}
		}

		// Delete any blank chunks out of the array for joining later
		for (int i = 0; i < pathComps.length; i++)
		{
			if (pathComps[i] == "")
			{
				if (pathComps.length == 1)
				{
					pathComps.length = 0;
				}
				else if (pathComps.length > 1)
				{
					// At the beginning
					if (i == 0)
					{
						pathComps = pathComps[1..$];
					}
					// At the end
					else if ((i + 1) == pathComps.length)
					{
						pathComps = pathComps[0..i];
					}
					// In the middle.  This should already have been taken care of from the logic near
					// the top of this function from using the squeeze and then split, there shouldn't be
					// any blank chunks in the middle.
				}
			}
		}

		result = std.string.join(pathComps, sep);
	}
	// Path was either a separator, curdir or pardir reference
	else
	{
		result = path;
	}


	if (result == "" && drive == "")
	{
		result = curdir;
	}
	else
	{
		result = drive ~ result;
	}

	return result.dup;
}

/**
  *
  * Normalizes the separators in a path.
  *
  * Use this to normalize separators as appropriate for the operating system in use.  On Windows,
  * forward slashes * will be converted to backward slashes.  On Linux, the path will just be
  * returned.
  *
  * Authors: Joe Zuccarello
  *
  * Date: February 15, 2006
  *
  * Returns: Normalized separators for a path.
  *
  * Version:
  *
  * License: Public domain.
  *
  * Examples:
  * ---------
  * version(Windows)
  * {
  *	normSep(r"c:/directory\file") => "c:\directory\file"
  * }
  * version(linux)
  * {
  *	normSep(r"/dir1\dir2\dir3/file") => "/dir1\dir2\dir3/file"
  * }
  * ---------
  */
char[] normSep(char[] path)
{
	version(Windows)
	{
		// Convert separators
		if (std.regexp.find(path, lSep) != -1)
		{
			path = std.string.replace(path, lSep, wSep);

			return path.dup;
		}
		else
		{
			return path;
		}
	}
	else version(Unix)
	{
		return path;
	}
	else
	{
		pragma(msg, "Unsupported OS");
		static assert(0);
	}
}
