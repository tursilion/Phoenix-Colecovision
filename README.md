# Warning

This repo is currently unofficial. The current build is in the sdcc4 branch. It does not merge into the public repo and at this time I haven't sorted out why. It runs on my version 1 Phoenix but I am the menu guy, I don't know what's different in the HDL on the version 2 Phoenix and don't yet have a build for that. Until that's sorted, I can't release this new version.

The primary fix is to just initialize the AY sound chip. If you are writing software that supports the AY sound chip in the Super Game Module, please initialize the chip by muting all the registers before you start to use it. Otherwise you may get unexpected tones out of the Phoenix one with the current core. ;)

# Phoenix

The Phoenix is an FPGA-based game system with several retro game system cores, most notably the ColecoVision game console and the Atari 2600.  The files here are the open source HDL for the system.

### Phoenix Core Build Instructions

Currently the build is a little lacking, and multiple steps are required.  Eventually the ISE steps will also be replaced with a Makefile.

### 1. Phoenix ColecoVision Core bit-stream

  - Create an ISE 14.7 project in a directory parallel-to the Phoenix source called: `collectorvision-ise`
  - Choose the Spartan-6 SLX16, CSG-324, speed grade 2.
  - Add all the HDL files in the `rtl` directory to the project.
  - Right-click the `Generate Programming File` process, choose `Process Properties -> Configuration Options`, and set the `Configuration Rate` to `26`, and `Unused IOB Pins` to `Float`. Click OK.
  - Double-click `Generate Programming File` to make a bit-stream.

### 2. Phoenix Core Menu

  A Windows command prompt is necessary for this step, the `Makefile` is currently specific to Windows.  `make` and the necessary `SDCC` binaries are included.

  - In a Windows console, change to the `gameMenus/coleco/src` directory.
  - Type `make`

  Produces the `phoenixBoot.rom` file in the same directory.  Do not move it, the location is known by the next step.

### 3. Phoenix Core

  A MinGW or Msys environment is assumed for this step, although a Unix system should work as well (untested).  The utilities will need to be rebuilt for a Unix environment, see the associated `Makefiles` in the `Utils/<utility>` directories.

  - In a MinGW or Msys console, change to the `cores/phoenix` directory.
  - Type `make all`

The result of these steps will be:

  1. A merged bit-stream in the main directory called `phoenix_top.merged.bit`, which can be loaded directly into the FPGA with a JTAG programming cable.
  2. A core file called `CORE01.PHX` in the main directory that can be loaded onto an SD-card and used directly with the Phoenix console to update the `COLECOVISION` core in the system.
