module wxc.dssswxlibs;

version (Tango)
{
pragma(msg, "DSSS does not support Tango, try again with Phobos");

void main() {}
}
else // Phobos
{

import std.file;
import std.stdio;
import std.string;

import hcf.process;

char[] backticks(char[] command)
{
   PStream ps = new PStream(command);
   char[] output = ps.readLine();
   ps.close();
   return output;
}

int main()
{
    char[] pss, fout;
    char[][] libs;
    
    fout = "module wx.libs;\n";
    fout ~= "version (build) { pragma(link, \"wxc\"";
    
    libs = split(backticks("wx-config --libs"));
    foreach (lib; libs) {
        if (lib.length < 2 ||
            lib[0..2] != "-l") continue;
        fout ~= ", \"" ~ lib[2..$] ~ "\"";
    }
    fout ~= ", \"stdc++\"); }\n";
    
    fout ~= "version (build) { pragma(export_version, "
            "\"__" ~backticks("wxc/wx-platform")~ "__\"); }\n";

    fout ~= "version (build) { pragma(export_version, "
            "\"" ~backticks("wxc/wx-encoding")~ "\"); }\n";

    std.file.write("wx/libs.d", cast(void[]) fout);
    
    return 0;
}

}