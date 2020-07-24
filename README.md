# Phoenix

The Phoenix is an FPGA-based game system with several retro game system cores, most notably the ColecoVision game console and the Atari 2600.  The files here are the open source HDL for the system.

### Phoenix Core Build Instructions

Currently the build is a little lacking, and multiple steps are required.  Eventually the ISE steps will also be replaced with a Makefile.  A Windows-based MinGW or Msys environment is assumed, although a Unix system should work as well (untested).  The utilities will need to be rebuilt for a Unix environment, see the associated `Makefiles` in the `Utils/<utility>` directories.

### 1. Phoenix ColecoVision Core bit-stream

  - Create an ISE 14.7 project in a directory parallel-to the Phoenix source called: `collectorvision-ise`
  - Choose the Spartan-6 SLX16, CSG-324, speed grade 2.
  - Add all the HDL files in this repository to the project.  There will most likely be files that are not associated under the `phoenix_top`, just ignore or remove them from the project.
  - Right-click the `Generate Programming File` process, choose `Process Properties -> Configuration Options`, and set the `Configuration Rate` to `26`, and `Unused IOB Pins` to `Float`. Click OK.
  - Double-click `Generate Programming File` to make a bit-stream.

### 2. Phoenix Core Menu

  - In a MinGW or Msys console, change to the `gameMenus/coleco/src` directory.
  - Type `make`

### 3. Phoenix Core

  - In a MinGW or Msys console, change to the `cores/phoenix` directory.
  - Type `make all`

The result of these steps will be:

  1. A merged bit-stream in the main directory called `phoenix_top.merged.bit`, which can be loaded directly into the FPGA with a JTAG programming cable.
  2. A core file called `CORE01.PHX` that can be loaded onto an SD-card and used directly with the Phoenix console to update the `COLECOVISION` core in the system.
