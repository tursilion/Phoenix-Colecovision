**Phoenix RTL with F18A VDP Core**

Please do not add an ISE project to this repo, a separate repo should be made for that if necessary (however, it is pretty easy to make an ISE project).

To create and ISE project for the Phoenix board:

1. Open ISE 14.7 and create a new project.  Choose the Spartan-6 SLX16, CSG-324, speed grade 2.
2. Add all the files in this repo to the project.  There will be several files that are not associated under the "phoenix_top", i.e. f18a_top, altera HDMI files, a generic serializer, etc.  Just remove those files from the project.
3. Right-click the "Generate Programming File" process, choose Process Properties -> Configuration Options, and set the Configuration Rate to 26, and Unused IOB Pins to Float. Click OK.
4. Double-click "Generate Programming File" to make a bit-stream.

There will be 3 timing constraints not met.  Two are false due to all clocks being generated via a single PLL, which means ISE knows the timing between the CPU (derived from the 21.7MHz clock) and the F18A (which uses the 100MHz and 25MHz clocks).  Due to the differences, ISE sees a signal from the CPU to the F18A and thinks it only has 2ns for the signal, which fails two signals.  There may be a way to tell the tool to ignore these paths.

The other constraint violation is valid and happens in the current HDMI core, specifically the audio encoder section.