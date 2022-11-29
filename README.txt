RPAN Show History v1.0
By Leslie E. Krause

RPAN Show History parses the search results for RPAN broadcasts from Old Reddit and
generates a summary of past shows as a tab-delimited text file.

The package consists of the following files:

  /rpan_show_history
  |- README.txt
  |- LICENSE.txt
  |- show_history_wizard.html
  |- template.lua
  |- convert.bat
  |- /bin
     |- parse_results (binary for Linux)
     |- parse_results.exe (binary for Windows)
  |- /src
     |- parse_results.lua

If you have the Lua interpreter on your system, then you can run the script directly from
the 'src' directory. Otherwise, standalone binaries for Windows and Linux are available
under the 'bin' directory. The binaries were generated using Enceladus:

  https://github.com/ToxicFrog/Enceladus

Note: On Linux, be sure to set the execute permissions for the standalone binary.

Open 'show_history_wizard.html' in your web browser. Follow the instructions to download
your search results. Each page of results should be saved within the project directory 
using sequential names (e.g. "results1.html", "results2.html", etc.)

To run the script directly on Linux:

  % cd rpan_show_history
  % lua src/parse_results.lua results#.html > history.txt

To run the standalone binary on Linux:

  % cd rpan_show_history
  % bin/parse_results results#.html > history.txt

A batch file is provided for Windows users. Navigate to the project folder in Windows 
Explorer. Then double-click on 'convert.bat'. The show history will be saved within the 
project folder as 'history.txt'.

The output consists of four tab-delimited fields: Subreddit, StreamID, PostDate, and 
PostTitle. You can customize the field order, delimiter, etc. by editing 'template.lua' 
accordingly. All records are sorted by date in descending order (newest to oldest).

If you plan to use my RPAN Stream Recap tool, then be sure to copy 'history.txt' into 
that project directory.
